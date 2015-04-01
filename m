From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 3/5] ALSA: hda - Add the controller helper
	codes to
Date: Wed,  1 Apr 2015 17:01:00 +0530
Message-ID: <1427887862-29054-4-git-send-email-vinod.koul@intel.com>
References: <1427887862-29054-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 6715C26518B
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 13:35:35 +0200 (CEST)
In-Reply-To: <1427887862-29054-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Takashi Iwai <tiwai@suse.de>

This is picked from Takashi's unstable tree and rebased on top of other
changes done

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hda_registers.h |   41 ++--
 include/sound/hdaudio.h       |  151 ++++++++++++-
 sound/hda/Makefile            |    3 +-
 sound/hda/hdac_bus.c          |   13 +-
 sound/hda/hdac_controller.c   |  401 ++++++++++++++++++++++++++++++++++
 sound/hda/hdac_stream.c       |  473 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 1063 insertions(+), 19 deletions(-)
 create mode 100644 sound/hda/hdac_controller.c
 create mode 100644 sound/hda/hdac_stream.c

diff --git a/include/sound/hda_registers.h b/include/sound/hda_registers.h
index 6afb26191f4d..9852a8c562b4 100644
--- a/include/sound/hda_registers.h
+++ b/include/sound/hda_registers.h
@@ -135,32 +135,41 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 /*
  * macros for easy use
  */
