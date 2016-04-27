From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dmaengine_pcm: Add support for packed transfers" to the asoc tree
Date: Wed, 27 Apr 2016 17:34:39 +0100
Message-ID: <E1avSQB-0004J4-I9@debutante>
References: <1461763613-28714-1-git-send-email-hias@horus.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461763613-28714-1-git-send-email-hias@horus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Reichl <hias@horus.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Martin Sperl <kernel@martin.sperl.org>, Mark Brown <broonie@kernel.org>Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgkernel@martin.sperl.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dmaengine_pcm: Add support for packed transfers

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

>From 73fe01cfb3babff01748a9fbc95cc3ea2079cc7f Mon Sep 17 00:00:00 2001
From: Matthias Reichl <hias@horus.com>
Date: Wed, 27 Apr 2016 15:26:51 +0200
Subject: [PATCH] ASoC: dmaengine_pcm: Add support for packed transfers

dmaengine_pcm currently only supports setups where FIFO reads/writes
correspond to exactly one sample, eg 16-bit sample data is transferred
via 16-bit FIFO accesses, 32-bit data via 32-bit accesses.

This patch adds support for setups with fixed width FIFOs where
multiple samples are packed into a larger word.

For example setups with a 32-bit wide FIFO register that expect
16-bit sample transfers to be done with the left+right sample data
packed into a 32-bit word.

Support for packed transfers is controlled via the
SND_DMAENGINE_PCM_DAI_FLAG_PACK flag in snd_dmaengine_dai_dma_data.flags

If this flag is set dmaengine_pcm doesn't put any restriction on the
supported formats and sets the DMA transfer width to undefined.

This means control over the constraints is now transferred to the DAI
driver and it's responsible to provide proper configuration and
check for possible corner cases that aren't handled by the ALSA core.

Signed-off-by: Matthias Reichl <hias@horus.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Tested-by: Martin Sperl <kernel@martin.sperl.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/dmaengine_pcm.h         | 12 ++++++++
 sound/core/pcm_dmaengine.c            | 11 +++++--
 sound/soc/soc-generic-dmaengine-pcm.c | 57 +++++++++++++++++++++--------------
 3 files changed, 55 insertions(+), 25 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index f86ef5ea9b01..67be2445941a 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -51,6 +51,16 @@ struct dma_chan *snd_dmaengine_pcm_request_channel(dma_filter_fn filter_fn,
 	void *filter_data);
 struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream);
 
