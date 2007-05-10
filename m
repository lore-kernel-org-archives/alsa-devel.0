From: Rene Herman <rene.herman@gmail.com>
Subject: Re: Can someone verify support for "AzTech Sound
 Galaxy Nova 16 Extra II-3D - using AZT-2316/R Chipset - FCC-ID:I38-MMSN846"
 ?
Date: Thu, 10 May 2007 16:56:07 +0200
Message-ID: <46433287.3020003@gmail.com>
References: <20070507054604.75A781CE303@ws1-6.us4.outblaze.com>
	<463F914C.7090600@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040407040708050006010406"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F64924398
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 16:58:38 +0200 (CEST)
In-Reply-To: <463F914C.7090600@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ramkromberg@mail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040407040708050006010406
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 05/07/2007 10:51 PM, Rene Herman wrote:

> As you have noticed, snd-sgalaxy will not work for this card. "sgalaxy" 
> is actually a really unfortunate name for that driver as Aztech named 
> _all_ their cards "Sound Galaxy" and snd-sgalaxy only drives the couple 
> with a AZT1605 chip on them.

Actually, snd-sgalaxy doesn't work for the AZT2316A cards that I've tried it 
with (two different types) but it _does_ in fact work for my AZT2316R based 
"Sound Galaxy Waverider Pro 32-3D" (I38-MMSN852) that is a very close match 
to your "Nova 16 Extra II-3D" (I38-MMSN846).

Please first make sure the EEPROM on the card contains sensible values for 
which you'll unfortunately need the DOS utilities (once). They can be had from:

ftp://ftp.aztech.com/download/sg/NOV16EII

After installation, C:\FOO\UTILITY\ contains CONFIG.EXE, HWSET.EXE, 
VOLSET.EXE, DIAGNOSE.EXE, ...

Running "HWSET /MR /MS" (and "VOLSET /MR /MS") will restore factory default 
values to the EEPROM which means SB = 0x220, irq 5, dma 1 and WSS = 0x530.

The DOS utilities use IRQ 10 as the WSS IRQ but that one didn't work under 
Linux for me. Too many possible reasons why not though, so try it. The WSS 
part can be configured on IRQ 7, 9, 10 and 11 and 7 worked for me. Make sure 
you also set your BIOS to reserve this IRQ and the SB IRQ and DMA (which the 
WSS part shares) for "legacy ISA".

When you've done that (or they were sensible to start with) you should both 
be able to load snd-sb8 as adviced in the previous message:

	modprobe snd-sb8 port=0x220 irq=5 dma8=1

and snd-sgalaxy for access to the WSS part:

	modprobe snd-sgalaxy sbport=0x220 wssport=0x530

The sgalaxy driver will grab IRQ7 when it's free.

But...

Before I noticed that sgalaxy would in fact work on my 2316R I had already 
done most of a new "azt2316" driver. Filling in the hardware details showed 
that sgalaxy actually worked for the 2316R (again, not for my 2316A cards).

snd-sgalaxy is not a nice driver so I did complete it and renamed it to 
snd-azt1605. It's attached as a patch against kernel 2.6.21. If you don't 
know what that means or what to do with it, never mind, both sb8 and sgalaxy 
should as said also work.

