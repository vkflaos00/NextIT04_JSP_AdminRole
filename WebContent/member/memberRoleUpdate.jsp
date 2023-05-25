<%@page import="kr.or.nextit.exception.BizException"%>
<%@page import="java.util.Arrays"%>
<%@page import="kr.or.nextit.exception.BizNotFoundException"%>
<%@page import="kr.or.nextit.exception.DaoException"%>
<%@page import="kr.or.nextit.member.service.MemberServiceImpl"%>
<%@page import="kr.or.nextit.member.service.IMemberService"%>
<%@page import="kr.or.nextit.exception.BizNotEffectedException"%>
<%@page import="kr.or.nextit.exception.BizPasswordNotMatchedException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
<%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
 
 <%
	request.setCharacterEncoding("utf-8");
%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NextIT</title>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/images/nextit_log.jpg"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/member.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body>

<!--회원권한수정02			서버단에 권한 수정 요청하기  -->
<%
	String memId = request.getParameter("memId");
	String[] roles = request.getParameterValues("userRole");/*userRole 배열로 전달 되어짐   */
	System.out.println( Arrays.toString(roles));
	
	IMemberService memberService = new MemberServiceImpl();
 	try{
		memberService.updateUserRole(memId, roles);
	}catch(BizNotEffectedException bne){
		request.setAttribute("bne", bne);
		bne.printStackTrace();
	}catch(DaoException de){
		request.setAttribute("de", de);
		de.printStackTrace();
	}
%>
 
<div class="container">

<!--회원권한수정09-1		성공처리  -->
	<c:if test="${ bne eq null and de eq null }">
		<h3>회원권한 수정 성공</h3>
		<div>
			<p>정상적으로 회원권한이 수정 되었습니다. 확인을 클릭하시면 회원목록 게시판으로 이동합니다.</p>
			<div class="btn-area">
				<button type="button" onclick="location.href='${pageContext.request.contextPath}/member/memberList.jsp'">확인</button>
			</div>
		</div>
	</c:if>
	
<!--회원권한수정09-2		실패처리  -->
	<c:if test="${ bne ne null or de ne null }">
		<h3>회원권한 수정 실패</h3>
		<div>
			<p>회원권한 수정에 실패하였습니다. 전산실에 문의 부탁드립니다. 042-719-8850</p>
			<div class="btn-area">
				<button type="button" onclick="history.back()">뒤로가기</button>
			</div>
		</div>
	</c:if>
</div>
</body>
</html>