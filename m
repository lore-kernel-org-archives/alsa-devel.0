From: Xing Zheng <zhengxing@rock-chips.com>
Subject: [PATCH 3/3] ASoC: da7219: Add detect_jack callback in the snd_soc_codec_driver
Date: Mon, 18 Apr 2016 16:17:32 +0800
Message-ID: <1460967452-24574-4-git-send-email-zhengxing@rock-chips.com>
References: <1460967452-24574-1-git-send-email-zhengxing@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460967452-24574-1-git-send-email-zhengxing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de, Adam.Thomson@diasemi.com, sugar.zhang@rock-chips.com, jay.xu@rock-chips.com, broonie@kernel.org, Xing Zheng <zhengxing@rock-chips.com>, Support Opensource <support.opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch tell soc-jack that this codec supports jack detection.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 sound/soc/codecs/da7219.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 81c0708..5a8ff1e 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1767,6 +1767,8 @@ static struct snd_soc_codec_driver soc_codec_dev_da7219 = {
 	.num_dapm_widgets	= ARRAY_SIZE(da7219_dapm_widgets),
 	.dapm_routes		= da7219_audio_map,
 	.num_dapm_routes	= ARRAY_SIZE(da7219_audio_map),
+
+	.detect_jack		= da7219_aad_jack_det,
 };
 
 
-- 
1.7.9.5
