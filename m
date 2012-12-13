From: Misael Lopez Cruz <misael.lopez@ti.com>
Subject: [PATCH] ASoC: Prevent pop_wait overwrite
Date: Thu, 13 Dec 2012 12:23:05 -0600
Message-ID: <1355422985-17100-1-git-send-email-misael.lopez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D5AA26164E
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2012 19:22:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

pop_wait is used to determine if a deferred playback close
needs to be cancelled when the a PCM is open or if after
the power-down delay expires it needs to run. pop_wait is
associated with the CODEC DAI, so the CODEC DAI must be
unique. This holds true for most CODECs, except for the
dummy CODEC and its DAI.

In DAI links with non-unique dummy CODECs (e.g. front-ends),
pop_wait can be overwritten by another DAI link using also a
dummy CODEC. Failure to cancel a deferred close can cause
mute due to the DAPM STOP event sent in the deferred work.

One scenario where pop_wait is overwritten and causing mute
is below (where hw:0,0 and hw:0,1 are two front-ends with
default pmdown_time = 5 secs):

aplay /dev/urandom -D hw:0,0 -c 2 -r 48000 -f S16_LE -d 1
sleep 1
aplay /dev/urandom -D hw:0,1 -c 2 -r 48000 -f S16_LE -d 3 &
aplay /dev/urandom -D hw:0,0 -c 2 -r 48000 -f S16_LE

Since CODECs may not be unique, pop_wait is moved to the PCM
runtime structure. Creating separate dummy CODECs for each
DAI link can also solve the problem, but at this point it's
only pop_wait variable in the CODEC DAI that has negative
effects by not being unique.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
---
 include/sound/soc-dai.h  |    1 -
 include/sound/soc.h      |    1 +
 sound/soc/soc-compress.c |    2 +-
 sound/soc/soc-pcm.c      |   12 ++++++------
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 628db7b..3953cea 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -242,7 +242,6 @@ struct snd_soc_dai {
 	unsigned int symmetric_rates:1;
 	struct snd_pcm_runtime *runtime;
 	unsigned int active;
-	unsigned char pop_wait:1;
 	unsigned char probed:1;
 
 	struct snd_soc_dapm_widget *playback_widget;
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 91244a0..769e27c 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1039,6 +1039,7 @@ struct snd_soc_pcm_runtime {
 	struct snd_soc_dpcm_runtime dpcm[2];
 
 	long pmdown_time;
+	unsigned char pop_wait:1;
 
 	/* runtime devices */
 	struct snd_pcm *pcm;
diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 967d0e1..5fbfb06 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -113,7 +113,7 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 					SNDRV_PCM_STREAM_PLAYBACK,
 					SND_SOC_DAPM_STREAM_STOP);
 		} else
-			codec_dai->pop_wait = 1;
+			rtd->pop_wait = 1;
 			schedule_delayed_work(&rtd->delayed_work,
 				msecs_to_jiffies(rtd->pmdown_time));
 	} else {
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 5c3ca2a..d7711fc 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -334,11 +334,11 @@ static void close_delayed_work(struct work_struct *work)
 	dev_dbg(rtd->dev, "ASoC: pop wq checking: %s status: %s waiting: %s\n",
 		 codec_dai->driver->playback.stream_name,
 		 codec_dai->playback_active ? "active" : "inactive",
-		 codec_dai->pop_wait ? "yes" : "no");
+		 rtd->pop_wait ? "yes" : "no");
 
 	/* are we waiting on this codec DAI stream */
-	if (codec_dai->pop_wait == 1) {
-		codec_dai->pop_wait = 0;
+	if (rtd->pop_wait == 1) {
+		rtd->pop_wait = 0;
 		snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_PLAYBACK,
 					  SND_SOC_DAPM_STREAM_STOP);
 	}
@@ -408,7 +408,7 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 						  SND_SOC_DAPM_STREAM_STOP);
 		} else {
 			/* start delayed pop wq here for playback streams */
-			codec_dai->pop_wait = 1;
+			rtd->pop_wait = 1;
 			schedule_delayed_work(&rtd->delayed_work,
 				msecs_to_jiffies(rtd->pmdown_time));
 		}
@@ -480,8 +480,8 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 
 	/* cancel any delayed stream shutdown that is pending */
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
-	    codec_dai->pop_wait) {
-		codec_dai->pop_wait = 0;
+	    rtd->pop_wait) {
+		rtd->pop_wait = 0;
 		cancel_delayed_work(&rtd->delayed_work);
 	}
 
-- 
1.7.9.5
