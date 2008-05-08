From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: SoC sound support for imx27
Date: Thu, 08 May 2008 12:25:13 +0100
Message-ID: <1210245913.11933.24.camel@odin>
References: <200804231654.44526.jbe@pengutronix.de>
	<200805051256.38153.jbe@pengutronix.de>
	<20080505124233.GE3426@sirena.org.uk>
	<200805080954.28299.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-1sFTG62O9+8wkosJnLbV"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 38B4E24573
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 13:25:16 +0200 (CEST)
In-Reply-To: <200805080954.28299.jbe@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Juergen Beisert <jbe@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--=-1sFTG62O9+8wkosJnLbV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2008-05-08 at 09:54 +0200, Juergen Beisert wrote:

> 
> I'm confused how to link the pcm-layer and the transmission layer together. 
> pxa2xx-i2s.c registers a codec-dai (line 346), while the imx-ssi.c registers 
> (line 864) a platform-dai (internally called a cpu_dai. BTW: why a different 
> name?). I _believe_ the CPU DAI tries to connect the CPU-pcm to the 
> transmission interface like ssi or i2s on the same chip. But both 
> implementations are using the same layering (pcm-dma and ssi/i2s), but 
> registering different DAIs. 
> 
> Now I have an ssi driver for my CPU (to be more precise: Two instances of it, 
> when I registering two ssi devices in my BSP file). But how to tell the CPU 
> pcm-layer which one it should use (and for what purpose, play, capture)? And 
> only the ssi driver itself knows how to interact with the DMA controller. But 
> this information is needed in the CPU pcm-layer as it setup the DMA.
> 
> Does a list exists, where I can store driver's private data in each layer 
> (mapped iomem addresses for example)? And how to access it, when I only get 
> a "struct snd_pcm_substream" as a parameter?
> 

You shouldn't need to write an I2S driver for the i.MX2x SSI port as the
i.MX3x SSI is very similar (maybe identical). Please try imx-ssi.c
first, although it may need some changes if the register defs are
different and will need changes for DMA config.

Fwiw, I've attached an older 2.4 OSS driver for the i.MX21. This may
help with the DMA.

Liam

--=-1sFTG62O9+8wkosJnLbV
Content-Disposition: attachment; filename=mx2ads-wm8731.c
Content-Type: text/x-csrc; name=mx2ads-wm8731.c; charset=utf-8
Content-Transfer-Encoding: 7bit

/******************************************************************************

	mx2ads-wm8731.c
	driver for wm8731 sound codec installed on Motorola MX2ADS board

	features:
	  - volume control
	  - Line IN or Mic In for recording
	  - OSS Sound Support
	  - supports 16-bit stereo/mono at 8KHz or 44.1KHz

	Copyright (c) 2004 MontaVista Software, Inc. <source@mvista.com>

	register initialization based on dbmx-mw8731-audio.c
	from Motorola's BSP rel. 1.0.2 beta for MX2ADS

	Copyright (C) 2003 Motorola Inc Ltd

	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
	

********************************************************************************/
#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/sched.h>
#include <linux/init.h>
#include <asm/uaccess.h>

#include <linux/delay.h>

#include <linux/i2c.h>

#include <asm/dma.h>
#include <asm/arch/dma.h>
#include <asm/arch/gpio.h>
#include <asm/arch/hardware.h>
#include <asm/arch/pll.h>
#include <linux/wait.h>

#include "sound_config.h"	/*include many macro definiation */
#include "dev_table.h"		/*sound_install_audiodrv()... */

#if 1				/*CEE LDM */
#include <linux/device.h>
#include <linux/dpm.h>
#endif

#ifdef CONFIG_PM
#include <linux/pm.h>
#endif

#include <linux/soundcard.h>
#define MODULE_NAME "MX2ADS-WM8731"
#define PKMOD MODULE_NAME ": "

/*
SSI 1&2 I/O pins used:

SSI2_CLK PC27
SSI2_TXD PC26
SSI2_FS PC24
SSI1_CLK PC23
SSI1_FS PC20
SSI1_RXD PC21
*/
#define WM8731_SSI_PORT_MASK ((1<<20) | (1<<21) | (1<<23) | (1<<24) | (1<<26) | (1<<27))

#define WM8731_I2C_ADDR 0x1A

static int wm8731_mixer_dev = -1;
static int wm8731_audio_dev = -1;
static int wm8731_inp_dma_chan = -1;
static int wm8731_outp_dma_chan = -1;
static char wm8731_ssi;
static char wm8731_initstate_gpio;
static char wm8731_initstate_outp_irq;
static char wm8731_initstate_inp_irq;
static char __initstate_i2c;

static char wm8731_busy;
static int wm8731_speed = 44100;
static int wm8731_channels = 2;
static char wm8731_ag_au_path;
static char wm8731_in_vol_r = 100;
static char wm8731_in_vol_l = 100;
static char wm8731_out_vol_l = 70;
static char wm8731_out_vol_r = 70;
static u8 wm8731_mic_vol = 100;

static char wm8731_recsrc = SOUND_MASK_LINE;
static char wm8731_ready;
static char wm8731_triggered;

/*these buffers are for DMA double buffering*/
static void *wm8731_dma_outp_buffer1 = NULL;
static void *wm8731_dma_outp_buffer2 = NULL;
static char wm8731_dma_outp_buf_use;
static char wm8731_dma_outp_buf_cnt;
static int wm8731_dma_outp_bufsize;
static void *wm8731_dma_inp_buffer = NULL;
static char wm8731_dma_inp_buf_use;
static int wm8731_dma_inp_bufsize;

static char wm8731_power = 1;	/*power state == on by default */

#define MX_AUDIO_WRITE_MODE 1
#define MX_AUDIO_READ_MODE 2

static int mx_audio_local_qlen(int dev);
static int
 mx_audio_open(int dev, int mode);
static void
 mx_audio_close(int dev);
static void
 mx_audio_output_block(int dev, unsigned long buf, int count, int intrflag);
static void
 mx_audio_start_input(int dev, unsigned long buf, int count, int intrflag);
static int
 mx_audio_ioctl(int dev, unsigned int cmd, caddr_t arg);
static int
 mx_audio_prepare_for_output(int dev, int bufsize, int nbufs);
static int
 mx_audio_prepare_for_input(int dev, int bufsize, int nbufs);
static void
 mx_audio_halt_io(int dev);
static void
 mx_audio_trigger(int dev, int state);
static int
 mx_audio_set_speed(int dev, int speed);
static unsigned int
 mx_audio_set_bits(int dev, unsigned int bits);
static signed short
 mx_audio_set_channels(int dev, signed short channels);

#define MAX_VOLUME 100

