From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v2] ASoC: tlv320dac33: Power down digital parts,
	when not needed
Date: Fri, 10 Dec 2010 13:26:31 +0200
Message-ID: <1291980391-5202-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id DFE882443A
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 12:26:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

If the following scenario has been followed:
1. Enable analog bypass
amixer sset 'Analog Left Bypass' on
amixer sset 'Analog Right Bypass' on

2. Start playback
aplay -fdat -d3 /dev/zero

After the playback stopped (3 sec), and the soc timeout (5 sec),
the digital parts of the codec will remain powered up.
This means that the DAI clocks are continue to run, the
oscillator remain operational, etc.

Use the SND_SOC_DAPM_POST_PMD widget to get notification
about the stopped stream, and power down the digital
part of the codec.
If the analog bypass is enabled, than the codec will remain in
BIAS_ON level, and things will work correctly.
In case, if the bypass is disabled, than the codec will
fall to BIAS_STANDBY than to BIAS_OFF level, as it used
to.

The digital part of DAC33 is initialized at every stream start
(DAPM_PRE:PRE_PMU event), so subsequent streams (within 5 sec)
will have working DAI.
When the codec is coming out from BIAS_OFF, the full power-up
sequence followed by the same DAPM_PRE widget event will power up
the digital part.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/tlv320dac33.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index b3445b3..776ac80 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -354,6 +354,21 @@ static inline void dac33_soft_power(struct snd_soc_codec *codec, int power)
 	dac33_write(codec, DAC33_PWR_CTRL, reg);
 }
 
+static inline void dac33_disable_digital(struct snd_soc_codec *codec)
+{
+	u8 reg;
+
+	/* Stop the DAI clock */
+	reg = dac33_read_reg_cache(codec, DAC33_SER_AUDIOIF_CTRL_B);
+	reg &= ~DAC33_BCLKON;
+	dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_B, reg);
+
+	/* Power down the Oscillator, and DACs */
+	reg = dac33_read_reg_cache(codec, DAC33_PWR_CTRL);
+	reg &= ~(DAC33_OSCPDNB | DAC33_DACRPDNB | DAC33_DACLPDNB);
+	dac33_write(codec, DAC33_PWR_CTRL, reg);
+}
+
 static int dac33_hard_power(struct snd_soc_codec *codec, int power)
 {
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
@@ -402,7 +417,7 @@ exit:
 	return ret;
 }
 
-static int playback_event(struct snd_soc_dapm_widget *w,
+static int dac33_playback_event(struct snd_soc_dapm_widget *w,
 		struct snd_kcontrol *kcontrol, int event)
 {
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(w->codec);
@@ -414,6 +429,9 @@ static int playback_event(struct snd_soc_dapm_widget *w,
 			dac33_prepare_chip(dac33->substream);
 		}
 		break;
+	case SND_SOC_DAPM_POST_PMD:
+		dac33_disable_digital(w->codec);
+		break;
 	}
 	return 0;
 }
@@ -609,7 +627,8 @@ static const struct snd_soc_dapm_widget dac33_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("Right DAC Power",
 			    DAC33_RDAC_PWR_CTRL, 2, 0, NULL, 0),
 
-	SND_SOC_DAPM_PRE("Prepare Playback", playback_event),
+	SND_SOC_DAPM_PRE("Pre Playback", dac33_playback_event),
+	SND_SOC_DAPM_POST("Post Playback", dac33_playback_event),
 };
 
 static const struct snd_soc_dapm_route audio_map[] = {
-- 
1.7.3.3
