From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: i2s: share tx/rx lrck when
	symmetric_rates enabled" to the asoc tree
Date: Fri, 23 Oct 2015 08:08:49 +0900
Message-ID: <E1ZpOyX-0008Gf-0y@finisterre>
References: <1444308009-29088-4-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3640C266AB7
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:09:03 +0200 (CEST)
In-Reply-To: <1444308009-29088-4-git-send-email-sugar.zhang@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: i2s: share tx/rx lrck when symmetric_rates enabled

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

>From b3f2dcddd576a2a6e59c407109610206c4062c8f Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Thu, 8 Oct 2015 20:40:09 +0800
Subject: [PATCH] ASoC: rockchip: i2s: share tx/rx lrck when symmetric_rates
 enabled

share lrck_tx to lrck_rx when symmetric_rates enabled.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 8 ++++++++
 sound/soc/rockchip/rockchip_i2s.h | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index f07833b..58ee645 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -226,6 +226,7 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
 	struct rk_i2s_dev *i2s = to_info(dai);
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	unsigned int val = 0;
 
 	switch (params_format(params)) {
@@ -278,6 +279,13 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 	regmap_update_bits(i2s->regmap, I2S_DMACR, I2S_DMACR_RDL_MASK,
 			   I2S_DMACR_RDL(16));
 
+	val = I2S_CKR_TRCM_TXRX;
+	if (dai->driver->symmetric_rates || rtd->dai_link->symmetric_rates)
+		val = I2S_CKR_TRCM_TXSHARE;
+
+	regmap_update_bits(i2s->regmap, I2S_CKR,
+			   I2S_CKR_TRCM_MASK,
+			   val);
 	return 0;
 }
 
diff --git a/sound/soc/rockchip/rockchip_i2s.h b/sound/soc/rockchip/rockchip_i2s.h
index a54ee35..dc6e2c7 100644
--- a/sound/soc/rockchip/rockchip_i2s.h
+++ b/sound/soc/rockchip/rockchip_i2s.h
@@ -78,6 +78,12 @@
  * CKR
  * clock generation register
 */
+#define I2S_CKR_TRCM_SHIFT	28
+#define I2S_CKR_TRCM(x)	(x << I2S_CKR_TRCM_SHIFT)
+#define I2S_CKR_TRCM_TXRX	(0 << I2S_CKR_TRCM_SHIFT)
+#define I2S_CKR_TRCM_TXSHARE	(1 << I2S_CKR_TRCM_SHIFT)
+#define I2S_CKR_TRCM_RXSHARE	(2 << I2S_CKR_TRCM_SHIFT)
+#define I2S_CKR_TRCM_MASK	(3 << I2S_CKR_TRCM_SHIFT)
 #define I2S_CKR_MSS_SHIFT	27
 #define I2S_CKR_MSS_MASTER	(0 << I2S_CKR_MSS_SHIFT)
 #define I2S_CKR_MSS_SLAVE	(1 << I2S_CKR_MSS_SHIFT)
-- 
2.6.1
