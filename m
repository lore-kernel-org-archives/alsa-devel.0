From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH] ASoC: codecs-ac97: Remove rate constraints
Date: Sun, 10 May 2015 00:09:57 +0200
Message-ID: <554E85B5.30107@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id C91B82607C8
 for <alsa-devel@alsa-project.org>; Sun, 10 May 2015 00:10:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, Wolfram Sang <wsa@the-dreams.de>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Remove rate constraints from generic ASoC AC'97 CODEC.
    
Supported rates should be detected and constrained anyway by
AC'97 generic code - was tested with VT1613 CODEC and iMX6 SSI
controller.

This way this driver can be used for platforms which don't need
specialized AC'97 CODEC drivers while at the same avoiding
code duplication from implementing equivalent functionality in
a controller driver.
    
Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>

--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -44,10 +44,6 @@ static int ac97_prepare(struct snd_pcm_substream *substream,
 	return snd_ac97_set_rate(ac97, reg, substream->runtime->rate);
 }
 
-#define STD_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
-		SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 |\
-		SNDRV_PCM_RATE_48000)
-
 static const struct snd_soc_dai_ops ac97_dai_ops = {
 	.prepare	= ac97_prepare,
 };
@@ -58,13 +54,13 @@ static struct snd_soc_dai_driver ac97_dai = {
 		.stream_name = "AC97 Playback",
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = STD_AC97_RATES,
+		.rates = SNDRV_PCM_RATE_KNOT,
 		.formats = SND_SOC_STD_AC97_FMTS,},
 	.capture = {
 		.stream_name = "AC97 Capture",
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = STD_AC97_RATES,
+		.rates = SNDRV_PCM_RATE_KNOT,
 		.formats = SND_SOC_STD_AC97_FMTS,},
 	.ops = &ac97_dai_ops,
 };
