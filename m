From: srinivas.kandagatla@linaro.org
Subject: [PATCH v1 1/6] ASoC: jack: fix snd_soc_codec_set_jack return error
Date: Wed, 26 Jul 2017 02:35:07 +0200
Message-ID: <20170726003512.18965-2-srinivas.kandagatla@linaro.org>
References: <20170726003512.18965-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726003512.18965-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch changes the error code returned by snd_soc_codec_set_jack()
from -EINVAL to -ENOTSUPP. The reason to do this is to make the caller
aware that the underlying codec does not support this callback. This can
make the caller write the code to handle this case properly.
Other reason is that -EINVAL is not the correct error to return in this
case anyway.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/soc-jack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 7daf21f..42ca9f1 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -36,7 +36,7 @@ int snd_soc_codec_set_jack(struct snd_soc_codec *codec,
 	if (codec->driver->set_jack)
 		return codec->driver->set_jack(codec, jack, data);
 	else
-		return -EINVAL;
+		return -ENOTSUPP;
 }
 EXPORT_SYMBOL_GPL(snd_soc_codec_set_jack);
 
-- 
2.9.3
