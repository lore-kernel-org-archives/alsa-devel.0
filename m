From: andi@lisas.de
Subject: [patch 2/6] sound azt3328: _setfmt() update
Date: Mon, 27 Dec 2010 21:16:49 +0100
Message-ID: <20101227201649.GC28432@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 81C7324702
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2010 21:16:49 +0100 (CET)
Content-Disposition: inline; filename=cosmetics_soundformat
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Andreas Mohr <andi@lisas.de>
List-Id: alsa-devel@alsa-project.org

ChangeLog:
- use a separate variable for the frequency part, don't always "or" it
- use a "clever"(?) macro to shorten the code

Signed-off-by: Andreas Mohr <andi@lisas.de>

Index: linux-2.6/sound/pci/azt3328.c
===================================================================
--- linux-2.6.orig/sound/pci/azt3328.c	2010-12-27 14:29:00.449517668 -0500
+++ linux-2.6/sound/pci/azt3328.c	2010-12-27 14:29:14.322851001 -0500
@@ -958,28 +958,35 @@ snd_azf3328_codec_setfmt(struct snd_azf3
 	unsigned long flags;
 	const struct snd_azf3328_codec_data *codec = &chip->codecs[codec_type];
 	u16 val = 0xff00;
+	u8 freq = 0;
 
 	snd_azf3328_dbgcallenter();
 	switch (bitrate) {
-	case AZF_FREQ_4000:  val |= SOUNDFORMAT_FREQ_SUSPECTED_4000; break;
-	case AZF_FREQ_4800:  val |= SOUNDFORMAT_FREQ_SUSPECTED_4800; break;
-	case AZF_FREQ_5512:
-		/* the AZF3328 names it "5510" for some strange reason */
-			     val |= SOUNDFORMAT_FREQ_5510; break;
-	case AZF_FREQ_6620:  val |= SOUNDFORMAT_FREQ_6620; break;
-	case AZF_FREQ_8000:  val |= SOUNDFORMAT_FREQ_8000; break;
-	case AZF_FREQ_9600:  val |= SOUNDFORMAT_FREQ_9600; break;
-	case AZF_FREQ_11025: val |= SOUNDFORMAT_FREQ_11025; break;
-	case AZF_FREQ_13240: val |= SOUNDFORMAT_FREQ_SUSPECTED_13240; break;
-	case AZF_FREQ_16000: val |= SOUNDFORMAT_FREQ_16000; break;
-	case AZF_FREQ_22050: val |= SOUNDFORMAT_FREQ_22050; break;
-	case AZF_FREQ_32000: val |= SOUNDFORMAT_FREQ_32000; break;
+#define AZF_FMT_XLATE(in_freq, out_bits) \
+	do { \
+		case AZF_FREQ_ ## in_freq: \
+			freq = SOUNDFORMAT_FREQ_ ## out_bits; \
+			break; \
+	} while (0);
+	AZF_FMT_XLATE(4000, SUSPECTED_4000)
+	AZF_FMT_XLATE(4800, SUSPECTED_4800)
+	/* the AZF3328 names it "5510" for some strange reason: */
+	AZF_FMT_XLATE(5512, 5510)
+	AZF_FMT_XLATE(6620, 6620)
+	AZF_FMT_XLATE(8000, 8000)
+	AZF_FMT_XLATE(9600, 9600)
+	AZF_FMT_XLATE(11025, 11025)
+	AZF_FMT_XLATE(13240, SUSPECTED_13240)
+	AZF_FMT_XLATE(16000, 16000)
+	AZF_FMT_XLATE(22050, 22050)
+	AZF_FMT_XLATE(32000, 32000)
 	default:
 		snd_printk(KERN_WARNING "unknown bitrate %d, assuming 44.1kHz!\n", bitrate);
 		/* fall-through */
-	case AZF_FREQ_44100: val |= SOUNDFORMAT_FREQ_44100; break;
-	case AZF_FREQ_48000: val |= SOUNDFORMAT_FREQ_48000; break;
-	case AZF_FREQ_66200: val |= SOUNDFORMAT_FREQ_SUSPECTED_66200; break;
+	AZF_FMT_XLATE(44100, 44100)
+	AZF_FMT_XLATE(48000, 48000)
+	AZF_FMT_XLATE(66200, SUSPECTED_66200)
+#undef AZF_FMT_XLATE
 	}
 	/* val = 0xff07; 3m27.993s (65301Hz; -> 64000Hz???) hmm, 66120, 65967, 66123 */
 	/* val = 0xff09; 17m15.098s (13123,478Hz; -> 12000Hz???) hmm, 13237.2Hz? */
@@ -991,6 +998,8 @@ snd_azf3328_codec_setfmt(struct snd_azf3
 	/* val = 0xff0d; 41m23.135s (5523,600Hz; -> 5512Hz???) */
 	/* val = 0xff0e; 28m30.777s (8017Hz; -> 8000Hz???) */
 
+	val |= freq;
+
 	if (channels == 2)
 		val |= SOUNDFORMAT_FLAG_2CHANNELS;
 

-- 
