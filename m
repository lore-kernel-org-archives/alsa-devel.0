From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: zx-i2s: fix harsh noise with 16-bit
	audio" to the asoc tree
Date: Mon, 29 May 2017 15:02:56 +0100
Message-ID: <E1dFLG4-0001PW-P4@finisterre>
References: <1495871444-4307-1-git-send-email-shawnguo@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C55B9266DCF
 for <alsa-devel@alsa-project.org>; Mon, 29 May 2017 16:03:09 +0200 (CEST)
In-Reply-To: <1495871444-4307-1-git-send-email-shawnguo@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Baoyou Xie <xie.baoyou@sanechips.com.cn>, Jun Nie <jun.nie@linaro.org>, Xin Zhou <zhou.xin8@sanechips.com.cn>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: zx-i2s: fix harsh noise with 16-bit audio

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

>From 6a9a440681f2170b9a07b1cf28c6aa7532c307c8 Mon Sep 17 00:00:00 2001
From: Shawn Guo <shawn.guo@linaro.org>
Date: Sat, 27 May 2017 15:50:44 +0800
Subject: [PATCH] ASoC: zx-i2s: fix harsh noise with 16-bit audio

The audio parameter setup in zx_i2s_hw_params() works fine with 32-bit
samples, but for 16-bit ones, all we can hear is harsh noises.
As suggested by vendor driver code, DMA burst size and TS width should
always be 32 bits, no matter audio sample is 16-bit or 32-bit.

Follow the suggestion above to fix the harsh noise issue seen with
16-bit audio samples.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/zte/zx-i2s.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/zte/zx-i2s.c b/sound/soc/zte/zx-i2s.c
index a865f37c2a56..a7f7a56e0a2d 100644
--- a/sound/soc/zte/zx-i2s.c
+++ b/sound/soc/zte/zx-i2s.c
@@ -226,11 +226,12 @@ static int zx_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct zx_i2s_info *i2s = snd_soc_dai_get_drvdata(socdai);
 	struct snd_dmaengine_dai_dma_data *dma_data;
 	unsigned int lane, ch_num, len, ret = 0;
+	unsigned int ts_width = 32;
 	unsigned long val;
 	unsigned long chn_cfg;
 
 	dma_data = snd_soc_dai_get_dma_data(socdai, substream);
-	dma_data->addr_width = params_width(params) >> 3;
+	dma_data->addr_width = ts_width >> 3;
 
 	val = readl_relaxed(i2s->reg_base + ZX_I2S_TIMING_CTRL);
 	val &= ~(ZX_I2S_TIMING_TS_WIDTH_MASK | ZX_I2S_TIMING_DATA_SIZE_MASK |
@@ -251,7 +252,7 @@ static int zx_i2s_hw_params(struct snd_pcm_substream *substream,
 		dev_err(socdai->dev, "Unknown data format\n");
 		return -EINVAL;
 	}
-	val |= ZX_I2S_TIMING_TS_WIDTH(len) | ZX_I2S_TIMING_DATA_SIZE(len);
+	val |= ZX_I2S_TIMING_TS_WIDTH(ts_width) | ZX_I2S_TIMING_DATA_SIZE(len);
 
 	ch_num = params_channels(params);
 	switch (ch_num) {
-- 
2.11.0
