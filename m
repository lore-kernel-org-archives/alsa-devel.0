From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v7] ASoC: soc-compress: Cancel delayed power
	down if needed
Date: Wed, 27 Mar 2013 16:39:01 +0000
Message-ID: <1364402341-6702-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 948E02651B8
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 17:46:19 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

When a new stream is being opened it is necessary to cancel any delayed
power down of the audio.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

ARGH! White space error.

Charles

 sound/soc/soc-compress.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index f9b2197..0f4cfce 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -198,6 +198,7 @@ static int soc_compr_set_params(struct snd_compr_stream *cstream,
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
@@ -211,19 +212,27 @@ static int soc_compr_set_params(struct snd_compr_stream *cstream,
 	if (platform->driver->compr_ops && platform->driver->compr_ops->set_params) {
 		ret = platform->driver->compr_ops->set_params(cstream, params);
 		if (ret < 0)
-			goto out;
+			goto err;
 	}
 
 	if (rtd->dai_link->compr_ops && rtd->dai_link->compr_ops->set_params) {
 		ret = rtd->dai_link->compr_ops->set_params(cstream);
 		if (ret < 0)
-			goto out;
+			goto err;
 	}
 
 	snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_PLAYBACK,
 				SND_SOC_DAPM_STREAM_START);
 
-out:
+	/* cancel any delayed stream shutdown that is pending */
+	rtd->pop_wait = 0;
+	mutex_unlock(&rtd->pcm_mutex);
+
+	cancel_delayed_work_sync(&rtd->delayed_work);
+
+	return ret;
+
+err:
 	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
 }
-- 
1.7.2.5
