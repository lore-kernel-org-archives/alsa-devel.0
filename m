From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Actively manage WM8903 DC servo
	configuration
Date: Wed,  9 Feb 2011 20:15:10 +0000
Message-ID: <1297282510-2319-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E471C24334
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 21:15:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Explicitly cache the DC servo offsets for digital paths in the driver,
allowing them to be preserved over suspend and resume, and ensure that
we recalibrate analogue outputs paths when they are in use so that we
cover any changes in the input offset.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |  123 +++++++++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/wm8903.h |    8 +++
 2 files changed, 127 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 0ade99d..ff1371f 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -224,6 +224,9 @@ struct wm8903_priv {
 	int fs;
 	int deemph;
 
+	int dcs_pending;
+	int dcs_cache[4];
+
 	/* Reference count */
 	int class_w_users;
 
@@ -253,6 +256,10 @@ static int wm8903_volatile_register(struct snd_soc_codec *codec, unsigned int re
 	case WM8903_WRITE_SEQUENCER_4:
 	case WM8903_POWER_MANAGEMENT_3:
 	case WM8903_POWER_MANAGEMENT_2:
+	case WM8903_DC_SERVO_READBACK_1:
+	case WM8903_DC_SERVO_READBACK_2:
+	case WM8903_DC_SERVO_READBACK_3:
+	case WM8903_DC_SERVO_READBACK_4:
 		return 1;
 
 	default:
@@ -320,6 +327,103 @@ static int wm8903_cp_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int wm8903_dcs_event(struct snd_soc_dapm_widget *w,
+			    struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		wm8903->dcs_pending |= 1 << w->shift;
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_update_bits(codec, WM8903_DC_SERVO_0,
+				    1 << w->shift, 0);
+		break;
+	}
+
+	return 0;
+}
+
+#define WM8903_DCS_MODE_WRITE_STOP 0
+#define WM8903_DCS_MODE_START_STOP 2
+
+static void wm8903_seq_notifier(struct snd_soc_dapm_context *dapm,
+				enum snd_soc_dapm_type event, int subseq)
+{
+	struct snd_soc_codec *codec = container_of(dapm,
+						   struct snd_soc_codec, dapm);
+	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
+	int dcs_mode = WM8903_DCS_MODE_WRITE_STOP;
+	int i, val;
+
+	/* Complete any pending DC servo starts */
+	if (wm8903->dcs_pending) {
+		dev_dbg(codec->dev, "Starting DC servo for %x\n",
+			wm8903->dcs_pending);
+
+		/* If we've no cached values then we need to do startup */
+		for (i = 0; i < ARRAY_SIZE(wm8903->dcs_cache); i++) {
+			if (!(wm8903->dcs_pending & (1 << i)))
+				continue;
+
+			if (wm8903->dcs_cache[i]) {
+				dev_dbg(codec->dev,
+					"Restore DC servo %d value %x\n",
+					3 - i, wm8903->dcs_cache[i]);
+
+				snd_soc_write(codec, WM8903_DC_SERVO_4 + i,
+					      wm8903->dcs_cache[i] & 0xff);
+			} else {
+				dev_dbg(codec->dev,
+					"Calibrate DC servo %d\n", 3 - i);
+				dcs_mode = WM8903_DCS_MODE_START_STOP;
+			}
+		}
+
+		/* Don't trust the cache for analogue */
+		if (wm8903->class_w_users)
+			dcs_mode = WM8903_DCS_MODE_START_STOP;
+
+		snd_soc_update_bits(codec, WM8903_DC_SERVO_2,
+				    WM8903_DCS_MODE_MASK, dcs_mode);
+
+		snd_soc_update_bits(codec, WM8903_DC_SERVO_0,
+				    WM8903_DCS_ENA_MASK, wm8903->dcs_pending);
+
+		switch (dcs_mode) {
+		case WM8903_DCS_MODE_WRITE_STOP:
+			break;
+
+		case WM8903_DCS_MODE_START_STOP:
+			msleep(270);
+
+			/* Cache the measured offsets for digital */
+			if (wm8903->class_w_users)
+				break;
+
+			for (i = 0; i < ARRAY_SIZE(wm8903->dcs_cache); i++) {
+				if (!(wm8903->dcs_pending & (1 << i)))
+					continue;
+
+				val = snd_soc_read(codec,
+						   WM8903_DC_SERVO_READBACK_1 + i);
+				dev_dbg(codec->dev, "DC servo %d: %x\n",
+					3 - i, val);
+				wm8903->dcs_cache[i] = val;
+			}
+			break;
+
+		default:
+			pr_warn("DCS mode %d delay not set\n", dcs_mode);
+			break;
+		}
+
+		wm8903->dcs_pending = 0;
+	}
+}
+
 /*
  * When used with DAC outputs only the WM8903 charge pump supports
  * operation in class W mode, providing very low power consumption
@@ -852,10 +956,15 @@ SND_SOC_DAPM_PGA_S("LINEOUTR_ENA_OUTP", 3, WM8903_ANALOGUE_LINEOUT_0, 2, 0,
 SND_SOC_DAPM_PGA_S("LINEOUTR_ENA_DLY", 1, WM8903_ANALOGUE_LINEOUT_0, 1, 0,
 		   NULL, 0),
 
-SND_SOC_DAPM_PGA_S("HPL_DCS", 3, WM8903_DC_SERVO_0, 3, 0, NULL, 0),
-SND_SOC_DAPM_PGA_S("HPR_DCS", 3, WM8903_DC_SERVO_0, 2, 0, NULL, 0),
-SND_SOC_DAPM_PGA_S("LINEOUTL_DCS", 3, WM8903_DC_SERVO_0, 1, 0, NULL, 0),
-SND_SOC_DAPM_PGA_S("LINEOUTR_DCS", 3, WM8903_DC_SERVO_0, 0, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("DCS Master", WM8903_DC_SERVO_0, 4, 0, NULL, 0),
+SND_SOC_DAPM_PGA_S("HPL_DCS", 3, SND_SOC_NOPM, 3, 0, wm8903_dcs_event,
+		   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_PGA_S("HPR_DCS", 3, SND_SOC_NOPM, 2, 0, wm8903_dcs_event,
+		   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_PGA_S("LINEOUTL_DCS", 3, SND_SOC_NOPM, 1, 0, wm8903_dcs_event,
+		   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_PGA_S("LINEOUTR_DCS", 3, SND_SOC_NOPM, 0, 0, wm8903_dcs_event,
+		   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 
 SND_SOC_DAPM_PGA("Left Speaker PGA", WM8903_POWER_MANAGEMENT_5, 1, 0,
 		 NULL, 0),
@@ -984,6 +1093,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{ "LINEOUTL_ENA_DLY", NULL, "Left Line Output PGA" },
 	{ "LINEOUTR_ENA_DLY", NULL, "Right Line Output PGA" },
 
+	{ "HPL_DCS", NULL, "DCS Master" },
+	{ "HPR_DCS", NULL, "DCS Master" },
+	{ "LINEOUTL_DCS", NULL, "DCS Master" },
+	{ "LINEOUTR_DCS", NULL, "DCS Master" },
+
 	{ "HPL_DCS", NULL, "HPL_ENA_DLY" },
 	{ "HPR_DCS", NULL, "HPR_ENA_DLY" },
 	{ "LINEOUTL_DCS", NULL, "LINEOUTL_ENA_DLY" },
@@ -2103,6 +2217,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8903 = {
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8903_reg_defaults,
 	.volatile_register = wm8903_volatile_register,
+	.seq_notifier = wm8903_seq_notifier,
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
diff --git a/sound/soc/codecs/wm8903.h b/sound/soc/codecs/wm8903.h
index a6d63e4..7d96646 100644
--- a/sound/soc/codecs/wm8903.h
+++ b/sound/soc/codecs/wm8903.h
@@ -81,6 +81,14 @@ extern int wm8903_mic_detect(struct snd_soc_codec *codec,
 #define WM8903_ANALOGUE_SPK_OUTPUT_CONTROL_0    0x41
 #define WM8903_DC_SERVO_0                       0x43
 #define WM8903_DC_SERVO_2                       0x45
+#define WM8903_DC_SERVO_4			0x47
+#define WM8903_DC_SERVO_5			0x48
+#define WM8903_DC_SERVO_6			0x49
+#define WM8903_DC_SERVO_7			0x4A
+#define WM8903_DC_SERVO_READBACK_1		0x51
+#define WM8903_DC_SERVO_READBACK_2		0x52
+#define WM8903_DC_SERVO_READBACK_3		0x53
+#define WM8903_DC_SERVO_READBACK_4		0x54
 #define WM8903_ANALOGUE_HP_0                    0x5A
 #define WM8903_ANALOGUE_LINEOUT_0               0x5E
 #define WM8903_CHARGE_PUMP_0                    0x62
-- 
1.7.2.3
