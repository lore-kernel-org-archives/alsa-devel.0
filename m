From: Xing Zheng <zhengxing@rock-chips.com>
Subject: [PATCH] ASoC: rt5616: Add support sample rate to 192KHz
Date: Fri, 29 Jan 2016 18:44:38 +0800
Message-ID: <1454064278-5791-1-git-send-email-zhengxing@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-rockchip@lists.infradead.org, bardliao@realtek.com, john.lin@realtek.com
Cc: keescook@google.com, leozwang@google.com, heiko@sntech.de, Xing Zheng <zhengxing@rock-chips.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Reference the TRM, the ALC5616 support one 24bit/8KHz ~ 192KHz
I2S/PCM Interface for stereo DAC and stereo ADC.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 sound/soc/codecs/rt5616.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5616.c b/sound/soc/codecs/rt5616.c
index 1c10d8e..3220e5c 100644
--- a/sound/soc/codecs/rt5616.c
+++ b/sound/soc/codecs/rt5616.c
@@ -1218,7 +1218,7 @@ static int rt5616_resume(struct snd_soc_codec *codec)
 #define rt5616_resume NULL
 #endif
 
-#define RT5616_STEREO_RATES SNDRV_PCM_RATE_8000_96000
+#define RT5616_STEREO_RATES SNDRV_PCM_RATE_8000_192000
 #define RT5616_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-- 
1.7.9.5
