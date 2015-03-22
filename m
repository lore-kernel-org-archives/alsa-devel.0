From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH 1/2] [resend] snd-waveartist: Introduce Rockwell WaveArtist RWA010 driver
Date: Sun, 22 Mar 2015 20:36:55 +0100
Message-ID: <1427053016-25830-1-git-send-email-linux@rainbow-software.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

This is a new ALSA driver driver for Rockwell WaveArtist RWA010 chips found
on some (rare) ISA sound cards, such as DCS Multimedia S717.

I wasn't able to get the old OSS WaveArtist driver to work with my card but it
was a great source of information about the chip (as the full datasheet is not
available - only a brief one and a design guide).
However, the OSS driver only supports few of the mixer registers so I had to
install the card in Windows and dump mixer registers while changing the mixer
settings. Then tried what the rest of the registers do and the result is a
fully working mixer which even supports more controls than the Windows driver.

Someone with a NetWinder can add support for it to this driver and then remove
the old OSS one.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 include/sound/mpu401.h |    1 +
 sound/isa/Kconfig      |   11 +
 sound/isa/Makefile     |    2 +
 sound/isa/waveartist.c | 1399 ++++++++++++++++++++++++++++++++++++++++++++++++
 sound/isa/waveartist.h |   74 +++
 5 files changed, 1487 insertions(+)
 create mode 100644 sound/isa/waveartist.c
 create mode 100644 sound/isa/waveartist.h

diff --git a/include/sound/mpu401.h b/include/sound/mpu401.h
index e942096..8fceeba 100644
--- a/include/sound/mpu401.h
+++ b/include/sound/mpu401.h
@@ -44,6 +44,7 @@
 #define MPU401_HW_INTEL8X0		17	/* Intel8x0 driver */
 #define MPU401_HW_PC98II		18	/* Roland PC98II */
 #define MPU401_HW_AUREAL		19	/* Aureal Vortex */
+#define MPU401_HW_WAVEARTIST		20	/* Rockwell WaveArtist */
 
 #define MPU401_INFO_INPUT	(1 << 0)	/* input stream */
 #define MPU401_INFO_OUTPUT	(1 << 1)	/* output stream */
diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index 0216475..7a3b4a2 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -454,5 +454,16 @@ config SND_MSND_CLASSIC
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-msnd-classic.
 
+config SND_WAVEARTIST
+	tristate "Rockwell WaveArtist RWA010"
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	select SND_PCM
+	help
+	  Say Y here to include support for Rockwell WaveArtist RWA010 chips.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-waveartist.
+
 endif	# SND_ISA
 
diff --git a/sound/isa/Makefile b/sound/isa/Makefile
index 9a15f14..23e11e2 100644
--- a/sound/isa/Makefile
+++ b/sound/isa/Makefile
@@ -12,6 +12,7 @@ snd-es18xx-objs := es18xx.o
 snd-opl3sa2-objs := opl3sa2.o
 snd-sc6000-objs := sc6000.o
 snd-sscape-objs := sscape.o
+snd-waveartist-objs := waveartist.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_ADLIB) += snd-adlib.o
@@ -23,6 +24,7 @@ obj-$(CONFIG_SND_ES18XX) += snd-es18xx.o
 obj-$(CONFIG_SND_OPL3SA2) += snd-opl3sa2.o
 obj-$(CONFIG_SND_SC6000) += snd-sc6000.o
 obj-$(CONFIG_SND_SSCAPE) += snd-sscape.o
+obj-$(CONFIG_SND_WAVEARTIST) += snd-waveartist.o
 
 obj-$(CONFIG_SND) += ad1816a/ ad1848/ cs423x/ es1688/ galaxy/ gus/ msnd/ opti9xx/ \
 		     sb/ wavefront/ wss/
