From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: Merging at91 and avr32 dirs - test report
Date: Tue, 14 Oct 2008 13:58:36 +0100
Message-ID: <20081014125835.GF14538@sirena.org.uk>
References: <B9D3C48C98930741A166756A50C44A610F17B561@helx1.corp.vaisala.com>
	<20081010185312.GA10766@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B562@helx1.corp.vaisala.com>
	<B9D3C48C98930741A166756A50C44A610F17B564@helx1.corp.vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 396C624506
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Oct 2008 14:58:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B9D3C48C98930741A166756A50C44A610F17B564@helx1.corp.vaisala.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext-jukka.hynninen@vaisala.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 14, 2008 at 03:38:22PM +0300, ext-jukka.hynninen@vaisala.com wrote:

> This is propably a false alarm, exactly the same happens with at91-ssc.c

OK, so you're happy that the new and old AT91 drivers perform
equivalently?

> Using mpg123, the soc_pcm_prepare() never gets called, which makes me
> suspect 
> that the real problem might lie in mpg123 code. A similar issue has been

The drivers should be robust against buggy applications, though.

> reported here in the past, but I couldn't find a solution:

> http://thread.gmane.org/gmane.linux.alsa.devel/47908

Yes, I think it's the same issue -  looks like a core bug which is still
present in current ASoC.  The patch below is *entirely* untested but may
help.  It needs more thought and (obviously) testing to make sure it's
safe before it can be merged.

[BTW, your mailer is doing some *really* strange line-wrapping.]


diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ad38113..725b30b 100644
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
+        /* do we need to power up codec */
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