static void wm8731_set_mic_vol(u8 vol);
#define WM8731_LINVOL_REG 0x0
#define WM8731_BINVOL_REG 0x1
#define WM8731_RINVOL_REG 0x2
#define WM8731_INVOL_MUTE (1<<7)
#define WM8731_INVOL_MASK 0x1F
static void wm8731_set_line_in_vol(unsigned char vol_l, unsigned char vol_r);
#define WM8731_LOUTVOL_REG 0x4
#define WM8731_BOUTVOL_REG 0x5
#define WM8731_ROUTVOL_REG 0x6
#define WM8731_OUTVOL_MIN 0x30
#define WM8731_OUTVOL_MASK 0x7F
static void wm8731_set_headphone_vol(unsigned char vol_l, unsigned char vol_r);
#define WM8731_AGAUPATH_REG 0x8
#define WM8731_MICBOOST 1
#define WM8731_MUTEMIC (1<<1)
#define WM8731_MICSEL (1<<2)
#define WM8731_BYPASS (1<<3)
#define WM8731_DACSEL (1<<4)
#define WM8731_SIDETONE (1<<5)
static void wm8731_set_ag_au_path(unsigned char path_cfg);
#define WM8731_DGAUPATH_REG 0xA
#define WM8731_ADC_HIGH_PASS_EN 0
#define WM8731_ADC_HIGH_PASS_DIS 1
#define WM8731_DEEMPH_48KHZ (3<<1)
#define WM8731_DEEMPH_44_1KHZ (2<<1)
#define WM8731_DEEMPH_32KHZ (1<<1)
#define WM8731_DEEMPH_DIS 0
#define WM8731_DAC_SOFT_MUTE_EN (1<<3)
#define WM8731_STORE_DC_OFFSET (1<<4)
static void wm8731_set_dg_au_path(unsigned char path_cfg);
#define WM8731_POWER_REG 0xC
#define WM8731_POWER_ALL_ON 0
#define WM8731_POWER_ALL_OFF 0xFF
static void wm8731_set_power(char pwr_on);
#define WM8731_IF_FORMAT_REG 0xE
#define WM8731_FORMAT_DSP 0x3
#define WM8731_FORMAT_I2S 0x2
#define WM8731_FORMAT_MSB_RIGHT_JUST 0x0
#define WM8731_FORMAT_MSB_LEFT_JUST 0x1
#define WM8731_FORMAT_MASK 0x3
#define WM8731_DATA_LEN_32BIT (0x3<<2)
#define WM8731_DATA_LEN_24BIT (0x2<<2)
#define WM8731_DATA_LEN_20BIT (0x1<<2)
#define WM8731_DATA_LEN_16BIT 0
#define WM8731_DATA_LEN_MASK (0x3<<2)
#define WM8731_R_CH_ON_DACLRC_HI (1<<4)
#define WM8731_MSB_ON_2ND_BCLK (1<<4)
#define WM8731_SWAP_CHAN (1<<5)
#define WM8731_MASTER_EN (1<<6)
#define WM8731_BITCLK_INV (1<<7)
static void wm8731_set_format(char fmt);

#define WM8731_SAMPLING_REG 0x10
#define WM8731_SAM_RATE_8K 0xB
#define WM8731_SAM_RATE_44_1K 0x8
static void wm8731_set_sampling( /*char sam_cfg, */ char sam_rate);
#define WM8731_ACTIVE_REG 0x12
#define WM8731_ACTIVE 0x1
#define WM8731_INACTIVE 0
static void wm8731_set_active(char active);
#define WM8731_RESET_REG 0x1E
static void wm8731_codec_reset(void);
static void mx_audio_reg_clear(void);
static void mx_audio_reg_init(void);
static int mx_mixer_ioctl(int dev, unsigned int cmd, caddr_t arg);
#ifdef CONFIG_PM
static int mx_audio_pm_callback(struct pm_dev *pmdev, pm_request_t rqst,
				void *data);
#endif
static void mx_audio_outp_dma_handler(dmach_t channel, void *dev, int status);
static void mx_audio_inp_dma_handler(dmach_t channel, void *dev, int status);
static int __init mx2ads_wm8731_init(void);
static void __init mx2ads_wm8731_exit(void);

#ifdef CONFIG_PM
static struct pm_dev *mx_audio_pmdev;
#endif

DECLARE_WAIT_QUEUE_HEAD(mx2snd_wait);

static inline int
mx2snd_timeout(struct dma_buffparms *dmap)
{
	return ((dmap->fragment_size * HZ) / dmap->data_rate) + HZ / 10;
}

static void
mx2snd_suspend(void)
{
	u32 flags;
	struct audio_operations *adev = audio_devs[wm8731_audio_dev];
	int timeout = 0;
	int timeout1 = 0;

	wm8731_power = 0;

	if (!wm8731_busy)
		return;

	save_flags(flags);
	cli();

	adev->go = 0;

	restore_flags(flags);

	if (adev->open_mode & OPEN_WRITE) {
		timeout = mx2snd_timeout(adev->dmap_out);
	}

	if (adev->open_mode & OPEN_READ) {
		timeout1 = mx2snd_timeout(adev->dmap_in);
	}

	if (timeout1 > timeout)
		timeout = timeout1;

	sleep_on_timeout(&mx2snd_wait, timeout);

	mx_audio_reg_clear();
}

static void
mx2snd_resume(void)
{
	u32 flags;

	wm8731_power = 1;

	if (!wm8731_busy)
		return;

	mx_audio_reg_init();

	save_flags(flags);
	cli();

	audio_devs[wm8731_audio_dev]->go = 1;

	if (audio_devs[wm8731_audio_dev]->open_mode & OPEN_WRITE) {
		DMAbuf_outputintr(wm8731_audio_dev, 1);
	}

	if (audio_devs[wm8731_audio_dev]->open_mode & OPEN_READ) {
		DMAbuf_inputintr(wm8731_audio_dev);
	}
	restore_flags(flags);
}

#if 1				/*CEE LDM */
extern void mx21_ldm_bus_register(struct device *device,
				  struct device_driver *driver);
extern void mx21_ldm_bus_unregister(struct device *device,
				    struct device_driver *driver);
static int
mx2snd_ldm_suspend(struct device *dev, u32 state, u32 level)
{
	switch (level) {
	case SUSPEND_POWER_DOWN:
		mx2snd_suspend();
		break;
	}
	return 0;
}

static int
mx2snd_ldm_resume(struct device *dev, u32 level)
{
	switch (level) {
	case RESUME_POWER_ON:
		mx2snd_resume();
		break;
	}
	return 0;
}

#ifdef CONFIG_DPM
static struct constraints mx2snd_constraints = {
	.count = 1,
	.param = {{DPM_MD_HCLK, 0, 0}},	/*to be initialized at module init time */
	.asserted = 1,
};
#endif

static struct device_driver mx2snd_driver_ldm = {
	.name = "mx2ads-wm8731",
	.suspend = mx2snd_ldm_suspend,
	.resume = mx2snd_ldm_resume,
};

static struct device mx2snd_device_ldm = {
	.name = "WM8731 Codec",
	.bus_id = "wm8731",
	.driver = &mx2snd_driver_ldm,
	.power_state = DPM_POWER_ON,
#ifdef CONFIG_DPM
	.constraints = &mx2snd_constraints,
#endif
};

#endif

static struct audio_driver mx_audio_driver = {
	.owner = THIS_MODULE,
	.open = mx_audio_open,
	.close = mx_audio_close,
	.output_block = mx_audio_output_block,
	.start_input = mx_audio_start_input,
	.ioctl = mx_audio_ioctl,
	.prepare_for_input = mx_audio_prepare_for_input,
	.prepare_for_output = mx_audio_prepare_for_output,
	.halt_io = mx_audio_halt_io,
	.trigger = mx_audio_trigger,
	.set_speed = mx_audio_set_speed,
	.set_bits = mx_audio_set_bits,
	.set_channels = mx_audio_set_channels,
	.local_qlen = mx_audio_local_qlen,
};

static struct mixer_operations mx_mixer_operations = {
	.owner = THIS_MODULE,
	.id = "DBMX2",
	.name = MODULE_NAME "MIXER",
	.ioctl = mx_mixer_ioctl
};

static unsigned short __normal_i2c_addr[] = { WM8731_I2C_ADDR, I2C_CLIENT_END};
static unsigned short __ignore_i2c_addr[] = { I2C_CLIENT_END };

static struct i2c_client_address_data __i2c_addr_data = {
	.normal_i2c = __normal_i2c_addr,
	.normal_i2c_range = __ignore_i2c_addr,
	.probe = __ignore_i2c_addr,
	.probe_range = __ignore_i2c_addr,
	.ignore = __ignore_i2c_addr,
	.ignore_range = __ignore_i2c_addr,
	.force = __ignore_i2c_addr
};

static int __i2c_probe(struct i2c_adapter *adap);
static int __i2c_detach(struct i2c_client *client);
static int __i2c_command(struct i2c_client *client, unsigned int cmd,
			   void *arg);

static struct i2c_client *__i2c_client;

static struct i2c_driver __i2c_driver = {
	.name = "WM8731 SND",
	.id = I2C_DRIVERID_EXP0,	/* Fake Id */
	.flags = I2C_DF_NOTIFY,
	.attach_adapter = __i2c_probe,
	.detach_client = __i2c_detach,
	.command = __i2c_command
};

