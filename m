From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2] ASoC: wm9713: fix regmap free path
Date: Mon, 22 Feb 2016 23:35:44 +0100
Message-ID: <1456180544-29108-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

In the conversion to regmap, I assumed that the devm_() variant could be
used in the soc probe function.

As a mater of fact with the current code the regmap is freed twice
because of the devm_() call:
(mutex_lock) from [<c01f6624>] (debugfs_remove_recursive+0x50/0x1d0)
(debugfs_remove_recursive) from [<c02bf800>] (regmap_debugfs_exit+0x1c/0xd4)
(regmap_debugfs_exit) from [<c02ba1f8>] (regmap_exit+0x28/0xc8)
(regmap_exit) from [<c02aa258>] (release_nodes+0x18c/0x204)
(release_nodes) from [<c02a278c>] (device_release+0x18/0x90)
(device_release) from [<c0239030>] (kobject_release+0x90/0x1bc)
(kobject_release) from [<c0395c94>] (wm9713_soc_remove+0x1c/0x24)
(wm9713_soc_remove) from [<c0384884>] (soc_remove_component+0x50/0x7c)
(soc_remove_component) from [<c0386c28>] (soc_remove_dai_links+0x118/0x228)
(soc_remove_dai_links) from [<c038721c>] (snd_soc_register_card+0x4e4/0xdd4)
(snd_soc_register_card) from [<c0393c54>] (devm_snd_soc_register_card+0x34/0x70)

Fix this by replacing the devm_regmap initialization code with the non
devm_() variant.

Fixes: 700dadfefc3d ASoC: wm9713: convert to regmap
Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: changed the fix into removing the devm_() variant
---
 sound/soc/codecs/wm9713.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 4e522302bb8a..edd270f6d8e5 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1212,7 +1212,7 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 	if (IS_ERR(wm9713->ac97))
 		return PTR_ERR(wm9713->ac97);
 
-	regmap = devm_regmap_init_ac97(wm9713->ac97, &wm9713_regmap_config);
+	regmap = regmap_init_ac97(wm9713->ac97, &wm9713_regmap_config);
 	if (IS_ERR(regmap)) {
 		snd_soc_free_ac97_codec(wm9713->ac97);
 		return PTR_ERR(regmap);
-- 
2.1.4
