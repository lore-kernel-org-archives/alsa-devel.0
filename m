From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: problems on AT91 with SSC not generating frame sync on
	RF0 pin
Date: Fri, 10 Jul 2009 13:44:07 +0200
Message-ID: <4A572987.3090402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from netfinity.tbmn.org (mail.tbmn.org [88.117.197.126])
	by alsa0.perex.cz (Postfix) with ESMTP id 14C901037FE
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jul 2009 13:44:35 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by netfinity.tbmn.org (Postfix) with ESMTP id 3671C4BE05
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jul 2009 13:32:23 +0200 (CEST)
Received: from netfinity.tbmn.org ([127.0.0.1])
	by localhost (netfinity.tbmn.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fP1y2Q8NTMGO for <alsa-devel@alsa-project.org>;
	Fri, 10 Jul 2009 13:32:22 +0200 (CEST)
Received: from [192.168.1.5] (chello080108001212.35.11.tuwien.teleweb.at
	[80.108.1.212])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mne@tbmn.org)
	by netfinity.tbmn.org (Postfix) with ESMTPSA id 1492E4BDFA
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jul 2009 13:32:18 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

Hi,

I wrote an ALSA machine driver for the WM8731 codec on the AT91SAM9260 platform (for code see end of mail).
I'm using the latest ALSA sound-2.6 tree from git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

The audio codec is configured as I2S slave, so that the SSC is responsible to create the BCLK and LRC frame sync signals.
my problem is that while playing audio works (and a LRC signal is created on the TF0 pin), recording does not work since there is no LRC signal on the RF0 pin.

The connection between SSC and wm8731 is the following:


codec                         SSC
	<-- BCLK/TK0    --
	<-- ADCLRC/RF0  --
	<-- DACLRC/TF0  --
	<-- DACDAT/TD0  --
	 -- ADCDAT/RD0  -->


In my board file I'm initializing the SSC with the following function call:
------------------------------------------------------------------------
static void __init ek_board_init(void)
{
....
at91_add_device_ssc(AT91SAM9260_ID_SSC, ATMEL_SSC_TK | ATMEL_SSC_RF | ATMEL_SSC_TF | ATMEL_SSC_TD | ATMEL_SSC_RD);
....
}
------------------------------------------------------------------------

In arch/arm/mach-at91/at91sam9260_devices.c this leads to the following calls:

------------------------------------------------------------------------
static inline void configure_ssc_pins(unsigned pins)
{
if (pins & ATMEL_SSC_TF)
at91_set_A_periph(AT91_PIN_PB17, 1);
if (pins & ATMEL_SSC_TK)
at91_set_A_periph(AT91_PIN_PB16, 1);
if (pins & ATMEL_SSC_TD)
at91_set_A_periph(AT91_PIN_PB18, 1);
if (pins & ATMEL_SSC_RD)
at91_set_A_periph(AT91_PIN_PB19, 1);
if (pins & ATMEL_SSC_RK)
at91_set_A_periph(AT91_PIN_PB20, 1);
if (pins & ATMEL_SSC_RF)
at91_set_A_periph(AT91_PIN_PB21, 1);
}
------------------------------------------------------------------------


Then in the machine driver I'm initializing both codec and cpu DAI with SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS.
For this reason the SSC is I2S master and has to generate the clock and frame sync signals.

By looking at atmel_ssc_dai.c (and putting some printk() debug code there) I verified that the SSC registers
are correctly set up so that the RF0 pin is configured as output.

As mentioned playing audio works just fine.
Thus by attaching a scope to the TF0 pin (which carries the transmitter frame sync signal) I can see that the signal is
alright.

However, if I record something with arecord, the SSC receiver is enabled, but no frame sync pulses can be seen on the RF0
pin.
Therefore also audio recording does not work since there is no data being transfered from the codec to the SSC.

