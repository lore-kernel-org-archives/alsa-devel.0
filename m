From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: Turn AFE on/off in runtime
	resume/suspend" to the asoc tree
Date: Wed, 23 Dec 2015 00:09:03 +0000
Message-ID: <E1aBWzH-0007OG-TB@debutante>
References: <1450753894-8087-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A6F60265E3F
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:09:10 +0100 (CET)
In-Reply-To: <1450753894-8087-1-git-send-email-koro.chen@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Koro Chen <koro.chen@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: Turn AFE on/off in runtime resume/suspend

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

>From c1f2a342846fbfd49ddc06ad7f0684d2c45b419d Mon Sep 17 00:00:00 2001
From: Koro Chen <koro.chen@mediatek.com>
Date: Tue, 22 Dec 2015 11:11:34 +0800
Subject: [PATCH] ASoC: mediatek: Turn AFE on/off in runtime resume/suspend

AFE is actually allowed to be turn on before configuration of DAIs
since each DAI has its own enabling control. Turn on/off AFE in
runtime resume/suspend to avoid AFE being shut down when closing a DAI
while other DAIs are still active.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mtk-afe-pcm.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mtk-afe-pcm.c
index 5399a0eead3e..08af9f5dc4ab 100644
--- a/sound/soc/mediatek/mtk-afe-pcm.c
+++ b/sound/soc/mediatek/mtk-afe-pcm.c
@@ -382,9 +382,6 @@ static void mtk_afe_i2s_shutdown(struct snd_pcm_substream *substream,
 			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M,
 			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M);
 	mtk_afe_dais_disable_clks(afe, afe->clocks[MTK_CLK_I2S1_M], NULL);
-
-	/* disable AFE */
-	regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0);
 }
 
 static int mtk_afe_i2s_prepare(struct snd_pcm_substream *substream,
@@ -433,9 +430,6 @@ static void mtk_afe_hdmi_shutdown(struct snd_pcm_substream *substream,
 
 	mtk_afe_dais_disable_clks(afe, afe->clocks[MTK_CLK_I2S3_M],
 				  afe->clocks[MTK_CLK_I2S3_B]);
-
-	/* disable AFE */
-	regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0);
 }
 
 static int mtk_afe_hdmi_prepare(struct snd_pcm_substream *substream,
@@ -679,17 +673,6 @@ static int mtk_afe_dais_hw_free(struct snd_pcm_substream *substream,
 	return snd_pcm_lib_free_pages(substream);
 }
 
-static int mtk_afe_dais_prepare(struct snd_pcm_substream *substream,
-				struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mtk_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
-
-	/* enable AFE */
-	regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0x1);
-	return 0;
-}
-
 static int mtk_afe_dais_trigger(struct snd_pcm_substream *substream, int cmd,
 				struct snd_soc_dai *dai)
 {
@@ -757,7 +740,6 @@ static const struct snd_soc_dai_ops mtk_afe_dai_ops = {
 	.shutdown	= mtk_afe_dais_shutdown,
 	.hw_params	= mtk_afe_dais_hw_params,
 	.hw_free	= mtk_afe_dais_hw_free,
-	.prepare	= mtk_afe_dais_prepare,
 	.trigger	= mtk_afe_dais_trigger,
 };
 
@@ -1118,6 +1100,9 @@ static int mtk_afe_runtime_suspend(struct device *dev)
 {
 	struct mtk_afe *afe = dev_get_drvdata(dev);
 
+	/* disable AFE */
+	regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0);
+
 	/* disable AFE clk */
 	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
 			   AUD_TCON0_PDN_AFE, AUD_TCON0_PDN_AFE);
@@ -1164,6 +1149,9 @@ static int mtk_afe_runtime_resume(struct device *dev)
 
 	/* unmask all IRQs */
 	regmap_update_bits(afe->regmap, AFE_IRQ_MCU_EN, 0xff, 0xff);
+
+	/* enable AFE */
+	regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0x1);
 	return 0;
 
 err_bck0:
-- 
2.6.2
