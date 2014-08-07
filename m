From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] ASoC: wm8962: Correct the bit offset to enable mono speaker output
Date: Thu, 7 Aug 2014 19:55:49 +0800
Message-ID: <1407412549-14983-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, rf@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.de, perex@perex.cz, ckeepax@opensource.wolfsonmicro.com, B18700@freescale.com, b02247@freescale.com
List-Id: alsa-devel@alsa-project.org

As WM8962 datasheet describes for SPK_MONO bit of R51: When SPK_MONO
is set to '1', both speakers output the signal from the left channel.

So for mono speaker widget, we shall enable Left Channel whose enable
bit is 6 instead of 7 (Right Channel).

This patches just simply corrects the bit offset.

Signed-off-by: Peter Chan <B18700@freescale.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---

@Peter
I cced you just to let you know that I'm merging your fix to upstream.
And because you patch can't be applied to the upstream tree directly,
I used my own commit with your signed-off. Thank you for the fix.

 sound/soc/codecs/wm8962.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 1098ae3..105deec 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2185,7 +2185,7 @@ SND_SOC_DAPM_MIXER("Speaker Mixer", WM8962_MIXER_ENABLES, 1, 0,
 		   spkmixl, ARRAY_SIZE(spkmixl)),
 SND_SOC_DAPM_MUX_E("Speaker PGA", WM8962_PWR_MGMT_2, 4, 0, &spkoutl_mux,
 		   out_pga_event, SND_SOC_DAPM_POST_PMU),
-SND_SOC_DAPM_PGA("Speaker Output", WM8962_CLASS_D_CONTROL_1, 7, 0, NULL, 0),
+SND_SOC_DAPM_PGA("Speaker Output", WM8962_CLASS_D_CONTROL_1, 6, 0, NULL, 0),
 SND_SOC_DAPM_OUTPUT("SPKOUT"),
 };
 
-- 
1.8.4
