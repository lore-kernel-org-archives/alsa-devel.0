From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/2] ASoC: core: Add flag to ignore
	pmdown_time at pcm_close
Date: Fri, 14 Oct 2011 14:43:33 +0300
Message-ID: <1318592614-13110-2-git-send-email-peter.ujfalusi@ti.com>
References: <1318592614-13110-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B6DB103819
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 13:43:38 +0200 (CEST)
Received: by mail-yw0-f45.google.com with SMTP id 39so2758276ywm.18
	for <alsa-devel@alsa-project.org>; Fri, 14 Oct 2011 04:43:37 -0700 (PDT)
In-Reply-To: <1318592614-13110-1-git-send-email-peter.ujfalusi@ti.com>
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

With this flag codec drivers can indicate that it is desired
to ignore the pmdown_time for DAPM shutdown sequence when
playback stream is stopped.
The DAPM sequence will be executed without delay in this case.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/sound/soc.h |    1 +
 sound/soc/soc-pcm.c |   15 +++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 858291d..11cfb59 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -578,6 +578,7 @@ struct snd_soc_codec {
 
 	/* dapm */
 	struct snd_soc_dapm_context dapm;
+	unsigned int ignore_pmdown_time:1; /* pmdown_time is ignored at stop */
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_codec_root;
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 8eb0f07..ee15337 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -319,10 +319,17 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	cpu_dai->runtime = NULL;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		/* start delayed pop wq here for playback streams */
-		codec_dai->pop_wait = 1;
-		schedule_delayed_work(&rtd->delayed_work,
-			msecs_to_jiffies(rtd->pmdown_time));
+		if (unlikely(codec->ignore_pmdown_time)) {
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
