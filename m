From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 02/19] ALSA: hda - Allow different ops to
	read/write registers
Date: Thu, 27 Feb 2014 22:35:45 -0800
Message-ID: <1393569362-27285-3-git-send-email-dgreid@chromium.org>
References: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f201.google.com (mail-ie0-f201.google.com
 [209.85.223.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 689B7265099
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 07:37:13 +0100 (CET)
Received: by mail-ie0-f201.google.com with SMTP id at1so710371iec.4
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 22:37:12 -0800 (PST)
In-Reply-To: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, swarren@wwwdotorg.org
List-Id: alsa-devel@alsa-project.org

The forthcoming platform hda driver needs to override the way
registers are read and written.  In preparation for that, introduce a
reg_ops struct that can be implemented differently by the new driver.
Change the existing macros to use the new structure, and move them to
hda_priv.h where they will be accessible to both pci and platform
drivers.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_intel.c | 159 ++++++++++++++++++++++++++--------------------
 sound/pci/hda/hda_priv.h  |  43 +++++++++++++
 2 files changed, 133 insertions(+), 69 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 9451ab3..e0ee3d4 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -293,34 +293,46 @@ static char *driver_short_names[] = {
 	[AZX_DRIVER_GENERIC] = "HD-Audio Generic",
 };
 
-/*
- * macros for easy use
- */
-#define azx_writel(chip,reg,value) \
-	writel(value, (chip)->remap_addr + ICH6_REG_##reg)
-#define azx_readl(chip,reg) \
-	readl((chip)->remap_addr + ICH6_REG_##reg)
-#define azx_writew(chip,reg,value) \
-	writew(value, (chip)->remap_addr + ICH6_REG_##reg)
-#define azx_readw(chip,reg) \
-	readw((chip)->remap_addr + ICH6_REG_##reg)
-#define azx_writeb(chip,reg,value) \
-	writeb(value, (chip)->remap_addr + ICH6_REG_##reg)
-#define azx_readb(chip,reg) \
-	readb((chip)->remap_addr + ICH6_REG_##reg)
-
-#define azx_sd_writel(dev,reg,value) \
-	writel(value, (dev)->sd_addr + ICH6_REG_##reg)
-#define azx_sd_readl(dev,reg) \
-	readl((dev)->sd_addr + ICH6_REG_##reg)
-#define azx_sd_writew(dev,reg,value) \
-	writew(value, (dev)->sd_addr + ICH6_REG_##reg)
-#define azx_sd_readw(dev,reg) \
-	readw((dev)->sd_addr + ICH6_REG_##reg)
-#define azx_sd_writeb(dev,reg,value) \
-	writeb(value, (dev)->sd_addr + ICH6_REG_##reg)
-#define azx_sd_readb(dev,reg) \
-	readb((dev)->sd_addr + ICH6_REG_##reg)
+/* PCI register access. */
+
+static void pci_azx_writel(u32 value, u32 *addr)
+{
+	writel(value, addr);
+}
+
+static u32 pci_azx_readl(u32 *addr)
+{
+	return readl(addr);
+}
+
+static void pci_azx_writew(u16 value, u16 *addr)
+{
+	writew(value, addr);
+}
+
+static u16 pci_azx_readw(u16 *addr)
+{
+	return readw(addr);
+}
+
+static void pci_azx_writeb(u8 value, u8 *addr)
+{
+	writeb(value, addr);
+}
+
+static u8 pci_azx_readb(u8 *addr)
+{
+	return readb(addr);
+}
+
+static const struct azx_reg_ops pci_reg_ops = {
+	.writel = pci_azx_writel,
+	.readl = pci_azx_readl,
+	.writew = pci_azx_writew,
+	.readw = pci_azx_readw,
+	.writeb = pci_azx_writeb,
+	.readb = pci_azx_readb,
+};
 
 /* for pcm support */
 #define get_azx_dev(substream) (substream->runtime->private_data)
@@ -854,8 +866,9 @@ static void azx_int_disable(struct azx *chip)
 	/* disable interrupts in stream descriptor */
 	for (i = 0; i < chip->num_streams; i++) {
 		struct azx_dev *azx_dev = &chip->azx_dev[i];
-		azx_sd_writeb(azx_dev, SD_CTL,
-			      azx_sd_readb(azx_dev, SD_CTL) & ~SD_INT_MASK);
+		azx_sd_writeb(chip, azx_dev, SD_CTL,
+			      azx_sd_readb(chip, azx_dev, SD_CTL) &
+					~SD_INT_MASK);
 	}
 
 	/* disable SIE for all streams */
@@ -874,7 +887,7 @@ static void azx_int_clear(struct azx *chip)
 	/* clear stream status */
 	for (i = 0; i < chip->num_streams; i++) {
 		struct azx_dev *azx_dev = &chip->azx_dev[i];
-		azx_sd_writeb(azx_dev, SD_STS, SD_INT_MASK);
+		azx_sd_writeb(chip, azx_dev, SD_STS, SD_INT_MASK);
 	}
 
 	/* clear STATESTS */
@@ -899,16 +912,18 @@ static void azx_stream_start(struct azx *chip, struct azx_dev *azx_dev)
 	azx_writel(chip, INTCTL,
 		   azx_readl(chip, INTCTL) | (1 << azx_dev->index));
 	/* set DMA start and interrupt mask */
-	azx_sd_writeb(azx_dev, SD_CTL, azx_sd_readb(azx_dev, SD_CTL) |
+	azx_sd_writeb(chip, azx_dev, SD_CTL,
+		      azx_sd_readb(chip, azx_dev, SD_CTL) |
 		      SD_CTL_DMA_START | SD_INT_MASK);
 }
 
 /* stop DMA */
 static void azx_stream_clear(struct azx *chip, struct azx_dev *azx_dev)
 {
-	azx_sd_writeb(azx_dev, SD_CTL, azx_sd_readb(azx_dev, SD_CTL) &
+	azx_sd_writeb(chip, azx_dev, SD_CTL,
+		      azx_sd_readb(chip, azx_dev, SD_CTL) &
 		      ~(SD_CTL_DMA_START | SD_INT_MASK));
-	azx_sd_writeb(azx_dev, SD_STS, SD_INT_MASK); /* to be sure */
+	azx_sd_writeb(chip, azx_dev, SD_STS, SD_INT_MASK); /* to be sure */
 }
 
 /* stop a stream */
@@ -1056,8 +1071,8 @@ static irqreturn_t azx_interrupt(int irq, void *dev_id)
 	for (i = 0; i < chip->num_streams; i++) {
 		azx_dev = &chip->azx_dev[i];
 		if (status & azx_dev->sd_int_sta_mask) {
-			sd_status = azx_sd_readb(azx_dev, SD_STS);
-			azx_sd_writeb(azx_dev, SD_STS, SD_INT_MASK);
+			sd_status = azx_sd_readb(chip, azx_dev, SD_STS);
+			azx_sd_writeb(chip, azx_dev, SD_STS, SD_INT_MASK);
 			if (!azx_dev->substream || !azx_dev->running ||
 			    !(sd_status & SD_INT_COMPLETE))
 				continue;
@@ -1154,8 +1169,8 @@ static int azx_setup_periods(struct azx *chip,
 	int pos_adj;
 
 	/* reset BDL address */
-	azx_sd_writel(azx_dev, SD_BDLPL, 0);
-	azx_sd_writel(azx_dev, SD_BDLPU, 0);
+	azx_sd_writel(chip, azx_dev, SD_BDLPL, 0);
+	azx_sd_writel(chip, azx_dev, SD_BDLPU, 0);
 
 	period_bytes = azx_dev->period_bytes;
 	periods = azx_dev->bufsize / period_bytes;
@@ -1217,21 +1232,22 @@ static void azx_stream_reset(struct azx *chip, struct azx_dev *azx_dev)
 
 	azx_stream_clear(chip, azx_dev);
 
-	azx_sd_writeb(azx_dev, SD_CTL, azx_sd_readb(azx_dev, SD_CTL) |
+	azx_sd_writeb(chip, azx_dev, SD_CTL,
+		      azx_sd_readb(chip, azx_dev, SD_CTL) |
 		      SD_CTL_STREAM_RESET);
 	udelay(3);
 	timeout = 300;
-	while (!((val = azx_sd_readb(azx_dev, SD_CTL)) & SD_CTL_STREAM_RESET) &&
-	       --timeout)
+	while (!((val = azx_sd_readb(chip, azx_dev, SD_CTL)) &
+		 SD_CTL_STREAM_RESET) && --timeout)
 		;
 	val &= ~SD_CTL_STREAM_RESET;
-	azx_sd_writeb(azx_dev, SD_CTL, val);
+	azx_sd_writeb(chip, azx_dev, SD_CTL, val);
 	udelay(3);
 
 	timeout = 300;
 	/* waiting for hardware to report that the stream is out of reset */
-	while (((val = azx_sd_readb(azx_dev, SD_CTL)) & SD_CTL_STREAM_RESET) &&
-	       --timeout)
+	while (((val = azx_sd_readb(chip, azx_dev, SD_CTL)) &
+		SD_CTL_STREAM_RESET) && --timeout)
 		;
 
 	/* reset first position - may not be synced with hw at this time */
@@ -1247,28 +1263,29 @@ static int azx_setup_controller(struct azx *chip, struct azx_dev *azx_dev)
 	/* make sure the run bit is zero for SD */
 	azx_stream_clear(chip, azx_dev);
 	/* program the stream_tag */
-	val = azx_sd_readl(azx_dev, SD_CTL);
+	val = azx_sd_readl(chip, azx_dev, SD_CTL);
 	val = (val & ~SD_CTL_STREAM_TAG_MASK) |
 		(azx_dev->stream_tag << SD_CTL_STREAM_TAG_SHIFT);
 	if (!azx_snoop(chip))
 		val |= SD_CTL_TRAFFIC_PRIO;
-	azx_sd_writel(azx_dev, SD_CTL, val);
+	azx_sd_writel(chip, azx_dev, SD_CTL, val);
 
 	/* program the length of samples in cyclic buffer */
-	azx_sd_writel(azx_dev, SD_CBL, azx_dev->bufsize);
+	azx_sd_writel(chip, azx_dev, SD_CBL, azx_dev->bufsize);
 
 	/* program the stream format */
 	/* this value needs to be the same as the one programmed */
-	azx_sd_writew(azx_dev, SD_FORMAT, azx_dev->format_val);
+	azx_sd_writew(chip, azx_dev, SD_FORMAT, azx_dev->format_val);
 
 	/* program the stream LVI (last valid index) of the BDL */
-	azx_sd_writew(azx_dev, SD_LVI, azx_dev->frags - 1);
+	azx_sd_writew(chip, azx_dev, SD_LVI, azx_dev->frags - 1);
 
 	/* program the BDL address */
 	/* lower BDL address */
-	azx_sd_writel(azx_dev, SD_BDLPL, (u32)azx_dev->bdl.addr);
+	azx_sd_writel(chip, azx_dev, SD_BDLPL, (u32)azx_dev->bdl.addr);
 	/* upper BDL address */
-	azx_sd_writel(azx_dev, SD_BDLPU, upper_32_bits(azx_dev->bdl.addr));
+	azx_sd_writel(chip, azx_dev, SD_BDLPU,
+		      upper_32_bits(azx_dev->bdl.addr));
 
 	/* enable the position buffer */
 	if (chip->position_fix[0] != POS_FIX_LPIB ||
@@ -1279,8 +1296,8 @@ static int azx_setup_controller(struct azx *chip, struct azx_dev *azx_dev)
 	}
 
 	/* set the interrupt enable bits in the descriptor control register */
-	azx_sd_writel(azx_dev, SD_CTL,
-		      azx_sd_readl(azx_dev, SD_CTL) | SD_INT_MASK);
+	azx_sd_writel(chip, azx_dev, SD_CTL,
+		      azx_sd_readl(chip, azx_dev, SD_CTL) | SD_INT_MASK);
 
 	return 0;
 }
@@ -1754,9 +1771,9 @@ static int azx_pcm_hw_free(struct snd_pcm_substream *substream)
 	/* reset BDL address */
 	dsp_lock(azx_dev);
 	if (!dsp_is_locked(azx_dev)) {
-		azx_sd_writel(azx_dev, SD_BDLPL, 0);
-		azx_sd_writel(azx_dev, SD_BDLPU, 0);
-		azx_sd_writel(azx_dev, SD_CTL, 0);
+		azx_sd_writel(chip, azx_dev, SD_BDLPL, 0);
+		azx_sd_writel(chip, azx_dev, SD_BDLPU, 0);
+		azx_sd_writel(chip, azx_dev, SD_CTL, 0);
 		azx_dev->bufsize = 0;
 		azx_dev->period_bytes = 0;
 		azx_dev->format_val = 0;
@@ -1836,7 +1853,8 @@ static int azx_pcm_prepare(struct snd_pcm_substream *substream)
 						runtime->rate) * 1000);
 	azx_setup_controller(chip, azx_dev);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		azx_dev->fifo_size = azx_sd_readw(azx_dev, SD_FIFOSIZE) + 1;
+		azx_dev->fifo_size =
+			azx_sd_readw(chip, azx_dev, SD_FIFOSIZE) + 1;
 	else
 		azx_dev->fifo_size = 0;
 
@@ -1928,7 +1946,7 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 				if (s->pcm->card != substream->pcm->card)
 					continue;
 				azx_dev = get_azx_dev(s);
-				if (!(azx_sd_readb(azx_dev, SD_STS) &
+				if (!(azx_sd_readb(chip, azx_dev, SD_STS) &
 				      SD_STS_FIFO_READY))
 					nwait++;
 			}
@@ -1944,7 +1962,7 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 				if (s->pcm->card != substream->pcm->card)
 					continue;
 				azx_dev = get_azx_dev(s);
-				if (azx_sd_readb(azx_dev, SD_CTL) &
+				if (azx_sd_readb(chip, azx_dev, SD_CTL) &
 				    SD_CTL_DMA_START)
 					nwait++;
 			}
@@ -1988,7 +2006,7 @@ static unsigned int azx_via_get_position(struct azx *chip,
 	unsigned int mod_link_pos, mod_dma_pos, mod_mini_pos;
 	unsigned int fifo_size;
 
-	link_pos = azx_sd_readl(azx_dev, SD_LPIB);
+	link_pos = azx_sd_readl(chip, azx_dev, SD_LPIB);
 	if (azx_dev->substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		/* Playback, no problem using link position */
 		return link_pos;
@@ -2050,7 +2068,7 @@ static unsigned int azx_get_position(struct azx *chip,
 	switch (chip->position_fix[stream]) {
 	case POS_FIX_LPIB:
 		/* read LPIB */
-		pos = azx_sd_readl(azx_dev, SD_LPIB);
+		pos = azx_sd_readl(chip, azx_dev, SD_LPIB);
 		break;
 	case POS_FIX_VIACOMBO:
 		pos = azx_via_get_position(chip, azx_dev);
@@ -2063,7 +2081,7 @@ static unsigned int azx_get_position(struct azx *chip,
 				dev_info(chip->card->dev,
 					 "Invalid position buffer, using LPIB read method instead.\n");
 				chip->position_fix[stream] = POS_FIX_LPIB;
-				pos = azx_sd_readl(azx_dev, SD_LPIB);
+				pos = azx_sd_readl(chip, azx_dev, SD_LPIB);
 			} else
 				chip->position_fix[stream] = POS_FIX_POSBUF;
 		}
@@ -2077,7 +2095,7 @@ static unsigned int azx_get_position(struct azx *chip,
 	if (substream->runtime &&
 	    chip->position_fix[stream] == POS_FIX_POSBUF &&
 	    (chip->driver_caps & AZX_DCAPS_COUNT_LPIB_DELAY)) {
-		unsigned int lpib_pos = azx_sd_readl(azx_dev, SD_LPIB);
+		unsigned int lpib_pos = azx_sd_readl(chip, azx_dev, SD_LPIB);
 		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 			delay = pos - lpib_pos;
 		else
@@ -2416,8 +2434,8 @@ static int azx_load_dsp_prepare(struct hda_bus *bus, unsigned int format,
 	azx_stream_reset(chip, azx_dev);
 
 	/* reset BDL address */
-	azx_sd_writel(azx_dev, SD_BDLPL, 0);
-	azx_sd_writel(azx_dev, SD_BDLPU, 0);
+	azx_sd_writel(chip, azx_dev, SD_BDLPL, 0);
+	azx_sd_writel(chip, azx_dev, SD_BDLPU, 0);
 
 	azx_dev->frags = 0;
 	bdl = (u32 *)azx_dev->bdl.area;
@@ -2466,9 +2484,9 @@ static void azx_load_dsp_cleanup(struct hda_bus *bus,
 
 	dsp_lock(azx_dev);
 	/* reset BDL address */
-	azx_sd_writel(azx_dev, SD_BDLPL, 0);
-	azx_sd_writel(azx_dev, SD_BDLPU, 0);
-	azx_sd_writel(azx_dev, SD_CTL, 0);
+	azx_sd_writel(chip, azx_dev, SD_BDLPL, 0);
+	azx_sd_writel(chip, azx_dev, SD_BDLPU, 0);
+	azx_sd_writel(chip, azx_dev, SD_CTL, 0);
 	azx_dev->bufsize = 0;
 	azx_dev->period_bytes = 0;
 	azx_dev->format_val = 0;
@@ -3145,6 +3163,7 @@ static void azx_probe_work(struct work_struct *work)
  */
 static int azx_create(struct snd_card *card, struct pci_dev *pci,
 		      int dev, unsigned int driver_caps,
+		      const struct azx_reg_ops *reg_ops,
 		      struct azx **rchip)
 {
 	static struct snd_device_ops ops = {
@@ -3170,6 +3189,7 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 	mutex_init(&chip->open_mutex);
 	chip->card = card;
 	chip->pci = pci;
+	chip->reg_ops = reg_ops;
 	chip->irq = -1;
 	chip->driver_caps = driver_caps;
 	chip->driver_type = driver_caps & 0xff;
@@ -3451,7 +3471,8 @@ static int azx_probe(struct pci_dev *pci,
 		return err;
 	}
 
-	err = azx_create(card, pci, dev, pci_id->driver_data, &chip);
+	err = azx_create(card, pci, dev, pci_id->driver_data,
+			 &pci_reg_ops, &chip);
 	if (err < 0)
 		goto out_free;
 	card->private_data = chip;
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index 7656494..5a21985 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -285,6 +285,16 @@ struct azx_rb {
 	u32 res[AZX_MAX_CODECS];	/* last read value */
 };
 
+/* Functions to read/write to hda registers. */
+struct azx_reg_ops {
+	void (*writel)(u32 value, u32 *addr);
+	u32 (*readl)(u32 *addr);
+	void (*writew)(u16 value, u16 *addr);
+	u16 (*readw)(u16 *addr);
+	void (*writeb)(u8 value, u8 *addr);
+	u8 (*readb)(u8 *addr);
+};
+
 struct azx_pcm {
 	struct azx *chip;
 	struct snd_pcm *pcm;
@@ -307,6 +317,9 @@ struct azx {
 	int capture_index_offset;
 	int num_streams;
 
+	/* Register interaction. */
+	const struct azx_reg_ops *reg_ops;
+
 	/* pci resources */
 	unsigned long addr;
 	void __iomem *remap_addr;
@@ -395,4 +408,34 @@ struct azx {
 #define azx_snoop(chip)		true
 #endif
 
+/*
+ * macros for easy use
+ */
+
+#define azx_writel(chip, reg, value) \
+	((chip)->reg_ops->writel(value, (chip)->remap_addr + ICH6_REG_##reg))
+#define azx_readl(chip, reg) \
+	((chip)->reg_ops->readl((chip)->remap_addr + ICH6_REG_##reg))
+#define azx_writew(chip, reg, value) \
+	((chip)->reg_ops->writew(value, (chip)->remap_addr + ICH6_REG_##reg))
+#define azx_readw(chip, reg) \
+	((chip)->reg_ops->readw((chip)->remap_addr + ICH6_REG_##reg))
+#define azx_writeb(chip, reg, value) \
+	((chip)->reg_ops->writeb(value, (chip)->remap_addr + ICH6_REG_##reg))
+#define azx_readb(chip, reg) \
+	((chip)->reg_ops->readb((chip)->remap_addr + ICH6_REG_##reg))
+
+#define azx_sd_writel(chip, dev, reg, value) \
+	((chip)->reg_ops->writel(value, (dev)->sd_addr + ICH6_REG_##reg))
+#define azx_sd_readl(chip, dev, reg) \
+	((chip)->reg_ops->readl((dev)->sd_addr + ICH6_REG_##reg))
+#define azx_sd_writew(chip, dev, reg, value) \
+	((chip)->reg_ops->writew(value, (dev)->sd_addr + ICH6_REG_##reg))
+#define azx_sd_readw(chip, dev, reg) \
+	((chip)->reg_ops->readw((dev)->sd_addr + ICH6_REG_##reg))
+#define azx_sd_writeb(chip, dev, reg, value) \
+	((chip)->reg_ops->writeb(value, (dev)->sd_addr + ICH6_REG_##reg))
+#define azx_sd_readb(chip, dev, reg) \
+	((chip)->reg_ops->readb((dev)->sd_addr + ICH6_REG_##reg))
+
 #endif /* __SOUND_HDA_PRIV_H */
-- 
1.8.1.3.605.g02339dd
