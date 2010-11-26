From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: Add WM8958 Multi-band compressor
	support
Date: Fri, 26 Nov 2010 15:21:08 +0000
Message-ID: <1290784869-22204-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1290784869-22204-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8DDF024503
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 16:23:29 +0100 (CET)
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

The WM8958 features a multi-band compressor which can be enabled on
any of the AIF inputs. The MBC allows different gains to be applied to
differnt audio bands, providing an improvement in perceived loudness
of the signal by avoiding overdriving the output transducers. This
patch enables support for the MBC.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/mfd/wm8994/registers.h |  115 ++++++++++++++++++++
 sound/soc/codecs/wm8994.c            |  198 +++++++++++++++++++++++++++++++--
 2 files changed, 301 insertions(+), 12 deletions(-)

diff --git a/include/linux/mfd/wm8994/registers.h b/include/linux/mfd/wm8994/registers.h
index 3eb70a4..423b2b5 100644
--- a/include/linux/mfd/wm8994/registers.h
+++ b/include/linux/mfd/wm8994/registers.h
@@ -246,6 +246,15 @@
 #define WM8994_INTERRUPT_STATUS_2_MASK          0x739
 #define WM8994_INTERRUPT_CONTROL                0x740
 #define WM8994_IRQ_DEBOUNCE                     0x748
+#define WM8958_DSP2_PROGRAM                     0x900
+#define WM8958_DSP2_CONFIG                      0x901
+#define WM8958_DSP2_MAGICNUM                    0xA00
+#define WM8958_DSP2_RELEASEYEAR                 0xA01
+#define WM8958_DSP2_RELEASEMONTHDAY             0xA02
+#define WM8958_DSP2_RELEASETIME                 0xA03
+#define WM8958_DSP2_VERMAJMIN                   0xA04
+#define WM8958_DSP2_VERBUILD                    0xA05
+#define WM8958_DSP2_EXECCONTROL                 0xA0D
 #define WM8994_WRITE_SEQUENCER_0                0x3000
 #define WM8994_WRITE_SEQUENCER_1                0x3001
 #define WM8994_WRITE_SEQUENCER_2                0x3002
@@ -2079,6 +2088,14 @@
 /*
  * R520 (0x208) - Clocking (1)
  */
+#define WM8958_DSP2CLK_ENA                      0x4000  /* DSP2CLK_ENA */
+#define WM8958_DSP2CLK_ENA_MASK                 0x4000  /* DSP2CLK_ENA */
+#define WM8958_DSP2CLK_ENA_SHIFT                    14  /* DSP2CLK_ENA */
+#define WM8958_DSP2CLK_ENA_WIDTH                     1  /* DSP2CLK_ENA */
+#define WM8958_DSP2CLK_SRC                      0x1000  /* DSP2CLK_SRC */
+#define WM8958_DSP2CLK_SRC_MASK                 0x1000  /* DSP2CLK_SRC */
+#define WM8958_DSP2CLK_SRC_SHIFT                    12  /* DSP2CLK_SRC */
+#define WM8958_DSP2CLK_SRC_WIDTH                     1  /* DSP2CLK_SRC */
 #define WM8994_TOCLK_ENA                        0x0010  /* TOCLK_ENA */
 #define WM8994_TOCLK_ENA_MASK                   0x0010  /* TOCLK_ENA */
 #define WM8994_TOCLK_ENA_SHIFT                       4  /* TOCLK_ENA */
@@ -4356,4 +4373,102 @@
 #define WM8994_TEMP_SHUT_DB_SHIFT                    0  /* TEMP_SHUT_DB */
 #define WM8994_TEMP_SHUT_DB_WIDTH                    1  /* TEMP_SHUT_DB */
 
