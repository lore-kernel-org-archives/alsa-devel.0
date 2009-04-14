From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 12/14] ASoC: Move the WM9713 voice DAC
	powerdown to a DAPM event
Date: Tue, 14 Apr 2009 13:33:11 +0100
Message-ID: <1239712393-6428-13-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090414123220.GA6342@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BB0A124354
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 14:33:17 +0200 (CEST)
In-Reply-To: <20090414123220.GA6342@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This ensures that we sync with the DAPM powerdown sequencing properly
and don't need to bounce the power on the voice DAC so often.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9713.c |   39 ++++++++++++++++++++++-----------------
 1 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index aa94cc6..a6feb78 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -189,6 +189,26 @@ SOC_SINGLE("3D Lower Cut-off Switch", AC97_REC_GAIN_MIC, 4, 1, 0),
 SOC_SINGLE("3D Depth", AC97_REC_GAIN_MIC, 0, 15, 1),
 };
 
+static int wm9713_voice_shutdown(struct snd_soc_dapm_widget *w,
+				 struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	u16 status, rate;
+
+	BUG_ON(event != SND_SOC_DAPM_PRE_PMD);
+
+	/* Gracefully shut down the voice interface. */
+	status = ac97_read(codec, AC97_EXTENDED_MID) | 0x1000;
+	rate = ac97_read(codec, AC97_HANDSET_RATE) & 0xF0FF;
+	ac97_write(codec, AC97_HANDSET_RATE, rate | 0x0200);
+	schedule_timeout_interruptible(msecs_to_jiffies(1));
+	ac97_write(codec, AC97_HANDSET_RATE, rate | 0x0F00);
+	ac97_write(codec, AC97_EXTENDED_MID, status);
+
+	return 0;
+}
+
+
 /* We have to create a fake left and right HP mixers because
  * the codec only has a single control that is shared by both channels.
  * This makes it impossible to determine the audio path using the current
@@ -400,7 +420,8 @@ SND_SOC_DAPM_MIXER("AC97 Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
 SND_SOC_DAPM_MIXER("HP Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
 SND_SOC_DAPM_MIXER("Line Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
 SND_SOC_DAPM_MIXER("Capture Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
-SND_SOC_DAPM_DAC("Voice DAC", "Voice Playback", AC97_EXTENDED_MID, 12, 1),
+SND_SOC_DAPM_DAC_E("Voice DAC", "Voice Playback", AC97_EXTENDED_MID, 12, 1,
+		   wm9713_voice_shutdown, SND_SOC_DAPM_PRE_PMD),
 SND_SOC_DAPM_DAC("Aux DAC", "Aux Playback", AC97_EXTENDED_MID, 11, 1),
 SND_SOC_DAPM_PGA("Left ADC", AC97_EXTENDED_MID, 5, 1, NULL, 0),
 SND_SOC_DAPM_PGA("Right ADC", AC97_EXTENDED_MID, 4, 1, NULL, 0),
@@ -936,21 +957,6 @@ static int wm9713_pcm_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static void wm9713_voiceshutdown(struct snd_pcm_substream *substream,
-				 struct snd_soc_dai *dai)
-{
-	struct snd_soc_codec *codec = dai->codec;
-	u16 status, rate;
-
-	/* Gracefully shut down the voice interface. */
-	status = ac97_read(codec, AC97_EXTENDED_STATUS) | 0x1000;
-	rate = ac97_read(codec, AC97_HANDSET_RATE) & 0xF0FF;
-	ac97_write(codec, AC97_HANDSET_RATE, rate | 0x0200);
-	schedule_timeout_interruptible(msecs_to_jiffies(1));
-	ac97_write(codec, AC97_HANDSET_RATE, rate | 0x0F00);
-	ac97_write(codec, AC97_EXTENDED_MID, status);
-}
-
 static int ac97_hifi_prepare(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
@@ -1019,7 +1025,6 @@ static struct snd_soc_dai_ops wm9713_dai_ops_aux = {
 
 static struct snd_soc_dai_ops wm9713_dai_ops_voice = {
 	.hw_params	= wm9713_pcm_hw_params,
-	.shutdown	= wm9713_voiceshutdown,
 	.set_clkdiv	= wm9713_set_dai_clkdiv,
 	.set_pll	= wm9713_set_dai_pll,
 	.set_fmt	= wm9713_set_dai_fmt,
-- 
1.6.2.2
