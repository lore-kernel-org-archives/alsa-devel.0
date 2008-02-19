From: =?iso-8859-1?q?C=E9dric_Br=E9gardis?= <cedric.bregardis@free.fr>
Subject: Re: [PATCH] Driver for Emagic Audiowerk 2
Date: Tue, 19 Feb 2008 22:34:36 +0100
Message-ID: <200802192234.36437.cedric.bregardis@free.fr>
References: <200802160030.56147.cedric.bregardis@free.fr>
	<200802191811.46049.cedric.bregardis@free.fr>
	<s5h63wkua83.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rt0uHXSD+mRtT7I"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by alsa0.perex.cz (Postfix) with ESMTP id E335F2461A
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 22:34:39 +0100 (CET)
In-Reply-To: <s5h63wkua83.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, jhassler@free.fr
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_rt0uHXSD+mRtT7I
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

At Tuesday 19 February 2008 18:28:28, Takashi Iwai wrote:
> At Tue, 19 Feb 2008 18:11:45 +0100,
>
> C=E9dric Br=E9gardis wrote:
> [...]
> > So, this time you will find the patch in attachment, as suggested.
>
> Thanks.  I've checked again right now, and found some remaining
> issues.

Thanks. I have corrected the driver according to your review. By the same
time I have removed some dead code. The new patch is in attachment.

Regards,
Cedric.

--Boundary-00=_rt0uHXSD+mRtT7I
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="snd-aw2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snd-aw2.patch"

Emagic Audiowerk 2 ALSA driver.

Signed-off-by: Cedric Bregardis <cedric.bregardis@free.fr>
Signed-off-by: Jean-Christian Hassler <jhassler@free.fr>
---
 sound/pci/Kconfig           |   15 +
 sound/pci/Makefile          |    1 +
 sound/pci/aw2/Makefile      |    3 +
 sound/pci/aw2/aw2-alsa.c    |  787 +++++++++++++++++++++++++++++++++++++++++++
 sound/pci/aw2/aw2-saa7146.c |  464 +++++++++++++++++++++++++
 sound/pci/aw2/aw2-saa7146.h |  105 ++++++
 sound/pci/aw2/aw2-tsl.h     |  116 +++++++
 sound/pci/aw2/saa7146.h     |  168 +++++++++
 8 files changed, 1659 insertions(+), 0 deletions(-)
 create mode 100644 sound/pci/aw2/Makefile
 create mode 100644 sound/pci/aw2/aw2-alsa.c
 create mode 100644 sound/pci/aw2/aw2-saa7146.c
 create mode 100644 sound/pci/aw2/aw2-saa7146.h
 create mode 100644 sound/pci/aw2/aw2-tsl.h
 create mode 100644 sound/pci/aw2/saa7146.h

diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index 812085d..194394b 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -122,6 +122,21 @@ config SND_AU8830
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-au8830.

+config SND_AW2
+	tristate "Emagic Audiowerk 2"
+	depends on SND
+	help
+	  Say Y here to include support for Emagic Audiowerk 2 soundcards.
+
+	  Supported features: Analog and SPDIF output. Analog or SPDIF input.
+	  Note: Switch between analog and digital input does not always work.
+	  It can produce continuous noise. The workaround is to switch again
+	  (and again) between digital and analog input until it works.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-aw2.
+
+
 config SND_AZT3328
 	tristate "Aztech AZF3328 / PCI168 (EXPERIMENTAL)"
 	depends on SND && EXPERIMENTAL
diff --git a/sound/pci/Makefile b/sound/pci/Makefile
index 2d42fd2..85ef14b 100644
--- a/sound/pci/Makefile
+++ b/sound/pci/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_SND) += \
 	ac97/ \
 	ali5451/ \
 	au88x0/ \
+	aw2/ \
 	ca0106/ \
 	cs46xx/ \
 	cs5535audio/ \
