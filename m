From: Rene Herman <rene.herman@gmail.com>
Subject: Re: Can someone verify support for "AzTech Sound
 Galaxy Nova 16 Extra II-3D - using AZT-2316/R Chipset - FCC-ID:I38-MMSN846"
 ?
Date: Mon, 14 May 2007 23:53:18 +0200
Message-ID: <4648DA4E.8050107@gmail.com>
References: <20070513101757.8C8191BF23B@ws1-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060903010708040506060300"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E9C2247CF
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2007 23:55:57 +0200 (CEST)
In-Reply-To: <20070513101757.8C8191BF23B@ws1-1.us4.outblaze.com>
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
--------------060903010708040506060300
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 05/13/2007 12:17 PM, ramkromberg@mail.com wrote:

> EPPROM OFF (SOFTWARE ON):
> 
> in dos: diagnose works,
> reboot and back to lin: sudo modprobe snd-sb8 port=0x220 irq=5 dma8=1
> 
> no error, no mention in dmesg, but xmms gives the usual error...

Yep. The DSP is there but the IRQ isn't firing.

I now understand what the difference between our boards is; we both have a 
jumper that can be set to EEPROM, but only I actually have an EEPROM...

It's amazing the things some manufacturers choose to save a penny on but 
both your and my (formerly) non-working AZT2316A boards do not have an 
actual EEPROM. It should be on that spot marked UX2 close to the clock (the 
shiny metal thing in the lower left corner).

This also means your board is simply not supported by any driver currently 
available in the tree. The driver needs to "play EEPROM" and upload the 
configuration values to the AZT2316 before the card will work and current 
drivers don't do this (under DOS, it's the job of that EEPROM.SYS DOS device 
driver that's executed from CONFIG.SYS).

Attached is a new snd-galaxy driver that _does_  do the enabling. It's not 
final yet, but works nicely for my EEPROM-less boards. It took quite a bit 
of grovveling around but it's completely documented now.

I want to test it with more cards first, with and without EEPROMS and with 
the JMPCFG jumper set to either position, need to figure out full-duplex on 
cards with a CS4231 (as opposed to a half-duplex CS4248), want to see if 
there are any cards among them that allow _both_ the SB and the WSS part to 
be active, and will finally merge in snd-azt2320 as well for one unified 
snd-galaxy driver.

Thought I'd post it now though. You already said you can't compile new 
drivers for that machine anyhow so consider this just for educational 
purposes. In the next message I'll post a small userspace program to do the 
enabling from userspace so that you can use that for now and then just use 
either snd-sb8 or snd-sgalaxy to drive the card.

Rene.

--------------060903010708040506060300
Content-Type: text/plain;
 name="galaxy.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="galaxy.diff"

diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index 4e3a972..4b07dec 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -177,6 +177,19 @@ config SND_ES18XX
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-es18xx.
 
+config SND_GALAXY
+	tristate "Aztech Sound Galaxy Driver"
+	depends on SND
+	select SND_CS4231_LIB
+	select SND_MPU401_UART
+	select SND_OPL3_LIB
+	select SND_PCM
+	help
+	  Say Y here to include support for Aztech Sound Galaxy cards.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-galaxy.
+
 config SND_GUS_SYNTH
 	tristate
 
diff --git a/sound/isa/sb/Makefile b/sound/isa/sb/Makefile
index fd9d9c5..75ced01 100644
--- a/sound/isa/sb/Makefile
+++ b/sound/isa/sb/Makefile
@@ -12,6 +12,7 @@ snd-sb16-objs := sb16.o
 snd-sbawe-objs := sbawe.o emu8000.o
 snd-emu8000-synth-objs := emu8000_synth.o emu8000_callback.o emu8000_patch.o emu8000_pcm.o
 snd-es968-objs := es968.o
+snd-galaxy-objs := galaxy.o
 
 #
 # this function returns:
