From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on stac9766" to the asoc tree
Date: Mon, 08 Aug 2016 12:00:42 +0100
Message-ID: <E1bWiIU-0002Yz-CE@debutante>
References: <871t1z39hx.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <871t1z39hx.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on stac9766

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

>From 70e710d649ce705910885617fda3e37528057300 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:25:22 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 stac9766

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/stac9766.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 0945c51df003..2c5941f3a234 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -320,8 +320,10 @@ static int stac9766_codec_remove(struct snd_soc_codec *codec)
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_stac9766 = {
-	.controls = stac9766_snd_ac97_controls,
-	.num_controls = ARRAY_SIZE(stac9766_snd_ac97_controls),
+	.component_driver = {
+		.controls		= stac9766_snd_ac97_controls,
+		.num_controls		= ARRAY_SIZE(stac9766_snd_ac97_controls),
+	},
 	.write = stac9766_ac97_write,
 	.read = stac9766_ac97_read,
 	.set_bias_level = stac9766_set_bias_level,
-- 
2.8.1
