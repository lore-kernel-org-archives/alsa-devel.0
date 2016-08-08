From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on spdif_transmitter" to the asoc tree
Date: Mon, 08 Aug 2016 12:05:03 +0100
Message-ID: <E1bWiMh-0003pV-6p@debutante>
References: <87lh077ih2.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87lh077ih2.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on spdif_transmitter

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

>From b9c990da5f258af36acc508f460356e47cd3cb14 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 08:57:52 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 spdif_transmitter

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/spdif_transmitter.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/spdif_transmitter.c b/sound/soc/codecs/spdif_transmitter.c
index ef634a9ad673..ee367536a498 100644
--- a/sound/soc/codecs/spdif_transmitter.c
+++ b/sound/soc/codecs/spdif_transmitter.c
@@ -38,10 +38,12 @@ static const struct snd_soc_dapm_route dit_routes[] = {
 };
 
 static struct snd_soc_codec_driver soc_codec_spdif_dit = {
-	.dapm_widgets = dit_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(dit_widgets),
-	.dapm_routes = dit_routes,
-	.num_dapm_routes = ARRAY_SIZE(dit_routes),
+	.component_driver = {
+		.dapm_widgets		= dit_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(dit_widgets),
+		.dapm_routes		= dit_routes,
+		.num_dapm_routes	= ARRAY_SIZE(dit_routes),
+	},
 };
 
 static struct snd_soc_dai_driver dit_stub_dai = {
-- 
2.8.1
