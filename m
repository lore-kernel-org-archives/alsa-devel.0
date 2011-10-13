From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 1/2] ASoC: soc-pcm: Add flag to ignore
	pmdown_time at pcm_close
Date: Thu, 13 Oct 2011 16:23:34 +0300
Message-ID: <1318512215-2331-2-git-send-email-peter.ujfalusi@ti.com>
References: <1318512215-2331-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog123.obsmtp.com (na3sys009aog123.obsmtp.com
	[74.125.149.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FE6D103854
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 15:23:46 +0200 (CEST)
Received: by mail-gy0-f178.google.com with SMTP id 4so1689107gyh.37
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2011 06:23:45 -0700 (PDT)
In-Reply-To: <1318512215-2331-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

With this flag machine drivers can indicate that it is desired
to ignore the pmdown_time for DAPM shutdown sequence when
playback stream is stopped.
The DAPM sequence will be executed without delay in this case.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/sound/soc.h |    3 +++
 sound/soc/soc-pcm.c |   15 +++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 858291d..7b75b68 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -717,6 +717,9 @@ struct snd_soc_dai_link {
 	/* Symmetry requirements */
 	unsigned int symmetric_rates:1;
 
+	/* Will ingore the pmdown_time for playback stream */
+	unsigned int ignore_pmdown_time:1;
+
 	/* codec/machine specific init - e.g. add machine controls */
 	int (*init)(struct snd_soc_pcm_runtime *rtd);
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 8eb0f07..faac256 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -319,10 +319,17 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	cpu_dai->runtime = NULL;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		/* start delayed pop wq here for playback streams */
-		codec_dai->pop_wait = 1;
-		schedule_delayed_work(&rtd->delayed_work,
-			msecs_to_jiffies(rtd->pmdown_time));
+		if (unlikely(rtd->dai_link->ignore_pmdown_time)) {
+			/* powered down playback stream now */
+			snd_soc_dapm_stream_event(rtd,
+				codec_dai->driver->playback.stream_name,
+				SND_SOC_DAPM_STREAM_STOP);
+		} else {
+			/* start delayed pop wq here for playback streams */
+			codec_dai->pop_wait = 1;
+			schedule_delayed_work(&rtd->delayed_work,
+				msecs_to_jiffies(rtd->pmdown_time));
+		}
 	} else {
 		/* capture streams can be powered down now */
 		snd_soc_dapm_stream_event(rtd,
-- 
1.7.7
