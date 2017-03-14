From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RFC PATCH] ASoC: wm8960: Use physical width for bclk
Date: Tue, 14 Mar 2017 18:57:02 +0200
Message-ID: <1489510622-30981-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com
Cc: ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, shengjiu.wang@freescale.com, mihai.serban@nxp.com, viorel.suman@nxp.com
List-Id: alsa-devel@alsa-project.org

bclk is derived from sysclk with the help of bclk_divs. Anyhow, for
S20_3LE format there is no bclk_divs that could be used to derive
an exact bclk.

We can fix this by using storage size instead the exact
number of bits of the sample when computing bclk.

With this approach we can play S20_3LE encoded files at the cost of
some unused BCLK cycles for S20_3LE and S24_LE.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/codecs/wm8960.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index e1429e3..18ca5fc 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -722,7 +722,8 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	int i;
 
-	wm8960->bclk = snd_soc_params_to_bclk(params);
+	wm8960->bclk = params_physical_width(params) *
+		params_channels(params) * params_rate(params);
 	if (params_channels(params) == 1)
 		wm8960->bclk *= 2;
 
-- 
2.7.4
