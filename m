From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: remove soft reset and add
	second I2S clock" to the asoc tree
Date: Fri, 26 Feb 2016 11:46:56 +0900
Message-ID: <E1aZ8Qi-0006JH-KD@finisterre>
References: <1456215624-40383-1-git-send-email-pc.liao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CE957265262
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 03:47:01 +0100 (CET)
In-Reply-To: <1456215624-40383-1-git-send-email-pc.liao@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: PC Liao <pc.liao@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: remove soft reset and add second I2S clock

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

>From 4d7cb66c8f9db37ffa2a72cc9b9233ae82e94d7e Mon Sep 17 00:00:00 2001
From: PC Liao <pc.liao@mediatek.com>
Date: Tue, 23 Feb 2016 16:20:24 +0800
Subject: [PATCH] ASoC: mediatek: remove soft reset and add second I2S clock

To improve I2S flow, this patch removes soft reset and adds second
I2S clock to use.

Signed-off-by: PC Liao <pc.liao@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mtk-afe-pcm.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mtk-afe-pcm.c
index 689c51f23d9f..3456bfab4617 100644
--- a/sound/soc/mediatek/mtk-afe-pcm.c
+++ b/sound/soc/mediatek/mtk-afe-pcm.c
@@ -283,20 +283,13 @@ static void mtk_afe_set_i2s_enable(struct mtk_afe *afe, bool enable)
 
 	regmap_read(afe->regmap, AFE_I2S_CON2, &val);
 	if (!!(val & AFE_I2S_CON2_EN) == enable)
-		return; /* must skip soft reset */
-
-	/* I2S soft reset begin */
-	regmap_update_bits(afe->regmap, AUDIO_TOP_CON1, 0x4, 0x4);
+		return;
 
 	/* input */
 	regmap_update_bits(afe->regmap, AFE_I2S_CON2, 0x1, enable);
 
 	/* output */
 	regmap_update_bits(afe->regmap, AFE_I2S_CON1, 0x1, enable);
-
-	/* I2S soft reset end */
-	udelay(1);
-	regmap_update_bits(afe->regmap, AUDIO_TOP_CON1, 0x4, 0);
 }
 
 static int mtk_afe_dais_enable_clks(struct mtk_afe *afe,
@@ -365,6 +358,7 @@ static int mtk_afe_i2s_startup(struct snd_pcm_substream *substream,
 		return 0;
 
 	mtk_afe_dais_enable_clks(afe, afe->clocks[MTK_CLK_I2S1_M], NULL);
+	mtk_afe_dais_enable_clks(afe, afe->clocks[MTK_CLK_I2S2_M], NULL);
 	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
 			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M, 0);
 	return 0;
@@ -384,6 +378,7 @@ static void mtk_afe_i2s_shutdown(struct snd_pcm_substream *substream,
 			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M,
 			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M);
 	mtk_afe_dais_disable_clks(afe, afe->clocks[MTK_CLK_I2S1_M], NULL);
+	mtk_afe_dais_disable_clks(afe, afe->clocks[MTK_CLK_I2S2_M], NULL);
 }
 
 static int mtk_afe_i2s_prepare(struct snd_pcm_substream *substream,
@@ -397,6 +392,9 @@ static int mtk_afe_i2s_prepare(struct snd_pcm_substream *substream,
 	mtk_afe_dais_set_clks(afe,
 			      afe->clocks[MTK_CLK_I2S1_M], runtime->rate * 256,
 			      NULL, 0);
+	mtk_afe_dais_set_clks(afe,
+			      afe->clocks[MTK_CLK_I2S2_M], runtime->rate * 256,
+			      NULL, 0);
 	/* config I2S */
 	ret = mtk_afe_set_i2s(afe, substream->runtime->rate);
 	if (ret)
-- 
2.7.0
