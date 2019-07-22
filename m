From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 03/21] ASoC: SOF: use common code to send
	PCM_FREE IPC
Date: Mon, 22 Jul 2019 09:13:44 -0500
Message-ID: <20190722141402.7194-4-pierre-louis.bossart@linux.intel.com>
References: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03679F803D1
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 16:14:13 +0200 (CEST)
In-Reply-To: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Remove duplicated code by using a common helper function
to send the PCM_FREE IPC message to FW.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/pcm.c | 50 ++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 3b8955e755b2..8612896673a5 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -216,6 +216,27 @@ static int sof_pcm_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static int sof_pcm_dsp_pcm_free(struct snd_pcm_substream *substream,
+				struct snd_sof_dev *sdev,
+				struct snd_sof_pcm *spcm)
+{
+	struct sof_ipc_stream stream;
+	struct sof_ipc_reply reply;
+	int ret;
+
+	stream.hdr.size = sizeof(stream);
+	stream.hdr.cmd = SOF_IPC_GLB_STREAM_MSG | SOF_IPC_STREAM_PCM_FREE;
+	stream.comp_id = spcm->stream[substream->stream].comp_id;
+
+	/* send IPC to the DSP */
+	ret = sof_ipc_tx_message(sdev->ipc, stream.hdr.cmd, &stream,
+				 sizeof(stream), &reply, sizeof(reply));
+	if (!ret)
+		spcm->prepared[substream->stream] = false;
+
+	return ret;
+}
+
 static int sof_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -223,8 +244,6 @@ static int sof_pcm_hw_free(struct snd_pcm_substream *substream)
 		snd_soc_rtdcom_lookup(rtd, DRV_NAME);
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
 	struct snd_sof_pcm *spcm;
-	struct sof_ipc_stream stream;
-	struct sof_ipc_reply reply;
 	int ret;
 
 	/* nothing to do for BE */
@@ -241,13 +260,7 @@ static int sof_pcm_hw_free(struct snd_pcm_substream *substream)
 	dev_dbg(sdev->dev, "pcm: free stream %d dir %d\n", spcm->pcm.pcm_id,
 		substream->stream);
 
-	stream.hdr.size = sizeof(stream);
-	stream.hdr.cmd = SOF_IPC_GLB_STREAM_MSG | SOF_IPC_STREAM_PCM_FREE;
-	stream.comp_id = spcm->stream[substream->stream].comp_id;
-
-	/* send IPC to the DSP */
-	ret = sof_ipc_tx_message(sdev->ipc, stream.hdr.cmd, &stream,
-				 sizeof(stream), &reply, sizeof(reply));
+	ret = sof_pcm_dsp_pcm_free(substream, sdev, spcm);
 
 	snd_pcm_lib_free_pages(substream);
 
@@ -260,8 +273,6 @@ static int sof_pcm_hw_free(struct snd_pcm_substream *substream)
 	if (ret < 0)
 		dev_err(sdev->dev, "error: platform hw free failed\n");
 
-	spcm->prepared[substream->stream] = false;
-
 	return ret;
 }
 
@@ -365,21 +376,10 @@ static int sof_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	ret = sof_ipc_tx_message(sdev->ipc, stream.hdr.cmd, &stream,
 				 sizeof(stream), &reply, sizeof(reply));
 
-	if (ret < 0 || !reset_hw_params)
-		return ret;
-
-	/*
-	 * In case of stream is stopped, DSP must be reprogrammed upon
-	 * restart, so free PCM here.
-	 */
-	stream.hdr.size = sizeof(stream);
-	stream.hdr.cmd = SOF_IPC_GLB_STREAM_MSG | SOF_IPC_STREAM_PCM_FREE;
-	stream.comp_id = spcm->stream[substream->stream].comp_id;
-	spcm->prepared[substream->stream] = false;
+	if (!ret && reset_hw_params)
+		ret = sof_pcm_dsp_pcm_free(substream, sdev, spcm);
 
-	/* send IPC to the DSP */
-	return sof_ipc_tx_message(sdev->ipc, stream.hdr.cmd, &stream,
-				  sizeof(stream), &reply, sizeof(reply));
+	return ret;
 }
 
 static snd_pcm_uframes_t sof_pcm_pointer(struct snd_pcm_substream *substream)
-- 
2.20.1