static int
__i2c_attach(struct i2c_adapter *adap, int addr, unsigned short flags,
	       int kind)
{
	struct i2c_client *c;

	c = (struct i2c_client *) kmalloc(sizeof (*c), GFP_KERNEL);

	if (!c)
		return -ENOMEM;

	strcpy(c->name, "WM8731 SND");
	c->id = __i2c_driver.id;
	c->flags = 0;
	c->addr = addr;
	c->adapter = adap;
	c->driver = &__i2c_driver;
	c->data = NULL;

	__i2c_client = c;

	return i2c_attach_client(c);
}

static int
__i2c_probe(struct i2c_adapter *adap)
{
	return i2c_probe(adap, &__i2c_addr_data, __i2c_attach);
}

static int
__i2c_detach(struct i2c_client *client)
{
	i2c_detach_client(client);
	kfree(__i2c_client);
	return 0;
}

/* No commands defined */
static int
__i2c_command(struct i2c_client *client, unsigned int cmd, void *arg)
{
	return 0;
}

/*writes a 2-byte i2c sequence to the codec*/
static inline void
wm8731_i2c_write(char *buf)
{
	
	i2c_master_send(__i2c_client, buf, 2);
}

static void
wm8731_free_dma_buf(void **dma_buf, int bufsize)
{
	if (*dma_buf != NULL) {
		free_pages((unsigned long) *dma_buf, get_order(bufsize));
		*dma_buf = NULL;
	}
}

static int
wm8731_alloc_dma_buf(void **dma_buf, int bufsize)
{
	*dma_buf = (void *) __get_dma_pages(GFP_KERNEL, get_order(bufsize));

	if (*dma_buf == NULL) {
		return -ENOMEM;
	}
	return 0;
}

static int
mx_audio_local_qlen(int dev)
{
	return wm8731_dma_outp_buf_cnt;
}

/*start the device*/
static int
mx_audio_open(int dev, int mode)
{
	/*power state must be ON */
	if (!wm8731_power)
		return -EPERM;
	/* only one open allowed */
	if (wm8731_busy)
		return -EBUSY;

	/*read, write, or readwrite possible */
	if (mode & OPEN_WRITE) {
		wm8731_busy |= MX_AUDIO_WRITE_MODE;
	}
	if (mode & OPEN_READ) {
		wm8731_busy |= MX_AUDIO_READ_MODE;
	}
	wm8731_dma_outp_bufsize = 0;
	wm8731_dma_inp_bufsize = 0;
	mx_audio_reg_init();
	return (0);
}

/*stop the device*/
static void
mx_audio_close(int dev)
{
	mx_audio_reg_clear();
	wm8731_busy = 0;
	wm8731_free_dma_buf(&wm8731_dma_outp_buffer1, wm8731_dma_outp_bufsize);
	wm8731_free_dma_buf(&wm8731_dma_outp_buffer2, wm8731_dma_outp_bufsize);
	wm8731_free_dma_buf(&wm8731_dma_inp_buffer, wm8731_dma_inp_bufsize);
}

#define MX2_SOUNDDMA_MIN_BLOCKSIZE 2048

/*this function is a part of output dma buffer processing*/
static void
mx_audio_output_block(int dev, unsigned long buf, int count, int intrflag)
{
	void *dma_buf;
	int count1;

	if (count < MX2_SOUNDDMA_MIN_BLOCKSIZE) {
		printk(KERN_ERR PKMOD
		       "skipping too small a block requested for output (%d bytes)\n",
		       count);
		return;
	}
	if (wm8731_dma_outp_buf_use == 0) {

		/*Initiate double buffering. Divide the first block of data into 2 and put it into
		   2 buffers, and set both of them up. Both parts better be roughly equal
		   because OSS needs some time to pass between DMA (re)start and the following interrupt handler,
		   or it'll miss wake up calls from them */

		count1 = (count / 2) & ~0x3;	/*make the first half a multiple of 4, just for the beauty of it */
		memcpy(wm8731_dma_outp_buffer1, phys_to_virt(buf), count1);
		memcpy(wm8731_dma_outp_buffer2, phys_to_virt(buf + count1),
		       count - count1);

		DMAbuf_start_dma(dev, virt_to_phys(wm8731_dma_outp_buffer1),
				 count1, DMA_MODE_WRITE);
		mx2_set_dma_source(wm8731_outp_dma_chan,
				   virt_to_phys(wm8731_dma_outp_buffer2),
				   count - count1);
		mx2_conf_dma_rpt(wm8731_outp_dma_chan, DMA_RPT_EN,
				 DMA_AUTO_CLR_RPT_EN);
		wm8731_dma_outp_buf_cnt = 2;
		wm8731_dma_outp_buf_use = 2;
		return;
	} else if (wm8731_dma_outp_buf_use == 1) {
		dma_buf = wm8731_dma_outp_buffer2;
		wm8731_dma_outp_buf_use = 2;
	} else {		/* ( wm8731_dma_outp_buf_use == 2) */

		dma_buf = wm8731_dma_outp_buffer1;
		wm8731_dma_outp_buf_use = 1;
	}

	memcpy(dma_buf, phys_to_virt(buf), count);
	mx2_set_dma_source(wm8731_outp_dma_chan, virt_to_phys(dma_buf), count);
	mx2_conf_dma_rpt(wm8731_outp_dma_chan, DMA_RPT_EN, DMA_AUTO_CLR_RPT_EN);
	wm8731_dma_outp_buf_cnt++;
}

#undef DEBUG_RECORDING
//#define DEBUG_RECORDING
/*this function is a part of input dma buffer processing*/
static void
mx_audio_start_input(int dev, unsigned long buf, int count, int intrflag)
{
	int count1;

	if (count < MX2_SOUNDDMA_MIN_BLOCKSIZE) {
		printk(KERN_ERR PKMOD
		       "skipping too small a block requested for input (%d bytes)\n",
		       count);
		return;
	}

	if (wm8731_dma_inp_buf_use == 0) {

		/*Initiate double buffering. Set local buffer to be the next one */

		DMAbuf_start_dma(dev, buf, count, DMA_MODE_READ);
#ifdef DEBUG_RECORDING
		memset(wm8731_dma_inp_buffer, 0xa5, wm8731_dma_inp_bufsize);
#endif
		mx2_set_dma_destination(wm8731_inp_dma_chan,
					virt_to_phys(wm8731_dma_inp_buffer),
					wm8731_dma_inp_bufsize);
		mx2_conf_dma_rpt(wm8731_inp_dma_chan, DMA_RPT_EN,
				 DMA_AUTO_CLR_RPT_EN);
		wm8731_dma_inp_buf_use = 1;

	} else {		/*if ( wm8731_dma_inp_buf_use == 1) */

		/*Data is being transferred into the local buffer. */

		/*Stop and redirect the transfer to the OSS buffer */
		mx2_dma_disable(wm8731_inp_dma_chan);

		count1 = mx2_dma_count(wm8731_inp_dma_chan);

		/*instead of 0 it shows the maximal count
		   for the previous transfer, because repeat is enabled */
		if (count1 > MX2_SOUNDDMA_MIN_BLOCKSIZE)
			count1 = 0;

		/*restart transfer with OSS buffer */
		mx2_set_dma_destination(wm8731_inp_dma_chan, buf + count1,
					count - count1);
		mx2_dma_enable(wm8731_inp_dma_chan);

		/*copy data accumulated in local buffer into OSS buffer */
		memcpy(phys_to_virt(buf), wm8731_dma_inp_buffer, count1);

		/*set local buffer to be the next one */
		mx2_set_dma_destination(wm8731_inp_dma_chan,
					virt_to_phys(wm8731_dma_inp_buffer),
					wm8731_dma_inp_bufsize);
		mx2_conf_dma_rpt(wm8731_inp_dma_chan, DMA_RPT_EN,
				 DMA_AUTO_CLR_RPT_EN);
#ifdef DEBUG_RECORDING
		if ((((char *) wm8731_dma_inp_buffer)[count1] != 0xa5)
		    || (((char *) wm8731_dma_inp_buffer)[count1] != 0xa5))
			printk(KERN_ERR PKMOD
			       "error switching buffers. More bytes written\n");
		if (count1 > 1) {
			if ((((char *) wm8731_dma_inp_buffer)[count1 - 1] ==
			     0xa5)
			    && (((char *) wm8731_dma_inp_buffer)[count1 - 2] ==
				0xa5))
				printk(KERN_ERR PKMOD
				       "error switching buffers. Less bytes written\n");
		} else
			printk(KERN_ERR PKMOD "0 count\n");
		memset(wm8731_dma_inp_buffer, 0xa5, wm8731_dma_inp_bufsize);
#endif
	}
}

