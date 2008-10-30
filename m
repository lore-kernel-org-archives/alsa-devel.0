From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/8] ASoC: Fix handling of DAPM suspend work
Date: Thu, 30 Oct 2008 15:58:23 +0000
Message-ID: <1225382309-1827-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081030155718.GA1418@rakim.wolfsonmicro.main>
	<1225382309-1827-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D84F2448E
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 16:58:31 +0100 (CET)
In-Reply-To: <1225382309-1827-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@sirena.org.uk>

Since we can query the playback stream power state directly we do not
need to infer if it is powered up from the timer being scheduled.  Doing
this avoids problems that previously existed with streams being
incorrectly determined to be powered up caused when the timer is
scheduled when streams are closed after being partially set up.

Reported-by: Nobin Mathew <nobin.mathew@gmail.com>
Reported-by: Jukka Hynninen <ext-jukka.hynninen@vaisala.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   55 ++++++++++++++++++++-----------------------------
 1 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4707042..411fd3b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -429,51 +429,42 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 		}
 	}
 
-	/* we only want to start a DAPM playback stream if we are not waiting
-	 * on an existing one stopping */
-	if (codec_dai->pop_wait) {
-		/* we are waiting for the delayed work to start */
-		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-				snd_soc_dapm_stream_event(socdev->codec,
-					codec_dai->capture.stream_name,
-					SND_SOC_DAPM_STREAM_START);
-		else {
-			codec_dai->pop_wait = 0;
-			cancel_delayed_work(&socdev->delayed_work);
-			snd_soc_dai_digital_mute(codec_dai, 0);
-		}
-	} else {
-		/* no delayed work - do we need to power up codec */
-		if (codec->bias_level != SND_SOC_BIAS_ON) {
+	/* cancel any delayed stream shutdown that is pending */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
+	    codec_dai->pop_wait) {
+		codec_dai->pop_wait = 0;
+		cancel_delayed_work(&socdev->delayed_work);
+	}
 
-			snd_soc_dapm_set_bias_level(socdev,
-						    SND_SOC_BIAS_PREPARE);
+	/* do we need to power up codec */
+	if (codec->bias_level != SND_SOC_BIAS_ON) {
+		snd_soc_dapm_set_bias_level(socdev,
+					    SND_SOC_BIAS_PREPARE);
 
-			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-				snd_soc_dapm_stream_event(codec,
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			snd_soc_dapm_stream_event(codec,
 					codec_dai->playback.stream_name,
 					SND_SOC_DAPM_STREAM_START);
-			else
-				snd_soc_dapm_stream_event(codec,
+		else
+			snd_soc_dapm_stream_event(codec,
 					codec_dai->capture.stream_name,
 					SND_SOC_DAPM_STREAM_START);
 
-			snd_soc_dapm_set_bias_level(socdev, SND_SOC_BIAS_ON);
-			snd_soc_dai_digital_mute(codec_dai, 0);
+		snd_soc_dapm_set_bias_level(socdev, SND_SOC_BIAS_ON);
+		snd_soc_dai_digital_mute(codec_dai, 0);
 
-		} else {
-			/* codec already powered - power on widgets */
-			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-				snd_soc_dapm_stream_event(codec,
+	} else {
+		/* codec already powered - power on widgets */
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			snd_soc_dapm_stream_event(codec,
 					codec_dai->playback.stream_name,
 					SND_SOC_DAPM_STREAM_START);
-			else
-				snd_soc_dapm_stream_event(codec,
+		else
+			snd_soc_dapm_stream_event(codec,
 					codec_dai->capture.stream_name,
 					SND_SOC_DAPM_STREAM_START);
 
-			snd_soc_dai_digital_mute(codec_dai, 0);
-		}
+		snd_soc_dai_digital_mute(codec_dai, 0);
 	}
 
 out:
-- 
1.5.6.5
