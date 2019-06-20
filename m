From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH] ASoC: rk3399_gru_sound: Support 32, 44.1 and 88.2 kHz sample rates
Date: Thu, 20 Jun 2019 15:47:08 +0200
Message-ID: <20190620134708.28311-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Collabora Kernel ML <kernel@collabora.com>, Xing Zheng <zhengxing@rock-chips.com>, Benson Leung <bleung@chromium.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

According to the datasheet the max98357a also supports 32, 44.1 and
88.2 kHz sample rate. This support was also introduced recently by
commit fdf34366d324 ("ASoC: max98357a: add missing supported rates").
This patch adds support for these rates also for the machine driver so
we get rid of the errors like the below and we are able to play files
using these sample rates.

  rk3399-gru-sound sound: rockchip_sound_max98357a_hw_params() doesn't support this sample rate: 44100
  rk3399-gru-sound sound: ASoC: machine hw_params failed: -22

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 sound/soc/rockchip/rk3399_gru_sound.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 3d0cc6e90d7b..8dfe1a560e42 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -59,7 +59,10 @@ static int rockchip_sound_max98357a_hw_params(struct snd_pcm_substream *substrea
 	switch (params_rate(params)) {
 	case 8000:
 	case 16000:
+	case 32000:
+	case 44100:
 	case 48000:
+	case 88200:
 	case 96000:
 		mclk = params_rate(params) * SOUND_FS;
 		break;
-- 
2.20.1
