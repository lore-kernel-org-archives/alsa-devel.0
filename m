From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: [patch] alsa-utils check if __USE_BSD is defined
 before compiling "BSD functions"
Date: Mon, 8 Dec 2008 07:26:02 +0100
Message-ID: <20081208072602.3b20cb50@hcegtvedt>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/=.SduQjuWdlki29/aP+2saF"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (nat-132.atmel.no [80.232.32.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A77C1037F8
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 07:26:02 +0100 (CET)
Received: from hcegtvedt (dhcp-252-160.norway.atmel.com [10.191.252.160])
	by relay.atmel.no (8.13.4/8.13.4) with ESMTP id mB86Om5s098278
	for <alsa-devel@alsa-project.org>; Mon, 8 Dec 2008 07:24:48 +0100 (CET)
	(envelope-from hans-christian.egtvedt@atmel.com)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--MP_/=.SduQjuWdlki29/aP+2saF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Another bug/issue I tripped over when compiling alsa-utils in an
environment using uClibc to supply the C library functions. Here I have
enabled some old BSD style functions. The attached patch will honor
them if they are enabled.

Without this patch I get a redefined error during compile.

-- 
Best regards,
Hans-Christian Egtvedt

--MP_/=.SduQjuWdlki29/aP+2saF
Content-Type: text/x-patch;
 name=alsa-utils-1.0.18-check-if-__use_bsd-is-defined.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=alsa-utils-1.0.18-check-if-__use_bsd-is-defined.patch

Index: alsa-utils-1.0.18/alsactl/init_sysdeps.c
===================================================================
--- alsa-utils-1.0.18.orig/alsactl/init_sysdeps.c	2008-12-01 08:27:16.000000000 +0100
+++ alsa-utils-1.0.18/alsactl/init_sysdeps.c	2008-12-01 08:27:22.000000000 +0100
@@ -17,7 +17,7 @@
  *
  */
 
-#ifdef __GLIBC__
+#if defined(__GLIBC__) && !defined(__USE_BSD)
 static size_t strlcpy(char *dst, const char *src, size_t size)
 {
 	size_t bytes = 0;

--MP_/=.SduQjuWdlki29/aP+2saF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--MP_/=.SduQjuWdlki29/aP+2saF--
