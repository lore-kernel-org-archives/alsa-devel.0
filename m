From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 02/10] ALSA: Add new DSP loader callback
	routines
Date: Thu, 20 Sep 2012 20:29:13 -0700
Message-ID: <1348198161-9256-3-git-send-email-ian_minett@creativelabs.com>
References: <1348198161-9256-1-git-send-email-ian_minett@creativelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1348198161-9256-1-git-send-email-ian_minett@creativelabs.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

From: Takashi Iwai <tiwai@suse.de>

Pass DMA buffer pointers in calls to setup_bdle().
Add DSP loader callback routines to controller.
Add new DSP loader switch to Kconfig to turn off DSP firmware.

Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 7105c3d..ba1dbd8 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -236,4 +236,12 @@ config SND_HDA_POWER_SAVE_DEFAULT
 	  The default time-out value in seconds for HD-audio automatic
 	  power-save mode.  0 means to disable the power-save mode.
 
+config SND_HDA_DSP_LOADER
+	bool "Enable DSP firmware loader"
+	depends on FW_LOADER
+	default y
+	help
+	  Say Y here to enable the DSP firmware loader, used by certain
+	  codecs (e.g. CA0132) to transfer their DSP binaries to the hardware.
+
 endif
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 507fe8a..c218bf4 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -618,6 +618,17 @@ struct hda_bus_ops {
 	/* notify power-up/down from codec to controller */
 	void (*pm_notify)(struct hda_bus *bus, bool power_up);
 #endif
+#ifdef CONFIG_SND_HDA_DSP_LOADER
+	/* prepare DSP transfer */
+	int (*load_dsp_prepare)(struct hda_bus *bus, unsigned int format,
+				unsigned int byte_size,
+				struct snd_dma_buffer *bufp);
+	/* start/stop DSP transfer */
+	void (*load_dsp_trigger)(struct hda_bus *bus, bool start);
+	/* clean up DSP transfer */
+	void (*load_dsp_cleanup)(struct hda_bus *bus,
+				 struct snd_dma_buffer *dmab);
+#endif
 };
 
 /* template to pass to the bus constructor */
@@ -1129,6 +1140,40 @@ static inline void snd_hda_power_sync(struct hda_codec *codec)
 int snd_hda_load_patch(struct hda_bus *bus, size_t size, const void *buf);
 #endif
 
