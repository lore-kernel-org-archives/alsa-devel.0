From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [OOPS] Alsa 0.9.4 / kernel 2.6.0-test1-mm1
Date: Mon, 21 Jul 2003 14:38:03 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307211436010.3903-100000@pnote.perex-int.cz>
References: <3F1BB0B0.9040201@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F1BB0B0.9040201@free.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Vince <fuzzy77@free.fr>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 21 Jul 2003, Vince wrote:

> Jaroslav Kysela wrote:
> > On Sat, 19 Jul 2003, Vince wrote:
> > 
> > 
> >>Jaroslav Kysela wrote:
> >>
> >>>On Fri, 18 Jul 2003, Vince wrote:
> >>>
> >>>
> >>>
> >>>>P.S.: I intended to test alsa 0.9.5 (in the hope that this bug was 
> >>>>already known & has already been fixed), but unfortunately I get a 
> >>>>compile error (I simply dropped alsa-kernel 0.9.5 in the 2.6.0-test1-mm1 
> >>>>source tree):
> >>>
> >>>
> >>>Copy also header files from alsa-kernel/include to linux/include/sound.
> >>>
> >>>						Jaroslav
> >>
> >>Thanks... If I made no mistake in installation, it appears that I still 
> >>get the exact same oops with 0.9.5 (btw alsa-kernel/include/version.h 
> >>still says 0.9.4 in the tarball):
> > 
> > 
> > Please, send us contents of /proc/asound/card0/pcm0p/sub0/* files after 
> > oops occured.
> 
> Here it is right after the oops:

Could you try the following patch? Note that this patch is a workaround 
for your hardware, but it does not fix the oops for other users (like 
the intel8x0 driver). I will work on this problem.

						Jaroslav

Index: pcm_plugin.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/oss/pcm_plugin.c,v
retrieving revision 1.10
retrieving revision 1.11
diff -u -r1.10 -r1.11
--- pcm_plugin.c	7 Feb 2003 08:29:08 -0000	1.10
+++ pcm_plugin.c	21 Jul 2003 12:36:10 -0000	1.11
@@ -56,6 +56,17 @@
 	return 0;
 }
 
+/*
+ *  because some cards might have rates "very close", we ignore
+ *  all "resampling" requests within +-5%
+ */
+static int rate_match(unsigned int src_rate, unsigned int dst_rate)
+{
+	unsigned int low = (src_rate * 95) / 100;
+	unsigned int high = (src_rate * 105) / 105;
+	return dst_rate >= low && dst_rate <= high;
+}
+
 static int snd_pcm_plugin_alloc(snd_pcm_plugin_t *plugin, snd_pcm_uframes_t frames)
 {
 	snd_pcm_plugin_format_t *format;
@@ -420,7 +431,7 @@
 
 	/* Format change (linearization) */
 	if ((srcformat.format != dstformat.format ||
-	     srcformat.rate != dstformat.rate ||
+	     !rate_match(srcformat.rate, dstformat.rate) ||
 	     srcformat.channels != dstformat.channels) &&
 	    !snd_pcm_format_linear(srcformat.format)) {
 		if (snd_pcm_format_linear(dstformat.format))
@@ -468,7 +479,7 @@
 				ttable[v * sv + v] = FULL;
 		}
 		tmpformat.channels = dstformat.channels;
-		if (srcformat.rate == dstformat.rate &&
+		if (rate_match(srcformat.rate, dstformat.rate) &&
 		    snd_pcm_format_linear(dstformat.format))
 			tmpformat.format = dstformat.format;
 		err = snd_pcm_plugin_build_route(plug,
@@ -490,7 +501,7 @@
 	}
 
 	/* rate resampling */
-	if (srcformat.rate != dstformat.rate) {
+	if (!rate_match(srcformat.rate, dstformat.rate)) {
 		tmpformat.rate = dstformat.rate;
 		if (srcformat.channels == dstformat.channels &&
 		    snd_pcm_format_linear(dstformat.format))

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
