From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [Alsa-devel] [RFC][RFT] Adding support for Jazz16
 based sound cards
Date: Tue, 20 Mar 2007 22:23:35 +0100
Message-ID: <460050D7.5060901@gmail.com>
References: <20070311232436.GB9778@sygehus.dk> <45FDDA0F.7050503@gmail.com>
	<20070319224607.GA7889@sygehus.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080005000804000000030104"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 06B5324770
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2007 22:24:28 +0100 (CET)
In-Reply-To: <20070319224607.GA7889@sygehus.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rask Ingemann Lambertsen <rask@sygehus.dk>
Cc: alsa-devel@alsa-project.org, Adam Belay <ambx1@neo.rr.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080005000804000000030104
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 03/19/2007 11:46 PM, Rask Ingemann Lambertsen wrote:

>> This setup also shares that same problem with the BIOS generally
>> not having reserved/routed the resources -- on a general PCI/ISA
>> system the user needs to go into the BIOS setup and reserve the
>> resources the card is (or will be, in this case) set to. So now the
>> user really needs to know what resources are going to be assigned,
>> destroying the plug and play idea...
> 
> Not really. A standards compliant PnPBIOS set up with "PnP aware OS =
> YES" will use only enough resources to boot the system, which should
> leave enough irqs and dmas for the Linux PnP layer to do its work.

There's also the "routed" bit though. I actually ran into this recently 
when I was playing with snd-sgalaxy (which is why I'm harping on it).

An sgalaxy is also a (partly) software configurable card and when not 
given explicit parameters the driver just searches for an unrequested 
IRQ and DMA and then programs the card for it. Over here  it grabbed IRQ 
10 but then didn't work anyway, and only started working when I set IRQ 
10 to "Legacy ISA" in the BIOS setup. It seems the IRQ simply was not 
available to ISA without having done that (no, no PCI cards were using 
IRQ 10 or anything).

I must say though that my comment above was partly based on a somewhat 
foggy understanding of how things get assigned. Yes, _if_ this "routing" 
problem I seemed to be experiencing is not a serious problem in practice 
(Adam? Are you able to comment?) then the fact that the PnP layer will 
be handing out the resources taking into account the other (known) cards 
is indeed a practical advantage of using that layer.

>    I think there are three good reasons to use the PnP layer:
> 
>    1) The PnP layer informs the PCI layer of irqs to try to avoid - please
> see pnp_register_irq_resource() in drivers/pnp/resource.c.

How does that help? On my systems (one AMI, all others Award BIOses) all 
PCI cards get assigned their IRQ before the OS ever boots. That "PnP OS: 
Yes/No" switch only effects whether or not the BIOS will fully configure 
all ISA-PnP cards.

>    2) The PnP layer knows which resources are used by active devices, even
> if they have not been allocated using e.g. request_region(). This
> happens in practice. For example:

Yes, this is an advantage. It does miss all the resources used by old 
ISA cards for which no (normal or pnp protocol as in this one) drivers 
have been loaded but I guess that's not much of a difference with a 
regular ISA driver...

>    3) Knowing which resources a card can utilize, the PnP layer can try to
> stay away from those resources when configuring other cards. The PnP layer
> doesn't do that yet in a stock kernel, but I've patched it to do so. I'll
> try to get those patches into the kernel.

I guess that could be an advantage.

When I was looking at pnp/isa integration a while ago myself I was 
looking at it from the angle of generic old ISA (ie, hardwired non 
settable resources) and concluded that for these there wasn't any point. 
Having looked a little closer at the resource assigment being done in 
the PnP layer now, I now feel there's some point, but still little for 
those.

But with software settable devices such as this Jazz16, there ofcourse 
is rather more point. I believe the routing issue I refferred to above 
is the most important thing to have answered.

I also still don't really like "splitting the one driver into the two 
pieces" like that but well, we don't actually have all that many 
software settable ISA devices and I guess it's not _too_ bad to have a 
few of these "front-ends" run as a protocol driver at boot as long as it 
stays "a few".

Hey, I already said I like the concept...

By the way; in the "straightforward version" I posted yesterday I 
neglected to reserve the SB_JAZZ16_CONFIG_PORT and the SB range before 
poking at it during setup. Attached version corrects that. Updated patch 
including your SB changes still at

