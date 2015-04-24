From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 17/21] ALSA: hda - Replace hda_bus_ops with
	static binding
Date: Fri, 24 Apr 2015 14:38:49 +0200
Message-ID: <1429879133-32293-18-git-send-email-tiwai@suse.de>
References: <1429879133-32293-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8233B2605F0
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 14:39:01 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D0EB2ADAC
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 12:39:00 +0000 (UTC)
In-Reply-To: <1429879133-32293-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Originally hda_bus takes its own ops (hda_bus_ops) to allow different
controller drivers giving individual implementations of PCM
attachment, etc.  But this never happened and we finally merged both
codec and controller helper codes.  Thus there is no merit to keep the
indirect accesses to functions via hda_bus_ops.

This patch replaces these calls with the direct local function calls
for simplification.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c      | 12 ++++-------
 sound/pci/hda/hda_codec.h      | 49 +++++++++---------------------------------
 sound/pci/hda/hda_controller.c | 42 +++++++++++++++---------------------
 3 files changed, 31 insertions(+), 72 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index df3cebc06110..2d8883fbde2b 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -150,7 +150,7 @@ static int codec_exec_verb(struct hdac_device *dev, unsigned int cmd,
 		if (bus->response_reset) {
 			codec_dbg(codec,
 				  "resetting BUS due to fatal communication error\n");
-			bus->ops.bus_reset(bus);
+			snd_hda_bus_reset(bus);
 		}
 		goto again;
 	}
@@ -3403,9 +3403,6 @@ int snd_hda_codec_build_pcms(struct hda_codec *codec)
 	struct hda_pcm *cpcm;
 	int dev, err;
 
