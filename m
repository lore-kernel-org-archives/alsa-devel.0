From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: wm9705: Remove ac97_read/ac97_write
	wrappers
Date: Fri, 21 Oct 2016 10:27:08 +0200
Message-ID: <1477038428-4480-2-git-send-email-lars@metafoo.de>
References: <1477038428-4480-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FD3A267164
 for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2016 10:27:15 +0200 (CEST)
In-Reply-To: <1477038428-4480-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Since the regmap conversion ac97_read/ac97_write are just simple wrappers
around snd_soc_read/snd_soc_write. Use those instead directly and remove
the wrappers.

Also use snd_soc_update_bits() where appropriate.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm9705.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 70ab607..e73ff61 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -226,33 +226,20 @@ static const struct snd_soc_dapm_route wm9705_audio_map[] = {
 	{"Right ADC", NULL, "ADC PGA"},
 };
 
-static unsigned int ac97_read(struct snd_soc_codec *codec, unsigned int reg)
-{
-	return snd_soc_read(codec, reg);
-}
-
-static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int val)
-{
-	return snd_soc_write(codec, reg, val);
-}
-
 static int ac97_prepare(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	int reg;
-	u16 vra;
 
-	vra = ac97_read(codec, AC97_EXTENDED_STATUS);
-	ac97_write(codec, AC97_EXTENDED_STATUS, vra | 0x1);
+	snd_soc_update_bits(codec, AC97_EXTENDED_STATUS, 0x1, 0x1);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		reg = AC97_PCM_FRONT_DAC_RATE;
 	else
 		reg = AC97_PCM_LR_ADC_RATE;
 
-	return ac97_write(codec, reg, substream->runtime->rate);
+	return snd_soc_write(codec, reg, substream->runtime->rate);
 }
 
 #define WM9705_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | \
@@ -299,7 +286,7 @@ static struct snd_soc_dai_driver wm9705_dai[] = {
 static int wm9705_soc_suspend(struct snd_soc_codec *codec)
 {
 	regcache_cache_bypass(codec->component.regmap, true);
-	ac97_write(codec, AC97_POWERDOWN, 0xffff);
+	snd_soc_write(codec, AC97_POWERDOWN, 0xffff);
 	regcache_cache_bypass(codec->component.regmap, false);
 
 	return 0;
-- 
2.1.4