http://members.home.nl/rene.herman/jazz16.diff

Looks more involved now, but posted mainly for completeness; correcting 
yesterday's post. Has been tested and found working again.

Rene.


--------------080005000804000000030104
Content-Type: text/plain;
 name="jazz16.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="jazz16.diff"

diff --git a/Documentation/sound/alsa/ALSA-Configuration.txt b/Documentation/sound/alsa/ALSA-Configuration.txt
index 9fef210..b60690a 100644
--- a/Documentation/sound/alsa/ALSA-Configuration.txt
+++ b/Documentation/sound/alsa/ALSA-Configuration.txt
@@ -1120,6 +1120,13 @@ Prior to version 0.9.0rc4 options had a 
 
     This module supports multiple cards, autoprobe and ISA PnP.
 
+  Module snd-jazz16
+  -----------------
+
+    Module for sound cards based Media Vision Jazz16 chip
+
+    This module supports multiple cards.
+
   Module snd-korg1212
   -------------------
 
diff --git a/include/sound/sb.h b/include/sound/sb.h
index 2dd5c8e..9594f89 100644
--- a/include/sound/sb.h
+++ b/include/sound/sb.h
@@ -38,6 +38,7 @@ enum sb_hw_type {
 	SB_HW_ALS100,		/* Avance Logic ALS100 chip */
 	SB_HW_ALS4000,		/* Avance Logic ALS4000 chip */
 	SB_HW_DT019X,		/* Diamond Tech. DT-019X / Avance Logic ALS-007 */
+	SB_HW_JAZZ16,		/* Media Vision Jazz16 chip */
 };
 
 #define SB_OPEN_PCM			0x01
@@ -140,8 +141,11 @@ #define SB_DSP_LO_OUTPUT_AUTO	0x1c
 #define SB_DSP_LO_INPUT_AUTO	0x2c
 #define SB_DSP_HI_OUTPUT_AUTO	0x90
 #define SB_DSP_HI_INPUT_AUTO	0x98
+#define SB_DSP_ULAW_OUTPUT_AUTO	0x7f
+#define SB_DSP_ULAW_INPUT_AUTO	0x8f
 #define SB_DSP_IMMED_INT	0xf2
 #define SB_DSP_GET_VERSION	0xe1
+#define SB_DSP_GET_JAZZ_VERSION	0xfa
 #define SB_DSP_SPEAKER_ON	0xd1
 #define SB_DSP_SPEAKER_OFF	0xd3
 #define SB_DSP_DMA8_OFF		0xd0
@@ -265,6 +269,14 @@ #define SB_DMASETUP_DMA5	0x20
 #define SB_DMASETUP_DMA6	0x40
 #define SB_DMASETUP_DMA7	0x80
 
+/* Jazz16 configuration. */
+#define SB_JAZZ16_CONFIG_PORT	0x201
+#define SB_JAZZ16_WAKEUP	0xaf
+#define SB_JAZZ16_SET_PORTS	0x50
+
+/* Check the output of SB_DSP_GET_JAZZ_VERSION. */
+#define SB_VERSION_IS_JAZZ16(x)	((x) == 0x12)
+
 /*
  *
  */
diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index a629b52..450255f 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -258,6 +258,14 @@ config SND_SW60XG
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-sw60xg.
 
+config SND_JAZZ16
+	tristate "Media Vision Jazz16"
+	depends on SND
+	select SND_OPL3_LIB
+	select SND_PCM
+	help
+	  Say 'Y' or 'M' to include support for Media Vision Jazz16.
+
 config SND_OPL3SA2
 	tristate "Yamaha OPL3-SA2/SA3"
 	depends on SND
diff --git a/sound/isa/sb/Makefile b/sound/isa/sb/Makefile
index fd9d9c5..745e1c1 100644
--- a/sound/isa/sb/Makefile
+++ b/sound/isa/sb/Makefile
@@ -12,6 +12,7 @@ snd-sb16-objs := sb16.o
 snd-sbawe-objs := sbawe.o emu8000.o
 snd-emu8000-synth-objs := emu8000_synth.o emu8000_callback.o emu8000_patch.o emu8000_pcm.o
 snd-es968-objs := es968.o
+snd-jazz16-objs := jazz16.o
 
 #
 # this function returns:
