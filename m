From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] jazz16: Add support for Media Vision Jazz16
	chipset
Date: Sun, 20 Dec 2009 19:01:50 +0100
Message-ID: <20091220190150.933d18c1.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id F0AC710380D
	for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2009 18:59:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This is one of Sound Blaster Pro compatible chipsets which is supported
by Linux OSS driver and was missing native supoort for ALSA.

The Jazz16 audio codec is Crystal CS4216 which is capable
of playback and recording up to 48 kHz stereo.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 include/sound/sb.h       |    1 +
 sound/isa/Kconfig        |   16 ++
 sound/isa/sb/Makefile    |    2 +
 sound/isa/sb/jazz16.c    |  385 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/isa/sb/sb8_main.c  |  117 ++++++++++++--
 sound/isa/sb/sb_common.c |    3 +
 sound/isa/sb/sb_mixer.c  |    3 +
 7 files changed, 511 insertions(+), 16 deletions(-)
 create mode 100644 sound/isa/sb/jazz16.c

diff --git a/include/sound/sb.h b/include/sound/sb.h
index 4e62ee1..9535354 100644
--- a/include/sound/sb.h
+++ b/include/sound/sb.h
@@ -33,6 +33,7 @@ enum sb_hw_type {
 	SB_HW_20,
 	SB_HW_201,
 	SB_HW_PRO,
+	SB_HW_JAZZ16,		/* Media Vision Jazz16 */
 	SB_HW_16,
 	SB_HW_16CSP,		/* SB16 with CSP chip */
 	SB_HW_ALS100,		/* Avance Logic ALS100 chip */
diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index 8ebd070..2024d3e 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -239,6 +239,22 @@ config SND_INTERWAVE_STB
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-interwave-stb.
 
+config SND_JAZZ16
+	tristate "Media Vision Jazz16 card and compatibles"
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	select SND_SB8_DSP
+	help
+	  Say Y here to include support for soundcards based on the
+	  Media Vision Jazz16 chipset: digital chip MVD1216 (Jazz16),
+	  codec MVA416 (CS4216) and mixer MVA514 (ICS2514).
+	  Media Vision's Jazz16 cards were sold under names Pro Sonic 16,
+	  Premium 3-D and Pro 3-D. There were also OEMs cards with the
+	  Jazz16 chipset.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-jazz16.
+
 config SND_OPL3SA2
 	tristate "Yamaha OPL3-SA2/SA3"
 	select SND_OPL3_LIB
diff --git a/sound/isa/sb/Makefile b/sound/isa/sb/Makefile
index faeffce..af36696 100644
--- a/sound/isa/sb/Makefile
+++ b/sound/isa/sb/Makefile
@@ -12,6 +12,7 @@ snd-sb16-objs := sb16.o
 snd-sbawe-objs := sbawe.o emu8000.o
 snd-emu8000-synth-objs := emu8000_synth.o emu8000_callback.o emu8000_patch.o emu8000_pcm.o
 snd-es968-objs := es968.o
+snd-jazz16-objs := jazz16.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_SB_COMMON) += snd-sb-common.o
@@ -21,6 +22,7 @@ obj-$(CONFIG_SND_SB8) += snd-sb8.o
 obj-$(CONFIG_SND_SB16) += snd-sb16.o
 obj-$(CONFIG_SND_SBAWE) += snd-sbawe.o
 obj-$(CONFIG_SND_ES968) += snd-es968.o
+obj-$(CONFIG_SND_JAZZ16) += snd-jazz16.o
 ifeq ($(CONFIG_SND_SB16_CSP),y)
   obj-$(CONFIG_SND_SB16) += snd-sb16-csp.o
   obj-$(CONFIG_SND_SBAWE) += snd-sb16-csp.o