static int
mx_audio_ioctl(int dev, unsigned int cmd, caddr_t arg)
{
	int val, ret = 0;

	switch (cmd) {
	case SOUND_PCM_WRITE_RATE:
		if (get_user(val, (int *) arg))
			return -EFAULT;
		ret = mx_audio_set_speed(dev, val);
		break;
	case SOUND_PCM_READ_RATE:
		ret = wm8731_speed;
		break;
	case SOUND_PCM_WRITE_CHANNELS:
		if (get_user(val, (int *) arg))
			return -EFAULT;
		ret = mx_audio_set_channels(dev, val);
		break;
	case SOUND_PCM_READ_CHANNELS:
		ret = wm8731_channels;
		break;
	case SNDCTL_DSP_SETFMT:
		if (get_user(val, (int *) arg))
			return -EFAULT;
		ret = mx_audio_set_bits(dev, val);
		break;
	case SNDCTL_DSP_GETFMTS:
	case SOUND_PCM_READ_BITS:
		ret = AFMT_S16_LE;
		break;
	default:
		return -EINVAL;
	}
	return put_user(ret, (int *) arg);
}

/*this function is a part of output dma buffer processing*/
static int
mx_audio_prepare_for_output(int dev, int bufsize, int nbufs)
{
	audio_devs[dev]->dmap_out->flags |= DMA_NODMA;

	if (!wm8731_dma_outp_bufsize) {
		wm8731_dma_outp_buf_use = 0;
		wm8731_dma_outp_buf_cnt = 0;

		/*Allocate local dma buffers used for double buffering.
		   The double buffering is necessary to solve TX FIFO underrun problem.
		   OSS buffers are not reallocated during playback, but they may be allocated
		   after local open() is called. They are allocated by the time we get here */
		wm8731_dma_outp_bufsize = audio_devs[dev]->dmap_out->buffsize;
		if (!wm8731_alloc_dma_buf
		    (&wm8731_dma_outp_buffer1, wm8731_dma_outp_bufsize)) {
			if (!wm8731_alloc_dma_buf
			    (&wm8731_dma_outp_buffer2, wm8731_dma_outp_bufsize))
				return 0;
		}
		printk(KERN_ERR PKMOD "cannot allocate output DMA buffer\n");
		wm8731_dma_outp_bufsize = 0;

		audio_devs[wm8731_audio_dev]->enable_bits &= ~PCM_ENABLE_OUTPUT;
		return -ENOMEM;
	}
	return 0;
}

/*this function is a part of input dma buffer processing*/
static int
mx_audio_prepare_for_input(int dev, int bufsize, int nbufs)
{
	audio_devs[dev]->dmap_in->flags |= DMA_NODMA;

	if (!wm8731_dma_inp_bufsize) {
		wm8731_dma_inp_buf_use = 0;

		/*Allocate local dma buffers used for double buffering.
		   The double buffering is necessary to solve RX FIFO overrun problem.
		   OSS buffers are not reallocated during playback, but they may be allocated
		   after local open() is called. They are allocated by the time we get here */

		if (audio_devs[dev]->dmap_in->buffsize <
		    MX2_SOUNDDMA_MIN_BLOCKSIZE) {
			printk(KERN_ERR PKMOD "OSS buffer is too small\n");
			audio_devs[dev]->enable_bits &= ~PCM_ENABLE_INPUT;
			return -EFAULT;
		}

		if (wm8731_alloc_dma_buf
		    (&wm8731_dma_inp_buffer, MX2_SOUNDDMA_MIN_BLOCKSIZE)) {
			printk(KERN_ERR PKMOD
			       "cannot allocate input DMA buffer\n");
			audio_devs[dev]->enable_bits &= ~PCM_ENABLE_INPUT;
			return -ENOMEM;
		}

		wm8731_dma_inp_bufsize = MX2_SOUNDDMA_MIN_BLOCKSIZE;
	}
	return 0;
}

/*restart the device*/
static void
mx_audio_halt_io(int dev)
{
	if (audio_devs[dev]->open_mode & OPEN_WRITE)
		audio_devs[dev]->enable_bits &= ~PCM_ENABLE_OUTPUT;

	if (audio_devs[dev]->open_mode & OPEN_READ)
		audio_devs[dev]->enable_bits &= ~PCM_ENABLE_INPUT;
}

/*this function is a part of input and output dma buffer processing*/
static void
mx_audio_trigger(int dev, int state)
{
	if (wm8731_triggered)
		return;

	if (!state) {
		return;
	}

	wm8731_triggered = 1;

	switch (wm8731_speed) {
	case 44100:
		/*16-bit, 4 word/frame (left = slot 0, right = slot 2) */
		SSI_STCCR(wm8731_ssi) = 0x0000E300;
		SSI_SRCCR(wm8731_ssi) = 0x0000E300;
		if (wm8731_channels == 2) {
			/*16 bit/sample, 44.1 kHz, stereo */
			SSI_STMSK(wm8731_ssi) = ~(1 << 0 | 1 << 2);
			SSI_SRMSK(wm8731_ssi) = ~(1 << 0 | 1 << 2);
		} else {	/* (wm8731_channels == 1) */

			/*16 bit/sample, 44.1 kHz, mono */
			SSI_STMSK(wm8731_ssi) = ~(1 << 0);
			SSI_SRMSK(wm8731_ssi) = ~(1 << 0);
		}
		break;
	case 8000:
		/*16-bit, 22 word/frame (left = slot 0, right = slot 11) */
		SSI_STCCR(wm8731_ssi) = 0x0000F500;
		SSI_SRCCR(wm8731_ssi) = 0x0000F500;
		if (wm8731_channels == 2) {
			/*16 bit/sample, 8 kHz, stereo */
			SSI_STMSK(wm8731_ssi) = ~(1 << 0 | 1 << 11);
			SSI_SRMSK(wm8731_ssi) = ~(1 << 0 | 1 << 11);
		} else {	/* (wm8731_channels == 1) */

			/*16 bit/sample, 8 kHz, mono */
			SSI_STMSK(wm8731_ssi) = ~(1 << 0);
			SSI_SRMSK(wm8731_ssi) = ~(1 << 0);
		}
		break;
	}

	if (state & PCM_ENABLE_OUTPUT) {
		/* enable SSI TxFIFO 0 request DMA */
		SSI_SIER(wm8731_ssi) |= 1 << 20;
		/* Enable transmit */
		SSI_SCR(wm8731_ssi) |= 0x02;
	}

	if (state & PCM_ENABLE_INPUT) {
		/* enable SSI RxFIFO 0 request DMA */
		SSI_SIER(wm8731_ssi) |= 1 << 22;
		/* Enable receive */
		SSI_SCR(wm8731_ssi) |= 0x04;
	}
}

/* set sampling rate, 8KHz or 44.1 KHz supported*/
static int
mx_audio_set_speed(int dev, int speed)
{
	switch (speed) {
	case 8000:
		wm8731_set_sampling(WM8731_SAM_RATE_8K);
		break;
	case 44100:
		wm8731_set_sampling(WM8731_SAM_RATE_44_1K);
		break;
	case 0:
		return wm8731_speed;
	default:
		return -EINVAL;
	}
	wm8731_speed = speed;
	return wm8731_speed;
}

