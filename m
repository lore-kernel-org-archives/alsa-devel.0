From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: wm8731: harmless underflow in wm8731_put_deemph()
Date: Tue, 13 Oct 2015 10:08:57 +0300
Message-ID: <20151013070857.GC31537@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Fabio Estevam <fabio.estevam@freescale.com>, Songjun Wu <songjun.wu@atmel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Axel Lin <axel.lin@ingics.com>, Sergey Kiselev <sergey.kiselev@intel.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The code tries to verify that "deemph" is zero or one, but it fails to
account for that it can be negative.  It's harmless because negatives
are treated the same as one, but we should fix it just to silence the
static checker warning.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index ace8645..07cf1bd 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -132,7 +132,7 @@ static int wm8731_put_deemph(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
-	int deemph = ucontrol->value.integer.value[0];
+	unsigned int deemph = ucontrol->value.integer.value[0];
 	int ret = 0;
 
 	if (deemph > 1)