+/*
+ * R2304 (0x900) - DSP2_Program
+ */
+#define WM8958_DSP2_ENA                         0x0001  /* DSP2_ENA */
+#define WM8958_DSP2_ENA_MASK                    0x0001  /* DSP2_ENA */
+#define WM8958_DSP2_ENA_SHIFT                        0  /* DSP2_ENA */
+#define WM8958_DSP2_ENA_WIDTH                        1  /* DSP2_ENA */
+
+/*
+ * R2305 (0x901) - DSP2_Config
+ */
+#define WM8958_MBC_SEL_MASK                     0x0030  /* MBC_SEL - [5:4] */
+#define WM8958_MBC_SEL_SHIFT                         4  /* MBC_SEL - [5:4] */
+#define WM8958_MBC_SEL_WIDTH                         2  /* MBC_SEL - [5:4] */
+#define WM8958_MBC_ENA                          0x0001  /* MBC_ENA */
+#define WM8958_MBC_ENA_MASK                     0x0001  /* MBC_ENA */
+#define WM8958_MBC_ENA_SHIFT                         0  /* MBC_ENA */
+#define WM8958_MBC_ENA_WIDTH                         1  /* MBC_ENA */
+
+/*
+ * R2560 (0xA00) - DSP2_MagicNum
+ */
+#define WM8958_DSP2_MAGIC_NUM_MASK              0xFFFF  /* DSP2_MAGIC_NUM - [15:0] */
+#define WM8958_DSP2_MAGIC_NUM_SHIFT                  0  /* DSP2_MAGIC_NUM - [15:0] */
+#define WM8958_DSP2_MAGIC_NUM_WIDTH                 16  /* DSP2_MAGIC_NUM - [15:0] */
+
+/*
+ * R2561 (0xA01) - DSP2_ReleaseYear
+ */
+#define WM8958_DSP2_RELEASE_YEAR_MASK           0xFFFF  /* DSP2_RELEASE_YEAR - [15:0] */
+#define WM8958_DSP2_RELEASE_YEAR_SHIFT               0  /* DSP2_RELEASE_YEAR - [15:0] */
+#define WM8958_DSP2_RELEASE_YEAR_WIDTH              16  /* DSP2_RELEASE_YEAR - [15:0] */
+
+/*
+ * R2562 (0xA02) - DSP2_ReleaseMonthDay
+ */
+#define WM8958_DSP2_RELEASE_MONTH_MASK          0xFF00  /* DSP2_RELEASE_MONTH - [15:8] */
+#define WM8958_DSP2_RELEASE_MONTH_SHIFT              8  /* DSP2_RELEASE_MONTH - [15:8] */
+#define WM8958_DSP2_RELEASE_MONTH_WIDTH              8  /* DSP2_RELEASE_MONTH - [15:8] */
+#define WM8958_DSP2_RELEASE_DAY_MASK            0x00FF  /* DSP2_RELEASE_DAY - [7:0] */
+#define WM8958_DSP2_RELEASE_DAY_SHIFT                0  /* DSP2_RELEASE_DAY - [7:0] */
+#define WM8958_DSP2_RELEASE_DAY_WIDTH                8  /* DSP2_RELEASE_DAY - [7:0] */
+
+/*
+ * R2563 (0xA03) - DSP2_ReleaseTime
+ */
+#define WM8958_DSP2_RELEASE_HOURS_MASK          0xFF00  /* DSP2_RELEASE_HOURS - [15:8] */
+#define WM8958_DSP2_RELEASE_HOURS_SHIFT              8  /* DSP2_RELEASE_HOURS - [15:8] */
+#define WM8958_DSP2_RELEASE_HOURS_WIDTH              8  /* DSP2_RELEASE_HOURS - [15:8] */
+#define WM8958_DSP2_RELEASE_MINS_MASK           0x00FF  /* DSP2_RELEASE_MINS - [7:0] */
+#define WM8958_DSP2_RELEASE_MINS_SHIFT               0  /* DSP2_RELEASE_MINS - [7:0] */
+#define WM8958_DSP2_RELEASE_MINS_WIDTH               8  /* DSP2_RELEASE_MINS - [7:0] */
+
+/*
+ * R2564 (0xA04) - DSP2_VerMajMin
+ */
+#define WM8958_DSP2_MAJOR_VER_MASK              0xFF00  /* DSP2_MAJOR_VER - [15:8] */
+#define WM8958_DSP2_MAJOR_VER_SHIFT                  8  /* DSP2_MAJOR_VER - [15:8] */
+#define WM8958_DSP2_MAJOR_VER_WIDTH                  8  /* DSP2_MAJOR_VER - [15:8] */
+#define WM8958_DSP2_MINOR_VER_MASK              0x00FF  /* DSP2_MINOR_VER - [7:0] */
+#define WM8958_DSP2_MINOR_VER_SHIFT                  0  /* DSP2_MINOR_VER - [7:0] */
+#define WM8958_DSP2_MINOR_VER_WIDTH                  8  /* DSP2_MINOR_VER - [7:0] */
+
+/*
+ * R2565 (0xA05) - DSP2_VerBuild
+ */
+#define WM8958_DSP2_BUILD_VER_MASK              0xFFFF  /* DSP2_BUILD_VER - [15:0] */
+#define WM8958_DSP2_BUILD_VER_SHIFT                  0  /* DSP2_BUILD_VER - [15:0] */
+#define WM8958_DSP2_BUILD_VER_WIDTH                 16  /* DSP2_BUILD_VER - [15:0] */
+
+/*
+ * R2573 (0xA0D) - DSP2_ExecControl
+ */
+#define WM8958_DSP2_STOPC                       0x0020  /* DSP2_STOPC */
+#define WM8958_DSP2_STOPC_MASK                  0x0020  /* DSP2_STOPC */
+#define WM8958_DSP2_STOPC_SHIFT                      5  /* DSP2_STOPC */
+#define WM8958_DSP2_STOPC_WIDTH                      1  /* DSP2_STOPC */
+#define WM8958_DSP2_STOPS                       0x0010  /* DSP2_STOPS */
+#define WM8958_DSP2_STOPS_MASK                  0x0010  /* DSP2_STOPS */
+#define WM8958_DSP2_STOPS_SHIFT                      4  /* DSP2_STOPS */
+#define WM8958_DSP2_STOPS_WIDTH                      1  /* DSP2_STOPS */
+#define WM8958_DSP2_STOPI                       0x0008  /* DSP2_STOPI */
+#define WM8958_DSP2_STOPI_MASK                  0x0008  /* DSP2_STOPI */
+#define WM8958_DSP2_STOPI_SHIFT                      3  /* DSP2_STOPI */
+#define WM8958_DSP2_STOPI_WIDTH                      1  /* DSP2_STOPI */
+#define WM8958_DSP2_STOP                        0x0004  /* DSP2_STOP */
+#define WM8958_DSP2_STOP_MASK                   0x0004  /* DSP2_STOP */
+#define WM8958_DSP2_STOP_SHIFT                       2  /* DSP2_STOP */
+#define WM8958_DSP2_STOP_WIDTH                       1  /* DSP2_STOP */
+#define WM8958_DSP2_RUNR                        0x0002  /* DSP2_RUNR */
+#define WM8958_DSP2_RUNR_MASK                   0x0002  /* DSP2_RUNR */
+#define WM8958_DSP2_RUNR_SHIFT                       1  /* DSP2_RUNR */
+#define WM8958_DSP2_RUNR_WIDTH                       1  /* DSP2_RUNR */
+#define WM8958_DSP2_RUN                         0x0001  /* DSP2_RUN */
+#define WM8958_DSP2_RUN_MASK                    0x0001  /* DSP2_RUN */
+#define WM8958_DSP2_RUN_SHIFT                        0  /* DSP2_RUN */
+#define WM8958_DSP2_RUN_WIDTH                        1  /* DSP2_RUN */
+
 #endif
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index fb06093..b30b2dd 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -80,6 +80,8 @@ struct wm8994_priv {
 	int dac_rates[2];
 	int lrclk_shared[2];
 
+	int mbc_ena[3];
+
 	/* Platform dependant DRC configuration */
 	const char **drc_texts;
 	int drc_cfg[WM8994_NUM_DRC];
@@ -137,6 +139,7 @@ static int wm8994_volatile(unsigned int reg)
 	case WM8994_RATE_STATUS:
 	case WM8994_LDO_1:
 	case WM8994_LDO_2:
+	case WM8958_DSP2_EXECCONTROL:
 		return 1;
 	default:
 		return 0;
@@ -520,6 +523,168 @@ static const struct soc_enum aif2dacl_src =
 static const struct soc_enum aif2dacr_src =
 	SOC_ENUM_SINGLE(WM8994_AIF2_CONTROL_2, 14, 2, aif_chan_src_text);
 
+static void wm8958_mbc_apply(struct snd_soc_codec *codec, int mbc, int start)
+{
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	int pwr_reg = snd_soc_read(codec, WM8994_POWER_MANAGEMENT_5);
+	int ena, reg, aif;
+
+	switch (mbc) {
+	case 0:
+		pwr_reg &= (WM8994_AIF1DAC1L_ENA | WM8994_AIF1DAC1R_ENA);
+		aif = 0;
+		break;
+	case 1:
+		pwr_reg &= (WM8994_AIF1DAC2L_ENA | WM8994_AIF1DAC2R_ENA);
+		aif = 0;
+		break;
+	case 2:
+		pwr_reg &= (WM8994_AIF2DACL_ENA | WM8994_AIF2DACR_ENA);
+		aif = 1;
+		break;
+	default:
+		BUG();
+		return;
+	}
+
+	/* We can only enable the MBC if the AIF is enabled and we
+	 * want it to be enabled. */
+	ena = pwr_reg && wm8994->mbc_ena[mbc];
+
+	reg = snd_soc_read(codec, WM8958_DSP2_PROGRAM);
+
+	dev_dbg(codec->dev, "MBC %d startup: %d, power: %x, DSP: %x\n",
+		mbc, start, pwr_reg, reg);
+
+	if (start && ena) {
+		/* If the DSP is already running then noop */
+		if (reg & WM8958_DSP2_ENA)
+			return;
+
+		/* Switch the clock over to the appropriate AIF */
+		snd_soc_update_bits(codec, WM8994_CLOCKING_1,
+				    WM8958_DSP2CLK_SRC | WM8958_DSP2CLK_ENA,
+				    aif << WM8958_DSP2CLK_SRC_SHIFT |
+				    WM8958_DSP2CLK_ENA);
+
+		snd_soc_update_bits(codec, WM8958_DSP2_PROGRAM,
+				    WM8958_DSP2_ENA, WM8958_DSP2_ENA);
+
+		/* TODO: Apply any user specified MBC settings */
+
+		/* Run the DSP */
+		snd_soc_write(codec, WM8958_DSP2_EXECCONTROL,
+			      WM8958_DSP2_RUNR);
+
+		/* And we're off! */
+		snd_soc_update_bits(codec, WM8958_DSP2_CONFIG,
+				    WM8958_MBC_ENA | WM8958_MBC_SEL_MASK,
+				    mbc << WM8958_MBC_SEL_SHIFT |
+				    WM8958_MBC_ENA);
+	} else {
+		/* If the DSP is already stopped then noop */
+		if (!(reg & WM8958_DSP2_ENA))
+			return;
+
+		snd_soc_update_bits(codec, WM8958_DSP2_CONFIG,
+				    WM8958_MBC_ENA, 0);	
+		snd_soc_update_bits(codec, WM8958_DSP2_PROGRAM,
+				    WM8958_DSP2_ENA, 0);
+		snd_soc_update_bits(codec, WM8994_CLOCKING_1,
+				    WM8958_DSP2CLK_ENA, 0);
+	}
+}
+
+static int wm8958_aif_ev(struct snd_soc_dapm_widget *w,
+		    struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	int mbc;
+
+	switch (w->shift) {
+	case 13:
+	case 12:
+		mbc = 2;
+		break;
+	case 11:
+	case 10:
+		mbc = 1;
+		break;
+	case 9:
+	case 8:
+		mbc = 0;
+		break;
+	default:
+		BUG();
+		return -EINVAL;
+	}
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		wm8958_mbc_apply(codec, mbc, 1);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		wm8958_mbc_apply(codec, mbc, 0);
+		break;
+	}
+
+	return 0;
+}
+
+static int wm8958_mbc_info(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int wm8958_mbc_get(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	int mbc = kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = wm8994->mbc_ena[mbc];
+
+	return 0;
+}
+
+static int wm8958_mbc_put(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	int mbc = kcontrol->private_value;
+	int i;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	if (ucontrol->value.integer.value[0] > 1)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(wm8994->mbc_ena); i++) {
+		if (mbc != i && wm8994->mbc_ena[i]) {
+			dev_dbg(codec->dev, "MBC %d active already\n", mbc);
+			return -EBUSY;
+		}
+	}
+
+	wm8994->mbc_ena[mbc] = ucontrol->value.integer.value[0];
+
+	wm8958_mbc_apply(codec, mbc, wm8994->mbc_ena[mbc]);
+
+	return 0;
+}
+
+#define WM8958_MBC_SWITCH(xname, xval) {\
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.info = wm8958_mbc_info, \
+	.get = wm8958_mbc_get, .put = wm8958_mbc_put, \
+	.private_value = xval }
+
 static const struct snd_kcontrol_new wm8994_snd_controls[] = {
 SOC_DOUBLE_R_TLV("AIF1ADC1 Volume", WM8994_AIF1_ADC1_LEFT_VOLUME,
 		 WM8994_AIF1_ADC1_RIGHT_VOLUME,
@@ -649,6 +814,9 @@ SOC_SINGLE_TLV("AIF2 EQ5 Volume", WM8994_AIF2_EQ_GAINS_2, 6, 31, 0,
 
 static const struct snd_kcontrol_new wm8958_snd_controls[] = {
 SOC_SINGLE_TLV("AIF3 Boost Volume", WM8958_AIF3_CONTROL_2, 10, 3, 0, aif_tlv),
+WM8958_MBC_SWITCH("AIF1DAC1 MBC Switch", 0),
+WM8958_MBC_SWITCH("AIF1DAC2 MBC Switch", 1),
+WM8958_MBC_SWITCH("AIF2DAC MBC Switch", 2),
 };
 
 static int clk_sys_event(struct snd_soc_dapm_widget *w,
@@ -1018,19 +1186,23 @@ SND_SOC_DAPM_AIF_OUT("AIF1ADC1L", "AIF1 Capture",
 		     0, WM8994_POWER_MANAGEMENT_4, 9, 0),
 SND_SOC_DAPM_AIF_OUT("AIF1ADC1R", "AIF1 Capture",
 		     0, WM8994_POWER_MANAGEMENT_4, 8, 0),
-SND_SOC_DAPM_AIF_IN("AIF1DAC1L", NULL, 0,
-		    WM8994_POWER_MANAGEMENT_5, 9, 0),
-SND_SOC_DAPM_AIF_IN("AIF1DAC1R", NULL, 0,
-		    WM8994_POWER_MANAGEMENT_5, 8, 0),
+SND_SOC_DAPM_AIF_IN_E("AIF1DAC1L", NULL, 0,
+		      WM8994_POWER_MANAGEMENT_5, 9, 0, wm8958_aif_ev,
+		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_AIF_IN_E("AIF1DAC1R", NULL, 0,
+		      WM8994_POWER_MANAGEMENT_5, 8, 0, wm8958_aif_ev,
+		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 
 SND_SOC_DAPM_AIF_OUT("AIF1ADC2L", "AIF1 Capture",
 		     0, WM8994_POWER_MANAGEMENT_4, 11, 0),
 SND_SOC_DAPM_AIF_OUT("AIF1ADC2R", "AIF1 Capture",
 		     0, WM8994_POWER_MANAGEMENT_4, 10, 0),
-SND_SOC_DAPM_AIF_IN("AIF1DAC2L", NULL, 0,
-		    WM8994_POWER_MANAGEMENT_5, 11, 0),
-SND_SOC_DAPM_AIF_IN("AIF1DAC2R", NULL, 0,
-		    WM8994_POWER_MANAGEMENT_5, 10, 0),
+SND_SOC_DAPM_AIF_IN_E("AIF1DAC2L", NULL, 0,
+		      WM8994_POWER_MANAGEMENT_5, 11, 0, wm8958_aif_ev,
+		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_AIF_IN_E("AIF1DAC2R", NULL, 0,
+		      WM8994_POWER_MANAGEMENT_5, 10, 0, wm8958_aif_ev,
+		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 
 SND_SOC_DAPM_MIXER("AIF1ADC1L Mixer", SND_SOC_NOPM, 0, 0,
 		   aif1adc1l_mix, ARRAY_SIZE(aif1adc1l_mix)),
@@ -1059,10 +1231,12 @@ SND_SOC_DAPM_AIF_OUT("AIF2ADCL", NULL, 0,
 		     WM8994_POWER_MANAGEMENT_4, 13, 0),
 SND_SOC_DAPM_AIF_OUT("AIF2ADCR", NULL, 0,
 		     WM8994_POWER_MANAGEMENT_4, 12, 0),
-SND_SOC_DAPM_AIF_IN("AIF2DACL", NULL, 0,
-		    WM8994_POWER_MANAGEMENT_5, 13, 0),
-SND_SOC_DAPM_AIF_IN("AIF2DACR", NULL, 0,
-		    WM8994_POWER_MANAGEMENT_5, 12, 0),
+SND_SOC_DAPM_AIF_IN_E("AIF2DACL", NULL, 0,
+		      WM8994_POWER_MANAGEMENT_5, 13, 0, wm8958_aif_ev,
+		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_AIF_IN_E("AIF2DACR", NULL, 0,
+		      WM8994_POWER_MANAGEMENT_5, 12, 0, wm8958_aif_ev,
+		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 
 SND_SOC_DAPM_AIF_IN("AIF1DACDAT", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
 SND_SOC_DAPM_AIF_IN("AIF2DACDAT", "AIF2 Playback", 0, SND_SOC_NOPM, 0, 0),
-- 
1.7.1
