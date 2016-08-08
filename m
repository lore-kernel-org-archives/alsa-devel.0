From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on atmel-pdmic" to the asoc tree
Date: Mon, 08 Aug 2016 12:03:02 +0100
Message-ID: <E1bWiKk-0003FL-Ji@debutante>
References: <87y4474oqv.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87y4474oqv.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on atmel-pdmic

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

>From 72bb3cdf93b1718c9a540fb157890d8639633eca Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:10:41 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 atmel-pdmic

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/atmel-pdmic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/atmel-pdmic.c b/sound/soc/atmel/atmel-pdmic.c
index 5f56da60c92f..2a3a41fad38d 100644
--- a/sound/soc/atmel/atmel-pdmic.c
+++ b/sound/soc/atmel/atmel-pdmic.c
@@ -357,8 +357,10 @@ static int atmel_pdmic_codec_probe(struct snd_soc_codec *codec)
 
 static struct snd_soc_codec_driver soc_codec_dev_pdmic = {
 	.probe		= atmel_pdmic_codec_probe,
-	.controls	= atmel_pdmic_snd_controls,
-	.num_controls	= ARRAY_SIZE(atmel_pdmic_snd_controls),
+	.component_driver = {
+		.controls		= atmel_pdmic_snd_controls,
+		.num_controls		= ARRAY_SIZE(atmel_pdmic_snd_controls),
+	},
 };
 
 /* codec dai component */
-- 
2.8.1
