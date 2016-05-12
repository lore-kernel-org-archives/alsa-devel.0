From: John Keeping <john@metanate.com>
Subject: [PATCH] ASoC: dapm: deprecate MICBIAS widget type
Date: Thu, 12 May 2016 13:55:53 +0100
Message-ID: <20160512125553.8523-1-john@metanate.com>
References: <20160512111216.GD6261@sirena.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160512111216.GD6261@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: John Keeping <john@metanate.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Commit 086d7f804e26 ("ASoC: Convert WM8962 MICBIAS to a supply widget",
2011-09-23) says:

	A supply widget is generally clearer than a MICBIAS widget and a
	mic bias is just a type of supply so use a supply widget for the
	MICBIAS. This also avoids confusion with the routing when
	connected to multiple inputs.

but this has never been documented as a policy.  Add some comments to
make it clear.

Signed-off-by: John Keeping <john@metanate.com>
---
 include/sound/soc-dapm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 97069466c38d..3101d53468aa 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -100,6 +100,7 @@ struct device;
 {       .id = snd_soc_dapm_mixer_named_ctl, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = wncontrols}
+/* DEPRECATED: use SND_SOC_DAPM_SUPPLY */
 #define SND_SOC_DAPM_MICBIAS(wname, wreg, wshift, winvert) \
 {	.id = snd_soc_dapm_micbias, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
@@ -473,7 +474,7 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_out_drv,			/* output driver */
 	snd_soc_dapm_adc,			/* analog to digital converter */
 	snd_soc_dapm_dac,			/* digital to analog converter */
-	snd_soc_dapm_micbias,		/* microphone bias (power) */
+	snd_soc_dapm_micbias,		/* microphone bias (power) - DEPRECATED: use snd_soc_dapm_supply */
 	snd_soc_dapm_mic,			/* microphone */
 	snd_soc_dapm_hp,			/* headphones */
 	snd_soc_dapm_spk,			/* speaker */
-- 
2.8.2.565.gdb84f68.dirty