@@ -25,6 +26,7 @@ sequencer = $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(1),m),$(if $(CONFIG_
 obj-$(CONFIG_SND_ALS100) += snd-sb16-dsp.o snd-sb-common.o
 obj-$(CONFIG_SND_CMI8330) += snd-sb16-dsp.o snd-sb-common.o
 obj-$(CONFIG_SND_DT019X) += snd-sb16-dsp.o snd-sb-common.o
+obj-$(CONFIG_SND_GALAXY) += snd-galaxy.o snd-sb8-dsp.o snd-sb-common.o
 obj-$(CONFIG_SND_SB8) += snd-sb8.o snd-sb8-dsp.o snd-sb-common.o
 obj-$(CONFIG_SND_SB16) += snd-sb16.o snd-sb16-dsp.o snd-sb-common.o
 obj-$(CONFIG_SND_SBAWE) += snd-sbawe.o snd-sb16-dsp.o snd-sb-common.o
diff --git a/sound/isa/sb/galaxy.c b/sound/isa/sb/galaxy.c
new file mode 100644
index 0000000..dd04194
--- /dev/null
+++ b/sound/isa/sb/galaxy.c
@@ -0,0 +1,607 @@
+/*
+ * Aztech Sound Galaxy Driver
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
+#define CRD_NAME "Aztech Sound Galaxy"
+#define DRV_NAME "GALAXY"
+#define DEV_NAME "galaxy"
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
+#define GALAXY_PORT_CONFIG		0x400
+
+#define WSS_PORT_CONFIG			0
+#define WSS_PORT_SIGNATURE		3
+
+#define	WSS_SIGNATURE			4
+
+/*
+ * Sound Galaxy 32-bit serial EEPROM 
+ */
+
+#define GALAXY_CONFIG_SBDMA_DISABLE	(0 << 30)
+#define GALAXY_CONFIG_SBDMA_0		(1 << 30)
+#define GALAXY_CONFIG_SBDMA_1		(2 << 30)
+#define GALAXY_CONFIG_SBDMA_3		(3 << 30)
+
+#define GALAXY_CONFIG_SBIRQ_10		(1 << 29)
+#define GALAXY_CONFIG_SBIRQ_7		(1 << 28)
+#define GALAXY_CONFIG_SBIRQ_5		(1 << 27)
+#define GALAXY_CONFIG_SBIRQ_2		(1 << 26)
+
+#define GALAXY_CONFIG_SBA_220		(0 << 24)
+#define GALAXY_CONFIG_SBA_240		(1 << 24)
+#define GALAXY_CONFIG_SBA_260		(2 << 24)
+#define GALAXY_CONFIG_SBA_280		(3 << 24)
+
+#define GALAXY_CONFIG_CDA_310		(0 << 22)
+#define GALAXY_CONFIG_CDA_320		(1 << 22)
+#define GALAXY_CONFIG_CDA_340		(2 << 22)
+#define GALAXY_CONFIG_CDA_350		(3 << 22)
+
+#define GALAXY_CONFIG_MPU_ENABLE	(1 << 21)
+#define GALAXY_CONFIG_MPUA_300		(0 << 20)
+#define GALAXY_CONFIG_MPUA_330		(1 << 20)
+
+#define GALAXY_CONFIG_GAME_ENABLE	(1 << 19)
+
+#define GALAXY_CONFIG_WSS_ENABLE	(1 << 18)
+#define GALAXY_CONFIG_WSSA_530		(0 << 16)
+#define GALAXY_CONFIG_WSSA_604		(1 << 16)
+#define GALAXY_CONFIG_WSSA_E80		(2 << 16)
+#define GALAXY_CONFIG_WSSA_F40		(3 << 16)
+
+#define GALAXY_CONFIG_CDDMA16_DISABLE	(0 << 14)
+#define GALAXY_CONFIG_CDDMA16_5		(1 << 14)
+#define GALAXY_CONFIG_CDDMA16_6		(2 << 14)
+#define GALAXY_CONFIG_CDDMA16_7		(3 << 14)
+
+#define GALAXY_CONFIG_CDDMA8_DISABLE	(0 << 12)
+#define GALAXY_CONFIG_CDDMA8_0		(1 << 12)
+#define GALAXY_CONFIG_CDDMA8_1		(2 << 12)
+#define GALAXY_CONFIG_CDDMA8_3		(3 << 12)
+
+#define GALAXY_CONFIG_CD_DISABLE	(0 << 8)
+#define GALAXY_CONFIG_CD_PANASONIC	(1 << 8)
+#define GALAXY_CONFIG_CD_SONY		(2 << 8)
+#define GALAXY_CONFIG_CD_MITSUMI	(3 << 8)
+#define GALAXY_CONFIG_CD_AZTECH		(4 << 8)
+
+#define GALAXY_CONFIG_CDIRQ_15		(1 << 7)
+#define GALAXY_CONFIG_CDIRQ_12		(1 << 6)
+#define GALAXY_CONFIG_CDIRQ_11		(1 << 5)
+#define GALAXY_CONFIG_CDIRQ_5		(1 << 4)
+
+#define GALAXY_CONFIG_MPUIRQ_10		(1 << 3)
+#define GALAXY_CONFIG_MPUIRQ_7		(1 << 2)
+#define GALAXY_CONFIG_MPUIRQ_5		(1 << 1)
+#define GALAXY_CONFIG_MPUIRQ_2		(1 << 0)
+
+/*
+ * Sound Galaxy specific DSP commands.
+ */
+
+#define SB_DSP_GALAXY		9
+
+#define GALAXY_DSP_WSSMODE	0
+#define GALAXY_DSP_MPU		2
+#define GALAXY_DSP_MPUA		4
+
+struct snd_galaxy {
+	struct resource *config_port;
+	struct resource *wss_port;
+};
+
+static u32 config[SNDRV_CARDS];
+
+static int __devinit snd_galaxy_match(struct device *dev, unsigned int n)
+{
+	if (!enable[n])
+		return 0;
+
+	switch (port[n]) {
+	case SNDRV_AUTO_PORT:
+		snd_printk(KERN_ERR "%s: please specify port\n", dev->bus_id);
+		return 0;
+	case 0x220:
+		config[n] |= GALAXY_CONFIG_SBA_220;
+		break;
+	case 0x240:
+		config[n] |= GALAXY_CONFIG_SBA_240;
+		break;
+	default:
+		snd_printk(KERN_ERR "%s: invalid port %#lx\n", dev->bus_id,
+			   port[n]);
+		return 0;
+	}
+
+	switch (irq[n]) {
+	case SNDRV_AUTO_IRQ:
+		snd_printk(KERN_ERR "%s: please specify irq\n", dev->bus_id);
+		return 0;
+	case 2:
+		config[n] |= GALAXY_CONFIG_SBIRQ_2;
+		break;
+	case 5:
+		config[n] |= GALAXY_CONFIG_SBIRQ_5;
+		break;
+	case 7:
+		config[n] |= GALAXY_CONFIG_SBIRQ_7;
+		break;
+	case 10:
+		config[n] |= GALAXY_CONFIG_SBIRQ_10;
+		break;
+	default:
+		snd_printk(KERN_ERR "%s: invalid irq %d\n", dev->bus_id,
+			   irq[n]);
+		return 0;
+	}
+
+	switch (dma[n]) {
+	case SNDRV_AUTO_DMA:
+		snd_printk(KERN_ERR "%s: please specify dma\n", dev->bus_id);
+		return 0;
+	case 0:
+		config[n] |= GALAXY_CONFIG_SBDMA_0;
+		break;
+	case 1:
+		config[n] |= GALAXY_CONFIG_SBDMA_1;
+		break;
+	case 3:
+		config[n] |= GALAXY_CONFIG_SBDMA_3;
+		break;
+	default:
+		snd_printk(KERN_ERR "%s: invalid dma %d\n", dev->bus_id,
+			   dma[n]);
+		return 0;
+	}
+
+	switch (wss_port[n]) {
+	case SNDRV_AUTO_PORT:
+		wss_port[n] = -1;
+		goto mpu;
+	case 0x530:
+		config[n] |= GALAXY_CONFIG_WSS_ENABLE | GALAXY_CONFIG_WSSA_530;
+		break;
+	case 0x604:
+		config[n] |= GALAXY_CONFIG_WSS_ENABLE | GALAXY_CONFIG_WSSA_604;
+		break;
+	case 0xe80:
+		config[n] |= GALAXY_CONFIG_WSS_ENABLE | GALAXY_CONFIG_WSSA_E80;
+		break;
+	case 0xf40:
+		config[n] |= GALAXY_CONFIG_WSS_ENABLE | GALAXY_CONFIG_WSSA_F40;
+		break;
+	default:	
+		snd_printk(KERN_ERR "%s: invalid wss port %#lx\n", dev->bus_id,
+			   wss_port[n]);
+		return 0;
+	}
+
+	if (wss_irq[n] == irq[n]) {
+		snd_printk(KERN_ERR "%s: cannot share IRQ between SB and WSS\n",
+			   dev->bus_id);
+		return 0;
+	}
+
+	switch (wss_irq[n]) {
+	case SNDRV_AUTO_IRQ:	
+		snd_printk(KERN_ERR "%s: please specify wss_irq", dev->bus_id);
+		return 0;
+	case 2:
+	case 5:
+	case 7:
+	case 10:
+		break;
+	default:
+		snd_printk(KERN_ERR "%s: invalid wss irq %d\n", dev->bus_id,
+			   irq[n]);
+		return 0;
+	}
+
+  mpu:	
+	switch (mpu_port[n]) {
+	case SNDRV_AUTO_PORT:
+		snd_printk(KERN_WARNING "%s: mpu_port not specified; not using "
+			   "MPU-401\n", dev->bus_id);
+		mpu_port[n] = -1;
+		goto fm;
+	case 0x300:
+		config[n] |= GALAXY_CONFIG_MPU_ENABLE | GALAXY_CONFIG_MPUA_300;
+		break;
+	case 0x330:
+		config[n] |= GALAXY_CONFIG_MPU_ENABLE | GALAXY_CONFIG_MPUA_330;
+		break;
+	default:
+		snd_printk(KERN_ERR "%s: invalid mpu port %#lx\n", dev->bus_id,
+			   mpu_port[n]);
+		return 0;
+	}
+
+	if (mpu_irq[n] == irq[n] || mpu_irq[n] == wss_irq[n]) {
+		snd_printk(KERN_ERR "%s: cannot share IRQ between SB/WSS "
+			   "and MPU-401\n", dev->bus_id);
+		return 0;
+	}
+
+	switch (mpu_irq[n]) {
+	case SNDRV_AUTO_IRQ:
+		snd_printk(KERN_WARNING "%s: mpu_irq not specified; using "
+			   "polling mode\n", dev->bus_id);
+		break;
+	case 2:
+		config[n] |= GALAXY_CONFIG_MPUIRQ_2;
+		break;
+	case 5:
+		config[n] |= GALAXY_CONFIG_MPUIRQ_5;
+		break;
+	case 7:
+		config[n] |= GALAXY_CONFIG_MPUIRQ_7;
+		break;
+	case 10:
+		config[n] |= GALAXY_CONFIG_MPUIRQ_10;
+		break;
+	default:
+		snd_printk(KERN_ERR "%s: invalid mpu irq %d\n", dev->bus_id,
+			   irq[n]);
+		return 0;
+	}
+
+  fm:
+	switch (fm_port[n]) {
+	case SNDRV_AUTO_PORT:
+		snd_printk(KERN_WARNING "%s: fm_port not specified: not using "
+			   "OPL3\n", dev->bus_id);
+		fm_port[n] = -1;
+		break;
+	case 0x388:
+		break;
+	default:
+		snd_printk(KERN_ERR "%s: illegal fm port %#lx\n", dev->bus_id,
+			   fm_port[n]);
+		return 0;
+	}
+
+	config[n] |= GALAXY_CONFIG_GAME_ENABLE;
+
+	return 1;
+}
+
+static int __devinit snd_galaxy_set(struct snd_sb *sb, unsigned char cmd,
+				    int set)
+{
+	int err;
+
+	err = snd_sbdsp_command(sb, SB_DSP_GALAXY);
+	if (err < 0)
+		return err;
+
+	err = snd_sbdsp_command(sb, cmd);
+	if (err < 0)
+		return err;
+
+	return snd_sbdsp_command(sb, set ? 255 : 0);
+}
+
+static int __devinit snd_galaxy_config(struct snd_card *card, struct snd_sb *sb,
+				       u32 config)
+{
+	struct snd_galaxy *galaxy = card->private_data;
+	unsigned char val;
+	int err;
+
+	galaxy->config_port = request_region(sb->port + GALAXY_PORT_CONFIG, 5,
+					     DRV_NAME);
+	if (!galaxy->config_port)
+		return -EBUSY;
+
+	err = snd_galaxy_set(sb, GALAXY_DSP_MPU,
+			     config & GALAXY_CONFIG_MPU_ENABLE);
+	if (err < 0)
+		return err;
+
+	err = snd_galaxy_set(sb, GALAXY_DSP_MPUA,
+			     config & GALAXY_CONFIG_MPUA_330);
+	if (err < 0)
+		return err;
+
+	val = inb(sb->port + GALAXY_PORT_CONFIG + 4);
+
+	outb(val | 0x80, sb->port + GALAXY_PORT_CONFIG + 4);
+	msleep(100);
+
+	outb(config, sb->port + GALAXY_PORT_CONFIG + 3);
+	config >>= 8;
+	outb(config, sb->port + GALAXY_PORT_CONFIG + 2);
+	config >>= 8;
+	outb(config, sb->port + GALAXY_PORT_CONFIG + 1);
+	config >>= 8;
+	outb(config, sb->port + GALAXY_PORT_CONFIG);
+
+	outb(val & 0x7f, sb->port + GALAXY_PORT_CONFIG + 4);
+	msleep(100);
+
+	return 0;
+}
+
+static int __devinit snd_galaxy_wssmode(struct snd_sb *sb)
+{
+	int err;
+
+	err = snd_sbdsp_reset(sb);
+	if (err < 0)
+		return err;
+
+	err = snd_sbdsp_command(sb, SB_DSP_GALAXY);
+	if (err < 0)
+		return err;
+
+	err = snd_sbdsp_command(sb, GALAXY_DSP_WSSMODE);
+	if (err < 0)
+		return err;
+
+	msleep(100);
+
+	return 0;
+}
+
+static int __devinit snd_galaxy_wss(struct snd_card *card, unsigned long port,
+				    int irq, int dma)
+{
+	struct snd_galaxy *galaxy = card->private_data;
+	unsigned char wss_config;
+	struct snd_cs4231 *wss;
+	int err;
+
+	galaxy->wss_port = request_region(port, 4, DRV_NAME);
+	if (!galaxy->wss_port) 
+		return  -EBUSY;
+
+	if ((inb(port + WSS_PORT_SIGNATURE) & 0x3f) != WSS_SIGNATURE) 
+		return -ENODEV;
+
+	switch (irq) {
+	case 7:
+		wss_config = 1 << 3;
+		break;
+	case 9:
+		wss_config = 2 << 3;
+		break;
+	case 10:
+		wss_config = 3 << 3;
+		break;
+	case 11:
+		wss_config = 4 << 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+	outb(wss_config | 0x40, port + WSS_PORT_CONFIG);
+
+	switch (dma) {
+	case 0:
+		wss_config |= 1;
+		break;
+	case 1:
+		wss_config |= 2;
+		break;
+	case 3:
+		wss_config |= 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+	outb(wss_config, port + WSS_PORT_CONFIG);
+
+	err = snd_cs4231_create(card, port + 4, -1, irq, dma, -1,
+				CS4231_HW_DETECT, CS4231_HWSHARE_DMA1, &wss);
+	if (err < 0)
+		return err;
+
+	err = snd_cs4231_pcm(wss, 0, NULL);
+	if (err < 0)
+		return err;
+
+	err = snd_cs4231_mixer(wss);
+	if (err < 0)
+		return err;
+
+	err = snd_cs4231_timer(wss, 0, NULL);
+	if (err < 0)
+		return err;
+
+	strcpy(card->shortname, snd_cs4231_chip_id(wss));
+	sprintf(card->longname, "%s at %#lx, irq %d, dma %d; ",
+		card->shortname, wss->port, wss->irq, wss->dma1);
+
+	return 0;
+}
+
+static irqreturn_t snd_galaxy_interrupt(int irq, void *dev_id)
+{
+	struct snd_sb *sb = dev_id;
+
+	if (sb->open & SB_OPEN_PCM)
+		return snd_sb8dsp_interrupt(sb);
+
+	return snd_sb8dsp_midi_interrupt(sb);
+}
+
+static void snd_galaxy_free(struct snd_card *card)
+{
+	struct snd_galaxy *galaxy = card->private_data;
+
+	release_and_free_resource(galaxy->wss_port);
+	release_and_free_resource(galaxy->config_port);
+}
+
+static int __devinit snd_galaxy_probe(struct device *dev, unsigned int n)
+{
+	struct snd_card *card;
+	struct snd_sb *sb;
+	int err;
+
+	card = snd_card_new(index[n], id[n], THIS_MODULE,
+			    sizeof(struct snd_galaxy));
+	if (!card)
+		return -EINVAL;
+
+	snd_card_set_dev(card, dev);
+
+	err = snd_sbdsp_create(card, port[n], irq[n], snd_galaxy_interrupt,
+			       dma[n], -1, SB_HW_AUTO, &sb);
+	if (err < 0)
+		goto error;
+
+	card->private_free = snd_galaxy_free;
+
+	err = snd_galaxy_config(card, sb, config[n]);
+	if (err < 0)
+		goto error;
+
+	if (wss_port[n] >= 0) {
+		err = snd_galaxy_wssmode(sb);
+		if (err < 0)
+			goto error;
+
+		err = snd_galaxy_wss(card, wss_port[n], wss_irq[n], sb->dma8);
+		if (err < 0)
+			goto error;
+	} else {
+		err = snd_sb8dsp_pcm(sb, 0, NULL);
+		if (err < 0)
+			goto error;
+
+		err = snd_sbmixer_new(sb);
+		if (err < 0)
+			goto error;
+
+		strcpy(card->shortname, sb->name);
+	}
+
+	sprintf(card->longname + strlen(card->longname),
+		"%s at %#lx, irq %d, dma %d",
+		sb->name, sb->port, sb->irq, sb->dma8);
+	strcpy(card->driver, DRV_NAME);
+
+	if (mpu_port[n] >= 0) {
+		err = snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
+					  mpu_port[n], 0, mpu_irq[n],
+					  mpu_irq[n] < 0 ? 0 : IRQF_DISABLED,
+					  NULL);
+		if (err < 0)
+			goto error;
+	}
+
+	if (fm_port[n] >= 0) {
+		struct snd_opl3 *opl3;
+
+		err = snd_opl3_create(card, fm_port[n], fm_port[n] + 2,
+				      OPL3_HW_AUTO, 0, &opl3);
+		if (err < 0) {
+                        snd_printk(KERN_ERR "%s: no OPL device at %#lx\n",
+                                   dev->bus_id, fm_port[n]);
+			goto error;
+		}
+		err = snd_opl3_timer_new(opl3, 1, 2);
+		if (err < 0)
+			goto error;
+
+		err = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
+		if (err < 0)
+			goto error;
+	}
+
+	err = snd_card_register(card);
+	if (err < 0)
+		goto error;
+
+	dev_set_drvdata(dev, card);
+	return 0;
+
+ error:		
+	snd_card_free(card);
+	return err;
+}
+
+static int __devexit snd_galaxy_remove(struct device *dev, unsigned int n)
+{
+	snd_card_free(dev_get_drvdata(dev));
+	dev_set_drvdata(dev, NULL);
+	return 0;
+}
+
+static struct isa_driver snd_galaxy_driver = {
+	.match		= snd_galaxy_match,
+	.probe		= snd_galaxy_probe,
+	.remove		= __devexit_p(snd_galaxy_remove),
+
+	.driver		= {
+		.name	= DEV_NAME
+	}
+};
+
+static int __init alsa_card_galaxy_init(void)
+{
+	return isa_register_driver(&snd_galaxy_driver, SNDRV_CARDS);
+}
+
+static void __exit alsa_card_galaxy_exit(void)
+{
+	isa_unregister_driver(&snd_galaxy_driver);
+}
+
+module_init(alsa_card_galaxy_init);
+module_exit(alsa_card_galaxy_exit);

--------------060903010708040506060300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060903010708040506060300--
