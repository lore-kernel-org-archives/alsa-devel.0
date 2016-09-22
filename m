From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: cq93vc: duplicated callback function goes to component
Date: Thu, 22 Sep 2016 11:37:32 +0200
Message-ID: <20160922093756.2093879-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

A cleanup removed a couple of members from struct snd_soc_codec_driver
after changing codec drivers to no longer use them, but one codec
was missed in the process, giving a build error:

sound/soc/codecs/cq93vc.c:134:2: error: unknown field 'controls' specified in initializer
  .controls = cq93vc_snd_controls,

This moves the members from the cq93vc codec driver to its component driver
just like the other codecs already had.

Fixes: 8073aefa6082 ("ASoC: remove codec duplicated callback function")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/cq93vc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 1c895a53001d..7a2d9a2ee427 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -131,8 +131,10 @@ static struct regmap *cq93vc_get_regmap(struct device *dev)
 static struct snd_soc_codec_driver soc_codec_dev_cq93vc = {
 	.set_bias_level = cq93vc_set_bias_level,
 	.get_regmap = cq93vc_get_regmap,
-	.controls = cq93vc_snd_controls,
-	.num_controls = ARRAY_SIZE(cq93vc_snd_controls),
+	.component_driver = {
+		.controls = cq93vc_snd_controls,
+		.num_controls = ARRAY_SIZE(cq93vc_snd_controls),
+	},
 };
 
 static int cq93vc_platform_probe(struct platform_device *pdev)
-- 
2.9.0
