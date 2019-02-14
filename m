From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: i2s: Get rid of a static
	spinlock" to the asoc tree
Date: Thu, 14 Feb 2019 13:09:27 +0000 (GMT)
Message-ID: <20190214130927.525141126F78@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F5512679D8
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2019 14:09:28 +0100 (CET)
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

   ASoC: samsung: i2s: Get rid of a static spinlock

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

>From defc67c6e3638020cc6189d056e0bc187b297068 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Thu, 14 Feb 2019 10:37:39 +0100
Subject: [PATCH] ASoC: samsung: i2s: Get rid of a static spinlock

This patch makes the spinlock serializing access to the primary/secondary
PCM a per I2S controller lock, rather than a global one. There is no need
to have a global lock across multiple I2S controllers in the SoC.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 8f0af4b0f25a..692a752b194c 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -88,9 +88,6 @@ struct i2s_dai {
 	struct samsung_i2s_priv *priv;
 };
 
-/* Lock for cross i/f checks */
-static DEFINE_SPINLOCK(lock);
-
 struct samsung_i2s_priv {
 	struct platform_device *pdev;
 	struct platform_device *pdev_sec;
@@ -101,6 +98,9 @@ struct samsung_i2s_priv {
 	/* Spinlock protecting access to the device's registers */
 	spinlock_t lock;
 
+	/* Lock for cross i/f checks */
+	spinlock_t pcm_lock;
+
 	/* CPU DAIs and their corresponding drivers */
 	struct i2s_dai *dai;
 	struct snd_soc_dai_driver *dai_drv;
@@ -832,7 +832,7 @@ static int i2s_startup(struct snd_pcm_substream *substream,
 
 	pm_runtime_get_sync(dai->dev);
 
-	spin_lock_irqsave(&lock, flags);
+	spin_lock_irqsave(&priv->pcm_lock, flags);
 
 	i2s->mode |= DAI_OPENED;
 
@@ -844,7 +844,7 @@ static int i2s_startup(struct snd_pcm_substream *substream,
 	if (!any_active(i2s) && (priv->quirks & QUIRK_NEED_RSTCLR))
 		writel(CON_RSTCLR, i2s->priv->addr + I2SCON);
 
-	spin_unlock_irqrestore(&lock, flags);
+	spin_unlock_irqrestore(&priv->pcm_lock, flags);
 
 	return 0;
 }
@@ -852,11 +852,12 @@ static int i2s_startup(struct snd_pcm_substream *substream,
 static void i2s_shutdown(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
+	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
 	struct i2s_dai *i2s = to_info(dai);
 	struct i2s_dai *other = get_other_dai(i2s);
 	unsigned long flags;
 
-	spin_lock_irqsave(&lock, flags);
+	spin_lock_irqsave(&priv->pcm_lock, flags);
 
 	i2s->mode &= ~DAI_OPENED;
 	i2s->mode &= ~DAI_MANAGER;
@@ -868,7 +869,7 @@ static void i2s_shutdown(struct snd_pcm_substream *substream,
 	i2s->rfs = 0;
 	i2s->bfs = 0;
 
-	spin_unlock_irqrestore(&lock, flags);
+	spin_unlock_irqrestore(&priv->pcm_lock, flags);
 
 	pm_runtime_put(dai->dev);
 }
@@ -1406,6 +1407,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pri_dai = &priv->dai[SAMSUNG_I2S_ID_PRIMARY - 1];
 
 	spin_lock_init(&priv->lock);
+	spin_lock_init(&priv->pcm_lock);
 
 	if (!np) {
 		if (i2s_pdata == NULL) {
-- 
2.20.1
