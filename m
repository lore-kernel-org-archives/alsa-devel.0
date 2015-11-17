From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: Move 22M/24M clock control
	into I2S ops" to the asoc tree
Date: Tue, 17 Nov 2015 18:54:43 +0000
Message-ID: <E1ZylOt-0003zI-VP@debutante>
References: <1447140372-10048-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EA442652E5
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2015 19:54:54 +0100 (CET)
In-Reply-To: <1447140372-10048-1-git-send-email-koro.chen@mediatek.com>
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

   ASoC: mediatek: Move 22M/24M clock control into I2S ops

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

>From b45e68df065a9babc43b4b7cd223c412d34b6658 Mon Sep 17 00:00:00 2001
From: Koro Chen <koro.chen@mediatek.com>
Date: Tue, 10 Nov 2015 15:26:12 +0800
Subject: [PATCH] ASoC: mediatek: Move 22M/24M clock control into I2S ops

22M/24M clocks are only required for I2S, so move the control to
I2S DAI ops.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mtk-afe-pcm.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mtk-afe-pcm.c
index f5baf3c38863..7f7134397f73 100644
--- a/sound/soc/mediatek/mtk-afe-pcm.c
+++ b/sound/soc/mediatek/mtk-afe-pcm.c
@@ -299,8 +299,6 @@ static int mtk_afe_dais_enable_clks(struct mtk_afe *afe,
 			dev_err(afe->dev, "Failed to enable m_ck\n");
 			return ret;
 		}
-		regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
-				   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M, 0);
 	}
 
 	if (b_ck) {
@@ -340,12 +338,8 @@ static int mtk_afe_dais_set_clks(struct mtk_afe *afe,
 static void mtk_afe_dais_disable_clks(struct mtk_afe *afe,
 				      struct clk *m_ck, struct clk *b_ck)
 {
-	if (m_ck) {
-		regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
-				   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M,
-				   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M);
+	if (m_ck)
 		clk_disable_unprepare(m_ck);
-	}
 	if (b_ck)
 		clk_disable_unprepare(b_ck);
 }
@@ -360,6 +354,8 @@ static int mtk_afe_i2s_startup(struct snd_pcm_substream *substream,
 		return 0;
 
 	mtk_afe_dais_enable_clks(afe, afe->clocks[MTK_CLK_I2S1_M], NULL);
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
+			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M, 0);
 	return 0;
 }
 
@@ -373,6 +369,9 @@ static void mtk_afe_i2s_shutdown(struct snd_pcm_substream *substream,
 		return;
 
 	mtk_afe_set_i2s_enable(afe, false);
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
+			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M,
+			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M);
 	mtk_afe_dais_disable_clks(afe, afe->clocks[MTK_CLK_I2S1_M], NULL);
 
 	/* disable AFE */
-- 
2.6.2
