From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: i2s: Comments clean up" to the
	asoc tree
Date: Thu, 14 Feb 2019 14:51:13 +0000 (GMT)
Message-ID: <20190214145113.ED3211126F78@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 273FD267A14
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2019 15:51:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: i2s: Comments clean up

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

>From 9f9f8a5b79b0855d162153de41ffda687fd2241f Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Thu, 14 Feb 2019 10:37:46 +0100
Subject: [PATCH] ASoC: samsung: i2s: Comments clean up

Spelling error fixes, upper/lower case letter changes.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 07f815a730df..84cfa2c0ba68 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1,5 +1,4 @@
-/* sound/soc/samsung/i2s.c
- *
+/*
  * ALSA SoC Audio Layer - Samsung I2S Controller driver
  *
  * Copyright (c) 2010 Samsung Electronics Co. Ltd.
@@ -61,10 +60,10 @@ struct i2s_dai {
 	/* Platform device for this DAI */
 	struct platform_device *pdev;
 
-	/* Frame Clock */
+	/* Frame clock */
 	unsigned frmclk;
 	/*
-	 * Specifically requested RCLK,BCLK by MACHINE Driver.
+	 * Specifically requested RCLK, BCLK by machine driver.
 	 * 0 indicates CPU driver is free to choose any value.
 	 */
 	unsigned rfs, bfs;
@@ -72,8 +71,9 @@ struct i2s_dai {
 	struct i2s_dai *pri_dai;
 	/* Pointer to the Secondary_Fifo if it has one, NULL otherwise */
 	struct i2s_dai *sec_dai;
-#define DAI_OPENED	(1 << 0) /* Dai is opened */
-#define DAI_MANAGER	(1 << 1) /* Dai is the manager */
+
+#define DAI_OPENED	(1 << 0) /* DAI is opened */
+#define DAI_MANAGER	(1 << 1) /* DAI is the manager */
 	unsigned mode;
 
 	/* Driver for this DAI */
@@ -98,7 +98,7 @@ struct samsung_i2s_priv {
 	/* Spinlock protecting access to the device's registers */
 	spinlock_t lock;
 
-	/* Lock for cross i/f checks */
+	/* Lock for cross interface checks */
 	spinlock_t pcm_lock;
 
 	/* CPU DAIs and their corresponding drivers */
@@ -309,7 +309,7 @@ static inline void set_rfs(struct i2s_dai *i2s, unsigned rfs)
 	writel(mod, priv->addr + I2SMOD);
 }
 
-/* Read Bit-Clock of I2S (in multiples of LRCLK) */
+/* Read bit-clock of I2S (in multiples of LRCLK) */
 static inline unsigned get_bfs(struct i2s_dai *i2s)
 {
 	struct samsung_i2s_priv *priv = i2s->priv;
@@ -331,7 +331,7 @@ static inline unsigned get_bfs(struct i2s_dai *i2s)
 	}
 }
 
-/* Write Bit-Clock of I2S (in multiples of LRCLK) */
+/* Write bit-clock of I2S (in multiples of LRCLK) */
 static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
 {
 	struct samsung_i2s_priv *priv = i2s->priv;
@@ -383,7 +383,7 @@ static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
 	writel(mod, priv->addr + I2SMOD);
 }
 
-/* Sample-Size */
+/* Sample size */
 static inline int get_blc(struct i2s_dai *i2s)
 {
 	int blc = readl(i2s->priv->addr + I2SMOD);
@@ -397,7 +397,7 @@ static inline int get_blc(struct i2s_dai *i2s)
 	}
 }
 
-/* TX Channel Control */
+/* TX channel control */
 static void i2s_txctrl(struct i2s_dai *i2s, int on)
 {
 	struct samsung_i2s_priv *priv = i2s->priv;
@@ -742,7 +742,7 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 	switch (params_channels(params)) {
 	case 6:
 		val |= MOD_DC2_EN;
-		/* fall through */
+		/* Fall through */
 	case 4:
 		val |= MOD_DC1_EN;
 		break;
@@ -821,7 +821,7 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-/* We set constraints on the substream acc to the version of I2S */
+/* We set constraints on the substream according to the version of I2S */
 static int i2s_startup(struct snd_pcm_substream *substream,
 	  struct snd_soc_dai *dai)
 {
@@ -1056,7 +1056,8 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 
 	pm_runtime_get_sync(dai->dev);
 
-	if (is_secondary(i2s)) { /* If this is probe on the secondary DAI */
+	if (is_secondary(i2s)) {
+		/* If this is probe on the secondary DAI */
 		snd_soc_dai_init_dma_data(dai, &i2s->dma_playback, NULL);
 	} else {
 		snd_soc_dai_init_dma_data(dai, &i2s->dma_playback,
-- 
2.20.1
