From: srinivas.kandagatla@linaro.org
Subject: [PATCH 0/2] ASoC: hdmi-codec: Allow driver to restrict sample size
Date: Mon, 17 Jul 2017 16:02:25 +0200
Message-ID: <20170717140227.17312-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds option to allow hdmi-codec drivers to restrict
the audio sample size based on the values that are suppored in hardware.

First patch is adding that formats option to hdmi_codec_pdata and
second patch is a fix in adv7511 codec driver which only supports
16 and 24 bit samples.

Srinivas Kandagatla (2):
  ASoC: hdmi-codec: Allow drivers to restrict sample sizes.
  drm/bridge: adv7511: restrict audio sample sizes

 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 2 ++
 include/sound/hdmi-codec.h                     | 1 +
 sound/soc/codecs/hdmi-codec.c                  | 3 +++
 3 files changed, 6 insertions(+)

-- 
2.11.0
