From: "Ronny V. Vindenes" <s864@ii.uib.no>
Subject: [PATCH] - Minor specfile update for alsa-utils
Date: Tue, 25 Nov 2003 15:41:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1069771313.3225.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-pUo7sdretDLtjXXzjaNm"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-pUo7sdretDLtjXXzjaNm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Include all man pages (alsaconf(8) was not included before)

-- 
Ronny V. Vindenes <s864@ii.uib.no>

--=-pUo7sdretDLtjXXzjaNm
Content-Disposition: attachment; filename=alsa-utils.spec.fix.patch
Content-Type: text/x-patch; name=alsa-utils.spec.fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- alsa-utils-1.0.0pre1/utils/alsa-utils.spec.in	2003-05-15 08:51:29.000000000 +0200
+++ fix/alsa-utils-1.0.0pre1/utils/alsa-utils.spec.in	2003-11-25 15:40:43.160825243 +0100
@@ -18,6 +18,9 @@
 Advanced Linux Sound Architecture (ALSA) - Utils
 
 %changelog
+* Tue Nov 25 2003 Ronny V. Vindenes <sublett@amigascne.org>
+- include all manpages
+
 * Thu Mar  6 2003 Ronny V. Vindenes <sublett@dc-s.com>
 
 - removed wrongly included doc file
@@ -60,4 +63,4 @@
 
 %{_prefix}/sbin/*
 %{_prefix}/bin/*
-%{_mandir}/man1/*
+%{_mandir}/man?/*

--=-pUo7sdretDLtjXXzjaNm--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
