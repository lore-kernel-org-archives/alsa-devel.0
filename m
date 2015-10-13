From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: wm8904: harmless underflow in wm8904_put_deemph()
Date: Tue, 13 Oct 2015 10:08:18 +0300
Message-ID: <20151013070818.GB31537@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Bo Shen <voice.shen@atmel.com>, Alexander Morozov <linux@meltdown.ru>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Fabio Estevam <fabio.estevam@freescale.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We try to check that "deemph" is zero or one, but because of an
underflow bug, it can also be negative.  It's fine, negative values are
handled as non-zero.  But it's messy and static checkers complain so
let's fix it.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index b783743..2aa23f1 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -534,7 +534,7 @@ static int wm8904_put_deemph(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
-	int deemph = ucontrol->value.integer.value[0];
+	unsigned int deemph = ucontrol->value.integer.value[0];
 
 	if (deemph > 1)
 		return -EINVAL;
