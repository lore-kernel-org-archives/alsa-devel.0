From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Improve logging messages" to
	the asoc tree
Date: Tue, 26 Feb 2019 12:06:22 +0000 (GMT)
Message-ID: <20190226120622.74DB111284E3@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A65BAF80734
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2019 13:06:24 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Improve logging messages

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 0d3fba3e7a566917f4286dd42b83c780c47dcbf7 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Fri, 22 Feb 2019 10:04:21 +0000
Subject: [PATCH] ASoC: wm_adsp: Improve logging messages

As the compressed stream implementation has acquired support for
multiple DAI links and compressed streams it has become harder to
interpret messages in the kernel log. Add additional macros to include
the compressed DAI name in the log messages, allowing different streams
to be easily disambiguated.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 97 +++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 44 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index fe802fc331c5..8077c18cbcdf 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -46,6 +46,13 @@
 #define adsp_dbg(_dsp, fmt, ...) \
 	dev_dbg(_dsp->dev, "%s: " fmt, _dsp->name, ##__VA_ARGS__)
 
+#define compr_err(_obj, fmt, ...) \
+	adsp_err(_obj->dsp, "%s: " fmt, _obj->name ? _obj->name : "legacy", \
+		 ##__VA_ARGS__)
+#define compr_dbg(_obj, fmt, ...) \
+	adsp_dbg(_obj->dsp, "%s: " fmt, _obj->name ? _obj->name : "legacy", \
+		 ##__VA_ARGS__)
+
 #define ADSP1_CONTROL_1                   0x00
 #define ADSP1_CONTROL_2                   0x02
 #define ADSP1_CONTROL_3                   0x03
@@ -3033,20 +3040,23 @@ int wm_adsp_compr_open(struct wm_adsp *dsp, struct snd_compr_stream *stream)
 	mutex_lock(&dsp->pwr_lock);
 
 	if (wm_adsp_fw[dsp->fw].num_caps == 0) {
-		adsp_err(dsp, "Firmware does not support compressed API\n");
+		adsp_err(dsp, "%s: Firmware does not support compressed API\n",
+			 rtd->codec_dai->name);
 		ret = -ENXIO;
 		goto out;
 	}
 
 	if (wm_adsp_fw[dsp->fw].compr_direction != stream->direction) {
-		adsp_err(dsp, "Firmware does not support stream direction\n");
+		adsp_err(dsp, "%s: Firmware does not support stream direction\n",
+			 rtd->codec_dai->name);
 		ret = -EINVAL;
 		goto out;
 	}
 
 	list_for_each_entry(tmp, &dsp->compr_list, list) {
 		if (!strcmp(tmp->name, rtd->codec_dai->name)) {
-			adsp_err(dsp, "Only a single stream supported per dai\n");
+			adsp_err(dsp, "%s: Only a single stream supported per dai\n",
+				 rtd->codec_dai->name);
 			ret = -EBUSY;
 			goto out;
 		}
@@ -3106,9 +3116,9 @@ static int wm_adsp_compr_check_params(struct snd_compr_stream *stream,
 	    params->buffer.fragments < WM_ADSP_MIN_FRAGMENTS ||
 	    params->buffer.fragments > WM_ADSP_MAX_FRAGMENTS ||
 	    params->buffer.fragment_size % WM_ADSP_DATA_WORD_SIZE) {
-		adsp_err(dsp, "Invalid buffer fragsize=%d fragments=%d\n",
-			 params->buffer.fragment_size,
-			 params->buffer.fragments);
+		compr_err(compr, "Invalid buffer fragsize=%d fragments=%d\n",
+			  params->buffer.fragment_size,
+			  params->buffer.fragments);
 
 		return -EINVAL;
 	}
@@ -3136,9 +3146,9 @@ static int wm_adsp_compr_check_params(struct snd_compr_stream *stream,
 				return 0;
 	}
 
-	adsp_err(dsp, "Invalid params id=%u ch=%u,%u rate=%u fmt=%u\n",
-		 params->codec.id, params->codec.ch_in, params->codec.ch_out,
-		 params->codec.sample_rate, params->codec.format);
+	compr_err(compr, "Invalid params id=%u ch=%u,%u rate=%u fmt=%u\n",
+		  params->codec.id, params->codec.ch_in, params->codec.ch_out,
+		  params->codec.sample_rate, params->codec.format);
 	return -EINVAL;
 }
 
@@ -3160,8 +3170,8 @@ int wm_adsp_compr_set_params(struct snd_compr_stream *stream,
 
 	compr->size = params->buffer;
 
-	adsp_dbg(compr->dsp, "fragment_size=%d fragments=%d\n",
-		 compr->size.fragment_size, compr->size.fragments);
+	compr_dbg(compr, "fragment_size=%d fragments=%d\n",
+		  compr->size.fragment_size, compr->size.fragments);
 
 	size = wm_adsp_compr_frag_words(compr) * sizeof(*compr->raw_buf);
 	compr->raw_buf = kmalloc(size, GFP_DMA | GFP_KERNEL);
@@ -3303,10 +3313,10 @@ static int wm_adsp_buffer_populate(struct wm_adsp_compr_buf *buf)
 
 		region->cumulative_size = offset;
 
-		adsp_dbg(buf->dsp,
-			 "region=%d type=%d base=%08x off=%08x size=%08x\n",
-			 i, region->mem_type, region->base_addr,
-			 region->offset, region->cumulative_size);
+		compr_dbg(buf,
+			  "region=%d type=%d base=%08x off=%08x size=%08x\n",
+			  i, region->mem_type, region->base_addr,
+			  region->offset, region->cumulative_size);
 	}
 
 	return 0;
@@ -3380,7 +3390,7 @@ static int wm_adsp_buffer_parse_legacy(struct wm_adsp *dsp)
 	if (ret < 0)
 		return ret;
 
-	adsp_dbg(dsp, "legacy host_buf_ptr=%x\n", buf->host_buf_ptr);
+	compr_dbg(buf, "legacy host_buf_ptr=%x\n", buf->host_buf_ptr);
 
 	return 0;
 }
@@ -3428,7 +3438,7 @@ static int wm_adsp_buffer_parse_coeff(struct wm_coeff_ctl *ctl)
 	 * control is one word, assume version 0.
 	 */
 	if (ctl->len == 4) {
-		adsp_dbg(ctl->dsp, "host_buf_ptr=%x\n", buf->host_buf_ptr);
+		compr_dbg(buf, "host_buf_ptr=%x\n", buf->host_buf_ptr);
 		return 0;
 	}
 
@@ -3458,8 +3468,8 @@ static int wm_adsp_buffer_parse_coeff(struct wm_coeff_ctl *ctl)
 	buf->name = kasprintf(GFP_KERNEL, "%s-dsp-%s", ctl->dsp->part,
 			      (char *)&coeff_v1.name);
 
-	adsp_dbg(ctl->dsp, "host_buf_ptr=%x coeff version %u\n",
-		 buf->host_buf_ptr, val);
+	compr_dbg(buf, "host_buf_ptr=%x coeff version %u\n",
+		  buf->host_buf_ptr, val);
 
 	return val;
 }
@@ -3525,7 +3535,7 @@ int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
 	struct wm_adsp *dsp = compr->dsp;
 	int ret = 0;
 
-	adsp_dbg(dsp, "Trigger: %d\n", cmd);
+	compr_dbg(compr, "Trigger: %d\n", cmd);
 
 	mutex_lock(&dsp->pwr_lock);
 
@@ -3534,8 +3544,8 @@ int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
 		if (!wm_adsp_compr_attached(compr)) {
 			ret = wm_adsp_compr_attach(compr);
 			if (ret < 0) {
-				adsp_err(dsp, "Failed to link buffer and stream: %d\n",
-					 ret);
+				compr_err(compr, "Failed to link buffer and stream: %d\n",
+					  ret);
 				break;
 			}
 		}
@@ -3547,8 +3557,8 @@ int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
 					   HOST_BUFFER_FIELD(high_water_mark),
 					   wm_adsp_compr_frag_words(compr));
 		if (ret < 0) {
-			adsp_err(dsp, "Failed to set high water mark: %d\n",
-				 ret);
+			compr_err(compr, "Failed to set high water mark: %d\n",
+				  ret);
 			break;
 		}
 		break;
