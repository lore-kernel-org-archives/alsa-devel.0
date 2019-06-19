From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sof-rt5682: add MCLK support for
	BYT platform" to the asoc tree
Date: Wed, 19 Jun 2019 13:12:04 +0100 (BST)
Message-ID: <20190619121204.CD5D244004A@finisterre.sirena.org.uk>
References: <20190618181539.9169-1-yung-chuan.liao@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1E202F896C7
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 14:12:10 +0200 (CEST)
In-Reply-To: <20190618181539.9169-1-yung-chuan.liao@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Xun Zhang <xun2.zhang@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, Mark Brown <broonie@kernel.org>, Bard liao <yung-chuan.liao@linux.intel.com>, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: sof-rt5682: add MCLK support for BYT platform

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 1eed6bc03f5409f0367780d4045bf3036e51b7ee Mon Sep 17 00:00:00 2001
From: Xun Zhang <xun2.zhang@intel.com>
Date: Wed, 19 Jun 2019 02:15:38 +0800
Subject: [PATCH] ASoC: Intel: sof-rt5682: add MCLK support for BYT platform

The sof-rt5682 machine driver currently uses BCLK on BYT/Minnowboard
platform. The MCLK signal is available since the Turbot revision, so
enable MCLK on BYT/Minnowboard Turbot platform.

Signed-off-by: Xun Zhang <xun2.zhang@intel.com>
Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/sof_rt5682.c | 65 ++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index e2e5f97d9920..f3d481b75b15 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -9,6 +9,7 @@
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
 #include <linux/dmi.h>
 #include <sound/core.h>
 #include <sound/jack.h>
@@ -32,6 +33,7 @@
 #define SOF_RT5682_SSP_AMP_MASK                 (GENMASK(8, 6))
 #define SOF_RT5682_SSP_AMP(quirk)	\
 	(((quirk) << SOF_RT5682_SSP_AMP_SHIFT) & SOF_RT5682_SSP_AMP_MASK)
+#define SOF_RT5682_MCLK_BYTCHT_EN		BIT(9)
 
 /* Default: MCLK on, MCLK 19.2M, SSP0  */
 static unsigned long sof_rt5682_quirk = SOF_RT5682_MCLK_EN |
@@ -48,6 +50,7 @@ struct sof_hdmi_pcm {
 };
 
 struct sof_card_private {
+	struct clk *mclk;
 	struct snd_soc_jack sof_headset;
 	struct list_head hdmi_pcm_list;
 };
@@ -59,6 +62,22 @@ static int sof_rt5682_quirk_cb(const struct dmi_system_id *id)
 }
 
 static const struct dmi_system_id sof_rt5682_quirk_table[] = {
+	{
+		.callback = sof_rt5682_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Max"),
+		},
+		.driver_data = (void *)(SOF_RT5682_SSP_CODEC(2)),
+	},
+	{
+		.callback = sof_rt5682_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "UP-CHT01"),
+		},
+		.driver_data = (void *)(SOF_RT5682_SSP_CODEC(2)),
+	},
 	{
 		.callback = sof_rt5682_quirk_cb,
 		.matches = {
@@ -127,6 +146,27 @@ static int sof_rt5682_codec_init(struct snd_soc_pcm_runtime *rtd)
 					RT5682_CLK_SEL_I2S1_ASRC);
 	}
 
+	if (sof_rt5682_quirk & SOF_RT5682_MCLK_BYTCHT_EN) {
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
+		ret = clk_set_rate(ctx->mclk, 19200000);
+
+		if (ret)
+			dev_err(rtd->dev, "unable to set MCLK rate\n");
+	}
+
 	/*
 	 * Headset buttons map to the google Reference headset.
 	 * These can be configured by userspace.
@@ -161,10 +201,20 @@ static int sof_rt5682_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sof_card_private *ctx = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int clk_id, clk_freq, pll_out, ret;
 
 	if (sof_rt5682_quirk & SOF_RT5682_MCLK_EN) {
+		if (sof_rt5682_quirk & SOF_RT5682_MCLK_BYTCHT_EN) {
+			ret = clk_prepare_enable(ctx->mclk);
+			if (ret < 0) {
+				dev_err(rtd->dev,
+					"could not configure MCLK state");
+				return ret;
+			}
+		}
+
 		clk_id = RT5682_PLL1_S_MCLK;
 		if (sof_rt5682_quirk & SOF_RT5682_MCLK_24MHZ)
 			clk_freq = 24000000;
@@ -507,7 +557,9 @@ static int sof_audio_probe(struct platform_device *pdev)
 		dmic_num = 0;
 		hdmi_num = 0;
 		/* default quirk for legacy cpu */
-		sof_rt5682_quirk = SOF_RT5682_SSP_CODEC(2);
+		sof_rt5682_quirk = SOF_RT5682_MCLK_EN |
+						SOF_RT5682_MCLK_BYTCHT_EN |
+						SOF_RT5682_SSP_CODEC(2);
 	} else {
 		dmic_num = 1;
 		hdmi_num = 3;
@@ -515,6 +567,17 @@ static int sof_audio_probe(struct platform_device *pdev)
 
 	dmi_check_system(sof_rt5682_quirk_table);
 
+	/* need to get main clock from pmc */
+	if (sof_rt5682_quirk & SOF_RT5682_MCLK_BYTCHT_EN) {
+		ctx->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
+		ret = clk_prepare_enable(ctx->mclk);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"could not configure MCLK state");
+			return ret;
+		}
+	}
+
 	dev_dbg(&pdev->dev, "sof_rt5682_quirk = %lx\n", sof_rt5682_quirk);
 
 	ssp_amp = (sof_rt5682_quirk & SOF_RT5682_SSP_AMP_MASK) >>
-- 
2.20.1