+#ifdef CONFIG_SND_HDA_DSP_LOADER
+static inline int
+snd_hda_codec_load_dsp_prepare(struct hda_codec *codec, unsigned int format,
+				unsigned int size,
+				struct snd_dma_buffer *bufp)
+{
+	return codec->bus->ops.load_dsp_prepare(codec->bus, format, size, bufp);
+}
+static inline void
+snd_hda_codec_load_dsp_trigger(struct hda_codec *codec, bool start)
+{
+	return codec->bus->ops.load_dsp_trigger(codec->bus, start);
+}
+static inline void
+snd_hda_codec_load_dsp_cleanup(struct hda_codec *codec,
+				struct snd_dma_buffer *dmab)
+{
+	return codec->bus->ops.load_dsp_cleanup(codec->bus, dmab);
+}
+#else
+static inline int
+snd_hda_codec_load_dsp_prepare(struct hda_codec *codec, unsigned int format,
+				unsigned int size,
+				struct snd_dma_buffer *bufp)
+{
+	return 0;
+}
+static inline void
+snd_hda_codec_load_dsp_trigger(struct hda_codec *codec, bool start) {}
+static inline void
+snd_hda_codec_load_dsp_cleanup(struct hda_codec *codec,
+				struct snd_dma_buffer *dmab) {}
+#endif
+
 /*
  * Codec modularization
  */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index bd90a51..66fefd1 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1037,6 +1037,15 @@ static unsigned int azx_get_response(struct hda_bus *bus,
 static void azx_power_notify(struct hda_bus *bus, bool power_up);
 #endif
 
+#ifdef CONFIG_SND_HDA_DSP_LOADER
+static int azx_load_dsp_prepare(struct hda_bus *bus, unsigned int format,
+				unsigned int byte_size,
+				struct snd_dma_buffer *bufp);
+static void azx_load_dsp_trigger(struct hda_bus *bus, bool start);
+static void azx_load_dsp_cleanup(struct hda_bus *bus,
+				 struct snd_dma_buffer *dmab);
+#endif
+
 /* reset codec link */
 static int azx_reset(struct azx *chip, int full_reset)
 {
@@ -1358,7 +1367,7 @@ static irqreturn_t azx_interrupt(int irq, void *dev_id)
  * set up a BDL entry
  */
 static int setup_bdle(struct azx *chip,
-		      struct snd_pcm_substream *substream,
+		      struct snd_dma_buffer *dmab,
 		      struct azx_dev *azx_dev, u32 **bdlp,
 		      int ofs, int size, int with_ioc)
 {
@@ -1371,12 +1380,12 @@ static int setup_bdle(struct azx *chip,
 		if (azx_dev->frags >= AZX_MAX_BDL_ENTRIES)
 			return -EINVAL;
 
-		addr = snd_pcm_sgbuf_get_addr(substream, ofs);
+		addr = snd_sgbuf_get_addr(dmab, ofs);
 		/* program the address field of the BDL entry */
 		bdl[0] = cpu_to_le32((u32)addr);
 		bdl[1] = cpu_to_le32(upper_32_bits(addr));
 		/* program the size field of the BDL entry */
-		chunk = snd_pcm_sgbuf_get_chunk_size(substream, ofs, size);
+		chunk = snd_sgbuf_get_chunk_size(dmab, ofs, size);
 		/* one BDLE cannot cross 4K boundary on CTHDA chips */
 		if (chip->driver_caps & AZX_DCAPS_4K_BDLE_BOUNDARY) {
 			u32 remain = 0x1000 - (ofs & 0xfff);
@@ -1435,7 +1444,8 @@ static int azx_setup_periods(struct azx *chip,
 				   bdl_pos_adj[chip->dev_index]);
 			pos_adj = 0;
 		} else {
-			ofs = setup_bdle(chip, substream, azx_dev,
+			ofs = setup_bdle(chip, snd_pcm_get_dma_buf(substream),
+					 azx_dev,
 					 &bdl, ofs, pos_adj, true);
 			if (ofs < 0)
 				goto error;
@@ -1444,10 +1454,12 @@ static int azx_setup_periods(struct azx *chip,
 		pos_adj = 0;
 	for (i = 0; i < periods; i++) {
 		if (i == periods - 1 && pos_adj)
-			ofs = setup_bdle(chip, substream, azx_dev, &bdl, ofs,
+			ofs = setup_bdle(chip, snd_pcm_get_dma_buf(substream),
+					 azx_dev, &bdl, ofs,
 					 period_bytes - pos_adj, 0);
 		else
-			ofs = setup_bdle(chip, substream, azx_dev, &bdl, ofs,
+			ofs = setup_bdle(chip, snd_pcm_get_dma_buf(substream),
+					 azx_dev, &bdl, ofs,
 					 period_bytes,
 					 !azx_dev->no_period_wakeup);
 		if (ofs < 0)
@@ -1609,6 +1621,11 @@ static int DELAYED_INIT_MARK azx_codec_create(struct azx *chip, const char *mode
 	bus_temp.power_save = &power_save;
 	bus_temp.ops.pm_notify = azx_power_notify;
 #endif
+#ifdef CONFIG_SND_HDA_DSP_LOADER
+	bus_temp.ops.load_dsp_prepare = azx_load_dsp_prepare;
+	bus_temp.ops.load_dsp_trigger = azx_load_dsp_trigger;
+	bus_temp.ops.load_dsp_cleanup = azx_load_dsp_cleanup;
+#endif
 
 	err = snd_hda_bus_new(chip->card, &bus_temp, &chip->bus);
 	if (err < 0)
@@ -2406,6 +2423,93 @@ static void azx_stop_chip(struct azx *chip)
 	chip->initialized = 0;
 }
 
+#ifdef CONFIG_SND_HDA_DSP_LOADER
+/*
+ * DSP loading code (e.g. for CA0132)
+ */
+
+/* use the first stream for loading DSP */
+static struct azx_dev *
+azx_get_dsp_loader_dev(struct azx *chip)
+{
+	return &chip->azx_dev[chip->playback_index_offset];
+}
+
+static int azx_load_dsp_prepare(struct hda_bus *bus, unsigned int format,
+				unsigned int byte_size,
+				struct snd_dma_buffer *bufp)
+{
+	u32 *bdl;
+	struct azx *chip = bus->private_data;
+	struct azx_dev *azx_dev;
+	int err;
+
+	if (snd_hda_lock_devices(bus))
+		return -EBUSY;
+
+	err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV_SG,
+				  snd_dma_pci_data(chip->pci),
+				  byte_size, bufp);
+	if (err < 0)
+		goto error;
+
+	azx_dev = azx_get_dsp_loader_dev(chip);
+	azx_dev->bufsize = byte_size;
+	azx_dev->period_bytes = byte_size;
+	azx_dev->format_val = format;
+
+	azx_stream_reset(chip, azx_dev);
+
+	/* reset BDL address */
+	azx_sd_writel(azx_dev, SD_BDLPL, 0);
+	azx_sd_writel(azx_dev, SD_BDLPU, 0);
+
+	azx_dev->frags = 0;
+	bdl = (u32 *)azx_dev->bdl.area;
+	err = setup_bdle(chip, bufp, azx_dev, &bdl, 0, byte_size, 0);
+	if (err < 0)
+		goto error;
+
+	azx_setup_controller(chip, azx_dev);
+	return azx_dev->stream_tag;
+
+ error:
+	snd_hda_unlock_devices(bus);
+	return err;
+}
+
+static void azx_load_dsp_trigger(struct hda_bus *bus, bool start)
+{
+	struct azx *chip = bus->private_data;
+	struct azx_dev *azx_dev = azx_get_dsp_loader_dev(chip);
+
+	if (start)
+		azx_stream_start(chip, azx_dev);
+	else
+		azx_stream_stop(chip, azx_dev);
+	azx_dev->running = start;
+}
+
+static void azx_load_dsp_cleanup(struct hda_bus *bus,
+				 struct snd_dma_buffer *dmab)
+{
+	struct azx *chip = bus->private_data;
+	struct azx_dev *azx_dev = azx_get_dsp_loader_dev(chip);
+
+	/* reset BDL address */
+	azx_sd_writel(azx_dev, SD_BDLPL, 0);
+	azx_sd_writel(azx_dev, SD_BDLPU, 0);
+	azx_sd_writel(azx_dev, SD_CTL, 0);
+	azx_dev->bufsize = 0;
+	azx_dev->period_bytes = 0;
+	azx_dev->format_val = 0;
+
+	snd_dma_free_pages(dmab);
+
+	snd_hda_unlock_devices(bus);
+}
+#endif /* CONFIG_SND_HDA_DSP_LOADER */
+
 #ifdef CONFIG_PM
 /* power-up/down the controller */
 static void azx_power_notify(struct hda_bus *bus, bool power_up)
-- 
1.7.4.1
