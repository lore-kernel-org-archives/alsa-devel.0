From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2] ASoC: wm9713: fix regmap free path
Date: Sat, 20 Feb 2016 20:44:30 +0100
Message-ID: <1455997470-12307-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr
 [80.12.242.123])
 by alsa0.perex.cz (Postfix) with ESMTP id AB56726073D
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 20:44:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Robert Jarzmik <robert.jarzmik@free.fr>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In the conversion to regmap, I assumed that the 2 following functions
was working symetrically:
 - snd_soc_codec_init_regmap()
 - snd_soc_codec_exit_regmap(codec)

As a mater of fact with the current code the regmap is freed twice
because of the devm_() call:
(mutex_lock) from (debugfs_remove_recursive+0x50/0x1d0)
(debugfs_remove_recursive) from (regmap_debugfs_exit+0x1c/0xd4)
(regmap_debugfs_exit) from (regmap_exit+0x28/0xc8)
(regmap_exit) from (release_nodes+0x18c/0x204)
(release_nodes) from (device_release+0x18/0x90)
(device_release) from (kobject_release+0x90/0x1bc)
(kobject_release) from (wm9713_soc_remove+0x1c/0x24)
(wm9713_soc_remove) from (soc_remove_component+0x50/0x7c)
(soc_remove_component) from (soc_remove_dai_links+0x118/0x228)
(soc_remove_dai_links) from (snd_soc_register_card+0x4e4/0xdd4)
(snd_soc_register_card) from (devm_snd_soc_register_card+0x34/0x70)

Fix this by removing the doubled regmap free.

Fixes: 700dadfefc3d ASoC: wm9713: convert to regmap
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: fix the diff second hunk, god knows where it came from.
---
 sound/soc/codecs/wm9713.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 79e143625ac3..dd31a5207527 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1230,7 +1230,6 @@ static int wm9713_soc_remove(struct snd_soc_codec *codec)
 {
 	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
 
-	snd_soc_codec_exit_regmap(codec);
 	snd_soc_free_ac97_codec(wm9713->ac97);
 	return 0;
 }
-- 
2.1.4
