From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: Add WM8958 microphone detection
	support
Date: Fri, 26 Nov 2010 15:21:09 +0000
Message-ID: <1290784869-22204-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1290784869-22204-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 07455103D81
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 16:23:32 +0100 (CET)
In-Reply-To: <1290784869-22204-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

The WM8958 contains an advanced accessory detection feature which allows
detection of up to seven different impedence levels on the microphone
bias output, including detection of video outputs. Since some of the
more involved accessory interfaces may involve noticable interactions
with external components a simple detection scheme is provided by
default with the option to provide custom handling of accessory detect.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/mfd/wm8994/registers.h |   43 ++++++++++
 sound/soc/codecs/wm8994.c            |  150 ++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8994.h            |    4 +
 3 files changed, 197 insertions(+), 0 deletions(-)

diff --git a/include/linux/mfd/wm8994/registers.h b/include/linux/mfd/wm8994/registers.h
index 423b2b5..a610c87 100644
--- a/include/linux/mfd/wm8994/registers.h
+++ b/include/linux/mfd/wm8994/registers.h
@@ -70,6 +70,9 @@
 #define WM8994_DC_SERVO_4                       0x57
 #define WM8994_DC_SERVO_READBACK                0x58
 #define WM8994_ANALOGUE_HP_1                    0x60
+#define WM8958_MIC_DETECT_1                     0xD0
+#define WM8958_MIC_DETECT_2                     0xD1
+#define WM8958_MIC_DETECT_3                     0xD2
 #define WM8994_CHIP_REVISION                    0x100
 #define WM8994_CONTROL_INTERFACE                0x101
 #define WM8994_WRITE_SEQUENCER_CTRL_1           0x110
@@ -1971,6 +1974,46 @@
 #define WM8994_HPOUT1R_DLY_WIDTH                     1  /* HPOUT1R_DLY */
 
 /*
+ * R208 (0xD0) - Mic Detect 1
+ */
+#define WM8958_MICD_BIAS_STARTTIME_MASK         0xF000  /* MICD_BIAS_STARTTIME - [15:12] */
+#define WM8958_MICD_BIAS_STARTTIME_SHIFT            12  /* MICD_BIAS_STARTTIME - [15:12] */
+#define WM8958_MICD_BIAS_STARTTIME_WIDTH             4  /* MICD_BIAS_STARTTIME - [15:12] */
+#define WM8958_MICD_RATE_MASK                   0x0F00  /* MICD_RATE - [11:8] */
+#define WM8958_MICD_RATE_SHIFT                       8  /* MICD_RATE - [11:8] */
+#define WM8958_MICD_RATE_WIDTH                       4  /* MICD_RATE - [11:8] */
+#define WM8958_MICD_DBTIME                      0x0002  /* MICD_DBTIME */
+#define WM8958_MICD_DBTIME_MASK                 0x0002  /* MICD_DBTIME */
+#define WM8958_MICD_DBTIME_SHIFT                     1  /* MICD_DBTIME */
+#define WM8958_MICD_DBTIME_WIDTH                     1  /* MICD_DBTIME */
+#define WM8958_MICD_ENA                         0x0001  /* MICD_ENA */
+#define WM8958_MICD_ENA_MASK                    0x0001  /* MICD_ENA */
+#define WM8958_MICD_ENA_SHIFT                        0  /* MICD_ENA */
+#define WM8958_MICD_ENA_WIDTH                        1  /* MICD_ENA */
+
+/*
+ * R209 (0xD1) - Mic Detect 2
+ */
+#define WM8958_MICD_LVL_SEL_MASK                0x00FF  /* MICD_LVL_SEL - [7:0] */
+#define WM8958_MICD_LVL_SEL_SHIFT                    0  /* MICD_LVL_SEL - [7:0] */
+#define WM8958_MICD_LVL_SEL_WIDTH                    8  /* MICD_LVL_SEL - [7:0] */
+
+/*
+ * R210 (0xD2) - Mic Detect 3
+ */
+#define WM8958_MICD_LVL_MASK                    0x07FC  /* MICD_LVL - [10:2] */
+#define WM8958_MICD_LVL_SHIFT                        2  /* MICD_LVL - [10:2] */
+#define WM8958_MICD_LVL_WIDTH                        9  /* MICD_LVL - [10:2] */
+#define WM8958_MICD_VALID                       0x0002  /* MICD_VALID */
+#define WM8958_MICD_VALID_MASK                  0x0002  /* MICD_VALID */
+#define WM8958_MICD_VALID_SHIFT                      1  /* MICD_VALID */
+#define WM8958_MICD_VALID_WIDTH                      1  /* MICD_VALID */
+#define WM8958_MICD_STS                         0x0001  /* MICD_STS */
+#define WM8958_MICD_STS_MASK                    0x0001  /* MICD_STS */
+#define WM8958_MICD_STS_SHIFT                        0  /* MICD_STS */
+#define WM8958_MICD_STS_WIDTH                        1  /* MICD_STS */
+
+/*
  * R256 (0x100) - Chip Revision
  */
 #define WM8994_CHIP_REV_MASK                    0x000F  /* CHIP_REV - [3:0] */
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index b30b2dd..948677b 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -21,6 +21,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <sound/core.h>
+#include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -95,6 +96,11 @@ struct wm8994_priv {
 
 	struct wm8994_micdet micdet[2];
 