@@ -30,6 +31,7 @@ obj-$(CONFIG_SND_SB16) += snd-sb16.o snd
 obj-$(CONFIG_SND_SBAWE) += snd-sbawe.o snd-sb16-dsp.o snd-sb-common.o
 obj-$(CONFIG_SND_ES968) += snd-es968.o snd-sb8-dsp.o snd-sb-common.o
 obj-$(CONFIG_SND_ALS4000) += snd-sb-common.o
+obj-$(CONFIG_SND_JAZZ16) += snd-jazz16.o snd-sb8-dsp.o snd-sb-common.o
 ifeq ($(CONFIG_SND_SB16_CSP),y)
   obj-$(CONFIG_SND_SB16) += snd-sb16-csp.o
   obj-$(CONFIG_SND_SBAWE) += snd-sb16-csp.o
diff --git a/sound/isa/sb/jazz16.c b/sound/isa/sb/jazz16.c
new file mode 100644
index 0000000..988a5e9
--- /dev/null
+++ b/sound/isa/sb/jazz16.c
@@ -0,0 +1,334 @@
+/* Driver for Media Vision Jazz16 based boards.
+ *
+ * Copyright (c) 2007 by Rask Ingemann Lambertsen
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ * The Jazz16 is an SB Pro compatible chip with a 16-bit mode and higher
+ * playback and capture rates added to it. It is not SB 16 compatible.
+ * The chip has an MPU-401 interface which is handled by the MPU-401 driver.
+ *
+ * The IBM PPS Model 6015 has a Jazz16 chip on board. Please tell me if it
+ * works with this driver or not.
+ */
+
+#include <sound/driver.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/isa.h>
+#include <linux/ioport.h>
+#include <asm/dma.h>
+#include <asm/io.h>
+#include <sound/core.h>
+#include <sound/sb.h>
+#include <sound/mpu401.h>
+#include <sound/opl3.h>
+#include <sound/initval.h>
+
+#define CRD_NAME "Media Vision Jazz16"
+#define DEV_NAME "jazz16"
+
+MODULE_DESCRIPTION(CRD_NAME);
+MODULE_AUTHOR("Rask Ingemann Lambertsen <rask@sygehus.dk>");
+MODULE_LICENSE("GPL");
+
+static int index = SNDRV_DEFAULT_IDX1;		/* Index 0-MAX */
+static char *id = SNDRV_DEFAULT_STR1;		/* ID for this card */
+static int enable = SNDRV_DEFAULT_ENABLE1;	/* Enable this card */
+static long port = SNDRV_DEFAULT_PORT1;		/* 0x220,0x240,0x260 */
+static long mpu_port = SNDRV_DEFAULT_PORT1;	/* 0x310,0x320,0x330 */
+static int irq = SNDRV_DEFAULT_IRQ1;		/* 5,9,3,7,10,15 */
+static int mpu_irq = SNDRV_DEFAULT_IRQ1;	/* 5,9,3,7,10,15 */
+static int dma8 = SNDRV_DEFAULT_DMA1;		/* 1,3 */
+static int dma16 = SNDRV_DEFAULT_DMA1;		/* 5,7 */
+
+module_param(index, int, 0444);
+MODULE_PARM_DESC(index, "Index value for " CRD_NAME " soundcard.");
+module_param(id, charp, 0444);
+MODULE_PARM_DESC(id, "ID string for " CRD_NAME " soundcard.");
+module_param(enable, bool, 0444);
+MODULE_PARM_DESC(enable, "Enable " CRD_NAME " soundcard.");
+module_param(port, long, 0444);
+MODULE_PARM_DESC(port, "Port # for " CRD_NAME " driver.");
+module_param(mpu_port, long, 0444);
+MODULE_PARM_DESC(mpu_port, "MPU-401 port # for " CRD_NAME " driver.");
+module_param(irq, int, 0444);
+MODULE_PARM_DESC(irq, "IRQ # for " CRD_NAME " driver.");
+module_param(mpu_irq, int, 0444);
+MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for " CRD_NAME " driver.");
+module_param(dma8, int, 0444);
+MODULE_PARM_DESC(dma8, "8-bit DMA # for " CRD_NAME " driver.");
+module_param(dma16, int, 0444);
+MODULE_PARM_DESC(dma16, "16-bit DMA # for " CRD_NAME " driver.");
+
+static int __devinit snd_jazz16_match(struct device *dev, unsigned int n)
+{
+	if (!enable)
+		return 0;
+
+	if (port == SNDRV_AUTO_PORT) {
+		snd_printk(KERN_ERR "%s: please specify port\n", dev->bus_id);
+		return 0;
+	}
+	if (irq == SNDRV_AUTO_IRQ) {
+		snd_printk(KERN_ERR "%s: please specify irq\n", dev->bus_id);
+		return 0;
+	}
+	if (dma8 == SNDRV_AUTO_DMA) {
+		snd_printk(KERN_ERR "%s: please specify dma8\n", dev->bus_id);
+		return 0;
+	}
+	if (dma16 == SNDRV_AUTO_DMA) {
+		snd_printk(KERN_ERR "%s: please specify dma16\n", dev->bus_id);
+		return 0;
+	}
+	return 1;
+}
+
+#define BUSY_LOOPS 100000
+
+static int __devinit jazz16_sbdsp_command(u8 value)
+{
+        int i;
+
+        for (i = BUSY_LOOPS; i; i--)
+                if ((inb(SBP1(port, STATUS)) & 0x80) == 0) {
+                        outb(value, SBP1(port, COMMAND));
+                        return 0;
+                }
+        return -EIO;
+}
+
+static int __devinit jazz16_sbdsp_get_byte(void)
+{
+        int i;
+
+        for (i = BUSY_LOOPS; i; i--) 
+                if (inb(SBP1(port, DATA_AVAIL)) & 0x80) 
+                        return inb(SBP1(port, READ));
+
+        return -EIO;
+}
+
+static int __devinit jazz16_sbdsp_reset(void)
+{
+        int error;
+
+        outb(1, SBP1(port, RESET));
+        udelay(10);
+        outb(0, SBP1(port, RESET));
+        udelay(30);
+
+	error = jazz16_sbdsp_get_byte();
+	if (error < 0)
+		return error;
+
+        return error == 0xaa ? 0 : -ENODEV;
+}
+
+static void jazz16_set_ports(u8 value)
+{
+        outb(SB_JAZZ16_WAKEUP, SB_JAZZ16_CONFIG_PORT);
+        outb(SB_JAZZ16_SET_PORTS, SB_JAZZ16_CONFIG_PORT);
+        outb(value, SB_JAZZ16_CONFIG_PORT);
+}
+
+#define JAZZ16_SET_DMAINTR 0xfb
+
+static int __devinit jazz16_enable(struct device *dev)
+{
+	static u8 irq_config[] = {0,0,2,3,0,1,0,4,0,2,5,0,0,0,0,6};
+	static u8 dma_config[] = {0,1,0,2,0,3,0,4};
+	u8 config = 0;
+
+	int error;
+
+	if (port != 0x220 && port != 0x240 && port != 0x260)
+		port = 0;
+
+	if (mpu_port != 0x310 && mpu_port != 0x320 && mpu_port != 0x330)
+		mpu_port = 0;
+
+	config = (port & 0x70) | ((mpu_port >> 4) & 0x07);
+
+	snd_printd("%s: setting SB port = %#lx, MPU port = %#lx.\n",
+		dev->bus_id, port, mpu_port);
+
+	jazz16_set_ports(config);
+	
+	snd_printd("%s: setting SB irq %d, dma %d&%d, MPU irq %d.\n",
+		dev->bus_id, irq, dma8, dma16, mpu_irq);
+
+	if (!request_region(port, 16, "Jazz16")) 
+		return  -EBUSY;
+
+	error = jazz16_sbdsp_command(JAZZ16_SET_DMAINTR);
+	if (error < 0)
+		goto out;
+
+	config = dma_config[dma8] | dma_config[dma16] << 4;
+
+	error = jazz16_sbdsp_command(config);
+	if (error < 0)
+		goto out;
+
+	config = irq_config[irq] | irq_config[mpu_irq] << 4;
+
+	error = jazz16_sbdsp_command(config);
+	if (error < 0)
+		goto out;
+
+        error = jazz16_sbdsp_reset();
+	if (error < 0)
+		goto out;
+
+        error = jazz16_sbdsp_command(SB_DSP_GET_JAZZ_VERSION);
+	if (error < 0)
+		goto out;
+
+	error = jazz16_sbdsp_get_byte();
+	if (error < 0)
+		goto out;
+
+	error = SB_VERSION_IS_JAZZ16(error) ? 0 : -ENODEV;
+		
+out:	release_region(port, 16);	
+	return error;	
+}
+
+static irqreturn_t snd_jazz16_interrupt(int irq, void *dev_id)
+{
+	return snd_sb8dsp_interrupt(dev_id);
+}
+
+static void snd_jazz16_free(struct snd_card *card)
+{
+	jazz16_set_ports(0);
+	release_and_free_resource(card->private_data);
+}
+
+static int __devinit snd_jazz16_probe(struct device *dev, unsigned int n)
+{
+	struct snd_sb *chip;
+	struct snd_card *card;
+	struct snd_opl3 *opl3;
+	int error;
+
+	card = snd_card_new(index, id, THIS_MODULE, 0);
+	if (!card)
+		return -EINVAL;
+
+	card->private_data = request_region(SB_JAZZ16_CONFIG_PORT, 1,
+				"Jazz16 Config");
+	if (!card->private_data) {
+		error = -EBUSY;
+		goto out;
+	}
+	card->private_free = snd_jazz16_free;
+
+	if (mpu_port == SNDRV_AUTO_PORT)
+		mpu_port = 0;
+
+	if (mpu_irq == SNDRV_AUTO_IRQ)
+		mpu_irq = 0;
+
+	error = jazz16_enable(dev);
+	if (error < 0)
+		goto out;
+
+	error = snd_sbdsp_create(card, port, irq, snd_jazz16_interrupt,
+			dma8, dma16, SB_HW_AUTO, &chip);
+	if (error < 0)
+		goto out;
+
+	if (chip->hardware != SB_HW_JAZZ16) {
+		snd_printk(KERN_ERR "%s: not a Jazz16 chip at %#lx.\n",
+			dev->bus_id, chip->port);
+		error = -ENODEV;
+		goto out;
+	}
+
+	strcpy(card->driver, "Jazz16");
+	strcpy(card->shortname, "Media Vision Jazz16");
+	sprintf(card->longname, "%s at %#lx, irq %d, dma8 %d, dma16 %d",
+	         chip->name, chip->port, chip->irq, chip->dma8, chip->dma16);
+
+	error = snd_sb8dsp_pcm(chip, 0, NULL);
+	if (error < 0)
+		goto out;
+
+	error = snd_sbmixer_new(chip);
+	if (error < 0)
+		goto out;
+
+	error = snd_opl3_create(card, chip->port, chip->port + 2, OPL3_HW_AUTO,
+			1, &opl3);
+	if (error < 0)
+		snd_printk(KERN_WARNING "%s: no OPL device found, skipping.\n",
+			dev->bus_id);
+	else {
+		error = snd_opl3_timer_new(opl3, 1, 2);
+		if (error < 0)
+			goto out;
+
+		error = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
+		if (error < 0)
+			goto out;
+	}
+
+	snd_card_set_dev(card, dev);
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
+static int __devexit snd_jazz16_remove(struct device *dev, unsigned int n)
+{
+	snd_card_free(dev_get_drvdata(dev));
+	dev_set_drvdata(dev, NULL);
+	return 0;
+}
+
+static struct isa_driver snd_jazz16_driver = {
+	.match		= snd_jazz16_match,
+	.probe		= snd_jazz16_probe,
+	.remove		= __devexit_p(snd_jazz16_remove),
+
+	.driver		= {
+		.name	= DEV_NAME
+	}
+};
+
+static int __devinit alsa_card_jazz16_init(void)
+{
+	return isa_register_driver(&snd_jazz16_driver, 1);
+}
+
+static void __devexit alsa_card_jazz16_exit(void)
+{
+	isa_unregister_driver(&snd_jazz16_driver);
+}
+
+module_init (alsa_card_jazz16_init);
+module_exit (alsa_card_jazz16_exit);
diff --git a/sound/isa/sb/sb8_main.c b/sound/isa/sb/sb8_main.c
index aea9e5e..70cd031 100644
--- a/sound/isa/sb/sb8_main.c
+++ b/sound/isa/sb/sb8_main.c
@@ -28,6 +28,9 @@
  *
  * Wed Jul 12 22:02:55 CEST 2000 Uros Bizjak <uros@kss-loka.si>
  *   Cleaned up and rewrote lowlevel routines.
+ *
+ * Sun Mar 11 18:45:38 CEST 2007 Rask Ingemann Lambertsen <rask@sygehus.dk>
+ *   Added Jazz16 enhancements.
  */
 
 #include <sound/driver.h>
@@ -73,6 +76,15 @@ static struct snd_ratnum stereo_clocks[]
 	}
 };
 
