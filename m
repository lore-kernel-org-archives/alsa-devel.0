From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: i2s: change bclk and lrck
	according to sample rates" to the asoc tree
Date: Fri, 06 Nov 2015 12:09:39 +0000
Message-ID: <E1Zufpr-00057v-No@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F3190260429
 for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2015 13:09:45 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caesar Wang <wxt@rock-chips.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: i2s: change bclk and lrck according to sample rates

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

>From daf7fdaa9909c22a30504f3fbf64861f6fb222af Mon Sep 17 00:00:00 2001
From: Caesar Wang <wxt@rock-chips.com>
Date: Fri, 6 Nov 2015 19:38:14 +0800
Subject: [PATCH] ASoC: rockchip: i2s: change bclk and lrck according to sample
 rates

This patch sets the dividers autonomously.

when i2s works on master mode, and sample rates changed. We need to change
bclk and lrck at the same time for cpu internal side.

As the input source clock to the module is MCLK_I2S,
and by the divider of the module, the clock generator generates
SCLK and LRCK to transmitter and receiver.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 58ee645..ce880f3 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -41,6 +41,7 @@ struct rk_i2s_dev {
 */
 	bool tx_start;
 	bool rx_start;
+	bool is_master_mode;
 };
 
 static int i2s_runtime_suspend(struct device *dev)
@@ -174,9 +175,11 @@ static int rockchip_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 	case SND_SOC_DAIFMT_CBS_CFS:
 		/* Set source clock in Master mode */
 		val = I2S_CKR_MSS_MASTER;
+		i2s->is_master_mode = true;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		val = I2S_CKR_MSS_SLAVE;
+		i2s->is_master_mode = false;
 		break;
 	default:
 		return -EINVAL;
@@ -228,6 +231,26 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct rk_i2s_dev *i2s = to_info(dai);
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	unsigned int val = 0;
+	unsigned int mclk_rate, bclk_rate, div_bclk, div_lrck;
+
+	if (i2s->is_master_mode) {
+		mclk_rate = clk_get_rate(i2s->mclk);
+		bclk_rate = 2 * 32 * params_rate(params);
+		if (bclk_rate && mclk_rate % bclk_rate)
+			return -EINVAL;
+
+		div_bclk = mclk_rate / bclk_rate;
+		div_lrck = bclk_rate / params_rate(params);
+		regmap_update_bits(i2s->regmap, I2S_CKR,
+				   I2S_CKR_MDIV_MASK,
+				   I2S_CKR_MDIV(div_bclk));
+
+		regmap_update_bits(i2s->regmap, I2S_CKR,
+				   I2S_CKR_TSD_MASK |
+				   I2S_CKR_RSD_MASK,
+				   I2S_CKR_TSD(div_lrck) |
+				   I2S_CKR_RSD(div_lrck));
+	}
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
-- 
2.6.1
