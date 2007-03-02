From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Problems compiling alsa-driver-1.0.14rc3
	and	Mercury driver
Date: Fri, 02 Mar 2007 10:11:20 -0800
Message-ID: <1172859080.4718.21.camel@razman.gruemaster.com>
References: <5FD5754DDBA0B1499B5A0B4BB5419485A64708@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-84entLgRNJHKE4KoLFyX"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <5FD5754DDBA0B1499B5A0B4BB5419485A64708@fmsmsx411.amr.corp.intel.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "Allyn, Mark A" <mark.a.allyn@intel.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-84entLgRNJHKE4KoLFyX
Content-Type: multipart/alternative; boundary="=-mxGXlyvNq2vJzdKs1FU8"


--=-mxGXlyvNq2vJzdKs1FU8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Several of my testers are being blocked by this as well.  Instead of
having a log2_compat.h, wouldn't it be easier to have an rtctimer.patch
that reverts to prior rtctimer.c behaviour?  What was the purpose of
this patch?  The l"is_power_of_2 function isn't even in a release kernel
(it will be in 2.6.21).

Here is a patch against the 1.0.14rc3 tarball.  It will need more
refinement for HG, but it works on my Mandriva 2007 kernels.


Signed off by Tobin Davis <tdavis@dsl-only.net>

On Thu, 2007-03-01 at 11:56 -0800, Allyn, Mark A wrote:
> Hi:
>  
> I am getting the same error trying to compile either the 1.0.14rc3 or
> the Mercury versions of the driver.
>  
> I get the following in both:
>  
> ====================================
>  
>   CC [M]  /root/newaudio/alsa-driver-1.0.14rc3/acore/rtctimer.o
> In file included
> from /root/newaudio/alsa-driver-1.0.14rc3/include/linux/log2.h:1,
> 
> from /root/newaudio/alsa-driver-1.0.14rc3/acore/../alsa-kernel/core/rtctimer.c:27,
> 
> from /root/newaudio/alsa-driver-1.0.14rc3/acore/rtctimer.c:1:
> /root/newaudio/alsa-driver-1.0.14rc3/include/log2_compat.h:8: error:
> syntax error before "is_power_of_2"
> /root/newaudio/alsa-driver-1.0.14rc3/include/log2_compat.h:9: warning:
> return type defaults to `int'
> make[4]: *** [/root/newaudio/alsa-driver-1.0.14rc3/acore/rtctimer.o]
> Error 1
> make[3]: *** [/root/newaudio/alsa-driver-1.0.14rc3/acore] Error 2
> make[2]: *** [_module_/root/newaudio/alsa-driver-1.0.14rc3] Error 2
> make[1]: *** [modules] Error 2
> make[1]: Leaving directory `/mnt1/src/linux-2.6.17.13.i686'
> make: *** [compile] Error 2
> 
>  
> ====================================
>  
> The header file, log2_compat.h is not in the rc2 release; I have no
> problems compiling rc2.
>  
> Does this mean that I have to be up to a certain rev on the kernel?
>  
> I am running red flag with the 2.6.17.13 kernel.
>  
> Thanks
>  
> Mark Allyn
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________ Alsa-devel mailing list Alsa-devel@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/alsa-devel



--=-mxGXlyvNq2vJzdKs1FU8
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
Several of my testers are being blocked by this as well.&nbsp; Instead of having a log2_compat.h, wouldn't it be easier to have an rtctimer.patch that reverts to prior rtctimer.c behaviour?&nbsp; What was the purpose of this patch?&nbsp; The l&quot;is_power_of_2 function isn't even in a release kernel (it will be in 2.6.21).<BR>
<BR>
Here is a patch against the 1.0.14rc3 tarball.&nbsp; It will need more refinement for HG, but it works on my Mandriva 2007 kernels.<BR>
<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<BR>
Signed off by Tobin Davis &lt;tdavis@dsl-only.net&gt;
</TD>
</TR>
</TABLE>
<BR>
On Thu, 2007-03-01 at 11:56 -0800, Allyn, Mark A wrote:
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">Hi:</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">I am getting the same error trying to compile either the 1.0.14rc3 or the Mercury versions of the driver.</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">I get the following in both:</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">====================================</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">&nbsp; CC [M]&nbsp; /root/newaudio/alsa-driver-1.0.14rc3/acore/rtctimer.o</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">In file included from /root/newaudio/alsa-driver-1.0.14rc3/include/linux/log2.h:1,</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /root/newaudio/alsa-driver-1.0.14rc3/acore/../alsa-kernel/core/rtctimer.c:27,</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /root/newaudio/alsa-driver-1.0.14rc3/acore/rtctimer.c:1:</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">/root/newaudio/alsa-driver-1.0.14rc3/include/log2_compat.h:8: error: syntax error before &quot;is_power_of_2&quot;</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">/root/newaudio/alsa-driver-1.0.14rc3/include/log2_compat.h:9: warning: return type defaults to `int'</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">make[4]: *** [/root/newaudio/alsa-driver-1.0.14rc3/acore/rtctimer.o] Error 1</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">make[3]: *** [/root/newaudio/alsa-driver-1.0.14rc3/acore] Error 2</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">make[2]: *** [_module_/root/newaudio/alsa-driver-1.0.14rc3] Error 2</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">make[1]: *** [modules] Error 2</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">make[1]: Leaving directory `/mnt1/src/linux-2.6.17.13.i686'</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">make: *** [compile] Error 2</FONT></FONT><BR>
    <BR>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">====================================</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">The header file, log2_compat.h is not in the rc2 release; I have no problems compiling rc2.</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">Does this mean that I have to be up to a certain rev on the kernel?</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">I am running red flag with the 2.6.17.13 kernel.</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">Thanks</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">Mark Allyn</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">-------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">Take Surveys. Earn Cash. Influence the Future of IT</FONT>