/* set number of bits, only 16 supported*/
static unsigned int
mx_audio_set_bits(int dev, unsigned int bits)
{
	switch (bits) {
	case 0:
	case AFMT_S16_LE:
		return AFMT_S16_LE;
	default:
		return -EINVAL;
	}
}

/* set number of channels, MONO(1) or STEREO(2) supported*/
static signed short
mx_audio_set_channels(int dev, signed short channels)
{
	switch (channels) {
	case 1:
	case 2:
		wm8731_channels = channels;
	case 0:
		return wm8731_channels;
	default:
		return -EINVAL;
	}
}

static void
wm8731_set_mic_vol(u8 vol)
{
	if (vol > 50)
		wm8731_ag_au_path |= WM8731_MICBOOST;
	else
		wm8731_ag_au_path &= ~WM8731_MICBOOST;
	if (vol == 0)
		wm8731_ag_au_path |= WM8731_MUTEMIC;
	else
		wm8731_ag_au_path &= ~WM8731_MUTEMIC;

	wm8731_set_ag_au_path(wm8731_ag_au_path);

}

/*this must remain a separate function*/
static void
wm8731_set_line_in_vol(unsigned char vol_l, unsigned char vol_r)
{
	char tmpbuf[2];

	if (vol_l == vol_r)
		tmpbuf[0] = WM8731_BINVOL_REG;	/*set both channels simultaneously */
	else
		tmpbuf[0] = WM8731_LINVOL_REG;	/*left channel register */

/* write left channel*/
	if (vol_l == 0)
		tmpbuf[1] = WM8731_INVOL_MUTE;	/*mute the channel */
	else
		tmpbuf[1] =
		    (char) (((int) vol_l * (WM8731_INVOL_MASK)) / MAX_VOLUME);
	wm8731_i2c_write(tmpbuf);

	if (vol_l != vol_r) {
/*also set right channel*/
		tmpbuf[0] = WM8731_RINVOL_REG;	/*right channel register */
		if (vol_r == 0)
			tmpbuf[1] = WM8731_INVOL_MUTE;	/*mute the channel */
		else
			tmpbuf[1] =
			    (char) (((int) vol_r * (WM8731_INVOL_MASK)) /
				    MAX_VOLUME);
		wm8731_i2c_write(tmpbuf);
	}
}

/*this must remain a separate function*/
static void
wm8731_set_headphone_vol(unsigned char vol_l, unsigned char vol_r)
{
	char tmpbuf[2];

	if (vol_l == vol_r)
		tmpbuf[0] = WM8731_BOUTVOL_REG;	/*set both channels simultaneously */
	else
		tmpbuf[0] = WM8731_LOUTVOL_REG;	/*left channel register */

/* write left channel*/
	tmpbuf[1] =
	    (char) (((int) vol_l * (WM8731_OUTVOL_MASK - WM8731_OUTVOL_MIN)) /
		    MAX_VOLUME) + WM8731_OUTVOL_MIN;
	wm8731_i2c_write(tmpbuf);

	if (vol_l != vol_r) {
/*also set right channel*/
		tmpbuf[0] = WM8731_ROUTVOL_REG;	/*right channel register */
		tmpbuf[1] =
		    (char) (((int) vol_r *
			     (WM8731_OUTVOL_MASK -
			      WM8731_OUTVOL_MIN)) / MAX_VOLUME) +
		    WM8731_OUTVOL_MIN;
		wm8731_i2c_write(tmpbuf);
	}
}

static void
wm8731_set_ag_au_path(unsigned char path_cfg)
{
	char tmpbuf[2];
	tmpbuf[0] = WM8731_AGAUPATH_REG;
	tmpbuf[1] = path_cfg;
	wm8731_i2c_write(tmpbuf);
}

static void
wm8731_set_dg_au_path(unsigned char path_cfg)
{
	char tmpbuf[2];
	tmpbuf[0] = WM8731_DGAUPATH_REG;
	tmpbuf[1] = path_cfg;
	wm8731_i2c_write(tmpbuf);
}

static void
wm8731_set_power(char pwr_on)
{
	char tmpbuf[2];
	tmpbuf[0] = WM8731_POWER_REG;
	tmpbuf[1] = pwr_on;
	wm8731_i2c_write(tmpbuf);
}

static void
wm8731_set_format(char fmt)
{
	char tmpbuf[2];
	tmpbuf[0] = WM8731_IF_FORMAT_REG;
	tmpbuf[1] = fmt;
	wm8731_i2c_write(tmpbuf);
}

static void
wm8731_set_sampling( /*char sam_cfg, */ char sam_rate)
{
	char tmpbuf[2];
	tmpbuf[0] = WM8731_SAMPLING_REG;
	tmpbuf[1] =		/*(sam_cfg & ~(0xf << 2)) | */
	    ((sam_rate << 2) & (0xf << 2));
	wm8731_i2c_write(tmpbuf);
}

static void
wm8731_set_active(char active)
{
	char tmpbuf[2];
	tmpbuf[0] = WM8731_ACTIVE_REG;
	tmpbuf[1] = active & WM8731_ACTIVE;
	wm8731_i2c_write(tmpbuf);
}

static void
wm8731_codec_reset(void)
{
	char tmpbuf[2];
	tmpbuf[0] = WM8731_RESET_REG;
	tmpbuf[1] = 0;
	wm8731_i2c_write(tmpbuf);
}

static void
mx_audio_reg_clear(void)
{
	wm8731_dma_outp_buf_use = 0;
	wm8731_dma_inp_buf_use = 0;
	wm8731_dma_outp_buf_cnt = 0;
	wm8731_ready = 0;
	wm8731_set_active(WM8731_INACTIVE);
	wm8731_set_dg_au_path(WM8731_DAC_SOFT_MUTE_EN);
	wm8731_set_ag_au_path(WM8731_MUTEMIC);
	wm8731_set_line_in_vol(0, 0);
	wm8731_set_power(WM8731_POWER_ALL_OFF);

	SSI_SCR(wm8731_ssi) = 0;	/* disable SSI. Status bits are at Power-On-Reset state */
	SSI_SIER(wm8731_ssi) = 0;

	/* disable Tx and Rx FIFO 0 */
	SSI_STCR(wm8731_ssi) = 0;
	SSI_SRCR(wm8731_ssi) = 0;

	if (wm8731_ssi == 1) {
		mx_module_clk_close(IPG_MODULE_SSI1_BAUD);
		mx_module_clk_close(IPG_MODULE_SSI1);
	} else {
		mx_module_clk_close(IPG_MODULE_SSI2_BAUD);
		mx_module_clk_close(IPG_MODULE_SSI2);
	}
}