The kernel output (with some debug code added) looks good:
------------------------------------------------------------------------
Jul  9 22:30:52 devboard kernel: atmel_ssc_startup: SSC_SR=0x12
Jul  9 22:30:52 devboard kernel: sam9l9260_startup()
Jul  9 22:30:52 devboard kernel: asoc: WM8731 <-> atmel-ssc0 info:
Jul  9 22:30:52 devboard kernel: asoc: rate mask 0x6fe
Jul  9 22:30:52 devboard kernel: asoc: min ch 1 max ch 2
Jul  9 22:30:52 devboard kernel: asoc: min rate 8000 max rate 96000
Jul  9 22:30:52 devboard kernel: sam9l9260_hw_params()
Jul  9 22:30:52 devboard kernel: sam9l9260_hw_params: sample rate is 44100 Hz
Jul  9 22:30:52 devboard kernel: sam9l9260_hw_params: substream->stream is SNDRV_PCM_STREAM_CAPTURE
Jul  9 22:30:52 devboard kernel: sam9l9260_hw_params: snd_soc_dai_set_clkdiv() --> I'm receiver !
Jul  9 22:30:52 devboard kernel: atmel_ssc_hw_params: setting up for SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS
Jul  9 22:30:52 devboard kernel: atmel_ssc_hw_params: RCMR=21010420 RFMR=001f018f TCMR=00010404 TFMR=001f018f
Jul  9 22:30:52 devboard kernel: atmel_ssc_dai: Starting clock
Jul  9 22:30:52 devboard kernel: atmel_ssc_dai,hw_params: SSC initialized
Jul  9 22:30:52 devboard kernel: atmel-pcm: hw_params: DMA for SSC0 PCM in initialized (dma_bytes=32768, period_size=8192)
Jul  9 22:30:52 devboard kernel: receive enabled SSC_SR=0x0002040c
Jul  9 22:30:53 devboard kernel: atmel-pcm:buffer_size = 8192,dma_area = ffc1b000, dma_bytes = 32768
Jul  9 22:30:53 devboard kernel: atmel-pcm: trigger: period_ptr=23a9a000, xpr=598310912, xcr=4096, xnpr=598319104, xncr=4096

Jul  9 22:30:53 devboard kernel: sr=133164 imr=0
atmel-pcm:buffer_size = 8192,dma_area = ffc1b000, dma_bytes = 32768
atmel_ssc_shutdown: receive disabled SSC_SR=0x0002083c
atmel_ssc_dau: Stopping clock
Jul  9 22:36:04 devboard kernel: atmel-pcm:buffer_size = 8192,dma_area = ffc1b000, dma_bytes = 32768
Jul  9 22:36:04 devboard kernel: atmel_ssc_shutdown: receive disabled SSC_SR=0x0002083c
Jul  9 22:36:04 devboard kernel: atmel_ssc_dau: Stopping clock
Jul  9 22:36:04 devboard kernel: sam9l9260_shutdown()
Unregistered DAI 'WM8731'
Unregistered codec 'WM8731'
Unregistered DAI 'atmel-ssc0'
Unregistered platform 'atmel-audio'
Jul  9 22:36:18 devboard kernel: Unregistered DAI 'WM8731'
Jul  9 22:36:18 devboard kernel: Unregistered codec 'WM8731'
Jul  9 22:36:18 devboard kernel: Unregistered DAI 'atmel-ssc0'
Jul  9 22:36:18 devboard kernel: Unregistered platform 'atmel-audio'
------------------------------------------------------------------------

As you can see above, the receiver is enabled (SNDRV_PCM_STREAM_CAPTURE), the clock is set for the receiver and
the SSC starts to generate the BCLK (which can be measured with tthe scope).
Also the SSC registers should be configured correctly (thus the RF0 pin should be output for frame sync), but it still does not work.


I also checked for hardware problems by completely disconnecting the SSC from the codec and directly attaching the lines to a scope.
The result it the same: While playing sound produces the correct signals, recording does not do so since there is no frame sync on the RF0 pin.

I also checked for bad solder junctions and I did do the measurements directly on the tiny AT91SAM9260 controller pins as well (with the same result).
And of course I also looked at the schematic and verified that the pins are not connected to anything else.
Also, the pins are not anywhere else in my kernel sources as for the SSC (I verified this by looking at the code and searching for the relevant pin names).
I read the relevant sections in the at91sam9260 and wm8731 datasheets very carefully and also verified that the setup is according to specification as well.

