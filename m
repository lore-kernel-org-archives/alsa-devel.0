From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: [PATCH] ASoC: cs4271: configure reset GPIO as output
Date: Sat, 29 Apr 2017 12:19:33 +0200
Message-ID: <20170429101933.9694-1-alexander.sverdlin@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, "# 4 . 6+" <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

During reset "refactoring" the output configuration was lost.
This commit repairs sound on EDB93XX boards.

Fixes: 9a397f4 ("ASoC: cs4271: add regulator consumer support")
Cc: Brian Austin <brian.austin@cirrus.com>
Cc: Paul Handrigan <Paul.Handrigan@cirrus.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: <stable@vger.kernel.org> # 4.6+
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 sound/soc/codecs/cs4271.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 8c0f3b8..e78b5f0 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -498,7 +498,7 @@ static int cs4271_reset(struct snd_soc_codec *codec)
 	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
 
 	if (gpio_is_valid(cs4271->gpio_nreset)) {
-		gpio_set_value(cs4271->gpio_nreset, 0);
+		gpio_direction_output(cs4271->gpio_nreset, 0);
 		mdelay(1);
 		gpio_set_value(cs4271->gpio_nreset, 1);
 		mdelay(1);
-- 
2.10.2
