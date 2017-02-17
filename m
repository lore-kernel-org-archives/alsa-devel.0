From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: automatic BCLK and LRC divde
	in master mode" to the asoc tree
Date: Fri, 17 Feb 2017 13:22:20 +0000
Message-ID: <E1ceiUO-0003pc-TU@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BCEBC2671B4
 for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2017 14:22:29 +0100 (CET)
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
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: automatic BCLK and LRC divde in master mode

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

>From 1e561f6166bacb9c12d6fa1d23df07999674573e Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Fri, 17 Feb 2017 09:55:33 +0800
Subject: [PATCH] ASoC: nau8825: automatic BCLK and LRC divde in master mode

configurable LRC and BCLK divide. The driver
will make configurations of LRC and BCLK automatically according to
BCLK and FS information in master mode.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 4576f987a4a5..97fbeba9498f 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1231,7 +1231,7 @@ static int nau8825_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
-	unsigned int val_len = 0, osr;
+	unsigned int val_len = 0, osr, ctrl_val, bclk_fs, bclk_div;
 
 	nau8825_sema_acquire(nau8825, 3 * HZ);
 
@@ -1261,6 +1261,24 @@ static int nau8825_hw_params(struct snd_pcm_substream *substream,
 			osr_adc_sel[osr].clk_src << NAU8825_CLK_ADC_SRC_SFT);
 	}
 
+	/* make BCLK and LRC divde configuration if the codec as master. */
+	regmap_read(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2, &ctrl_val);
+	if (ctrl_val & NAU8825_I2S_MS_MASTER) {
+		/* get the bclk and fs ratio */
+		bclk_fs = snd_soc_params_to_bclk(params) / params_rate(params);
+		if (bclk_fs <= 32)
+			bclk_div = 2;
+		else if (bclk_fs <= 64)
+			bclk_div = 1;
+		else if (bclk_fs <= 128)
+			bclk_div = 0;
+		else
+			return -EINVAL;
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2,
+			NAU8825_I2S_LRC_DIV_MASK | NAU8825_I2S_BLK_DIV_MASK,
+			((bclk_div + 1) << NAU8825_I2S_LRC_DIV_SFT) | bclk_div);
+	}
+
 	switch (params_width(params)) {
 	case 16:
 		val_len |= NAU8825_I2S_DL_16;
-- 
2.11.0