I'm pretty sure that it is a software problem somewhere, but after so much time trying to fix the problem I no longer have any ideas what could be wrong.
For my understanding the pins need to be multiplexed for use with the SSC.
I verified this and the pins are indeed multiplexed with calls to at91_set_A_periph() on the according pins (see code snippet above).
Once this has been done the pins should be ready for use with the SSC.
Thus once the SSC registers are configured (which they verifiably are in atmel_ssc_dai.c) the pins should behave according to the SSC register configuration.
And since the SSC registers are configured in a way that the RF0 pin is an ouput with with the LR frame sync signal for the receive on it,
it should also work (which it doesn't).


If you have any ideas why it is not working I would be very grateful.


sincerely,
Stefan





machine driver code:
------------------------------------------------------------------------
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/kernel.h>
#include <linux/timer.h>
#include <linux/interrupt.h>
#include <linux/platform_device.h>
#include <linux/i2c.h>

#include <linux/atmel-ssc.h>

#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/pcm_params.h>
#include <sound/soc.h>
#include <sound/soc-dapm.h>

#include <asm/mach-types.h>
#include <mach/hardware.h>
#include <mach/gpio.h>

#include "../codecs/wm8731.h"
#include "atmel-pcm.h"
#include "atmel_ssc_dai.h"

#define MCLK_RATE 12288000

static int sam9l9260_startup(struct snd_pcm_substream *substream)
{
	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
	int ret;

	printk(KERN_INFO "sam9l9260_startup()\n");

	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK,
		MCLK_RATE, SND_SOC_CLOCK_IN);
	if (ret < 0) {
		return ret;
	}

	return 0;
}

static void sam9l9260_shutdown(struct snd_pcm_substream *substream)
{
	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
	
	printk(KERN_INFO "sam9l9260_shutdown()\n");

	dev_dbg(rtd->socdev->dev, "shutdown");
}

