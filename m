From: niklas.morberg@axis.com, Carlsson@axis.com
Subject: [PATCH] ASoC: adau1761: Ensure DSP_RUN and DSP_ENABLE are disabled
Date: Thu, 29 Nov 2018 08:21:44 +0100
Message-ID: <20181129072144.16208-1-niklasc@axis.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: niklasc@axis.com, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Niklas Carlsson <niklasc@axis.com>

DSP_RUN and DSP_ENABLE needs to be disabled during FW load. This is not
a problem after power-cycling but for soft reboots.

Signed-off-by: Niklas Carlsson <niklasc@axis.com>
---
 sound/soc/codecs/adau1761.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index bef3e9e74c26..3075c13bcbbc 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -460,8 +460,35 @@ static int adau1761_set_bias_level(struct snd_soc_component *component,
 		regmap_update_bits(adau->regmap, ADAU17X1_CLOCK_CONTROL,
 			ADAU17X1_CLOCK_CONTROL_SYSCLK_EN,
 			ADAU17X1_CLOCK_CONTROL_SYSCLK_EN);
-		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF)
+		if (snd_soc_component_get_bias_level(component) ==
+		    SND_SOC_BIAS_OFF) {
+			/*
+			 * When going OFF -> STANDBY, the device can be in two
+			 * states:
+			 * 1) Power-cycled and reset
+			 * 2) Soft reboot
+			 * In the case of soft reboot, we need to sync the HW
+			 * registers even if our regmap reports default values.
+			 * Marking the cache as dirty ensures that both cases
+			 * are handled.
+			 */
+			regcache_mark_dirty(adau->regmap);
 			regcache_sync(adau->regmap);
+			/*
+			 * In order for FW to load correctly, the device needs
+			 * DSP_RUN and DSP_ENABLE to be 0. This might not be the
+			 * case for soft reboots. Ensure that DSP_RUN and
+			 * DSP_ENABLE is 0 by bypassing the cache and write
+			 * directly to HW when going OFF -> STANDBY.
+			 */
+			if (adau17x1_has_dsp(adau)) {
+				regcache_cache_bypass(adau->regmap, true);
+				regmap_write(adau->regmap, ADAU17X1_DSP_RUN, 0);
+				regmap_write(adau->regmap,
+					ADAU17X1_DSP_ENABLE, 0);
+				regcache_cache_bypass(adau->regmap, false);
+			}
+		}
 		break;
 	case SND_SOC_BIAS_OFF:
 		regmap_update_bits(adau->regmap, ADAU17X1_CLOCK_CONTROL,
-- 
2.11.0
