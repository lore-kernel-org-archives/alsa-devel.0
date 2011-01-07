From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH 1/3] ASoC: sn95031 fix the code style and
	format inconsistencies
Date: Fri,  7 Jan 2011 16:20:28 +0530
Message-ID: <1294397428-8730-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E5E82432F
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 11:48:39 +0100 (CET)
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
Cc: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, Vinod Koul <vinod.koul@intel.com>, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

this patch fixes inconsistencies commented by Mark.
This also fixes few other style things in audio_map & header file

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/codecs/sn95031.c |   30 +++++++++++++++---------------
 sound/soc/codecs/sn95031.h |   12 ++++++------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 146b744..593632c 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -235,21 +235,21 @@ static const struct snd_soc_dapm_route sn95031_audio_map[] = {
 	{ "IHFDAC Right", NULL, "Speaker Rail"},
 
 	/* vibra map */
-	{"VIB1OUT", NULL, "Vibra1 Playback"},
-	{"Vibra1 Playback", NULL, "Vibra1 DAC"},
+	{ "VIB1OUT", NULL, "Vibra1 Playback"},
+	{ "Vibra1 Playback", NULL, "Vibra1 DAC"},
 
-	{"VIB2OUT", NULL, "Vibra2 Playback"},
-	{"Vibra2 Playback", NULL, "Vibra2 DAC"},
+	{ "VIB2OUT", NULL, "Vibra2 Playback"},
+	{ "Vibra2 Playback", NULL, "Vibra2 DAC"},
 
 	/* lineout */
-	{"LINEOUTL", NULL, "Lineout Left Playback"},
-	{"LINEOUTR", NULL, "Lineout Right Playback"},
-	{"Lineout Left Playback", NULL, "Headset Left Filter"},
-	{"Lineout Left Playback", NULL, "Speaker Left Filter"},
-	{"Lineout Left Playback", NULL, "Vibra1 DAC"},
-	{"Lineout Right Playback", NULL, "Headset Right Filter"},
-	{"Lineout Right Playback", NULL, "Speaker Right Filter"},
-	{"Lineout Right Playback", NULL, "Vibra2 DAC"},
+	{ "LINEOUTL", NULL, "Lineout Left Playback"},
+	{ "LINEOUTR", NULL, "Lineout Right Playback"},
+	{ "Lineout Left Playback", NULL, "Headset Left Filter"},
+	{ "Lineout Left Playback", NULL, "Speaker Left Filter"},
+	{ "Lineout Left Playback", NULL, "Vibra1 DAC"},
+	{ "Lineout Right Playback", NULL, "Headset Right Filter"},
+	{ "Lineout Right Playback", NULL, "Speaker Right Filter"},
+	{ "Lineout Right Playback", NULL, "Vibra2 DAC"},
 };
 
 /* speaker and headset mutes, for audio pops and clicks */
@@ -444,8 +444,8 @@ static int sn95031_codec_remove(struct snd_soc_codec *codec)
 }
 
 struct snd_soc_codec_driver sn95031_codec = {
-	.probe =	sn95031_codec_probe,
-	.remove =	sn95031_codec_remove,
+	.probe		= sn95031_codec_probe,
+	.remove		= sn95031_codec_remove,
 	.read		= sn95031_read,
 	.write		= sn95031_write,
 	.set_bias_level	= sn95031_set_vaud_bias,
@@ -488,7 +488,7 @@ static void __exit sn95031_exit(void)
 }
 module_exit(sn95031_exit);
 
-MODULE_DESCRIPTION("ASoC Intel(R) SN95031 codec driver");
+MODULE_DESCRIPTION("ASoC TI SN95031 codec driver");
 MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
 MODULE_AUTHOR("Harsha Priya <priya.harsha@intel.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/sn95031.h b/sound/soc/codecs/sn95031.h
index b17a39b..e2b17d9 100644
--- a/sound/soc/codecs/sn95031.h
+++ b/sound/soc/codecs/sn95031.h
@@ -35,13 +35,13 @@
 #define SN95031_AUDPLLCTRL		0x240
 #define SN95031_DMICBUF0123		0x241
 #define SN95031_DMICBUF45		0x242
-#define SN95031_DMICGPO		0x244
-#define SN95031_DMICMUX		0x245
+#define SN95031_DMICGPO			0x244
+#define SN95031_DMICMUX			0x245
 #define SN95031_DMICLK			0x246
-#define SN95031_MICBIAS		0x247
+#define SN95031_MICBIAS			0x247
 #define SN95031_ADCCONFIG		0x248
-#define SN95031_MICAMP1		0x249
-#define SN95031_MICAMP2		0x24A
+#define SN95031_MICAMP1			0x249
+#define SN95031_MICAMP2			0x24A
 #define SN95031_NOISEMUX		0x24B
 #define SN95031_AUDIOMUX12		0x24C
 #define SN95031_AUDIOMUX34		0x24D
@@ -49,7 +49,7 @@
 #define SN95031_AUDIOTXEN		0x24F
 #define SN95031_HSEPRXCTRL		0x250
 #define SN95031_IHFRXCTRL		0x251
-#define SN95031_HSMIXER		0x256
+#define SN95031_HSMIXER			0x256
 #define SN95031_DACCONFIG		0x257
 #define SN95031_SOFTMUTE		0x258
 #define SN95031_HSLVOLCTRL		0x259
-- 
1.7.2.3