static void
mx_audio_reg_init(void)
{
	wm8731_dma_outp_buf_use = 0;
	wm8731_dma_inp_buf_use = 0;
	wm8731_dma_outp_buf_cnt = 0;

/*configure AUDMUX:
 Codec - SSI Master, in async mode. Uses 1 SSI host and 2 pin groups.
 CPU uses the SSI host in slave mode: all control signals are inputs
*/
	if (wm8731_ssi == 1) {
		/* enable SSI1 IPG clocks */
		mx_module_clk_open(IPG_MODULE_SSI1_BAUD);
		mx_module_clk_open(IPG_MODULE_SSI1);
	} else {		/*(wm8731_ssi==2) */
		/* enable SSI1 IPG clocks */
		mx_module_clk_open(IPG_MODULE_SSI2_BAUD);
		mx_module_clk_open(IPG_MODULE_SSI2);
	}

	/*Configure Host SSI1 */
	AUDMUX_HPCR(wm8731_ssi) = (1 << 31) |	/* TFSDIR */
	    (1 << 30) |		/* TCLKDIR */
	    (4 << 26) |		/* TFCSEL       select TX frame syn. from port5 */
	    (1 << 25) |		/* RSFDIR */
	    (1 << 24) |		/* RCLKDIR */
	    (3 << 20) |		/* RFCSEL       select RX frame syn. from port 4 !!!! diff in codec standalone!!! */
	    (3 << 13) |		/* RXDSEL       select RXD from port 4 */
	    (0 << 12) |		/* SYN */
	    (0 << 10) |		/* TXRXEN */
	    (0 << 8) |		/* INMEN */
	    (0 << 0);		/* INMASK */
	/* Configure Audmux Port 4 - SSI1 Pinout (Receive) */
	AUDMUX_PPCR(1) = (0 << 31) |	/* TFSDIR */
	    (0 << 30) |		/* TCLKDIR */
	    (0 << 26) |		/* TFCSEL */
	    (0 << 25) |		/* RSFDIR */
	    (0 << 24) |		/* RCLKDIR */
	    (0 << 20) |		/* RFCSEL */
	    (0 << 13) |		/* RXDSEL */
	    (1 << 12) |		/* SYN */
	    (0 << 10);		/* TXRXEN */

	/* Configure Audmux Port 5 - SSI2 Pinout (Transmit) */
	AUDMUX_PPCR(2) = (0 << 31) |	/* TFSDIR */
	    (0 << 30) |		/* TCLKDIR */
	    (0 << 26) |		/* TFCSEL */
	    (0 << 25) |		/* RSFDIR */
	    (0 << 24) |		/* RCLKDIR */
	    (0 << 20) |		/* RFCSEL */
	    ((wm8731_ssi - 1) << 13) |	/* RXDSEL */
	    (1 << 12) |		/* SYN */
	    (0 << 10);		/* TXRXEN */

	/* reset SSI */
	SSI_SCR(wm8731_ssi) = 0;	/* disable SSI. Status bits are at Power-On-Reset state */
	SSI_SOR(wm8731_ssi) = (7 << 3) | 1;	/*clear receiver, transmitter, reset state machine, frame sync */
	SSI_SOR(wm8731_ssi) = 0;

	SSI_SCR(wm8731_ssi) = (0 << 9) |	/*CLK_IST=0: Clock idle state is 0 */
	    (0 << 8) |		/*TCH_EN=0: Two channel mode disabled */
	    (0 << 7) |		/*SYS_CLK_EN=0: SYS_CLK not output on SRCK port */
	    (0 << 5) |		/*I2S_MODE=0:0: I2S_MODE not selected */
	    (0 << 4) |		/*SYN=0: Asynchronous mode selected */
	    (1 << 3) |		/*NET=1: Network mode selected */
	    (0 << 2) |		/*RE=0: Receiver not enabled (yet) */
	    (0 << 1) |		/*TE=0: Transmitter not enabled (yet) */
	    (1 << 0);		/*SSIEN=1: SSI is enabled */

	SSI_STCR(wm8731_ssi) = (0 << 10) |	/*TCK_SEL=0: internal bit clock source - don't care, external used */
	    (1 << 9) |		/*TXBIT0=1: Shifting with respect to bit 0 */
	    (0 << 8) |		/*TFEN1=0: Transmit FIFO1 disabled. Can we use it somehow in a sequence with TX FIFO 0? */
	    (1 << 7) |		/*TFEN0=1: Transmit FIFO0 enabled */
	    (0 << 6) |		/*TFDIR=0: Transmit Frame Sync is external */
	    (0 << 5) |		/*TXDIR=0: Transmit Clock is external */
	    (0 << 4) |		/*TSHFD=0: Data transmitted MSB first */
	    (1 << 3) |		/*TSCKP=1: Transmitted Data valid on falling edge if bit clock */
	    (0 << 2) |		/*TFSI=0: Transmit Frame Sync active high */
	    (0 << 1) |		/*TFSL=0: Transmit Frame Sync time is in words */
	    (0 << 0);		/*TESL=0: Transmit Frame Sync starts simultaneously with the first data bit */

	SSI_SRCR(wm8731_ssi) = (0 << 10) |	/*RCK_SEL=0: internal bit clock source - don't care, external used */
	    (1 << 9) |		/*RXBIT0=1: Shifting with respect to bit 0 */
	    (0 << 8) |		/*RFEN1=0: Receive FIFO1 disabled. Can we use it somehow in a sequence with RX FIFO 0? */
	    (1 << 7) |		/*RFEN0=1: Receive FIFO0 enabled */
	    (0 << 6) |		/*RFDIR=0: Receive Frame Sync is external */
	    (0 << 5) |		/*RXDIR=0: Receive Clock is external */
	    (0 << 4) |		/*RSHFD=0: Data received MSB first */
	    (1 << 3) |		/*RSCKP=1: Received Data valid on rising edge if bit clock */
	    (0 << 2) |		/*RFSI=0: Receive Frame Sync active high */
	    (0 << 1) |		/*RFSL=0: Receive Frame Sync is in words */
	    (0 << 0);		/*RESL=0: Receive Frame Sync starts simultaneously with the first data bit */

	SSI_SFCSR(wm8731_ssi) = 0x220022;	/*Rx FIFO Full water mark [7:4] set to 2, Tx FIFO Empty water mark [3:0] set to 2;  */

	/* set up CODEC */
	wm8731_codec_reset();

	wm8731_set_power(WM8731_POWER_ALL_ON);

	wm8731_set_format(WM8731_FORMAT_MSB_LEFT_JUST | WM8731_DATA_LEN_16BIT |
			  WM8731_MASTER_EN);

	wm8731_ag_au_path = 0;

	if (wm8731_busy & MX_AUDIO_READ_MODE) {
		/*select microphone input else line input */
		if (wm8731_recsrc == SOUND_MASK_MIC) {
			wm8731_ag_au_path |= WM8731_MICSEL | WM8731_SIDETONE;
		} else
			wm8731_ag_au_path |= WM8731_BYPASS;
	}

	if (wm8731_busy & MX_AUDIO_WRITE_MODE) {
		wm8731_ag_au_path |= WM8731_DACSEL;
	}

	wm8731_set_dg_au_path(0);

	mx_audio_set_speed(0, wm8731_speed);
	wm8731_set_headphone_vol(wm8731_out_vol_l, wm8731_out_vol_r);
	wm8731_set_line_in_vol(wm8731_in_vol_l, wm8731_in_vol_r);
	wm8731_set_mic_vol(wm8731_mic_vol);

	wm8731_set_active(WM8731_ACTIVE);

	wm8731_triggered = 0;
	wm8731_ready = 1;
}

