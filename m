From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 11/13] ASoC: wm_adsp: Attach buffers and
	streams together
Date: Tue, 8 Dec 2015 16:08:35 +0000
Message-ID: <1449590917-21170-11-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1449590917-21170-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 5706926044B
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 17:09:10 +0100 (CET)
In-Reply-To: <1449590917-21170-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The stream is created whilst the compressed stream is opened and a
buffer is created when the DSP powers up. It is necessary at a point
once both the DSP has powered up and the the stream has been opened to
connect a stream to a buffer on the DSP. This is done in the trigger
callback as this is after the DSP has been powered and obviously the
stream must be open. Note that whilst the connect is currently trivial
it is expected that this will get more complex when support for multiple
buffers/streams per DSP is added.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c  |  1 +
 sound/soc/codecs/wm_adsp.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm_adsp.h |  1 +
 3 files changed, 64 insertions(+)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 8c0fd91..c364096 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2272,6 +2272,7 @@ static struct snd_compr_ops wm5110_compr_ops = {
 	.free = wm_adsp_compr_free,
 	.set_params = wm_adsp_compr_set_params,
 	.get_caps = wm_adsp_compr_get_caps,
+	.trigger = wm_adsp_compr_trigger,
 };
 
 static struct snd_soc_platform_driver wm5110_compr_platform = {
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index cf68557..de015da 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -283,6 +283,7 @@ struct wm_adsp_compr_buf {
 
 struct wm_adsp_compr {
 	struct wm_adsp *dsp;
+	struct wm_adsp_compr_buf *buf;
 
 	struct snd_compr_stream *stream;
 	struct snd_compressed_buffer size;
@@ -2338,6 +2339,13 @@ int wm_adsp_compr_open(struct wm_adsp *dsp, struct snd_compr_stream *stream)
 		goto out;
 	}
 
+	if (dsp->compr) {
+		/* It is expect this limitation will be removed in future */
+		adsp_err(dsp, "Only a single stream supported per DSP\n");
+		ret = -EBUSY;
+		goto out;
+	}
+
 	compr = kzalloc(sizeof(*compr), GFP_KERNEL);
 	if (!compr) {
 		ret = -ENOMEM;
@@ -2655,4 +2663,58 @@ static int wm_adsp_buffer_free(struct wm_adsp *dsp)
 	return 0;
 }
 
+static inline int wm_adsp_compr_attached(struct wm_adsp_compr *compr)
+{
+	return compr->buf != NULL;
+}
+
+static int wm_adsp_compr_attach(struct wm_adsp_compr *compr)
+{
+	/*
+	 * Note this will be more complex once each DSP can support multiple
+	 * streams
+	 */
+	if (!compr->dsp->buffer)
+		return -EINVAL;
+
+	compr->buf = compr->dsp->buffer;
+
+	return 0;
+}
+
+int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
+{
+	struct wm_adsp_compr *compr = stream->runtime->private_data;
+	struct wm_adsp *dsp = compr->dsp;
+	int ret = 0;
+
+	adsp_dbg(dsp, "Trigger: %d\n", cmd);
+
+	mutex_lock(&dsp->pwr_lock);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		if (wm_adsp_compr_attached(compr))
+			break;
+
+		ret = wm_adsp_compr_attach(compr);
+		if (ret < 0) {
+			adsp_err(dsp, "Failed to link buffer and stream: %d\n",
+				 ret);
+			break;
+		}
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&dsp->pwr_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(wm_adsp_compr_trigger);
+
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 0b2205a..43af093 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -111,5 +111,6 @@ extern int wm_adsp_compr_set_params(struct snd_compr_stream *stream,
 				    struct snd_compr_params *params);
 extern int wm_adsp_compr_get_caps(struct snd_compr_stream *stream,
 				  struct snd_compr_caps *caps);
+extern int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd);
 
 #endif
-- 
2.1.4