The attached driver is a bit better in so far that it keeps the SB part 
reserved after switching to WSS (we don't want anyone resetting our bus 
interface out from under us while we're happily playing MP3s), provides 
access to the onboard MPU-401 (MIDI port) and OPL3 (FM synthesis chip) and 
allows to tell the driver where you want the wss_irq yourself. If you want 
to try it out, it should be loaded as:

	modprobe snd-azt1605 port=0x220 irq=5 dma=1 wss_port=0x530 wss_irq=7

Also specify mpu_port=0x330 (and possibly mpu_irq=9) and fm_port=0x388 if 
you want MPU-401 and OPL3 enabled.

It's been only quickly tested on AZT1605 and AZT2316R and I'm not submitting 
this or anything. AZT2316A not working is probably something small but it's 
going to need trial & error and/or poking around in the DOS utilities and I 
don't have time for either at the moment.

It does show promise for eventually having one unified snd-galaxy driver (I 
hate that s!) with AZT2320 folded back in as well...

Hope this helps.

Rene.

--------------040407040708050006010406
Content-Type: text/plain;
 name="azt1605.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="azt1605.diff"

diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index 4e3a972..d7bb734 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -63,6 +63,19 @@ config SND_ALS100
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-als100.
 
+config SND_AZT1605
+	tristate "Aztech AZT1605/2316 Driver"
+	depends on SND
+	select SND_CS4231_LIB
+	select SND_MPU401_UART
+	select SND_OPL3_LIB
+	help
+	  Say Y here to include support for Aztech AZT1605/2316 based
+	  soundcards.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-azt1605.
+
 config SND_AZT2320
 	tristate "Aztech Systems AZT2320"
 	depends on SND && PNP && ISA
diff --git a/sound/isa/sb/Makefile b/sound/isa/sb/Makefile
index fd9d9c5..73912bf 100644
--- a/sound/isa/sb/Makefile
+++ b/sound/isa/sb/Makefile
@@ -12,6 +12,7 @@ snd-sb16-objs := sb16.o
 snd-sbawe-objs := sbawe.o emu8000.o
 snd-emu8000-synth-objs := emu8000_synth.o emu8000_callback.o emu8000_patch.o emu8000_pcm.o
 snd-es968-objs := es968.o
+snd-azt1605-objs := azt1605.o
 
 #
 # this function returns:
@@ -23,6 +24,7 @@ sequencer = $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(1),m),$(if $(CONFIG_
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_ALS100) += snd-sb16-dsp.o snd-sb-common.o
+obj-$(CONFIG_SND_AZT1605) += snd-azt1605.o snd-sb8-dsp.o snd-sb-common.o
 obj-$(CONFIG_SND_CMI8330) += snd-sb16-dsp.o snd-sb-common.o
 obj-$(CONFIG_SND_DT019X) += snd-sb16-dsp.o snd-sb-common.o
 obj-$(CONFIG_SND_SB8) += snd-sb8.o snd-sb8-dsp.o snd-sb-common.o
diff --git a/sound/isa/sb/azt1605.c b/sound/isa/sb/azt1605.c
new file mode 100644
index 0000000..7eeac01
--- /dev/null
+++ b/sound/isa/sb/azt1605.c
@@ -0,0 +1,350 @@
+/*
+ * Aztech AZT1605 Driver (also works for AZT2316R, not AZT2316A)
+ */
+
+#include <sound/driver.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/isa.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/sb.h>
+#include <sound/cs4231.h>
+#include <sound/mpu401.h>
+#include <sound/opl3.h>
+
+#define CRD_NAME "Aztech AZT1605"
+#define DRV_NAME "AZT1605"
+#define DEV_NAME "azt1605"
+
+MODULE_DESCRIPTION(CRD_NAME);
+MODULE_AUTHOR("Rene Herman");
+MODULE_LICENSE("GPL");
+
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;
+
+module_param_array(index, int, NULL, 0444);
+MODULE_PARM_DESC(index, "Index value for " CRD_NAME " soundcard.");
+module_param_array(id, charp, NULL, 0444);
+MODULE_PARM_DESC(id, "ID string for " CRD_NAME " soundcard.");
+module_param_array(enable, bool, NULL, 0444);
+MODULE_PARM_DESC(enable, "Enable " CRD_NAME " soundcard.");
+
+static long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
+static long wss_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
+static long mpu_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
+static long fm_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
+static int irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;
+static int wss_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;
+static int mpu_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;
+static int dma[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;
+
+module_param_array(port, long, NULL, 0444);
+MODULE_PARM_DESC(port, "Port # for " CRD_NAME " driver.");
+module_param_array(wss_port, long, NULL, 0444);
+MODULE_PARM_DESC(wss_port, "WSS port # for " CRD_NAME " driver.");
+module_param_array(mpu_port, long, NULL, 0444);
+MODULE_PARM_DESC(mpu_port, "MPU-401 port # for " CRD_NAME " driver.");
+module_param_array(fm_port, long, NULL, 0444);
+MODULE_PARM_DESC(fm_port, "OPL3 port # for " CRD_NAME " driver.");
+module_param_array(irq, int, NULL, 0444);
+MODULE_PARM_DESC(irq, "IRQ # for " CRD_NAME " driver.");
+module_param_array(wss_irq, int, NULL, 0444);
+MODULE_PARM_DESC(wss_irq, "WSS IRQ # for " CRD_NAME " driver.");
+module_param_array(mpu_irq, int, NULL, 0444);
+MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for " CRD_NAME " driver.");
+module_param_array(dma, int, NULL, 0444);
+MODULE_PARM_DESC(dma, "DMA # for " CRD_NAME " driver.");
+
+static int __devinit snd_azt1605_match(struct device *dev, unsigned int n)
+{
+	int match = enable[n];
+
+	if (!match)
+		goto out;
+
+	match = port[n] != SNDRV_AUTO_PORT;
+	if (!match) {
+		snd_printk(KERN_ERR "%s: please specify port\n", dev->bus_id);
+		goto out;
+	}
+
+	match = irq[n] != SNDRV_AUTO_IRQ;
+	if (!match) {
+		snd_printk(KERN_ERR "%s: please specify irq\n", dev->bus_id);
+		goto out;
+	}
+
+	match = dma[n] != SNDRV_AUTO_DMA;
+	if (!match) {
+		snd_printk(KERN_ERR "%s: please specify dma\n", dev->bus_id);
+		goto out;
+	}
+
+	if (wss_port[n] != SNDRV_AUTO_PORT) {
+		match = wss_irq[n] != SNDRV_AUTO_IRQ;
+		if (!match) {
+			snd_printk(KERN_ERR "%s: please specify wss_irq\n",
+				   dev->bus_id);
+			goto out;
+		}
+		match = wss_irq[n] != irq[n];
+		if (!match) {
+			snd_printk(KERN_ERR "%s: cannot share IRQ between SB "
+				   "and WSS\n", dev->bus_id);
+			goto out;
+		}
+	} else {
+		snd_printk(KERN_WARNING "%s: wss_port not specified: using SB "
+			   "mode\n", dev->bus_id);
+		wss_port[n] = -1;
+	}
+
+	if (mpu_port[n] != SNDRV_AUTO_PORT) {
+		if (mpu_irq[n] == SNDRV_AUTO_IRQ) {
+			snd_printk(KERN_WARNING "%s: mpu_irq not specified: "
+				   "using polling mode\n", dev->bus_id);
+			mpu_irq[n] = -1;
+		}
+	} else {
+		snd_printk(KERN_WARNING "%s: mpu_port not specified: not using "
+			   "MPU-401\n", dev->bus_id);
+		mpu_port[n] = -1;
+	}
+
+	if (fm_port[n] == SNDRV_AUTO_PORT) {
+		snd_printk(KERN_WARNING "%s: fm_port not specified: not using "
+			   "OPL3\n", dev->bus_id);
+		fm_port[n] = -1;
+	}
+
+out:	return match;
+}
+
+static int __devinit snd_azt1605_wssmode(struct snd_sb *sb, unsigned long port,
+					 int irq)
+{
+	unsigned char val;
+	int error;
+
+	error = snd_sbdsp_reset(sb);
+	if (error < 0)
+		goto out;
+
+	error = snd_sbdsp_command(sb, 9);
+	if (error < 0)
+		goto out;
+
+	error = snd_sbdsp_command(sb, 0);
+	if (error < 0)
+		goto out;
+
+	msleep(100);
+
+	/* check WSS signature */
+	if ((inb(port + 3) & 0x3f) != 4) {
+		error = -ENODEV;
+		goto out;
+	}
+
+	switch (irq) {
+	case 7:
+		val = 1 << 3;
+		break;
+	case 9:
+		val = 2 << 3;
+		break;
+	case 10:
+		val = 3 << 3;
+		break;
+	case 11:
+		val = 4 << 3;
+		break;
+	default:
+		error = -EINVAL;
+		goto out;
+	}
+	outb(0x40 | val, port);
+
+	switch (sb->dma8) {
+	case 0:
+		val |= 1;
+		break;
+	case 1:
+		val |= 2;
+		break;
+	case 3:
+		val |= 3;
+		break;
+	default:
+		error = -EINVAL;
+		goto out;
+	}
+	outb(val, port);
+
+out:	return error;
+}
+
+static irqreturn_t snd_azt1605_interrupt(int irq, void *dev_id)
+{
+	struct snd_sb *sb = dev_id;
+	irqreturn_t ret = IRQ_NONE;
+
+	if (!sb->card->private_data) {
+		if (sb->open & SB_OPEN_PCM)
+			ret = snd_sb8dsp_interrupt(sb);
+		else
+			ret = snd_sb8dsp_midi_interrupt(sb);
+	}
+	return ret;
+}
+
+static void snd_azt1605_free(struct snd_card *card)
+{
+	release_and_free_resource(card->private_data);
+}
+
+static int __devinit snd_azt1605_probe(struct device *dev, unsigned int n) 
+{
+	struct snd_card *card;
+	struct snd_sb *sb;
+	int error;
+
+	card = snd_card_new(index[n], id[n], THIS_MODULE, 0);
+	if (!card)
+		return -EINVAL;
+
+	snd_card_set_dev(card, dev);
+
+	error = snd_sbdsp_create(card, port[n], irq[n], snd_azt1605_interrupt,
+				 dma[n], -1, SB_HW_AUTO, &sb);
+	if (error < 0)
+		goto out;
+
+	if (wss_port[n] >= 0) {
+		struct snd_cs4231 *wss;
+
+		card->private_data = request_region(wss_port[n], 4, DRV_NAME);
+		if (!card->private_data) {
+			snd_printk(KERN_ERR "%s: ports %#lx-%#lx unavailable\n",
+				   dev->bus_id, wss_port[n], wss_port[n] + 3);	
+			error = -EBUSY;
+			goto out;
+		}
+		card->private_free = snd_azt1605_free;
+
+		error = snd_azt1605_wssmode(sb, wss_port[n], wss_irq[n]);
+		if (error < 0) {
+			snd_printk(KERN_ERR "%s: " CRD_NAME " not detected\n",
+				   dev->bus_id);
+			goto out;
+		}
+
+		error = snd_cs4231_create(card, wss_port[n] + 4, -1, wss_irq[n],
+					  dma[n], -1, CS4231_HW_DETECT, 
+					  CS4231_HWSHARE_DMA1, &wss);
+		if (error < 0)
+			goto out;
+
+		error = snd_cs4231_pcm(wss, 0, NULL);
+		if (error < 0)
+			goto out;
+
+		error = snd_cs4231_mixer(wss);
+		if (error < 0)
+			goto out;
+
+		error = snd_cs4231_timer(wss, 0, NULL);
+		if (error < 0)
+			goto out;
+
+		sprintf(card->shortname, snd_cs4231_chip_id(wss));
+		sprintf(card->longname, "%s at %#lx, irq %d, dma %d",
+			card->shortname, wss->port, wss->irq, wss->dma1);
+	} else {
+		error = snd_sb8dsp_pcm(sb, 0, NULL);
+		if (error < 0)
+			goto out;
+
+		error = snd_sbmixer_new(sb);
+		if (error < 0)
+			goto out;
+
+		sprintf(card->shortname, sb->name);
+		sprintf(card->longname, "%s at %#lx, irq %d, dma %d",
+			card->shortname, sb->port, sb->irq, sb->dma8);
+	}
+	strcpy(card->driver, DRV_NAME);
+
+	if (mpu_port[n] >= 0) {
+		error = snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
+					    mpu_port[n], 0, mpu_irq[n],
+					    mpu_irq[n] < 0 ? 0 : IRQF_DISABLED,
+					    NULL);
+		if (error < 0)
+			goto out;
+	}
+
+	if (fm_port[n] >= 0) {
+		struct snd_opl3 *opl3;
+
+		error = snd_opl3_create(card, fm_port[n], fm_port[n] + 2,
+					OPL3_HW_AUTO, 0, &opl3);
+		if (error < 0) {
+                        snd_printk(KERN_ERR "%s: no OPL device at %#lx\n",
+                                   dev->bus_id, fm_port[n]);
+			goto out;
+		}
+		error = snd_opl3_timer_new(opl3, 1, 2);
+		if (error < 0)
+			goto out;
+
+		error = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
+		if (error < 0)
+			goto out;
+	}
+
+	error = snd_card_register(card);
+	if (error < 0)
+		goto out;
+
+	dev_set_drvdata(dev, card);
+	return 0;
+
+out:	snd_card_free(card);
+	return error;
+}
+
+static int __devexit snd_azt1605_remove(struct device *dev, unsigned int n)
+{
+	snd_card_free(dev_get_drvdata(dev));
+	dev_set_drvdata(dev, NULL);
+	return 0;
+}
+
+static struct isa_driver snd_azt1605_driver = {
+	.match		= snd_azt1605_match,
+	.probe		= snd_azt1605_probe,
+	.remove		= __devexit_p(snd_azt1605_remove),
+
+	.driver		= {
+		.name	= DEV_NAME
+	}
+};
+
+static int __init alsa_card_azt1605_init(void)
+{
+	return isa_register_driver(&snd_azt1605_driver, SNDRV_CARDS);
+}
+
+static void __exit alsa_card_azt1605_exit(void)
+{
+	isa_unregister_driver(&snd_azt1605_driver);
+}
+
+module_init(alsa_card_azt1605_init);
+module_exit(alsa_card_azt1605_exit);

--------------040407040708050006010406
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040407040708050006010406--
