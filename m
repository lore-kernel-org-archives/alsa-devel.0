From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_spdif: fix sysclk_df type" to the asoc tree
Date: Mon, 18 Feb 2019 18:52:34 +0000 (GMT)
Message-ID: <20190218185234.163961128008@debutante.sirena.org.uk>
References: <1550503474-18865-1-git-send-email-viorel.suman@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550503474-18865-1-git-send-email-viorel.suman@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Viorel Suman <viorel.suman@gmail.com>Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_spdif: fix sysclk_df type

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 2231609a2c0a4807c017822ecb5834bbb7f59fb9 Mon Sep 17 00:00:00 2001
From: Viorel Suman <viorel.suman@nxp.com>
Date: Mon, 18 Feb 2019 15:25:00 +0000
Subject: [PATCH] ASoC: fsl_spdif: fix sysclk_df type

According to RM SPDIF STC SYSCLK_DF field is 9-bit wide, values
being in 0..511 range. Use a proper type to handle sysclk_df.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_spdif.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index a26686e7281c..4842e6df9a2d 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -96,7 +96,7 @@ struct fsl_spdif_priv {
 	bool dpll_locked;
 	u32 txrate[SPDIF_TXRATE_MAX];
 	u8 txclk_df[SPDIF_TXRATE_MAX];
-	u8 sysclk_df[SPDIF_TXRATE_MAX];
+	u16 sysclk_df[SPDIF_TXRATE_MAX];
 	u8 txclk_src[SPDIF_TXRATE_MAX];
 	u8 rxclk_src;
 	struct clk *txclk[SPDIF_TXRATE_MAX];
@@ -376,7 +376,8 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
 	struct platform_device *pdev = spdif_priv->pdev;
 	unsigned long csfs = 0;
 	u32 stc, mask, rate;
-	u8 clk, txclk_df, sysclk_df;
+	u16 sysclk_df;
+	u8 clk, txclk_df;
 	int ret;
 
 	switch (sample_rate) {
@@ -1109,8 +1110,9 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
 	static const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
 	bool is_sysclk = clk_is_match(clk, spdif_priv->sysclk);
 	u64 rate_ideal, rate_actual, sub;
-	u32 sysclk_dfmin, sysclk_dfmax;
-	u32 txclk_df, sysclk_df, arate;
+	u32 arate;
+	u16 sysclk_dfmin, sysclk_dfmax, sysclk_df;
+	u8 txclk_df;
 
 	/* The sysclk has an extra divisor [2, 512] */
 	sysclk_dfmin = is_sysclk ? 2 : 1;
-- 
2.20.1