+#define _azx_write(type, chip, reg, value)				\
+	((chip)->ops->reg_write ## type(value, (chip)->remap_addr + (reg)))
+#define _azx_read(type, chip, reg)					\
+	((chip)->ops->reg_read ## type((chip)->remap_addr + (reg)))
 
 #define azx_writel(chip, reg, value) \
-	((chip)->ops->reg_writel(value, (chip)->remap_addr + AZX_REG_##reg))
-#define azx_readl(chip, reg) \
-	((chip)->ops->reg_readl((chip)->remap_addr + AZX_REG_##reg))
+	_azx_write(l, chip, AZX_REG_ ## reg, value)
 #define azx_writew(chip, reg, value) \
-	((chip)->ops->reg_writew(value, (chip)->remap_addr + AZX_REG_##reg))
-#define azx_readw(chip, reg) \
-	((chip)->ops->reg_readw((chip)->remap_addr + AZX_REG_##reg))
+	_azx_write(w, chip, AZX_REG_ ## reg, value)
 #define azx_writeb(chip, reg, value) \
-	((chip)->ops->reg_writeb(value, (chip)->remap_addr + AZX_REG_##reg))
+	_azx_write(b, chip, AZX_REG_ ## reg, value)
+#define azx_readl(chip, reg) \
+	_azx_read(l, chip, AZX_REG_ ## reg)
+#define azx_readw(chip, reg) \
+	_azx_read(w, chip, AZX_REG_ ## reg)
 #define azx_readb(chip, reg) \
-	((chip)->ops->reg_readb((chip)->remap_addr + AZX_REG_##reg))
+	_azx_read(b, chip, AZX_REG_ ## reg)
+
+#define _azx_sd_write(type, chip, dev, reg, value)			\
+	((chip)->ops->reg_write ## type(value, (dev)->sd_addr + (reg)))
+#define _azx_sd_read(type, chip, dev, reg)				\
+	((chip)->ops->reg_read ## type((dev)->sd_addr + (reg)))
 
 #define azx_sd_writel(chip, dev, reg, value) \
-	((chip)->ops->reg_writel(value, (dev)->sd_addr + AZX_REG_##reg))
-#define azx_sd_readl(chip, dev, reg) \
-	((chip)->ops->reg_readl((dev)->sd_addr + AZX_REG_##reg))
+	_azx_sd_write(l, chip, dev, AZX_REG_ ## reg, value)
 #define azx_sd_writew(chip, dev, reg, value) \
-	((chip)->ops->reg_writew(value, (dev)->sd_addr + AZX_REG_##reg))
-#define azx_sd_readw(chip, dev, reg) \
-	((chip)->ops->reg_readw((dev)->sd_addr + AZX_REG_##reg))
+	_azx_sd_write(w, chip, dev, AZX_REG_ ## reg, value)
 #define azx_sd_writeb(chip, dev, reg, value) \
-	((chip)->ops->reg_writeb(value, (dev)->sd_addr + AZX_REG_##reg))
+	_azx_sd_write(b, chip, dev, AZX_REG_ ## reg, value)
+#define azx_sd_readl(chip, dev, reg) \
+	_azx_sd_read(l, chip, dev, AZX_REG_ ## reg)
+#define azx_sd_readw(chip, dev, reg) \
+	_azx_sd_read(w, chip, dev, AZX_REG_ ## reg)
 #define azx_sd_readb(chip, dev, reg) \
-	((chip)->ops->reg_readb((dev)->sd_addr + AZX_REG_##reg))
+	_azx_sd_read(b, chip, dev, AZX_REG_ ## reg)
 
 #define azx_has_pm_runtime(chip) \
 	(!AZX_DCAPS_PM_RUNTIME || ((chip)->driver_caps & AZX_DCAPS_PM_RUNTIME))
diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index c67dbd3d8afa..647d5ef44222 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -6,7 +6,12 @@
 #define __SOUND_HDAUDIO_H
 
 #include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/timecounter.h>
+#include <sound/core.h>
+#include <sound/memalloc.h>
 #include <sound/hda_verbs.h>
+#include <sound/hda_registers.h>
 
 #define HDA_MAX_CODECS		8
 
@@ -14,6 +19,7 @@
 typedef u16 hda_nid_t;
 
 struct hdac_bus;
+struct hdac_stream;
 struct hdac_device;
 struct hdac_driver;
 struct hdac_widget_tree;
@@ -127,14 +133,40 @@ struct hdac_bus_ops {
 	/* get a response from the last command */
 	int (*get_response)(struct hdac_bus *bus, unsigned int addr,
 			    unsigned int *res);
+	/* mapped register accesses */
+	void (*reg_writel)(u32 value, u32 __iomem *addr);
+	u32 (*reg_readl)(u32 __iomem *addr);
+	void (*reg_writew)(u16 value, u16 __iomem *addr);
+	u16 (*reg_readw)(u16 __iomem *addr);
+	void (*reg_writeb)(u8 value, u8 __iomem *addr);
+	u8 (*reg_readb)(u8 __iomem *addr);
 };
 
 #define HDA_UNSOL_QUEUE_SIZE	64
+#define HDA_MAX_CODECS		8
+
+/*
+ * CORB/RIRB
+ *
+ * Each CORB entry is 4byte, RIRB is 8byte
+ */
+struct hda_rb {
+	u32 *buf;		/* virtual address of CORB/RIRB buffer */
+	dma_addr_t addr;	/* physical address of CORB/RIRB buffer */
+	unsigned short rp, wp;	/* RIRB read/write pointers */
+	int cmds[HDA_MAX_CODECS];	/* number of pending requests */
+	u32 res[HDA_MAX_CODECS];	/* last read value */
+};
 
 struct hdac_bus {
 	struct device *dev;
 	const struct hdac_bus_ops *ops;
 
+	/* h/w resources */
+	unsigned long addr;
+	void __iomem *remap_addr;
+	int irq;
+
 	/* codec linked list */
 	struct list_head codec_list;
 	unsigned int num_codecs;
@@ -147,13 +179,39 @@ struct hdac_bus {
 	unsigned int unsol_rp, unsol_wp;
 	struct work_struct unsol_work;
 
+	/* bit flags of detected codecs */
+	unsigned long codec_mask;
+
 	/* bit flags of powered codecs */
 	unsigned long codec_powered;
 
-	/* flags */
+	/* CORB/RIRB */
+	struct hda_rb corb;
+	struct hda_rb rirb;
+	unsigned int last_cmd[HDA_MAX_CODECS];	/* last sent command */
+
+	/* CORB/RIRB and position buffers */
+	struct snd_dma_buffer rb;
+	struct snd_dma_buffer posbuf;
+
+	/* hdac_stream linked list */
+	struct list_head stream_list;
+
+	/* operation state */
+	bool chip_init:1;		/* h/w initialized */
+
+	/* behavior flags */
 	bool sync_write:1;		/* sync after verb write */
+	bool use_posbuf:1;		/* use position buffer */
+	bool snoop:1;			/* enable snooping */
+	bool align_bdle_4k:1;		/* BDLE align 4K boundary */
+	bool reverse_assign:1;		/* assign devices in reverse order */
+	bool corbrp_self_clear:1;	/* CORBRP clears itself after reset */
+
+	int bdl_pos_adj;		/* BDL position adjustment */
 
 	/* locks */
+	spinlock_t reg_lock;
 	struct mutex cmd_mutex;
 };
 
@@ -180,4 +238,95 @@ static inline void snd_hdac_codec_link_down(struct hdac_device *codec)
 	clear_bit(codec->addr, &codec->bus->codec_powered);
 }
 
+int snd_hdac_bus_send_cmd(struct hdac_bus *bus, unsigned int val);
+int snd_hdac_bus_get_response(struct hdac_bus *bus, unsigned int addr,
+			      unsigned int *res);
+
+void snd_hdac_bus_init_chip(struct hdac_bus *bus, bool full_reset);
+void snd_hdac_bus_stop_chip(struct hdac_bus *bus);
+
+void snd_hdac_bus_update_rirb(struct hdac_bus *bus);
+void snd_hdac_bus_handle_stream_irq(struct hdac_bus *bus, unsigned int status,
+				    void (*ack)(struct hdac_bus *,
+						struct hdac_stream *));
+
+/*
+ * HD-audio stream
+ */
+
+struct hdac_stream {
+	struct hdac_bus *bus;
+	struct snd_dma_buffer bdl; /* BDL buffer */
+	u32 *posbuf;		/* position buffer pointer */
+	int direction;		/* playback / capture (SNDRV_PCM_STREAM_*) */
+
+	unsigned int bufsize;	/* size of the play buffer in bytes */
+	unsigned int period_bytes; /* size of the period in bytes */
+	unsigned int frags;	/* number for period in the play buffer */
+	unsigned int fifo_size;	/* FIFO size */
+
+	void __iomem *sd_addr;	/* stream descriptor pointer */
+
+	u32 sd_int_sta_mask;	/* stream int status mask */
+
+	/* pcm support */
+	struct snd_pcm_substream *substream;	/* assigned substream,
+						 * set in PCM open
+						 */
+	unsigned int format_val;	/* format value to be set in the
+					 * controller and the codec
+					 */
+	unsigned char stream_tag;	/* assigned stream */
+	unsigned char index;		/* stream index */
+	int assigned_key;		/* last device# key assigned to */
+
+	unsigned int opened:1;
+	unsigned int running:1;
+	unsigned int no_period_wakeup:1;
+
+	/* timestamp */
+	unsigned long start_wallclk;	/* start + minimum wallclk */
+	unsigned long period_wallclk;	/* wallclk for period */
+	struct timecounter  tc;
+	struct cyclecounter cc;
+	int delay_negative_threshold;
+
+	struct list_head list;
+};
+
+void snd_hdac_bus_stream_init(struct hdac_bus *bus, struct hdac_stream *azx_dev,
+			      int idx, int direction, int tag);
+struct hdac_stream *snd_hdac_stream_assign(struct hdac_bus *bus,
+					   struct snd_pcm_substream *substream);
+void snd_hdac_stream_release(struct hdac_stream *azx_dev);
+
+int snd_hdac_stream_setup(struct hdac_stream *azx_dev);
+void snd_hdac_stream_cleanup(struct hdac_stream *azx_dev);
+int snd_hdac_stream_setup_periods(struct hdac_stream *azx_dev);
+void snd_hdac_stream_start(struct hdac_stream *azx_dev, bool fresh_start);
+void snd_hdac_stream_clear(struct hdac_stream *azx_dev);
+void snd_hdac_stream_stop(struct hdac_stream *azx_dev);
+void snd_hdac_stream_reset(struct hdac_stream *azx_dev);
+void snd_hdac_stream_sync_trigger(struct hdac_stream *azx_dev, bool set,
+				  unsigned int streams, unsigned int reg);
+void snd_hdac_stream_sync(struct hdac_stream *azx_dev, bool start,
+			  unsigned int streams);
+void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
+				      unsigned int streams);
+
+/*
+ * helpers to read the stream position
+ */
+static inline unsigned int
+snd_hdac_bus_get_pos_lpib(struct hdac_bus *bus, struct hdac_stream *stream)
+{
+	return azx_sd_readl(bus, stream, SD_LPIB);
+}
+
+static inline unsigned int
+snd_hdac_bus_get_pos_posbuf(struct hdac_bus *bus, struct hdac_stream *stream)
+{
+	return le32_to_cpu(*stream->posbuf);
+}
+
 #endif /* __SOUND_HDAUDIO_H */
diff --git a/sound/hda/Makefile b/sound/hda/Makefile
index eec5da03b41f..25af39f330ef 100644
--- a/sound/hda/Makefile
+++ b/sound/hda/Makefile
@@ -1,4 +1,5 @@
-snd-hda-core-objs := hda_bus_type.o hdac_bus.o hdac_device.o hdac_sysfs.o
+snd-hda-core-objs := hda_bus_type.o hdac_bus.o hdac_device.o hdac_sysfs.o \
+	hdac_controller.o hdac_stream.o
 
 snd-hda-core-objs += trace.o
 CFLAGS_trace.o := -I$(src)
diff --git a/sound/hda/hdac_bus.c b/sound/hda/hdac_bus.c
index 8e262da74f6a..3294fd465ca2 100644
--- a/sound/hda/hdac_bus.c
+++ b/sound/hda/hdac_bus.c
@@ -11,6 +11,11 @@
 
 static void process_unsol_events(struct work_struct *work);
 
+static const struct hdac_bus_ops default_ops = {
+	.command = snd_hdac_bus_send_cmd,
+	.get_response = snd_hdac_bus_get_response,
+};
+
 /**
  * snd_hdac_bus_init - initialize a HD-audio bas bus
  * @bus: the pointer to bus object
@@ -22,9 +27,14 @@ int snd_hdac_bus_init(struct hdac_bus *bus, struct device *dev,
 {
 	memset(bus, 0, sizeof(*bus));
 	bus->dev = dev;
-	bus->ops = ops;
+	if (ops)
+		bus->ops = ops;
+	else
+		bus->ops = &default_ops;
+	INIT_LIST_HEAD(&bus->stream_list);
 	INIT_LIST_HEAD(&bus->codec_list);
 	INIT_WORK(&bus->unsol_work, process_unsol_events);
+	spin_lock_init(&bus->reg_lock);
 	mutex_init(&bus->cmd_mutex);
 	return 0;
 }
@@ -36,6 +46,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_bus_init);
  */
 void snd_hdac_bus_exit(struct hdac_bus *bus)
 {
+	WARN_ON(!list_empty(&bus->stream_list));
 	WARN_ON(!list_empty(&bus->codec_list));
 	cancel_work_sync(&bus->unsol_work);
 }
diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
new file mode 100644
index 000000000000..5b1cd945b48c
--- /dev/null
+++ b/sound/hda/hdac_controller.c
@@ -0,0 +1,401 @@
+/*
+ * HD-audio controller helpers
+ */
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/export.h>
+#include <sound/core.h>
+#include <sound/hdaudio.h>
+#include <sound/hda_registers.h>
+
+/* clear CORB read pointer properly */
+static void azx_clear_corbrp(struct hdac_bus *bus)
+{
+	int timeout;
+
+	for (timeout = 1000; timeout > 0; timeout--) {
+		if ((azx_readw(bus, CORBRP) & AZX_CORBRP_RST) == AZX_CORBRP_RST)
+			break;
+		udelay(1);
+	}
+	if (timeout <= 0)
+		dev_err(bus->dev, "CORB reset timeout#1, CORBRP = %d\n",
+			azx_readw(bus, CORBRP));
+
+	azx_writew(bus, CORBRP, 0);
+	for (timeout = 1000; timeout > 0; timeout--) {
+		if (azx_readw(bus, CORBRP) == 0)
+			break;
+		udelay(1);
+	}
+	if (timeout <= 0)
+		dev_err(bus->dev, "CORB reset timeout#2, CORBRP = %d\n",
+			azx_readw(bus, CORBRP));
+}
+
+static void azx_init_cmd_io(struct hdac_bus *bus)
+{
+	spin_lock_irq(&bus->reg_lock);
+	/* CORB set up */
+	bus->corb.addr = bus->rb.addr;
+	bus->corb.buf = (u32 *)bus->rb.area;
+	azx_writel(bus, CORBLBASE, (u32)bus->corb.addr);
+	azx_writel(bus, CORBUBASE, upper_32_bits(bus->corb.addr));
+
+	/* set the corb size to 256 entries (ULI requires explicitly) */
+	azx_writeb(bus, CORBSIZE, 0x02);
+	/* set the corb write pointer to 0 */
+	azx_writew(bus, CORBWP, 0);
+
+	/* reset the corb hw read pointer */
+	azx_writew(bus, CORBRP, AZX_CORBRP_RST);
+	if (!bus->corbrp_self_clear)
+		azx_clear_corbrp(bus);
+
+	/* enable corb dma */
+	azx_writeb(bus, CORBCTL, AZX_CORBCTL_RUN);
+
+	/* RIRB set up */
+	bus->rirb.addr = bus->rb.addr + 2048;
+	bus->rirb.buf = (u32 *)(bus->rb.area + 2048);
+	bus->rirb.wp = bus->rirb.rp = 0;
+	memset(bus->rirb.cmds, 0, sizeof(bus->rirb.cmds));
+	azx_writel(bus, RIRBLBASE, (u32)bus->rirb.addr);
+	azx_writel(bus, RIRBUBASE, upper_32_bits(bus->rirb.addr));
+
+	/* set the rirb size to 256 entries (ULI requires explicitly) */
+	azx_writeb(bus, RIRBSIZE, 0x02);
+	/* reset the rirb hw write pointer */
+	azx_writew(bus, RIRBWP, AZX_RIRBWP_RST);
+	/* set N=1, get RIRB response interrupt for new entry */
+	azx_writew(bus, RINTCNT, 1);
+	/* enable rirb dma and response irq */
+	azx_writeb(bus, RIRBCTL, AZX_RBCTL_DMA_EN | AZX_RBCTL_IRQ_EN);
+	spin_unlock_irq(&bus->reg_lock);
+}
+
+static void azx_free_cmd_io(struct hdac_bus *bus)
+{
+	spin_lock_irq(&bus->reg_lock);
+	/* disable ringbuffer DMAs */
+	azx_writeb(bus, RIRBCTL, 0);
+	azx_writeb(bus, CORBCTL, 0);
+	spin_unlock_irq(&bus->reg_lock);
+}
+
+static unsigned int azx_command_addr(u32 cmd)
+{
+	unsigned int addr = cmd >> 28;
+
+	if (snd_BUG_ON(addr >= HDA_MAX_CODECS))
+		addr = 0;
+	return addr;
+}
+
+/* send a command */
+int snd_hdac_bus_send_cmd(struct hdac_bus *bus, unsigned int val)
+{
+	unsigned int addr = azx_command_addr(val);
+	unsigned int wp, rp;
+
+	spin_lock_irq(&bus->reg_lock);
+
+	bus->last_cmd[azx_command_addr(val)] = val;
+
+	/* add command to corb */
+	wp = azx_readw(bus, CORBWP);
+	if (wp == 0xffff) {
+		/* something wrong, controller likely turned to D3 */
+		spin_unlock_irq(&bus->reg_lock);
+		return -EIO;
+	}
+	wp++;
+	wp %= AZX_MAX_CORB_ENTRIES;
+
+	rp = azx_readw(bus, CORBRP);
+	if (wp == rp) {
+		/* oops, it's full */
+		spin_unlock_irq(&bus->reg_lock);
+		return -EAGAIN;
+	}
+
+	bus->rirb.cmds[addr]++;
+	bus->corb.buf[wp] = cpu_to_le32(val);
+	azx_writew(bus, CORBWP, wp);
+
+	spin_unlock_irq(&bus->reg_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_bus_send_cmd);
+
+#define AZX_RIRB_EX_UNSOL_EV	(1<<4)
+
+/* retrieve RIRB entry - called from interrupt handler */
+void snd_hdac_bus_update_rirb(struct hdac_bus *bus)
+{
+	unsigned int rp, wp;
+	unsigned int addr;
+	u32 res, res_ex;
+
+	wp = azx_readw(bus, RIRBWP);
+	if (wp == 0xffff) {
+		/* something wrong, controller likely turned to D3 */
+		return;
+	}
+
+	if (wp == bus->rirb.wp)
+		return;
+	bus->rirb.wp = wp;
+
+	while (bus->rirb.rp != wp) {
+		bus->rirb.rp++;
+		bus->rirb.rp %= AZX_MAX_RIRB_ENTRIES;
+
+		rp = bus->rirb.rp << 1; /* an RIRB entry is 8-bytes */
+		res_ex = le32_to_cpu(bus->rirb.buf[rp + 1]);
+		res = le32_to_cpu(bus->rirb.buf[rp]);
+		addr = res_ex & 0xf;
+		if (addr >= HDA_MAX_CODECS) {
+			dev_err(bus->dev,
+				"spurious response %#x:%#x, rp = %d, wp = %d",
+				res, res_ex, bus->rirb.rp, wp);
+			snd_BUG();
+		} else if (res_ex & AZX_RIRB_EX_UNSOL_EV)
+			snd_hdac_bus_queue_event(bus, res, res_ex);
+		else if (bus->rirb.cmds[addr]) {
+			bus->rirb.res[addr] = res;
+			bus->rirb.cmds[addr]--;
+		} else {
+			dev_err_ratelimited(bus->dev,
+				"spurious response %#x:%#x, last cmd=%#08x\n",
+				res, res_ex, bus->last_cmd[addr]);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(snd_hdac_bus_update_rirb);
+
+/* receive a response */
+int snd_hdac_bus_get_response(struct hdac_bus *bus, unsigned int addr,
+			      unsigned int *res)
+{
+	unsigned long timeout;
+	unsigned long loopcounter;
+
+	timeout = jiffies + msecs_to_jiffies(1000);
+
+	for (loopcounter = 0;; loopcounter++) {
+		spin_lock_irq(&bus->reg_lock);
+		if (!bus->rirb.cmds[addr]) {
+			*res = bus->rirb.res[addr]; /* the last value */
+			spin_unlock_irq(&bus->reg_lock);
+			return 0;
+		}
+		spin_unlock_irq(&bus->reg_lock);
+		if (time_after(jiffies, timeout))
+			break;
+		if (loopcounter > 3000)
+			msleep(2); /* temporary workaround */
+		else {
+			udelay(10);
+			cond_resched();
+		}
+	}
+
+	return -EIO;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_bus_get_response);
+
+/*
+ * Lowlevel interface
+ */
+
+/* enter link reset */
+static void azx_enter_link_reset(struct hdac_bus *bus)
+{
+	unsigned long timeout;
+
+	/* reset controller */
+	azx_writel(bus, GCTL, azx_readl(bus, GCTL) & ~AZX_GCTL_RESET);
+
+	timeout = jiffies + msecs_to_jiffies(100);
+	while ((azx_readb(bus, GCTL) & AZX_GCTL_RESET) &&
+	       time_before(jiffies, timeout))
+		usleep_range(500, 1000);
+}
+
+/* exit link reset */
+static void azx_exit_link_reset(struct hdac_bus *bus)
+{
+	unsigned long timeout;
+
+	azx_writeb(bus, GCTL, azx_readb(bus, GCTL) | AZX_GCTL_RESET);
+
+	timeout = jiffies + msecs_to_jiffies(100);
+	while (!azx_readb(bus, GCTL) && time_before(jiffies, timeout))
+		usleep_range(500, 1000);
+}
+
+/* reset codec link */
+static int azx_reset(struct hdac_bus *bus, bool full_reset)
+{
+	if (!full_reset)
+		goto skip_reset;
+
+	/* clear STATESTS */
+	azx_writew(bus, STATESTS, STATESTS_INT_MASK);
+
+	/* reset controller */
+	azx_enter_link_reset(bus);
+
+	/* delay for >= 100us for codec PLL to settle per spec
+	 * Rev 0.9 section 5.5.1
+	 */
+	usleep_range(500, 1000);
+
+	/* Bring controller out of reset */
+	azx_exit_link_reset(bus);
+
+	/* Brent Chartrand said to wait >= 540us for codecs to initialize */
+	usleep_range(1000, 1200);
+
+ skip_reset:
+	/* check to see if controller is ready */
+	if (!azx_readb(bus, GCTL)) {
+		dev_dbg(bus->dev, "azx_reset: controller not ready!\n");
+		return -EBUSY;
+	}
+
+	/* Accept unsolicited responses */
+	azx_writel(bus, GCTL, azx_readl(bus, GCTL) | AZX_GCTL_UNSOL);
+
+	/* detect codecs */
+	if (!bus->codec_mask) {
+		bus->codec_mask = azx_readw(bus, STATESTS);
+		dev_dbg(bus->dev, "codec_mask = 0x%lx\n", bus->codec_mask);
+	}
+
+	return 0;
+}
+
+/* enable interrupts */
+static void azx_int_enable(struct hdac_bus *bus)
+{
+	/* enable controller CIE and GIE */
+	azx_writel(bus, INTCTL, azx_readl(bus, INTCTL) |
+		   AZX_INT_CTRL_EN | AZX_INT_GLOBAL_EN);
+}
+
+/* disable interrupts */
+static void azx_int_disable(struct hdac_bus *bus)
+{
+	struct hdac_stream *azx_dev;
+
+	/* disable interrupts in stream descriptor */
+	list_for_each_entry(azx_dev, &bus->stream_list, list) {
+		azx_sd_writeb(bus, azx_dev, SD_CTL,
+			      azx_sd_readb(bus, azx_dev, SD_CTL) &
+					~SD_INT_MASK);
+	}
+
+	/* disable SIE for all streams */
+	azx_writeb(bus, INTCTL, 0);
+
+	/* disable controller CIE and GIE */
+	azx_writel(bus, INTCTL, azx_readl(bus, INTCTL) &
+		   ~(AZX_INT_CTRL_EN | AZX_INT_GLOBAL_EN));
+}
+
+/* clear interrupts */
+static void azx_int_clear(struct hdac_bus *bus)
+{
+	struct hdac_stream *azx_dev;
+
+	/* clear stream status */
+	list_for_each_entry(azx_dev, &bus->stream_list, list)
+		azx_sd_writeb(bus, azx_dev, SD_STS, SD_INT_MASK);
+
+	/* clear STATESTS */
+	azx_writew(bus, STATESTS, STATESTS_INT_MASK);
+
+	/* clear rirb status */
+	azx_writeb(bus, RIRBSTS, RIRB_INT_MASK);
+
+	/* clear int status */
+	azx_writel(bus, INTSTS, AZX_INT_CTRL_EN | AZX_INT_ALL_STREAM);
+}
+
+/*
+ * reset and start the controller registers
+ */
+void snd_hdac_bus_init_chip(struct hdac_bus *bus, bool full_reset)
+{
+	if (bus->chip_init)
+		return;
+
+	/* reset controller */
+	azx_reset(bus, full_reset);
+
+	/* initialize interrupts */
+	azx_int_clear(bus);
+	azx_int_enable(bus);
+
+	/* initialize the codec command I/O */
+	azx_init_cmd_io(bus);
+
+	/* program the position buffer */
+	if (bus->use_posbuf && bus->posbuf.addr) {
+		azx_writel(bus, DPLBASE, (u32)bus->posbuf.addr);
+		azx_writel(bus, DPUBASE, upper_32_bits(bus->posbuf.addr));
+	}
+
+	bus->chip_init = true;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_bus_init_chip);
+
+void snd_hdac_bus_stop_chip(struct hdac_bus *bus)
+{
+	if (!bus->chip_init)
+		return;
+
+	/* disable interrupts */
+	azx_int_disable(bus);
+	azx_int_clear(bus);
+
+	/* disable CORB/RIRB */
+	azx_free_cmd_io(bus);
+
+	/* disable position buffer */
+	if (bus->use_posbuf && bus->posbuf.addr) {
+		azx_writel(bus, DPLBASE, 0);
+		azx_writel(bus, DPUBASE, 0);
+	}
+
+	bus->chip_init = false;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_bus_stop_chip);
+
+/*
+ * interrupt handler
+ */
+void snd_hdac_bus_handle_stream_irq(struct hdac_bus *bus, unsigned int status,
+				    void (*ack)(struct hdac_bus *,
+						struct hdac_stream *))
+{
+	struct hdac_stream *azx_dev;
+	u8 sd_status;
+
+	list_for_each_entry(azx_dev, &bus->stream_list, list) {
+		if (status & azx_dev->sd_int_sta_mask) {
+			sd_status = azx_sd_readb(bus, azx_dev, SD_STS);
+			azx_sd_writeb(bus, azx_dev, SD_STS, SD_INT_MASK);
+			if (!azx_dev->substream || !azx_dev->running ||
+			    !(sd_status & SD_INT_COMPLETE))
+				continue;
+			if (ack)
+				ack(bus, azx_dev);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(snd_hdac_bus_handle_stream_irq);
diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
new file mode 100644
index 000000000000..541648c84bd7
--- /dev/null
+++ b/sound/hda/hdac_stream.c
@@ -0,0 +1,473 @@
+/*
+ * HD-audio stream operations
+ */
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/export.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/hdaudio.h>
+#include <sound/hda_registers.h>
+
+/* initialize each stream (aka device)
+ * assign the starting bdl address to each stream (device)
+ * and initialize
+ */
+void snd_hdac_stream_init(struct hdac_bus *bus, struct hdac_stream *azx_dev,
+			  int idx, int direction, int tag)
+{
+	azx_dev->bus = bus;
+	if (bus->posbuf.area)
+		azx_dev->posbuf = (u32 __iomem *)(bus->posbuf.area + idx * 8);
+	/* offset: SDI0=0x80, SDI1=0xa0, ... SDO3=0x160 */
+	azx_dev->sd_addr = bus->remap_addr + (0x20 * idx + 0x80);
+	/* int mask: SDI0=0x01, SDI1=0x02, ... SDO3=0x80 */
+	azx_dev->sd_int_sta_mask = 1 << idx;
+	azx_dev->index = idx;
+	azx_dev->direction = direction;
+	azx_dev->stream_tag = tag;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_stream_init);
+
+/* start a stream */
+void snd_hdac_stream_start(struct hdac_stream *azx_dev, bool fresh_start)
+{
+	struct hdac_bus *bus = azx_dev->bus;
+
+	azx_dev->start_wallclk = azx_readl(bus, WALLCLK);
+	if (!fresh_start)
+		azx_dev->start_wallclk -= azx_dev->period_wallclk;
+
+	/* enable SIE */
+	azx_writel(bus, INTCTL, azx_readl(bus, INTCTL) | (1 << azx_dev->index));
+	/* set DMA start and interrupt mask */
+	azx_sd_writeb(bus, azx_dev, SD_CTL,
+		      azx_sd_readb(bus, azx_dev, SD_CTL) |
+		      SD_CTL_DMA_START | SD_INT_MASK);
+	azx_dev->running = true;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_stream_start);
+
+/* stop DMA */
+void snd_hdac_stream_clear(struct hdac_stream *azx_dev)
+{
+	struct hdac_bus *bus = azx_dev->bus;
+
+	azx_sd_writeb(bus, azx_dev, SD_CTL,
+		      azx_sd_readb(bus, azx_dev, SD_CTL) &
+		      ~(SD_CTL_DMA_START | SD_INT_MASK));
+	azx_sd_writeb(bus, azx_dev, SD_STS, SD_INT_MASK); /* to be sure */
+	azx_dev->running = false;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_stream_clear);
+
+/* stop a stream */
+void snd_hdac_stream_stop(struct hdac_stream *azx_dev)
+{
+	struct hdac_bus *bus = azx_dev->bus;
+
+	snd_hdac_stream_clear(azx_dev);
+	/* disable SIE */
+	azx_writel(bus, INTCTL,
+		   azx_readl(bus, INTCTL) & ~(1 << azx_dev->index));
+}
+EXPORT_SYMBOL_GPL(snd_hdac_stream_stop);
+
+/* reset stream */
+void snd_hdac_stream_reset(struct hdac_stream *azx_dev)
+{
+	struct hdac_bus *bus = azx_dev->bus;
+	unsigned char val;
+	int timeout;
+
+	snd_hdac_stream_clear(azx_dev);
+
+	azx_sd_writeb(bus, azx_dev, SD_CTL,
+		      azx_sd_readb(bus, azx_dev, SD_CTL) |
+		      SD_CTL_STREAM_RESET);
+	udelay(3);
+	timeout = 300;
+	do {
+		val = azx_sd_readb(bus, azx_dev, SD_CTL) & SD_CTL_STREAM_RESET;
+		if (val)
+			break;
+	} while (--timeout);
+	val &= ~SD_CTL_STREAM_RESET;
+	azx_sd_writeb(bus, azx_dev, SD_CTL, val);
+	udelay(3);
+
+	timeout = 300;
+	/* waiting for hardware to report that the stream is out of reset */
+	do {
+		val = azx_sd_readb(bus, azx_dev, SD_CTL) & SD_CTL_STREAM_RESET;
+		if (!val)
+			break;
+	} while (--timeout);
+
+	/* reset first position - may not be synced with hw at this time */
+	if (azx_dev->posbuf)
+		*azx_dev->posbuf = 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_stream_reset);
+
+/*
+ * set up the SD for streaming
+ */
+int snd_hdac_stream_setup(struct hdac_stream *azx_dev)
+{
+	struct hdac_bus *bus = azx_dev->bus;
+	struct snd_pcm_runtime *runtime = azx_dev->substream->runtime;
+	unsigned int val;
+
+	/* make sure the run bit is zero for SD */
+	snd_hdac_stream_clear(azx_dev);
+	/* program the stream_tag */
+	val = azx_sd_readl(bus, azx_dev, SD_CTL);
+	val = (val & ~SD_CTL_STREAM_TAG_MASK) |
+		(azx_dev->stream_tag << SD_CTL_STREAM_TAG_SHIFT);
+	if (!bus->snoop)
+		val |= SD_CTL_TRAFFIC_PRIO;
+	azx_sd_writel(bus, azx_dev, SD_CTL, val);
+
+	/* program the length of samples in cyclic buffer */
+	azx_sd_writel(bus, azx_dev, SD_CBL, azx_dev->bufsize);
+
+	/* program the stream format */
+	/* this value needs to be the same as the one programmed */
+	azx_sd_writew(bus, azx_dev, SD_FORMAT, azx_dev->format_val);
+
+	/* program the stream LVI (last valid index) of the BDL */
+	azx_sd_writew(bus, azx_dev, SD_LVI, azx_dev->frags - 1);
+
+	/* program the BDL address */
+	/* lower BDL address */
+	azx_sd_writel(bus, azx_dev, SD_BDLPL, (u32)azx_dev->bdl.addr);
+	/* upper BDL address */
+	azx_sd_writel(bus, azx_dev, SD_BDLPU,
+		      upper_32_bits(azx_dev->bdl.addr));
+
+	/* enable the position buffer */
+	if (bus->use_posbuf) {
+		if (!(azx_readl(bus, DPLBASE) & AZX_DPLBASE_ENABLE))
+			azx_writel(bus, DPLBASE,
+				(u32)bus->posbuf.addr | AZX_DPLBASE_ENABLE);
+	}
+
+	/* set the interrupt enable bits in the descriptor control register */
+	azx_sd_writel(bus, azx_dev, SD_CTL,
+		      azx_sd_readl(bus, azx_dev, SD_CTL) | SD_INT_MASK);
+
+	if (azx_dev->direction == SNDRV_PCM_STREAM_PLAYBACK)
+		azx_dev->fifo_size =
+			azx_sd_readw(bus, azx_dev, SD_FIFOSIZE) + 1;
+	else
+		azx_dev->fifo_size = 0;
+
+	/* when LPIB delay correction gives a small negative value,
+	 * we ignore it; currently set the threshold statically to
+	 * 64 frames
+	 */
+	if (runtime->period_size > 64)
+		azx_dev->delay_negative_threshold =
+			-frames_to_bytes(runtime, 64);
+	else
+		azx_dev->delay_negative_threshold = 0;
+
+	/* wallclk has 24Mhz clock source */
+	azx_dev->period_wallclk = (((runtime->period_size * 24000) /
+				    runtime->rate) * 1000);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_stream_setup);
+
+void snd_hdac_stream_cleanup(struct hdac_stream *azx_dev)
+{
+	struct hdac_bus *bus = azx_dev->bus;
+
+	azx_sd_writel(bus, azx_dev, SD_BDLPL, 0);
+	azx_sd_writel(bus, azx_dev, SD_BDLPU, 0);
+	azx_sd_writel(bus, azx_dev, SD_CTL, 0);
+	azx_dev->bufsize = 0;
+	azx_dev->period_bytes = 0;
+	azx_dev->format_val = 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_stream_cleanup);
+
+/* assign a stream for the PCM */
+struct hdac_stream *snd_hdac_stream_assign(struct hdac_bus *bus,
+					   struct snd_pcm_substream *substream)
+{
+	struct hdac_stream *azx_dev;
+	struct hdac_stream *res = NULL;
+
+	/* make a non-zero unique key for the substream */
+	int key = (substream->pcm->device << 16) | (substream->number << 2) |
+		(substream->stream + 1);
+
+	list_for_each_entry(azx_dev, &bus->stream_list, list) {
+		if (azx_dev->direction != substream->stream)
+			continue;
+		if (azx_dev->opened)
+			continue;
+		if (azx_dev->assigned_key == key) {
+			res = azx_dev;
+			break;
+		}
+		if (!res || bus->reverse_assign)
+			res = azx_dev;
+	}
+	if (res) {
+		spin_lock_irq(&bus->reg_lock);
+		res->opened = 1;
+		res->running = 0;
+		res->assigned_key = key;
+		res->substream = substream;
+		spin_lock_irq(&bus->reg_lock);
+	}
+	return res;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_stream_assign);
+
+/* release the assigned stream */
+void snd_hdac_stream_release(struct hdac_stream *azx_dev)
+{
+	struct hdac_bus *bus = azx_dev->bus;
+
+	spin_lock_irq(&bus->reg_lock);
+	azx_dev->opened = 0;
+	azx_dev->running = 0;
+	azx_dev->substream = NULL;
+	spin_lock_irq(&bus->reg_lock);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_stream_release);
+
+/*
+ * set up a BDL entry
+ */
+static int setup_bdle(struct hdac_bus *bus,
+		      struct snd_dma_buffer *dmab,
+		      struct hdac_stream *azx_dev, u32 **bdlp,
+		      int ofs, int size, int with_ioc)
+{
+	u32 *bdl = *bdlp;
+
+	while (size > 0) {
+		dma_addr_t addr;
+		int chunk;
+
+		if (azx_dev->frags >= AZX_MAX_BDL_ENTRIES)
+			return -EINVAL;
+
+		addr = snd_sgbuf_get_addr(dmab, ofs);
+		/* program the address field of the BDL entry */
+		bdl[0] = cpu_to_le32((u32)addr);
+		bdl[1] = cpu_to_le32(upper_32_bits(addr));
+		/* program the size field of the BDL entry */
+		chunk = snd_sgbuf_get_chunk_size(dmab, ofs, size);
+		/* one BDLE cannot cross 4K boundary on CTHDA chips */
+		if (bus->align_bdle_4k) {
+			u32 remain = 0x1000 - (ofs & 0xfff);
+
+			if (chunk > remain)
+				chunk = remain;
+		}
+		bdl[2] = cpu_to_le32(chunk);
+		/* program the IOC to enable interrupt
+		 * only when the whole fragment is processed
+		 */
+		size -= chunk;
+		bdl[3] = (size || !with_ioc) ? 0 : cpu_to_le32(0x01);
+		bdl += 4;
+		azx_dev->frags++;
+		ofs += chunk;
+	}
+	*bdlp = bdl;
+	return ofs;
+}
+
+/*
+ * set up BDL entries
+ */
+int snd_hdac_stream_setup_periods(struct hdac_stream *azx_dev)
+{
+	struct hdac_bus *bus = azx_dev->bus;
+	struct snd_pcm_substream *substream = azx_dev->substream;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	u32 *bdl;
+	int i, ofs, periods, period_bytes;
+	int pos_adj, pos_align;
+
+	/* reset BDL address */
+	azx_sd_writel(bus, azx_dev, SD_BDLPL, 0);
+	azx_sd_writel(bus, azx_dev, SD_BDLPU, 0);
+
+	period_bytes = azx_dev->period_bytes;
+	periods = azx_dev->bufsize / period_bytes;
+
+	/* program the initial BDL entries */
+	bdl = (u32 *)azx_dev->bdl.area;
+	ofs = 0;
+	azx_dev->frags = 0;
+
+	pos_adj = bus->bdl_pos_adj;
+	if (!azx_dev->no_period_wakeup && pos_adj > 0) {
+		pos_align = pos_adj;
+		pos_adj = (pos_adj * runtime->rate + 47999) / 48000;
+		if (!pos_adj)
+			pos_adj = pos_align;
+		else
+			pos_adj = ((pos_adj + pos_align - 1) / pos_align) *
+				pos_align;
+		pos_adj = frames_to_bytes(runtime, pos_adj);
+		if (pos_adj >= period_bytes) {
+			dev_warn(bus->dev, "Too big adjustment %d\n",
+				 pos_adj);
+			pos_adj = 0;
+		} else {
+			ofs = setup_bdle(bus, snd_pcm_get_dma_buf(substream),
+					 azx_dev,
+					 &bdl, ofs, pos_adj, true);
+			if (ofs < 0)
+				goto error;
+		}
+	} else
+		pos_adj = 0;
+
+	for (i = 0; i < periods; i++) {
+		if (i == periods - 1 && pos_adj)
+			ofs = setup_bdle(bus, snd_pcm_get_dma_buf(substream),
+					 azx_dev, &bdl, ofs,
+					 period_bytes - pos_adj, 0);
+		else
+			ofs = setup_bdle(bus, snd_pcm_get_dma_buf(substream),
+					 azx_dev, &bdl, ofs,
+					 period_bytes,
+					 !azx_dev->no_period_wakeup);
+		if (ofs < 0)
+			goto error;
+	}
+	return 0;
+
+ error:
+	dev_err(bus->dev, "Too many BDL entries: buffer=%d, period=%d\n",
+		azx_dev->bufsize, period_bytes);
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_stream_setup_periods);
+
+static cycle_t azx_cc_read(const struct cyclecounter *cc)
+{
+	struct hdac_stream *azx_dev = container_of(cc, struct hdac_stream, cc);
+
+	return azx_readl(azx_dev->bus, WALLCLK);
+}
+
+static void azx_timecounter_init(struct hdac_stream *azx_dev,
+				 bool force, cycle_t last)
+{
+	struct timecounter *tc = &azx_dev->tc;
+	struct cyclecounter *cc = &azx_dev->cc;
+	u64 nsec;
+
+	cc->read = azx_cc_read;
+	cc->mask = CLOCKSOURCE_MASK(32);
+
+	/*
+	 * Converting from 24 MHz to ns means applying a 125/3 factor.
+	 * To avoid any saturation issues in intermediate operations,
+	 * the 125 factor is applied first. The division is applied
+	 * last after reading the timecounter value.
+	 * Applying the 1/3 factor as part of the multiplication
+	 * requires at least 20 bits for a decent precision, however
+	 * overflows occur after about 4 hours or less, not a option.
+	 */
+
+	cc->mult = 125; /* saturation after 195 years */
+	cc->shift = 0;
+
+	nsec = 0; /* audio time is elapsed time since trigger */
+	timecounter_init(tc, cc, nsec);
+	if (force) {
+		/*
+		 * force timecounter to use predefined value,
+		 * used for synchronized starts
+		 */
+		tc->cycle_last = last;
+	}
+}
+
+void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
+				      unsigned int streams)
+{
+	struct hdac_bus *bus = azx_dev->bus;
+	struct snd_pcm_runtime *runtime = azx_dev->substream->runtime;
+	struct hdac_stream *s;
+	bool inited = false;
+	cycle_t cycle_last = 0;
+	int i = 0;
+
+	list_for_each_entry(s, &bus->stream_list, list) {
+		if (streams & (1 << i)) {
+			azx_timecounter_init(s, inited, cycle_last);
+			if (!inited) {
+				inited = true;
+				cycle_last = s->tc.cycle_last;
+			}
+		}
+		i++;
+	}
+
+	snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
+	runtime->trigger_tstamp_latched = true;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_stream_timecounter_init);
+
+void snd_hdac_stream_sync_trigger(struct hdac_stream *azx_dev, bool set,
+				  unsigned int streams, unsigned int reg)
+{
+	struct hdac_bus *bus = azx_dev->bus;
+	unsigned int mask = ~streams;
+
+	if (!set)
+		streams = 0;
+	if (!reg)
+		reg = AZX_REG_SSYNC;
+	_azx_write(l, bus, reg, (_azx_read(l, bus, reg) & mask) | streams);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_stream_sync_trigger);
+
+/* wait until all FIFOs get ready */
+void snd_hdac_stream_sync(struct hdac_stream *azx_dev, bool start,
+			  unsigned int streams)
+{
+	struct hdac_bus *bus = azx_dev->bus;
+	int i, nwait, timeout;
+	struct hdac_stream *s;
+
+	for (timeout = 5000; timeout; timeout--) {
+		nwait = 0;
+		i = 0;
+		list_for_each_entry(s, &bus->stream_list, list) {
+			if (streams & (1 << i)) {
+				if (start) {
+					/* check FIFO gets ready */
+					if (!(azx_sd_readb(bus, s, SD_STS) &
+					      SD_STS_FIFO_READY))
+						nwait++;
+				} else {
+					/* check RUN bit is cleared */
+					if (azx_sd_readb(bus, s, SD_CTL) &
+					    SD_CTL_DMA_START)
+						nwait++;
+				}
+			}
+			i++;
+		}
+		if (!nwait)
+			break;
+		cpu_relax();
+	}
+}
+EXPORT_SYMBOL_GPL(snd_hdac_stream_sync);
-- 
1.7.9.5
