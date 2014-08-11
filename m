From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 3/3] ASoC: Intel: Restore Baytrail ADSP streams
	only when ADSP was in reset
Date: Mon, 11 Aug 2014 14:15:38 +0300
Message-ID: <1407755738-31693-4-git-send-email-jarkko.nikula@linux.intel.com>
References: <1407755738-31693-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8584E264ED5
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 13:15:49 +0200 (CEST)
In-Reply-To: <1407755738-31693-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, yang fang <yang.a.fang@intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

There is no need to restore and restart PCM streams in case ADSP didn't
reach reset and power off state during system suspend/resume cycle. In that
case stream is still active but paused and firmware doesn't allow allocating
a new stream before paused stream is freed.

ADSP remains active in case suspend sequence didn't go to suspend_late
stage. This can happen when either suspend sequence is aborted by a wakeup
or by letting only devices suspend by "echo devices >/sys/power/pm_test".

Currently stream restoring fails in these suspend cases. Fix this by adding
a flag that indicates is complete stream reinitialization needed or is it
enough to resume paused stream. Flag is set when we know that ADSP reached
suspend_late.

Initial fix to this issue came from Fang Yang. I modified it a little and
forward ported it to top of two other suspend/resume patches from me.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Borun Fu <borun.fu@intel.com>
Cc: yang fang <yang.a.fang@intel.com>
---
 sound/soc/intel/sst-baytrail-pcm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-baytrail-pcm.c b/sound/soc/intel/sst-baytrail-pcm.c
index eb7b31e13565..eab1c7d85187 100644
--- a/sound/soc/intel/sst-baytrail-pcm.c
+++ b/sound/soc/intel/sst-baytrail-pcm.c
@@ -59,6 +59,9 @@ struct sst_byt_priv_data {
 
 	/* DAI data */
 	struct sst_byt_pcm_data pcm[BYT_PCM_COUNT];
+
+	/* flag indicating is stream context restore needed after suspend */
+	bool restore_stream;
 };
 
 /* this may get called several times by oss emulation */
@@ -184,7 +187,10 @@ static int sst_byt_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		sst_byt_stream_start(byt, pcm_data->stream, 0);
 		break;
 	case SNDRV_PCM_TRIGGER_RESUME:
-		schedule_work(&pcm_data->work);
+		if (pdata->restore_stream == true)
+			schedule_work(&pcm_data->work);
+		else
+			sst_byt_stream_resume(byt, pcm_data->stream);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		sst_byt_stream_resume(byt, pcm_data->stream);
@@ -193,6 +199,7 @@ static int sst_byt_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		sst_byt_stream_stop(byt, pcm_data->stream);
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
+		pdata->restore_stream = false;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		sst_byt_stream_pause(byt, pcm_data->stream);
 		break;
@@ -407,6 +414,7 @@ static const struct snd_soc_component_driver byt_dai_component = {
 static int sst_byt_pcm_dev_suspend_late(struct device *dev)
 {
 	struct sst_pdata *sst_pdata = dev_get_platdata(dev);
+	struct sst_byt_priv_data *priv_data = dev_get_drvdata(dev);
 	int ret;
 
 	dev_dbg(dev, "suspending late\n");
@@ -417,6 +425,8 @@ static int sst_byt_pcm_dev_suspend_late(struct device *dev)
 		return ret;
 	}
 
+	priv_data->restore_stream = true;
+
 	return ret;
 }
 
-- 
2.0.1