<FONT COLOR="#000000">Join SourceForge.net's Techsay panel and you'll get the chance to share your</FONT>
<FONT COLOR="#000000">opinions on IT &amp; business topics through brief surveys-and earn cash</FONT>
<FONT COLOR="#000000"><A HREF="http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</A></FONT>
<FONT COLOR="#000000">_______________________________________________ Alsa-devel mailing list <A HREF="mailto:Alsa-devel@lists.sourceforge.net">Alsa-devel@lists.sourceforge.net</A> <A HREF="https://lists.sourceforge.net/lists/listinfo/alsa-devel">https://lists.sourceforge.net/lists/listinfo/alsa-devel</A></FONT>
</PRE>
</BLOCKQUOTE>
<BR>
</BODY>
</HTML>

--=-mxGXlyvNq2vJzdKs1FU8--

--=-84entLgRNJHKE4KoLFyX
Content-Disposition: attachment; filename=buildfix-1.0.14rc3.patch
Content-Type: text/x-patch; name=buildfix-1.0.14rc3.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- alsa-driver-1.0.14rc3.orig/acore/Makefile	2007-02-26 00:59:24.000000000 -0800
+++ alsa-driver-1.0.14rc3/acore/Makefile	2007-03-02 09:57:45.000000000 -0800
@@ -6,12 +6,12 @@
 include $(SND_TOPDIR)/Makefile.conf
 
 clean-files := info.c pcm.c pcm_native.c control.c hwdep.c init.c rawmidi.c \
-	       sound.c timer.c memalloc.c misc.c
+	       sound.c timer.c memalloc.c misc.c rtctimer.c
 
 export-objs := control.o device.o info.o info_oss.o init.o isadma.o memory.o \
 	misc.o misc_driver.o sound.o sound_oss.o \
 	pcm.o pcm_lib.o pcm_memory.o pcm_misc.o pcm_native.o \
-	rawmidi.o timer.o hwdep.o memalloc.o
+	rawmidi.o timer.o hwdep.o memalloc.o rtctimer.o
 
 include $(SND_TOPDIR)/alsa-kernel/core/Makefile
 
@@ -36,5 +36,6 @@
 rawmidi.c: rawmidi.patch $(SND_TOPDIR)/alsa-kernel/core/rawmidi.c
 sound.c: sound.patch $(SND_TOPDIR)/alsa-kernel/core/sound.c
 timer.c: timer.patch $(SND_TOPDIR)/alsa-kernel/core/timer.c
+rtctimer.c: rtctimer.patch $(SND_TOPDIR)/alsa-kernel/core/rtctimer.c
 memalloc.c: memalloc.patch memalloc.inc memalloc.inc1 $(SND_TOPDIR)/alsa-kernel/core/memalloc.c
 misc.c: misc.patch $(SND_TOPDIR)/alsa-kernel/core/misc.c
--- /dev/null	2007-03-01 22:57:55.348146750 -0800
+++ alsa-driver-1.0.14rc3/acore/rtctimer.patch	2007-03-02 09:50:14.000000000 -0800
@@ -0,0 +1,24 @@
+--- ../alsa-kernel/core/rtctimer.c	2007-02-26 00:59:29.000000000 -0800
++++ rtctimer.c	2007-03-02 09:49:45.000000000 -0800
+@@ -24,7 +24,9 @@
+ #include <linux/init.h>
+ #include <linux/interrupt.h>
+ #include <linux/moduleparam.h>
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 21)
+ #include <linux/log2.h>
++#endif
+ #include <sound/core.h>
+ #include <sound/timer.h>
+ 
+@@ -130,7 +132,11 @@
+ 	struct snd_timer *timer;
+ 
+ 	if (rtctimer_freq < 2 || rtctimer_freq > 8192 ||
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 21)
+ 	    !is_power_of_2(rtctimer_freq)) {
++#else
++	    (rtctimer_freq & (rtctimer_freq - 1)) != 0) {
++#endif
+ 		snd_printk(KERN_ERR "rtctimer: invalid frequency %d\n",
+ 			   rtctimer_freq);
+ 		return -EINVAL;

--=-84entLgRNJHKE4KoLFyX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-84entLgRNJHKE4KoLFyX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-84entLgRNJHKE4KoLFyX--
