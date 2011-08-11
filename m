From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Disable WM8994 VMID for digital only
	paths
Date: Thu, 11 Aug 2011 10:57:20 +0900
Message-ID: <1313027840-11894-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1313027840-11894-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E541324427
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 04:10:12 +0200 (CEST)
In-Reply-To: <1313027840-11894-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On WM8994 class devices only the analogue portions of the CODEC require
VMID so when running digital only paths we can leave VMID disabled.
On some earlier devices the FLL uses VMID so we don't use DAPM reference
counting alone, we maintain an internal reference count which is also
enabled and disabled by the FLL startup.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |  182 +++++++++++++++++++++++++++++++--------------
 sound/soc/codecs/wm8994.h |    2 +
 2 files changed, 128 insertions(+), 56 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 2fb3807..e1fb844 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -644,6 +644,97 @@ static int clk_sys_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static void vmid_reference(struct snd_soc_codec *codec)
+{
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	wm8994->vmid_refcount++;
+
+	dev_dbg(codec->dev, "Referencing VMID, refcount is now %d\n",
+		wm8994->vmid_refcount);
+
+	if (wm8994->vmid_refcount == 1) {
+		/* Startup bias, VMID ramp & buffer */
+		snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+				    WM8994_STARTUP_BIAS_ENA |
+				    WM8994_VMID_BUF_ENA |
+				    WM8994_VMID_RAMP_MASK,
+				    WM8994_STARTUP_BIAS_ENA |
+				    WM8994_VMID_BUF_ENA |
+				    (0x11 << WM8994_VMID_RAMP_SHIFT));
+
+		/* Main bias enable, VMID=2x40k */
+		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
+				    WM8994_BIAS_ENA |
+				    WM8994_VMID_SEL_MASK,
+				    WM8994_BIAS_ENA | 0x2);
+
+		msleep(20);
+	}
+}
+
+static void vmid_dereference(struct snd_soc_codec *codec)
+{
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	wm8994->vmid_refcount--;
+
+	dev_dbg(codec->dev, "Dereferencing VMID, refcount is now %d\n",
+		wm8994->vmid_refcount);
+
+	if (wm8994->vmid_refcount == 0) {
+		/* Switch over to startup biases */
+		snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+				    WM8994_BIAS_SRC |
+				    WM8994_STARTUP_BIAS_ENA |
+				    WM8994_VMID_BUF_ENA |
+				    WM8994_VMID_RAMP_MASK,
+				    WM8994_BIAS_SRC |
+				    WM8994_STARTUP_BIAS_ENA |
+				    WM8994_VMID_BUF_ENA |
+				    (1 << WM8994_VMID_RAMP_SHIFT));
+
+		/* Disable main biases */
+		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
+				    WM8994_BIAS_ENA |
+				    WM8994_VMID_SEL_MASK, 0);
+
+		/* Discharge line */
+		snd_soc_update_bits(codec, WM8994_ANTIPOP_1,
+				    WM8994_LINEOUT1_DISCH |
+				    WM8994_LINEOUT2_DISCH,
+				    WM8994_LINEOUT1_DISCH |
+				    WM8994_LINEOUT2_DISCH);
+
+		msleep(5);
+
+		/* Switch off startup biases */
+		snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+				    WM8994_BIAS_SRC |
+				    WM8994_STARTUP_BIAS_ENA |
+				    WM8994_VMID_BUF_ENA |
+				    WM8994_VMID_RAMP_MASK, 0);
+	}
+}
+
+static int vmid_event(struct snd_soc_dapm_widget *w,
+		      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		vmid_reference(codec);
+		break;
+
+	case SND_SOC_DAPM_POST_PMD:
+		vmid_dereference(codec);
+		break;
+	}
+
+	return 0;
+}
+
 static void wm8994_update_class_w(struct snd_soc_codec *codec)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
@@ -1171,7 +1262,8 @@ SND_SOC_DAPM_INPUT("Clock"),
 
 SND_SOC_DAPM_SUPPLY_S("MICBIAS Supply", 1, SND_SOC_NOPM, 0, 0, micbias_ev,
 		      SND_SOC_DAPM_PRE_PMU),
