From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] ASoC: atmel: tse850: fix off-by-one in the "ANA" enumeration count
Date: Wed, 31 May 2017 14:32:33 +0200
Message-ID: <1496233953-758-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Nicolas Ferre <nicolas.ferre@microchip.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

At some point I added the "Low" entry at the beginning of the array
without bumping the enumeration count from 9 to 10. Fix this. While at
it, fix the anti-pattern for the other enumeration (used by MUX{1,2}).

Fixes: aa43112445f0 ("ASoC: atmel: tse850: add ASoC driver for the Axentia TSE-850")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/atmel/tse850-pcm5142.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/tse850-pcm5142.c b/sound/soc/atmel/tse850-pcm5142.c
index a72c7d642026..3a1393283156 100644
--- a/sound/soc/atmel/tse850-pcm5142.c
+++ b/sound/soc/atmel/tse850-pcm5142.c
@@ -227,7 +227,7 @@ int tse850_put_ana(struct snd_kcontrol *kctrl,
 static const char * const mux_text[] = { "Mixer", "Loop" };
 
 static const struct soc_enum mux_enum =
-	SOC_ENUM_SINGLE(SND_SOC_NOPM, 0, 2, mux_text);
+	SOC_ENUM_SINGLE(SND_SOC_NOPM, 0, ARRAY_SIZE(mux_text), mux_text);
 
 static const struct snd_kcontrol_new mux1 =
 	SOC_DAPM_ENUM_EXT("MUX1", mux_enum, tse850_get_mux1, tse850_put_mux1);
@@ -252,7 +252,7 @@ static const char * const ana_text[] = {
 };
 
 static const struct soc_enum ana_enum =
-	SOC_ENUM_SINGLE(SND_SOC_NOPM, 0, 9, ana_text);
+	SOC_ENUM_SINGLE(SND_SOC_NOPM, 0, ARRAY_SIZE(ana_text), ana_text);
 
 static const struct snd_kcontrol_new out =
 	SOC_DAPM_ENUM_EXT("ANA", ana_enum, tse850_get_ana, tse850_put_ana);
-- 
2.1.4
