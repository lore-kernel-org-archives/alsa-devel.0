From: srinivas.kandagatla@linaro.org
Subject: [PATCH 1/2] ASoC: hdmi-codec: Allow drivers to restrict sample sizes.
Date: Mon, 17 Jul 2017 16:02:26 +0200
Message-ID: <20170717140227.17312-2-srinivas.kandagatla@linaro.org>
References: <20170717140227.17312-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170717140227.17312-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Currently hdmi client drivers does have means to limit the
sample sizes that it can only support. Having formats parameter
option would solve this.

This issue was noticed on DB410c board when adv7511 hdmi codec driver
failed to play a 32 bits audio samples, as it does not support them.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/sound/hdmi-codec.h    | 1 +
 sound/soc/codecs/hdmi-codec.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
index 9483c55f871b..89fc4cce5785 100644
--- a/include/sound/hdmi-codec.h
+++ b/include/sound/hdmi-codec.h
@@ -104,6 +104,7 @@ struct hdmi_codec_pdata {
 	uint i2s:1;
 	uint spdif:1;
 	int max_i2s_channels;
+	u64 formats;
 	void *data;
 };
 
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 22ed0dc88f0a..1ece73f4be92 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -780,6 +780,9 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 		hcp->daidrv[i] = hdmi_i2s_dai;
 		hcp->daidrv[i].playback.channels_max =
 			hcd->max_i2s_channels;
+
+		if (hcd->formats)
+			hcp->daidrv[i].playback.formats = hcd->formats;
 		i++;
 	}
 
-- 
2.11.0
