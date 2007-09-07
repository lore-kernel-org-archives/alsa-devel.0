From: Rene Herman <rene.herman@gmail.com>
Subject: [PATCH] New Aztech Sound Galaxy driver.
Date: Sat, 08 Sep 2007 01:22:43 +0200
Message-ID: <46E1DD43.6060403@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000004060902080503020300"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C618103824
	for <alsa-devel@alsa-project.org>;
	Sat,  8 Sep 2007 01:29:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, Ram Kromberg <ramkromberg@mail.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000004060902080503020300
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Good day.

This is not being submitted yet...

This is a new driver for Aztech Sound Galaxy soundcards. At the moment, it 
supports all AZT2316A/R based cards which make up the bulk of SG cards. It's 
been tested and found to be working with:

1. FCC-ID I38-MMSN824: Aztech Sound Galaxy Pro 16 AB
2. FCC-ID I38-MMSN826: Aztech Sound Galaxy Waverider 32+
3. FCC-ID I38-MMSN830: Trust Sound Expert DeLuxe 16+
4. FCC-ID I38-MMSN847: Trust Sound Expert DeLuxe Wave 32-3D
5. FCC-ID I38-MMSN852: Aztech Sound Galaxy Waverider Pro 32-3D

where:

1. I38-MMSN824 = AZT2316A + CS4248-KL, without EEPROM
2. I38-MMSN826 = AZT2316A + AD1845XP, with EEPROM
3. I38-MMSN830 = AZT2316A + CS4248-KL, without EEPROM, and some cards:
                  AZT2316A + AD1845-XP, without EEPROM
4. I38-MMSN847 = AZT2316R + CS4231A-KL, with EEPROM
5. I38-MMSN852 = AZT2316R + CS4231A-KL, with EEPROM

All cards with a settings EEPROM have been tested with their JMPCFG jumper 
set to both EEPROM and SOFTWARE, and work correctly in both situations.

All cards support full-duplex. The ones with AD1845XP codecs seem to be a 
little flakey, where starting a capture _sometimes_ hangs a concurrent 
playback, and sometimes not.

Except the ones with a CS4248-KL codec, all cards experience a 
"cs4231_mce_down - auto calibration time out (1)" upon loading which does 
not seem to have any further consequences. Both this and the previous point 
may be cause for debugging cs4231_lib. Later...

Ram -- included you in the CC because you had a:

FCC-ID: I38-MMSN846: Aztech Sound Galaxy Nova 16 Extra II-3D, AZT2316R + 
CS4231A-KL, without EEPROM

The attached patch is against 2.6.22.x and if you're setup to test, feel 
free and I'll add your card to the "was tested on" list. If you're not, 
don't bother too much though -- it'll work (and sorry for the long delay by 
the way...).

As to the AZT2316A/R chipset series, this driver seems complete and correct. 
I also have a couple of Aztech Sound Galaxy cards with an AZT1605 chipset 
(and one even older Sound Galaxy) though and those don't quite/fully work 
yet as their EEPROMs are layed out slightly different -- they also store 
default volumes in the EEPROM for example. Got about half of it mapped out 
already but can't work on it tomorrow so thought I'd post now.

Finally I have a bunch of AZT2320 based cards, which are PnP based, and 
which I'll merge in as well.

Krzysztof -- you won't be surprised to learn that this driver doesn't do 
auto-probing. It needs all parameters passed in; normally:

   options snd-galaxy port=0x220 wss_port=0x530 irq=10 dma1=1 dma2=0

If you don't specify dma2 (or set it equal to dma1) the card's setup in 
half-duplex mode. I'll document it all upon driver submission. Your 
(expected) Waverider should also work fine with it. If/when you test it, 
could you provide the information such as given in the tables above?

You have an EEPROM if you have "X24C00" chip sitting on a spot marked "UX2" 
on the board, close to a crystal (silver shiny thing). If that spot is 
empty, you have an EEPROM-less variant.

Mapping out the rest of AZT1605 (there may also be a duplex diference there) 
will be sunday or next week.

Rene.


--------------000004060902080503020300
Content-Type: text/plain;
 name="galaxy.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="galaxy.diff"

diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index cf3803c..02a0f55 100644
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
 
diff --git a/sound/isa/Makefile b/sound/isa/Makefile
index bb317cc..28bf545 100644
--- a/sound/isa/Makefile
+++ b/sound/isa/Makefile
@@ -12,6 +12,7 @@ snd-es18xx-objs := es18xx.o
 snd-opl3sa2-objs := opl3sa2.o
 snd-sgalaxy-objs := sgalaxy.o
 snd-sscape-objs := sscape.o
