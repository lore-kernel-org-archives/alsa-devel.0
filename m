From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: [PATCH] fixes Re: problem compiling alsa-lib CVS.
Date: Mon, 22 Mar 2004 17:02:34 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <405F1C2A.1070000@superbug.demon.co.uk>
References: <405F1A01.8080408@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000807010309090708090400"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-31.mail.demon.net (anchor-post-31.mail.demon.net [194.217.242.89])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA07796
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2004 17:58:27 +0100
Received: from superbug.demon.co.uk ([80.176.146.252])
	by anchor-post-31.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1B5Skr-000HLf-0V
	for alsa-devel@alsa-project.org; Mon, 22 Mar 2004 16:58:25 +0000
In-Reply-To: <405F1A01.8080408@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000807010309090708090400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

James Courtier-Dutton wrote:
> I attach the output I see on the screen when running ./cvscompile.
> 
> Cheers
> James
> 

I attach a patch to fix the problem for me.

--------------000807010309090708090400
Content-Type: text/x-patch;
 name="cvscompile.fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cvscompile.fix.patch"

--- cvscompile	2002-10-24 13:09:30.000000000 +0100
+++ cvscompile.new	2004-03-22 16:58:07.072241360 +0000
@@ -1,4 +1,9 @@
 #!/bin/bash
+# Minimum value required to build
+WANT_AUTOMAKE_1_6=1 export WANT_AUTOMAKE_1_6
+AUTOMAKE_MIN=1.6.0
+AUTOCONF_MIN=2.53
+LIBTOOL_MIN=1.4.0
 
 touch ltconfig
 libtoolize --force --copy --automake

--------------000807010309090708090400--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