static int
mx_mixer_ioctl(int dev, unsigned int cmd, caddr_t arg)
{
	int ret = 0;
	int usrVol;
	/* Only accepts mixer (type 'M') ioctls */
	if (_IOC_TYPE(cmd) != 'M') {
		return -EINVAL;
	}

	switch (cmd) {
	case SOUND_MIXER_READ_DEVMASK:
		/* Mask available channels */
		ret = SOUND_MASK_VOLUME | SOUND_MASK_LINE | SOUND_MASK_MIC;
		break;
	case SOUND_MIXER_READ_RECMASK:
		/* Mask available recording channels */
		ret = SOUND_MASK_LINE | SOUND_MASK_MIC;
		break;
	case SOUND_MIXER_READ_STEREODEVS:
		/* Mask stereo capable channels */
		ret = SOUND_MASK_VOLUME | SOUND_MASK_LINE;
		break;
	case SOUND_MIXER_READ_CAPS:
		/* Only one recording source at a time */
		ret = SOUND_CAP_EXCL_INPUT;
		break;
	case SOUND_MIXER_WRITE_VOLUME:
		/* Set and return new volume */
		if (get_user(usrVol, (int *) arg)) {
			return -EFAULT;
		}
		wm8731_out_vol_l = usrVol & 0xff;
		wm8731_out_vol_r = (usrVol >> 8) & 0xff;
		if (wm8731_out_vol_l > MAX_VOLUME)
			wm8731_out_vol_l = MAX_VOLUME;
		if (wm8731_out_vol_r > MAX_VOLUME)
			wm8731_out_vol_r = MAX_VOLUME;
		if (wm8731_ready)
			wm8731_set_headphone_vol(wm8731_out_vol_l,
						 wm8731_out_vol_r);
	case SOUND_MIXER_READ_VOLUME:
		/* Return volume */
		ret = wm8731_out_vol_l | (wm8731_out_vol_r << 8);
		break;
	case SOUND_MIXER_WRITE_LINE:
		/* Set and return new volume */
		if (get_user(usrVol, (int *) arg)) {
			return -EFAULT;
		}
		wm8731_in_vol_l = usrVol & 0xff;
		wm8731_in_vol_r = (usrVol >> 8) & 0xff;
		if (wm8731_in_vol_l > MAX_VOLUME)
			wm8731_in_vol_l = MAX_VOLUME;
		if (wm8731_in_vol_r > MAX_VOLUME)
			wm8731_in_vol_r = MAX_VOLUME;
		if (wm8731_ready)
			wm8731_set_line_in_vol(wm8731_in_vol_l,
					       wm8731_in_vol_r);
	case SOUND_MIXER_READ_LINE:
		/* Return input volume */
		ret = wm8731_in_vol_l | (wm8731_in_vol_r << 8);
		break;
	case SOUND_MIXER_WRITE_MIC:
		{
			/* Set and return new volume */
			if (get_user(usrVol, (int *) arg))
				return -EFAULT;

			u8 left, right, tmp;
			left = usrVol & 0x00ff;
			right = (usrVol >> 8) & 0x00ff;

			if (left > MAX_VOLUME)
				left = 100;
			if (right > MAX_VOLUME)
				right = 100;

			if (wm8731_mic_vol != right)
				tmp = right;
			else
				tmp = left;
			/* valid settings are: 0(mic mute), 50(no mic boost), 100(mic boost) */
			if (tmp < wm8731_mic_vol) {
				if (tmp < 50)
					wm8731_mic_vol = 0;
				else
					wm8731_mic_vol = 50;
			} else if (tmp > wm8731_mic_vol) {
				if (tmp > 50)
					wm8731_mic_vol = 100;
				else
					wm8731_mic_vol = 50;
			}

			if (wm8731_ready)
				wm8731_set_mic_vol(wm8731_mic_vol);
		}
	case SOUND_MIXER_READ_MIC:
		/* Return input volume */
		ret = wm8731_mic_vol + ((wm8731_mic_vol << 8) & 0xFF00);
		break;
	case SOUND_MIXER_WRITE_RECSRC:
		if (get_user(ret, (int *) arg)) {
			return -EFAULT;
		}
		/*recording source will change on the next audio open */
		if (ret & SOUND_MASK_LINE) {
			/* use LINE in */
			wm8731_recsrc = SOUND_MASK_LINE;
		} else {
			/* use MIC */
			wm8731_recsrc = SOUND_MASK_MIC;
		}

	case SOUND_MIXER_READ_RECSRC:
		ret = wm8731_recsrc;
		break;

	default:
		return -EINVAL;
	}

	return put_user(ret, (int *) arg);
}

#ifdef CONFIG_PM
static int
mx_audio_pm_callback(struct pm_dev *pmdev, pm_request_t rqst, void *data)
{
	switch (rqst) {
	case PM_SUSPEND:
		mx2snd_suspend();
		break;
	case PM_RESUME:
		mx2snd_resume();
		break;
	}
	return 0;
}
#endif

/* output dma handler*/
static void
mx_audio_outp_dma_handler(dmach_t channel, void *dev, int status)
{
	if (status & DMA_DONE) {
		wm8731_dma_outp_buf_cnt--;
		if (SSI_SISR(wm8731_ssi) & (1 << 8)) {
			printk(KERN_ERR PKMOD "TX FIFO underrun\n");
			wm8731_dma_outp_buf_use = 0;
			wm8731_dma_outp_buf_cnt = 0;
		}
		DMAbuf_outputintr(wm8731_audio_dev, 1);
	} else {
		if (status & DMA_BURST_TIMEOUT)
			printk(KERN_ERR PKMOD "%s: DMA_BURST_TIMEOUT\n",
			       __FUNCTION__);
		if (status & DMA_TRANSFER_ERROR)
			printk(KERN_ERR PKMOD "%s: DMA_TRANSFER_ERROR\n",
			       __FUNCTION__);
		if (status & DMA_BUFFER_OVERFLOW)
			printk(KERN_ERR PKMOD "%s: DMA_BUFFER_OVERFLOW\n",
			       __FUNCTION__);
		if (status & DMA_REQUEST_TIMEOUT)
			printk(KERN_ERR PKMOD "%s: DMA_REQUEST_TIMEOUT\n",
			       __FUNCTION__);
	}
}

/*input dma handler*/
static void
mx_audio_inp_dma_handler(dmach_t channel, void *dev, int status)
{
	if (status & DMA_DONE) {
		if (SSI_SISR(wm8731_ssi) & (1 << 10)) {
			printk(KERN_ERR PKMOD "RX FIFO overrrun\n");
			wm8731_dma_inp_buf_use = 0;
		}
		DMAbuf_inputintr(wm8731_audio_dev);
	} else {
		if (status & DMA_BURST_TIMEOUT)
			printk(KERN_ERR PKMOD "%s: DMA_BURST_TIMEOUT\n",
			       __FUNCTION__);
		if (status & DMA_TRANSFER_ERROR)
			printk(KERN_ERR PKMOD "%s: DMA_TRANSFER_ERROR\n",
			       __FUNCTION__);
		if (status & DMA_BUFFER_OVERFLOW)
			printk(KERN_ERR PKMOD "%s: DMA_BUFFER_OVERFLOW\n",
			       __FUNCTION__);
		if (status & DMA_REQUEST_TIMEOUT)
			printk(KERN_ERR PKMOD "%s: DMA_REQUEST_TIMEOUT\n",
			       __FUNCTION__);
	}
}

/*choose SSI search order*/
#define FIRST_SSI 1
#define SECOND_SSI 2
#define MX2ADS_WM8731_MIN_HCLK 24576

