From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: [PATCH] Gallant SC-6000 driver (5th version)
Date: Sun, 9 Sep 2007 22:04:11 +0200
Message-ID: <20070909220411.c7cdc0e2.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by alsa0.perex.cz (Postfix) with ESMTP id E4CA324376
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Sep 2007 21:57:28 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id d21so887270nfb
	for <alsa-devel@alsa-project.org>; Sun, 09 Sep 2007 12:57:28 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This is port of the Gallant SC-6000 driver from the OSS aedsp16 driver.
This card was also sold as AudioExcel DSP 16 and Zoltrix AV302 (Audio Plus True 16).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This version is heavily influenced by Rene's new Sound Galaxy driver.
It uses ioread8/iowrite8 functions and managed port mappings.
It has fixed memory management on error in the probe function.

/*
 *  Driver for Audio Excel DSP 16 soundcard.
 *  Copyright (C) 2007 Krzysztof Helt <krzysztof.h1@wp.pl>
 *
 *  I don't have documentation for this card, I based this driver on the
 *  driver for OSS/Free included in the kernel source.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 */

#include <linux/module.h>
#include <linux/isa.h>
#include <asm/dma.h>
#include <sound/driver.h>
#include <sound/core.h>
#include <sound/ad1848.h>
#include <sound/control.h>
#define SNDRV_LEGACY_FIND_FREE_IRQ
#define SNDRV_LEGACY_FIND_FREE_DMA
#include <sound/initval.h>

MODULE_AUTHOR("Krzysztof Helt");
MODULE_DESCRIPTION("Gallant SC-6000");
MODULE_LICENSE("GPL");
MODULE_SUPPORTED_DEVICE("{{Gallant SC-6000}}");

static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;	/* Enable this card */
static long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* 0x220, 0x240 */
static int irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* 5, 7, 9, 10, 11 */
static long mss_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* 0x530, 0xe80 */
static long mpu_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
						/* 0x300, 0x310, 0x320, 0x330 */
