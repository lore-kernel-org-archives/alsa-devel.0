From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH v2] ASoC: rt5514: Support the DSP recording
	continuously after the hotwording triggered
Date: Thu, 13 Jul 2017 19:42:20 +0800
Message-ID: <1499946140-28773-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id D9F7726648D
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 13:42:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, albertchen@realtek.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch uses the IRQ to copy the PCM data to userspace continuously after
the hotwording triggered from DSP.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5514-spi.c | 139 ++++++++++++++++++++++--------------------
 sound/soc/codecs/rt5514-spi.h |   7 +--
 2 files changed, 76 insertions(+), 70 deletions(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 7ed62e8..950d1ff 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -43,9 +43,7 @@ struct rt5514_dsp {
 	struct mutex dma_lock;
 	struct snd_pcm_substream *substream;
 	unsigned int buf_base, buf_limit, buf_rp;
-	size_t buf_size;
-	size_t dma_offset;
-	size_t dsp_offset;
+	size_t buf_size, get_size, dma_offset;
 };
 
 static const struct snd_pcm_hardware rt5514_spi_pcm_hardware = {
@@ -80,6 +78,8 @@ static void rt5514_spi_copy_work(struct work_struct *work)
 		container_of(work, struct rt5514_dsp, copy_work.work);
 	struct snd_pcm_runtime *runtime;
 	size_t period_bytes, truncated_bytes = 0;
+	unsigned int cur_wp, remain_data;
+	u8 buf[8];
 
 	mutex_lock(&rt5514_dsp->dma_lock);
 	if (!rt5514_dsp->substream) {
@@ -90,8 +90,24 @@ static void rt5514_spi_copy_work(struct work_struct *work)
 	runtime = rt5514_dsp->substream->runtime;
 	period_bytes = snd_pcm_lib_period_bytes(rt5514_dsp->substream);
 
-	if (rt5514_dsp->buf_size - rt5514_dsp->dsp_offset <  period_bytes)
-		period_bytes = rt5514_dsp->buf_size - rt5514_dsp->dsp_offset;
+	if (rt5514_dsp->get_size >= rt5514_dsp->buf_size) {
+		rt5514_spi_burst_read(RT5514_BUFFER_VOICE_WP, (u8 *)&buf,
+			sizeof(buf));
+		cur_wp = buf[0] | buf[1] << 8 | buf[2] << 16 |
+					buf[3] << 24;
+
+		if (cur_wp >= rt5514_dsp->buf_rp)
+			remain_data = (cur_wp - rt5514_dsp->buf_rp);
+		else
+			remain_data =
+				(rt5514_dsp->buf_limit - rt5514_dsp->buf_rp) +
+				(cur_wp - rt5514_dsp->buf_base);
+
+		if (remain_data < period_bytes) {
+			schedule_delayed_work(&rt5514_dsp->copy_work, 5);
+			goto done;
+		}
+	}
 
 	if (rt5514_dsp->buf_rp + period_bytes <= rt5514_dsp->buf_limit) {
 		rt5514_spi_burst_read(rt5514_dsp->buf_rp,
@@ -112,24 +128,58 @@ static void rt5514_spi_copy_work(struct work_struct *work)
 			runtime->dma_area + rt5514_dsp->dma_offset +
 			truncated_bytes, period_bytes - truncated_bytes);
 
-			rt5514_dsp->buf_rp = rt5514_dsp->buf_base +
-				period_bytes - truncated_bytes;
+		rt5514_dsp->buf_rp = rt5514_dsp->buf_base + period_bytes -
+			truncated_bytes;
 	}
 
+	rt5514_dsp->get_size += period_bytes;
 	rt5514_dsp->dma_offset += period_bytes;
 	if (rt5514_dsp->dma_offset >= runtime->dma_bytes)
 		rt5514_dsp->dma_offset = 0;
 
-	rt5514_dsp->dsp_offset += period_bytes;
-
 	snd_pcm_period_elapsed(rt5514_dsp->substream);
 
-	if (rt5514_dsp->dsp_offset < rt5514_dsp->buf_size)
-		schedule_delayed_work(&rt5514_dsp->copy_work, 5);
+	schedule_delayed_work(&rt5514_dsp->copy_work, 5);
+
 done:
 	mutex_unlock(&rt5514_dsp->dma_lock);
 }
 
+static irqreturn_t rt5514_spi_irq(int irq, void *data)
+{
+	struct rt5514_dsp *rt5514_dsp = data;
+	u8 buf[8];
+
+	rt5514_dsp->get_size = 0;
+	rt5514_dsp->dma_offset = 0;
+
+	/**
+	 * The address area x1800XXXX is the register address, and it cannot
+	 * support spi burst read perfectly. So we use the spi burst read
+	 * individually to make sure the data correctly.
+	 */
+	rt5514_spi_burst_read(RT5514_BUFFER_VOICE_BASE, (u8 *)&buf,
+		sizeof(buf));
+	rt5514_dsp->buf_base = buf[0] | buf[1] << 8 | buf[2] << 16 |
+				buf[3] << 24;
+
+	rt5514_spi_burst_read(RT5514_BUFFER_VOICE_LIMIT, (u8 *)&buf,
+		sizeof(buf));
+	rt5514_dsp->buf_limit = buf[0] | buf[1] << 8 | buf[2] << 16 |
+				buf[3] << 24;
+
+	rt5514_spi_burst_read(RT5514_BUFFER_VOICE_WP, (u8 *)&buf,
+		sizeof(buf));
+	rt5514_dsp->buf_rp = buf[0] | buf[1] << 8 | buf[2] << 16 |
+				buf[3] << 24;
+
+	rt5514_dsp->buf_size = rt5514_dsp->buf_limit - rt5514_dsp->buf_base;
+
+	schedule_delayed_work(&rt5514_dsp->copy_work, 0);
+
+	return IRQ_HANDLED;
+}
+
 /* PCM for streaming audio from the DSP buffer */
 static int rt5514_spi_pcm_open(struct snd_pcm_substream *substream)
 {
@@ -170,59 +220,6 @@ static int rt5514_spi_hw_free(struct snd_pcm_substream *substream)
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
 }
 
-static int rt5514_spi_prepare(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct rt5514_dsp *rt5514_dsp =
-			snd_soc_platform_get_drvdata(rtd->platform);
-	u8 buf[8];
-
-	rt5514_dsp->dma_offset = 0;
-	rt5514_dsp->dsp_offset = 0;
-
-	/**
-	 * The address area x1800XXXX is the register address, and it cannot
-	 * support spi burst read perfectly. So we use the spi burst read
-	 * individually to make sure the data correctly.
-	*/
-	rt5514_spi_burst_read(RT5514_BUFFER_VOICE_BASE, (u8 *)&buf,
-		sizeof(buf));
-	rt5514_dsp->buf_base = buf[0] | buf[1] << 8 | buf[2] << 16 |
-				buf[3] << 24;
-
-	rt5514_spi_burst_read(RT5514_BUFFER_VOICE_LIMIT, (u8 *)&buf,
-		sizeof(buf));
-	rt5514_dsp->buf_limit = buf[0] | buf[1] << 8 | buf[2] << 16 |
-				buf[3] << 24;
-
-	rt5514_spi_burst_read(RT5514_BUFFER_VOICE_RP, (u8 *)&buf,
-		sizeof(buf));
-	rt5514_dsp->buf_rp = buf[0] | buf[1] << 8 | buf[2] << 16 |
-				buf[3] << 24;
-
-	rt5514_spi_burst_read(RT5514_BUFFER_VOICE_SIZE, (u8 *)&buf,
-		sizeof(buf));
-	rt5514_dsp->buf_size = buf[0] | buf[1] << 8 | buf[2] << 16 |
-				buf[3] << 24;
-
-	return 0;
-}
-
-static int rt5514_spi_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct rt5514_dsp *rt5514_dsp =
-			snd_soc_platform_get_drvdata(rtd->platform);
-
-	if (cmd == SNDRV_PCM_TRIGGER_START) {
-		if (rt5514_dsp->buf_base && rt5514_dsp->buf_limit &&
-			rt5514_dsp->buf_rp && rt5514_dsp->buf_size)
-			schedule_delayed_work(&rt5514_dsp->copy_work, 0);
-	}
-
-	return 0;
-}
-
 static snd_pcm_uframes_t rt5514_spi_pcm_pointer(
 		struct snd_pcm_substream *substream)
 {
@@ -238,8 +235,6 @@ static const struct snd_pcm_ops rt5514_spi_pcm_ops = {
 	.open		= rt5514_spi_pcm_open,
 	.hw_params	= rt5514_spi_hw_params,
 	.hw_free	= rt5514_spi_hw_free,
-	.trigger	= rt5514_spi_trigger,
-	.prepare	= rt5514_spi_prepare,
 	.pointer	= rt5514_spi_pcm_pointer,
 	.mmap		= snd_pcm_lib_mmap_vmalloc,
 	.page		= snd_pcm_lib_get_vmalloc_page,
@@ -248,6 +243,7 @@ static const struct snd_pcm_ops rt5514_spi_pcm_ops = {
 static int rt5514_spi_pcm_probe(struct snd_soc_platform *platform)
 {
 	struct rt5514_dsp *rt5514_dsp;
+	int ret;
 
 	rt5514_dsp = devm_kzalloc(platform->dev, sizeof(*rt5514_dsp),
 			GFP_KERNEL);
@@ -257,6 +253,17 @@ static int rt5514_spi_pcm_probe(struct snd_soc_platform *platform)
 	INIT_DELAYED_WORK(&rt5514_dsp->copy_work, rt5514_spi_copy_work);
 	snd_soc_platform_set_drvdata(platform, rt5514_dsp);
 
+	if (rt5514_spi->irq) {
+		ret = devm_request_threaded_irq(&rt5514_spi->dev,
+			rt5514_spi->irq, NULL, rt5514_spi_irq,
+			IRQF_TRIGGER_RISING | IRQF_ONESHOT, "rt5514-spi",
+			rt5514_dsp);
+		if (ret)
+			dev_err(&rt5514_spi->dev,
+				"%s Failed to reguest IRQ: %d\n", __func__,
+				ret);
+	}
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/rt5514-spi.h b/sound/soc/codecs/rt5514-spi.h
index f69b1cd..a6434ee 100644
--- a/sound/soc/codecs/rt5514-spi.h
+++ b/sound/soc/codecs/rt5514-spi.h
@@ -17,10 +17,9 @@
 */
 #define RT5514_SPI_BUF_LEN		240
 
-#define RT5514_BUFFER_VOICE_BASE	0x18001034
-#define RT5514_BUFFER_VOICE_LIMIT	0x18001038
-#define RT5514_BUFFER_VOICE_RP		0x1800103c
-#define RT5514_BUFFER_VOICE_SIZE	0x18001040
+#define RT5514_BUFFER_VOICE_BASE	0x18000200
+#define RT5514_BUFFER_VOICE_LIMIT	0x18000204
+#define RT5514_BUFFER_VOICE_WP		0x1800020c
 
 /* SPI Command */
 enum {
-- 
2.7.4
