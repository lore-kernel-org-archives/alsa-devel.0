From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v2 2/3] ASoC: rockchip-max98090: Allow more sample rates
Date: Fri,  6 Nov 2015 19:38:15 +0800
Message-ID: <1446809896-11254-3-git-send-email-wxt@rock-chips.com>
References: <1446809896-11254-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446809896-11254-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>
Cc: kmixter@chromium.org, Sonny Rao <sonnyrao@chromium.org>, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Dylan Reid <dgreid@chromium.org>, benchan@chromium.org, Cheng-Yi Chiang <cychiang@chromium.org>, Caesar Wang <wxt@rock-chips.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The MAX98090 audio codec support sample rates from 8 to 96 kHz
as the dai claim.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v2:
- add the 64000 sample rates for max98090.

 sound/soc/rockchip/rockchip_max98090.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index 26567b1..5436102 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -80,11 +80,17 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 	switch (params_rate(params)) {
 	case 8000:
 	case 16000:
+	case 24000:
+	case 32000:
 	case 48000:
+	case 64000:
 	case 96000:
 		mclk = 12288000;
 		break;
+	case 11025:
+	case 22050:
 	case 44100:
+	case 88200:
 		mclk = 11289600;
 		break;
 	default:
-- 
1.9.1
