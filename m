From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] ASoC: cs53l30: Set .of_match_table to OF device ID table
Date: Tue,  4 Apr 2017 14:59:30 -0400
Message-ID: <20170404185930.1437-1-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The driver has an OF device ID table but the struct i2c_driver
.of_match_table field is not set.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 sound/soc/codecs/cs53l30.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index cb47fb595ff4..1e0d5973b758 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -1130,6 +1130,7 @@ MODULE_DEVICE_TABLE(i2c, cs53l30_id);
 static struct i2c_driver cs53l30_i2c_driver = {
 	.driver = {
 		.name = "cs53l30",
+		.of_match_table = cs53l30_of_match,
 		.pm = &cs53l30_runtime_pm,
 	},
 	.id_table = cs53l30_id,
-- 
2.9.3