-SND_SOC_DAPM_SUPPLY("VMID", SND_SOC_NOPM, 0, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("VMID", SND_SOC_NOPM, 0, 0, vmid_event,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 
 SND_SOC_DAPM_SUPPLY("CLK_SYS", SND_SOC_NOPM, 0, 0, clk_sys_event,
 		    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
@@ -1599,6 +1691,7 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 	struct fll_div fll;
 	u16 reg, aif1, aif2;
 	unsigned long timeout;
+	bool was_enabled;
 
 	aif1 = snd_soc_read(codec, WM8994_AIF1_CLOCKING_1)
 		& WM8994_AIF1CLK_ENA;
@@ -1619,6 +1712,9 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 		return -EINVAL;
 	}
 
+	reg = snd_soc_read(codec, WM8994_FLL1_CONTROL_1 + reg_offset);
+	was_enabled = reg & WM8994_FLL1_ENA;
+
 	switch (src) {
 	case 0:
 		/* Allow no source specification when stopping */
@@ -1685,6 +1781,21 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 
 	/* Enable (with fractional mode if required) */
 	if (freq_out) {
+		/* Enable VMID if we need it */
+		if (!was_enabled) {
+			switch (wm8994->wm8994->type) {
+			case WM8994:
+				vmid_reference(codec);
+				break;
+			case WM8958:
+				if (wm8994->revision < 1)
+					vmid_reference(codec);
+				break;
+			default:
+				break;
+			}
+		}
+
 		if (fll.k)
 			reg = WM8994_FLL1_ENA | WM8994_FLL1_FRAC;
 		else
@@ -1702,6 +1813,20 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 		} else {
 			msleep(5);
 		}
+	} else {
+		if (was_enabled) {
+			switch (wm8994->wm8994->type) {
+			case WM8994:
+				vmid_dereference(codec);
+				break;
+			case WM8958:
+				if (wm8994->revision < 1)
+					vmid_dereference(codec);
+				break;
+			default:
+				break;
+			}
+		}
 	}
 
 	wm8994->fll[id].in = freq_in;
@@ -1818,9 +1943,6 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
-		/* VMID=2x40k */
-		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
-				    WM8994_VMID_SEL_MASK, 0x2);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
@@ -1865,65 +1987,13 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 					    WM8994_LINEOUT2_DISCH,
 					    WM8994_LINEOUT1_DISCH |
 					    WM8994_LINEOUT2_DISCH);
-
-			/* Startup bias, VMID ramp & buffer */
-			snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
-					    WM8994_STARTUP_BIAS_ENA |
-					    WM8994_VMID_BUF_ENA |
-					    WM8994_VMID_RAMP_MASK,
-					    WM8994_STARTUP_BIAS_ENA |
-					    WM8994_VMID_BUF_ENA |
-					    (0x11 << WM8994_VMID_RAMP_SHIFT));
-
-			/* Main bias enable, VMID=2x40k */
-			snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
-					    WM8994_BIAS_ENA |
-					    WM8994_VMID_SEL_MASK,
-					    WM8994_BIAS_ENA | 0x2);
-
-			msleep(20);
 		}
 
-		/* VMID=2x500k */
-		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
-				    WM8994_VMID_SEL_MASK, 0x4);
 
 		break;
 
 	case SND_SOC_BIAS_OFF:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY) {
-			/* Switch over to startup biases */
-			snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
-					    WM8994_BIAS_SRC |
-					    WM8994_STARTUP_BIAS_ENA |
-					    WM8994_VMID_BUF_ENA |
-					    WM8994_VMID_RAMP_MASK,
-					    WM8994_BIAS_SRC |
-					    WM8994_STARTUP_BIAS_ENA |
-					    WM8994_VMID_BUF_ENA |
-					    (1 << WM8994_VMID_RAMP_SHIFT));
-
-			/* Disable main biases */
-			snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
-					    WM8994_BIAS_ENA |
-					    WM8994_VMID_SEL_MASK, 0);
-
-			/* Discharge line */
-			snd_soc_update_bits(codec, WM8994_ANTIPOP_1,
-					    WM8994_LINEOUT1_DISCH |
-					    WM8994_LINEOUT2_DISCH,
-					    WM8994_LINEOUT1_DISCH |
-					    WM8994_LINEOUT2_DISCH);
-
-			msleep(5);
-
-			/* Switch off startup biases */
-			snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
-					    WM8994_BIAS_SRC |
-					    WM8994_STARTUP_BIAS_ENA |
-					    WM8994_VMID_BUF_ENA |
-					    WM8994_VMID_RAMP_MASK, 0);
-
 			wm8994->cur_fw = NULL;
 
 			pm_runtime_put(codec->dev);
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index 1ce9355..09538f6 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -84,6 +84,8 @@ struct wm8994_priv {
 	struct completion fll_locked[2];
 	bool fll_locked_irq;
 
+	int vmid_refcount;
+
 	int dac_rates[2];
 	int lrclk_shared[2];
 
-- 
1.7.5.4
