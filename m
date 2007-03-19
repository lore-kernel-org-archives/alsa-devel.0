From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [RFC][RFT] Adding support for Jazz16 based sound
 cards
Date: Mon, 19 Mar 2007 21:52:50 +0100
Message-ID: <45FEF822.1000701@gmail.com>
References: <20070311232436.GB9778@sygehus.dk> <45FDDA0F.7050503@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050905060001050602000207"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45FDDA0F.7050503@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Rask Ingemann Lambertsen <rask@sygehus.dk>
Cc: Adam Belay <ambx1@neo.rr.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050905060001050602000207
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 03/19/2007 01:32 AM, Rene Herman wrote:

> In snd-jazz16, you'd take port= as a parameter (or autoprobe 220-260
> as you do now; not a fan of autoprobing but that's not the issue now)
> same as other alsa drivers do and take irq/dma8/dma16 parameters as
> requests to use those specified resources and program the card for
> it.

That is, I'd so something like the attached which just keeps it all in 
the driver.

This version also doesn't autoprobe anything; none of the resources 
exist before being programmed into the card and given that BIOS setup 
issue I've gone on about a couple of times you can't just pick any free 
resource or anything but need the user to tell you which ones it has 
reserved for the card. Only probing for "port" would be okay...

The hardware fundamentally supports just one card per system due to the 
fixed SB_JAZZ16_CONFIG_PORT so the driver does as well. Has been tested 
and works okay. It's rather more straightforward then with the new PnP 
protocol.