+	wm8958_micdet_cb jack_cb;
+	void *jack_cb_data;
+	bool jack_is_mic;
+	bool jack_is_video;
+
 	int revision;
 	struct wm8994_pdata *pdata;
 };
@@ -140,6 +146,7 @@ static int wm8994_volatile(unsigned int reg)
 	case WM8994_LDO_1:
 	case WM8994_LDO_2:
 	case WM8958_DSP2_EXECCONTROL:
+	case WM8958_MIC_DETECT_3:
 		return 1;
 	default:
 		return 0;
@@ -2633,6 +2640,133 @@ static irqreturn_t wm8994_mic_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/* Default microphone detection handler for WM8958 - the user can
+ * override this if they wish.
+ */
+static void wm8958_default_micdet(u16 status, void *data)
+{
+	struct snd_soc_codec *codec = data;
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	int report = 0;
+
+	/* If nothing present then clear our statuses */
+	if (!(status & WM8958_MICD_STS)) {
+		wm8994->jack_is_video = false;
+		wm8994->jack_is_mic = false;
+		goto done;
+	}
+
+	/* Assume anything over 475 ohms is a microphone and remember
+	 * that we've seen one (since buttons override it) */
+	if (status & 0x600)
+		wm8994->jack_is_mic = true;
+	if (wm8994->jack_is_mic)
+		report |= SND_JACK_MICROPHONE;
+
+	/* Video has an impedence of approximately 75 ohms; assume
+	 * this isn't used as a button and remember it since buttons
+	 * override it. */
+	if (status & 0x40)
+		wm8994->jack_is_video = true;
+	if (wm8994->jack_is_video)
+		report |= SND_JACK_VIDEOOUT;
+
+	/* Everything else is buttons; just assign slots */
+	if (status & 0x4)
+		report |= SND_JACK_BTN_0;
+	if (status & 0x8)
+		report |= SND_JACK_BTN_1;
+	if (status & 0x10)
+		report |= SND_JACK_BTN_2;
+	if (status & 0x20)
+		report |= SND_JACK_BTN_3;
+	if (status & 0x80)
+		report |= SND_JACK_BTN_4;
+	if (status & 0x100)
+		report |= SND_JACK_BTN_5;
+
+done:
+	snd_soc_jack_report(wm8994->micdet[0].jack,
+			    SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2 |
+			    SND_JACK_BTN_3 | SND_JACK_BTN_4 | SND_JACK_BTN_5 |
+			    SND_JACK_MICROPHONE | SND_JACK_VIDEOOUT,
+			    report);
+}
+
+/**
+ * wm8958_mic_detect - Enable microphone detection via the WM8958 IRQ
+ *
+ * @codec:   WM8958 codec
+ * @jack:    jack to report detection events on
+ *
+ * Enable microphone detection functionality for the WM8958.  By
+ * default simple detection which supports the detection of up to 6
+ * buttons plus video and microphone functionality is supported.
+ *
+ * The WM8958 has an advanced jack detection facility which is able to
+ * support complex accessory detection, especially when used in
+ * conjunction with external circuitry.  In order to provide maximum
+ * flexiblity a callback is provided which allows a completely custom
+ * detection algorithm.
+ */
+int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
+		      wm8958_micdet_cb cb, void *cb_data)
+{
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994 *control = codec->control_data;
+
+	if (control->type != WM8958)
+		return -EINVAL;
+
+	if (jack) {
+		if (!cb) {
+			dev_dbg(codec->dev, "Using default micdet callback\n");
+			cb = wm8958_default_micdet;
+			cb_data = codec;
+		}
+
+		wm8994->micdet[0].jack = jack;
+		wm8994->jack_cb = cb;
+		wm8994->jack_cb_data = cb_data;
+
+		snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
+				    WM8958_MICD_ENA, WM8958_MICD_ENA);
+	} else {
+		snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
+				    WM8958_MICD_ENA, 0);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wm8958_mic_detect);
+
+static irqreturn_t wm8958_mic_irq(int irq, void *data)
+{
+	struct wm8994_priv *wm8994 = data;
+	struct snd_soc_codec *codec = wm8994->codec;
+	int reg;
+
+	reg = snd_soc_read(codec, WM8958_MIC_DETECT_3);
+	if (reg < 0) {
+		dev_err(codec->dev, "Failed to read mic detect status: %d\n",
+			reg);
+		return IRQ_NONE;
+	}
+
+	if (!(reg & WM8958_MICD_VALID)) {
+		dev_dbg(codec->dev, "Mic detect data not valid\n");
+		goto out;
+	}
+
+	if (wm8994->jack_cb)
+		wm8994->jack_cb(reg, wm8994->jack_cb_data);
+	else
+		dev_warn(codec->dev, "Accessory detection with no callback\n");
+
+out:
+	return IRQ_HANDLED;
+}
+
 static int wm8994_codec_probe(struct snd_soc_codec *codec)
 {
 	struct wm8994 *control;
@@ -2732,6 +2866,17 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 				 "Failed to request Mic2 short IRQ: %d\n",
 				 ret);
 		break;
