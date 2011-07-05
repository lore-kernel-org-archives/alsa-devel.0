From: Santosh Sivaraj <santoshs@fossix.org>
Subject: Recording doesn't end gracefully
Date: Tue, 5 Jul 2011 15:55:21 +0530
Message-ID: <20110705102521.GB10296@santoshs.mistral.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FA7810391A
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jul 2011 12:27:35 +0200 (CEST)
Received: by pzk26 with SMTP id 26so2947931pzk.38
	for <alsa-devel@alsa-project.org>; Tue, 05 Jul 2011 03:27:34 -0700 (PDT)
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

Hi all,

We were working on 1.0.23 version of the ALSA driver. In the following
scenario we are getting some issues with recording.

* Play some music in the sound player in the background
* Open recorder and start recording
* Since playback and recording can't happen simultaneously, we explicitly
  reset the codec device and configure it for recording.
* In this case, after some time the codec driver is powered off by the
  soc-core and only silence is recorded.

All this were done from the Android UI. When the same is repeated from the
command line with aplay and arecord we see that aplay is stopped and
recording works fine.

When we debugged the problem, we found that the following diff seems to get rid
of the above problem:

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c984996..247f4ee 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -773,7 +773,8 @@ int snd_soc_pcm_close(struct snd_pcm_substream *substream)
        /* Muting the DAC suppresses artifacts caused during digital
         * shutdown, for example from stopping clocks.
         */
-       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+       if ((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ||
+           (substream->stream == SNDRV_PCM_STREAM_CAPTURE))
                snd_soc_dai_digital_mute(codec_dai, 1);
 
        if (cpu_dai->driver->ops->shutdown)
@@ -869,7 +870,8 @@ int snd_soc_pcm_prepare(struct snd_pcm_substream *substream)
        }
 
        /* cancel any delayed stream shutdown that is pending */
-       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
+       if (((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ||
+            (substream->stream == SNDRV_PCM_STREAM_CAPTURE))  &&
            codec_dai->pop_wait) {
                codec_dai->pop_wait = 0;
                cancel_delayed_work(&rtd->delayed_work);

I am not aware of what consequences/side effects these changes can cause,
please advice, whether it is a problem elsewhere

-- 
http://fossix.org, http://dot.slashb.in
Things do not change; we change 
					-- Henry David
