From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: wm8955: harmless underflow in wm8955_put_deemph()
Date: Tue, 13 Oct 2015 10:10:48 +0300
Message-ID: <20151013071048.GG31537@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Axel Lin <axel.lin@ingics.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Valid values for "deemph" are zero and one, but we mistakenly allow
negative values as well.  It's harmless but we may as well clean it up.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index 12e4435..9db00d5 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -402,7 +402,7 @@ static int wm8955_put_deemph(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8955_priv *wm8955 = snd_soc_codec_get_drvdata(codec);
-	int deemph = ucontrol->value.integer.value[0];
+	unsigned int deemph = ucontrol->value.integer.value[0];
 
 	if (deemph > 1)
 		return -EINVAL;