@@ -3589,7 +3599,7 @@ static int wm_adsp_buffer_update_avail(struct wm_adsp_compr_buf *buf)
 		read_index = sign_extend32(next_read_index, 23);
 
 		if (read_index < 0) {
-			adsp_dbg(buf->dsp, "Avail check on unstarted stream\n");
+			compr_dbg(buf, "Avail check on unstarted stream\n");
 			return 0;
 		}
 
@@ -3607,8 +3617,8 @@ static int wm_adsp_buffer_update_avail(struct wm_adsp_compr_buf *buf)
 	if (avail < 0)
 		avail += wm_adsp_buffer_size(buf);
 
-	adsp_dbg(buf->dsp, "readindex=0x%x, writeindex=0x%x, avail=%d\n",
-		 buf->read_index, write_index, avail * WM_ADSP_DATA_WORD_SIZE);
+	compr_dbg(buf, "readindex=0x%x, writeindex=0x%x, avail=%d\n",
+		  buf->read_index, write_index, avail * WM_ADSP_DATA_WORD_SIZE);
 
 	buf->avail = avail;
 
@@ -3621,11 +3631,11 @@ static int wm_adsp_buffer_get_error(struct wm_adsp_compr_buf *buf)
 
 	ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(error), &buf->error);
 	if (ret < 0) {
-		adsp_err(buf->dsp, "Failed to check buffer error: %d\n", ret);
+		compr_err(buf, "Failed to check buffer error: %d\n", ret);
 		return ret;
 	}
 	if (buf->error != 0) {
-		adsp_err(buf->dsp, "Buffer error occurred: %d\n", buf->error);
+		compr_err(buf, "Buffer error occurred: %d\n", buf->error);
 		return -EIO;
 	}
 
