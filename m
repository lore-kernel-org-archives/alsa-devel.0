From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH 4/4] ASoC: UDA1380: change
	decimator/interpolator register handling
Date: Tue,  3 Mar 2009 16:10:54 +0100
Message-ID: <1236093054-1952-4-git-send-email-philipp.zabel@gmail.com>
References: <1236093054-1952-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f177.google.com (mail-fx0-f177.google.com
	[209.85.220.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 0178210384A
	for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2009 16:11:05 +0100 (CET)
Received: by mail-fx0-f177.google.com with SMTP id 25so2677141fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 03 Mar 2009 07:11:05 -0800 (PST)
In-Reply-To: <1236093054-1952-1-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

If the UDA1380's interpolator or decimator are set to be clocked from
the WSPLL (which syncs to the WSI signal), the DAI link must be running
to change the interpolator/decimator registers (which include volume
controls and digital mute setting).

* Queue work in the alsa PCM_START .trigger to flush registers
  as soon as the link is running. This replaces the .prepare
  and .digital_mute callbacks.
* Use the SILENCE override instead of MTM for muting and remove
  its alsa control to avoid confusion.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/codecs/uda1380.c |  102 +++++++++++++++++++++-----------------------
 1 files changed, 48 insertions(+), 54 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index a6987d7..1b10f48 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -25,6 +25,7 @@
 #include <linux/ioctl.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/workqueue.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/initval.h>
@@ -35,6 +36,9 @@
 
 #include "uda1380.h"
 
+static struct work_struct uda1380_work;
+static struct snd_soc_codec *uda1380_codec;
+
 /*
  * uda1380 register cache
  */
@@ -50,6 +54,8 @@ static const u16 uda1380_reg[UDA1380_CACHEREGNUM] = {
 	0x0000, 0x8000, 0x0002, 0x0000,
 };
 
+static unsigned long uda1380_cache_dirty;
+
 /*
  * read uda1380 register cache
  */
@@ -71,8 +77,11 @@ static inline void uda1380_write_reg_cache(struct snd_soc_codec *codec,
 	u16 reg, unsigned int value)
 {
 	u16 *cache = codec->reg_cache;
+
 	if (reg >= UDA1380_CACHEREGNUM)
 		return;
+	if ((reg >= 0x10) && (cache[reg] != value))
+		set_bit(reg - 0x10, &uda1380_cache_dirty);
 	cache[reg] = value;
 }
 
@@ -111,6 +120,8 @@ static int uda1380_write(struct snd_soc_codec *codec, unsigned int reg,
 					(data[0]<<8) | data[1]);
 			return -EIO;
 		}
+		if (reg >= 0x10)
+			clear_bit(reg - 0x10, &uda1380_cache_dirty);
 		return 0;
 	} else
 		return -EIO;
