From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Move setting of DSP speed into
	CODEC specific code" to the asoc tree
Date: Fri, 29 Jan 2016 01:16:39 +0100
Message-ID: <E1aOwjv-0005XQ-Ne@finisterre>
References: <1453398782-32198-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 206F72614CB
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2016 01:16:53 +0100 (CET)
In-Reply-To: <1453398782-32198-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Move setting of DSP speed into CODEC specific code

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d82d767f0e61da5f1f872d40358904eb316af264 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Thu, 21 Jan 2016 17:53:02 +0000
Subject: [PATCH] ASoC: wm_adsp: Move setting of DSP speed into CODEC specific
 code

The ADSP code should be agnostic of which CODEC it runs upon, currently
there is only one remaining part of the implementation that doesn't
follow this. When the DSP is booted on ADSP2 we read
ARIZONA_SYSTEM_CLOCK_1 and use that to set the initial speed for the DSP
clock. This patch factors that out into CODEC specific code, leaving the
ADSP code entirely CODEC agnostic.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs47l24.c | 23 +++++++++++++++++++++--
 sound/soc/codecs/wm5102.c  |  6 +++---
 sound/soc/codecs/wm5110.c  | 27 +++++++++++++++++++++++----
 sound/soc/codecs/wm_adsp.c | 40 +++++++++++++++-------------------------
 sound/soc/codecs/wm_adsp.h |  8 +++-----
 5 files changed, 65 insertions(+), 39 deletions(-)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index dc5ae7f..9dc77a4 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -57,6 +57,25 @@ static const struct wm_adsp_region *cs47l24_dsp_regions[] = {
 	cs47l24_dsp3_regions,
 };
 
+static int cs47l24_adsp_power_ev(struct snd_soc_dapm_widget *w,
+				 struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
+	unsigned int v;
+	int ret;
+
+	ret = regmap_read(arizona->regmap, ARIZONA_SYSTEM_CLOCK_1, &v);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to read SYSCLK state: %d\n", ret);
+		return ret;
+	}
+
+	v = (v & ARIZONA_SYSCLK_FREQ_MASK) >> ARIZONA_SYSCLK_FREQ_SHIFT;
+
+	return wm_adsp2_early_event(w, kcontrol, event, v);
+}
+
 static DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
 static DECLARE_TLV_DB_SCALE(digital_tlv, -6400, 50, 0);
 static DECLARE_TLV_DB_SCALE(noise_tlv, -13200, 600, 0);