-	if (snd_BUG_ON(!bus->ops.attach_pcm))
-		return -EINVAL;
-
 	err = snd_hda_codec_parse_pcms(codec);
 	if (err < 0) {
 		snd_hda_codec_reset(codec);
@@ -3423,7 +3420,7 @@ int snd_hda_codec_build_pcms(struct hda_codec *codec)
 		if (dev < 0)
 			continue; /* no fatal error */
 		cpcm->device = dev;
-		err =  bus->ops.attach_pcm(bus, codec, cpcm);
+		err =  snd_hda_attach_pcm_stream(bus, codec, cpcm);
 		if (err < 0) {
 			codec_err(codec,
 				  "cannot attach PCM stream %d for codec #%d\n",
@@ -4093,10 +4090,10 @@ int snd_hda_add_imux_item(struct hda_codec *codec,
 EXPORT_SYMBOL_GPL(snd_hda_add_imux_item);
 
 /**
- * snd_hda_bus_reset - Reset the bus
+ * snd_hda_bus_reset_codecs - Reset the bus
  * @bus: HD-audio bus
  */
-void snd_hda_bus_reset(struct hda_bus *bus)
+void snd_hda_bus_reset_codecs(struct hda_bus *bus)
 {
 	struct hda_codec *codec;
 
@@ -4111,7 +4108,6 @@ void snd_hda_bus_reset(struct hda_bus *bus)
 #endif
 	}
 }
-EXPORT_SYMBOL_GPL(snd_hda_bus_reset);
 
 /**
  * snd_print_pcm_bits - Print the supported PCM fmt bits to the string buffer
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 1ffdd39cb556..0f8b6b5812e6 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -40,26 +40,6 @@ struct hda_codec;
 struct hda_pcm;
 struct hda_pcm_stream;
 
-/* bus operators */
-struct hda_bus_ops {
-	/* attach a PCM stream */
-	int (*attach_pcm)(struct hda_bus *bus, struct hda_codec *codec,
-			  struct hda_pcm *pcm);
-	/* reset bus for retry verb */
-	void (*bus_reset)(struct hda_bus *bus);
-#ifdef CONFIG_SND_HDA_DSP_LOADER
-	/* prepare DSP transfer */
-	int (*load_dsp_prepare)(struct hda_bus *bus, unsigned int format,
-				unsigned int byte_size,
-				struct snd_dma_buffer *bufp);
-	/* start/stop DSP transfer */
-	void (*load_dsp_trigger)(struct hda_bus *bus, bool start);
-	/* clean up DSP transfer */
-	void (*load_dsp_cleanup)(struct hda_bus *bus,
-				 struct snd_dma_buffer *dmab);
-#endif
-};
-
 /*
  * codec bus
  *
@@ -73,7 +53,6 @@ struct hda_bus {
 
 	struct pci_dev *pci;
 	const char *modelname;
-	struct hda_bus_ops ops;
 
 	struct mutex prepare_mutex;
 
@@ -464,6 +443,9 @@ void __snd_hda_codec_cleanup_stream(struct hda_codec *codec, hda_nid_t nid,
 
 extern const struct snd_pcm_chmap_elem snd_pcm_2_1_chmaps[];
 
+int snd_hda_attach_pcm_stream(struct hda_bus *_bus, struct hda_codec *codec,
+			      struct hda_pcm *cpcm);
+
 /*
  * Misc
  */
@@ -474,6 +456,7 @@ void snd_hda_codec_set_power_to_all(struct hda_codec *codec, hda_nid_t fg,
 int snd_hda_lock_devices(struct hda_bus *bus);
 void snd_hda_unlock_devices(struct hda_bus *bus);
 void snd_hda_bus_reset(struct hda_bus *bus);
+void snd_hda_bus_reset_codecs(struct hda_bus *bus);
 
 /*
  * power management
@@ -519,24 +502,12 @@ int snd_hda_load_patch(struct hda_bus *bus, size_t size, const void *buf);
 #endif
 
 #ifdef CONFIG_SND_HDA_DSP_LOADER
-static inline int
-snd_hda_codec_load_dsp_prepare(struct hda_codec *codec, unsigned int format,
-				unsigned int size,
-				struct snd_dma_buffer *bufp)
-{
-	return codec->bus->ops.load_dsp_prepare(codec->bus, format, size, bufp);
-}
-static inline void
-snd_hda_codec_load_dsp_trigger(struct hda_codec *codec, bool start)
-{
-	return codec->bus->ops.load_dsp_trigger(codec->bus, start);
-}
-static inline void
-snd_hda_codec_load_dsp_cleanup(struct hda_codec *codec,
-				struct snd_dma_buffer *dmab)
-{
-	return codec->bus->ops.load_dsp_cleanup(codec->bus, dmab);
-}
+int snd_hda_codec_load_dsp_prepare(struct hda_codec *codec, unsigned int format,
+				   unsigned int size,
+				   struct snd_dma_buffer *bufp);
+void snd_hda_codec_load_dsp_trigger(struct hda_codec *codec, bool start);
+void snd_hda_codec_load_dsp_cleanup(struct hda_codec *codec,
+				    struct snd_dma_buffer *dmab);
 #else
 static inline int
 snd_hda_codec_load_dsp_prepare(struct hda_codec *codec, unsigned int format,
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 0e43f79e1d9b..9bc8eaf0e5ac 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -532,8 +532,8 @@ static void azx_pcm_free(struct snd_pcm *pcm)
 
 #define MAX_PREALLOC_SIZE	(32 * 1024 * 1024)
 
-static int azx_attach_pcm_stream(struct hda_bus *_bus, struct hda_codec *codec,
-				 struct hda_pcm *cpcm)
+int snd_hda_attach_pcm_stream(struct hda_bus *_bus, struct hda_codec *codec,
+			      struct hda_pcm *cpcm)
 {
 	struct hdac_bus *bus = &_bus->core;
 	struct azx *chip = bus_to_azx(bus);
@@ -814,11 +814,11 @@ azx_get_dsp_loader_dev(struct azx *chip)
 	return NULL;
 }
 
-static int azx_load_dsp_prepare(struct hda_bus *_bus, unsigned int format,
-				unsigned int byte_size,
-				struct snd_dma_buffer *bufp)
+int snd_hda_codec_load_dsp_prepare(struct hda_codec *codec, unsigned int format,
+				   unsigned int byte_size,
+				   struct snd_dma_buffer *bufp)
 {
-	struct hdac_bus *bus = &_bus->core;
+	struct hdac_bus *bus = &codec->bus->core;
 	struct azx *chip = bus_to_azx(bus);
 	struct azx_dev *azx_dev;
 	struct hdac_stream *hstr;
@@ -846,25 +846,27 @@ static int azx_load_dsp_prepare(struct hda_bus *_bus, unsigned int format,
 	azx_dev->prepared = 0;
 	return err;
 }
+EXPORT_SYMBOL_GPL(snd_hda_codec_load_dsp_prepare);
 
-static void azx_load_dsp_trigger(struct hda_bus *_bus, bool start)
+void snd_hda_codec_load_dsp_trigger(struct hda_codec *codec, bool start)
 {
-	struct hdac_bus *bus = &_bus->core;
+	struct hdac_bus *bus = &codec->bus->core;
 	struct azx *chip = bus_to_azx(bus);
 	struct azx_dev *azx_dev = azx_get_dsp_loader_dev(chip);
 
 	snd_hdac_dsp_trigger(azx_stream(azx_dev), start);
 }
+EXPORT_SYMBOL_GPL(snd_hda_codec_load_dsp_trigger);
 
-static void azx_load_dsp_cleanup(struct hda_bus *_bus,
-				 struct snd_dma_buffer *dmab)
+void snd_hda_codec_load_dsp_cleanup(struct hda_codec *codec,
+				    struct snd_dma_buffer *dmab)
 {
-	struct hdac_bus *bus = &_bus->core;
+	struct hdac_bus *bus = &codec->bus->core;
 	struct azx *chip = bus_to_azx(bus);
 	struct azx_dev *azx_dev = azx_get_dsp_loader_dev(chip);
 	struct hdac_stream *hstr = azx_stream(azx_dev);
 
-	if (!dmab->area || !azx_dev->core.locked)
+	if (!dmab->area || !hstr->locked)
 		return;
 
 	snd_hdac_dsp_cleanup(hstr, dmab);
@@ -874,6 +876,7 @@ static void azx_load_dsp_cleanup(struct hda_bus *_bus,
 	hstr->locked = false;
 	spin_unlock_irq(&bus->reg_lock);
 }
+EXPORT_SYMBOL_GPL(snd_hda_codec_load_dsp_cleanup);
 #endif /* CONFIG_SND_HDA_DSP_LOADER */
 
 /*
@@ -993,7 +996,7 @@ static int probe_codec(struct azx *chip, int addr)
 	return 0;
 }
 
-static void azx_bus_reset(struct hda_bus *bus)
+void snd_hda_bus_reset(struct hda_bus *bus)
 {
 	struct azx *chip = bus_to_azx(&bus->core);
 
@@ -1001,7 +1004,7 @@ static void azx_bus_reset(struct hda_bus *bus)
 	azx_stop_chip(chip);
 	azx_init_chip(chip, true);
 	if (bus->core.chip_init)
-		snd_hda_bus_reset(bus);
+		snd_hda_bus_reset_codecs(bus);
 	bus->in_reset = 0;
 }
 
@@ -1026,16 +1029,6 @@ static int get_jackpoll_interval(struct azx *chip)
 	return j;
 }
 
-static struct hda_bus_ops bus_ops = {
-	.attach_pcm = azx_attach_pcm_stream,
-	.bus_reset = azx_bus_reset,
-#ifdef CONFIG_SND_HDA_DSP_LOADER
-	.load_dsp_prepare = azx_load_dsp_prepare,
-	.load_dsp_trigger = azx_load_dsp_trigger,
-	.load_dsp_cleanup = azx_load_dsp_cleanup,
-#endif
-};
-
 /* HD-audio bus initialization */
 int azx_bus_init(struct azx *chip, const char *model,
 		 const struct hdac_io_ops *io_ops)
@@ -1052,7 +1045,6 @@ int azx_bus_init(struct azx *chip, const char *model,
 	mutex_init(&bus->prepare_mutex);
 	bus->pci = chip->pci;
 	bus->modelname = model;
-	bus->ops = bus_ops;
 	bus->core.snoop = azx_snoop(chip);
 	if (chip->get_position[0] != azx_get_pos_lpib ||
 	    chip->get_position[1] != azx_get_pos_lpib)
-- 
2.3.5
