From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Output from configure
Date: Tue, 7 Sep 2004 12:22:34 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409071221480.1723@linux.local>
References: <95D76FF714D87E4A8BC88A0A2957E48B1440A0@tseappl.tseintern.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C2267280
	for <alsa-devel@alsa-project.org>; Tue,  7 Sep 2004 12:23:56 +0200 (MEST)
In-Reply-To: <95D76FF714D87E4A8BC88A0A2957E48B1440A0@tseappl.tseintern.dk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Mogens Elneff (elneff) (E-mail)" <mogens@elneff.dk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 7 Sep 2004, Mogens Elneff wrote:

> Hi. 
> 
> I have downloaded the source by means of cvs and then ran the command:
> "./cvscompile --with-cards=cmipci --with-sequencer=yes". Here below are
> the output.
>
> checking for kernel version... 2.4.27.vdr2 checking for GCC
> version... Kernel compiler: GCC 3.3.4 (Debian 1:3.3.4-6sarge1) Used
> compiler: gcc (GCC) 3.3.4 (Debian 1:3.3.4-6sarge1)

Could you try this patch?

Index: configure.in
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/configure.in,v
retrieving revision 1.262
retrieving revision 1.263
diff -u -r1.262 -r1.263
--- configure.in	20 Aug 2004 12:03:00 -0000	1.262
+++ configure.in	7 Sep 2004 10:22:43 -0000	1.263
@@ -233,7 +233,7 @@
         ac_compiler_version=`echo $i | sed -e 's/^.*gcc-\([0-9.]\+\).*$/\1/'`
       fi
       ;;
-    *gcc*)
+    *gcc*|*GCC*)
       if test -z "$ac_compiler_type"; then
         ac_compiler_type=gcc
       fi

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
