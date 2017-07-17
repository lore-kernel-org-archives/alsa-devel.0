From: srinivas.kandagatla@linaro.org
Subject: [PATCH 2/2] drm/bridge: adv7511: restrict audio sample sizes
Date: Mon, 17 Jul 2017 16:02:27 +0200
Message-ID: <20170717140227.17312-3-srinivas.kandagatla@linaro.org>
References: <20170717140227.17312-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170717140227.17312-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

ADV7533 only supports audio samples word width from 16-24 bits.
This patch restricts the audio sample sizes to the supported ones,
so that sound card does not report wrong list of supported hwparms.

Without this patch aplay would fail when playing a 32 bit audio.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
index 67469c26bae8..d01d0aa0eef7 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
@@ -214,6 +214,8 @@ static struct hdmi_codec_pdata codec_data = {
 	.ops = &adv7511_codec_ops,
 	.max_i2s_channels = 2,
 	.i2s = 1,
+	.formats = (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |
+		    SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE),
 };
 
 int adv7511_audio_init(struct device *dev, struct adv7511 *adv7511)
-- 
2.11.0
