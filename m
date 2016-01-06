From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Add a handler for the
	compressed IRQ" to the asoc tree
Date: Wed, 06 Jan 2016 18:12:25 +0000
Message-ID: <E1aGsZN-0007D4-NK@debutante>
References: <1452083599-3932-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C85126044E
 for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2016 19:13:45 +0100 (CET)
In-Reply-To: <1452083599-3932-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Add a handler for the compressed IRQ

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 565ace464105cb9623cbf4eb9549d4b0c24166c9 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Wed, 6 Jan 2016 12:33:18 +0000
Subject: [PATCH] ASoC: wm_adsp: Add a handler for the compressed IRQ

Here support is added for responding to DSP IRQs that are used to
indicate data being available on the DSP. The idea is that we check the
amount of data available upon receipt of an IRQ and on subsequent calls
to the pointer callback we recheck once less than one fragment is
available (to avoid excessive SPI traffic), if there is truely less than
one fragment available we ack the last IRQ and wait for a new one.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm5110.c  |  27 +++++++
 sound/soc/codecs/wm_adsp.c | 188 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm_adsp.h |   3 +
 3 files changed, 218 insertions(+)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index c36409601835..dde94c4a0caa 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2177,10 +2177,23 @@ static int wm5110_open(struct snd_compr_stream *stream)
 	return wm_adsp_compr_open(&priv->core.adsp[n_adsp], stream);
 }
 
+static irqreturn_t wm5110_adsp2_irq(int irq, void *data)
+{
+	struct wm5110_priv *florida = data;
+	int ret;
+
+	ret = wm_adsp_compr_handle_irq(&florida->core.adsp[2]);
+	if (ret == -ENODEV)
+		return IRQ_NONE;
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
@@ -2189,6 +2202,14 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
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
@@ -2209,12 +2230,15 @@ err_adsp2_codec_probe:
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
@@ -2222,6 +2246,8 @@ static int wm5110_codec_remove(struct snd_soc_codec *codec)
 
 	priv->core.arizona->dapm = NULL;
 
+	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, priv);
+
 	return 0;
 }
 
@@ -2273,6 +2299,7 @@ static struct snd_compr_ops wm5110_compr_ops = {
 	.set_params = wm_adsp_compr_set_params,
 	.get_caps = wm_adsp_compr_get_caps,
 	.trigger = wm_adsp_compr_trigger,
+	.pointer = wm_adsp_compr_pointer,
 };
 
 static struct snd_soc_platform_driver wm5110_compr_platform = {
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index ac879d16c6a6..49ef0bbe9892 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -279,6 +279,11 @@ struct wm_adsp_compr_buf {
 
 	struct wm_adsp_buffer_region *regions;
 	u32 host_buf_ptr;
+
+	u32 error;
+	u32 irq_count;
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
@@ -2436,6 +2443,11 @@ static int wm_adsp_compr_check_params(struct snd_compr_stream *stream,
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
@@ -2622,6 +2634,8 @@ static int wm_adsp_buffer_init(struct wm_adsp *dsp)
 		return -ENOMEM;
 
 	buf->dsp = dsp;
+	buf->read_index = -1;
+	buf->irq_count = 0xFFFFFFFF;
 
 	ret = wm_adsp_buffer_locate(buf);
 	if (ret < 0) {
@@ -2705,6 +2719,16 @@ int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
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
@@ -2719,4 +2743,168 @@ int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
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
+		ret = -ENODEV;
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
+				  &buf->irq_count);
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
+static int wm_adsp_buffer_reenable_irq(struct wm_adsp_compr_buf *buf)
+{
+	if (buf->irq_count & 0x01)
+		return 0;
+
+	adsp_dbg(buf->dsp, "Enable IRQ(0x%x) for next fragment\n",
+		 buf->irq_count);
+
+	buf->irq_count |= 0x01;
+
+	return wm_adsp_buffer_write(buf, HOST_BUFFER_FIELD(irq_ack),
+				    buf->irq_count);
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
+		 * If we really have less than 1 fragment available tell the
+		 * DSP to inform us once a whole fragment is available.
+		 */
+		if (buf->avail < wm_adsp_compr_frag_words(compr)) {
+			ret = wm_adsp_buffer_reenable_irq(buf);
+			if (ret < 0) {
+				adsp_err(dsp,
+					 "Failed to re-enable buffer IRQ: %d\n",
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
index 43af093fafcf..522fa1ada4e6 100644
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
2.7.0.rc3
