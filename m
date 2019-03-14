From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8810: automatic selecting BCLK in
	I2S master mode" to the asoc tree
Date: Thu, 14 Mar 2019 15:53:21 +0000 (GMT)
Message-ID: <20190314155321.382C61126E64@debutante.sirena.org.uk>
References: <20190313085201.8605-1-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B782F896C7
 for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2019 16:53:25 +0100 (CET)
In-Reply-To: <20190313085201.8605-1-KCHSU0@nuvoton.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8810: automatic selecting BCLK in I2S master mode

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

>From 20b83421e8eea43e28cb7aeea3e3f865f86aa69d Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Wed, 13 Mar 2019 16:52:01 +0800
Subject: [PATCH] ASoC: nau8810: automatic selecting BCLK in I2S master mode

The driver will select correct BCLK automatically according to
BCLK and FS information in I2S master mode.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8810.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
index 39512a78a556..5d300b790f78 100644
--- a/sound/soc/codecs/nau8810.c
+++ b/sound/soc/codecs/nau8810.c
@@ -667,6 +667,24 @@ static int nau8810_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct nau8810 *nau8810 = snd_soc_component_get_drvdata(component);
 	int val_len = 0, val_rate = 0, ret = 0;
+	unsigned int ctrl_val, bclk_fs, bclk_div;
+
+	/* Select BCLK configuration if the codec as master. */
+	regmap_read(nau8810->regmap, NAU8810_REG_CLOCK, &ctrl_val);
+	if (ctrl_val & NAU8810_CLKIO_MASTER) {
+		/* get the bclk and fs ratio */
+		bclk_fs = snd_soc_params_to_bclk(params) / params_rate(params);
+		if (bclk_fs <= 32)
+			bclk_div = NAU8810_BCLKDIV_8;
+		else if (bclk_fs <= 64)
+			bclk_div = NAU8810_BCLKDIV_4;
+		else if (bclk_fs <= 128)
+			bclk_div = NAU8810_BCLKDIV_2;
+		else
+			return -EINVAL;
+		regmap_update_bits(nau8810->regmap, NAU8810_REG_CLOCK,
+			NAU8810_BCLKSEL_MASK, bclk_div);
+	}
 
 	switch (params_width(params)) {
 	case 16:
-- 
2.20.1