static int sam9l9260_hw_params(struct snd_pcm_substream *substream,
	struct snd_pcm_hw_params *params)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
	struct atmel_ssc_info *ssc_p = cpu_dai->private_data;
	struct ssc_device *ssc = ssc_p->ssc;
	int ret;

	unsigned int rate;
	int cmr_div, period;
	
	printk(KERN_INFO "sam9l9260_hw_params()\n");

	if (ssc == NULL) {
		printk(KERN_INFO "sam9l9260_hw_params: ssc is NULL!\n");
		return -EINVAL;
	}

	/* set codec DAI configuration */
	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
	if (ret < 0)
		return ret;

	/* set cpu DAI configuration */
	/*
	 * atmel_ssc_dai.c
	 *  SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS
	 *  --> I2S format, SSC provides BCLK and LRC clocks.
	 *
	 *  SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM:
	 *  --> I2S format, CODEC supplies BCLK and LRC clocks.
	 */
	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
	if (ret < 0)
		return ret;

	/*
	 * The SSC clock dividers depend on the sample rate.  The CMR.DIV
	 * field divides the system master clock MCK to drive the SSC TK
	 * signal which provides the codec BCLK.  The TCMR.PERIOD and
	 * RCMR.PERIOD fields further divide the BCLK signal to drive
	 * the SSC TF and RF signals which provide the codec DACLRC and
	 * ADCLRC clocks.
	 *
	 * The dividers were determined through trial and error, where a
	 * CMR.DIV value is chosen such that the resulting BCLK value is
	 * divisible, or almost divisible, by (2 * sample rate), and then
	 * the TCMR.PERIOD or RCMR.PERIOD is BCLK / (2 * sample rate) - 1.
	 *
	 * AT91SAM9260 datasheet:
	 * 	CMR - clock mode register - p. 492
	 * 		CMR.DIV is 12-bit value, the divided clock equals
	 * 		the master clock devided by 2 times DIV
	 *
	 * 	TCMR - transmit clock mode register - p. 497
	 * 		TCMR.PERIOD is 8-bit value, divider for frame sync signal (LRCLK).
	 * 		(Also called: WM8731 --> DACLRC, TLV320AIC23 --> LRCIN)
	 * 		A period signal is generated each 2*(PERIOD+1) transmit clock
	 *
	 * 	RCMR - receive clock mode register - p. 493
	 * 		RCMR.PERIOD is 8-bit value, divider for frame sync signal (LRCLK).
	 *		(Also called: WM8731 --> ADCLRC, TLV320AIC23 --> LRCOUT)
	 *		A period signal is generated each 2*(PERIOD+1) receive clock
	 *
	 *	The LRCLK sync signals needs to be as close to the sampling rate as possible.
	 *
	 *	The following register values have been calculated with my
	 *	wm8731_calculate_ssc_dividers.pl script.
	 *
	 *	According to the wm8731 datasheet, the minimum BCLK cycle time is 50 ns.
	 *	That would be f = 1/T = 1/0,050us = 20 MHz
	 */

	rate = params_rate(params);

	printk(KERN_INFO "sam9l9260_hw_params: sample rate is %i Hz\n", rate);

	switch (rate) {
		case 8000:
						cmr_div=29;	/* BCLK = 90 MHz / (2*29) ~= 1.551 MHz */
						period=96;	/* LRC = BCLK/(2*(96+1)) ~= 7998.6 Hz */
						break;
		case 11025:
						cmr_div=13;	/* BCLK ~= 3.461 Mhz */
						period=156;	/* LRC ~= 11024.0 Hz */
						break;
		case 16000:
						cmr_div=38;	/* BCLK ~= 1.184 */
						period=36;	/* LRC ~= 16002.8 */
						break;
		case 22050:
						cmr_div=17;	/* BCLK ~= 2.647 */
						period=59;	/* LRC ~= 22058.8 */
						break;	
		case 32000:
						cmr_div=19;	/* BCLK ~= 2.368 */
						period=36;	/* LRC ~= 32005.6 */
						break;
		case 44100:
						cmr_div=15;	/* BCLK ~= 3.000 */
						period=33;	/* LRC ~= 44117.6 */
						break;
		case 48000:
						cmr_div=7;	/* BCLK ~= 6.428 */
						period=66;	/* LRC ~= 47974.4 */
						break;
		case 88200:
						cmr_div=5;	/* BCLK ~= 9.000 */
						period=50;	/* LRC ~= 88235.3 */
						break;
		case 96000:
						cmr_div=6;	/* BCLK ~= 7.500 */
						period=38;	/* LRC ~= 96153.8 */
						break;
	default:
		printk(KERN_WARNING "unsupported rate %d"
				" on at91sam9g20ek board\n", rate);
		return -EINVAL;
	}

	/* set the MCK divider for BCLK */
	ret = snd_soc_dai_set_clkdiv(cpu_dai, ATMEL_SSC_CMR_DIV, cmr_div);
	if (ret < 0)
		return ret;

	switch (substream->stream)
	{
		case SNDRV_PCM_STREAM_PLAYBACK:
			printk(KERN_DEBUG "%s: substream->stream is SNDRV_PCM_STREAM_PLAYBACK\n", __func__); break;
		case SNDRV_PCM_STREAM_CAPTURE:
			printk(KERN_DEBUG "%s: substream->stream is SNDRV_PCM_STREAM_CAPTURE\n", __func__); break;
		default:
			printk(KERN_DEBUG "%s: substream->stream is INVALID !!!\n", __func__); break;
	}


	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
		/* set the BCLK divider for DACLRC */
		ret = snd_soc_dai_set_clkdiv(cpu_dai,
						ATMEL_SSC_TCMR_PERIOD, period);
		printk(KERN_DEBUG "%s: snd_soc_dai_set_clkdiv() --> I'm transmitter !\n", __func__);
	} else {
		/* set the BCLK divider for ADCLRC */
		ret = snd_soc_dai_set_clkdiv(cpu_dai,
						ATMEL_SSC_RCMR_PERIOD, period);
		printk(KERN_DEBUG "%s: snd_soc_dai_set_clkdiv() --> I'm receiver !\n", __func__);
	}
	if (ret < 0)
		return ret;

	return 0;
}

static struct snd_soc_ops sam9l9260_ops = {
	.startup = sam9l9260_startup,
	.hw_params = sam9l9260_hw_params,
	.shutdown = sam9l9260_shutdown,
};

static const struct snd_soc_dapm_widget sam9l9260_dapm_widgets[] = {
	SND_SOC_DAPM_MIC("Mic", NULL),
	SND_SOC_DAPM_SPK("Phones", NULL),
};