static int mpu_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* 5, 7, 9, 10, 0 */
static int dma[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* 0, 1, 3 */

module_param_array(index, int, NULL, 0444);
MODULE_PARM_DESC(index, "Index value for sc-6000 based soundcard.");
module_param_array(id, charp, NULL, 0444);
MODULE_PARM_DESC(id, "ID string for sc-6000 based soundcard.");
module_param_array(enable, bool, NULL, 0444);
MODULE_PARM_DESC(enable, "Enable sc-6000 based soundcard.");
module_param_array(port, long, NULL, 0444);
MODULE_PARM_DESC(port, "Port # for sc-6000 driver.");
module_param_array(mss_port, long, NULL, 0444);
MODULE_PARM_DESC(mss_port, "MSS Port # for sc-6000 driver.");
module_param_array(mpu_port, long, NULL, 0444);
MODULE_PARM_DESC(mpu_port, "MPU-401 port # for sc-6000 driver.");
module_param_array(irq, int, NULL, 0444);
MODULE_PARM_DESC(irq, "IRQ # for sc-6000 driver.");
module_param_array(mpu_irq, int, NULL, 0444);
MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for sc-6000 driver.");
module_param_array(dma, int, NULL, 0444);
MODULE_PARM_DESC(dma, "DMA # for sc-6000 driver.");

/*
 * Bit mapped flags for calling sc6000_init_board(), and saving the current
 * emulation mode.
 */
#define INIT_NONE   (0)
#define INIT_SBPRO  (1<<0)
#define INIT_MPU401 (1<<1)

#define SC6000_AUXC_LEFT	18
#define SC6000_AUXC_RIGHT	19

/*
 * Commands of SC6000's DSP (SBPRO+special).
 * Some of them are COMMAND_xx, in the future they may change.
 */
#define WRITE_MDIRQ_CFG	0x50	/* Set M&I&DRQ mask (the real config)	*/
#define COMMAND_52	0x52	/*					*/
#define READ_HARD_CFG	0x58	/* Read Hardware Config (I/O base etc)	*/
#define COMMAND_5C	0x5c	/*					*/
#define COMMAND_60	0x60	/*					*/
#define COMMAND_66	0x66	/*					*/
#define COMMAND_6C	0x6c	/*					*/
#define COMMAND_6E	0x6e	/*					*/
#define COMMAND_88	0x88	/*					*/
#define DSP_INIT_MSS	0x8c	/* Enable Microsoft Sound System mode	*/
#define COMMAND_C5	0xc5	/*					*/
#define GET_DSP_VERSION	0xe1	/* Get DSP Version			*/
#define GET_DSP_COPYRIGHT 0xe3	/* Get DSP Copyright			*/

/*
 * Offsets of SC6000 DSP I/O ports. The offset is added to base I/O port
 * to have the actual I/O port.
 * Register permissions are:
 * (wo) == Write Only
 * (ro) == Read  Only
 * (w-) == Write
 * (r-) == Read
 */
#define DSP_RESET	0x06	/* offset of DSP RESET	  	(wo) */
#define DSP_READ	0x0a	/* offset of DSP READ	    	(ro) */
#define DSP_WRITE	0x0c	/* offset of DSP WRITE	  	(w-) */
#define DSP_COMMAND	0x0c	/* offset of DSP COMMAND	(w-) */
#define DSP_STATUS	0x0c	/* offset of DSP STATUS		(r-) */
#define DSP_DATAVAIL	0x0e	/* offset of DSP DATA AVAILABLE	(ro) */

#define PFX		"sc-6000: "

/* hardware dependent functions */

/*
 * sc6000_irq_to_softcfg - Decode irq number into cfg code.
 */
static inline unsigned char sc6000_irq_to_softcfg(int irq)
{
	unsigned char val = 0;

	switch (irq) {
	case 5:
		val = 0x28;
		break;
	case 7:
		val = 0x8;
		break;
	case 9:
		val = 0x10;
		break;
	case 10:
		val = 0x18;
		break;
	case 11:
		val = 0x20;
		break;
	default:
		break;
	}
	return val;
}

/*
 * sc6000_dma_to_softcfg - Decode dma number into cfg code.
 */
static inline unsigned char sc6000_dma_to_softcfg(int dma)
{
	unsigned char val = 0;

	switch (dma) {
	case 0:
		val = 1;
		break;
	case 1:
		val = 2;
		break;
	case 3:
		val = 3;
		break;
	default:
		break;
	}
	return val;
}

/*
 * sc6000_mpu_irq_to_softcfg - Decode MPU-401 irq number into cfg code.
 */
static inline unsigned char sc6000_mpu_irq_to_softcfg(int mpu_irq)
{
	unsigned char val = 0;

	switch (mpu_irq) {
	case 5:
		val = 4;
		break;
	case 7:
		val = 0x44;
		break;
	case 9:
		val = 0x84;
		break;
	case 10:
		val = 0xc4;
		break;
	default:
		break;
	}
	return val;
}

static int sc6000_wait_data(int port)
{
	int loop = 1000;
	unsigned char ret = 0;

	do {
		ret = inb(port + DSP_DATAVAIL);
		if (ret & 0x80)
			return 0;
		cpu_relax();
	} while (loop--);

	return -EAGAIN;
}

static int sc6000_read(int port)
{
	int inbyte;

	snd_printdd("  Read DSP Byte (0x%x): ", port);

	if (sc6000_wait_data(port)) {
		snd_printdd("failure.\n");
		return -EBUSY;
	}

	inbyte = inb(port + DSP_READ);

	snd_printdd("read [0x%x]/{%c}.\n", inbyte, inbyte);
	printk(KERN_DEBUG "read [0x%x]/{%c}.\n", inbyte, inbyte);

	return inbyte;
}

static int sc6000_write(int port, int cmd)
{
	unsigned char ret;
	int loop = 500000;

	snd_printdd("  Write DSP Byte (0x%x) [0x%x]: ", port, cmd);

	do {
		ret = inb(port + DSP_STATUS);
		/*
		 * DSP ready to receive data if bit 7 of ret == 0
		 */
		if (!(ret & 0x80)) {
			outb(cmd, port + DSP_COMMAND);
			snd_printdd("success.\n");
			return 1;
		}
	} while (loop--);

	snd_printdd("timeout.\n");
	snd_printk(KERN_ERR PFX "DSP Command (0x%x) timeout.\n", cmd);

	return -EAGAIN;
}

static int __devinit sc6000_dsp_get_answer(int port, int command, char *data,
					    int data_len)
{
	int len = 0;

	snd_printdd("Get DSP answer:\n");

	if (!sc6000_write(port, command)) {
		snd_printk(KERN_ERR PFX "CMD 0x%x: failed!\n", command);
		snd_printdd("failed.\n");
		return -EFAULT;
	}

	do {
		int ret = sc6000_read(port);
		if (ret < 0) {
	/*
	 * If no more data available, return to the caller, no error if len>0.
	 * We have no other way to know when the string is finished.
	 */
			if (len)
				break;
			else {
				snd_printdd("failed.\n");
				return -ENXIO;
			}
		}

		data[len++] = ret;

	} while (len < data_len);

	snd_printdd("success.\n");

	return len;
}

static int __devinit sc6000_dsp_reset(int port)
{
	snd_printdd("Reset DSP:\n");

	outb(1, port + DSP_RESET);
	udelay(10);
	outb(0, port + DSP_RESET);
	udelay(20);
	if (sc6000_read(port) == 0xaa) {
		snd_printdd("success.\n");
		return 0;
	} else
		snd_printdd("failure.\n");
	return -EBUSY;
}

/* detection and initialization */
static int __devinit sc6000_cfg_write(int port, unsigned char softcfg)
{

	if (sc6000_write(port, WRITE_MDIRQ_CFG) < 0) {
		snd_printk(KERN_ERR PFX "CMD 0x%x: failed!\n", WRITE_MDIRQ_CFG);
		return -ENXIO;
	}
	if (sc6000_write(port, softcfg) < 0) {
		snd_printk(KERN_ERR PFX "sc6000_cfg_write: failed!\n");
		return -ENXIO;
	}
	return 0;
}

static int __devinit sc6000_setup_board(int port, int config)
{
	int loop = 10;

	do {
		if (sc6000_write(port, COMMAND_88) < 0) {
			snd_printk(KERN_ERR PFX "CMD 0x%x: failed!\n",
				   COMMAND_88);
			return -ENXIO;
		}
	} while ((sc6000_wait_data(port) < 0) && loop--);

	if (sc6000_read(port) < 0) {
		snd_printk(KERN_ERR "sc6000_read after CMD 0x%x: failed\n",
			   COMMAND_88);
		return -ENXIO;
	}

	if (sc6000_cfg_write(port, config) < 0)
		return -EFAULT;

	return 0;
}

static int __devinit snd_sc6000_match(struct device *devptr, unsigned int dev)
{
	if (!enable[dev])
		return 0;
	if (port[dev] == SNDRV_AUTO_PORT) {
		printk(KERN_ERR PFX "specify IO port\n");
		return 0;
	}
	if (mss_port[dev] == SNDRV_AUTO_IRQ) {
		printk(KERN_ERR PFX "specify MSS port\n");
		return 0;
	}
	return 1;
}

static int __devinit sc6000_init_mss(int port, int config, int mss_port,
				      int mss_config)
{
	snd_printdd("sc6000_init_mss:\n");

	if (sc6000_write(port, DSP_INIT_MSS) < 0) {
		snd_printk(KERN_ERR PFX "sc6000_init_mss [0x%x]: failed!\n",
			   DSP_INIT_MSS);
		snd_printdd("failure.\n");
		return -ENXIO;
	}

	mdelay(10);

	if (sc6000_cfg_write(port, config) < 0)
		return -ENXIO;

	outb(mss_config, mss_port);

	snd_printdd("success.\n");

	return 0;
}

static int __devinit sc6000_init_board(int port, int irq, int dma,
					int mss_port, int mpu_irq)
{
	char answer[15];
	int mss_config = sc6000_irq_to_softcfg(irq) |
			 sc6000_dma_to_softcfg(dma);
	int config = mss_config |
		     sc6000_mpu_irq_to_softcfg(mpu_irq);

	printk(KERN_DEBUG "mss_config: %x, config = %x\n",mss_config,config);
	if (sc6000_dsp_reset(port)) {
		snd_printk(KERN_ERR PFX "sc6000_dsp_reset: failed!\n");
		return -EBUSY;
	}

	if (sc6000_dsp_get_answer(port, GET_DSP_COPYRIGHT, answer, 15) <= 0) {
		snd_printk(KERN_ERR PFX "sc6000_dsp_copyright: failed!\n");
		return -ENXIO;
	}
	/*
	 * My SC-6000 card return "SC-6000" in DSPCopyright, so
	 * if we have something different, we have to be warned.
	 */
	if (strcmp("SC-6000", answer))
		snd_printk(KERN_ERR PFX "Warning: non SC-6000 audio card!\n");

	if (sc6000_dsp_get_answer(port, GET_DSP_VERSION, answer, 2) < 2) {
		snd_printk(KERN_ERR PFX "sc6000_dsp_version: failed!\n");
		return -ENXIO;
	}

	/*
	 * 0x0A == (IRQ 7, DMA 1, MIRQ 0)
	 */
	if (sc6000_cfg_write(port, 0x0a) < 0) {
		snd_printk(KERN_ERR PFX "sc6000_stdcfg: failed!\n");
		return -EFAULT;
	}

	if (sc6000_setup_board(port, config) < 0) {
		snd_printk(KERN_ERR PFX "sc6000_setup_board: failed!\n");
		return -ENODEV;
	}

	if (sc6000_init_mss(port, config, mss_port,
			     mss_config) < 0) {
		snd_printk(KERN_ERR PFX "Can not initialize"
			   "Microsoft Sound System mode.\n");
		return -ENODEV;
	}

	return 0;
}

static int __devinit snd_sc6000_detect(int dev, int irq, int dma)
{
	int err = -ENODEV;

	snd_printdd("Initializing BASE[0x%x] IRQ[%d] DMA[%d] MIRQ[%d]\n",
		    port, irq, dma, mpu_irq);

/*
 * We must request the port region because these are the I/O
 * ports to access card's control registers.
 */
	if (!request_region(port[dev], 0x10, "sc-6000 (base)")) {
		snd_printk(KERN_ERR PFX
			   "SC-6000 port I/O port region is already in use.\n");
		return -EBUSY;
	}

	err = sc6000_init_board(port[dev],irq,dma,mss_port[dev],mpu_irq[dev]);

	release_region(port[dev], 0x10);

	return err;
}

static int __devinit snd_sc6000_probe(struct device *devptr, unsigned int dev)
{
	static int possible_irqs[] = { 7, 9, 10, 11, -1 };
	static int possible_dmas[] = { 1, 3, 0, -1 };
	int err;
	int xirq = irq[dev];
	int xdma = dma[dev];
	struct snd_card *card;
	struct snd_ad1848 *chip;

	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
	if (card == NULL)
		return -ENOMEM;

	if (xirq == SNDRV_AUTO_IRQ) {
		xirq = snd_legacy_find_free_irq(possible_irqs);
		if (xirq < 0) {
			snd_printk(KERN_ERR PFX "unable to find a free IRQ\n");
			err = -EBUSY;
			goto _err;
		}
	}

	if (xdma == SNDRV_AUTO_DMA) {
		xdma = snd_legacy_find_free_dma(possible_dmas);
		if (xdma < 0) {
			snd_printk(KERN_ERR PFX "unable to find a free DMA\n");
			err = -EBUSY;
			goto _err;
		}
	}

	printk(KERN_DEBUG "irq %d dma %d\n",xirq,xdma);
	err = snd_sc6000_detect(dev, xirq, xdma);
	if (err < 0)
		goto _err;

	err = snd_ad1848_create(card, mss_port[dev] + 4, xirq, xdma,
				AD1848_HW_DETECT, &chip);
	if (err < 0)
		goto _err;
	card->private_data = chip;

	err = snd_ad1848_pcm(chip, 0, NULL);
	if (err < 0) {
		snd_printdd(PFX "error creating new ad1848 PCM device\n");
		goto _err;
	}
	err = snd_ad1848_mixer(chip);
	if (err < 0) {
		snd_printdd(PFX "error creating new ad1848 mixer\n");
		goto _err;
	}
#ifdef NOT_WORKING
	err = snd_sc6000_mixer(chip);
	if (err < 0) {
		snd_printdd(PFX "the mixer rewrite failed\n");
		goto _err;
	}
#endif

	strcpy(card->driver, "Gallant SC-6000");
	strcpy(card->shortname, "Gallant SC-6000");
	sprintf(card->longname, "Gallant SC-6000 at 0x%lx, irq %d, dma %d",
		mss_port[dev], xirq, xdma);

	snd_card_set_dev(card, devptr);

	err = snd_card_register(card);
	if (err < 0)
		goto _err;

	dev_set_drvdata(devptr, card);
	return 0;

 _err:
	snd_card_free(card);
	return err;
}

static int __devexit snd_sc6000_remove(struct device *devptr, unsigned int dev)
{
	snd_card_free(dev_get_drvdata(devptr));
	dev_set_drvdata(devptr, NULL);
	return 0;
}

static struct isa_driver snd_sc6000_driver = {
	.match		= snd_sc6000_match,
	.probe		= snd_sc6000_probe,
	.remove		= __devexit_p(snd_sc6000_remove),
	/* FIXME: suspend/resume */
	.driver		= {
		.name	= "sc6000",
	},
};


static int __init alsa_card_sc6000_init(void)
{
	return isa_register_driver(&snd_sc6000_driver, SNDRV_CARDS);
}

static void __exit alsa_card_sc6000_exit(void)
{
	isa_unregister_driver(&snd_sc6000_driver);
}

module_init(alsa_card_sc6000_init)
module_exit(alsa_card_sc6000_exit)