diff --git a/sound/isa/sb/jazz16.c b/sound/isa/sb/jazz16.c
new file mode 100644
index 0000000..d52966b
--- /dev/null
+++ b/sound/isa/sb/jazz16.c
@@ -0,0 +1,385 @@
+
+/*
+ * jazz16.c - driver for Media Vision Jazz16 based soundcards.
+ * Copyright (C) 2009 Krzysztof Helt <krzysztof.h1@wp.pl>
+ * Based on patches posted by Rask Ingemann Lambertsen and Rene Herman.
+ * Based on OSS Sound Blaster driver.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive for
+ * more details.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <asm/dma.h>
+#include <linux/isa.h>
+#include <sound/core.h>
+#include <sound/mpu401.h>
+#include <sound/opl3.h>
+#include <sound/sb.h>
+#define SNDRV_LEGACY_FIND_FREE_IRQ
+#define SNDRV_LEGACY_FIND_FREE_DMA
+#include <sound/initval.h>
+
+#define PFX "jazz16: "
+
+MODULE_DESCRIPTION("Media Vision Jazz16");
+MODULE_SUPPORTED_DEVICE("{{Media Vision ??? },"
+		"{RTL,RTL3000}}");
+
+MODULE_AUTHOR("Krzysztof Helt <krzysztof.h1@wp.pl>");
+MODULE_LICENSE("GPL");
+
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;	/* Enable this card */
+static unsigned long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
+static unsigned long mpu_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
+static int irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;
+static int mpu_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;
+static int dma8[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;
+static int dma16[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;
+
+module_param_array(index, int, NULL, 0444);
+MODULE_PARM_DESC(index, "Index value for Media Vision Jazz16 based soundcard.");
+module_param_array(id, charp, NULL, 0444);
+MODULE_PARM_DESC(id, "ID string for Media Vision Jazz16 based soundcard.");
+module_param_array(enable, bool, NULL, 0444);
+MODULE_PARM_DESC(enable, "Enable Media Vision Jazz16 based soundcard.");
+module_param_array(port, long, NULL, 0444);
+MODULE_PARM_DESC(port, "Port # for jazz16 driver.");
+module_param_array(mpu_port, long, NULL, 0444);
+MODULE_PARM_DESC(mpu_port, "MPU-401 port # for jazz16 driver.");
+module_param_array(irq, int, NULL, 0444);
+MODULE_PARM_DESC(irq, "IRQ # for jazz16 driver.");
+module_param_array(mpu_irq, int, NULL, 0444);
+MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for jazz16 driver.");
+module_param_array(dma8, int, NULL, 0444);
+MODULE_PARM_DESC(dma8, "DMA8 # for jazz16 driver.");
+module_param_array(dma16, int, NULL, 0444);
+MODULE_PARM_DESC(dma16, "DMA16 # for jazz16 driver.");
+
+#define SB_JAZZ16_WAKEUP	0xaf
+#define SB_JAZZ16_SET_PORTS	0x50
+#define SB_DSP_GET_JAZZ_BRD_REV	0xfa
+#define SB_JAZZ16_SET_DMAINTR	0xfb
+#define SB_DSP_GET_JAZZ_MODEL	0xfe
+
+struct snd_card_jazz16 {
+	struct snd_sb *chip;
+};
+
+static irqreturn_t jazz16_interrupt(int irq, void *chip)
+{
+	return snd_sb8dsp_interrupt(chip);
+}
+
+static int __devinit jazz16_configure_ports(unsigned long port,
+					    unsigned long mpu_port, int idx)
+{
+	unsigned char val;
+
+	if (!request_region(0x201, 1, "jazz16 config")) {
+		snd_printk(KERN_ERR "config port region is already in use.\n");
+		return -EBUSY;
+	}
+	outb(SB_JAZZ16_WAKEUP - idx, 0x201);
+	udelay(100);
+	outb(SB_JAZZ16_SET_PORTS + idx, 0x201);
+	udelay(100);
+	val = port & 0x70;
+	val |= (mpu_port & 0x30) >> 4;
+	outb(val, 0x201);
+
+	release_region(0x201, 1);
+	return 0;
+}
+
+static int __devinit jazz16_detect_board(unsigned long port,
+					 unsigned long mpu_port)
+{
+	int err;
+	int val;
+	struct snd_sb chip;
+
+	if (!request_region(port, 0x10, "jazz16")) {
+		snd_printk(KERN_ERR "I/O port region is already in use.\n");
+		return -EBUSY;
+	}
+	/* just to call snd_sbdsp_command/reset/get_byte() */
+	chip.port = port;
+
+	err = snd_sbdsp_reset(&chip);
+	if (err < 0)
+		for (val = 0; val < 4; val++) {
+			err = jazz16_configure_ports(port, mpu_port, val);
+			if (err < 0)
+				break;
+
+			err = snd_sbdsp_reset(&chip);
+			if (!err)
+				break;
+		}
+	if (err < 0) {
+		err = -ENODEV;
+		goto err_unmap;
+	}
+	if (!snd_sbdsp_command(&chip, SB_DSP_GET_JAZZ_BRD_REV)) {
+		err = -EBUSY;
+		goto err_unmap;
+	}
+	val = snd_sbdsp_get_byte(&chip);
+	if (val >= 0x30)
+		snd_sbdsp_get_byte(&chip);
+
+	if ((val & 0xf0) != 0x10) {
+		err = -ENODEV;
+		goto err_unmap;
+	}
+	if (!snd_sbdsp_command(&chip, SB_DSP_GET_JAZZ_MODEL)) {
+		err = -EBUSY;
+		goto err_unmap;
+	}
+	snd_sbdsp_get_byte(&chip);
+	err = snd_sbdsp_get_byte(&chip);
+	snd_printd("Media Vision Jazz16 board detected: rev 0x%x, model 0x%x\n",
+		   val, err);
+
+	err = 0;
+
+err_unmap:
+	release_region(port, 0x10);
+	return err;
+}
+
+static int __devinit jazz16_configure_board(struct snd_sb *chip, int mpu_irq)
+{
+	static unsigned char jazz_irq_bits[] = { 0, 0, 2, 3, 0, 1, 0, 4,
+						 0, 2, 5, 0, 0, 0, 0, 6 };
+	static unsigned char jazz_dma_bits[] = { 0, 1, 0, 2, 0, 3, 0, 4 };
+
+	if (jazz_dma_bits[chip->dma8] == 0 ||
+	    jazz_dma_bits[chip->dma16] == 0 ||
+	    jazz_irq_bits[chip->irq] == 0)
+		return -EINVAL;
+
+	if (!snd_sbdsp_command(chip, SB_JAZZ16_SET_DMAINTR))
+		return -EBUSY;
+
+	if (!snd_sbdsp_command(chip,
+			       jazz_dma_bits[chip->dma8] |
+			       (jazz_dma_bits[chip->dma16] << 4)))
+		return -EBUSY;
+
+	if (!snd_sbdsp_command(chip,
+			       jazz_irq_bits[chip->irq] |
+			       (jazz_irq_bits[mpu_irq] << 4)))
+		return -EBUSY;
+
+	return 0;
+}
+
+static int __devinit snd_jazz16_match(struct device *devptr, unsigned int dev)
+{
+	if (!enable[dev])
+		return 0;
+	if (port[dev] == SNDRV_AUTO_PORT) {
+		snd_printk(KERN_ERR "please specify port\n");
+		return 0;
+	}
+	if (dma16[dev] != SNDRV_AUTO_DMA &&
+	    dma16[dev] != 5 && dma16[dev] != 7) {
+		snd_printk(KERN_ERR "dma16 must be 5 or 7");
+		return 0;
+	}
+	return 1;
+}
+
+static int __devinit snd_jazz16_probe(struct device *devptr, unsigned int dev)
+{
+	struct snd_card *card;
+	struct snd_card_jazz16 *jazz16;
+	struct snd_sb *chip;
+	struct snd_opl3 *opl3;
+	static int possible_irqs[] = {2, 3, 5, 7, 9, 10, 15, -1};
+	static int possible_dmas8[] = {1, 3, -1};
+	static int possible_dmas16[] = {5, 7, -1};
+	int err, xirq, xdma8, xdma16, xmpu_port, xmpu_irq;
+
+	err = snd_card_create(index[dev], id[dev], THIS_MODULE,
+			      sizeof(struct snd_card_jazz16), &card);
+	if (err < 0)
+		return err;
+
+	jazz16 = card->private_data;
+
+	xirq = irq[dev];
+	if (xirq == SNDRV_AUTO_IRQ) {
+		xirq = snd_legacy_find_free_irq(possible_irqs);
+		if (xirq < 0) {
+			snd_printk(KERN_ERR "unable to find a free IRQ\n");
+			err = -EBUSY;
+			goto err_free;
+		}
+	}
+	xdma8 = dma8[dev];
+	if (xdma8 == SNDRV_AUTO_DMA) {
+		xdma8 = snd_legacy_find_free_dma(possible_dmas8);
+		if (xdma8 < 0) {
+			snd_printk(KERN_ERR "unable to find a free DMA8\n");
+			err = -EBUSY;
+			goto err_free;
+		}
+	}
+	xdma16 = dma16[dev];
+	if (xdma16 == SNDRV_AUTO_DMA) {
+		xdma16 = snd_legacy_find_free_dma(possible_dmas16);
+		if (xdma16 < 0) {
+			snd_printk(KERN_ERR "unable to find a free DMA16\n");
+			err = -EBUSY;
+			goto err_free;
+		}
+	}
+
+	xmpu_port = mpu_port[dev];
+	if (xmpu_port == SNDRV_AUTO_PORT)
+		xmpu_port = 0;
+	err = jazz16_detect_board(port[dev], xmpu_port);
+	if (err < 0) {
+		printk(KERN_ERR "Media Vision Jazz16 board not detected\n");
+		goto err_free;
+	}
+	err = snd_sbdsp_create(card, port[dev], irq[dev],
+			       jazz16_interrupt,
+			       dma8[dev], dma16[dev],
+			       SB_HW_JAZZ16,
+			       &chip);
+	if (err < 0)
+		goto err_free;
+
+	xmpu_irq = mpu_irq[dev];
+	if (xmpu_irq == SNDRV_AUTO_IRQ || mpu_port[dev] == SNDRV_AUTO_PORT)
+		xmpu_irq = 0;
+	err = jazz16_configure_board(chip, xmpu_irq);
+	if (err < 0) {
+		printk(KERN_ERR "Media Vision Jazz16 configuration failed\n");
+		goto err_free;
+	}
+
+	jazz16->chip = chip;
+
+	strcpy(card->driver, "jazz16");
+	strcpy(card->shortname, "Media Vision Jazz16");
+	sprintf(card->longname,
+		"Media Vision Jazz16 at 0x%lx, irq %d, dma8 %d, dma16 %d",
+		port[dev], xirq, xdma8, xdma16);
+
+	err = snd_sb8dsp_pcm(chip, 0, NULL);
+	if (err < 0)
+		goto err_free;
+	err = snd_sbmixer_new(chip);
+	if (err < 0)
+		goto err_free;
+
+	err = snd_opl3_create(card, chip->port, chip->port + 2,
+			      OPL3_HW_AUTO, 1, &opl3);
+	if (err < 0)
+		snd_printk(KERN_WARNING "no OPL device at 0x%lx-0x%lx\n",
+			   chip->port, chip->port + 2);
+	else {
+		err = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
+		if (err < 0)
+			goto err_free;
+	}
+	if (mpu_port[dev] > 0 && mpu_port[dev] != SNDRV_AUTO_PORT) {
+		if (mpu_irq[dev] == SNDRV_AUTO_IRQ)
+			mpu_irq[dev] = -1;
+
+		if (snd_mpu401_uart_new(card, 0,
+					MPU401_HW_MPU401,
+					mpu_port[dev], 0,
+					mpu_irq[dev],
+					mpu_irq[dev] >= 0 ? IRQF_DISABLED : 0,
+					NULL) < 0)
+			snd_printk(KERN_ERR "no MPU-401 device at 0x%lx\n",
+					mpu_port[dev]);
+	}
+
+	snd_card_set_dev(card, devptr);
+
+	err = snd_card_register(card);
+	if (err < 0)
+		goto err_free;
+
+	dev_set_drvdata(devptr, card);
+	return 0;
+
+err_free:
+	snd_card_free(card);
+	return err;
+}
+
+static int __devexit snd_jazz16_remove(struct device *devptr, unsigned int dev)
+{
+	struct snd_card *card = dev_get_drvdata(devptr);
+
+	dev_set_drvdata(devptr, NULL);
+	snd_card_free(card);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int snd_jazz16_suspend(struct device *pdev, unsigned int n,
+			       pm_message_t state)
+{
+	struct snd_card *card = dev_get_drvdata(pdev);
+	struct snd_card_jazz16 *acard = card->private_data;
+	struct snd_sb *chip = acard->chip;
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
+	snd_pcm_suspend_all(chip->pcm);
+	snd_sbmixer_suspend(chip);
+	return 0;
+}
+
+static int snd_jazz16_resume(struct device *pdev, unsigned int n)
+{
+	struct snd_card *card = dev_get_drvdata(pdev);
+	struct snd_card_jazz16 *acard = card->private_data;
+	struct snd_sb *chip = acard->chip;
+
+	snd_sbdsp_reset(chip);
+	snd_sbmixer_resume(chip);
+	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
+	return 0;
+}
+#endif
+
+static struct isa_driver snd_jazz16_driver = {
+	.match		= snd_jazz16_match,
+	.probe		= snd_jazz16_probe,
+	.remove		= __devexit_p(snd_jazz16_remove),
+#ifdef CONFIG_PM
+	.suspend	= snd_jazz16_suspend,
+	.resume		= snd_jazz16_resume,
+#endif
+	.driver		= {
+		.name	= "jazz16"
+	},
+};
+
+static int __init alsa_card_jazz16_init(void)
+{
+	return isa_register_driver(&snd_jazz16_driver, SNDRV_CARDS);
+}
+
+static void __exit alsa_card_jazz16_exit(void)
+{
+	isa_unregister_driver(&snd_jazz16_driver);
+}
+
+module_init(alsa_card_jazz16_init)
+module_exit(alsa_card_jazz16_exit)
diff --git a/sound/isa/sb/sb8_main.c b/sound/isa/sb/sb8_main.c
index 658d557..3222aed 100644
--- a/sound/isa/sb/sb8_main.c
+++ b/sound/isa/sb/sb8_main.c
@@ -106,9 +106,21 @@ static int snd_sb8_playback_prepare(struct snd_pcm_substream *substream)
 	struct snd_sb *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned int mixreg, rate, size, count;
+	unsigned char format;
+	unsigned char stereo = runtime->channels > 1;
+	int dma;
 
 	rate = runtime->rate;
 	switch (chip->hardware) {
+	case SB_HW_JAZZ16:
+		if (runtime->format == SNDRV_PCM_FORMAT_S16_LE) {
+			if (chip->mode & SB_MODE_CAPTURE_16)
+				return -EBUSY;
+			else
+				chip->mode |= SB_MODE_PLAYBACK_16;
+		}
+		chip->playback_format = SB_DSP_LO_OUTPUT_AUTO;
+		break;
 	case SB_HW_PRO:
 		if (runtime->channels > 1) {
 			if (snd_BUG_ON(rate != SB8_RATE(11025) &&
@@ -133,11 +145,21 @@ static int snd_sb8_playback_prepare(struct snd_pcm_substream *substream)
 	default:
 		return -EINVAL;
 	}
+	if (chip->mode & SB_MODE_PLAYBACK_16) {
+		format = stereo ? SB_DSP_STEREO_16BIT : SB_DSP_MONO_16BIT;
+		dma = chip->dma16;
+	} else {
+		format = stereo ? SB_DSP_STEREO_8BIT : SB_DSP_MONO_8BIT;
+		chip->mode |= SB_MODE_PLAYBACK_8;
+		dma = chip->dma8;
+	}
 	size = chip->p_dma_size = snd_pcm_lib_buffer_bytes(substream);
 	count = chip->p_period_size = snd_pcm_lib_period_bytes(substream);
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	snd_sbdsp_command(chip, SB_DSP_SPEAKER_ON);
-	if (runtime->channels > 1) {
+	if (chip->hardware == SB_HW_JAZZ16)
+		snd_sbdsp_command(chip, format);
+	else if (stereo) {
 		/* set playback stereo mode */
 		spin_lock(&chip->mixer_lock);
 		mixreg = snd_sbmixer_read(chip, SB_DSP_STEREO_SW);
@@ -147,15 +169,14 @@ static int snd_sb8_playback_prepare(struct snd_pcm_substream *substream)
 		/* Soundblaster hardware programming reference guide, 3-23 */
 		snd_sbdsp_command(chip, SB_DSP_DMA8_EXIT);
 		runtime->dma_area[0] = 0x80;
-		snd_dma_program(chip->dma8, runtime->dma_addr, 1, DMA_MODE_WRITE);
+		snd_dma_program(dma, runtime->dma_addr, 1, DMA_MODE_WRITE);
 		/* force interrupt */
-		chip->mode = SB_MODE_HALT;
 		snd_sbdsp_command(chip, SB_DSP_OUTPUT);
 		snd_sbdsp_command(chip, 0);
 		snd_sbdsp_command(chip, 0);
 	}
 	snd_sbdsp_command(chip, SB_DSP_SAMPLE_RATE);
-	if (runtime->channels > 1) {
+	if (stereo) {
 		snd_sbdsp_command(chip, 256 - runtime->rate_den / 2);
 		spin_lock(&chip->mixer_lock);
 		/* save output filter status and turn it off */
@@ -168,13 +189,15 @@ static int snd_sb8_playback_prepare(struct snd_pcm_substream *substream)
 		snd_sbdsp_command(chip, 256 - runtime->rate_den);
 	}
 	if (chip->playback_format != SB_DSP_OUTPUT) {
+		if (chip->mode & SB_MODE_PLAYBACK_16)
+			count /= 2;
 		count--;
 		snd_sbdsp_command(chip, SB_DSP_BLOCK_SIZE);
 		snd_sbdsp_command(chip, count & 0xff);
 		snd_sbdsp_command(chip, count >> 8);
 	}
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_dma_program(chip->dma8, runtime->dma_addr,
+	snd_dma_program(dma, runtime->dma_addr,
 			size, DMA_MODE_WRITE | DMA_AUTOINIT);
 	return 0;
 }
@@ -212,7 +235,6 @@ static int snd_sb8_playback_trigger(struct snd_pcm_substream *substream,
 		snd_sbdsp_command(chip, SB_DSP_SPEAKER_OFF);
 	}
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	chip->mode = (cmd == SNDRV_PCM_TRIGGER_START) ? SB_MODE_PLAYBACK_8 : SB_MODE_HALT;
 	return 0;
 }
 
@@ -234,9 +256,21 @@ static int snd_sb8_capture_prepare(struct snd_pcm_substream *substream)
 	struct snd_sb *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned int mixreg, rate, size, count;
+	unsigned char format;
+	unsigned char stereo = runtime->channels > 1;
+	int dma;
 
 	rate = runtime->rate;
 	switch (chip->hardware) {
+	case SB_HW_JAZZ16:
+		if (runtime->format == SNDRV_PCM_FORMAT_S16_LE) {
+			if (chip->mode & SB_MODE_PLAYBACK_16)
+				return -EBUSY;
+			else
+				chip->mode |= SB_MODE_CAPTURE_16;
+		}
+		chip->capture_format = SB_DSP_LO_INPUT_AUTO;
+		break;
 	case SB_HW_PRO:
 		if (runtime->channels > 1) {
 			if (snd_BUG_ON(rate != SB8_RATE(11025) &&
@@ -262,14 +296,24 @@ static int snd_sb8_capture_prepare(struct snd_pcm_substream *substream)
 	default:
 		return -EINVAL;
 	}
+	if (chip->mode & SB_MODE_CAPTURE_16) {
+		format = stereo ? SB_DSP_STEREO_16BIT : SB_DSP_MONO_16BIT;
+		dma = chip->dma16;
+	} else {
+		format = stereo ? SB_DSP_STEREO_8BIT : SB_DSP_MONO_8BIT;
+		chip->mode |= SB_MODE_CAPTURE_8;
+		dma = chip->dma8;
+	}
 	size = chip->c_dma_size = snd_pcm_lib_buffer_bytes(substream);
 	count = chip->c_period_size = snd_pcm_lib_period_bytes(substream);
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	snd_sbdsp_command(chip, SB_DSP_SPEAKER_OFF);
-	if (runtime->channels > 1)
+	if (chip->hardware == SB_HW_JAZZ16)
+		snd_sbdsp_command(chip, format);
+	else if (stereo)
 		snd_sbdsp_command(chip, SB_DSP_STEREO_8BIT);
 	snd_sbdsp_command(chip, SB_DSP_SAMPLE_RATE);
-	if (runtime->channels > 1) {
+	if (stereo) {
 		snd_sbdsp_command(chip, 256 - runtime->rate_den / 2);
 		spin_lock(&chip->mixer_lock);
 		/* save input filter status and turn it off */
@@ -282,13 +326,15 @@ static int snd_sb8_capture_prepare(struct snd_pcm_substream *substream)
 		snd_sbdsp_command(chip, 256 - runtime->rate_den);
 	}
 	if (chip->capture_format != SB_DSP_INPUT) {
+		if (chip->mode & SB_MODE_PLAYBACK_16)
+			count /= 2;
 		count--;
 		snd_sbdsp_command(chip, SB_DSP_BLOCK_SIZE);
 		snd_sbdsp_command(chip, count & 0xff);
 		snd_sbdsp_command(chip, count >> 8);
 	}
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_dma_program(chip->dma8, runtime->dma_addr,
+	snd_dma_program(dma, runtime->dma_addr,
 			size, DMA_MODE_READ | DMA_AUTOINIT);
 	return 0;
 }
@@ -328,7 +374,6 @@ static int snd_sb8_capture_trigger(struct snd_pcm_substream *substream,
 		snd_sbdsp_command(chip, SB_DSP_SPEAKER_OFF);
 	}
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	chip->mode = (cmd == SNDRV_PCM_TRIGGER_START) ? SB_MODE_CAPTURE_8 : SB_MODE_HALT;
 	return 0;
 }
 
@@ -339,13 +384,21 @@ irqreturn_t snd_sb8dsp_interrupt(struct snd_sb *chip)
 
 	snd_sb_ack_8bit(chip);
 	switch (chip->mode) {
-	case SB_MODE_PLAYBACK_8:	/* ok.. playback is active */
+	case SB_MODE_PLAYBACK_16:	/* ok.. playback is active */
+		if (chip->hardware != SB_HW_JAZZ16)
+			break;
+		/* fallthru */
+	case SB_MODE_PLAYBACK_8:
 		substream = chip->playback_substream;
 		runtime = substream->runtime;
 		if (chip->playback_format == SB_DSP_OUTPUT)
 		    	snd_sb8_playback_trigger(substream, SNDRV_PCM_TRIGGER_START);
 		snd_pcm_period_elapsed(substream);
 		break;
+	case SB_MODE_CAPTURE_16:
+		if (chip->hardware != SB_HW_JAZZ16)
+			break;
+		/* fallthru */
 	case SB_MODE_CAPTURE_8:
 		substream = chip->capture_substream;
 		runtime = substream->runtime;
@@ -361,10 +414,15 @@ static snd_pcm_uframes_t snd_sb8_playback_pointer(struct snd_pcm_substream *subs
 {
 	struct snd_sb *chip = snd_pcm_substream_chip(substream);
 	size_t ptr;
+	int dma;
 
-	if (chip->mode != SB_MODE_PLAYBACK_8)
+	if (chip->mode & SB_MODE_PLAYBACK_8)
+		dma = chip->dma8;
+	else if (chip->mode & SB_MODE_PLAYBACK_16)
+		dma = chip->dma16;
+	else
 		return 0;
-	ptr = snd_dma_pointer(chip->dma8, chip->p_dma_size);
+	ptr = snd_dma_pointer(dma, chip->p_dma_size);
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
@@ -372,10 +430,15 @@ static snd_pcm_uframes_t snd_sb8_capture_pointer(struct snd_pcm_substream *subst
 {
 	struct snd_sb *chip = snd_pcm_substream_chip(substream);
 	size_t ptr;
+	int dma;
 
-	if (chip->mode != SB_MODE_CAPTURE_8)
+	if (chip->mode & SB_MODE_CAPTURE_8)
+		dma = chip->dma8;
+	else if (chip->mode & SB_MODE_CAPTURE_16)
+		dma = chip->dma16;
+	else
 		return 0;
-	ptr = snd_dma_pointer(chip->dma8, chip->c_dma_size);
+	ptr = snd_dma_pointer(dma, chip->c_dma_size);
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
@@ -446,6 +509,13 @@ static int snd_sb8_open(struct snd_pcm_substream *substream)
 		runtime->hw = snd_sb8_capture;
 	}
 	switch (chip->hardware) {
+	case SB_HW_JAZZ16:
+		runtime->hw.formats |= SNDRV_PCM_FMTBIT_S16_LE;
+		runtime->hw.rates |= SNDRV_PCM_RATE_8000_48000;
+		runtime->hw.rate_min = 4000;
+		runtime->hw.rate_max = 50000;
+		runtime->hw.channels_max = 2;
+		break;
 	case SB_HW_PRO:
 		runtime->hw.rate_max = 44100;
 		runtime->hw.channels_max = 2;
@@ -468,6 +538,14 @@ static int snd_sb8_open(struct snd_pcm_substream *substream)
 	}
 	snd_pcm_hw_constraint_ratnums(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				      &hw_constraints_clock);
+	if (chip->dma8 > 3 || chip->dma16 >= 0) {
+		snd_pcm_hw_constraint_step(runtime, 0,
+					   SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 2);
+		snd_pcm_hw_constraint_step(runtime, 0,
+					   SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 2);
+		runtime->hw.buffer_bytes_max = 128 * 1024 * 1024;
+		runtime->hw.period_bytes_max = 128 * 1024 * 1024;
+	}
 	return 0;	
 }
 
@@ -480,6 +558,10 @@ static int snd_sb8_close(struct snd_pcm_substream *substream)
 	chip->capture_substream = NULL;
 	spin_lock_irqsave(&chip->open_lock, flags);
 	chip->open &= ~SB_OPEN_PCM;
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		chip->mode &= ~SB_MODE_PLAYBACK;
+	else
+		chip->mode &= ~SB_MODE_CAPTURE;
 	spin_unlock_irqrestore(&chip->open_lock, flags);
 	return 0;
 }
@@ -515,6 +597,7 @@ int snd_sb8dsp_pcm(struct snd_sb *chip, int device, struct snd_pcm ** rpcm)
 	struct snd_card *card = chip->card;
 	struct snd_pcm *pcm;
 	int err;
+	size_t max_prealloc = 64 * 1024;
 
 	if (rpcm)
 		*rpcm = NULL;
@@ -527,9 +610,11 @@ int snd_sb8dsp_pcm(struct snd_sb *chip, int device, struct snd_pcm ** rpcm)
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_sb8_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_sb8_capture_ops);
 
+	if (chip->dma8 > 3 || chip->dma16 >= 0)
+		max_prealloc = 128 * 1024;
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_isa_data(),
-					      64*1024, 64*1024);
+					      64*1024, max_prealloc);
 
 	if (rpcm)
 		*rpcm = pcm;
diff --git a/sound/isa/sb/sb_common.c b/sound/isa/sb/sb_common.c
index 27a6515..eae6c1c 100644
--- a/sound/isa/sb/sb_common.c
+++ b/sound/isa/sb/sb_common.c
@@ -170,6 +170,9 @@ static int snd_sbdsp_probe(struct snd_sb * chip)
 	case SB_HW_CS5530:
 		str = "16 (CS5530)";
 		break;
+	case SB_HW_JAZZ16:
+		str = "Pro (Jazz16)";
+		break;
 	default:
 		return -ENODEV;
 	}
diff --git a/sound/isa/sb/sb_mixer.c b/sound/isa/sb/sb_mixer.c
index 8cfc41f..6496822 100644
--- a/sound/isa/sb/sb_mixer.c
+++ b/sound/isa/sb/sb_mixer.c
@@ -779,6 +779,7 @@ int snd_sbmixer_new(struct snd_sb *chip)
 			return err;
 		break;
 	case SB_HW_PRO:
+	case SB_HW_JAZZ16:
 		if ((err = snd_sbmixer_init(chip,
 					    snd_sbpro_controls,
 					    ARRAY_SIZE(snd_sbpro_controls),
@@ -929,6 +930,7 @@ void snd_sbmixer_suspend(struct snd_sb *chip)
 		save_mixer(chip, sb20_saved_regs, ARRAY_SIZE(sb20_saved_regs));
 		break;
 	case SB_HW_PRO:
+	case SB_HW_JAZZ16:
 		save_mixer(chip, sbpro_saved_regs, ARRAY_SIZE(sbpro_saved_regs));
 		break;
 	case SB_HW_16:
@@ -955,6 +957,7 @@ void snd_sbmixer_resume(struct snd_sb *chip)
 		restore_mixer(chip, sb20_saved_regs, ARRAY_SIZE(sb20_saved_regs));
 		break;
 	case SB_HW_PRO:
+	case SB_HW_JAZZ16:
 		restore_mixer(chip, sbpro_saved_regs, ARRAY_SIZE(sbpro_saved_regs));
 		break;
 	case SB_HW_16:
-- 
1.6.4


----------------------------------------------------------------------
Sprawdz sekrety swojego biorytmu.
Kliknij >> http://link.interia.pl/f2534