static const struct snd_soc_dapm_route intercon[] = {

	/* speaker connected to LHPOUT */
	{"Phones", NULL, "LHPOUT"},

	/* mic is connected to Mic Jack, with WM8731 Mic Bias */
	{"MICIN", NULL, "Mic Bias"},
	{"Mic Bias", NULL, "Mic"},
};

/*
 * Logic for a wm8731 as connected on a at91sam9g20ek board.
 */
static int sam9l9260_wm8731_init(struct snd_soc_codec *codec)
{
	printk(KERN_DEBUG
			"sam9l9260_wm8731 "
			": sam9l9260_wm8731_init() called\n");
	
	printk(KERN_INFO "sam9l9260_wm8731_init()\n");

	/* Add specific widgets */
	snd_soc_dapm_new_controls(codec, sam9l9260_dapm_widgets,
				  ARRAY_SIZE(sam9l9260_dapm_widgets));
	/* Set up specific audio path interconnects */
	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));

	/* not connected */
	snd_soc_dapm_nc_pin(codec, "RLINEIN");
	snd_soc_dapm_nc_pin(codec, "LLINEIN");
	
	snd_soc_dapm_nc_pin(codec, "ROUT");
	snd_soc_dapm_nc_pin(codec, "LOUT");

	/* always connected */
	snd_soc_dapm_enable_pin(codec, "Mic");
	snd_soc_dapm_enable_pin(codec, "Phones");

	snd_soc_dapm_sync(codec);

	return 0;
}

static struct snd_soc_dai_link sam9l9260_dai = {
	.name = "WM8731",
	.stream_name = "WM8731 PCM",
	.cpu_dai = &atmel_ssc_dai[0],
	.codec_dai = &wm8731_dai,
	.init = sam9l9260_wm8731_init,
	.ops = &sam9l9260_ops,
};

static struct snd_soc_card snd_soc_at91sam9g20ek = {
	.name = "SAM9-L9260",
	.platform = &atmel_soc_platform,
	.dai_link = &sam9l9260_dai,
	.num_links = 1,
};

static struct snd_soc_device sam9l9260_snd_devdata = {
	.card = &snd_soc_at91sam9g20ek,
	.codec_dev = &soc_codec_dev_wm8731,
};

static struct platform_device *sam9l9260_snd_device;

static int __init sam9l9260_init(void)
{
	struct atmel_ssc_info *ssc_p = sam9l9260_dai.cpu_dai->private_data;
	struct ssc_device *ssc = NULL;
	int ret;
	
	printk(KERN_INFO "sam9l9260_init()\n");

	/* Olimex SAM9-L9260 board */
	if (!(machine_is_sam9_l9260()))
		return -ENODEV;

	/*
	 * Request SSC device
	 */
	ssc = ssc_request(0);
	if (IS_ERR(ssc)) {
		printk(KERN_ERR "ASoC: Failed to request SSC 0\n");
		ret = PTR_ERR(ssc);
		ssc = NULL;
		goto err_ssc;
	}
	ssc_p->ssc = ssc;

	sam9l9260_snd_device = platform_device_alloc("soc-audio", -1);
	if (!sam9l9260_snd_device) {
		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
		ret = -ENOMEM;
	}

	platform_set_drvdata(sam9l9260_snd_device,
			&sam9l9260_snd_devdata);
	sam9l9260_snd_devdata.dev = &sam9l9260_snd_device->dev;

	ret = platform_device_add(sam9l9260_snd_device);
	if (ret) {
		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
		platform_device_put(sam9l9260_snd_device);
	}

	return ret;

err_ssc:
	ssc_free(ssc);
	ssc_p->ssc = NULL;
	
	return ret;
}

static void __exit sam9l9260_exit(void)
{
	struct atmel_ssc_info *ssc_p = sam9l9260_dai.cpu_dai->private_data;
	struct ssc_device *ssc;

	if (ssc_p != NULL) {
		ssc = ssc_p->ssc;
		if (ssc != NULL)
			ssc_free(ssc);
		ssc_p->ssc = NULL;
	}

	platform_device_unregister(sam9l9260_snd_device);
	sam9l9260_snd_device = NULL;
}

module_init(sam9l9260_init);
module_exit(sam9l9260_exit);

MODULE_DESCRIPTION("ALSA SoC sam9l9260_WM8731");
MODULE_LICENSE("GPL");
------------------------------------------------------------------------
