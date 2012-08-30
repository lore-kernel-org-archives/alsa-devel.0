From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 2/3] ALSA: Add new DSP loader callback routines
Date: Thu, 30 Aug 2012 13:21:05 -0700
Message-ID: <1346358066-7851-3-git-send-email-ian_minett@creativelabs.com>
References: <1346358066-7851-1-git-send-email-ian_minett@creativelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1346358066-7851-1-git-send-email-ian_minett@creativelabs.com>
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
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

From: Ian Minett <ian_minett@creativelabs.com>

Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 194d625..a7ff2c4 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -244,4 +244,12 @@ config SND_HDA_POWER_SAVE_DEFAULT
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
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 1b35115..d90e1b3 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2390,7 +2390,7 @@ typedef int (*map_slave_func_t)(void *, struct snd_kcontrol *);
 
 /* apply the function to all matching slave ctls in the mixer list */
 static int map_slaves(struct hda_codec *codec, const char * const *slaves,
-		      const char *suffix, map_slave_func_t func, void *data) 
+		      const char *suffix, map_slave_func_t func, void *data)
 {
 	struct hda_nid_item *items;
 	const char * const *s;
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 72477cc..faa3067 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -337,15 +337,15 @@ enum {
 #define AC_KNBCAP_DELTA			(1<<7)
 
 /* HDMI LPCM capabilities */
-#define AC_LPCMCAP_48K_CP_CHNS		(0x0f<<0) /* max channels w/ CP-on */	
+#define AC_LPCMCAP_48K_CP_CHNS		(0x0f<<0) /* max channels w/ CP-on */
 #define AC_LPCMCAP_48K_NO_CHNS		(0x0f<<4) /* max channels w/o CP-on */
 #define AC_LPCMCAP_48K_20BIT		(1<<8)	/* 20b bitrate supported */
 #define AC_LPCMCAP_48K_24BIT		(1<<9)	/* 24b bitrate supported */
-#define AC_LPCMCAP_96K_CP_CHNS		(0x0f<<10) /* max channels w/ CP-on */	
+#define AC_LPCMCAP_96K_CP_CHNS		(0x0f<<10) /* max channels w/ CP-on */
 #define AC_LPCMCAP_96K_NO_CHNS		(0x0f<<14) /* max channels w/o CP-on */
 #define AC_LPCMCAP_96K_20BIT		(1<<18)	/* 20b bitrate supported */
 #define AC_LPCMCAP_96K_24BIT		(1<<19)	/* 24b bitrate supported */
-#define AC_LPCMCAP_192K_CP_CHNS		(0x0f<<20) /* max channels w/ CP-on */	
+#define AC_LPCMCAP_192K_CP_CHNS		(0x0f<<20) /* max channels w/ CP-on */
 #define AC_LPCMCAP_192K_NO_CHNS		(0x0f<<24) /* max channels w/o CP-on */
 #define AC_LPCMCAP_192K_20BIT		(1<<28)	/* 20b bitrate supported */
 #define AC_LPCMCAP_192K_24BIT		(1<<29)	/* 24b bitrate supported */
@@ -618,6 +618,17 @@ struct hda_bus_ops {
 	/* notify power-up/down from codec to controller */
 	void (*pm_notify)(struct hda_bus *bus, struct hda_codec *codec);
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
@@ -689,7 +700,7 @@ struct hda_codec_preset {
 	const char *name;
 	int (*patch)(struct hda_codec *codec);
 };
-	
+
 struct hda_codec_preset_list {
 	const struct hda_codec_preset *preset;
 	struct module *owner;
@@ -1132,6 +1143,40 @@ static inline void snd_hda_power_sync(struct hda_codec *codec)
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
index 1c9c779..248d70a 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -31,7 +31,7 @@
  *  CHANGES:
  *
  *  2004.12.01	Major rewrite by tiwai, merged the work of pshou
- * 
+ *
  */
 
 #include <linux/delay.h>
@@ -600,8 +600,8 @@ static char *driver_short_names[] DELAYED_INITDATA_MARK = {
 	[AZX_DRIVER_SIS] = "HDA SIS966",
 	[AZX_DRIVER_ULI] = "HDA ULI M5461",
 	[AZX_DRIVER_NVIDIA] = "HDA NVidia",
-	[AZX_DRIVER_TERA] = "HDA Teradici", 
-	[AZX_DRIVER_CTX] = "HDA Creative", 
+	[AZX_DRIVER_TERA] = "HDA Teradici",
+	[AZX_DRIVER_CTX] = "HDA Creative",
 	[AZX_DRIVER_CTHDA] = "HDA Creative",
 	[AZX_DRIVER_GENERIC] = "HD-Audio Generic",
 };
@@ -1036,6 +1036,15 @@ static unsigned int azx_get_response(struct hda_bus *bus,
 static void azx_power_notify(struct hda_bus *bus, struct hda_codec *codec);
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
@@ -1093,7 +1102,7 @@ static int azx_reset(struct azx *chip, int full_reset)
 
 /*
  * Lowlevel interface
- */  
+ */
 
 /* enable interrupts */
 static void azx_int_enable(struct azx *chip)
@@ -1306,7 +1315,7 @@ static irqreturn_t azx_interrupt(int irq, void *dev_id)
 		spin_unlock(&chip->reg_lock);
 		return IRQ_NONE;
 	}
-	
+
 	for (i = 0; i < chip->num_streams; i++) {
 		azx_dev = &chip->azx_dev[i];
 		if (status & azx_dev->sd_int_sta_mask) {
@@ -1348,7 +1357,7 @@ static irqreturn_t azx_interrupt(int irq, void *dev_id)
 		azx_writeb(chip, STATESTS, 0x04);
 #endif
 	spin_unlock(&chip->reg_lock);
-	
+
 	return IRQ_HANDLED;
 }
 
@@ -1357,7 +1366,7 @@ static irqreturn_t azx_interrupt(int irq, void *dev_id)
  * set up a BDL entry
  */
 static int setup_bdle(struct azx *chip,
-		      struct snd_pcm_substream *substream,
+		      struct snd_dma_buffer *dmab,
 		      struct azx_dev *azx_dev, u32 **bdlp,
 		      int ofs, int size, int with_ioc)
 {
@@ -1370,12 +1379,12 @@ static int setup_bdle(struct azx *chip,
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
@@ -1434,9 +1443,9 @@ static int azx_setup_periods(struct azx *chip,
 				   bdl_pos_adj[chip->dev_index]);
 			pos_adj = 0;
 		} else {
-			ofs = setup_bdle(chip, substream, azx_dev,
-					 &bdl, ofs, pos_adj,
-					 !substream->runtime->no_period_wakeup);
+			ofs = setup_bdle(chip, snd_pcm_get_dma_buf(substream),
+					azx_dev, &bdl, ofs, pos_adj,
+					!substream->runtime->no_period_wakeup);
 			if (ofs < 0)
 				goto error;
 		}
@@ -1444,10 +1453,12 @@ static int azx_setup_periods(struct azx *chip,
 		pos_adj = 0;
 	for (i = 0; i < periods; i++) {
 		if (i == periods - 1 && pos_adj)
-			ofs = setup_bdle(chip, substream, azx_dev, &bdl, ofs,
+			ofs = setup_bdle(chip, snd_pcm_get_dma_buf(substream),
+					azx_dev, &bdl, ofs,
 					 period_bytes - pos_adj, 0);
 		else
-			ofs = setup_bdle(chip, substream, azx_dev, &bdl, ofs,
+			ofs = setup_bdle(chip, snd_pcm_get_dma_buf(substream),
+					 azx_dev, &bdl, ofs,
 					 period_bytes,
 					 !substream->runtime->no_period_wakeup);
 		if (ofs < 0)
@@ -1609,6 +1620,11 @@ static int DELAYED_INIT_MARK azx_codec_create(struct azx *chip, const char *mode
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
@@ -2462,6 +2478,93 @@ static int param_set_xint(const char *val, const struct kernel_param *kp)
 #define azx_del_card_list(chip) /* NOP */
 #endif /* CONFIG_SND_HDA_POWER_SAVE */
 
+#ifdef CONFIG_SND_HDA_DSP_LOADER
+/*
+ * DSP loading code (e.g. for CA0132)
+ */
+
+/*use the first stream for loading DSP*/
+static struct azx_dev*
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
+error:
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
 #if defined(CONFIG_PM_SLEEP) || defined(SUPPORT_VGA_SWITCHEROO)
 /*
  * power management
-- 
1.7.4.1
