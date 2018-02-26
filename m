From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dmaengine_pcm: add processing support"
	to the asoc tree
Date: Mon, 26 Feb 2018 11:17:10 +0000
Message-ID: <E1eqGmM-0005Om-NT@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D8D72267990
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 12:17:13 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olivier Moysan <olivier.moysan@st.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dmaengine_pcm: add processing support

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

>From 78648092ef46255e6dc6685202164199c86cf930 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 19 Feb 2018 16:00:36 +0100
Subject: [PATCH] ASoC: dmaengine_pcm: add processing support

Allow dmaengine client to optionally register a processing callback.
This callback is intended to apply processing
on samples in buffer copied from/to user space, before/after DMA transfer.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/dmaengine_pcm.h         |  3 ++
 sound/soc/soc-generic-dmaengine-pcm.c | 62 +++++++++++++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 8a5a8404966e..47ef486852ed 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -140,6 +140,9 @@ struct snd_dmaengine_pcm_config {
 	struct dma_chan *(*compat_request_channel)(
 			struct snd_soc_pcm_runtime *rtd,
 			struct snd_pcm_substream *substream);
+	int (*process)(struct snd_pcm_substream *substream,
+		       int channel, unsigned long hwoff,
+		       void *buf, unsigned long bytes);
 	dma_filter_fn compat_filter_fn;
 	struct device *dma_dev;
 	const char *chan_names[SNDRV_PCM_STREAM_LAST + 1];
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 785f25ede3e5..567fbdfd1ca9 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -341,6 +341,41 @@ static snd_pcm_uframes_t dmaengine_pcm_pointer(
 		return snd_dmaengine_pcm_pointer(substream);
 }
 
+static int dmaengine_copy_user(struct snd_pcm_substream *substream,
+			       int channel, unsigned long hwoff,
+			       void *buf, unsigned long bytes)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, SND_DMAENGINE_PCM_DRV_NAME);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct dmaengine_pcm *pcm = soc_component_to_pcm(component);
+	int (*process)(struct snd_pcm_substream *substream,
+		       int channel, unsigned long hwoff,
+		       void *buf, unsigned long bytes) = pcm->config->process;
+	bool is_playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
+	void *dma_ptr = runtime->dma_area + hwoff +
+			channel * (runtime->dma_bytes / runtime->channels);
+	int ret;
+
+	if (is_playback)
+		if (copy_from_user(dma_ptr, (void __user *)buf, bytes))
+			return -EFAULT;
+
+	if (process) {
+		ret = process(substream, channel, hwoff,
+			      (void __user *)buf, bytes);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (!is_playback)
+		if (copy_to_user((void __user *)buf, dma_ptr, bytes))
+			return -EFAULT;
+
+	return 0;
+}
+
 static const struct snd_pcm_ops dmaengine_pcm_ops = {
 	.open		= dmaengine_pcm_open,
 	.close		= snd_dmaengine_pcm_close,
@@ -351,6 +386,17 @@ static const struct snd_pcm_ops dmaengine_pcm_ops = {
 	.pointer	= dmaengine_pcm_pointer,
 };
 
+static const struct snd_pcm_ops dmaengine_pcm_process_ops = {
+	.open		= dmaengine_pcm_open,
+	.close		= snd_dmaengine_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= dmaengine_pcm_hw_params,
+	.hw_free	= snd_pcm_lib_free_pages,
+	.trigger	= snd_dmaengine_pcm_trigger,
+	.pointer	= dmaengine_pcm_pointer,
+	.copy_user	= dmaengine_copy_user,
+};
+
 static const struct snd_soc_component_driver dmaengine_pcm_component = {
 	.name		= SND_DMAENGINE_PCM_DRV_NAME,
 	.probe_order	= SND_SOC_COMP_ORDER_LATE,
@@ -358,6 +404,13 @@ static const struct snd_soc_component_driver dmaengine_pcm_component = {
 	.pcm_new	= dmaengine_pcm_new,
 };
 
+static const struct snd_soc_component_driver dmaengine_pcm_component_process = {
+	.name		= SND_DMAENGINE_PCM_DRV_NAME,
+	.probe_order	= SND_SOC_COMP_ORDER_LATE,
+	.ops		= &dmaengine_pcm_process_ops,
+	.pcm_new	= dmaengine_pcm_new,
+};
+
 static const char * const dmaengine_pcm_dma_channel_names[] = {
 	[SNDRV_PCM_STREAM_PLAYBACK] = "tx",
 	[SNDRV_PCM_STREAM_CAPTURE] = "rx",
@@ -453,8 +506,13 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	if (ret)
 		goto err_free_pcm;
 
-	ret = snd_soc_add_component(dev, &pcm->component,
-				    &dmaengine_pcm_component, NULL, 0);
+	if (config && config->process)
+		ret = snd_soc_add_component(dev, &pcm->component,
+					    &dmaengine_pcm_component_process,
+					    NULL, 0);
+	else
+		ret = snd_soc_add_component(dev, &pcm->component,
+					    &dmaengine_pcm_component, NULL, 0);
 	if (ret)
 		goto err_free_dma;
 
-- 
2.16.1
