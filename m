From: Stas Sergeev <stsp@aknet.ru>
Subject: [patch] snd-pcsp: put back the compatibility code
Date: Fri, 16 May 2008 22:11:31 +0400
Message-ID: <482DCE53.1000406@aknet.ru>
References: <hPXlJLjt4XG.A._lF.Jv1JIB@chimera>	<88YBFoyd1CN.A._sF.Ov1JIB@chimera>	<s5hskwmeb1h.wl%tiwai@suse.de>	<20080514212011.GH7054@mit.edu>	<s5hhcd0azv1.wl%tiwai@suse.de>	<20080515130654.GC18825@mit.edu> <s5h8wybr0c2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090105040308060502040906"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759402AbYEPSLw@vger.kernel.org>
In-Reply-To: <s5h8wybr0c2.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Theodore Tso <tytso@mit.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Roberto Oppedisano <roberto.oppedisano@infracom.it>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090105040308060502040906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello.

The attached patch adds back the
compatibility code, allowing the
driver to work with older alsa-libs.
The removal was premature, it breaks
the real-life configs, I am sorry
about that.

Takashi, could you please apply?
It is a straight-forward revert of:
http://hg-mirror.alsa-project.org/alsa-kernel/diff/26b0243ab4fa/drivers/pcsp/pcsp_lib.c

--------------090105040308060502040906
Content-Type: text/x-patch;
 name="pcsp_s16_back.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcsp_s16_back.diff"

# HG changeset patch
# User Stas Sergeev <stsp@users.sourceforge.net>
# Date 1210960913 -14400
# Node ID 3887126bbd9ca422208e651d46f9f5385d409efe
# Parent  1ffcb28969441147a0480f0ad7bdc52093d1e4ee
snd-pcsp: put back the compatibility code for the older alsa-libs.

Signed-off-by: Stas Sergeev <stsp@aknet.ru>

diff -r 1ffcb2896944 -r 3887126bbd9c drivers/pcsp/pcsp_lib.c
--- a/drivers/pcsp/pcsp_lib.c	Fri May 16 12:34:47 2008 +0200
+++ b/drivers/pcsp/pcsp_lib.c	Fri May 16 22:01:53 2008 +0400
@@ -17,6 +17,8 @@ module_param(nforce_wa, bool, 0444);
 module_param(nforce_wa, bool, 0444);
 MODULE_PARM_DESC(nforce_wa, "Apply NForce chipset workaround "
 		"(expect bad sound)");
+
+#define DMIX_WANTS_S16	1
 
 static void pcsp_start_timer(unsigned long dummy)
 {
@@ -47,7 +49,7 @@ enum hrtimer_restart pcsp_do_timer(struc
 {
 	unsigned long flags;
 	unsigned char timer_cnt, val;
-	int periods_elapsed;
+	int fmt_size, periods_elapsed;
 	u64 ns;
 	size_t period_bytes, buffer_bytes;
 	struct snd_pcm_substream *substream;
@@ -92,8 +94,11 @@ enum hrtimer_restart pcsp_do_timer(struc
 		goto exit_nr_unlock2;
 
 	runtime = substream->runtime;
-	/* assume it is u8 mono */
-	val = runtime->dma_area[chip->playback_ptr];
+	fmt_size = snd_pcm_format_physical_width(runtime->format) >> 3;
+	/* assume it is mono! */
+	val = runtime->dma_area[chip->playback_ptr + fmt_size - 1];
+	if (snd_pcm_format_signed(runtime->format))
+		val ^= 0x80;
 	timer_cnt = val * CUR_DIV() / 256;
 
 	if (timer_cnt && chip->enable) {
@@ -111,7 +116,7 @@ enum hrtimer_restart pcsp_do_timer(struc
 
 	period_bytes = snd_pcm_lib_period_bytes(substream);
 	buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
-	chip->playback_ptr += PCSP_INDEX_INC();
+	chip->playback_ptr += PCSP_INDEX_INC() * fmt_size;
 	periods_elapsed = chip->playback_ptr - chip->period_ptr;
 	if (periods_elapsed < 0) {
 		printk(KERN_WARNING "PCSP: playback_ptr inconsistent "
@@ -270,7 +275,11 @@ static struct snd_pcm_hardware snd_pcsp_
 	.info = (SNDRV_PCM_INFO_INTERLEAVED |
 		 SNDRV_PCM_INFO_HALF_DUPLEX |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
-	.formats = SNDRV_PCM_FMTBIT_U8,
+	.formats = (SNDRV_PCM_FMTBIT_U8
+#if DMIX_WANTS_S16
+		    | SNDRV_PCM_FMTBIT_S16_LE
+#endif
+	    ),
 	.rates = SNDRV_PCM_RATE_KNOT,
 	.rate_min = PCSP_DEFAULT_SRATE,
 	.rate_max = PCSP_DEFAULT_SRATE,

--------------090105040308060502040906--