diff --git a/sound/isa/waveartist.c b/sound/isa/waveartist.c
new file mode 100644
index 0000000..e5bda5c
--- /dev/null
+++ b/sound/isa/waveartist.c
@@ -0,0 +1,1399 @@
+/*
+ *  Driver for Rockwell WaveArtist RWA010 soundcards
+ *
+ *  Copyright (c) 2015 Ondrej Zary
+ *
+ *  HW-related parts based on OSS WaveArtist driver by Hannu Savolainen
+ *
+ *  ALSA code based on ES18xx driver by Christian Fischbach & Abramo Bagnara
+ *  and also by OPL3-SA2 driver by Jaroslav Kysela
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/isa.h>
+#include <linux/pnp.h>
+#include <linux/isapnp.h>
+#include <asm/dma.h>
+#include <sound/core.h>
+#include <sound/control.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/mpu401.h>
+#include <sound/opl3.h>
+#include <sound/initval.h>
+#include "waveartist.h"
+
+MODULE_AUTHOR("Ondrej Zary");
+MODULE_DESCRIPTION("Driver for Rockwell WaveArtist RWA010 sound cards");
+MODULE_LICENSE("GPL");
+
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
+static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_ISAPNP;
+#ifdef CONFIG_PNP
+static bool isapnp[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};
+#endif
+static long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* 0x250-0x3f0 */
+static long fm_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* 0x388-0x3f0 */
+static long midi_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;/* 0x300-0x3f0 */
+static int irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* 5,7,10,11 */
+static int dma1[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* 5,6,7 */
+static int dma2[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* 0,1,3 */
+
+module_param_array(index, int, NULL, 0444);
+MODULE_PARM_DESC(index, "Index value for WaveArtist soundcard.");
+module_param_array(id, charp, NULL, 0444);
+MODULE_PARM_DESC(id, "ID string for WaveArtist soundcard.");
+module_param_array(enable, bool, NULL, 0444);
+MODULE_PARM_DESC(enable, "Enable WaveArtist soundcard.");
+#ifdef CONFIG_PNP
+module_param_array(isapnp, bool, NULL, 0444);
+MODULE_PARM_DESC(isapnp, "PnP detection for specified soundcard.");
+#endif
+module_param_array(port, long, NULL, 0444);
+MODULE_PARM_DESC(port, "Port # for WaveArtist driver.");
+module_param_array(fm_port, long, NULL, 0444);
+MODULE_PARM_DESC(fm_port, "FM port # for WaveArtist driver.");
+module_param_array(midi_port, long, NULL, 0444);
+MODULE_PARM_DESC(midi_port, "MIDI port # for WaveArtist driver.");
+module_param_array(irq, int, NULL, 0444);
+MODULE_PARM_DESC(irq, "IRQ # for WaveArtist driver.");
+module_param_array(dma1, int, NULL, 0444);
+MODULE_PARM_DESC(dma1, "DMA1 # for WaveArtist driver.");
+module_param_array(dma2, int, NULL, 0444);
+MODULE_PARM_DESC(dma2, "DMA2 # for WaveArtist driver.");
+
+#ifdef CONFIG_PNP
+static int isa_registered;
+static int pnp_registered;
+#endif
+
+#define PFX	"waveartist: "
+
+#ifdef CONFIG_PNP
+#define WA_DEVICE(pnpid) { \
+	.id = pnpid, \
+	.devs = { {"RSS5000"}, {"RSS5001"}, {"RSS5002"} } \
+}
+/*
+ * RSS5000 = WaveArtist, RSS5001 = SB, RSS5002 = MPU-401, RSS5003 = IDE,
+ * RSS5004 = gameport, RSS5005 = modem, RSS5006 = 3D
+ */
+
+static struct pnp_card_device_id snd_waveartist_pnpids[] = {
+	WA_DEVICE("RSS5000"), /* 16-bit decode */
+	WA_DEVICE("RSS5100"), /* 16-bit decode + modem */
+	WA_DEVICE("RSS5200"), /* 10-bit decode + modem */
+	WA_DEVICE("RSS5300"), /* 10-bit decode */
+	WA_DEVICE("RSS5400"), /* 16-bit decode + IDE */
+	WA_DEVICE("RSS5500"), /* 16-bit decode + modem + IDE */
+	WA_DEVICE("RSS5600"), /* 10-bit decode + IDE */
+	WA_DEVICE("RSS5700"), /* 10-bit decode + modem + IDE */
+	WA_DEVICE("RSS5800"), /* 10-bit decode + modem + 3D */
+	WA_DEVICE("RSS5900"), /* 10-bit decode + 3D */
+	WA_DEVICE("RSS5A00"), /* 16-bit decode + modem + 3D */
+	WA_DEVICE("RSS5B00"), /* 16-bit decode + 3D */
+	{ .id = "" }	/* end */
+};
+MODULE_DEVICE_TABLE(pnp_card, snd_waveartist_pnpids);
+#endif /* CONFIG_PNP */
+
+struct snd_waveartist {
+#ifdef CONFIG_PNP
+	struct pnp_dev *wa;	/* WaveArtist device */
+	struct pnp_dev *sb;	/* SB emulation device */
+	struct pnp_dev *mpu;	/* MPU-401 device */
+#endif
+	unsigned long port;	/* base port */
+	struct resource *res_port; /* base port resource */
+	int irq;
+	int dma_playback;
+	int dma_capture;
+
+	struct snd_card *card;
+	struct snd_pcm *pcm;
+	struct snd_pcm_substream *playback_substream;
+	struct snd_pcm_substream *capture_substream;
+
+	spinlock_t reg_lock;
+	struct snd_hwdep *synth;
+	struct snd_rawmidi *rmidi;
+
+	u16 image[20];	/* mixer registers image */
+};
+
+static inline void wa_outb(struct snd_waveartist *chip, u8 reg, u8 val)
+{
+	outb(val, chip->port + reg);
+}
+
+static inline u8 wa_inb(struct snd_waveartist *chip, u8 reg)
+{
+	return inb(chip->port + reg);
+}
+
+static inline void wa_outw(struct snd_waveartist *chip, u8 reg, u16 val)
+{
+	outw(val, chip->port + reg);
+}
+
+static inline u16 wa_inw(struct snd_waveartist *chip, u8 reg)
+{
+	return inw(chip->port + reg);
+}
+
+static inline void waveartist_set_ctlr(struct snd_waveartist *chip, u8 clear,
+				       u8 set)
+{
+	clear = ~clear & wa_inb(chip, CTLR);
+	wa_outb(chip, CTLR, clear | set);
+}
+
+/* acknowledge IRQ */
+static inline void waveartist_iack(struct snd_waveartist *chip)
+{
+	u8 old_ctlr = wa_inb(chip, CTLR) & ~IRQ_ACK;
+
+	wa_outb(chip, CTLR, old_ctlr | IRQ_ACK);
+	wa_outb(chip, CTLR, old_ctlr);
+}
+
+static int waveartist_reset(struct snd_waveartist *chip)
+{
+	unsigned int timeout, res = -1;
+
+	waveartist_set_ctlr(chip, -1, RESET);
+	msleep(200);
+	waveartist_set_ctlr(chip, RESET, 0);
+
+	timeout = 500;
+	do {
+		mdelay(2);
+
+		if (wa_inb(chip, STATR) & CMD_RF) {
+			res = wa_inw(chip, CMDR);
+			if (res == 0x55aa)
+				break;
+		}
+	} while (--timeout);
+
+	if (timeout == 0) {
+		dev_warn(chip->card->dev, "WaveArtist: reset timeout (res=0x%x)\n",
+			 res);
+		return 1;
+	}
+
+	return 0;
+}
+
+/* Helper function to send and receive words
+ * from WaveArtist. It handles all the handshaking
+ * and can send or receive multiple words.
+ */
+static int waveartist_cmd(struct snd_waveartist *chip,
+			  int nr_cmd, u16 *cmd,
+			  int nr_resp, u16 *resp)
+{
+	unsigned long flags;
+	unsigned int timed_out = 0, i;
+
+	spin_lock_irqsave(&chip->reg_lock, flags);
+	/*
+	 * The chip can hang if we access the STATR register too quickly
+	 * after a write. Do a dummy read to slow down.
+	 */
+	wa_inb(chip, CTLR);
+
+	if (wa_inb(chip, STATR) & CMD_RF) {
+		/* flush the port */
+		wa_inw(chip, CMDR);
+		udelay(10);
+	}
+
+	for (i = 0; !timed_out && i < nr_cmd; i++) {
+		int count;
+
+		for (count = 5000; count; count--)
+			if (wa_inb(chip, STATR) & CMD_WE)
+				break;
+
+		if (!count)
+			timed_out = 1;
+		else
+			wa_outw(chip, CMDR, cmd[i]);
+		/* Another dummy read */
+		wa_inb(chip, CTLR);
+	}
+
+	for (i = 0; !timed_out && i < nr_resp; i++) {
+		int count;
+
+		for (count = 5000; count; count--)
+			if (wa_inb(chip, STATR) & CMD_RF)
+				break;
+
+		if (!count)
+			timed_out = 1;
+		else
+			resp[i] = wa_inw(chip, CMDR);
+	}
+	spin_unlock_irqrestore(&chip->reg_lock, flags);
+
+	return timed_out ? 1 : 0;
+}
+
+/* Send one command word */
+static inline int waveartist_cmd1(struct snd_waveartist *chip, u16 cmd)
+{
+	return waveartist_cmd(chip, 1, &cmd, 0, NULL);
+}
+
+/* Send one command, receive one word */
+static inline u16 waveartist_cmd1_r(struct snd_waveartist *chip, u16 cmd)
+{
+	u16 ret;
+
+	waveartist_cmd(chip, 1, &cmd, 1, &ret);
+
+	return ret;
+}
+
+/* Send a double command, receive one word (and throw it away) */
+static inline int waveartist_cmd2(struct snd_waveartist *chip, u16 cmd, u16 arg)
+{
+	u16 vals[2] = { cmd, arg };
+
+	return waveartist_cmd(chip, 2, vals, 1, vals);
+}
+
+/* Send a triple command */
+static inline int waveartist_cmd3(struct snd_waveartist *chip, u16 cmd,
+				  u16 arg1, u16 arg2)
+{
+	u16 vals[3] = { cmd, arg1, arg2 };
+
+	return waveartist_cmd(chip, 3, vals, 0, NULL);
+}
+
+static u16 waveartist_getrev(struct snd_waveartist *chip)
+{
+	u16 temp[2];
+	u16 cmd = WACMD_GETREV;
+
+	waveartist_cmd(chip, 1, &cmd, 2, temp);
+
+	return temp[0];
+}
+
+static irqreturn_t snd_waveartist_interrupt(int irq, void *dev_id)
+{
+	u8 status, irqstatus;
+	struct snd_card *card = dev_id;
+	struct snd_waveartist *chip;
+
+	if (card == NULL)
+		return IRQ_NONE;
+
+	chip = card->private_data;
+
+	irqstatus = wa_inb(chip, IRQSTAT);
+	status    = wa_inb(chip, STATR);
+
+	if (status & IRQ_REQ)	/* clear interrupt */
+		waveartist_iack(chip);
+
+	if (irqstatus & IRQ_PCM) { /* PCM buffer done */
+		if ((status & DMA1) && chip->playback_substream)
+			snd_pcm_period_elapsed(chip->playback_substream);
+		if ((status & DMA0) && chip->capture_substream)
+			snd_pcm_period_elapsed(chip->capture_substream);
+		if (!(status & (DMA0 | DMA1)))
+			dev_warn(chip->card->dev, "Unknown PCM interrupt\n");
+	}
+
+	if (irqstatus & IRQ_SB)	/* we do not use SB mode */
+		dev_warn(chip->card->dev, "Unexpected SB interrupt\n");
+
+	if ((irqstatus & IRQ_MPU) && chip->rmidi)
+		snd_mpu401_uart_interrupt(irq, chip->rmidi->private_data);
+
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_PM
+static int snd_waveartist_suspend(struct snd_card *card, pm_message_t state)
+{
+	struct snd_waveartist *chip = card->private_data;
+	int i;
+
+	if (!card)
+		return 0;
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
+	snd_pcm_suspend_all(chip->pcm);
+
+	/* save mixer registers */
+	for (i = 0; i < ARRAY_SIZE(chip->image); i++)
+		chip->image[i] = waveartist_cmd1_r(chip,
+						   WACMD_GET_LEVEL | i << 8);
+
+	return 0;
+}
+
+static int snd_waveartist_resume(struct snd_card *card)
+{
+	struct snd_waveartist *chip;
+	int i;
+
+	if (!card)
+		return 0;
+
+	chip = card->private_data;
+
+	/* restore mixer registers */
+	for (i = 0; i < 10; i += 2)
+		waveartist_cmd3(chip, WACMD_SET_MIXER,
+				chip->image[i], chip->image[i + 1]);
+	for (i = 10; i < ARRAY_SIZE(chip->image); i += 2)
+		waveartist_cmd3(chip, WACMD_SET_LEVEL |
+				      ((i - 10) / 2) << 8,
+				      chip->image[i], chip->image[i + 1]);
+
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
+
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+#ifdef CONFIG_PNP
+static void snd_waveartist_set_irq(struct pnp_dev *pdev, int irq)
+{
+	if (!pdev->active)
+		return;
+	isapnp_cfg_begin(isapnp_card_number(pdev), isapnp_csn_number(pdev));
+	isapnp_write_byte(0x70, irq);	/* ISAPNP_CFG_IRQ */
+	isapnp_cfg_end();
+}
+
+static int snd_waveartist_pnp(int dev, struct snd_waveartist *chip,
+			      struct pnp_card_link *card,
+			      const struct pnp_card_device_id *id)
+{
+	chip->wa = pnp_request_card_device(card, id->devs[0].id, NULL);
+	if (!chip->wa)
+		return -EBUSY;
+
+	chip->sb = pnp_request_card_device(card, id->devs[1].id, NULL);
+	if (!chip->sb)
+		return -EBUSY;
+
+	chip->mpu = pnp_request_card_device(card, id->devs[2].id, NULL);
+	if (!chip->mpu)
+		return -EBUSY;
+
+	if (pnp_activate_dev(chip->wa) < 0) {
+		dev_err(chip->card->dev, "WA PnP configure failure\n");
+		return -EBUSY;
+	}
+	if (pnp_activate_dev(chip->sb) < 0) {
+		dev_err(chip->card->dev, "SB PnP configure failure\n");
+		return -EBUSY;
+	}
+	port[dev] = pnp_port_start(chip->wa, 0);
+	dma2[dev] = pnp_dma(chip->wa, 0);
+	fm_port[dev] = pnp_port_start(chip->sb, 1);
+	dma1[dev] = pnp_dma(chip->sb, 0);
+	irq[dev] = pnp_irq(chip->sb, 0);
+
+	/*
+	 * The card uses only one IRQ (listed in the resources of SB device)
+	 * which needs to be shared by WaveArtist and MPU-401 devices. They
+	 * don't have an IRQ resource so it must be forced.
+	 */
+	snd_waveartist_set_irq(chip->wa, irq[dev]);
+
+	/* allocate MPU-401 resources */
+	if (pnp_activate_dev(chip->mpu) < 0)
+		dev_err(chip->card->dev, "MPU-401 PnP configure failure: will be disabled\n");
+	else {
+		midi_port[dev] = pnp_port_start(chip->mpu, 0);
+		snd_waveartist_set_irq(chip->mpu, irq[dev]);
+	}
+
+	dev_dbg(chip->card->dev, "PnP WaveArtist: port=0x%lx, fm port=0x%lx, midi port=0x%lx\n",
+		port[dev], fm_port[dev], midi_port[dev]);
+	dev_dbg(chip->card->dev, "PnP WaveArtist: dma1=%i, dma2=%i, irq=%i\n",
+		dma1[dev], dma2[dev], irq[dev]);
+
+	return 0;
+}
+#endif /* CONFIG_PNP */
+
+static int snd_waveartist_playback_hw_params(
+					struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *hw_params)
+{
+	int err = snd_pcm_lib_malloc_pages(substream,
+					   params_buffer_bytes(hw_params));
+
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int snd_waveartist_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_lib_free_pages(substream);
+}
+
+static enum wa_format waveartist_format(snd_pcm_format_t format)
+{
+	if (snd_pcm_format_width(format) == 16)
+		return WA_FMT_S16;
+	if (snd_pcm_format_unsigned(format))
+		return WA_FMT_U8;
+	else
+		return WA_FMT_S8;
+}
+
+static u16 waveartist_rate(struct snd_pcm_runtime *runtime)
+{
+	return (runtime->rate << 16) / 44100;
+}
+
+static int snd_waveartist_playback_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_waveartist *chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned int size = snd_pcm_lib_buffer_bytes(substream);
+	unsigned int count = snd_pcm_lib_period_bytes(substream);
+
+	/* Set rate */
+	if (waveartist_cmd2(chip, WACMD_OUTPUTSPEED, waveartist_rate(runtime)))
+		dev_warn(chip->card->dev, "error setting playback rate %dHz\n",
+			 runtime->rate);
+	/* Set channel count */
+	if (waveartist_cmd2(chip, WACMD_OUTPUTCHANNELS, runtime->channels))
+		dev_warn(chip->card->dev, "error setting playback %d channels\n",
+			 runtime->channels);
+	/* Set DMA channel */
+	if (waveartist_cmd2(chip, WACMD_OUTPUTDMA,
+			chip->dma_playback > 3 ? WA_DMA_16BIT : WA_DMA_8BIT))
+		dev_warn(chip->card->dev, "error setting playback data path\n");
+	/* Set format */
+	if (waveartist_cmd2(chip, WACMD_OUTPUTFORMAT,
+			    waveartist_format(runtime->format)))
+		dev_warn(chip->card->dev, "error setting playback format %d\n",
+			 runtime->format);
+	/* Set sample count */
+	if (waveartist_cmd2(chip, WACMD_OUTPUTSIZE, count - 1))
+		dev_warn(chip->card->dev, "error setting playback count %d\n",
+			 count);
+	/* Configure DMA controller */
+	snd_dma_program(chip->dma_playback, runtime->dma_addr, size,
+			DMA_MODE_WRITE | DMA_AUTOINIT);
+
+	return 0;
+}
+
+static int snd_waveartist_playback_trigger(struct snd_pcm_substream *substream,
+					   int cmd)
+{
+	struct snd_waveartist *chip = snd_pcm_substream_chip(substream);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		waveartist_cmd1(chip, WACMD_OUTPUTSTART);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		waveartist_cmd1(chip, WACMD_OUTPUTSTOP);
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		waveartist_cmd1(chip, WACMD_OUTPUTPAUSE);
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		waveartist_cmd1(chip, WACMD_OUTPUTRESUME);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int snd_waveartist_capture_hw_params(struct snd_pcm_substream *substream,
+					    struct snd_pcm_hw_params *hw_params)
+{
+	int err = snd_pcm_lib_malloc_pages(substream,
+					   params_buffer_bytes(hw_params));
+
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int snd_waveartist_capture_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_waveartist *chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned int size = snd_pcm_lib_buffer_bytes(substream);
+	unsigned int count = snd_pcm_lib_period_bytes(substream);
+
+	/* Set rate */
+	if (waveartist_cmd2(chip, WACMD_INPUTSPEED, waveartist_rate(runtime)))
+		dev_warn(chip->card->dev, "error setting capture rate %dHz\n",
+			 runtime->rate);
+	/* Set channel count */
+	if (waveartist_cmd2(chip, WACMD_INPUTCHANNELS, runtime->channels))
+		dev_warn(chip->card->dev, "error setting capture %d channels\n",
+			 runtime->channels);
+	/* Set DMA channel */
+	if (waveartist_cmd2(chip, WACMD_INPUTDMA,
+			    chip->dma_capture > 3 ? WA_DMA_16BIT : WA_DMA_8BIT))
+		dev_warn(chip->card->dev, "error setting capture data path\n");
+	/* Set format */
+	if (waveartist_cmd2(chip, WACMD_INPUTFORMAT,
+			    waveartist_format(runtime->format)))
+		dev_warn(chip->card->dev, "error setting capture format %d\n",
+			 runtime->format);
+	/* Set sample count */
+	if (waveartist_cmd2(chip, WACMD_INPUTSIZE, count - 1))
+		dev_warn(chip->card->dev, "error setting capture count %d\n",
+			 count);
+	/* Configure DMA controller */
+	snd_dma_program(chip->dma_capture, runtime->dma_addr, size,
+			DMA_MODE_READ | DMA_AUTOINIT);
+
+	return 0;
+}
+
+static int snd_waveartist_capture_trigger(struct snd_pcm_substream *substream,
+					  int cmd)
+{
+	struct snd_waveartist *chip = snd_pcm_substream_chip(substream);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		waveartist_cmd1(chip, WACMD_INPUTSTART);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		waveartist_cmd1(chip, WACMD_INPUTSTOP);
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		waveartist_cmd1(chip, WACMD_INPUTPAUSE);
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		waveartist_cmd1(chip, WACMD_INPUTRESUME);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static snd_pcm_uframes_t snd_waveartist_playback_pointer(
+					struct snd_pcm_substream *substream)
+{
+	struct snd_waveartist *chip = snd_pcm_substream_chip(substream);
+	size_t size = snd_pcm_lib_buffer_bytes(substream);
+	size_t ptr = snd_dma_pointer(chip->dma_playback, size);
+
+	return bytes_to_frames(substream->runtime, ptr);
+}
+
+static snd_pcm_uframes_t snd_waveartist_capture_pointer(
+					struct snd_pcm_substream *substream)
+{
+	struct snd_waveartist *chip = snd_pcm_substream_chip(substream);
+	size_t size = snd_pcm_lib_buffer_bytes(substream);
+	size_t ptr = snd_dma_pointer(chip->dma_capture, size);
+
+	return bytes_to_frames(substream->runtime, ptr);
+}
+
+static struct snd_pcm_hardware snd_waveartist_playback = {
+	.info =			SNDRV_PCM_INFO_MMAP |
+				SNDRV_PCM_INFO_INTERLEAVED |
+				SNDRV_PCM_INFO_PAUSE |
+				SNDRV_PCM_INFO_MMAP_VALID,
+	.formats =		SNDRV_PCM_FMTBIT_U8 |
+				SNDRV_PCM_FMTBIT_S8 |
+				SNDRV_PCM_FMTBIT_S16_LE,
+	.rates =		SNDRV_PCM_RATE_CONTINUOUS |
+				SNDRV_PCM_RATE_8000_44100,
+	.rate_min =		4000,
+	.rate_max =		44100,
+	.channels_min =		1,
+	.channels_max =		2,
+	.buffer_bytes_max =	(128*1024),
+	.period_bytes_min =	64,
+	.period_bytes_max =	(128*1024),
+	.periods_min =		1,
+	.periods_max =		1024,
+};
+
+static struct snd_pcm_hardware snd_waveartist_capture = {
+	.info =			SNDRV_PCM_INFO_MMAP |
+				SNDRV_PCM_INFO_INTERLEAVED |
+				SNDRV_PCM_INFO_PAUSE |
+				SNDRV_PCM_INFO_MMAP_VALID,
+	.formats =		SNDRV_PCM_FMTBIT_U8 |
+				SNDRV_PCM_FMTBIT_S8 |
+				SNDRV_PCM_FMTBIT_S16_LE,
+	.rates =		SNDRV_PCM_RATE_CONTINUOUS |
+				SNDRV_PCM_RATE_8000_44100,
+	.rate_min =		4000,
+	.rate_max =		44100,
+	.channels_min =		1,
+	.channels_max =		2,
+	.buffer_bytes_max =	(128*1024),
+	.period_bytes_min =	64,
+	.period_bytes_max =	(128*1024),
+	.periods_min =		1,
+	.periods_max =		1024,
+};
+
+static int snd_waveartist_playback_open(struct snd_pcm_substream *substream)
+{
+	struct snd_waveartist *chip = snd_pcm_substream_chip(substream);
+
+	chip->playback_substream = substream;
+	substream->runtime->hw = snd_waveartist_playback;
+
+	snd_pcm_limit_isa_dma_size(chip->dma_playback,
+				   &substream->runtime->hw.buffer_bytes_max);
+	snd_pcm_limit_isa_dma_size(chip->dma_playback,
+				   &substream->runtime->hw.period_bytes_max);
+
+	return 0;
+}
+
+static int snd_waveartist_capture_open(struct snd_pcm_substream *substream)
+{
+	struct snd_waveartist *chip = snd_pcm_substream_chip(substream);
+
+	chip->capture_substream = substream;
+	substream->runtime->hw = snd_waveartist_capture;
+
+	snd_pcm_limit_isa_dma_size(chip->dma_capture,
+				   &substream->runtime->hw.buffer_bytes_max);
+	snd_pcm_limit_isa_dma_size(chip->dma_capture,
+				   &substream->runtime->hw.period_bytes_max);
+
+	return 0;
+}
+
+static int snd_waveartist_playback_close(struct snd_pcm_substream *substream)
+{
+	struct snd_waveartist *chip = snd_pcm_substream_chip(substream);
+
+	chip->playback_substream = NULL;
+	snd_pcm_lib_free_pages(substream);
+
+	return 0;
+}
+
+static int snd_waveartist_capture_close(struct snd_pcm_substream *substream)
+{
+	struct snd_waveartist *chip = snd_pcm_substream_chip(substream);
+
+	chip->capture_substream = NULL;
+	snd_pcm_lib_free_pages(substream);
+
+	return 0;
+}
+
+static struct snd_pcm_ops snd_waveartist_playback_ops = {
+	.open =		snd_waveartist_playback_open,
+	.close =	snd_waveartist_playback_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_waveartist_playback_hw_params,
+	.hw_free =	snd_waveartist_pcm_hw_free,
+	.prepare =	snd_waveartist_playback_prepare,
+	.trigger =	snd_waveartist_playback_trigger,
+	.pointer =	snd_waveartist_playback_pointer,
+};
+
+static struct snd_pcm_ops snd_waveartist_capture_ops = {
+	.open =		snd_waveartist_capture_open,
+	.close =	snd_waveartist_capture_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_waveartist_capture_hw_params,
+	.hw_free =	snd_waveartist_pcm_hw_free,
+	.prepare =	snd_waveartist_capture_prepare,
+	.trigger =	snd_waveartist_capture_trigger,
+	.pointer =	snd_waveartist_capture_pointer,
+};
+
+static int snd_waveartist_pcm(struct snd_card *card)
+{
+	struct snd_waveartist *chip = card->private_data;
+	struct snd_pcm *pcm;
+	int err;
+
+	err = snd_pcm_new(card, "WaveArtist", 0, 1, 1, &pcm);
+	if (err < 0)
+		return err;
+
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+			&snd_waveartist_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
+			&snd_waveartist_capture_ops);
+
+	/* global setup */
+	pcm->private_data = chip;
+	pcm->info_flags = 0;
+	if (chip->dma_playback == chip->dma_capture)
+		pcm->info_flags |= SNDRV_PCM_INFO_HALF_DUPLEX;
+	strcpy(pcm->name, card->shortname);
+	chip->pcm = pcm;
+
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+		      snd_dma_isa_data(), 64 * 1024,
+		      chip->dma_playback > 3 || chip->dma_capture > 3 ?
+		      128 * 1024 : 64 * 1024);
+
+	return 0;
+}
+
+static void snd_waveartist_free(struct snd_card *card)
+{
+	struct snd_waveartist *chip = card->private_data;
+
+	release_and_free_resource(chip->res_port);
+	if (chip->irq >= 0)
+		free_irq(chip->irq, card);
+	if (chip->dma_playback >= 0) {
+		disable_dma(chip->dma_playback);
+		free_dma(chip->dma_playback);
+	}
+	if (chip->dma_capture >= 0 && chip->dma_capture != chip->dma_playback) {
+		disable_dma(chip->dma_capture);
+		free_dma(chip->dma_capture);
+	}
+}
+
+static int snd_waveartist_dev_free(struct snd_device *device)
+{
+	snd_waveartist_free(device->card);
+
+	return 0;
+}
+
+static int snd_waveartist_init(struct snd_waveartist *chip)
+{
+	if (waveartist_reset(chip))
+		return -ENODEV;
+	dev_dbg(chip->card->dev, "chip rev. 0x%x\n", waveartist_getrev(chip));
+
+	waveartist_cmd1(chip, WACMD_RST_MIXER);	/* reset mixer */
+	waveartist_iack(chip);	/* clear any pending interrupt */
+	waveartist_set_ctlr(chip, 0, DMA1_IE | DMA0_IE); /* enable DMA IRQs */
+	waveartist_iack(chip);	/* clear any pending interrupt */
+
+	return 0;
+}
+
+static int snd_waveartist_new_device(struct snd_card *card,
+				     unsigned long port,
+				     unsigned long mpu_port,
+				     unsigned long fm_port,
+				     int irq, int dma1, int dma2)
+{
+	struct snd_waveartist *chip = card->private_data;
+	static struct snd_device_ops ops = {
+		.dev_free =	snd_waveartist_dev_free,
+	};
+	int err;
+
+	spin_lock_init(&chip->reg_lock);
+	chip->card = card;
+	chip->port = port;
+	chip->irq = -1;
+	chip->dma_playback = -1;
+	chip->dma_capture = -1;
+
+	chip->res_port = request_region(port, 16, "WaveArtist");
+	if (!chip->res_port) {
+		snd_waveartist_free(card);
+		dev_err(chip->card->dev, "unable to grab ports 0x%lx-0x%lx\n",
+			port, port + 16 - 1);
+		return -EBUSY;
+	}
+
+	if (snd_waveartist_init(chip) < 0) {
+		snd_waveartist_free(card);
+		return -ENODEV;
+	}
+
+	if (request_irq(irq, snd_waveartist_interrupt, 0, "WaveArtist", card)) {
+		snd_waveartist_free(card);
+		dev_err(chip->card->dev, "unable to grab IRQ %d\n", irq);
+		return -EBUSY;
+	}
+	chip->irq = irq;
+
+	if (dma1 == dma2 || dma1 == SNDRV_AUTO_DMA || dma2 == SNDRV_AUTO_DMA) {
+		/* we have only one DMA channel */
+		if (dma1 == SNDRV_AUTO_DMA)
+			dma1 = dma2;
+		if (request_dma(dma1, "WaveArtist")) {
+			snd_waveartist_free(card);
+			dev_err(chip->card->dev, "unable to grab DMA %d\n",
+				dma1);
+			return -EBUSY;
+		}
+		chip->dma_playback = chip->dma_capture = dma1;
+	} else {
+		/*
+		 * 2 channels: use 16-bit for playback and 8-bit for capture as
+		 * full-duplex works better this way. However, the chip seems to
+		 * have some band-width limit so full-duplex at 44kHz/16-bit/2ch
+		 * is not possible - some frames are dropped during capture,
+		 * resulting in too-fast recording. If capture is done using
+		 * lower rate or 8-bit or mono, everything is fine.
+		 */
+		if (dma2 > 3)
+			swap(dma1, dma2);
+
+		if (request_dma(dma1, "WaveArtist playback")) {
+			snd_waveartist_free(card);
+			dev_err(chip->card->dev, "unable to grab playback DMA %d\n",
+				dma1);
+			return -EBUSY;
+		}
+		chip->dma_playback = dma1;
+
+		if (dma2 != dma1 && request_dma(dma2, "WaveArtist capture")) {
+			snd_waveartist_free(card);
+			dev_err(chip->card->dev, "unable to grab capture DMA %d\n",
+				dma2);
+			return -EBUSY;
+		}
+		chip->dma_capture = dma2;
+	}
+
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0) {
+		snd_waveartist_free(card);
+		return err;
+	}
+
+	return 0;
+}
+
+static int snd_waveartist_card_new(struct device *pdev, int dev,
+				struct snd_card **cardp)
+{
+	return snd_card_new(pdev, index[dev], id[dev], THIS_MODULE,
+			    sizeof(struct snd_waveartist), cardp);
+}
+
+static int snd_waveartist_info_single(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_info *uinfo)
+{
+	int mask = (kcontrol->private_value >> 16) & 0xff;
+
+	uinfo->type = mask == 1 ? SNDRV_CTL_ELEM_TYPE_BOOLEAN :
+				  SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = mask;
+
+	return 0;
+}
+
+static int snd_waveartist_get_single(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_waveartist *chip = snd_kcontrol_chip(kcontrol);
+	int reg = kcontrol->private_value & 0xff;
+	int shift = (kcontrol->private_value >> 8) & 0xff;
+	int mask = (kcontrol->private_value >> 16) & 0xff;
+	u16 val;
+
+	val = waveartist_cmd1_r(chip, WACMD_GET_LEVEL | reg << 8);
+	ucontrol->value.integer.value[0] = (val >> shift) & mask;
+
+	return 0;
+}
+
+static int snd_waveartist_put_single(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_waveartist *chip = snd_kcontrol_chip(kcontrol);
+	int reg = kcontrol->private_value & 0xff;
+	int shift = (kcontrol->private_value >> 8) & 0xff;
+	int mask = (kcontrol->private_value >> 16) & 0xff;
+	u16 val, old_val, new_val;
+
+	val = (ucontrol->value.integer.value[0] & mask);
+	mask <<= shift;
+	val <<= shift;
+
+	old_val = waveartist_cmd1_r(chip, WACMD_GET_LEVEL | reg << 8);
+	new_val = (old_val & ~mask) | (val & mask);
+
+	if (new_val == old_val)
+		return 0;
+
+	/* new_val already contains register number (bits 12..15), bit 11 set */
+	waveartist_cmd3(chip, WACMD_SET_MIXER, new_val, new_val);
+
+	return 1;
+}
+
+static int snd_waveartist_info_double(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_info *uinfo)
+{
+	int mask = (kcontrol->private_value >> 24) & 0xff;
+
+	uinfo->type = mask == 1 ? SNDRV_CTL_ELEM_TYPE_BOOLEAN :
+				  SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = mask ? mask : 0x7fff;
+
+	return 0;
+}
+
+static int snd_waveartist_get_double(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_waveartist *chip = snd_kcontrol_chip(kcontrol);
+	int left_reg = kcontrol->private_value & 0xff;
+	int right_reg = (kcontrol->private_value >> 8) & 0xff;
+	int shift_left = (kcontrol->private_value >> 16) & 0x0f;
+	int shift_right = (kcontrol->private_value >> 20) & 0x0f;
+	int mask = (kcontrol->private_value >> 24) & 0xff;
+	u16 left, right;
+
+	if (mask == 0)
+		mask = 0x7fff;
+
+	left = waveartist_cmd1_r(chip, WACMD_GET_LEVEL | left_reg << 8);
+	if (left_reg != right_reg)
+		right = waveartist_cmd1_r(chip, WACMD_GET_LEVEL |
+						right_reg << 8);
+	else
+		right = left;
+
+	ucontrol->value.integer.value[0] = (left >> shift_left) & mask;
+	ucontrol->value.integer.value[1] = (right >> shift_right) & mask;
+
+	return 0;
+}
+
+static int snd_waveartist_put_double(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_waveartist *chip = snd_kcontrol_chip(kcontrol);
+	int left_reg = kcontrol->private_value & 0xff;
+	int right_reg = (kcontrol->private_value >> 8) & 0xff;
+	int shift_left = (kcontrol->private_value >> 16) & 0x0f;
+	int shift_right = (kcontrol->private_value >> 20) & 0x0f;
+	int mask = (kcontrol->private_value >> 24) & 0xff;
+	u16 val1, val2, mask1, mask2;
+	u16 old_left, old_right, new_left, new_right;
+
+	if (mask == 0)
+		mask = 0x7fff;
+
+	val1 = ucontrol->value.integer.value[0] & mask;
+	val2 = ucontrol->value.integer.value[1] & mask;
+	val1 <<= shift_left;
+	val2 <<= shift_right;
+	mask1 = mask << shift_left;
+	mask2 = mask << shift_right;
+
+	old_left = waveartist_cmd1_r(chip, WACMD_GET_LEVEL | left_reg << 8);
+	if (left_reg != right_reg)
+		old_right = waveartist_cmd1_r(chip, WACMD_GET_LEVEL |
+						    right_reg << 8);
+	else
+		old_right = old_left;
+
+	new_left = (old_left & ~mask1) | (val1 & mask1);
+	new_right = (old_right & ~mask2) | (val2 & mask2);
+
+	if (new_left == old_left && new_right == old_right)
+		return 0;
+
+	if (left_reg < 10)
+		/* new_* already contain reg. num. (bits 12..15), bit 11 set */
+		waveartist_cmd3(chip, WACMD_SET_MIXER, new_left, new_right);
+	else
+		waveartist_cmd3(chip, WACMD_SET_LEVEL |
+				      ((left_reg - 10) / 2) << 8,
+				      new_left, new_right);
+
+	return 1;
+}
+
+static int snd_waveartist_info_mux(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_info *uinfo)
+{
+	static const char * const mux_texts[] = {
+		"None", "Mix", "Line", "Phone", "CD", "Mic"
+	};
+
+	return snd_ctl_enum_info(uinfo, 2, ARRAY_SIZE(mux_texts), mux_texts);
+}
+
+static int snd_waveartist_get_mux(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_waveartist *chip = snd_kcontrol_chip(kcontrol);
+	int mux = waveartist_cmd1_r(chip, WACMD_GET_LEVEL | 0x08 << 8);
+
+	ucontrol->value.enumerated.item[0] = mux & 0x07;
+	ucontrol->value.enumerated.item[1] = (mux >> 3) & 0x07;
+
+	return 0;
+}
+
+static int snd_waveartist_put_mux(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_waveartist *chip = snd_kcontrol_chip(kcontrol);
+	u16 old_val, new_val;
+	u16 val1 = ucontrol->value.enumerated.item[0];
+	u16 val2 = ucontrol->value.enumerated.item[1];
+
+	old_val = waveartist_cmd1_r(chip, WACMD_GET_LEVEL | 0x08 << 8);
+	new_val = (old_val & ~0x3f) | (val1 & 0x07) | ((val2 & 0x07) << 3);
+	if (new_val == old_val)
+		return 0;
+
+	/* new_val already contains register number (bits 12..15), bit 11 set */
+	waveartist_cmd3(chip, WACMD_SET_MIXER, new_val, new_val);
+
+	return 1;
+}
+
+#define WAVEARTIST_SINGLE(xname, reg, shift, mask) \
+{ \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_waveartist_info_single, \
+	.get = snd_waveartist_get_single, .put = snd_waveartist_put_single, \
+	.private_value = reg | (shift << 8) | (mask << 16) \
+}
+
+#define WAVEARTIST_DOUBLE(xname, left_reg, right_reg, shift_left, shift_right, \
+			  mask) \
+{ \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_waveartist_info_double, \
+	.get = snd_waveartist_get_double, .put = snd_waveartist_put_double, \
+	.private_value = left_reg | (right_reg << 8) | (shift_left << 16) | \
+			 (shift_right << 20) | (mask << 24) \
+}
+
+static struct snd_kcontrol_new snd_waveartist_controls[] = {
+WAVEARTIST_DOUBLE("Master Playback Volume", 2, 6, 1, 1, 0x07),
+WAVEARTIST_DOUBLE("Master Playback Switch", 0, 4, 0, 0, 1),
+WAVEARTIST_DOUBLE("PCM Playback Volume", 10, 11, 0, 0, 0x00),/* 0x00 = 0x7fff */
+WAVEARTIST_DOUBLE("FM Playback Volume", 12, 13, 0, 0, 0x00),/* 0x00 = 0x7fff */
+/* WAVEARTIST_DOUBLE("Wavetable? Playback Volume", 14, 15, 0, 0, 0x00), */
+/* WAVEARTIST_DOUBLE("? Playback Volume", 16, 17, 0, 0, 0x00), */
+/* WAVEARTIST_DOUBLE("? Playback Volume", 18, 19, 0, 0, 0x00), */
+WAVEARTIST_DOUBLE("Digital Playback Switch", 3, 7, 10, 10, 1), /* PCM + FM */
+WAVEARTIST_DOUBLE("CD Playback Volume", 0, 4, 1, 1, 0x1f),
+WAVEARTIST_DOUBLE("CD Playback Switch", 3, 7, 6, 6, 1),
+WAVEARTIST_DOUBLE("Line Playback Volume", 0, 4, 6, 6, 0x1f),
+WAVEARTIST_DOUBLE("Line Playback Switch", 3, 7, 4, 4, 1),
+WAVEARTIST_DOUBLE("Phone Playback Volume", 1, 5, 6, 6, 0x1f),
+WAVEARTIST_DOUBLE("Phone Playback Switch", 3, 7, 5, 5, 1),
+WAVEARTIST_SINGLE("Mono Playback Volume", 8, 5, 0x1f),
+WAVEARTIST_DOUBLE("Mono Playback Switch", 3, 7, 9, 9, 1),
+WAVEARTIST_DOUBLE("Mic Playback Volume", 2, 6, 6, 6, 0x1f),
+WAVEARTIST_DOUBLE("Mic 2 Playback Volume", 1, 5, 1, 1, 0x1f),
+WAVEARTIST_DOUBLE("Mic Playback Switch", 3, 7, 7, 7, 1),
+WAVEARTIST_DOUBLE("Mic 2 Playback Switch", 3, 7, 8, 8, 1),
+WAVEARTIST_DOUBLE("Mic Gain", 2, 6, 4, 4, 0x03),
+WAVEARTIST_DOUBLE("Capture Volume", 3, 7, 0, 0, 0x0f),
+WAVEARTIST_SINGLE("Mono Output Playback Switch", 1, 0, 1),
+{
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Capture Source",
+	.info = snd_waveartist_info_mux,
+	.get = snd_waveartist_get_mux,
+	.put = snd_waveartist_put_mux,
+}
+};
+
+static int snd_waveartist_mixer(struct snd_card *card)
+{
+	struct snd_waveartist *chip = card->private_data;
+	int err;
+	unsigned int idx;
+
+	strcpy(card->mixername, chip->pcm->name);
+
+	for (idx = 0; idx < ARRAY_SIZE(snd_waveartist_controls); idx++) {
+		struct snd_kcontrol *kctl;
+
+		kctl = snd_ctl_new1(&snd_waveartist_controls[idx], chip);
+		err = snd_ctl_add(card, kctl);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static int snd_waveartist_probe(struct snd_card *card, int dev)
+{
+	struct snd_waveartist *chip = card->private_data;
+	struct snd_opl3 *opl3;
+	int err;
+
+	err = snd_waveartist_new_device(card,
+					port[dev], midi_port[dev], fm_port[dev],
+					irq[dev], dma1[dev], dma2[dev]);
+	if (err < 0)
+		return err;
+
+	strcpy(card->driver, "WaveArtist");
+	strcpy(card->shortname, "Rockwell WaveArtist RWA010");
+	sprintf(card->longname, "%s at 0x%lx, irq %d, dma1 %d, dma2 %d",
+		card->shortname, chip->port, irq[dev], dma1[dev], dma2[dev]);
+
+	err = snd_waveartist_pcm(card);
+	if (err < 0)
+		return err;
+	err = snd_waveartist_mixer(card);
+	if (err < 0)
+		return err;
+
+	if (fm_port[dev] >= 0x388 && fm_port[dev] < 0x3f0) {
+		err = snd_opl3_create(card, fm_port[dev], fm_port[dev] + 2,
+				      OPL3_HW_OPL3, 0, &opl3);
+		if (err < 0)
+			return err;
+		err = snd_opl3_timer_new(opl3, 1, 2);
+		if (err < 0)
+			return err;
+		err = snd_opl3_hwdep_new(opl3, 0, 1, &chip->synth);
+		if (err < 0)
+			return err;
+	}
+	if (midi_port[dev] >= 0x300 && midi_port[dev] < 0x3f0) {
+		err = snd_mpu401_uart_new(card, 0, MPU401_HW_WAVEARTIST,
+					  midi_port[dev], MPU401_INFO_IRQ_HOOK,
+					  -1, &chip->rmidi);
+		if (err < 0)
+			return err;
+	}
+
+	return snd_card_register(card);
+}
+
+static int snd_waveartist_isa_match(struct device *pdev,
+				    unsigned int dev)
+{
+	if (!enable[dev])
+		return 0;
+#ifdef CONFIG_PNP
+	if (isapnp[dev])
+		return 0;
+#endif
+	if (port[dev] == SNDRV_AUTO_PORT) {
+		dev_err(pdev, "specify port\n");
+		return 0;
+	}
+	if (irq[dev] == SNDRV_AUTO_IRQ) {
+		dev_err(pdev, "specify irq\n");
+		return 0;
+	}
+	if (dma1[dev] == SNDRV_AUTO_DMA) {
+		dev_err(pdev, "specify dma1\n");
+		return 0;
+	}
+
+	return 1;
+}
+
+static int snd_waveartist_isa_probe(struct device *pdev,
+				    unsigned int dev)
+{
+	struct snd_card *card;
+	int err;
+
+	err = snd_waveartist_card_new(pdev, dev, &card);
+	if (err < 0)
+		return err;
+	err = snd_waveartist_probe(card, dev);
+	if (err < 0) {
+		snd_card_free(card);
+		return err;
+	}
+	dev_set_drvdata(pdev, card);
+
+	return 0;
+}
+
+static int snd_waveartist_isa_remove(struct device *devptr,
+				     unsigned int dev)
+{
+	snd_card_free(dev_get_drvdata(devptr));
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int snd_waveartist_isa_suspend(struct device *dev, unsigned int n,
+				      pm_message_t state)
+{
+	return snd_waveartist_suspend(dev_get_drvdata(dev), state);
+}
+
+static int snd_waveartist_isa_resume(struct device *dev, unsigned int n)
+{
+	return snd_waveartist_resume(dev_get_drvdata(dev));
+}
+#endif
+
+static struct isa_driver waveartist_isa_driver = {
+	.match		= snd_waveartist_isa_match,
+	.probe		= snd_waveartist_isa_probe,
+	.remove		= snd_waveartist_isa_remove,
+#ifdef CONFIG_PM
+	.suspend	= snd_waveartist_isa_suspend,
+	.resume		= snd_waveartist_isa_resume,
+#endif
+	.driver		= { .name = "waveartist" },
+};
+
+#ifdef CONFIG_PNP
+static int snd_waveartist_pnp_detect(struct pnp_card_link *pcard,
+				     const struct pnp_card_device_id *pid)
+{
+	static int dev;
+	int err;
+	struct snd_card *card;
+
+	for (; dev < SNDRV_CARDS; dev++) {
+		if (enable[dev] && isapnp[dev])
+			break;
+	}
+	if (dev >= SNDRV_CARDS)
+		return -ENODEV;
+
+	err = snd_waveartist_card_new(&pcard->card->dev, dev, &card);
+	if (err < 0)
+		return err;
+	err = snd_waveartist_pnp(dev, card->private_data, pcard, pid);
+	if (err < 0) {
+		dev_err(&pcard->card->dev, "PnP detection failed\n");
+		snd_card_free(card);
+		return err;
+	}
+	err = snd_waveartist_probe(card, dev);
+	if (err < 0) {
+		snd_card_free(card);
+		return err;
+	}
+	pnp_set_card_drvdata(pcard, card);
+	dev++;
+
+	return 0;
+}
+
+static void snd_waveartist_pnp_remove(struct pnp_card_link *pcard)
+{
+	struct snd_card *card = pnp_get_card_drvdata(pcard);
+	struct snd_waveartist *chip = card->private_data;
+
+	/* disable forced IRQs */
+	snd_waveartist_set_irq(chip->wa, 0);
+	snd_waveartist_set_irq(chip->mpu, 0);
+
+	snd_card_free(pnp_get_card_drvdata(pcard));
+	pnp_set_card_drvdata(pcard, NULL);
+}
+
+#ifdef CONFIG_PM
+static int snd_waveartist_pnp_suspend(struct pnp_card_link *pcard,
+				      pm_message_t state)
+{
+	struct snd_card *card = pnp_get_card_drvdata(pcard);
+	struct snd_waveartist *chip = card->private_data;
+
+	snd_waveartist_suspend(card, state);
+
+	/* disable forced IRQs to prevent opps */
+	snd_waveartist_set_irq(chip->wa, 0);
+	snd_waveartist_set_irq(chip->mpu, 0);
+
+	return 0;
+}
+static int snd_waveartist_pnp_resume(struct pnp_card_link *pcard)
+{
+	struct snd_card *card = pnp_get_card_drvdata(pcard);
+	struct snd_waveartist *chip = card->private_data;
+
+	/* re-enable forced IRQs */
+	snd_waveartist_set_irq(chip->wa, chip->irq);
+	snd_waveartist_set_irq(chip->mpu, chip->irq);
+
+	return snd_waveartist_resume(pnp_get_card_drvdata(pcard));
+}
+#endif
+
+static struct pnp_card_driver waveartist_pnpc_driver = {
+	.flags		= PNP_DRIVER_RES_DISABLE,
+	.name		= "waveartist",
+	.id_table	= snd_waveartist_pnpids,
+	.probe		= snd_waveartist_pnp_detect,
+	.remove		= snd_waveartist_pnp_remove,
+#ifdef CONFIG_PM
+	.suspend	= snd_waveartist_pnp_suspend,
+	.resume		= snd_waveartist_pnp_resume,
+#endif
+};
+#endif /* CONFIG_PNP */
+
+static int __init alsa_card_waveartist_init(void)
+{
+	int err;
+
+	err = isa_register_driver(&waveartist_isa_driver, SNDRV_CARDS);
+#ifdef CONFIG_PNP
+	if (!err)
+		isa_registered = 1;
+
+	err = pnp_register_card_driver(&waveartist_pnpc_driver);
+	if (!err)
+		pnp_registered = 1;
+
+	if (isa_registered)
+		err = 0;
+#endif
+	return err;
+}
+
+static void __exit alsa_card_waveartist_exit(void)
+{
+#ifdef CONFIG_PNP
+	if (pnp_registered)
+		pnp_unregister_card_driver(&waveartist_pnpc_driver);
+
+	if (isa_registered)
+#endif
+		isa_unregister_driver(&waveartist_isa_driver);
+}
+
+module_init(alsa_card_waveartist_init)
+module_exit(alsa_card_waveartist_exit)
diff --git a/sound/isa/waveartist.h b/sound/isa/waveartist.h
new file mode 100644
index 0000000..72254cf
--- /dev/null
+++ b/sound/isa/waveartist.h
@@ -0,0 +1,74 @@
+/*
+ *  Rockwell WaveArtist RWA010 chip register definitions
+ *
+ *  Based on OSS WaveArtist driver by Hannu Savolainen
+ */
+
+/* registers */
+#define CMDR	0	/* command (16-bit) */
+#define DATR	2	/* data (for PIO?) (16-bit) */
+#define CTLR	4	/* control */
+#define	STATR	5	/* status */
+#define EXPCR1	6	/* expansion control 1 */
+#define EXPCR2	7	/* expansion control 2 */
+#define EXPDAT1 8	/* expansion data 1 (16-bit) */
+#define EXPDAT2 10	/* expansion data 2 (16-bit) */
+#define	IRQSTAT	12	/* IRQ status */
+
+/* STATR register bit definitions */
+#define	CMD_WE	BIT(7)	/* CMDR write empty (ready for write) */
+#define	CMD_RF	BIT(6)	/* CMDR read full (ready for read) */
+#define	DAT_WE	BIT(5)	/* DATR write empty (ready for write) */
+#define	DAT_RF	BIT(4)	/* DATR read full (ready for read) */
+#define	IRQ_REQ	BIT(3)	/* IRQ was requested */
+#define	DMA1	BIT(2)	/* DMA1 IRQ was requested */
+#define	DMA0	BIT(1)	/* DMA0 IRQ was requested */
+
+/* CTLR register bit definitions */
+#define	CMD_WEIE	BIT(7)	/* CMDR write empty interrupt enable */
+#define	CMD_RFIE	BIT(6)	/* CMDR read full interrupt enable */
+#define	DAT_WEIE	BIT(5)	/* DATR write empty interrupt enable */
+#define	DAT_RFIE	BIT(4)	/* DATR read full interrupt enable */
+#define	RESET		BIT(3)	/* chip reset */
+#define	DMA1_IE		BIT(2)	/* DMA1 interrupt enable */
+#define	DMA0_IE		BIT(1)	/* DMA0 interrupt enable */
+#define	IRQ_ACK		BIT(0)	/* IRQ acknowlege */
+
+/* IRQSTAT register bit definitions */
+#define IRQ_MPU		BIT(2)	/* MPU-401 */
+#define IRQ_SB		BIT(1)	/* SB emulation */
+#define IRQ_PCM		BIT(0)	/* native PCM */
+
+/* commands */
+#define WACMD_GETREV		0x00
+
+#define	WACMD_INPUTFORMAT	0x10	/* 0=S8, 1=S16, 2=U8 */
+#define	WACMD_INPUTCHANNELS	0x11	/* 1=mono, 2=Stereo */
+#define	WACMD_INPUTSPEED	0x12	/* sampling rate */
+#define	WACMD_INPUTDMA		0x13	/* 0=8bit, 1=16bit, 2=PIO */
+#define	WACMD_INPUTSIZE		0x14	/* samples to interrupt */
+#define	WACMD_INPUTSTART	0x15	/* start ADC */
+#define	WACMD_INPUTPAUSE	0x16	/* pause ADC */
+#define	WACMD_INPUTSTOP		0x17	/* stop ADC */
+#define	WACMD_INPUTRESUME	0x18	/* resume ADC */
+#define	WACMD_INPUTPIO		0x19	/* PIO ADC */
+
+#define	WACMD_OUTPUTFORMAT	0x20	/* 0=S8, 1=S16, 2=U8 */
+#define	WACMD_OUTPUTCHANNELS	0x21	/* 1=mono, 2=stereo */
+#define	WACMD_OUTPUTSPEED	0x22	/* sampling rate */
+#define	WACMD_OUTPUTDMA		0x23	/* 0=8bit, 1=16bit, 2=PIO */
+#define	WACMD_OUTPUTSIZE	0x24	/* samples to interrupt */
+#define	WACMD_OUTPUTSTART	0x25	/* start DAC */
+#define	WACMD_OUTPUTPAUSE	0x26	/* pause DAC */
+#define	WACMD_OUTPUTSTOP	0x27	/* stop DAC */
+#define	WACMD_OUTPUTRESUME	0x28	/* resume DAC */
+#define	WACMD_OUTPUTPIO		0x29	/* PIO DAC */
+
+#define	WACMD_GET_LEVEL		0x30	/* read mixer reg */
+#define	WACMD_SET_LEVEL		0x31	/* set mixer regs (10..19) */
+#define	WACMD_SET_MIXER		0x32	/* set mixer regs (0..9) */
+#define	WACMD_RST_MIXER		0x33	/* mixer reset */
+#define	WACMD_SET_MONO		0x34	/* set mono mode (|0x000=L, |0x100=R) */
+
+enum wa_format { WA_FMT_S8 = 0, WA_FMT_S16, WA_FMT_U8 };
+enum wa_dma { WA_DMA_8BIT = 0, WA_DMA_16BIT, WA_DMA_PIO };
-- 
Ondrej Zary
