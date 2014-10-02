From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] ASoC: tas2552: Fix compilation warning for !PM_RUNTIME
Date: Thu,  2 Oct 2014 09:28:00 +0200
Message-ID: <1412234880-8308-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Thierry Reding <treding@nvidia.com>

The tas2552_sw_shutdown() function is only used by runtime suspend
support, so only build it when necessary.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 sound/soc/codecs/tas2552.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 1ed57a7e57b6..f039dc825971 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -115,6 +115,7 @@ static const struct snd_soc_dapm_route tas2552_audio_map[] = {
 	{"ClassD", NULL, "PLL"},
 };
 
+#ifdef CONFIG_PM_RUNTIME
 static void tas2552_sw_shutdown(struct tas2552_data *tas_data, int sw_shutdown)
 {
 	u8 cfg1_reg;
@@ -127,6 +128,7 @@ static void tas2552_sw_shutdown(struct tas2552_data *tas_data, int sw_shutdown)
 	snd_soc_update_bits(tas_data->codec, TAS2552_CFG_1,
 						 TAS2552_SWS_MASK, cfg1_reg);
 }
+#endif
 
 static int tas2552_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
-- 
2.1.0
