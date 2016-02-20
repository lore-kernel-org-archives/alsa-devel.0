From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: Use IRQ safe spin lock calls" to the asoc tree
Date: Sun, 21 Feb 2016 02:16:26 +0900
Message-ID: <E1aXB8s-0008UE-Gc@finisterre>
References: <1455810433-10305-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1455810433-10305-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: stable-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Anand Moon <linux.amoon@gmail.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: Use IRQ safe spin lock calls

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

>From 316fa9e09ad76e095b9d7e9350c628b918370a22 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Thu, 18 Feb 2016 15:47:13 +0000
Subject: [PATCH] ASoC: samsung: Use IRQ safe spin lock calls

Lockdep warns of a potential lock inversion, i2s->lock is held numerous
times whilst we are under the substream lock (snd_pcm_stream_lock). If
we use the IRQ unsafe spin lock calls, you can also end up locking
snd_pcm_stream_lock whilst under i2s->lock (if an IRQ happens whilst we
are holding i2s->lock). This could result in deadlock.

[   18.147001]        CPU0                    CPU1
[   18.151509]        ----                    ----
[   18.156022]   lock(&(&pri_dai->spinlock)->rlock);
[   18.160701]                                local_irq_disable();
[   18.166622]                                lock(&(&substream->self_group.lock)->rlock);
[   18.174595]                                lock(&(&pri_dai->spinlock)->rlock);
[   18.181806]   <Interrupt>
[   18.184408]     lock(&(&substream->self_group.lock)->rlock);
[   18.190045]
[   18.190045]  *** DEADLOCK ***

This patch changes to using the irq safe spinlock calls, to avoid this
issue.

Fixes: ce8bcdbb61d9 ("ASoC: samsung: i2s: Protect more registers with a spinlock")
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Tested-by: Anand Moon <linux.amoon@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/samsung/i2s.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 84d9e77..70a2559 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -481,10 +481,11 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 	unsigned int cdcon_mask = 1 << i2s_regs->cdclkcon_off;
 	unsigned int rsrc_mask = 1 << i2s_regs->rclksrc_off;
 	u32 mod, mask, val = 0;
+	unsigned long flags;
 
-	spin_lock(i2s->lock);
+	spin_lock_irqsave(i2s->lock, flags);
 	mod = readl(i2s->addr + I2SMOD);
-	spin_unlock(i2s->lock);
+	spin_unlock_irqrestore(i2s->lock, flags);
 
 	switch (clk_id) {
 	case SAMSUNG_I2S_OPCLK:
@@ -575,11 +576,11 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	spin_lock(i2s->lock);
+	spin_lock_irqsave(i2s->lock, flags);
 	mod = readl(i2s->addr + I2SMOD);
 	mod = (mod & ~mask) | val;
 	writel(mod, i2s->addr + I2SMOD);
-	spin_unlock(i2s->lock);
+	spin_unlock_irqrestore(i2s->lock, flags);
 
 	return 0;
 }
@@ -590,6 +591,7 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 	struct i2s_dai *i2s = to_info(dai);
 	int lrp_shift, sdf_shift, sdf_mask, lrp_rlow, mod_slave;
 	u32 mod, tmp = 0;
+	unsigned long flags;
 
 	lrp_shift = i2s->variant_regs->lrp_off;
 	sdf_shift = i2s->variant_regs->sdf_off;
@@ -649,7 +651,7 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	spin_lock(i2s->lock);
+	spin_lock_irqsave(i2s->lock, flags);
 	mod = readl(i2s->addr + I2SMOD);
 	/*
 	 * Don't change the I2S mode if any controller is active on this
@@ -657,7 +659,7 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 	 */
 	if (any_active(i2s) &&
 		((mod & (sdf_mask | lrp_rlow | mod_slave)) != tmp)) {
-		spin_unlock(i2s->lock);
+		spin_unlock_irqrestore(i2s->lock, flags);
 		dev_err(&i2s->pdev->dev,
 				"%s:%d Other DAI busy\n", __func__, __LINE__);
 		return -EAGAIN;
@@ -666,7 +668,7 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 	mod &= ~(sdf_mask | lrp_rlow | mod_slave);
 	mod |= tmp;
 	writel(mod, i2s->addr + I2SMOD);
-	spin_unlock(i2s->lock);
+	spin_unlock_irqrestore(i2s->lock, flags);
 
 	return 0;
 }
@@ -676,6 +678,7 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 {
 	struct i2s_dai *i2s = to_info(dai);
 	u32 mod, mask = 0, val = 0;
+	unsigned long flags;
 
 	if (!is_secondary(i2s))
 		mask |= (MOD_DC2_EN | MOD_DC1_EN);
@@ -744,11 +747,11 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	spin_lock(i2s->lock);
+	spin_lock_irqsave(i2s->lock, flags);
 	mod = readl(i2s->addr + I2SMOD);
 	mod = (mod & ~mask) | val;
 	writel(mod, i2s->addr + I2SMOD);
-	spin_unlock(i2s->lock);
+	spin_unlock_irqrestore(i2s->lock, flags);
 
 	samsung_asoc_init_dma_data(dai, &i2s->dma_playback, &i2s->dma_capture);
 
-- 
2.7.0
