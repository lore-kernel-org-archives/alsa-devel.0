From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH] ASoC: rockchip: rockchip_max98090: Set period size to 240
Date: Tue, 13 Aug 2019 15:44:30 +0800
Message-ID: <20190813074430.191791-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, dgreid@chromium.org, tzungbi@chromium.org, zhengxing@rock-chips.com, cain.cai@rock-chips.com, eddie.cai@rock-chips.com, jeffy.chen@rock-chips.com, enric.balletbo@collabora.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

>From stress testing of arecord, we found that period size
greater than ~900 will bring pl330 to DYING state and
can not recover within 100 iterations.
The result is that arecord will stuck and get I/O error,
and issue can not be recovered until reboot.

This issue does not happen when period size is small.
Set constraint of period size to 240 to prevent such issue.
With the constraint, there will be no issue after 2000 iterations.

We can revert this patch once the root cause is found
in rockchip's pl330 implementation.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/rockchip/rockchip_max98090.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index 7b0c21fa6dca..0097df1fae66 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -137,8 +137,19 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static int rk_aif1_startup(struct snd_pcm_substream *substream)
+{
+	/*
+	 * Set period size to 240 because pl330 has issue
+	 * dealing with larger period in stress testing.
+	 */
+	return snd_pcm_hw_constraint_minmax(substream->runtime,
+			SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 240, 240);
+}
+
 static const struct snd_soc_ops rk_aif1_ops = {
 	.hw_params = rk_aif1_hw_params,
+	.startup = rk_aif1_startup,
 };
 
 SND_SOC_DAILINK_DEFS(hifi,
-- 
2.23.0.rc1.153.gdeed80330f-goog
