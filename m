From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: wm2000: a couple harmless underflows
Date: Tue, 13 Oct 2015 10:12:45 +0300
Message-ID: <20151013071245.GI31537@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We want these to be zero or one, but by mistake we also accept negative
values.  It's harmless but we should still clean it up.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 786abd0..a67ea10 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -620,7 +620,7 @@ static int wm2000_anc_mode_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
-	int anc_active = ucontrol->value.integer.value[0];
+	unsigned int anc_active = ucontrol->value.integer.value[0];
 	int ret;
 
 	if (anc_active > 1)
@@ -653,7 +653,7 @@ static int wm2000_speaker_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
-	int val = ucontrol->value.integer.value[0];
+	unsigned int val = ucontrol->value.integer.value[0];
 	int ret;
 
 	if (val > 1)
