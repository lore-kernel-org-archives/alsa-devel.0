From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/2] ASoC: tfa9879: switch to using .probe_new
Date: Wed, 11 Apr 2018 14:42:38 +0200
Message-ID: <20180411124238.9385-2-peda@axentia.se>
References: <20180411124238.9385-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180411124238.9385-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use the new probe style for i2c drivers.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/tfa9879.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tfa9879.c b/sound/soc/codecs/tfa9879.c
index e7ca764b5729..15c769528d6d 100644
--- a/sound/soc/codecs/tfa9879.c
+++ b/sound/soc/codecs/tfa9879.c
@@ -274,8 +274,7 @@ static struct snd_soc_dai_driver tfa9879_dai = {
 	.ops = &tfa9879_dai_ops,
 };
 
-static int tfa9879_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static int tfa9879_i2c_probe(struct i2c_client *i2c)
 {
 	struct tfa9879_priv *tfa9879;
 	int i;
@@ -323,7 +322,7 @@ static struct i2c_driver tfa9879_i2c_driver = {
 		.name = "tfa9879",
 		.of_match_table = tfa9879_of_match,
 	},
-	.probe = tfa9879_i2c_probe,
+	.probe_new = tfa9879_i2c_probe,
 	.remove = tfa9879_i2c_remove,
 	.id_table = tfa9879_i2c_id,
 };
-- 
2.11.0