+snd-galaxy-objs := galaxy.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_ADLIB) += snd-adlib.o
@@ -23,6 +24,7 @@ obj-$(CONFIG_SND_ES18XX) += snd-es18xx.o
 obj-$(CONFIG_SND_OPL3SA2) += snd-opl3sa2.o
 obj-$(CONFIG_SND_SGALAXY) += snd-sgalaxy.o
 obj-$(CONFIG_SND_SSCAPE) += snd-sscape.o
+obj-$(CONFIG_SND_GALAXY) += snd-galaxy.o
 
 obj-$(CONFIG_SND) += ad1816a/ ad1848/ cs423x/ es1688/ gus/ opti9xx/ \
 		     sb/ wavefront/
diff --git a/sound/isa/galaxy.c b/sound/isa/galaxy.c
new file mode 100644
index 0000000..8f8e9af
--- /dev/null
+++ b/sound/isa/galaxy.c
@@ -0,0 +1,674 @@
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
+static int mpu_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;
+static int dma1[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;
+static int dma2[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;
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
+module_param_array(mpu_irq, int, NULL, 0444);
+MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for " CRD_NAME " driver.");
+module_param_array(dma1, int, NULL, 0444);
+MODULE_PARM_DESC(dma1, "Playback DMA # for " CRD_NAME " driver.");
+module_param_array(dma2, int, NULL, 0444);
+MODULE_PARM_DESC(dma2, "Capture DMA # for " CRD_NAME " driver.");
+
+/*
+ * Sound Galaxy 32-bit serial EEPROM
+ */
+
+#define GALAXY_PORT_CONFIG		1024
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
+#define GALAXY_CONFIG_SBA_MASK		GALAXY_CONFIG_SBA_280
+
+#define GALAXY_CONFIG_CDA_310		(0 << 22)
+#define GALAXY_CONFIG_CDA_320		(1 << 22)
+#define GALAXY_CONFIG_CDA_340		(2 << 22)
+#define GALAXY_CONFIG_CDA_350		(3 << 22)
+#define GALAXY_CONFIG_CDA_MASK		GALAXY_CONFIG_CDA_350
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
+#define GALAXY_CONFIG_CDDMA16_MASK	GALAXY_CONFIG_CDDMA16_7
+
+#define GALAXY_CONFIG_CDDMA8_DISABLE	(0 << 12)
+#define GALAXY_CONFIG_CDDMA8_0		(1 << 12)
+#define GALAXY_CONFIG_CDDMA8_1		(2 << 12)
+#define GALAXY_CONFIG_CDDMA8_3		(3 << 12)
+#define GALAXY_CONFIG_CDDMA8_MASK	GALAXY_CONFIG_CDDMA8_3
+
+#define GALAXY_CONFIG_CD_DISABLE	(0 << 8)
+#define GALAXY_CONFIG_CD_PANASONIC	(1 << 8)
+#define GALAXY_CONFIG_CD_SONY		(2 << 8)
+#define GALAXY_CONFIG_CD_MITSUMI	(3 << 8)
+#define GALAXY_CONFIG_CD_AZTECH		(4 << 8)
+#define GALAXY_CONFIG_CD_UNUSED_0	(5 << 8)
+#define GALAXY_CONFIG_CD_UNUSED_1	(6 << 8)
+#define GALAXY_CONFIG_CD_UNUSED_2	(7 << 8)
+#define GALAXY_CONFIG_CD_MASK		GALAXY_CONFIG_CD_UNUSED_2
+
+#define GALAXY_CONFIG_CDIRQ_15		(1 << 7)
+#define GALAXY_CONFIG_CDIRQ_12		(1 << 6)
+#define GALAXY_CONFIG_CDIRQ_11		(1 << 5)
+#define GALAXY_CONFIG_CDIRQ_5		(1 << 4)
+#define GALAXY_CONFIG_CDIRQ_MASK	(\
+	GALAXY_CONFIG_CDIRQ_15 | GALAXY_CONFIG_CDIRQ_12	|\
+	GALAXY_CONFIG_CDIRQ_11 | GALAXY_CONFIG_CDIRQ_5)
+
+#define GALAXY_CONFIG_MPUIRQ_10		(1 << 3)
+#define GALAXY_CONFIG_MPUIRQ_7		(1 << 2)
+#define GALAXY_CONFIG_MPUIRQ_5		(1 << 1)
+#define GALAXY_CONFIG_MPUIRQ_2		(1 << 0)
+
+#define GALAXY_CONFIG_MASK		(\
+	GALAXY_CONFIG_SBA_MASK | GALAXY_CONFIG_CDA_MASK |\
+	GALAXY_CONFIG_CDDMA16_MASK | GALAXY_CONFIG_CDDMA8_MASK |\
+	GALAXY_CONFIG_CD_MASK | GALAXY_CONFIG_CDIRQ_MASK)
+
+/*
+ * WSS 8-bit configuration register
+ */
+
+#define WSS_PORT_CONFIG			0
+
+#define WSS_CONFIG_IRQ_7		(1 << 3)
+#define WSS_CONFIG_IRQ_9		(2 << 3)
+#define WSS_CONFIG_IRQ_10		(3 << 3)
+#define WSS_CONFIG_IRQ_11		(4 << 3)
+
+#define WSS_CONFIG_DUPLEX		(1 << 2)
+
+#define WSS_CONFIG_DMA_0		(1 << 0)
+#define WSS_CONFIG_DMA_1		(2 << 0)
+#define WSS_CONFIG_DMA_3		(3 << 0)
+
+#define WSS_PORT_SIGNATURE		3
+#define	WSS_SIGNATURE			4
+
+/*
+ * Generic SB DSP registers
+ */
+
+#define DSP_PORT_RESET			0x6
+#define DSP_PORT_READ			0xa
+#define DSP_PORT_COMMAND		0xc
+#define DSP_PORT_STATUS			0xc
+#define DSP_PORT_DATA_AVAIL		0xe
+
+#define DSP_SIGNATURE			0xaa
+
+/*
+ * Sound Galaxy specific DSP commands.
+ */
+
+#define DSP_COMMAND_GALAXY		9
+
+#define GALAXY_COMMAND_WSSMODE		0
+#define GALAXY_COMMAND_SBPMODE		1
+#define GALAXY_COMMAND_MPU		2
+#define GALAXY_COMMAND_MPUA		4
+
+#define GALAXY_MODE_WSS			GALAXY_COMMAND_WSSMODE
+#define GALAXY_MODE_SBP			GALAXY_COMMAND_SBPMODE
+
+struct snd_galaxy {
+	void __iomem *port;
+	void __iomem *config_port;
+	void __iomem *wss_port;
+	struct resource *res_port;
+	struct resource *res_config_port;
+	struct resource *res_wss_port;
+	u32 config;
+};
+
+static u32 config[SNDRV_CARDS];
+static u8 wss_config[SNDRV_CARDS];
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
+	switch (wss_port[n]) {
+	case SNDRV_AUTO_PORT:
+		snd_printk(KERN_ERR "%s: please specify wss_port\n",
+			   dev->bus_id);
+		return 0;
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
+		snd_printk(KERN_ERR "%s: invalid WSS port %#lx\n", dev->bus_id,
+			   wss_port[n]);
+		return 0;
+	}
+
+	switch (irq[n]) {
+	case SNDRV_AUTO_IRQ:
+		snd_printk(KERN_ERR "%s: please specify irq\n", dev->bus_id);
+		return 0;
+	case 7:
+		wss_config[n] |= WSS_CONFIG_IRQ_7;
+		break;
+	case 9:
+	case 2:
+		wss_config[n] |= WSS_CONFIG_IRQ_9;
+		break;
+	case 10:
+		wss_config[n] |= WSS_CONFIG_IRQ_10;
+		break;
+	case 11:
+		wss_config[n] |= WSS_CONFIG_IRQ_11;
+		break;
+	default:
+		snd_printk(KERN_ERR "%s: invalid IRQ %d\n", dev->bus_id,
+			   irq[n]);
+		return 0;
+	}
+
+	switch (dma1[n]) {
+	case SNDRV_AUTO_DMA:
+		snd_printk(KERN_ERR "%s: please specify dma1\n",
+			   dev->bus_id);
+		return 0;
+	case 0:
+		wss_config[n] |= WSS_CONFIG_DMA_0;
+		break;
+	case 1:
+		wss_config[n] |= WSS_CONFIG_DMA_1;
+		break;
+	case 3:
+		wss_config[n] |= WSS_CONFIG_DMA_3;
+		break;
+	default:
+		snd_printk(KERN_ERR "%s: invalid playback DMA %d\n",
+			   dev->bus_id, dma1[n]);
+		return 0;
+	}
+
+	if (dma2[n] == SNDRV_AUTO_DMA || dma2[n] == dma1[n]) {
+		dma2[n] = -1;
+		goto mpu;
+	}
+
+	wss_config[n] |= WSS_CONFIG_DUPLEX;
+	switch (dma2[n]) {
+	case 1:
+		if (dma1[n] == 0)
+	case 0:
+			break;
+	default:
+		snd_printk(KERN_ERR "%s: invalid capture DMA %d\n",
+			   dev->bus_id, dma2[n]);
+		return 0;
+	}
+
+mpu:
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
+	if (mpu_irq[n] == irq[n]) {
+		snd_printk(KERN_ERR "%s: cannot share IRQ between WSS and "
+			   "MPU-401\n", dev->bus_id);
+		return 0;
+	}
+
+	switch (mpu_irq[n]) {
+	case SNDRV_AUTO_IRQ:
+		snd_printk(KERN_WARNING "%s: mpu_irq not specified; using "
+			   "polling mode\n", dev->bus_id);
+		mpu_irq[n] = -1;
+		break;
+	case 2:
+	case 9:
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
+fm:
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
+	return 1;
+}
+
+static int __devinit __reset(struct snd_galaxy *galaxy)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(100);
+
+	iowrite8(1, galaxy->port + DSP_PORT_RESET);
+	udelay(10);
+	iowrite8(0, galaxy->port + DSP_PORT_RESET);
+	udelay(10);
+
+	while (!(ioread8(galaxy->port + DSP_PORT_DATA_AVAIL) & 0x80)) {
+		if (time_after(jiffies, timeout))
+			return -EIO;
+		cpu_relax();
+	}
+	if (ioread8(galaxy->port + DSP_PORT_READ) != DSP_SIGNATURE)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int __devinit __command(struct snd_galaxy *galaxy, unsigned char cmd)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(100);
+
+	while (ioread8(galaxy->port + DSP_PORT_STATUS) & 0x80) {
+		if (time_after(jiffies, timeout))
+			return -EIO;
+		cpu_relax();
+	}
+	iowrite8(cmd, galaxy->port + DSP_PORT_COMMAND);
+
+	return 0;
+}
+
+static int __devinit snd_galaxy_set(struct snd_galaxy *galaxy,
+				    unsigned char cmd, int set)
+{
+	int err;
+
+	err = __command(galaxy, DSP_COMMAND_GALAXY);
+	if (err < 0)
+		return err;
+
+	err = __command(galaxy, cmd);
+	if (err < 0)
+		return err;
+
+	err = __command(galaxy, set ? 255 : 0);
+
+	return err;
+}
+
+static u32 __devinit __get_config(struct snd_galaxy *galaxy)
+{
+	return ioread32be(galaxy->config_port);
+}
+
+static void __devinit __set_config(struct snd_galaxy *galaxy, u32 config)
+{
+	unsigned char tmp = ioread8(galaxy->config_port + 4);
+
+	iowrite8(tmp | 0x80, galaxy->config_port + 4);
+	udelay(10);
+	iowrite32be(config, galaxy->config_port);
+	udelay(10);
+	iowrite8(tmp & 0x7f, galaxy->config_port + 4);
+}
+
+static int __devinit snd_galaxy_config(struct snd_galaxy *galaxy, u32 config)
+{
+	int err;
+
+	err = snd_galaxy_set(galaxy, GALAXY_COMMAND_MPU,
+			     config & GALAXY_CONFIG_MPU_ENABLE);
+	if (err < 0)
+		return err;
+
+	err = snd_galaxy_set(galaxy, GALAXY_COMMAND_MPUA,
+			     config & GALAXY_CONFIG_MPUA_330);
+	if (err < 0)
+		return err;
+
+	galaxy->config = __get_config(galaxy);
+	__set_config(galaxy, (galaxy->config & GALAXY_CONFIG_MASK) | config);
+
+	msleep(100);
+	return 0;
+}
+
+static int __devinit snd_galaxy_setmode(struct snd_galaxy *galaxy, int mode)
+{
+	int err;
+
+	err = __reset(galaxy);
+	if (err < 0)
+		return err;
+
+	err = __command(galaxy, DSP_COMMAND_GALAXY);
+	if (err < 0)
+		return err;
+
+	err = __command(galaxy, mode);
+	if (err < 0)
+		return err;
+
+	msleep(100);
+	return 0;
+}
+
+static unsigned char __devinit __wss_signature(struct snd_galaxy *galaxy)
+{
+	return ioread8(galaxy->wss_port + WSS_PORT_SIGNATURE) & 0x3f;
+}
+
+static void __devinit __wss_config(struct snd_galaxy *galaxy, u8 wss_config)
+{
+	iowrite8(wss_config, galaxy->wss_port + WSS_PORT_CONFIG);
+}
+
+static int __devinit snd_galaxy_wss_config(struct snd_galaxy *galaxy,
+					   u8 wss_config)
+{
+	if (__wss_signature(galaxy) != WSS_SIGNATURE)
+		return -ENODEV;
+
+	__wss_config(galaxy, wss_config);
+
+	msleep(100);
+	return 0;
+}
+
+static void snd_galaxy_free(struct snd_card *card)
+{
+	struct snd_galaxy *galaxy = card->private_data;
+
+	if (galaxy->wss_port) {
+		__wss_config(galaxy, 0);
+		ioport_unmap(galaxy->wss_port);
+		release_and_free_resource(galaxy->res_wss_port);
+	}
+	if (galaxy->config_port) {
+		__set_config(galaxy, galaxy->config);
+		ioport_unmap(galaxy->config_port);
+		release_and_free_resource(galaxy->res_config_port);
+	}
+	if (galaxy->port) {
+		ioport_unmap(galaxy->port);
+		release_and_free_resource(galaxy->res_port);
+	}
+}
+
+static int __devinit snd_galaxy_probe(struct device *dev, unsigned int n)
+{
+	struct snd_galaxy *galaxy;
+	struct snd_cs4231 *chip;
+	struct snd_card *card;
+	int err;
+
+	card = snd_card_new(index[n], id[n], THIS_MODULE, sizeof *galaxy);
+	if (!card)
+		return -EINVAL;
+
+	snd_card_set_dev(card, dev);
+
+	card->private_free = snd_galaxy_free;
+	galaxy = card->private_data;
+
+	galaxy->res_port = request_region(port[n], 16, DRV_NAME);
+	if (!galaxy->res_port) {
+		err = -EBUSY;
+		goto error;
+	}
+	galaxy->port = ioport_map(port[n], 16);
+
+	err = __reset(galaxy);
+	if (err < 0) {
+		snd_printd("%s: DSP not found at %#lx\n", dev->bus_id, port[n]);
+		goto error;
+	}
+
+	galaxy->res_config_port = request_region(port[n] + GALAXY_PORT_CONFIG,
+						 16, DRV_NAME);
+	if (!galaxy->res_config_port) {
+		err = -EBUSY;
+		goto error;
+	}
+	galaxy->config_port = ioport_map(port[n] + GALAXY_PORT_CONFIG, 16);
+
+	err = snd_galaxy_config(galaxy, config[n]);
+	if (err < 0)
+		goto error;
+
+	galaxy->res_wss_port = request_region(wss_port[n], 4, DRV_NAME);
+	if (!galaxy->res_wss_port)  {
+		err = -EBUSY;
+		goto error;
+	}
+	galaxy->wss_port = ioport_map(wss_port[n], 4);
+
+	err = snd_galaxy_wss_config(galaxy, wss_config[n]);
+	if (err < 0) {
+		snd_printd("%s: WSS not found at %#lx\n", dev->bus_id,
+			   wss_port[n]);
+		goto error;
+	}
+
+	err = snd_galaxy_setmode(galaxy, GALAXY_MODE_WSS);
+	if (err < 0)
+		goto error;
+
+	strcpy(card->driver, DRV_NAME);
+	strcpy(card->shortname, DRV_NAME);
+
+	err = snd_cs4231_create(card, wss_port[n] + 4, -1, irq[n], dma1[n],
+				dma2[n], CS4231_HW_DETECT, 0, &chip);
+	if (err < 0)
+		return err;
+
+	sprintf(card->longname, "%s at %#lx, irq %d, dma %d/%d",
+		card->shortname, chip->port, chip->irq, chip->dma1, chip->dma2);
+
+	err = snd_cs4231_pcm(chip, 0, NULL);
+	if (err < 0)
+		return err;
+
+	err = snd_cs4231_mixer(chip);
+	if (err < 0)
+		return err;
+
+	err = snd_cs4231_timer(chip, 0, NULL);
+	if (err < 0)
+		return err;
+
+	if (mpu_port[n] >= 0) {
+		err = snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
+					  mpu_port[n], 0, mpu_irq[n],
+					  IRQF_DISABLED, NULL);
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
+error:
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

--------------000004060902080503020300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000004060902080503020300--
