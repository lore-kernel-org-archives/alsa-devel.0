From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 12/13] ASoC: wm_adsp: Add a handler for the
	compressed IRQ
Date: Tue, 8 Dec 2015 16:08:36 +0000
Message-ID: <1449590917-21170-12-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1449590917-21170-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id CF81E26051D
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 17:09:09 +0100 (CET)
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

Here support is added for responding to DSP IRQs that are used to
indicate data being available on the DSP. The idea is that we check the
amount of data available upon receipt of an IRQ and on subsequent calls
to the pointer callback we recheck once less than one fragment is
available (to avoid excessive SPI traffic), if there is truely less than
one fragment available we ack the last IRQ and wait for a new one.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c  |  24 ++++++
 sound/soc/codecs/wm_adsp.c | 187 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm_adsp.h |   3 +
 3 files changed, 214 insertions(+)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index c364096..c6c176e 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2177,10 +2177,20 @@ static int wm5110_open(struct snd_compr_stream *stream)
 	return wm_adsp_compr_open(&priv->core.adsp[n_adsp], stream);
 }
 
+static irqreturn_t wm5110_adsp2_irq(int irq, void *data)
+{
+	struct wm5110_priv *florida = data;
+
+	wm_adsp_compr_handle_irq(&florida->core.adsp[2]);
+
+	return IRQ_HANDLED;
+}
+
 static int wm5110_codec_probe(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct wm5110_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->core.arizona;
 	int i, ret;
 
 	priv->core.arizona->dapm = dapm;
@@ -2189,6 +2199,14 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 	arizona_init_gpio(codec);
 	arizona_init_mono(codec);
 
+	ret = arizona_request_irq(arizona, ARIZONA_IRQ_DSP_IRQ1,
+				  "ADSP2 Compressed IRQ", wm5110_adsp2_irq,
+				  priv);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to request DSP IRQ: %d\n", ret);
+		return ret;
+	}
+
 	for (i = 0; i < WM5110_NUM_ADSP; ++i) {
 		ret = wm_adsp2_codec_probe(&priv->core.adsp[i], codec);
 		if (ret)
@@ -2209,12 +2227,15 @@ err_adsp2_codec_probe:
 	for (--i; i >= 0; --i)
 		wm_adsp2_codec_remove(&priv->core.adsp[i], codec);
 
+	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, priv);
+
 	return ret;
 }
 
 static int wm5110_codec_remove(struct snd_soc_codec *codec)
 {
 	struct wm5110_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->core.arizona;
 	int i;
 
 	for (i = 0; i < WM5110_NUM_ADSP; ++i)
@@ -2222,6 +2243,8 @@ static int wm5110_codec_remove(struct snd_soc_codec *codec)
 
 	priv->core.arizona->dapm = NULL;
 
+	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, priv);
+
 	return 0;
 }
 