+/* For stereo playback and capture, the denominator is divided by two, so it
+ * must be even to get the intended sample rate. */
+static struct snd_ratnum jazz16_stereo_clock = {
+	.num = SB8_CLOCK,
+	.den_min = 2,
+	.den_max = 512,
+	.den_step = 2,
+};
+
 static int snd_sb8_hw_constraint_rate_channels(struct snd_pcm_hw_params *params,
 					       struct snd_pcm_hw_rule *rule)
 {
@@ -101,14 +113,54 @@ static int snd_sb8_hw_constraint_channel
 	return 0;
 }
 
+static int snd_jazz16_hw_constraint_rate_channels(struct snd_pcm_hw_params *params,
+						  struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *c = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_interval *r = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+  	unsigned int num = 0, den = 0;
+	int err = 0;
+
+	if (c->max > 1)
+		err = snd_interval_ratnum(r, 1, &jazz16_stereo_clock, &num, &den);
+	else
+		err = snd_interval_ratnum(r, 1, &clock, &num, &den);
+	if (err >= 0 && den) {
+		params->rate_num = num;
+		params->rate_den = den;
+	}
+	return err;
+}
+
+static int snd_jazz16_hw_constraint_channels_rate(struct snd_pcm_hw_params *params,
+						  struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *r = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+	int err = 0;
+
+	/* Force mono mode if the sample rate interval doesn't allow stereo. */
+	if (SB8_DEN(r->min) == SB8_DEN(r->max)
+	    && SB8_DEN(r->min) & 1)
+	{
+		struct snd_interval t = { .min = 1, .max = 1 };
+		struct snd_interval *c;
+
+		c = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+		err = snd_interval_refine(c, &t);
+	}
+	return err;
+}
+
 static int snd_sb8_playback_prepare(struct snd_pcm_substream *substream)
 {
 	unsigned long flags;
 	struct snd_sb *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	unsigned int mixreg, rate, size, count;
+	unsigned int mixreg, rate, size, count, dma;
+	unsigned char stereo, format;
 
 	rate = runtime->rate;
+	stereo = runtime->channels > 1;
 	switch (chip->hardware) {
 	case SB_HW_PRO:
 		if (runtime->channels > 1) {
@@ -117,6 +169,12 @@ static int snd_sb8_playback_prepare(stru
 			break;
 		}
 		/* fallthru */
+	case SB_HW_JAZZ16:
+		if (runtime->format == SNDRV_PCM_FORMAT_MU_LAW) {
+			chip->playback_format = SB_DSP_ULAW_OUTPUT_AUTO;
+			break;
+		}
+		/* fall through */
 	case SB_HW_201:
 		if (rate > 23000) {
 			chip->playback_format = SB_DSP_HI_OUTPUT_AUTO;
@@ -134,8 +192,26 @@ static int snd_sb8_playback_prepare(stru
 	}
 	size = chip->p_dma_size = snd_pcm_lib_buffer_bytes(substream);
 	count = chip->p_period_size = snd_pcm_lib_period_bytes(substream);
+	switch (runtime->format)
+	{
+		case SNDRV_PCM_FORMAT_U8:
+		case SNDRV_PCM_FORMAT_MU_LAW:
+		dma = chip->dma8;
+		format = stereo ? SB_DSP_STEREO_8BIT : SB_DSP_MONO_8BIT;
+		break;
+
+		case SNDRV_PCM_FORMAT_S16_LE:
+		dma = chip->dma16;
+		format = stereo ? SB_DSP_STEREO_16BIT : SB_DSP_MONO_16BIT;
+		break;
+
+		default:
+		return -EINVAL;
+	}
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	snd_sbdsp_command(chip, SB_DSP_SPEAKER_ON);
+	if (chip->hardware >= SB_HW_PRO)
+		snd_sbdsp_command(chip, format);
 	if (runtime->channels > 1) {
 		/* set playback stereo mode */
 		spin_lock(&chip->mixer_lock);
@@ -173,7 +249,7 @@ static int snd_sb8_playback_prepare(stru
 		snd_sbdsp_command(chip, count >> 8);
 	}
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_dma_program(chip->dma8, runtime->dma_addr,
+	snd_dma_program(dma, runtime->dma_addr,
 			size, DMA_MODE_WRITE | DMA_AUTOINIT);
 	return 0;
 }
@@ -232,9 +308,11 @@ static int snd_sb8_capture_prepare(struc
 	unsigned long flags;
 	struct snd_sb *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	unsigned int mixreg, rate, size, count;
+	unsigned int mixreg, rate, size, count, dma;
+	unsigned char stereo, format;
 
 	rate = runtime->rate;
+	stereo = runtime->channels > 1;
 	switch (chip->hardware) {
 	case SB_HW_PRO:
 		if (runtime->channels > 1) {
@@ -242,6 +320,12 @@ static int snd_sb8_capture_prepare(struc
 			chip->capture_format = SB_DSP_HI_INPUT_AUTO;
 			break;
 		}
+		/* fall through */
+	case SB_HW_JAZZ16:
+		if (runtime->format == SNDRV_PCM_FORMAT_MU_LAW) {
+			chip->capture_format = SB_DSP_ULAW_OUTPUT_AUTO;
+			break;
+		}
 		chip->capture_format = (rate > 23000) ? SB_DSP_HI_INPUT_AUTO : SB_DSP_LO_INPUT_AUTO;
 		break;
 	case SB_HW_201:
@@ -261,10 +345,26 @@ static int snd_sb8_capture_prepare(struc
 	}
 	size = chip->c_dma_size = snd_pcm_lib_buffer_bytes(substream);
 	count = chip->c_period_size = snd_pcm_lib_period_bytes(substream);
+	switch (runtime->format)
+	{
+		case SNDRV_PCM_FORMAT_U8:
+		case SNDRV_PCM_FORMAT_MU_LAW:
+		dma = chip->dma8;
+		format = stereo ? SB_DSP_STEREO_8BIT : SB_DSP_MONO_8BIT;
+		break;
+
+		case SNDRV_PCM_FORMAT_S16_LE:
+		dma = chip->dma16;
+		format = stereo ? SB_DSP_STEREO_16BIT : SB_DSP_MONO_16BIT;
+		break;
+
+		default:
+		return -EINVAL;
+	}
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	snd_sbdsp_command(chip, SB_DSP_SPEAKER_OFF);
-	if (runtime->channels > 1)
-		snd_sbdsp_command(chip, SB_DSP_STEREO_8BIT);
+	if (chip->hardware >= SB_HW_PRO)
+		snd_sbdsp_command(chip, format);
 	snd_sbdsp_command(chip, SB_DSP_SAMPLE_RATE);
 	if (runtime->channels > 1) {
 		snd_sbdsp_command(chip, 256 - runtime->rate_den / 2);
@@ -278,14 +378,14 @@ static int snd_sb8_capture_prepare(struc
 	} else {
 		snd_sbdsp_command(chip, 256 - runtime->rate_den);
 	}
-	if (chip->capture_format != SB_DSP_OUTPUT) {
+	if (chip->capture_format != SB_DSP_INPUT) {
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
@@ -358,10 +458,12 @@ static snd_pcm_uframes_t snd_sb8_playbac
 {
 	struct snd_sb *chip = snd_pcm_substream_chip(substream);
 	size_t ptr;
+	int dma;
 
 	if (chip->mode != SB_MODE_PLAYBACK_8)
 		return 0;
-	ptr = snd_dma_pointer(chip->dma8, chip->p_dma_size);
+	dma = (substream->runtime->format == SNDRV_PCM_FORMAT_S16_LE) ? chip->dma16 : chip->dma8;
+	ptr = snd_dma_pointer(dma, chip->p_dma_size);
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
@@ -369,10 +471,12 @@ static snd_pcm_uframes_t snd_sb8_capture
 {
 	struct snd_sb *chip = snd_pcm_substream_chip(substream);
 	size_t ptr;
+	int dma;
 
 	if (chip->mode != SB_MODE_CAPTURE_8)
 		return 0;
-	ptr = snd_dma_pointer(chip->dma8, chip->c_dma_size);
+	dma = (substream->runtime->format == SNDRV_PCM_FORMAT_S16_LE) ? chip->dma16 : chip->dma8;
+	ptr = snd_dma_pointer(dma, chip->c_dma_size);
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
@@ -443,6 +547,20 @@ static int snd_sb8_open(struct snd_pcm_s
 		runtime->hw = snd_sb8_capture;
 	}
 	switch (chip->hardware) {
+	case SB_HW_JAZZ16:
+		runtime->hw.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE
+				    | SNDRV_PCM_FMTBIT_MU_LAW;
+		runtime->hw.rates = SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_44100;
+		runtime->hw.rate_max = 45455;
+		runtime->hw.channels_max = 2;
+		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				    snd_jazz16_hw_constraint_rate_channels, NULL,
+				    SNDRV_PCM_HW_PARAM_CHANNELS,
+				    SNDRV_PCM_HW_PARAM_RATE, -1);
+		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				    snd_jazz16_hw_constraint_channels_rate, NULL,
+				    SNDRV_PCM_HW_PARAM_RATE, -1);
+		break;
 	case SB_HW_PRO:
 		runtime->hw.rate_max = 44100;
 		runtime->hw.channels_max = 2;
@@ -463,9 +581,11 @@ static int snd_sb8_open(struct snd_pcm_s
 	default:
 		break;
 	}
+	if (chip->hardware == SB_HW_JAZZ16)
+		return 0;
 	snd_pcm_hw_constraint_ratnums(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				      &hw_constraints_clock);
-	return 0;	
+	return 0;
 }
 
 static int snd_sb8_close(struct snd_pcm_substream *substream)
diff --git a/sound/isa/sb/sb_common.c b/sound/isa/sb/sb_common.c
index 3094f38..69e72b5 100644
--- a/sound/isa/sb/sb_common.c
+++ b/sound/isa/sb/sb_common.c
@@ -146,8 +146,16 @@ static int snd_sbdsp_probe(struct snd_sb
 			}
 			break;
 		case 3:
-			chip->hardware = SB_HW_PRO;
-			str = "Pro";
+			spin_lock_irqsave(&chip->reg_lock, flags);
+			if (snd_sbdsp_command(chip, SB_DSP_GET_JAZZ_VERSION) &&
+			    SB_VERSION_IS_JAZZ16(snd_sbdsp_get_byte (chip))) {
+				chip->hardware = SB_HW_JAZZ16;
+				str = "Pro (Jazz16)";
+			} else {
+				chip->hardware = SB_HW_PRO;
+				str = "Pro";
+			}
+			spin_unlock_irqrestore (&chip->reg_lock, flags);
 			break;
 		case 4:
 			chip->hardware = SB_HW_16;
diff --git a/sound/isa/sb/sb_mixer.c b/sound/isa/sb/sb_mixer.c
index 490b1ca..b16b592 100644
--- a/sound/isa/sb/sb_mixer.c
+++ b/sound/isa/sb/sb_mixer.c
@@ -811,6 +811,7 @@ int snd_sbmixer_new(struct snd_sb *chip)
 			return err;
 		break;
 	case SB_HW_PRO:
+	case SB_HW_JAZZ16:
 		if ((err = snd_sbmixer_init(chip,
 					    snd_sbpro_controls,
 					    ARRAY_SIZE(snd_sbpro_controls),
@@ -946,6 +947,7 @@ void snd_sbmixer_suspend(struct snd_sb *
 		save_mixer(chip, sb20_saved_regs, ARRAY_SIZE(sb20_saved_regs));
 		break;
 	case SB_HW_PRO:
+	case SB_HW_JAZZ16:
 		save_mixer(chip, sbpro_saved_regs, ARRAY_SIZE(sbpro_saved_regs));
 		break;
 	case SB_HW_16:
@@ -971,6 +973,7 @@ void snd_sbmixer_resume(struct snd_sb *c
 		restore_mixer(chip, sb20_saved_regs, ARRAY_SIZE(sb20_saved_regs));
 		break;
 	case SB_HW_PRO:
+	case SB_HW_JAZZ16:
 		restore_mixer(chip, sbpro_saved_regs, ARRAY_SIZE(sbpro_saved_regs));
 		break;
 	case SB_HW_16:

--------------080005000804000000030104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080005000804000000030104--