+
+	case WM8958:
+		ret = wm8994_request_irq(codec->control_data,
+					 WM8994_IRQ_MIC1_DET,
+					 wm8958_mic_irq, "Mic detect",
+					 wm8994);
+		if (ret != 0)
+			dev_warn(codec->dev,
+				 "Failed to request Mic detect IRQ: %d\n",
+				 ret);
+		break;
 	}
 
 	/* Remember if AIFnLRCLK is configured as a GPIO.  This should be
@@ -2866,6 +3011,11 @@ static int  wm8994_codec_remove(struct snd_soc_codec *codec)
 		wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC1_DET,
 				wm8994);
 		break;
+
+	case WM8958:
+		wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC1_DET,
+				wm8994);
+		break;
 	}
 	kfree(wm8994->retune_mobile_texts);
 	kfree(wm8994->drc_texts);
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index b8b3166..455cae6 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -28,8 +28,12 @@
 #define WM8994_FLL_SRC_LRCLK  3
 #define WM8994_FLL_SRC_BCLK   4
 
+typedef void (*wm8958_micdet_cb)(u16 status, void *data);
+
 int wm8994_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 		      int micbias, int det, int shrt);
+int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
+		      wm8958_micdet_cb cb, void *cb_data);
 
 #define WM8994_CACHE_SIZE 1570
 
-- 
1.7.1
