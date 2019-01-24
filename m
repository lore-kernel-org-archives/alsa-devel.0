From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ASoC: intel: cht_bsw_max98090_ti: Enable codec
	clock once and keep it enabled
Date: Thu, 24 Jan 2019 11:34:25 +0100
Message-ID: <20190124103425.22214-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 2897A26756F
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2019 11:34:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Dean Wallace <duffydack73@gmail.com>, Mogens Jensen <mogens-jensen@protonmail.com>
List-Id: alsa-devel@alsa-project.org

Users have been seeing sound stability issues with max98090 codecs since:
commit 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")

At first that commit broke sound for Chromebook Swanky and Clapper models,
the problem was that the machine-driver has been controlling the wrong
clock on those models since support for them was added. This was hidden by
clk-pmc-atom.c keeping the actual clk on unconditionally.

With the machine-driver controlling the proper clock, sound works again
but we are seeing bug reports describing it as: low volume,
"sounds like played at 10x speed" and instable.

When these issues are hit the following message is seen in dmesg:
"max98090 i2c-193C9890:00: PLL unlocked".

Attempts have been made to fix this by inserting a delay between enabling
the clk and enabling and checking the pll, but this has not helped.

It seems that if we ever disable the clk, the pll looses its lock and
then we get various issues.

This commit fixes this by enabling the clock once at probe time,
in essence restoring the old behavior of clk-pmc-atom.c always keeping
the clk on, but then only on machines with a max98090 codec.

Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Reported-and-tested-by: Mogens Jensen <mogens-jensen@protonmail.com>
Reported-and-tested-by: Dean Wallace <duffydack73@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 75 ++++++--------------
 1 file changed, 20 insertions(+), 55 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 08a5152e635a..549d6ce12ec4 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -44,43 +44,11 @@ struct cht_mc_private {
 	bool ts3a227e_present;
 };
 
-static int platform_clock_control(struct snd_soc_dapm_widget *w,
-					  struct snd_kcontrol *k, int  event)
-{
-	struct snd_soc_dapm_context *dapm = w->dapm;
-	struct snd_soc_card *card = dapm->card;
-	struct snd_soc_dai *codec_dai;
-	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
-	int ret;
-
-	codec_dai = snd_soc_card_get_codec_dai(card, CHT_CODEC_DAI);
-	if (!codec_dai) {
-		dev_err(card->dev, "Codec dai not found; Unable to set platform clock\n");
-		return -EIO;
-	}
-
-	if (SND_SOC_DAPM_EVENT_ON(event)) {
-		ret = clk_prepare_enable(ctx->mclk);
-		if (ret < 0) {
-			dev_err(card->dev,
-				"could not configure MCLK state");
-			return ret;
-		}
-	} else {
-		clk_disable_unprepare(ctx->mclk);
-	}
-
-	return 0;
-}
-
 static const struct snd_soc_dapm_widget cht_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
 	SND_SOC_DAPM_SPK("Ext Spk", NULL),
-	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
-			    platform_clock_control, SND_SOC_DAPM_PRE_PMU |
-			    SND_SOC_DAPM_POST_PMD),
 };
 
 static const struct snd_soc_dapm_route cht_audio_map[] = {
@@ -97,10 +65,6 @@ static const struct snd_soc_dapm_route cht_audio_map[] = {
 	{"codec_in0", NULL, "ssp2 Rx" },
 	{"codec_in1", NULL, "ssp2 Rx" },
 	{"ssp2 Rx", NULL, "HiFi Capture"},
-	{"Headphone", NULL, "Platform Clock"},
-	{"Headset Mic", NULL, "Platform Clock"},
-	{"Int Mic", NULL, "Platform Clock"},
-	{"Ext Spk", NULL, "Platform Clock"},
 };
 
 static const struct snd_kcontrol_new cht_mc_controls[] = {
@@ -222,25 +186,6 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 			"jack detection gpios not added, error %d\n", ret);
 	}
 
-	/*
-	 * The firmware might enable the clock at
-	 * boot (this information may or may not
-	 * be reflected in the enable clock register).
-	 * To change the rate we must disable the clock
-	 * first to cover these cases. Due to common
-	 * clock framework restrictions that do not allow
-	 * to disable a clock that has not been enabled,
-	 * we need to enable the clock first.
-	 */
-	ret = clk_prepare_enable(ctx->mclk);
-	if (!ret)
-		clk_disable_unprepare(ctx->mclk);
-
-	ret = clk_set_rate(ctx->mclk, CHT_PLAT_CLK_3_HZ);
-
-	if (ret)
-		dev_err(runtime->dev, "unable to set MCLK rate\n");
-
 	return ret;
 }
 
@@ -459,6 +404,16 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		return PTR_ERR(drv->mclk);
 	}
 
+	/*
+	 * The MAX98090 does not seem to like it if we muck with its clock,
+	 * so we enable it here once and leave it at that.
+	 */
+	ret_val = clk_prepare_enable(drv->mclk);
+	if (ret_val < 0) {
+		dev_err(&pdev->dev, "Failed to enable MCLK: %d\n", ret_val);
+		return ret_val;
+	}
+
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_cht);
 	if (ret_val) {
 		dev_err(&pdev->dev,
@@ -469,11 +424,21 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	return ret_val;
 }
 
+static int snd_cht_mc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
+
+	clk_disable_unprepare(ctx->mclk);
+	return 0;
+}
+
 static struct platform_driver snd_cht_mc_driver = {
 	.driver = {
 		.name = "cht-bsw-max98090",
 	},
 	.probe = snd_cht_mc_probe,
+	.remove = snd_cht_mc_remove,
 };
 
 module_platform_driver(snd_cht_mc_driver)
-- 
2.20.1
