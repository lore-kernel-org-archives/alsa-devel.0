From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v1 3/5] ASoC: rockchip-rt5645: Allow more sample rates
Date: Tue,  3 Nov 2015 09:33:56 +0800
Message-ID: <1446514438-13922-4-git-send-email-wxt@rock-chips.com>
References: <1446514438-13922-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446514438-13922-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>
Cc: Sonny Rao <sonnyrao@chromium.org>, Dylan Reid <dgreid@chromium.org>, Doug Anderson <dianders@chromium.org>, Cheng-Yi Chiang <cychiang@chromium.org>, linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The RT5645 audio codec support sample rates from 8 to 96 kHz
as the dai claim.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v1: None

 sound/soc/rockchip/rockchip_rt5645.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_rt5645.c b/sound/soc/rockchip/rockchip_rt5645.c
index 68c62e4..edff07f 100644
--- a/sound/soc/rockchip/rockchip_rt5645.c
+++ b/sound/soc/rockchip/rockchip_rt5645.c
@@ -79,11 +79,16 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 	switch (params_rate(params)) {
 	case 8000:
 	case 16000:
+	case 24000:
+	case 32000:
 	case 48000:
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
