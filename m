From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: CONFIG_SND_RTC and CONFIG_SND_RTCTIMER and CONFIG_RTC, oh my!
Date: Fri, 17 May 2002 13:21:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CE4E7D0.36461BEB@ladisch.de>
References: <3CE0CF92.F5CFFB38@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mlucom8.urz.Uni-Halle.DE [141.48.10.118] (may be forged))
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA17610
	for <alsa-devel@alsa-project.org>; Fri, 17 May 2002 13:22:18 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> they are ruines from the old alsa-driver package.
> all should be CONFIG_SND_RTCTIMER and take m/n/y.
> 
> fixed now on cvs.

CONFIG_RTC is still missing. The patch below fakes it.

Additionally, I've modified the initialization of rtcsup.
(but I think it that line wasn't used anyway :)


Index: Makefile.conf.in
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/Makefile.conf.in,v
retrieving revision 1.37
diff -u -r1.37 Makefile.conf.in
--- Makefile.conf.in	14 May 2002 17:55:38 -0000	1.37
+++ Makefile.conf.in	17 May 2002 11:12:56 -0000
@@ -54,6 +54,7 @@
 CONFIG_SND_SEQUENCER_OSS = n
 endif
 CONFIG_SND_RTCTIMER	= @CONFIG_SND_RTCTIMER@
+CONFIG_RTC		= @CONFIG_RTC@
 
 INCLUDE		= -I$(TOPDIR)/include -I$(CONFIG_SND_KERNELDIR)/include
 CFLAGS		= $(MODFLAGS) $(INCLUDE) $(c_opts) -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe
Index: configure.in
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/configure.in,v
retrieving revision 1.106
diff -u -r1.106 configure.in
--- configure.in	14 May 2002 17:55:38 -0000	1.106
+++ configure.in	17 May 2002 11:12:56 -0000
@@ -714,7 +714,7 @@
 
 dnl Check for RTC timer support...
 AC_MSG_CHECKING(for RTC callback support in kernel)
-rtcsup="0"
+rtcsup="n"
 ac_save_CFLAGS="$CFLAGS"
 CFLAGS="$CFLAGS -I$CONFIG_SND_KERNELDIR/include"
 AC_TRY_RUN([
@@ -743,6 +743,8 @@
 CFLAGS=$ac_save_CFLAGS
 CONFIG_SND_RTCTIMER=$rtcsup
 AC_SUBST(CONFIG_SND_RTCTIMER)
+CONFIG_RTC=CONFIG_SND_RTCTIMER
+AC_SUBST(CONFIG_RTC)
 
 dnl Check for which cards to compile driver for...
 ALSA_TOPLEVEL_INIT

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
