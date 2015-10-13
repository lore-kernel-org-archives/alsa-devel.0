From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: wm8903: harmless underflow in wm8903_put_deemph()
Date: Tue, 13 Oct 2015 10:10:18 +0300
Message-ID: <20151013071018.GF31537@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Axel Lin <axel.lin@ingics.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, abdoulaye berthe <berthe.ab@gmail.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Valid values for "deemph" are zero and one, but we accidentally allow
negative values as well.  It's harmless, but static checkers complain
and we may as well clean it up.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index b011253..e4cc41e 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -452,7 +452,7 @@ static int wm8903_put_deemph(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
-	int deemph = ucontrol->value.integer.value[0];
+	unsigned int deemph = ucontrol->value.integer.value[0];
 	int ret = 0;
 
 	if (deemph > 1)
