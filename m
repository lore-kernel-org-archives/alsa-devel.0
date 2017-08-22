From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 02/14] ASoC: intel: cht_bsw_max98090: add
	support for clock framework
Date: Tue, 22 Aug 2017 15:32:27 -0500
Message-ID: <20170822203239.19891-3-pierre-louis.bossart@linux.intel.com>
References: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 660FA267041
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 22:33:10 +0200 (CEST)
In-Reply-To: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Add MCLK management to reuse this driver for platforms where
the firmware does not manage the MCLK. This should solve
issues with distributions unable to support Chromebooks as well
as atom/sst platforms.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 101 +++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 20755ec..fc4c381 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -23,6 +23,9 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <asm/cpu_device_id.h>
+#include <asm/platform_sst_audio.h>
+#include <linux/clk.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -37,13 +40,64 @@
 struct cht_mc_private {
 	struct snd_soc_jack jack;
 	bool ts3a227e_present;
+	struct clk *mclk;
 };
 
+static inline struct snd_soc_dai *cht_get_codec_dai(struct snd_soc_card *card)
+{
+	struct snd_soc_pcm_runtime *rtd;
+
+	list_for_each_entry(rtd, &card->rtd_list, list) {
+		if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI,
+			     strlen(CHT_CODEC_DAI)))
+			return rtd->codec_dai;
+	}
+	return NULL;
+}
+
+static int platform_clock_control(struct snd_soc_dapm_widget *w,
+					  struct snd_kcontrol *k, int  event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_card *card = dapm->card;
+	struct snd_soc_dai *codec_dai;
+	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
+	int ret;
+
+	codec_dai = cht_get_codec_dai(card);
+	if (!codec_dai) {
+		dev_err(card->dev, "Codec dai not found; Unable to set platform clock\n");
+		return -EIO;
+	}
+
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		if (ctx->mclk) {
+			ret = clk_prepare_enable(ctx->mclk);
+			if (ret < 0) {
+				dev_err(card->dev,
+					"could not configure MCLK state");
+				return ret;
+			}
+		}
+	} else {
+
+		/* FIXME: if there is no clock can jack detection work ? */
+
+		if (ctx->mclk)
+			clk_disable_unprepare(ctx->mclk);
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget cht_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
 	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
+			    platform_clock_control, SND_SOC_DAPM_PRE_PMU |
+			    SND_SOC_DAPM_POST_PMD),
 };
 
 static const struct snd_soc_dapm_route cht_audio_map[] = {
@@ -60,6 +114,10 @@ static const struct snd_soc_dapm_route cht_audio_map[] = {
 	{"codec_in0", NULL, "ssp2 Rx" },
 	{"codec_in1", NULL, "ssp2 Rx" },
 	{"ssp2 Rx", NULL, "HiFi Capture"},
+	{"Headphone", NULL, "Platform Clock"},
+	{"Headset Mic", NULL, "Platform Clock"},
+	{"Int Mic", NULL, "Platform Clock"},
+	{"Ext Spk", NULL, "Platform Clock"},
 };
 
 static const struct snd_kcontrol_new cht_mc_controls[] = {
@@ -141,6 +199,26 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	if (ctx->ts3a227e_present)
 		snd_soc_jack_notifier_register(jack, &cht_jack_nb);
 
+	if (ctx->mclk) {
+		/*
+		 * The firmware might enable the clock at
+		 * boot (this information may or may not
+		 * be reflected in the enable clock register).
+		 * To change the rate we must disable the clock
+		 * first to cover these cases. Due to common
+		 * clock framework restrictions that do not allow
+		 * to disable a clock that has not been enabled,
+		 * we need to enable the clock first.
+		 */
+		ret = clk_prepare_enable(ctx->mclk);
+		if (!ret)
+			clk_disable_unprepare(ctx->mclk);
+
+		ret = clk_set_rate(ctx->mclk, CHT_PLAT_CLK_3_HZ);
+
+		if (ret)
+			dev_err(runtime->dev, "unable to set MCLK rate\n");
+	}
 	return ret;
 }
 
@@ -275,6 +353,18 @@ static struct snd_soc_card snd_soc_card_cht = {
 	.num_controls = ARRAY_SIZE(cht_mc_controls),
 };
 
+static bool is_valleyview(void)
+{
+	static const struct x86_cpu_id cpu_ids[] = {
+		{ X86_VENDOR_INTEL, 6, 55 }, /* Valleyview, Bay Trail */
+		{}
+	};
+
+	if (!x86_match_cpu(cpu_ids))
+		return false;
+	return true;
+}
+
 static int snd_cht_mc_probe(struct platform_device *pdev)
 {
 	int ret_val = 0;
@@ -294,6 +384,17 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	/* register the soc card */
 	snd_soc_card_cht.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&snd_soc_card_cht, drv);
+
+	if (is_valleyview()) {
+		drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
+		if (IS_ERR(drv->mclk)) {
+			dev_err(&pdev->dev,
+				"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
+				PTR_ERR(drv->mclk));
+			return PTR_ERR(drv->mclk);
+		}
+	}
+
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_cht);
 	if (ret_val) {
 		dev_err(&pdev->dev,
-- 
2.9.3