+/*
+ * The DAI supports packed transfers, eg 2 16-bit samples in a 32-bit word.
+ * If this flag is set the dmaengine driver won't put any restriction on
+ * the supported sample formats and set the DMA transfer size to undefined.
+ * The DAI driver is responsible to disable any unsupported formats in it's
+ * configuration and catch corner cases that are not already handled in
+ * the ALSA core.
+ */
+#define SND_DMAENGINE_PCM_DAI_FLAG_PACK BIT(0)
+
 /**
  * struct snd_dmaengine_dai_dma_data - DAI DMA configuration data
  * @addr: Address of the DAI data source or destination register.
@@ -63,6 +73,7 @@ struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream)
  * requesting the DMA channel.
  * @chan_name: Custom channel name to use when requesting DMA channel.
  * @fifo_size: FIFO size of the DAI controller in bytes
+ * @flags: PCM_DAI flags, only SND_DMAENGINE_PCM_DAI_FLAG_PACK for now
  */
 struct snd_dmaengine_dai_dma_data {
 	dma_addr_t addr;
@@ -72,6 +83,7 @@ struct snd_dmaengine_dai_dma_data {
 	void *filter_data;
 	const char *chan_name;
 	unsigned int fifo_size;
+	unsigned int flags;
 };
 
 void snd_dmaengine_pcm_set_config_from_dai_data(
diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 697c166acf05..8eb58c709b14 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -106,8 +106,9 @@ EXPORT_SYMBOL_GPL(snd_hwparams_to_dma_slave_config);
  * direction of the substream. If the substream is a playback stream the dst
  * fields will be initialized, if it is a capture stream the src fields will be
  * initialized. The {dst,src}_addr_width field will only be initialized if the
- * addr_width field of the DAI DMA data struct is not equal to
- * DMA_SLAVE_BUSWIDTH_UNDEFINED.
+ * SND_DMAENGINE_PCM_DAI_FLAG_PACK flag is set or if the addr_width field of
+ * the DAI DMA data struct is not equal to DMA_SLAVE_BUSWIDTH_UNDEFINED. If
+ * both conditions are met the latter takes priority.
  */
 void snd_dmaengine_pcm_set_config_from_dai_data(
 	const struct snd_pcm_substream *substream,
@@ -117,11 +118,17 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		slave_config->dst_addr = dma_data->addr;
 		slave_config->dst_maxburst = dma_data->maxburst;
+		if (dma_data->flags & SND_DMAENGINE_PCM_DAI_FLAG_PACK)
+			slave_config->dst_addr_width =
+				DMA_SLAVE_BUSWIDTH_UNDEFINED;
 		if (dma_data->addr_width != DMA_SLAVE_BUSWIDTH_UNDEFINED)
 			slave_config->dst_addr_width = dma_data->addr_width;
 	} else {
 		slave_config->src_addr = dma_data->addr;
 		slave_config->src_maxburst = dma_data->maxburst;
+		if (dma_data->flags & SND_DMAENGINE_PCM_DAI_FLAG_PACK)
+			slave_config->src_addr_width =
+				DMA_SLAVE_BUSWIDTH_UNDEFINED;
 		if (dma_data->addr_width != DMA_SLAVE_BUSWIDTH_UNDEFINED)
 			slave_config->src_addr_width = dma_data->addr_width;
 	}
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 6fd1906af387..6cef3977507a 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -163,31 +163,42 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
 	}
 
 	/*
-	 * Prepare formats mask for valid/allowed sample types. If the dma does
-	 * not have support for the given physical word size, it needs to be
-	 * masked out so user space can not use the format which produces
-	 * corrupted audio.
-	 * In case the dma driver does not implement the slave_caps the default
-	 * assumption is that it supports 1, 2 and 4 bytes widths.
+	 * If SND_DMAENGINE_PCM_DAI_FLAG_PACK is set keep
+	 * hw.formats set to 0, meaning no restrictions are in place.
+	 * In this case it's the responsibility of the DAI driver to
+	 * provide the supported format information.
 	 */
-	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
-		int bits = snd_pcm_format_physical_width(i);
-
-		/* Enable only samples with DMA supported physical widths */
-		switch (bits) {
-		case 8:
-		case 16:
-		case 24:
-		case 32:
-		case 64:
-			if (addr_widths & (1 << (bits / 8)))
-				hw.formats |= (1LL << i);
-			break;
-		default:
-			/* Unsupported types */
-			break;
+	if (!(dma_data->flags & SND_DMAENGINE_PCM_DAI_FLAG_PACK))
+		/*
+		 * Prepare formats mask for valid/allowed sample types. If the
+		 * dma does not have support for the given physical word size,
+		 * it needs to be masked out so user space can not use the
+		 * format which produces corrupted audio.
+		 * In case the dma driver does not implement the slave_caps the
+		 * default assumption is that it supports 1, 2 and 4 bytes
+		 * widths.
+		 */
+		for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
+			int bits = snd_pcm_format_physical_width(i);
+
+			/*
+			 * Enable only samples with DMA supported physical
+			 * widths
+			 */
+			switch (bits) {
+			case 8:
+			case 16:
+			case 24:
+			case 32:
+			case 64:
+				if (addr_widths & (1 << (bits / 8)))
+					hw.formats |= (1LL << i);
+				break;
+			default:
+				/* Unsupported types */
+				break;
+			}
 		}
-	}
 
 	return snd_soc_set_runtime_hwparams(substream, &hw);
 }
-- 
2.8.0.rc3
