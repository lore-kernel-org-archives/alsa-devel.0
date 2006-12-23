From: Tobin Davis <tdavis@dsl-only.net>
Subject: Fix typo and add entry to documentation.
Date: Fri, 22 Dec 2006 22:33:00 -0800
Message-ID: <1166855580.12749.19.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-b1gLdm7qY0Fu1AQdohMH"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-b1gLdm7qY0Fu1AQdohMH
Content-Type: multipart/alternative; boundary="=-dUYEwjO9LovdLewQcVkx"


--=-dUYEwjO9LovdLewQcVkx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds the macpro and fixes a typo in the ALC882 section of
ALSA-Configuration.txt. 

Signed off by:  Tobin Davis <tdavis@dsl-only.net>


--=-dUYEwjO9LovdLewQcVkx
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
This patch adds the macpro and fixes a typo in the ALC882 section of ALSA-Configuration.txt. <BR>
<BR>
Signed off by:&nbsp; Tobin Davis &lt;<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>&gt;<BR>
<BR>
</BODY>
</HTML>

--=-dUYEwjO9LovdLewQcVkx--

--=-b1gLdm7qY0Fu1AQdohMH
Content-Disposition: attachment; filename=Doc.patch
Content-Type: text/x-patch; name=Doc.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 511f2a148410 Documentation/ALSA-Configuration.txt
--- a/Documentation/ALSA-Configuration.txt	Thu Dec 21 19:17:29 2006 +0100
+++ b/Documentation/ALSA-Configuration.txt	Fri Dec 22 22:01:27 2006 -0800
@@ -814,8 +814,9 @@ Prior to version 0.9.0rc4 options had a 
 
 	ALC882/885
 	  3stack-dig	3-jack with SPDIF I/O
-	  6stck-dig	6-jack digital with SPDIF I/O
+	  6stack-dig	6-jack digital with SPDIF I/O
 	  arima		Arima W820Di1
+	  macpro	MacPro support
 	  auto		auto-config reading BIOS (default)
 
 	ALC883/888

--=-b1gLdm7qY0Fu1AQdohMH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-b1gLdm7qY0Fu1AQdohMH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-b1gLdm7qY0Fu1AQdohMH--
