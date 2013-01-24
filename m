From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: soc-compress: Initialise delayed
	work to power down audio
Date: Thu, 24 Jan 2013 09:44:30 +0000
Message-ID: <1359020670-25684-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1359020670-25684-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CEDD42615D0
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 10:47:09 +0100 (CET)
In-Reply-To: <1359020670-25684-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: vinod.koul@linux.intel.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Delayed work was scheduled but not initialised, this patch adds the
actual work and initialises it.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-compress.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index c48db63..3ea7956 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -75,6 +75,34 @@ out:
 	return ret;
 }
 
+/*
+ * Power down the audio subsystem pmdown_time msecs after close is called.
+ * This is to ensure there are no pops or clicks in between any music tracks
+ * due to DAPM power cycling.
+ */
+static void close_delayed_work(struct work_struct *work)
+{
+	struct snd_soc_pcm_runtime *rtd =
+			container_of(work, struct snd_soc_pcm_runtime, delayed_work.work);
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+
+	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
+
+	dev_dbg(rtd->dev, "ASoC: pop wq checking: %s status: %s waiting: %s\n",
+		 codec_dai->driver->playback.stream_name,
+		 codec_dai->playback_active ? "active" : "inactive",
+		 rtd->pop_wait ? "yes" : "no");
+
+	/* are we waiting on this codec DAI stream */
+	if (rtd->pop_wait == 1) {
+		rtd->pop_wait = 0;
+		snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_PLAYBACK,
+					  SND_SOC_DAPM_STREAM_STOP);
+	}
+
+	mutex_unlock(&rtd->pcm_mutex);
+}
+
 static int soc_compr_free(struct snd_compr_stream *cstream)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
@@ -317,6 +345,9 @@ int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 		return ret;
 	}
 
+	/* DAPM dai link stream work */
+	INIT_DELAYED_WORK(&rtd->delayed_work, close_delayed_work);
+
 	rtd->compr = compr;
 	compr->private_data = rtd;
 
-- 
1.7.2.5
