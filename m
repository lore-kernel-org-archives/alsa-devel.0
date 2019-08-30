From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: davinci-i2s: Add S32_LE as support
	format" to the asoc tree
Date: Fri, 30 Aug 2019 12:45:18 +0100 (BST)
Message-ID: <20190830114518.F3A512742B61@ypsilon.sirena.org.uk>
References: <20190830103841.25128-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 197DDF80377
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 13:45:20 +0200 (CEST)
In-Reply-To: <20190830103841.25128-2-peter.ujfalusi@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, nsekhar@ti.com, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ti: davinci-i2s: Add S32_LE as support format

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 2231b2c63f869528504195f202d9585a4f00f143 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 30 Aug 2019 13:38:38 +0300
Subject: [PATCH] ASoC: ti: davinci-i2s: Add S32_LE as support format

ASP/McBSP can support 8/16/20/24/32 bits word in theory. I have only tested
S16_LE and S32_LE, the other formats might not work so only extend the
supported formats with S32_LE for now.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20190830103841.25128-2-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/davinci-i2s.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index 92c1bdc69086..f04d9fb5130f 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -612,6 +612,8 @@ static void davinci_i2s_shutdown(struct snd_pcm_substream *substream,
 }
 
 #define DAVINCI_I2S_RATES	SNDRV_PCM_RATE_8000_96000
+#define DAVINCI_I2S_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+				 SNDRV_PCM_FMTBIT_S32_LE)
 
 static const struct snd_soc_dai_ops davinci_i2s_dai_ops = {
 	.shutdown	= davinci_i2s_shutdown,
@@ -639,12 +641,14 @@ static struct snd_soc_dai_driver davinci_i2s_dai = {
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = DAVINCI_I2S_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+		.formats = DAVINCI_I2S_FORMATS,
+	},
 	.capture = {
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = DAVINCI_I2S_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+		.formats = DAVINCI_I2S_FORMATS,
+	},
 	.ops = &davinci_i2s_dai_ops,
 
 };
-- 
2.20.1