@@ -118,6 +129,20 @@ static int uda1380_write(struct snd_soc_codec *codec, unsigned int reg,
 
 #define uda1380_reset(c)	uda1380_write(c, UDA1380_RESET, 0)
 
+static void uda1380_flush_work(struct work_struct *work)
+{
+	int bit, reg;
+
+	for_each_bit(bit, &uda1380_cache_dirty, UDA1380_CACHEREGNUM - 0x10) {
+		reg = 0x10 + bit;
+		pr_debug("uda1380: flush reg %x val %x:\n", reg,
+				uda1380_read_reg_cache(uda1380_codec, reg));
+		uda1380_write(uda1380_codec, reg,
+				uda1380_read_reg_cache(uda1380_codec, reg));
+		clear_bit(bit, &uda1380_cache_dirty);
+	}
+}
+
 /* declarations of ALSA reg_elem_REAL controls */
 static const char *uda1380_deemp[] = {
 	"None",
@@ -252,7 +277,6 @@ static const struct snd_kcontrol_new uda1380_snd_controls[] = {
 	SOC_SINGLE("DAC Polarity inverting Switch", UDA1380_MIXER, 15, 1, 0),	/* DA_POL_INV */
 	SOC_ENUM("Noise Shaper", uda1380_sel_ns_enum),				/* SEL_NS */
 	SOC_ENUM("Digital Mixer Signal Control", uda1380_mix_enum),		/* MIX_POS, MIX */
-	SOC_SINGLE("Silence Switch", UDA1380_MIXER, 7, 1, 0),			/* SILENCE, force DAC output to silence */
 	SOC_SINGLE("Silence Detector Switch", UDA1380_MIXER, 6, 1, 0),		/* SDET_ON */
 	SOC_ENUM("Silence Detector Setting", uda1380_sdet_enum),		/* SD_VALUE */
 	SOC_ENUM("Oversampling Input", uda1380_os_enum),			/* OS */
@@ -443,41 +467,28 @@ static int uda1380_set_dai_fmt_capture(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-/*
- * Flush reg cache
- * We can only write the interpolator and decimator registers
- * when the DAI is being clocked by the CPU DAI. It's up to the
- * machine and cpu DAI driver to do this before we are called.
- */
-static int uda1380_pcm_prepare(struct snd_pcm_substream *substream,
-			       struct snd_soc_dai *dai)
+static int uda1380_trigger(struct snd_pcm_substream *substream, int cmd,
+		struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
-	int reg, reg_start, reg_end, clk;
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		reg_start = UDA1380_MVOL;
-		reg_end = UDA1380_MIXER;
-	} else {
-		reg_start = UDA1380_DEC;
-		reg_end = UDA1380_AGC;
-	}
-
-	/* FIXME disable DAC_CLK */
-	clk = uda1380_read_reg_cache(codec, UDA1380_CLK);
-	uda1380_write(codec, UDA1380_CLK, clk & ~R00_DAC_CLK);
-
-	for (reg = reg_start; reg <= reg_end; reg++) {
-		pr_debug("uda1380: flush reg %x val %x:", reg,
-				uda1380_read_reg_cache(codec, reg));
-		uda1380_write(codec, reg, uda1380_read_reg_cache(codec, reg));
+	int mixer = uda1380_read_reg_cache(codec, UDA1380_MIXER);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		uda1380_write_reg_cache(codec, UDA1380_MIXER,
+					mixer & ~R14_SILENCE);
+		schedule_work(&uda1380_work);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		uda1380_write_reg_cache(codec, UDA1380_MIXER,
+					mixer | R14_SILENCE);
+		schedule_work(&uda1380_work);
+		break;
 	}
-
-	/* FIXME restore DAC_CLK */
-	uda1380_write(codec, UDA1380_CLK, clk);
-
 	return 0;
 }
 
@@ -543,24 +554,6 @@ static void uda1380_pcm_shutdown(struct snd_pcm_substream *substream,
 	uda1380_write(codec, UDA1380_CLK, clk);
 }
 
-static int uda1380_mute(struct snd_soc_dai *codec_dai, int mute)
-{
-	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 mute_reg = uda1380_read_reg_cache(codec, UDA1380_DEEMP) & ~R13_MTM;
-
-	/* FIXME: mute(codec,0) is called when the magician clock is already
-	 * set to WSPLL, but for some unknown reason writing to interpolator
-	 * registers works only when clocked by SYSCLK */
-	u16 clk = uda1380_read_reg_cache(codec, UDA1380_CLK);
-	uda1380_write(codec, UDA1380_CLK, ~R00_DAC_CLK & clk);
-	if (mute)
-		uda1380_write(codec, UDA1380_DEEMP, mute_reg | R13_MTM);
-	else
-		uda1380_write(codec, UDA1380_DEEMP, mute_reg);
-	uda1380_write(codec, UDA1380_CLK, clk);
-	return 0;
-}
-
 static int uda1380_set_bias_level(struct snd_soc_codec *codec,
 	enum snd_soc_bias_level level)
 {
@@ -602,10 +595,9 @@ struct snd_soc_dai uda1380_dai[] = {
 		.rates = UDA1380_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 	.ops = {
+		.trigger = uda1380_trigger,
 		.hw_params = uda1380_pcm_hw_params,
 		.shutdown = uda1380_pcm_shutdown,
-		.prepare = uda1380_pcm_prepare,
-		.digital_mute = uda1380_mute,
 		.set_fmt = uda1380_set_dai_fmt_both,
 	},
 },
@@ -619,10 +611,9 @@ struct snd_soc_dai uda1380_dai[] = {
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	.ops = {
+		.trigger = uda1380_trigger,
 		.hw_params = uda1380_pcm_hw_params,
 		.shutdown = uda1380_pcm_shutdown,
-		.prepare = uda1380_pcm_prepare,
-		.digital_mute = uda1380_mute,
 		.set_fmt = uda1380_set_dai_fmt_playback,
 	},
 },
@@ -636,9 +627,9 @@ struct snd_soc_dai uda1380_dai[] = {
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	.ops = {
+		.trigger = uda1380_trigger,
 		.hw_params = uda1380_pcm_hw_params,
 		.shutdown = uda1380_pcm_shutdown,
-		.prepare = uda1380_pcm_prepare,
 		.set_fmt = uda1380_set_dai_fmt_capture,
 	},
 },
@@ -697,6 +688,9 @@ static int uda1380_init(struct snd_soc_device *socdev, int dac_clk)
 	codec->reg_cache_step = 1;
 	uda1380_reset(codec);
 
+	uda1380_codec = codec;
+	INIT_WORK(&uda1380_work, uda1380_flush_work);
+
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
 	if (ret < 0) {
-- 
1.6.1.3
