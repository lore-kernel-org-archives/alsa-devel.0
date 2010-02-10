From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Wierdness in alsa-driver configure script
Date: Thu, 11 Feb 2010 10:59:56 +1300
Message-ID: <4B732C5C.9020003@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id DCF50103827
	for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2010 23:00:16 +0100 (CET)
Received: from [192.168.1.6]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0KXN00GRVBSDMK00@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 11 Feb 2010 11:00:14 +1300 (NZDT)
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

checking for kernel version... 2.6.28-17-generic
checking for GCC version... ./configure: eval: line 5540: syntax error
near unexpected token `)'
./configure: eval: line 5540: `my_compiler_version=4.3.3-5ubuntu4)'
Kernel compiler:  Used compiler: gcc (Ubuntu 4.3.3-5ubuntu4) 4.3.3


gcc --version gives (yes, it is ugly!):
gcc (Ubuntu 4.3.3-5ubuntu4) 4.3.3
Copyright (C) 2008 Free Software Foundation, Inc.

The following change works for this particular case, but perhaps there
is a better answer?

--- a/configure.in
+++ b/configure.in
@@ -363,7 +363,7 @@ AC_DEFUN([CHECK_COMPILER], [
       ;;
     [[0-9]].[[0-9]]*)
       if test -z "$ac_compiler_version"; then
-        ac_compiler_version="$i"
+        ac_compiler_version=`echo $i | sed -e
's|[[^0-9]]*\([[0-9.]]\+\).*$|\1|'`
       fi
       ;;
     esac
