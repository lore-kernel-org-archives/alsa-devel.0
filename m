From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: es8328: harmless underflow in es8328_put_deemph()
Date: Tue, 13 Oct 2015 10:11:09 +0300
Message-ID: <20151013071109.GH31537@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Valid values for "deemph" are zero and one but we accidentally allow
negative values as well.  It's harmless but it causes static checker
warnings and we may as well clean it up.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 6a09101..969e337 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -129,7 +129,7 @@ static int es8328_put_deemph(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct es8328_priv *es8328 = snd_soc_codec_get_drvdata(codec);
-	int deemph = ucontrol->value.integer.value[0];
+	unsigned int deemph = ucontrol->value.integer.value[0];
 	int ret;
 
 	if (deemph > 1)