diff --git a/sound/pci/aw2/Makefile b/sound/pci/aw2/Makefile
new file mode 100644
index 0000000..842335d
--- /dev/null
+++ b/sound/pci/aw2/Makefile
@@ -0,0 +1,3 @@
+snd-aw2-objs := aw2-alsa.o aw2-saa7146.o
+
+obj-$(CONFIG_SND_AW2) += snd-aw2.o
diff --git a/sound/pci/aw2/aw2-alsa.c b/sound/pci/aw2/aw2-alsa.c
new file mode 100644
index 0000000..74af639
--- /dev/null
+++ b/sound/pci/aw2/aw2-alsa.c
@@ -0,0 +1,787 @@
+/*****************************************************************************
+ *
+ * Copyright (C) 2008 Cedric Bregardis <cedric.bregardis@free.fr> and
+ * Jean-Christian Hassler <jhassler@free.fr>
+ *
+ * This file is part of the Audiowerk2 ALSA driver
+ *
+ * The Audiowerk2 ALSA driver is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2.
+ *
+ * The Audiowerk2 ALSA driver is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with the Audiowerk2 ALSA driver; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
+ * USA.
+ *
+ *****************************************************************************/
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/control.h>
+
+#include "saa7146.h"
+#include "aw2-saa7146.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Cedric Bregardis <cedric.bregardis@free.fr>, "
+	      "Jean-Christian Hassler <jhassler@free.fr>");
+MODULE_DESCRIPTION("Emagic Audiowerk 2 sound driver");
+MODULE_LICENSE("GPL");
+
+/*********************************
+ * DEFINES
+ ********************************/
+#define PCI_VENDOR_ID_SAA7146		  0x1131
+#define PCI_DEVICE_ID_SAA7146		  0x7146
+
+#define CTL_ROUTE_ANALOG 0
+#define CTL_ROUTE_DIGITAL 1
+
+/*********************************
+ * TYPEDEFS
+ ********************************/
+  /* hardware definition */
+static struct snd_pcm_hardware snd_aw2_playback_hw = {
+	.info = (SNDRV_PCM_INFO_MMAP |
+		 SNDRV_PCM_INFO_INTERLEAVED |
+		 SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_MMAP_VALID),
+	.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	.rates = SNDRV_PCM_RATE_44100,
+	.rate_min = 44100,
+	.rate_max = 44100,
+	.channels_min = 2,
+	.channels_max = 4,
+	.buffer_bytes_max = 32768,
+	.period_bytes_min = 4096,
+	.period_bytes_max = 32768,
+	.periods_min = 1,
+	.periods_max = 1024,
+};
+
+static struct snd_pcm_hardware snd_aw2_capture_hw = {
+	.info = (SNDRV_PCM_INFO_MMAP |
+		 SNDRV_PCM_INFO_INTERLEAVED |
+		 SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_MMAP_VALID),
+	.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	.rates = SNDRV_PCM_RATE_44100,
+	.rate_min = 44100,
+	.rate_max = 44100,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = 32768,
+	.period_bytes_min = 4096,
+	.period_bytes_max = 32768,
+	.periods_min = 1,
+	.periods_max = 1024,
+};
+
+struct aw2_pcm_device {
+	struct snd_pcm *pcm;
+	unsigned int stream_number;
+	struct aw2 *chip;
+};
+
+struct aw2 {
+	struct snd_aw2_saa7146 saa7146;
+
+	struct pci_dev *pci;
+	int irq;
+	spinlock_t reg_lock;
+	struct mutex mtx;
+
+	unsigned long iobase_phys;
+	void __iomem *iobase_virt;
+
+	struct snd_card *card;
+
+	struct aw2_pcm_device device_playback[NB_STREAM_PLAYBACK];
+	struct aw2_pcm_device device_capture[NB_STREAM_CAPTURE];
+};
+
+/*********************************
+ * FUNCTION DECLARATIONS
+ ********************************/
+static int __init alsa_card_aw2_init(void);
+static void __exit alsa_card_aw2_exit(void);
+static int snd_aw2_dev_free(struct snd_device *device);
+static int __devinit snd_aw2_create(struct snd_card *card,
+				    struct pci_dev *pci, struct aw2 **rchip);
+static int __devinit snd_aw2_probe(struct pci_dev *pci,
+				   const struct pci_device_id *pci_id);
+static void __devexit snd_aw2_remove(struct pci_dev *pci);
+static int snd_aw2_pcm_playback_open(struct snd_pcm_substream *substream);
+static int snd_aw2_pcm_playback_close(struct snd_pcm_substream *substream);
+static int snd_aw2_pcm_capture_open(struct snd_pcm_substream *substream);
+static int snd_aw2_pcm_capture_close(struct snd_pcm_substream *substream);
+static int snd_aw2_pcm_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *hw_params);
+static int snd_aw2_pcm_hw_free(struct snd_pcm_substream *substream);
+static int snd_aw2_pcm_prepare_playback(struct snd_pcm_substream *substream);
+static int snd_aw2_pcm_prepare_capture(struct snd_pcm_substream *substream);
+static int snd_aw2_pcm_trigger_playback(struct snd_pcm_substream *substream,
+					int cmd);
+static int snd_aw2_pcm_trigger_capture(struct snd_pcm_substream *substream,
+				       int cmd);
+static snd_pcm_uframes_t snd_aw2_pcm_pointer_playback(struct snd_pcm_substream
+						      *substream);
+static snd_pcm_uframes_t snd_aw2_pcm_pointer_capture(struct snd_pcm_substream
+						     *substream);
+static int __devinit snd_aw2_new_pcm(struct aw2 *chip);
+
+static int snd_aw2_control_switch_capture_info(struct snd_kcontrol *kcontrol,
+					       struct snd_ctl_elem_info *uinfo);
+static int snd_aw2_control_switch_capture_get(struct snd_kcontrol *kcontrol,
+					      struct snd_ctl_elem_value
+					      *ucontrol);
+static int snd_aw2_control_switch_capture_put(struct snd_kcontrol *kcontrol,
+					      struct snd_ctl_elem_value
+					      *ucontrol);
+
+/*********************************
+ * VARIABLES
+ ********************************/
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
+
+static struct pci_device_id snd_aw2_ids[] = {
+	{PCI_VENDOR_ID_SAA7146, PCI_DEVICE_ID_SAA7146, PCI_ANY_ID, PCI_ANY_ID,
+	 0, 0, 0},
+	{0}
+};
+
+MODULE_DEVICE_TABLE(pci, snd_aw2_ids);
+
+/* pci_driver definition */
+static struct pci_driver driver = {
+	.name = "Emagic Audiowerk 2",
+	.id_table = snd_aw2_ids,
+	.probe = snd_aw2_probe,
+	.remove = __devexit_p(snd_aw2_remove),
+};
+
+/* operators for playback PCM alsa interface */
+static struct snd_pcm_ops snd_aw2_playback_ops = {
+	.open = snd_aw2_pcm_playback_open,
+	.close = snd_aw2_pcm_playback_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = snd_aw2_pcm_hw_params,
+	.hw_free = snd_aw2_pcm_hw_free,
+	.prepare = snd_aw2_pcm_prepare_playback,
+	.trigger = snd_aw2_pcm_trigger_playback,
+	.pointer = snd_aw2_pcm_pointer_playback,
+};
+
+/* operators for capture PCM alsa interface */
+static struct snd_pcm_ops snd_aw2_capture_ops = {
+	.open = snd_aw2_pcm_capture_open,
+	.close = snd_aw2_pcm_capture_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = snd_aw2_pcm_hw_params,
+	.hw_free = snd_aw2_pcm_hw_free,
+	.prepare = snd_aw2_pcm_prepare_capture,
+	.trigger = snd_aw2_pcm_trigger_capture,
+	.pointer = snd_aw2_pcm_pointer_capture,
+};
+
+static struct snd_kcontrol_new aw2_control __devinitdata = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "PCM Capture Route",
+	.index = 0,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.private_value = 0xffff,
+	.info = snd_aw2_control_switch_capture_info,
+	.get = snd_aw2_control_switch_capture_get,
+	.put = snd_aw2_control_switch_capture_put
+};
+
+/*********************************
+ * FUNCTION IMPLEMENTATIONS
+ ********************************/
+
+/* initialization of the module */
+static int __init alsa_card_aw2_init(void)
+{
+	snd_printdd(KERN_DEBUG "aw2: Load aw2 module\n");
+	return pci_register_driver(&driver);
+}
+
+/* clean up the module */
+static void __exit alsa_card_aw2_exit(void)
+{
+	snd_printdd(KERN_DEBUG "aw2: Unload aw2 module\n");
+	pci_unregister_driver(&driver);
+}
+
+module_init(alsa_card_aw2_init);
+module_exit(alsa_card_aw2_exit);
+
+/* component-destructor */
+static int snd_aw2_dev_free(struct snd_device *device)
+{
+	struct aw2 *chip = device->device_data;
+
+	/* Free hardware */
+	snd_aw2_saa7146_free(&chip->saa7146);
+
+	/* release the irq */
+	if (chip->irq >= 0)
+		free_irq(chip->irq, (void *)chip);
+	/* release the i/o ports & memory */
+	if (chip->iobase_virt)
+		iounmap(chip->iobase_virt);
+
+	pci_release_regions(chip->pci);
+	/* disable the PCI entry */
+	pci_disable_device(chip->pci);
+	/* release the data */
+	kfree(chip);
+
+	return 0;
+}
+
+/* chip-specific constructor */
+static int __devinit snd_aw2_create(struct snd_card *card,
+				    struct pci_dev *pci, struct aw2 **rchip)
+{
+	struct aw2 *chip;
+	int err;
+	static struct snd_device_ops ops = {
+		.dev_free = snd_aw2_dev_free,
+	};
+
+	*rchip = NULL;
+
+	/* initialize the PCI entry */
+	err = pci_enable_device(pci);
+	if (err < 0)
+		return err;
+	pci_set_master(pci);
+
+	/* check PCI availability (32bit DMA) */
+	if ((pci_set_dma_mask(pci, DMA_32BIT_MASK) < 0) ||
+	    (pci_set_consistent_dma_mask(pci, DMA_32BIT_MASK) < 0)) {
+		printk(KERN_ERR "aw2: Impossible to set 32bit mask DMA\n");
+		pci_disable_device(pci);
+		return -ENXIO;
+	}
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+	if (chip == NULL) {
+		pci_disable_device(pci);
+		return -ENOMEM;
+	}
+
+	/* initialize the stuff */
+	chip->card = card;
+	chip->pci = pci;
+	chip->irq = -1;
+
+	/* (1) PCI resource allocation */
+	err = pci_request_regions(pci, "Audiowerk2");
+	if (err < 0) {
+		pci_disable_device(pci);
+		kfree(chip);
+		return err;
+	}
+	chip->iobase_phys = pci_resource_start(pci, 0);
+	chip->iobase_virt =
+		ioremap_nocache(chip->iobase_phys,
+				pci_resource_len(pci, 0));
+
+	if (chip->iobase_virt == NULL) {
+		printk(KERN_ERR "aw2: unable to remap memory region");
+		pci_release_regions(pci);
+		pci_disable_device(pci);
+		kfree(chip);
+		return -ENOMEM;
+	}
+
+
+	if (request_irq(pci->irq, snd_aw2_saa7146_interrupt,
+			IRQF_SHARED, "Audiowerk2", chip)) {
+		printk(KERN_ERR "aw2: Cannot grab irq %d\n", pci->irq);
+
+		iounmap(chip->iobase_virt);
+		pci_release_regions(chip->pci);
+		pci_disable_device(chip->pci);
+		kfree(chip);
+		return -EBUSY;
+	}
+	chip->irq = pci->irq;
+
+	/* (2) initialization of the chip hardware */
+	snd_aw2_saa7146_setup(&chip->saa7146, chip->iobase_virt);
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0) {
+		free_irq(chip->irq, (void *)chip);
+		iounmap(chip->iobase_virt);
+		pci_release_regions(chip->pci);
+		pci_disable_device(chip->pci);
+		kfree(chip);
+		return err;
+	}
+
+	snd_card_set_dev(card, &pci->dev);
+	*rchip = chip;
+
+	printk(KERN_INFO
+	       "Audiowerk 2 sound card (saa7146 chipset) detected and "
+	       "managed\n");
+	return 0;
+}
+
+/* constructor */
+static int __devinit snd_aw2_probe(struct pci_dev *pci,
+				   const struct pci_device_id *pci_id)
+{
+	static int dev;
+	struct snd_card *card;
+	struct aw2 *chip;
+	int err;
+
+	/* (1) Continue if device is not enabled, else inc dev */
+	if (dev >= SNDRV_CARDS)
+		return -ENODEV;
+	if (!enable[dev]) {
+		dev++;
+		return -ENOENT;
+	}
+
+	/* (2) Create card instance */
+	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
+	if (card == NULL)
+		return -ENOMEM;
+
+	/* (3) Create main component */
+	err = snd_aw2_create(card, pci, &chip);
+	if (err < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
+	/* initialize mutex */
+	mutex_init(&chip->mtx);
+	/* init spinlock */
+	spin_lock_init(&chip->reg_lock);
+	/* (4) Define driver ID and name string */
+	strcpy(card->driver, "aw2");
+	strcpy(card->shortname, "Audiowerk2");
+
+	sprintf(card->longname, "%s with SAA7146 irq %i",
+		card->shortname, chip->irq);
+
+	/* (5) Create other components */
+	snd_aw2_new_pcm(chip);
+
+	/* (6) Register card instance */
+	err = snd_card_register(card);
+	if (err < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
+	/* (7) Set PCI driver data */
+	pci_set_drvdata(pci, card);
+
+	dev++;
+	return 0;
+}
+
+/* destructor */
+static void __devexit snd_aw2_remove(struct pci_dev *pci)
+{
+	snd_card_free(pci_get_drvdata(pci));
+	pci_set_drvdata(pci, NULL);
+}
+
+/* open callback */
+static int snd_aw2_pcm_playback_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	snd_printdd(KERN_DEBUG "aw2: Playback_open \n");
+	runtime->hw = snd_aw2_playback_hw;
+	return 0;
+}
+
+/* close callback */
+static int snd_aw2_pcm_playback_close(struct snd_pcm_substream *substream)
+{
+	return 0;
+
+}
+
+static int snd_aw2_pcm_capture_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	snd_printdd(KERN_DEBUG "aw2: Capture_open \n");
+	runtime->hw = snd_aw2_capture_hw;
+	return 0;
+}
+
+/* close callback */
+static int snd_aw2_pcm_capture_close(struct snd_pcm_substream *substream)
+{
+	/* TODO: something to do ? */
+	return 0;
+}
+
+ /* hw_params callback */
+static int snd_aw2_pcm_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *hw_params)
+{
+	return snd_pcm_lib_malloc_pages(substream,
+					params_buffer_bytes(hw_params));
+}
+
+/* hw_free callback */
+static int snd_aw2_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_lib_free_pages(substream);
+}
+
+/* prepare callback for playback */
+static int snd_aw2_pcm_prepare_playback(struct snd_pcm_substream *substream)
+{
+	struct aw2_pcm_device *pcm_device = snd_pcm_substream_chip(substream);
+	struct aw2 *chip = pcm_device->chip;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned long period_size, buffer_size;
+
+	mutex_lock(&chip->mtx);
+
+	period_size = snd_pcm_lib_period_bytes(substream);
+	buffer_size = snd_pcm_lib_buffer_bytes(substream);
+
+	snd_aw2_saa7146_pcm_init_playback(&chip->saa7146,
+					  pcm_device->stream_number,
+					  runtime->dma_addr, period_size,
+					  buffer_size);
+
+	/* Define Interrupt callback */
+	snd_aw2_saa7146_define_it_playback_callback(pcm_device->stream_number,
+						    (snd_aw2_saa7146_it_cb)
+						    snd_pcm_period_elapsed,
+						    (void *)substream);
+
+	mutex_unlock(&chip->mtx);
+
+	return 0;
+}
+
+/* prepare callback for capture */
+static int snd_aw2_pcm_prepare_capture(struct snd_pcm_substream *substream)
+{
+	struct aw2_pcm_device *pcm_device = snd_pcm_substream_chip(substream);
+	struct aw2 *chip = pcm_device->chip;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned long period_size, buffer_size;
+
+	mutex_lock(&chip->mtx);
+
+	period_size = snd_pcm_lib_period_bytes(substream);
+	buffer_size = snd_pcm_lib_buffer_bytes(substream);
+
+	snd_aw2_saa7146_pcm_init_capture(&chip->saa7146,
+					 pcm_device->stream_number,
+					 runtime->dma_addr, period_size,
+					 buffer_size);
+
+	/* Define Interrupt callback */
+	snd_aw2_saa7146_define_it_capture_callback(pcm_device->stream_number,
+						   (snd_aw2_saa7146_it_cb)
+						   snd_pcm_period_elapsed,
+						   (void *)substream);
+
+	mutex_unlock(&chip->mtx);
+
+	return 0;
+}
+
+/* playback trigger callback */
+static int snd_aw2_pcm_trigger_playback(struct snd_pcm_substream *substream,
+					int cmd)
+{
+	int status = 0;
+	struct aw2_pcm_device *pcm_device = snd_pcm_substream_chip(substream);
+	struct aw2 *chip = pcm_device->chip;
+	spin_lock(&chip->reg_lock);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		snd_aw2_saa7146_pcm_trigger_start_playback(&chip->saa7146,
+							   pcm_device->
+							   stream_number);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		snd_aw2_saa7146_pcm_trigger_stop_playback(&chip->saa7146,
+							  pcm_device->
+							  stream_number);
+		break;
+	default:
+		status = -EINVAL;
+	}
+	spin_unlock(&chip->reg_lock);
+	return status;
+}
+
+/* capture trigger callback */
+static int snd_aw2_pcm_trigger_capture(struct snd_pcm_substream *substream,
+				       int cmd)
+{
+	int status = 0;
+	struct aw2_pcm_device *pcm_device = snd_pcm_substream_chip(substream);
+	struct aw2 *chip = pcm_device->chip;
+	spin_lock(&chip->reg_lock);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		snd_aw2_saa7146_pcm_trigger_start_capture(&chip->saa7146,
+							  pcm_device->
+							  stream_number);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		snd_aw2_saa7146_pcm_trigger_stop_capture(&chip->saa7146,
+							 pcm_device->
+							 stream_number);
+		break;
+	default:
+		status = -EINVAL;
+	}
+	spin_unlock(&chip->reg_lock);
+	return status;
+}
+
+/* playback pointer callback */
+static snd_pcm_uframes_t snd_aw2_pcm_pointer_playback(struct snd_pcm_substream
+						      *substream)
+{
+	struct aw2_pcm_device *pcm_device = snd_pcm_substream_chip(substream);
+	struct aw2 *chip = pcm_device->chip;
+	unsigned int current_ptr;
+
+	/* get the current hardware pointer */
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	current_ptr =
+		snd_aw2_saa7146_get_hw_ptr_playback(&chip->saa7146,
+						    pcm_device->stream_number,
+						    runtime->dma_area,
+						    runtime->buffer_size);
+
+	return bytes_to_frames(substream->runtime, current_ptr);
+}
+
+/* capture pointer callback */
+static snd_pcm_uframes_t snd_aw2_pcm_pointer_capture(struct snd_pcm_substream
+						     *substream)
+{
+	struct aw2_pcm_device *pcm_device = snd_pcm_substream_chip(substream);
+	struct aw2 *chip = pcm_device->chip;
+	unsigned int current_ptr;
+
+	/* get the current hardware pointer */
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	current_ptr =
+		snd_aw2_saa7146_get_hw_ptr_capture(&chip->saa7146,
+						   pcm_device->stream_number,
+						   runtime->dma_area,
+						   runtime->buffer_size);
+
+	return bytes_to_frames(substream->runtime, current_ptr);
+}
+
+/* create a pcm device */
+static int __devinit snd_aw2_new_pcm(struct aw2 *chip)
+{
+	struct snd_pcm *pcm_playback_ana;
+	struct snd_pcm *pcm_playback_num;
+	struct snd_pcm *pcm_capture;
+	struct aw2_pcm_device *pcm_device;
+	int err = 0;
+
+	/* Create new Alsa PCM device */
+
+	err = snd_pcm_new(chip->card, "Audiowerk2 analog playback", 0, 1, 0,
+			  &pcm_playback_ana);
+	if (err < 0) {
+		printk(KERN_ERR "aw2: snd_pcm_new error (0x%X)\n", err);
+		return err;
+	}
+
+	/* Creation ok */
+	pcm_device = &chip->device_playback[NUM_STREAM_PLAYBACK_ANA];
+
+	/* Set PCM device name */
+	strcpy(pcm_playback_ana->name, "Analog playback");
+	/* Associate private data to PCM device */
+	pcm_playback_ana->private_data = pcm_device;
+	/* set operators of PCM device */
+	snd_pcm_set_ops(pcm_playback_ana, SNDRV_PCM_STREAM_PLAYBACK,
+			&snd_aw2_playback_ops);
+	/* store PCM device */
+	pcm_device->pcm = pcm_playback_ana;
+	/* give base chip pointer to our internal pcm device
+	   structure */
+	pcm_device->chip = chip;
+	/* Give stream number to PCM device */
+	pcm_device->stream_number = NUM_STREAM_PLAYBACK_ANA;
+
+	/* pre-allocation of buffers */
+	/* Preallocate continuous pages. */
+	err = snd_pcm_lib_preallocate_pages_for_all(pcm_playback_ana,
+						    SNDRV_DMA_TYPE_DEV,
+						    snd_dma_pci_data
+						    (chip->pci),
+						    64 * 1024, 64 * 1024);
+	if (err)
+		printk(KERN_ERR "aw2: snd_pcm_lib_preallocate_pages_for_all "
+		       "error (0x%X)\n", err);
+
+	err = snd_pcm_new(chip->card, "Audiowerk2 digital playback", 1, 1, 0,
+			  &pcm_playback_num);
+
+	if (err < 0) {
+		printk(KERN_ERR "aw2: snd_pcm_new error (0x%X)\n", err);
+		return err;
+	}
+	/* Creation ok */
+	pcm_device = &chip->device_playback[NUM_STREAM_PLAYBACK_DIG];
+
+	/* Set PCM device name */
+	strcpy(pcm_playback_num->name, "Digital playback");
+	/* Associate private data to PCM device */
+	pcm_playback_num->private_data = pcm_device;
+	/* set operators of PCM device */
+	snd_pcm_set_ops(pcm_playback_num, SNDRV_PCM_STREAM_PLAYBACK,
+			&snd_aw2_playback_ops);
+	/* store PCM device */
+	pcm_device->pcm = pcm_playback_num;
+	/* give base chip pointer to our internal pcm device
+	   structure */
+	pcm_device->chip = chip;
+	/* Give stream number to PCM device */
+	pcm_device->stream_number = NUM_STREAM_PLAYBACK_DIG;
+
+	/* pre-allocation of buffers */
+	/* Preallocate continuous pages. */
+	err = snd_pcm_lib_preallocate_pages_for_all(pcm_playback_num,
+						    SNDRV_DMA_TYPE_DEV,
+						    snd_dma_pci_data
+						    (chip->pci),
+						    64 * 1024, 64 * 1024);
+	if (err)
+		printk(KERN_ERR
+		       "aw2: snd_pcm_lib_preallocate_pages_for_all error "
+		       "(0x%X)\n", err);
+
+
+
+	err = snd_pcm_new(chip->card, "Audiowerk2 capture", 2, 0, 1,
+			  &pcm_capture);
+
+	if (err < 0) {
+		printk(KERN_ERR "aw2: snd_pcm_new error (0x%X)\n", err);
+		return err;
+	}
+
+	/* Creation ok */
+	pcm_device = &chip->device_capture[NUM_STREAM_CAPTURE_ANA];
+
+	/* Set PCM device name */
+	strcpy(pcm_capture->name, "Capture");
+	/* Associate private data to PCM device */
+	pcm_capture->private_data = pcm_device;
+	/* set operators of PCM device */
+	snd_pcm_set_ops(pcm_capture, SNDRV_PCM_STREAM_CAPTURE,
+			&snd_aw2_capture_ops);
+	/* store PCM device */
+	pcm_device->pcm = pcm_capture;
+	/* give base chip pointer to our internal pcm device
+	   structure */
+	pcm_device->chip = chip;
+	/* Give stream number to PCM device */
+	pcm_device->stream_number = NUM_STREAM_CAPTURE_ANA;
+
+	/* pre-allocation of buffers */
+	/* Preallocate continuous pages. */
+	err = snd_pcm_lib_preallocate_pages_for_all(pcm_capture,
+						    SNDRV_DMA_TYPE_DEV,
+						    snd_dma_pci_data
+						    (chip->pci),
+						    64 * 1024, 64 * 1024);
+	if (err)
+		printk(KERN_ERR
+		       "aw2: snd_pcm_lib_preallocate_pages_for_all error "
+		       "(0x%X)\n", err);
+
+
+	/* Create control */
+	err = snd_ctl_add(chip->card, snd_ctl_new1(&aw2_control, chip));
+	if (err < 0) {
+		printk(KERN_ERR "aw2: snd_ctl_add error (0x%X)\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int snd_aw2_control_switch_capture_info(struct snd_kcontrol *kcontrol,
+					       struct snd_ctl_elem_info *uinfo)
+{
+	static char *texts[2] = {
+		"Analog", "Digital"
+	};
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 2;
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items) {
+		uinfo->value.enumerated.item =
+		    uinfo->value.enumerated.items - 1;
+	}
+	strcpy(uinfo->value.enumerated.name,
+	       texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int snd_aw2_control_switch_capture_get(struct snd_kcontrol *kcontrol,
+					      struct snd_ctl_elem_value
+					      *ucontrol)
+{
+	struct aw2 *chip = snd_kcontrol_chip(kcontrol);
+	if (snd_aw2_saa7146_is_using_digital_input(&chip->saa7146))
+		ucontrol->value.enumerated.item[0] = CTL_ROUTE_DIGITAL;
+	else
+		ucontrol->value.enumerated.item[0] = CTL_ROUTE_ANALOG;
+	return 0;
+}
+
+static int snd_aw2_control_switch_capture_put(struct snd_kcontrol *kcontrol,
+					      struct snd_ctl_elem_value
+					      *ucontrol)
+{
+	struct aw2 *chip = snd_kcontrol_chip(kcontrol);
+	int changed = 0;
+	int is_disgital =
+	    snd_aw2_saa7146_is_using_digital_input(&chip->saa7146);
+
+	if (((ucontrol->value.integer.value[0] == CTL_ROUTE_DIGITAL)
+	     && !is_disgital)
+	    || ((ucontrol->value.integer.value[0] == CTL_ROUTE_ANALOG)
+		&& is_disgital)) {
+		snd_aw2_saa7146_use_digital_input(&chip->saa7146, !is_disgital);
+		changed = 1;
+	}
+	return changed;
+}
diff --git a/sound/pci/aw2/aw2-saa7146.c b/sound/pci/aw2/aw2-saa7146.c
new file mode 100644
index 0000000..f20f213
--- /dev/null
+++ b/sound/pci/aw2/aw2-saa7146.c
@@ -0,0 +1,464 @@
+/*****************************************************************************
+ *
+ * Copyright (C) 2008 Cedric Bregardis <cedric.bregardis@free.fr> and
+ * Jean-Christian Hassler <jhassler@free.fr>
+ *
+ * This file is part of the Audiowerk2 ALSA driver
+ *
+ * The Audiowerk2 ALSA driver is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2.
+ *
+ * The Audiowerk2 ALSA driver is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with the Audiowerk2 ALSA driver; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
+ * USA.
+ *
+ *****************************************************************************/
+
+#define AW2_SAA7146_M
+
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <asm/system.h>
+#include <asm/io.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+
+#include "aw2-tsl.h"
+#include "saa7146.h"
+#include "aw2-saa7146.h"
+
+#define WRITEREG(value, addr) writel((value), chip->base_addr + (addr))
+#define READREG(addr) readl(chip->base_addr + (addr))
+
+static struct snd_aw2_saa7146_cb_param
+ arr_substream_it_playback_cb[NB_STREAM_PLAYBACK];
+static struct snd_aw2_saa7146_cb_param
+ arr_substream_it_capture_cb[NB_STREAM_CAPTURE];
+
+static int snd_aw2_saa7146_get_limit(int size);
+
+/* chip-specific destructor */
+int snd_aw2_saa7146_free(struct snd_aw2_saa7146 *chip)
+{
+	/* disable all irqs */
+	WRITEREG(0, IER);
+
+	/* reset saa7146 */
+	WRITEREG((MRST_N << 16), MC1);
+
+	/* Unset base addr */
+	chip->base_addr = NULL;
+
+	return 0;
+}
+
+void snd_aw2_saa7146_setup(struct snd_aw2_saa7146 *chip,
+			   void __iomem *pci_base_addr)
+{
+	/* set PCI burst/threshold
+
+	   Burst length definition
+	   VALUE    BURST LENGTH
+	   000      1 Dword
+	   001      2 Dwords
+	   010      4 Dwords
+	   011      8 Dwords
+	   100      16 Dwords
+	   101      32 Dwords
+	   110      64 Dwords
+	   111      128 Dwords
+
+	   Threshold definition
+	   VALUE    WRITE MODE              READ MODE
+	   00       1 Dword of valid data   1 empty Dword
+	   01       4 Dwords of valid data  4 empty Dwords
+	   10       8 Dwords of valid data  8 empty Dwords
+	   11       16 Dwords of valid data 16 empty Dwords */
+
+	unsigned int acon2;
+	unsigned int acon1 = 0;
+	int i;
+
+	/* Set base addr */
+	chip->base_addr = pci_base_addr;
+
+	/* disable all irqs */
+	WRITEREG(0, IER);
+
+	/* reset saa7146 */
+	WRITEREG((MRST_N << 16), MC1);
+
+	/* enable audio interface */
+#ifdef __BIG_ENDIAN
+	acon1 |= A1_SWAP;
+	acon1 |= A2_SWAP;
+#endif
+	/* WS0_CTRL, WS0_SYNC: input TSL1, I2S */
+
+	/* At initialization WS1 and WS2 are disbaled (configured as input */
+	acon1 |= 0 * WS1_CTRL;
+	acon1 |= 0 * WS2_CTRL;
+
+	/* WS4 is not used. So it must not restart A2.
+	   This is why it is configured as output (force to low) */
+	acon1 |= 3 * WS4_CTRL;
+
+	/* WS3_CTRL, WS3_SYNC: output TSL2, I2S */
+	acon1 |= 2 * WS3_CTRL;
+
+	/* A1 and A2 are active and asynchronous */
+	acon1 |= 3 * AUDIO_MODE;
+	WRITEREG(acon1, ACON1);
+
+	/* The following comes from original windows driver.
+	   It is needed to have a correct behavior of input and output
+	   simultenously, but I don't know why ! */
+	WRITEREG(3 * (BurstA1_in) + 3 * (ThreshA1_in) +
+		 3 * (BurstA1_out) + 3 * (ThreshA1_out) +
+		 3 * (BurstA2_out) + 3 * (ThreshA2_out), PCI_BT_A);
+
+	/* enable audio port pins */
+	WRITEREG((EAP << 16) | EAP, MC1);
+
+	/* enable I2C */
+	WRITEREG((EI2C << 16) | EI2C, MC1);
+	/* enable interrupts */
+	WRITEREG(A1_out | A2_out | A1_in | IIC_S | IIC_E, IER);
+
+	/* audio configuration */
+	acon2 = A2_CLKSRC | BCLK1_OEN;
+	WRITEREG(acon2, ACON2);
+
+	/* By default use analog input */
+	snd_aw2_saa7146_use_digital_input(chip, 0);
+
+	/* TSL setup */
+	for (i = 0; i < 8; ++i) {
+		WRITEREG(tsl1[i], TSL1 + (i * 4));
+		WRITEREG(tsl2[i], TSL2 + (i * 4));
+	}
+
+}
+
+void snd_aw2_saa7146_pcm_init_playback(struct snd_aw2_saa7146 *chip,
+				       int stream_number,
+				       unsigned long dma_addr,
+				       unsigned long period_size,
+				       unsigned long buffer_size)
+{
+	unsigned long dw_page, dw_limit;
+
+	/* Configure DMA for substream
+	   Configuration informations: ALSA has allocated continuous memory
+	   pages. So we don't need to use MMU of saa7146.
+	 */
+
+	/* No MMU -> nothing to do with PageA1, we only configure the limit of
+	   PageAx_out register */
+	/* Disable MMU */
+	dw_page = (0L << 11);
+
+	/* Configure Limit for DMA access.
+	   The limit register defines an address limit, which generates
+	   an interrupt if passed by the actual PCI address pointer.
+	   '0001' means an interrupt will be generated if the lower
+	   6 bits (64 bytes) of the PCI address are zero. '0010'
+	   defines a limit of 128 bytes, '0011' one of 256 bytes, and
+	   so on up to 1 Mbyte defined by '1111'. This interrupt range
+	   can be calculated as follows:
+	   Range = 2^(5 + Limit) bytes.
+	 */
+	dw_limit = snd_aw2_saa7146_get_limit(period_size);
+	dw_page |= (dw_limit << 4);
+
+	if (stream_number == 0) {
+		WRITEREG(dw_page, PageA2_out);
+
+		/* Base address for DMA transfert. */
+		/* This address has been reserved by ALSA. */
+		/* This is a physical address */
+		WRITEREG(dma_addr, BaseA2_out);
+
+		/* Define upper limit for DMA access */
+		WRITEREG(dma_addr + buffer_size, ProtA2_out);
+
+	} else if (stream_number == 1) {
+		WRITEREG(dw_page, PageA1_out);
+
+		/* Base address for DMA transfert. */
+		/* This address has been reserved by ALSA. */
+		/* This is a physical address */
+		WRITEREG(dma_addr, BaseA1_out);
+
+		/* Define upper limit for DMA access */
+		WRITEREG(dma_addr + buffer_size, ProtA1_out);
+	} else {
+		printk(KERN_ERR
+		       "aw2: snd_aw2_saa7146_pcm_init_playback: "
+		       "Substream number is not 0 or 1 -> not managed\n");
+	}
+}
+
+void snd_aw2_saa7146_pcm_init_capture(struct snd_aw2_saa7146 *chip,
+				      int stream_number, unsigned long dma_addr,
+				      unsigned long period_size,
+				      unsigned long buffer_size)
+{
+	unsigned long dw_page, dw_limit;
+
+	/* Configure DMA for substream
+	   Configuration informations: ALSA has allocated continuous memory
+	   pages. So we don't need to use MMU of saa7146.
+	 */
+
+	/* No MMU -> nothing to do with PageA1, we only configure the limit of
+	   PageAx_out register */
+	/* Disable MMU */
+	dw_page = (0L << 11);
+
+	/* Configure Limit for DMA access.
+	   The limit register defines an address limit, which generates
+	   an interrupt if passed by the actual PCI address pointer.
+	   '0001' means an interrupt will be generated if the lower
+	   6 bits (64 bytes) of the PCI address are zero. '0010'
+	   defines a limit of 128 bytes, '0011' one of 256 bytes, and
+	   so on up to 1 Mbyte defined by '1111'. This interrupt range
+	   can be calculated as follows:
+	   Range = 2^(5 + Limit) bytes.
+	 */
+	dw_limit = snd_aw2_saa7146_get_limit(period_size);
+	dw_page |= (dw_limit << 4);
+
+	if (stream_number == 0) {
+		WRITEREG(dw_page, PageA1_in);
+
+		/* Base address for DMA transfert. */
+		/* This address has been reserved by ALSA. */
+		/* This is a physical address */
+		WRITEREG(dma_addr, BaseA1_in);
+
+		/* Define upper limit for DMA access  */
+		WRITEREG(dma_addr + buffer_size, ProtA1_in);
+	} else {
+		printk(KERN_ERR
+		       "aw2: snd_aw2_saa7146_pcm_init_capture: "
+		       "Substream number is not 0 -> not managed\n");
+	}
+}
+
+void snd_aw2_saa7146_define_it_playback_callback(unsigned int stream_number,
+						 snd_aw2_saa7146_it_cb
+						 p_it_callback,
+						 void *p_callback_param)
+{
+	if (stream_number < NB_STREAM_PLAYBACK) {
+		arr_substream_it_playback_cb[stream_number].p_it_callback =
+		    (snd_aw2_saa7146_it_cb) p_it_callback;
+		arr_substream_it_playback_cb[stream_number].p_callback_param =
+		    (void *)p_callback_param;
+	}
+}
+
+void snd_aw2_saa7146_define_it_capture_callback(unsigned int stream_number,
+						snd_aw2_saa7146_it_cb
+						p_it_callback,
+						void *p_callback_param)
+{
+	if (stream_number < NB_STREAM_CAPTURE) {
+		arr_substream_it_capture_cb[stream_number].p_it_callback =
+		    (snd_aw2_saa7146_it_cb) p_it_callback;
+		arr_substream_it_capture_cb[stream_number].p_callback_param =
+		    (void *)p_callback_param;
+	}
+}
+
+void snd_aw2_saa7146_pcm_trigger_start_playback(struct snd_aw2_saa7146 *chip,
+						int stream_number)
+{
+	unsigned int acon1 = 0;
+	/* In aw8 driver, dma transfert is always active. It is
+	   started and stopped in a larger "space" */
+	acon1 = READREG(ACON1);
+	if (stream_number == 0) {
+		WRITEREG((TR_E_A2_OUT << 16) | TR_E_A2_OUT, MC1);
+
+		/* WS2_CTRL, WS2_SYNC: output TSL2, I2S */
+		acon1 |= 2 * WS2_CTRL;
+		WRITEREG(acon1, ACON1);
+
+	} else if (stream_number == 1) {
+		WRITEREG((TR_E_A1_OUT << 16) | TR_E_A1_OUT, MC1);
+
+		/* WS1_CTRL, WS1_SYNC: output TSL1, I2S */
+		acon1 |= 1 * WS1_CTRL;
+		WRITEREG(acon1, ACON1);
+	}
+}
+
+void snd_aw2_saa7146_pcm_trigger_stop_playback(struct snd_aw2_saa7146 *chip,
+					       int stream_number)
+{
+	unsigned int acon1 = 0;
+	acon1 = READREG(ACON1);
+	if (stream_number == 0) {
+		/* WS2_CTRL, WS2_SYNC: output TSL2, I2S */
+		acon1 &= ~(3 * WS2_CTRL);
+		WRITEREG(acon1, ACON1);
+
+		WRITEREG((TR_E_A2_OUT << 16), MC1);
+	} else if (stream_number == 1) {
+		/* WS1_CTRL, WS1_SYNC: output TSL1, I2S */
+		acon1 &= ~(3 * WS1_CTRL);
+		WRITEREG(acon1, ACON1);
+
+		WRITEREG((TR_E_A1_OUT << 16), MC1);
+	}
+}
+
+void snd_aw2_saa7146_pcm_trigger_start_capture(struct snd_aw2_saa7146 *chip,
+					       int stream_number)
+{
+	/* In aw8 driver, dma transfert is always active. It is
+	   started and stopped in a larger "space" */
+	if (stream_number == 0)
+		WRITEREG((TR_E_A1_IN << 16) | TR_E_A1_IN, MC1);
+}
+
+void snd_aw2_saa7146_pcm_trigger_stop_capture(struct snd_aw2_saa7146 *chip,
+					      int stream_number)
+{
+	if (stream_number == 0)
+		WRITEREG((TR_E_A1_IN << 16), MC1);
+}
+
+irqreturn_t snd_aw2_saa7146_interrupt(int irq, void *dev_id)
+{
+	unsigned int isr;
+	unsigned int iicsta;
+	struct snd_aw2_saa7146 *chip = dev_id;
+
+	isr = READREG(ISR);
+	if (!isr)
+		return IRQ_NONE;
+
+	WRITEREG(isr, ISR);
+
+	if (isr & (IIC_S | IIC_E)) {
+		iicsta = READREG(IICSTA);
+		WRITEREG(0x100, IICSTA);
+	}
+
+	if (isr & A1_out) {
+		if (arr_substream_it_playback_cb[1].p_it_callback != NULL) {
+			arr_substream_it_playback_cb[1].
+			    p_it_callback(arr_substream_it_playback_cb[1].
+					  p_callback_param);
+		}
+	}
+	if (isr & A2_out) {
+		if (arr_substream_it_playback_cb[0].p_it_callback != NULL) {
+			arr_substream_it_playback_cb[0].
+			    p_it_callback(arr_substream_it_playback_cb[0].
+					  p_callback_param);
+		}
+
+	}
+	if (isr & A1_in) {
+		if (arr_substream_it_capture_cb[0].p_it_callback != NULL) {
+			arr_substream_it_capture_cb[0].
+			    p_it_callback(arr_substream_it_capture_cb[0].
+					  p_callback_param);
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+unsigned int snd_aw2_saa7146_get_hw_ptr_playback(struct snd_aw2_saa7146 *chip,
+						 int stream_number,
+						 unsigned char *start_addr,
+						 unsigned int buffer_size)
+{
+	long pci_adp = 0;
+	size_t ptr = 0;
+
+	if (stream_number == 0) {
+		pci_adp = READREG(PCI_ADP3);
+		ptr = pci_adp - (long)start_addr;
+
+		if (ptr == buffer_size)
+			ptr = 0;
+	}
+	if (stream_number == 1) {
+		pci_adp = READREG(PCI_ADP1);
+		ptr = pci_adp - (size_t) start_addr;
+
+		if (ptr == buffer_size)
+			ptr = 0;
+	}
+	return ptr;
+}
+
+unsigned int snd_aw2_saa7146_get_hw_ptr_capture(struct snd_aw2_saa7146 *chip,
+						int stream_number,
+						unsigned char *start_addr,
+						unsigned int buffer_size)
+{
+	size_t pci_adp = 0;
+	size_t ptr = 0;
+	if (stream_number == 0) {
+		pci_adp = READREG(PCI_ADP2);
+		ptr = pci_adp - (size_t) start_addr;
+
+		if (ptr == buffer_size)
+			ptr = 0;
+	}
+	return ptr;
+}
+
+void snd_aw2_saa7146_use_digital_input(struct snd_aw2_saa7146 *chip,
+				       int use_digital)
+{
+	/* FIXME: switch between analog and digital input does not always work.
+	   It can produce a kind of white noise. It seams that received data
+	   are inverted sometime (endian inversion). Why ? I don't know, maybe
+	   a problem of synchronization... However for the time being I have
+	   not found the problem. Workaround: switch again (and again) between
+	   digital and analog input until it works. */
+	if (use_digital)
+		WRITEREG(0x40, GPIO_CTRL);
+	else
+		WRITEREG(0x50, GPIO_CTRL);
+}
+
+int snd_aw2_saa7146_is_using_digital_input(struct snd_aw2_saa7146 *chip)
+{
+	unsigned int reg_val = READREG(GPIO_CTRL);
+	if ((reg_val & 0xFF) == 0x40)
+		return 1;
+	else
+		return 0;
+}
+
+
+static int snd_aw2_saa7146_get_limit(int size)
+{
+	int limitsize = 32;
+	int limit = 0;
+	while (limitsize < size) {
+		limitsize *= 2;
+		limit++;
+	}
+	return limit;
+}
diff --git a/sound/pci/aw2/aw2-saa7146.h b/sound/pci/aw2/aw2-saa7146.h
new file mode 100644
index 0000000..5b35e35
--- /dev/null
+++ b/sound/pci/aw2/aw2-saa7146.h
@@ -0,0 +1,105 @@
+/*****************************************************************************
+ *
+ * Copyright (C) 2008 Cedric Bregardis <cedric.bregardis@free.fr> and
+ * Jean-Christian Hassler <jhassler@free.fr>
+ *
+ * This file is part of the Audiowerk2 ALSA driver
+ *
+ * The Audiowerk2 ALSA driver is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2.
+ *
+ * The Audiowerk2 ALSA driver is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with the Audiowerk2 ALSA driver; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
+ * USA.
+ *
+ *****************************************************************************/
+
+#ifndef AW2_SAA7146_H
+#define AW2_SAA7146_H
+
+#define NB_STREAM_PLAYBACK 2
+#define NB_STREAM_CAPTURE 1
+
+#define NUM_STREAM_PLAYBACK_ANA 0
+#define NUM_STREAM_PLAYBACK_DIG 1
+
+#define NUM_STREAM_CAPTURE_ANA 0
+
+typedef void (*snd_aw2_saa7146_it_cb) (void *);
+
+struct snd_aw2_saa7146_cb_param {
+	snd_aw2_saa7146_it_cb p_it_callback;
+	void *p_callback_param;
+};
+
+/* definition of the chip-specific record */
+
+struct snd_aw2_saa7146 {
+	void __iomem *base_addr;
+};
+
+extern void snd_aw2_saa7146_setup(struct snd_aw2_saa7146 *chip,
+				  void __iomem *pci_base_addr);
+extern int snd_aw2_saa7146_free(struct snd_aw2_saa7146 *chip);
+
+extern void snd_aw2_saa7146_pcm_init_playback(struct snd_aw2_saa7146 *chip,
+					      int stream_number,
+					      unsigned long dma_addr,
+					      unsigned long period_size,
+					      unsigned long buffer_size);
+extern void snd_aw2_saa7146_pcm_init_capture(struct snd_aw2_saa7146 *chip,
+					     int stream_number,
+					     unsigned long dma_addr,
+					     unsigned long period_size,
+					     unsigned long buffer_size);
+extern void snd_aw2_saa7146_define_it_playback_callback(unsigned int
+							stream_number,
+							snd_aw2_saa7146_it_cb
+							p_it_callback,
+							void *p_callback_param);
+extern void snd_aw2_saa7146_define_it_capture_callback(unsigned int
+						       stream_number,
+						       snd_aw2_saa7146_it_cb
+						       p_it_callback,
+						       void *p_callback_param);
+extern void snd_aw2_saa7146_pcm_trigger_start_capture(struct snd_aw2_saa7146
+						      *chip, int stream_number);
+extern void snd_aw2_saa7146_pcm_trigger_stop_capture(struct snd_aw2_saa7146
+						     *chip, int stream_number);
+
+extern void snd_aw2_saa7146_pcm_trigger_start_playback(struct snd_aw2_saa7146
+						       *chip,
+						       int stream_number);
+extern void snd_aw2_saa7146_pcm_trigger_stop_playback(struct snd_aw2_saa7146
+						      *chip, int stream_number);
+
+extern irqreturn_t snd_aw2_saa7146_interrupt(int irq, void *dev_id);
+extern unsigned int snd_aw2_saa7146_get_hw_ptr_playback(struct snd_aw2_saa7146
+							*chip,
+							int stream_number,
+							unsigned char
+							*start_addr,
+							unsigned int
+							buffer_size);
+extern unsigned int snd_aw2_saa7146_get_hw_ptr_capture(struct snd_aw2_saa7146
+						       *chip,
+						       int stream_number,
+						       unsigned char
+						       *start_addr,
+						       unsigned int
+						       buffer_size);
+
+extern void snd_aw2_saa7146_use_digital_input(struct snd_aw2_saa7146 *chip,
+					      int use_digital);
+
+extern int snd_aw2_saa7146_is_using_digital_input(struct snd_aw2_saa7146
+						  *chip);
+
+#endif
diff --git a/sound/pci/aw2/aw2-tsl.h b/sound/pci/aw2/aw2-tsl.h
new file mode 100644
index 0000000..e8afaa0
--- /dev/null
+++ b/sound/pci/aw2/aw2-tsl.h
@@ -0,0 +1,116 @@
+/*****************************************************************************
+ *
+ * Copyright (C) 2008 Cedric Bregardis <cedric.bregardis@free.fr> and
+ * Jean-Christian Hassler <jhassler@free.fr>
+ * Copyright 1998 Emagic Soft- und Hardware GmbH
+ * Copyright 2002 Martijn Sipkema
+ *
+ * This file is part of the Audiowerk2 ALSA driver
+ *
+ * The Audiowerk2 ALSA driver is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2.
+ *
+ * The Audiowerk2 ALSA driver is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with the Audiowerk2 ALSA driver; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
+ * USA.
+ *
+ *****************************************************************************/
+
+#define TSL_WS0		(1UL << 31)
+#define	TSL_WS1		(1UL << 30)
+#define	TSL_WS2		(1UL << 29)
+#define TSL_WS3		(1UL << 28)
+#define TSL_WS4		(1UL << 27)
+#define	TSL_DIS_A1	(1UL << 24)
+#define TSL_SDW_A1	(1UL << 23)
+#define TSL_SIB_A1	(1UL << 22)
+#define TSL_SF_A1	(1UL << 21)
+#define	TSL_LF_A1	(1UL << 20)
+#define TSL_BSEL_A1	(1UL << 17)
+#define TSL_DOD_A1	(1UL << 15)
+#define TSL_LOW_A1	(1UL << 14)
+#define TSL_DIS_A2	(1UL << 11)
+#define TSL_SDW_A2	(1UL << 10)
+#define TSL_SIB_A2	(1UL << 9)
+#define TSL_SF_A2	(1UL << 8)
+#define TSL_LF_A2	(1UL << 7)
+#define TSL_BSEL_A2	(1UL << 4)
+#define TSL_DOD_A2	(1UL << 2)
+#define TSL_LOW_A2	(1UL << 1)
+#define TSL_EOS		(1UL << 0)
+
+    /* Audiowerk8 hardware setup: */
+    /*      WS0, SD4, TSL1  - Analog/ digital in */
+    /*      WS1, SD0, TSL1  - Analog out #1, digital out */
+    /*      WS2, SD2, TSL1  - Analog out #2 */
+    /*      WS3, SD1, TSL2  - Analog out #3 */
+    /*      WS4, SD3, TSL2  - Analog out #4 */
+
+    /* Audiowerk8 timing: */
+    /*      Timeslot:     | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | ... */
+
+    /*      A1_INPUT: */
+    /*      SD4:          <_ADC-L_>-------<_ADC-R_>-------< */
+    /*      WS0:          _______________/---------------\_ */
+
+    /*      A1_OUTPUT: */
+    /*      SD0:          <_1-L___>-------<_1-R___>-------< */
+    /*      WS1:          _______________/---------------\_ */
+    /*      SD2:          >-------<_2-L___>-------<_2-R___> */
+    /*      WS2:          -------\_______________/--------- */
+
+    /*      A2_OUTPUT: */
+    /*      SD1:          <_3-L___>-------<_3-R___>-------< */
+    /*      WS3:          _______________/---------------\_ */
+    /*      SD3:          >-------<_4-L___>-------<_4-R___> */
+    /*      WS4:          -------\_______________/--------- */
+
+#ifdef __BIG_ENDIAN
+    /* TODO: not yet implemented */
+#else /*  */
+
+static int tsl1[8] = {
+	1 * TSL_SDW_A1 | 3 * TSL_BSEL_A1 |
+	0 * TSL_DIS_A1 | 0 * TSL_DOD_A1 | TSL_LF_A1,
+
+	1 * TSL_SDW_A1 | 2 * TSL_BSEL_A1 |
+	0 * TSL_DIS_A1 | 0 * TSL_DOD_A1,
+
+	0 * TSL_SDW_A1 | 3 * TSL_BSEL_A1 |
+	0 * TSL_DIS_A1 | 0 * TSL_DOD_A1,
+
+	0 * TSL_SDW_A1 | 2 * TSL_BSEL_A1 |
+	0 * TSL_DIS_A1 | 0 * TSL_DOD_A1,
+
+	1 * TSL_SDW_A1 | 1 * TSL_BSEL_A1 |
+	0 * TSL_DIS_A1 | 0 * TSL_DOD_A1 | TSL_WS1 | TSL_WS0,
+
+	1 * TSL_SDW_A1 | 0 * TSL_BSEL_A1 |
+	0 * TSL_DIS_A1 | 0 * TSL_DOD_A1 | TSL_WS1 | TSL_WS0,
+
+	0 * TSL_SDW_A1 | 1 * TSL_BSEL_A1 |
+	0 * TSL_DIS_A1 | 0 * TSL_DOD_A1 | TSL_WS1 | TSL_WS0,
+
+	0 * TSL_SDW_A1 | 0 * TSL_BSEL_A1 | 0 * TSL_DIS_A1 |
+	0 * TSL_DOD_A1 | TSL_WS1 | TSL_WS0 | TSL_SF_A1 | TSL_EOS,
+};
+
+static int tsl2[8] = {
+	0 * TSL_SDW_A2 | 3 * TSL_BSEL_A2 | 2 * TSL_DOD_A2 | TSL_LF_A2,
+	0 * TSL_SDW_A2 | 2 * TSL_BSEL_A2 | 2 * TSL_DOD_A2,
+	0 * TSL_SDW_A2 | 3 * TSL_BSEL_A2 | 2 * TSL_DOD_A2,
+	0 * TSL_SDW_A2 | 2 * TSL_BSEL_A2 | 2 * TSL_DOD_A2,
+	0 * TSL_SDW_A2 | 1 * TSL_BSEL_A2 | 2 * TSL_DOD_A2 | TSL_WS2,
+	0 * TSL_SDW_A2 | 0 * TSL_BSEL_A2 | 2 * TSL_DOD_A2 | TSL_WS2,
+	0 * TSL_SDW_A2 | 1 * TSL_BSEL_A2 | 2 * TSL_DOD_A2 | TSL_WS2,
+	0 * TSL_SDW_A2 | 0 * TSL_BSEL_A2 | 2 * TSL_DOD_A2 | TSL_WS2 | TSL_EOS
+};
+
+#endif /*  */
diff --git a/sound/pci/aw2/saa7146.h b/sound/pci/aw2/saa7146.h
new file mode 100644
index 0000000..ce0ab5f
--- /dev/null
+++ b/sound/pci/aw2/saa7146.h
@@ -0,0 +1,168 @@
+/*****************************************************************************
+ *
+ * Copyright (C) 2008 Cedric Bregardis <cedric.bregardis@free.fr> and
+ * Jean-Christian Hassler <jhassler@free.fr>
+ *
+ * This file is part of the Audiowerk2 ALSA driver
+ *
+ * The Audiowerk2 ALSA driver is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2.
+ *
+ * The Audiowerk2 ALSA driver is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with the Audiowerk2 ALSA driver; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
+ * USA.
+ *
+ *****************************************************************************/
+
+/* SAA7146 registers */
+#define PCI_BT_A	0x4C
+#define IICTFR		0x8C
+#define IICSTA		0x90
+#define BaseA1_in	0x94
+#define ProtA1_in	0x98
+#define PageA1_in	0x9C
+#define BaseA1_out	0xA0
+#define ProtA1_out	0xA4
+#define PageA1_out	0xA8
+#define BaseA2_in	0xAC
+#define ProtA2_in	0xB0
+#define PageA2_in	0xB4
+#define BaseA2_out	0xB8
+#define ProtA2_out	0xBC
+#define PageA2_out	0xC0
+#define IER		0xDC
+#define GPIO_CTRL	0xE0
+#define ACON1		0xF4
+#define ACON2		0xF8
+#define MC1		0xFC
+#define MC2		0x100
+#define ISR		0x10C
+#define PSR		0x110
+#define SSR		0x114
+#define PCI_ADP1	0x12C
+#define PCI_ADP2	0x130
+#define PCI_ADP3	0x134
+#define PCI_ADP4	0x138
+#define LEVEL_REP	0x140
+#define FB_BUFFER1	0x144
+#define FB_BUFFER2	0x148
+#define TSL1		0x180
+#define TSL2		0x1C0
+
+#define ME	(1UL << 11)
+#define LIMIT	(1UL << 4)
+#define PV	(1UL << 3)
+
+/* PSR/ISR/IER */
+#define PPEF		(1UL << 31)
+#define PABO		(1UL << 30)
+#define IIC_S		(1UL << 17)
+#define IIC_E		(1UL << 16)
+#define A2_in		(1UL << 15)
+#define A2_out		(1UL << 14)
+#define A1_in		(1UL << 13)
+#define A1_out		(1UL << 12)
+#define AFOU		(1UL << 11)
+#define PIN3		(1UL << 6)
+#define PIN2		(1UL << 5)
+#define PIN1		(1UL << 4)
+#define PIN0		(1UL << 3)
+#define ECS		(1UL << 2)
+#define EC3S		(1UL << 1)
+#define EC0S		(1UL << 0)
+
+/* SSR */
+#define PRQ		(1UL << 31)
+#define PMA		(1UL << 30)
+#define IIC_EA		(1UL << 21)
+#define IIC_EW		(1UL << 20)
+#define IIC_ER		(1UL << 19)
+#define IIC_EL		(1UL << 18)
+#define IIC_EF		(1UL << 17)
+#define AF2_in		(1UL << 10)
+#define AF2_out		(1UL << 9)
+#define AF1_in		(1UL << 8)
+#define AF1_out		(1UL << 7)
+#define EC5S		(1UL << 3)
+#define EC4S		(1UL << 2)
+#define EC2S		(1UL << 1)
+#define EC1S		(1UL << 0)
+
+/* PCI_BT_A */
+#define BurstA1_in	(1UL << 26)
+#define ThreshA1_in	(1UL << 24)
+#define BurstA1_out	(1UL << 18)
+#define ThreshA1_out	(1UL << 16)
+#define BurstA2_in	(1UL << 10)
+#define ThreshA2_in	(1UL << 8)
+#define BurstA2_out	(1UL << 2)
+#define ThreshA2_out	(1UL << 0)
+
+/* MC1 */
+#define MRST_N		(1UL << 15)
+#define EAP		(1UL << 9)
+#define EI2C		(1UL << 8)
+#define TR_E_A2_OUT	(1UL << 3)
+#define TR_E_A2_IN	(1UL << 2)
+#define TR_E_A1_OUT	(1UL << 1)
+#define TR_E_A1_IN	(1UL << 0)
+
+/* MC2 */
+#define UPLD_IIC	(1UL << 0)
+
+/* ACON1 */
+#define AUDIO_MODE	(1UL << 29)
+#define MAXLEVEL	(1UL << 22)
+#define A1_SWAP		(1UL << 21)
+#define A2_SWAP		(1UL << 20)
+#define WS0_CTRL	(1UL << 18)
+#define WS0_SYNC	(1UL << 16)
+#define WS1_CTRL	(1UL << 14)
+#define WS1_SYNC	(1UL << 12)
+#define WS2_CTRL	(1UL << 10)
+#define WS2_SYNC	(1UL << 8)
+#define WS3_CTRL	(1UL << 6)
+#define WS3_SYNC	(1UL << 4)
+#define WS4_CTRL	(1UL << 2)
+#define WS4_SYNC	(1UL << 0)
+
+/* ACON2 */
+#define A1_CLKSRC	(1UL << 27)
+#define A2_CLKSRC	(1UL << 22)
+#define INVERT_BCLK1	(1UL << 21)
+#define INVERT_BCLK2	(1UL << 20)
+#define BCLK1_OEN	(1UL << 19)
+#define BCLK2_OEN	(1UL << 18)
+
+/* IICSTA */
+#define IICCC		(1UL << 8)
+#define ABORT		(1UL << 7)
+#define SPERR		(1UL << 6)
+#define APERR		(1UL << 5)
+#define DTERR		(1UL << 4)
+#define DRERR		(1UL << 3)
+#define AL		(1UL << 2)
+#define ERR		(1UL << 1)
+#define BUSY		(1UL << 0)
+
+/* IICTFR */
+#define BYTE2		(1UL << 24)
+#define BYTE1		(1UL << 16)
+#define BYTE0		(1UL << 8)
+#define ATRR2		(1UL << 6)
+#define ATRR1		(1UL << 4)
+#define ATRR0		(1UL << 2)
+#define ERR		(1UL << 1)
+#define BUSY		(1UL << 0)
+
+#define START	3
+#define CONT	2
+#define STOP	1
+#define NOP	0
--
1.5.2.5


--Boundary-00=_rt0uHXSD+mRtT7I
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_rt0uHXSD+mRtT7I--