(if anyone is following along; this is only the top-level driver module 
and still needs Rask's SB code changes applied. Full patch at

http://members.home.nl/rene.herman/jazz16.diff)

Rene.


--------------050905060001050602000207
Content-Type: text/plain;
 name="jazz16.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="jazz16.c"

/* Driver for Media Vision Jazz16 based boards.
 *
 * Copyright (c) 2007 by Rask Ingemann Lambertsen
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 *
 * The Jazz16 is an SB Pro compatible chip with a 16-bit mode and higher
 * playback and capture rates added to it. It is not SB 16 compatible.
 * The chip has an MPU-401 interface which is handled by the MPU-401 driver.
 *
 * The IBM PPS Model 6015 has a Jazz16 chip on board. Please tell me if it
 * works with this driver or not.
 */

#include <sound/driver.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/isa.h>
#include <linux/ioport.h>
#include <asm/dma.h>
#include <asm/io.h>
#include <sound/core.h>
#include <sound/sb.h>
#include <sound/mpu401.h>
#include <sound/opl3.h>
#include <sound/initval.h>

#define CRD_NAME "Media Vision Jazz16"
#define DEV_NAME "jazz16"

MODULE_DESCRIPTION(CRD_NAME);
MODULE_AUTHOR("Rask Ingemann Lambertsen <rask@sygehus.dk>");
MODULE_LICENSE("GPL");

static int index = SNDRV_DEFAULT_IDX1;		/* Index 0-MAX */
static char *id = SNDRV_DEFAULT_STR1;		/* ID for this card */
static int enable = SNDRV_DEFAULT_ENABLE1;	/* Enable this card */
static long port = SNDRV_DEFAULT_PORT1;		/* 0x220,0x240,0x260 */
static long mpu_port = SNDRV_DEFAULT_PORT1;	/* 0x310,0x320,0x330 */
static int irq = SNDRV_DEFAULT_IRQ1;		/* 5,9,3,7,10,15 */
static int mpu_irq = SNDRV_DEFAULT_IRQ1;	/* 5,9,3,7,10,15 */
static int dma8 = SNDRV_DEFAULT_DMA1;		/* 1,3 */
static int dma16 = SNDRV_DEFAULT_DMA1;		/* 5,7 */

module_param(index, int, 0444);
MODULE_PARM_DESC(index, "Index value for " CRD_NAME " soundcard.");
module_param(id, charp, 0444);
MODULE_PARM_DESC(id, "ID string for " CRD_NAME " soundcard.");
module_param(enable, bool, 0444);
MODULE_PARM_DESC(enable, "Enable " CRD_NAME " soundcard.");
module_param(port, long, 0444);
MODULE_PARM_DESC(port, "Port # for " CRD_NAME " driver.");
module_param(mpu_port, long, 0444);
MODULE_PARM_DESC(mpu_port, "MPU-401 port # for " CRD_NAME " driver.");
module_param(irq, int, 0444);
MODULE_PARM_DESC(irq, "IRQ # for " CRD_NAME " driver.");
module_param(mpu_irq, int, 0444);
MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for " CRD_NAME " driver.");
module_param(dma8, int, 0444);
MODULE_PARM_DESC(dma8, "8-bit DMA # for " CRD_NAME " driver.");
module_param(dma16, int, 0444);
MODULE_PARM_DESC(dma16, "16-bit DMA # for " CRD_NAME " driver.");

static int __devinit snd_jazz16_match(struct device *dev, unsigned int n)
{
	if (!enable)
		return 0;

	if (port == SNDRV_AUTO_PORT) {
		snd_printk(KERN_ERR "%s: please specify port\n", dev->bus_id);
		return 0;
	}
	if (irq == SNDRV_AUTO_IRQ) {
		snd_printk(KERN_ERR "%s: please specify irq\n", dev->bus_id);
		return 0;
	}
	if (dma8 == SNDRV_AUTO_DMA) {
		snd_printk(KERN_ERR "%s: please specify dma8\n", dev->bus_id);
		return 0;
	}
	if (dma16 == SNDRV_AUTO_DMA) {
		snd_printk(KERN_ERR "%s: please specify dma16\n", dev->bus_id);
		return 0;
	}
	return 1;
}

static void __devinit snd_jazz16_set_ports(u8 value)
{
        outb(SB_JAZZ16_WAKEUP, SB_JAZZ16_CONFIG_PORT);
        outb(SB_JAZZ16_SET_PORTS, SB_JAZZ16_CONFIG_PORT);
        outb(value, SB_JAZZ16_CONFIG_PORT);
}

#define BUSY_LOOPS 100000

static int __devinit snd_jazz16_sbdsp_command(u8 value)
{
        int i;

        for (i = BUSY_LOOPS; i; i--)
                if ((inb(SBP1(port, STATUS)) & 0x80) == 0) {
                        outb(value, SBP1(port, COMMAND));
                        return 0;
                }
        return -EIO;
}

#define JAZZ16_SET_DMAINTR 0xfb

static int __devinit snd_jazz16_enable(struct device *dev)
{
	static u8 irq_config[] = {0,0,2,3,0,1,0,4,0,2,5,0,0,0,0,6};
	static u8 dma_config[] = {0,1,0,2,0,3,0,4};
	u8 config = 0;

	int error;

	if (port == 0x220 || port == 0x240 || port == 0x260)
		config = port & 0x70;

	if (mpu_port == 0x310 || mpu_port == 0x320 || mpu_port == 0x330)
		config |= (mpu_port >> 4) & 0x07;

	snd_printd("%s: setting SB port = %#lx, MPU port = %#lx.\n",
		dev->bus_id, port, mpu_port);

	snd_jazz16_set_ports(config);

	snd_printd("%s: setting SB irq %d, dma %d&%d, MPU irq %d.\n",
		dev->bus_id, irq, dma8, dma16, mpu_irq);

	error = snd_jazz16_sbdsp_command(JAZZ16_SET_DMAINTR);
	if (error < 0)
		return error;

	config = dma_config[dma8] | dma_config[dma16] << 4;

	error = snd_jazz16_sbdsp_command(config);
	if (error < 0)
		return error;

	config = irq_config[irq] | irq_config[mpu_irq] << 4;

	return snd_jazz16_sbdsp_command(config);
}

static irqreturn_t snd_jazz16_interrupt(int irq, void *dev_id)
{
	return snd_sb8dsp_interrupt(dev_id);
}

static void snd_jazz16_free(struct snd_card *card)
{
	snd_jazz16_set_ports(0);
}

static int __devinit snd_jazz16_probe(struct device *dev, unsigned int n)
{
	struct snd_sb *chip;
	struct snd_card *card;
	struct snd_opl3 *opl3;
	int error;

	card = snd_card_new(index, id, THIS_MODULE, 0);
	if (!card)
		return -EINVAL;

	card->private_free = snd_jazz16_free;

	error = snd_jazz16_enable(dev);
	if (error < 0)
		goto out;

	error = snd_sbdsp_create(card, port, irq, snd_jazz16_interrupt,
			dma8, dma16, SB_HW_AUTO, &chip);
	if (error < 0) 
		goto out;

	if (chip->hardware != SB_HW_JAZZ16) {
		snd_printk(KERN_ERR "%s: not a Jazz16 chip at %#lx.\n",
			dev->bus_id, chip->port);
		error = -ENODEV;
		goto out;
	}

	strcpy(card->driver, "Jazz16");
	strcpy(card->shortname, "Media Vision Jazz16");
	sprintf(card->longname, "%s at %#lx, irq %d, dma8 %d, dma16 %d",
	         chip->name, chip->port, chip->irq, chip->dma8, chip->dma16);

	error = snd_sb8dsp_pcm(chip, 0, NULL);
	if (error < 0)
		goto out;

	error = snd_sbmixer_new(chip);
	if (error < 0)
		goto out;

	error = snd_opl3_create(card, chip->port, chip->port + 2, OPL3_HW_AUTO,
			1, &opl3);
	if (error < 0)
		snd_printk(KERN_WARNING "%s: no OPL device found, skipping.\n",
			dev->bus_id);
	else {
		error = snd_opl3_timer_new(opl3, 1, 2);
		if (error < 0)
			goto out;

		error = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
		if (error < 0)
			goto out;
	}

	snd_card_set_dev(card, dev);

	error = snd_card_register(card);
	if (error < 0)
		goto out;

	dev_set_drvdata(dev, card);
	return 0;

out:	snd_card_free(card);
	return error;
}

static int __devexit snd_jazz16_remove(struct device *dev, unsigned int n)
{
	snd_card_free(dev_get_drvdata(dev));
	dev_set_drvdata(dev, NULL);
	return 0;
}

static struct isa_driver snd_jazz16_driver = {
	.match		= snd_jazz16_match,
	.probe		= snd_jazz16_probe,
	.remove		= __devexit_p(snd_jazz16_remove),

	.driver		= {
		.name	= DEV_NAME
	}
};

static int __devinit alsa_card_jazz16_init(void)
{
	return isa_register_driver(&snd_jazz16_driver, 1);
}

static void __devexit alsa_card_jazz16_exit(void)
{
	isa_unregister_driver(&snd_jazz16_driver);
}

module_init (alsa_card_jazz16_init);
module_exit (alsa_card_jazz16_exit);

--------------050905060001050602000207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------050905060001050602000207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------050905060001050602000207--