@@ -3644,6 +3654,7 @@ int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 		ret = -ENODEV;
 		goto out;
 	}
+
 	adsp_dbg(dsp, "Handling buffer IRQ\n");
 
 	list_for_each_entry(buf, &dsp->buffer_list, list) {
@@ -3656,13 +3667,13 @@ int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 		ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(irq_count),
 					  &buf->irq_count);
 		if (ret < 0) {
-			adsp_err(dsp, "Failed to get irq_count: %d\n", ret);
+			compr_err(buf, "Failed to get irq_count: %d\n", ret);
 			goto out;
 		}
 
 		ret = wm_adsp_buffer_update_avail(buf);
 		if (ret < 0) {
-			adsp_err(dsp, "Error reading avail: %d\n", ret);
+			compr_err(buf, "Error reading avail: %d\n", ret);
 			goto out;
 		}
 
@@ -3686,8 +3697,7 @@ static int wm_adsp_buffer_reenable_irq(struct wm_adsp_compr_buf *buf)
 	if (buf->irq_count & 0x01)
 		return 0;
 
-	adsp_dbg(buf->dsp, "Enable IRQ(0x%x) for next fragment\n",
-		 buf->irq_count);
+	compr_dbg(buf, "Enable IRQ(0x%x) for next fragment\n", buf->irq_count);
 
 	buf->irq_count |= 0x01;
 
@@ -3703,7 +3713,7 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 	struct wm_adsp_compr_buf *buf;
 	int ret = 0;
 
-	adsp_dbg(dsp, "Pointer request\n");
+	compr_dbg(compr, "Pointer request\n");
 
 	mutex_lock(&dsp->pwr_lock);
 
@@ -3718,7 +3728,7 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 	if (buf->avail < wm_adsp_compr_frag_words(compr)) {
 		ret = wm_adsp_buffer_update_avail(buf);
 		if (ret < 0) {
-			adsp_err(dsp, "Error reading avail: %d\n", ret);
+			compr_err(compr, "Error reading avail: %d\n", ret);
 			goto out;
 		}
 
@@ -3737,9 +3747,8 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 
 			ret = wm_adsp_buffer_reenable_irq(buf);
 			if (ret < 0) {
-				adsp_err(dsp,
-					 "Failed to re-enable buffer IRQ: %d\n",
-					 ret);
+				compr_err(compr, "Failed to re-enable buffer IRQ: %d\n",
+					  ret);
 				goto out;
 			}
 		}
@@ -3814,11 +3823,10 @@ static int wm_adsp_buffer_capture_block(struct wm_adsp_compr *compr, int target)
 static int wm_adsp_compr_read(struct wm_adsp_compr *compr,
 			      char __user *buf, size_t count)
 {
-	struct wm_adsp *dsp = compr->dsp;
 	int ntotal = 0;
 	int nwords, nbytes;
 
-	adsp_dbg(dsp, "Requested read of %zu bytes\n", count);
+	compr_dbg(compr, "Requested read of %zu bytes\n", count);
 
 	if (!compr->buf || compr->buf->error) {
 		snd_compr_stop_error(compr->stream, SNDRV_PCM_STATE_XRUN);
@@ -3830,17 +3838,18 @@ static int wm_adsp_compr_read(struct wm_adsp_compr *compr,
 	do {
 		nwords = wm_adsp_buffer_capture_block(compr, count);
 		if (nwords < 0) {
-			adsp_err(dsp, "Failed to capture block: %d\n", nwords);
+			compr_err(compr, "Failed to capture block: %d\n",
+				  nwords);
 			return nwords;
 		}
 
 		nbytes = nwords * WM_ADSP_DATA_WORD_SIZE;
 
-		adsp_dbg(dsp, "Read %d bytes\n", nbytes);
+		compr_dbg(compr, "Read %d bytes\n", nbytes);
 
 		if (copy_to_user(buf + ntotal, compr->raw_buf, nbytes)) {
-			adsp_err(dsp, "Failed to copy data to user: %d, %d\n",
-				 ntotal, nbytes);
+			compr_err(compr, "Failed to copy data to user: %d, %d\n",
+				  ntotal, nbytes);
 			return -EFAULT;
 		}
 
-- 
2.20.1