@@ -2273,6 +2296,7 @@ static struct snd_compr_ops wm5110_compr_ops = {
 	.set_params = wm_adsp_compr_set_params,
 	.get_caps = wm_adsp_compr_get_caps,
 	.trigger = wm_adsp_compr_trigger,
+	.pointer = wm_adsp_compr_pointer,
 };
 
 static struct snd_soc_platform_driver wm5110_compr_platform = {
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index de015da..8b823b6 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -279,6 +279,11 @@ struct wm_adsp_compr_buf {
 
 	struct wm_adsp_buffer_region *regions;
 	u32 host_buf_ptr;
+
+	u32 error;
+	u32 irq_ack;
+	int read_index;
+	int avail;
 };
 
 struct wm_adsp_compr {
@@ -287,6 +292,8 @@ struct wm_adsp_compr {
 
 	struct snd_compr_stream *stream;
 	struct snd_compressed_buffer size;
+
+	unsigned int copied_total;
 };
 
 #define WM_ADSP_DATA_WORD_SIZE         3
@@ -2433,6 +2440,11 @@ static int wm_adsp_compr_check_params(struct snd_compr_stream *stream,
 	return -EINVAL;
 }
 
+static inline unsigned int wm_adsp_compr_frag_words(struct wm_adsp_compr *compr)
+{
+	return compr->size.fragment_size / WM_ADSP_DATA_WORD_SIZE;
+}
+
 int wm_adsp_compr_set_params(struct snd_compr_stream *stream,
 			     struct snd_compr_params *params)
 {
@@ -2620,6 +2632,8 @@ static int wm_adsp_buffer_init(struct wm_adsp *dsp)
 		return -ENOMEM;
 
 	buf->dsp = dsp;
+	buf->read_index = -1;
+	buf->irq_ack = 0xFFFFFFFF;
 
 	ret = wm_adsp_buffer_locate(buf);
 	if (ret < 0) {
@@ -2703,6 +2717,16 @@ int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
 				 ret);
 			break;
 		}
+
+		/* Trigger the IRQ at one fragment of data */
+		ret = wm_adsp_buffer_write(compr->buf,
+					   HOST_BUFFER_FIELD(high_water_mark),
+					   wm_adsp_compr_frag_words(compr));
+		if (ret < 0) {
+			adsp_err(dsp, "Failed to set high water mark: %d\n",
+				 ret);
+			break;
+		}
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		break;
@@ -2717,4 +2741,167 @@ int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
 }
 EXPORT_SYMBOL_GPL(wm_adsp_compr_trigger);
 
+static inline int wm_adsp_buffer_size(struct wm_adsp_compr_buf *buf)
+{
+	int last_region = wm_adsp_fw[buf->dsp->fw].caps->num_regions - 1;
+
+	return buf->regions[last_region].cumulative_size;
+}
+
+static int wm_adsp_buffer_update_avail(struct wm_adsp_compr_buf *buf)
+{
+	u32 next_read_index, next_write_index;
+	int write_index, read_index, avail;
+	int ret;
+
+	/* Only sync read index if we haven't already read a valid index */
+	if (buf->read_index < 0) {
+		ret = wm_adsp_buffer_read(buf,
+				HOST_BUFFER_FIELD(next_read_index),
+				&next_read_index);
+		if (ret < 0)
+			return ret;
+
+		read_index = sign_extend32(next_read_index, 23);
+
+		if (read_index < 0) {
+			adsp_dbg(buf->dsp, "Avail check on unstarted stream\n");
+			return 0;
+		}
+
+		buf->read_index = read_index;
+	}
+
+	ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(next_write_index),
+			&next_write_index);
+	if (ret < 0)
+		return ret;
+
+	write_index = sign_extend32(next_write_index, 23);
+
+	avail = write_index - buf->read_index;
+	if (avail < 0)
+		avail += wm_adsp_buffer_size(buf);
+
+	adsp_dbg(buf->dsp, "readindex=0x%x, writeindex=0x%x, avail=%d\n",
+		 buf->read_index, write_index, avail);
+
+	buf->avail = avail;
+
+	return 0;
+}
+
+int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
+{
+	struct wm_adsp_compr_buf *buf = dsp->buffer;
+	int ret = 0;
+
+	mutex_lock(&dsp->pwr_lock);
+
+	if (!buf) {
+		adsp_err(dsp, "Spurious buffer IRQ\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	adsp_dbg(dsp, "Handling buffer IRQ\n");
+
+	ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(error), &buf->error);
+	if (ret < 0) {
+		adsp_err(dsp, "Failed to check buffer error: %d\n", ret);
+		goto out;
+	}
+	if (buf->error != 0) {
+		adsp_err(dsp, "Buffer error occurred: %d\n", buf->error);
+		ret = -EIO;
+		goto out;
+	}
+
+	ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(irq_count),
+				  &buf->irq_ack);
+	if (ret < 0) {
+		adsp_err(dsp, "Failed to get irq_count: %d\n", ret);
+		goto out;
+	}
+
+	ret = wm_adsp_buffer_update_avail(buf);
+	if (ret < 0) {
+		adsp_err(dsp, "Error reading avail: %d\n", ret);
+		goto out;
+	}
+
+out:
+	mutex_unlock(&dsp->pwr_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(wm_adsp_compr_handle_irq);
+
+static int wm_adsp_buffer_ack_irq(struct wm_adsp_compr_buf *buf)
+{
+	if (buf->irq_ack & 0x01)
+		return 0;
+
+	adsp_dbg(buf->dsp, "Acking buffer IRQ(0x%x)\n", buf->irq_ack);
+
+	buf->irq_ack |= 0x01;
+
+	return wm_adsp_buffer_write(buf, HOST_BUFFER_FIELD(irq_ack),
+				    buf->irq_ack);
+}
+
+int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
+			  struct snd_compr_tstamp *tstamp)
+{
+	struct wm_adsp_compr *compr = stream->runtime->private_data;
+	struct wm_adsp_compr_buf *buf = compr->buf;
+	struct wm_adsp *dsp = compr->dsp;
+	int ret = 0;
+
+	adsp_dbg(dsp, "Pointer request\n");
+
+	mutex_lock(&dsp->pwr_lock);
+
+	if (!compr->buf) {
+		ret = -ENXIO;
+		goto out;
+	}
+
+	if (compr->buf->error) {
+		ret = -EIO;
+		goto out;
+	}
+
+	if (buf->avail < wm_adsp_compr_frag_words(compr)) {
+		ret = wm_adsp_buffer_update_avail(buf);
+		if (ret < 0) {
+			adsp_err(dsp, "Error reading avail: %d\n", ret);
+			goto out;
+		}
+
+		/*
+		 * If we really have less than 1 fragment available ack the
+		 * last DSP IRQ and rely on the IRQ to inform us once a whole
+		 * fragment is available.
+		 */
+		if (buf->avail < wm_adsp_compr_frag_words(compr)) {
+			ret = wm_adsp_buffer_ack_irq(buf);
+			if (ret < 0) {
+				adsp_err(dsp, "Failed to ack buffer IRQ: %d\n",
+					 ret);
+				goto out;
+			}
+		}
+	}
+
+	tstamp->copied_total = compr->copied_total;
+	tstamp->copied_total += buf->avail * WM_ADSP_DATA_WORD_SIZE;
+
+out:
+	mutex_unlock(&dsp->pwr_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(wm_adsp_compr_pointer);
+
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 43af093..522fa1a 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -112,5 +112,8 @@ extern int wm_adsp_compr_set_params(struct snd_compr_stream *stream,
 extern int wm_adsp_compr_get_caps(struct snd_compr_stream *stream,
 				  struct snd_compr_caps *caps);
 extern int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd);
+extern int wm_adsp_compr_handle_irq(struct wm_adsp *dsp);
+extern int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
+				 struct snd_compr_tstamp *tstamp);
 
 #endif
-- 
2.1.4