/* module init*/
static int __init
mx2ads_wm8731_init(void)
{
	int tmp;

	/*printk(KERN_INFO PKMOD"ver. 1.1 built on %s %s\n", __TIME__, __DATE__); */

#if 1 /*CEE LDM*/
	if (MX2ADS_WM8731_MIN_HCLK > mx_module_get_clk(HCLK) / 1000) {
		printk(KERN_ERR PKMOD "cannot initialize - HCLK too slow\n");
		return -EPERM;
	}
#endif

	/* request SSI register region */
	if (!
	    (request_region
	     (SSI_BASE(FIRST_SSI), SSI_IO_SIZE, "mx2ads-wm8731"))) {
		if (!
		    (request_region
		     (SSI_BASE(SECOND_SSI), SSI_IO_SIZE, "mx2ads-wm8731"))) {
			printk(KERN_ERR PKMOD
			       "all SSI devices are already in use\n");
			mx2ads_wm8731_exit();
			return -1;
		}
		wm8731_ssi = SECOND_SSI;
	} else
		wm8731_ssi = FIRST_SSI;

	tmp = i2c_add_driver(&__i2c_driver);
	if (tmp < 0) {
		printk(KERN_ERR PKMOD "cannot initialize I2C\n");
		mx2ads_wm8731_exit();
		return tmp;
	}
	__initstate_i2c = 1;

	if (!__i2c_client) {
		printk(KERN_ERR PKMOD "wrong I2C address or device not present\n");
		mx2ads_wm8731_exit();
		return -ENODEV;
	}


	tmp = mx2_register_gpios(PORT_C, WM8731_SSI_PORT_MASK, PRIMARY);
	if (tmp < 0) {
		printk(KERN_ERR PKMOD "PORT_C mask 0x%x is already in use\n",
		       WM8731_SSI_PORT_MASK);
		mx2ads_wm8731_exit();
		return tmp;
	}
	wm8731_initstate_gpio = 1;

	/*we must allocate DMA here, not in open(),
	   because it is remembered by upper-level audio at the point of registering */

	/*configure output DMA support */
	for (wm8731_outp_dma_chan = 0; wm8731_outp_dma_chan < MAX_DMA_CHANNELS;
	     wm8731_outp_dma_chan++) {
		if (!sound_alloc_dma
		    (wm8731_outp_dma_chan, MODULE_NAME " OUTPUT"))
			break;
	}
	if (wm8731_outp_dma_chan == MAX_DMA_CHANNELS) {
		wm8731_outp_dma_chan = -1;
		printk(KERN_ERR PKMOD "can't get a DMA channel for output\n");
		mx2ads_wm8731_exit();
		return -1;
	}

	if ((tmp =
	     mx2_request_dma_irq(wm8731_outp_dma_chan,
				 mx_audio_outp_dma_handler, MODULE_NAME)) < 0) {
		printk(KERN_ERR PKMOD
		       "cannot request IRQ for output DMA channel %d\n",
		       wm8731_outp_dma_chan);
		mx2ads_wm8731_exit();
		return tmp;
	}
	wm8731_initstate_outp_irq = 1;

	mx2_conf_dma_source(wm8731_outp_dma_chan, DMA_TYPE_LINEAR,
			    DMA_MEM_SIZE_32, 0);
	mx2_conf_dma_destination(wm8731_outp_dma_chan, DMA_TYPE_FIFO, DMA_MEM_SIZE_16, _SSI_STX0(wm8731_ssi));	/* SSI Tx data register 0 */
	mx2_conf_dma_memdir(wm8731_outp_dma_chan, DMA_MEMDIR_INCR);
	mx2_conf_dma_request(wm8731_outp_dma_chan, DMA_REQUEST_EN,
			     ((wm8731_ssi ==
			       1) ? DMA_REQ_SSI1_TX0 : DMA_REQ_SSI2_TX0),
			     DMA_REQ_TIMEOUT_DIS, 0, 0, 0);
	mx2_conf_dma_burst(wm8731_outp_dma_chan, 4, 0);	/* burst length - 4 */

	/*configure input DMA support */
	for (wm8731_inp_dma_chan = 0; wm8731_inp_dma_chan < MAX_DMA_CHANNELS;
	     wm8731_inp_dma_chan++) {
		if (!sound_alloc_dma(wm8731_inp_dma_chan, MODULE_NAME " INPUT"))
			break;
	}
	if (wm8731_inp_dma_chan == MAX_DMA_CHANNELS) {
		wm8731_inp_dma_chan = -1;
		printk(KERN_ERR PKMOD "can't get a DMA channel for input\n");
		mx2ads_wm8731_exit();
		return -1;
	}

	if ((tmp =
	     mx2_request_dma_irq(wm8731_inp_dma_chan, mx_audio_inp_dma_handler,
				 MODULE_NAME)) < 0) {
		printk(KERN_ERR PKMOD
		       "cannot request IRQ for input DMA channel %d\n",
		       wm8731_inp_dma_chan);
		mx2ads_wm8731_exit();
		return tmp;
	}
	wm8731_initstate_inp_irq = 1;

	mx2_conf_dma_source(wm8731_inp_dma_chan, DMA_TYPE_FIFO, DMA_MEM_SIZE_16, _SSI_SRX0(wm8731_ssi));	/* SSI Rx data register 0 */
	mx2_conf_dma_destination(wm8731_inp_dma_chan, DMA_TYPE_LINEAR,
				 DMA_MEM_SIZE_32, 0);
	mx2_conf_dma_memdir(wm8731_inp_dma_chan, DMA_MEMDIR_INCR);
	mx2_conf_dma_request(wm8731_inp_dma_chan, DMA_REQUEST_EN,
			     ((wm8731_ssi ==
			       1) ? DMA_REQ_SSI1_RX0 : DMA_REQ_SSI2_RX0),
			     DMA_REQ_TIMEOUT_DIS, 0, 0, 0);
	mx2_conf_dma_burst(wm8731_inp_dma_chan, 4, 0);	/* burst length - 4 */

/*register audio and mixer devices*/
	if ((tmp = sound_install_audiodrv(AUDIO_DRIVER_VERSION,
					  MODULE_NAME " AUDIO",
					  &mx_audio_driver,
					  sizeof (struct audio_driver),
					  DMA_DUPLEX,
					  AFMT_S16_LE,
					  NULL,
					  wm8731_outp_dma_chan,
					  wm8731_inp_dma_chan)) < 0) {
		printk(KERN_ERR PKMOD "failed to register audio device\n");
		mx2ads_wm8731_exit();
		return tmp;
	}
	wm8731_audio_dev = tmp;

	if ((tmp = sound_install_mixer(MIXER_DRIVER_VERSION,
				       mx_mixer_operations.name,
				       &mx_mixer_operations,
				       sizeof (struct mixer_operations),
				       NULL)) < 0) {
		printk(KERN_ERR PKMOD "failed to register mixer device\n");
		mx2ads_wm8731_exit();
		return tmp;
	}
	wm8731_mixer_dev = tmp;
	mx_audio_reg_clear();
#if 1				/*CEE LDM */
#ifdef CONFIG_DPM
	mx2snd_constraints.param[0].min = MX2ADS_WM8731_MIN_HCLK;	/*in KHz */
	mx2snd_constraints.param[0].max = mx_module_get_clk(MPLL) / 1000;	/* unlimited */
#endif
	mx21_ldm_bus_register(&mx2snd_device_ldm, &mx2snd_driver_ldm);
#endif
#ifdef CONFIG_PM
	mx_audio_pmdev =
	    pm_register(PM_UNKNOWN_DEV, PM_SYS_UNKNOWN, mx_audio_pm_callback);
	if (!mx_audio_pmdev)
		printk(KERN_ERR PKMOD
		       "failed to initialize power management\n");
#endif
	return 0;
}

/* module exit*/
static void __init
mx2ads_wm8731_exit(void)
{
#ifdef CONFIG_PM
	if (mx_audio_pmdev)
		pm_unregister(mx_audio_pmdev);
#endif
	if (wm8731_mixer_dev >= 0) {
#if 1				/*CEE LDM */
		mx21_ldm_bus_unregister(&mx2snd_device_ldm, &mx2snd_driver_ldm);
#endif
		sound_unload_mixerdev(wm8731_mixer_dev);
	}
	if (wm8731_audio_dev >= 0) {
		sound_unload_audiodev(wm8731_audio_dev);
	}
	if (wm8731_initstate_inp_irq) {
		mx2_free_dma_irq(wm8731_inp_dma_chan, MODULE_NAME);
	}
	if (wm8731_inp_dma_chan >= 0) {
		sound_free_dma(wm8731_inp_dma_chan);
	}
	if (wm8731_initstate_outp_irq) {
		mx2_free_dma_irq(wm8731_outp_dma_chan, MODULE_NAME);
	}
	if (wm8731_outp_dma_chan >= 0) {
		sound_free_dma(wm8731_outp_dma_chan);
	}
	if (wm8731_initstate_gpio) {
		mx2_unregister_gpios(PORT_C, WM8731_SSI_PORT_MASK);
	}
	if (__initstate_i2c) {
		i2c_del_driver(&__i2c_driver);
	}
	if (wm8731_ssi) {
		release_region(SSI_BASE(wm8731_ssi), SSI_IO_SIZE);
	}
}

module_init(mx2ads_wm8731_init);
module_exit(mx2ads_wm8731_exit);

MODULE_AUTHOR("MontaVista Software Inc");
MODULE_DESCRIPTION("WM8731 AUDIO DRIVER FOR MX2ADS");
MODULE_LICENSE("GPL");

--=-1sFTG62O9+8wkosJnLbV
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-1sFTG62O9+8wkosJnLbV--
