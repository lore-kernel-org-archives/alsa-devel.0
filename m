From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: mid-x86 add jack detect support
Date: Wed, 19 Jan 2011 14:41:38 +0000
Message-ID: <20110119144138.GB16328@opensource.wolfsonmicro.com>
References: <1295441296-32180-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 47C511039AF
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 15:41:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295441296-32180-1-git-send-email-priya.harsha@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harsha Priya <priya.harsha@intel.com>
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 19, 2011 at 06:18:16PM +0530, Harsha Priya wrote:

>  sound/soc/codecs/sn95031.c             |   82 +++++++++++++-
>  sound/soc/codecs/sn95031.h             |   20 ++++
>  sound/soc/codecs/sn95031_adc_control.h |  194 ++++++++++++++++++++++++++++++++
>  sound/soc/mid-x86/mfld_machine.c       |  159 +++++++++++++++++++++-----

This should be split into two: one patch adding the feature in the
CODEC, the other adding the use of the feature in the machine driver.

> +struct snd_soc_codec *sn95031_codec;
> +

Why do we need a global variable?

>  	/* all end points mic, hs etc */
> +	SND_SOC_DAPM_HP("HeadPhones", NULL),

Again this is a machine driver widget.

> +int sn95031_get_headset_state(void)
> +{
> +	unsigned int mic_bias = sn95031_get_mic_bias(sn95031_codec);
> +
> +	if (mic_bias >= SN_HP_START && mic_bias < SN_HP_END) {
> +		pr_debug("sst: Detected Headphone!!!\n");
> +		snd_soc_update_bits(sn95031_codec, AUDIO_GPIO_CTRL,
> +					BIT(1), BIT(0));
> +	} else if (mic_bias >= SN_AM_HS_START && mic_bias < SN_AM_HS_END) {
> +		pr_debug("sst: Detected American headset\n");
> +		snd_soc_update_bits(sn95031_codec, AUDIO_GPIO_CTRL,
> +					BIT(1), BIT(1));
> +	} else if (mic_bias >= SN_HS_START && mic_bias < SN_HS_END) {
> +		pr_debug("sst: Detected Headset!!!\n");
> +		snd_soc_update_bits(sn95031_codec, AUDIO_GPIO_CTRL,
> +					BIT(1), BIT(0));
> +		enable_jack_btn(sn95031_codec);
> +		return SND_JACK_HEADSET;
> +	} else
> +		pr_debug("sst: Detected Open Cable!!!\n");

What exactly is this doing?  It looks like it's measuring the voltage on
micbias and using that to identify the accessory connected?  That's
normally a machine specific thing - different manufacturers have
different ideas about what they want to do with this.  Some will do
things like have multiple buttons on the jack with different resistances
connected between them and measure the voltage to determine which button
has been pressed, take a look at the Nexus S kernel for one example.

Looking at all this fairly briefly it looks like all the CODEC is doing
is providing an ADC and possibly some signals fed directly into the CPU.
The detection then mostly belongs externally to the CODEC driver - the
CPU then generates interrupts and the machine driver goes off and does
some ADC readings using the facility provided by the CODEC.

Since this is a common pattern we should ideally have some utility code
which can take any table of ADC values in conjunction with any ADC and
use those to do detection.

> +static int sn95031_initialize_adc(struct snd_soc_codec *sn95031_codec)
> +{
> +	int base_addr, chnl_addr;
> +	int value;
> +	static int channel_index;

The functions added in this header look like they'd be better placed in
the source file?