@@ -405,8 +424,8 @@ SND_SOC_DAPM_PGA("ASRC2L", ARIZONA_ASRC_ENABLE, ARIZONA_ASRC2L_ENA_SHIFT, 0,
 SND_SOC_DAPM_PGA("ASRC2R", ARIZONA_ASRC_ENABLE, ARIZONA_ASRC2R_ENA_SHIFT, 0,
 		 NULL, 0),
 
-WM_ADSP2("DSP2", 1),
-WM_ADSP2("DSP3", 2),
+WM_ADSP2("DSP2", 1, cs47l24_adsp_power_ev),
+WM_ADSP2("DSP3", 2, cs47l24_adsp_power_ev),
 
 SND_SOC_DAPM_PGA("ISRC1INT1", ARIZONA_ISRC_1_CTRL_3,
 		 ARIZONA_ISRC1_INT0_ENA_SHIFT, 0, NULL, 0),
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 64637d1..7c0860d 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -619,7 +619,7 @@ static int wm5102_adsp_power_ev(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
-	unsigned int v;
+	unsigned int v = 0;
 	int ret;
 
 	switch (event) {
@@ -654,7 +654,7 @@ static int wm5102_adsp_power_ev(struct snd_soc_dapm_widget *w,
 		break;
 	}
 
-	return wm_adsp2_early_event(w, kcontrol, event);
+	return wm_adsp2_early_event(w, kcontrol, event, v);
 }
 
 static int wm5102_out_comp_coeff_get(struct snd_kcontrol *kcontrol,
@@ -1408,7 +1408,7 @@ ARIZONA_MUX_WIDGETS(ISRC2DEC2, "ISRC2DEC2"),
 ARIZONA_MUX_WIDGETS(ISRC2INT1, "ISRC2INT1"),
 ARIZONA_MUX_WIDGETS(ISRC2INT2, "ISRC2INT2"),
 
-WM_ADSP2_E("DSP1", 0, wm5102_adsp_power_ev),
+WM_ADSP2("DSP1", 0, wm5102_adsp_power_ev),
 
 SND_SOC_DAPM_OUTPUT("HPOUT1L"),
 SND_SOC_DAPM_OUTPUT("HPOUT1R"),
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 83760b7..b47bc44 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -191,6 +191,25 @@ static int wm5110_sysclk_ev(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int wm5110_adsp_power_ev(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
+	unsigned int v;
+	int ret;
+
+	ret = regmap_read(arizona->regmap, ARIZONA_SYSTEM_CLOCK_1, &v);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to read SYSCLK state: %d\n", ret);
+		return ret;
+	}
+
+	v = (v & ARIZONA_SYSCLK_FREQ_MASK) >> ARIZONA_SYSCLK_FREQ_SHIFT;
+
+	return wm_adsp2_early_event(w, kcontrol, event, v);
+}
+
 static const struct reg_sequence wm5110_no_dre_left_enable[] = {
 	{ 0x3024, 0xE410 },
 	{ 0x3025, 0x0056 },
@@ -1179,10 +1198,10 @@ SND_SOC_DAPM_PGA("ASRC2L", ARIZONA_ASRC_ENABLE, ARIZONA_ASRC2L_ENA_SHIFT, 0,
 SND_SOC_DAPM_PGA("ASRC2R", ARIZONA_ASRC_ENABLE, ARIZONA_ASRC2R_ENA_SHIFT, 0,
 		 NULL, 0),
 
-WM_ADSP2("DSP1", 0),
-WM_ADSP2("DSP2", 1),
-WM_ADSP2("DSP3", 2),
-WM_ADSP2("DSP4", 3),
+WM_ADSP2("DSP1", 0, wm5110_adsp_power_ev),
+WM_ADSP2("DSP2", 1, wm5110_adsp_power_ev),
+WM_ADSP2("DSP3", 2, wm5110_adsp_power_ev),
+WM_ADSP2("DSP4", 3, wm5110_adsp_power_ev),
 
 SND_SOC_DAPM_PGA("ISRC1INT1", ARIZONA_ISRC_1_CTRL_3,
 		 ARIZONA_ISRC1_INT0_ENA_SHIFT, 0, NULL, 0),
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index a81f568..76ab52d 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -32,9 +32,6 @@
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
-#include <linux/mfd/arizona/registers.h>
-
-#include "arizona.h"
 #include "wm_adsp.h"
 
 #define adsp_crit(_dsp, fmt, ...) \
@@ -2146,30 +2143,9 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 					   struct wm_adsp,
 					   boot_work);
 	int ret;
-	unsigned int val;
 
 	mutex_lock(&dsp->pwr_lock);
 
-	/*
-	 * For simplicity set the DSP clock rate to be the
-	 * SYSCLK rate rather than making it configurable.
-	 */
-	ret = regmap_read(dsp->regmap, ARIZONA_SYSTEM_CLOCK_1, &val);
-	if (ret != 0) {
-		adsp_err(dsp, "Failed to read SYSCLK state: %d\n", ret);
-		goto err_mutex;
-	}
-	val = (val & ARIZONA_SYSCLK_FREQ_MASK)
-		>> ARIZONA_SYSCLK_FREQ_SHIFT;
-
-	ret = regmap_update_bits_async(dsp->regmap,
-				       dsp->base + ADSP2_CLOCKING,
-				       ADSP2_CLK_SEL_MASK, val);
-	if (ret != 0) {
-		adsp_err(dsp, "Failed to set clock rate: %d\n", ret);
-		goto err_mutex;
-	}
-
 	ret = wm_adsp2_ena(dsp);
 	if (ret != 0)
 		goto err_mutex;
@@ -2209,8 +2185,21 @@ err_mutex:
 	mutex_unlock(&dsp->pwr_lock);
 }
 
+static void wm_adsp2_set_dspclk(struct wm_adsp *dsp, unsigned int freq)
+{
+	int ret;
+
+	ret = regmap_update_bits_async(dsp->regmap,
+				       dsp->base + ADSP2_CLOCKING,
+				       ADSP2_CLK_SEL_MASK,
+				       freq << ADSP2_CLK_SEL_SHIFT);
+	if (ret != 0)
+		adsp_err(dsp, "Failed to set clock rate: %d\n", ret);
+}
+
 int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
-		   struct snd_kcontrol *kcontrol, int event)
+			 struct snd_kcontrol *kcontrol, int event,
+			 unsigned int freq)
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
@@ -2220,6 +2209,7 @@ int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
+		wm_adsp2_set_dspclk(dsp, freq);
 		queue_work(system_unbound_wq, &dsp->boot_work);
 		break;
 	default:
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 1a928ec..b61cb57 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -80,7 +80,7 @@ struct wm_adsp {
 	SND_SOC_DAPM_PGA_E(wname, SND_SOC_NOPM, num, 0, NULL, 0, \
 		wm_adsp1_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD)
 
-#define WM_ADSP2_E(wname, num, event_fn) \
+#define WM_ADSP2(wname, num, event_fn) \
 {	.id = snd_soc_dapm_dai_link, .name = wname " Preloader", \
 	.reg = SND_SOC_NOPM, .shift = num, .event = event_fn, \
 	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD }, \
@@ -88,9 +88,6 @@ struct wm_adsp {
 	.reg = SND_SOC_NOPM, .shift = num, .event = wm_adsp2_event, \
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD }
 
-#define WM_ADSP2(wname, num) \
-	WM_ADSP2_E(wname, num, wm_adsp2_early_event)
-
 extern const struct snd_kcontrol_new wm_adsp_fw_controls[];
 
 int wm_adsp1_init(struct wm_adsp *dsp);
@@ -100,7 +97,8 @@ int wm_adsp2_codec_remove(struct wm_adsp *dsp, struct snd_soc_codec *codec);
 int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
 int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
-			 struct snd_kcontrol *kcontrol, int event);
+			 struct snd_kcontrol *kcontrol, int event,
+			 unsigned int freq);
 int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
 
-- 
2.6.4
