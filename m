From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 10/19] ASoC: SOF: PCM: add period_elapsed work
	to fix race condition in interrupt context
Date: Tue, 30 Apr 2019 18:09:25 -0500
Message-ID: <20190430230934.4321-11-pierre-louis.bossart@linux.intel.com>
References: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 007CEF89723
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2019 01:10:02 +0200 (CEST)
In-Reply-To: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Keyon Jie <yang.jie@linux.intel.com>

The IPC implementation in SOF requires sending IPCs serially: we should
not send a new IPC command to the firmware before we get an ACK (or time
out) from firmware, and the IRQ processing is complete.

snd_pcm_period_elapsed() can be called in interrupt context before
IRQ_HANDLED is returned. When the PCM is done draining, a STOP
IPC will then be sent, which breaks the expectation that IPCs are
handled serially and leads to IPC timeouts.

This patch adds a workqueue to defer the call to snd_pcm_elapsed() after
the IRQ is handled.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/pcm.c      | 48 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/sof/sof-priv.h |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index be4984c4da4e..649968841dad 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -52,6 +52,48 @@ static int sof_pcm_dsp_params(struct snd_sof_pcm *spcm, struct snd_pcm_substream
 	return ret;
 }
 
+/*
+ * sof pcm period elapse work
+ */
+static void sof_pcm_period_elapsed_work(struct work_struct *work)
+{
+	struct snd_sof_pcm_stream *sps =
+		container_of(work, struct snd_sof_pcm_stream,
+			     period_elapsed_work);
+
+	snd_pcm_period_elapsed(sps->substream);
+}
+
+/*
+ * sof pcm period elapse, this could be called at irq thread context.
+ */
+void snd_sof_pcm_period_elapsed(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
+	struct snd_sof_pcm *spcm;
+
+	spcm = snd_sof_find_spcm_dai(sdev, rtd);
+	if (!spcm) {
+		dev_err(sdev->dev,
+			"error: period elapsed for unknown stream!\n");
+		return;
+	}
+
+	/*
+	 * snd_pcm_period_elapsed() can be called in interrupt context
+	 * before IRQ_HANDLED is returned. Inside snd_pcm_period_elapsed(),
+	 * when the PCM is done draining or xrun happened, a STOP IPC will
+	 * then be sent and this IPC will hit IPC timeout.
+	 * To avoid sending IPC before the previous IPC is handled, we
+	 * schedule delayed work here to call the snd_pcm_period_elapsed().
+	 */
+	schedule_work(&spcm->stream[substream->stream].period_elapsed_work);
+}
+EXPORT_SYMBOL(snd_sof_pcm_period_elapsed);
+
 /* this may get called several times by oss emulation */
 static int sof_pcm_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params)
@@ -169,6 +211,9 @@ static int sof_pcm_hw_params(struct snd_pcm_substream *substream,
 	/* save pcm hw_params */
 	memcpy(&spcm->params[substream->stream], params, sizeof(*params));
 
+	INIT_WORK(&spcm->stream[substream->stream].period_elapsed_work,
+		  sof_pcm_period_elapsed_work);
+
 	return ret;
 }
 
@@ -203,6 +248,9 @@ static int sof_pcm_hw_free(struct snd_pcm_substream *substream)
 				 sizeof(stream), &reply, sizeof(reply));
 
 	snd_pcm_lib_free_pages(substream);
+
+	cancel_work_sync(&spcm->stream[substream->stream].period_elapsed_work);
+
 	return ret;
 }
 
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 35e78ffecce2..675bb10c82f5 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -274,6 +274,7 @@ struct snd_sof_pcm_stream {
 	struct snd_dma_buffer page_table;
 	struct sof_ipc_stream_posn posn;
 	struct snd_pcm_substream *substream;
+	struct work_struct period_elapsed_work;
 };
 
 /* ALSA SOF PCM device */
@@ -495,6 +496,7 @@ struct snd_sof_pcm *snd_sof_find_spcm_comp(struct snd_sof_dev *sdev,
 					   int *direction);
 struct snd_sof_pcm *snd_sof_find_spcm_pcm_id(struct snd_sof_dev *sdev,
 					     unsigned int pcm_id);
+void snd_sof_pcm_period_elapsed(struct snd_pcm_substream *substream);
 
 /*
  * Stream IPC
-- 
2.17.1
