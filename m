From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH 4/4] ASoC: mid-x86 add jack detect support
Date: Wed, 19 Jan 2011 22:18:04 +0530
Message-ID: <438BB0150E931F4B9CE701519A446301084470BBE1@bgsmsx502.gar.corp.intel.com>
References: <1295441296-32180-1-git-send-email-priya.harsha@intel.com>
	<20110119144138.GB16328@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C541244CF
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 17:50:59 +0100 (CET)
In-Reply-To: <20110119144138.GB16328@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Harsha, Priya" <priya.harsha@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

> This should be split into two: one patch adding the feature in the
> CODEC, the other adding the use of the feature in the machine driver.
Agreed

> >  	/* all end points mic, hs etc */
> > +	SND_SOC_DAPM_HP("HeadPhones", NULL),
> 
> Again this is a machine driver widget.
ACK

> > +int sn95031_get_headset_state(void)
> > +{
> > +	unsigned int mic_bias = sn95031_get_mic_bias(sn95031_codec);
> > +
> > +	if (mic_bias >= SN_HP_START && mic_bias < SN_HP_END) {
> > +		pr_debug("sst: Detected Headphone!!!\n");
> > +		snd_soc_update_bits(sn95031_codec, AUDIO_GPIO_CTRL,
> > +					BIT(1), BIT(0));
> > +	} else if (mic_bias >= SN_AM_HS_START && mic_bias < SN_AM_HS_END) {
> > +		pr_debug("sst: Detected American headset\n");
> > +		snd_soc_update_bits(sn95031_codec, AUDIO_GPIO_CTRL,
> > +					BIT(1), BIT(1));
> > +	} else if (mic_bias >= SN_HS_START && mic_bias < SN_HS_END) {
> > +		pr_debug("sst: Detected Headset!!!\n");
> > +		snd_soc_update_bits(sn95031_codec, AUDIO_GPIO_CTRL,
> > +					BIT(1), BIT(0));
> > +		enable_jack_btn(sn95031_codec);
> > +		return SND_JACK_HEADSET;
> > +	} else
> > +		pr_debug("sst: Detected Open Cable!!!\n");
> 
> What exactly is this doing?  It looks like it's measuring the voltage on
> micbias and using that to identify the accessory connected?  That's
> normally a machine specific thing - different manufacturers have
> different ideas about what they want to do with this.  Some will do
> things like have multiple buttons on the jack with different resistances
> connected between them and measure the voltage to determine which button
> has been pressed, take a look at the Nexus S kernel for one example.
> 
> Looking at all this fairly briefly it looks like all the CODEC is doing
> is providing an ADC and possibly some signals fed directly into the CPU.
> The detection then mostly belongs externally to the CODEC driver - the
> CPU then generates interrupts and the machine driver goes off and does
> some ADC readings using the facility provided by the CODEC.
> 
> Since this is a common pattern we should ideally have some utility code
> which can take any table of ADC values in conjunction with any ADC and
> use those to do detection.
Yes the codec reads into the ADC to measure the micbias voltage.
It has map where we know based on micbais present what kind of accessory maybe
connected. Since this is entirely codec domain it should be in codec.
Let me know if you disagree.

> 
> > +static int sn95031_initialize_adc(struct snd_soc_codec *sn95031_codec)
> > +{
> > +	int base_addr, chnl_addr;
> > +	int value;
> > +	static int channel_index;
> 
> The functions added in this header look like they'd be better placed in
> the source file?
Typically ADC should be a separate driver but we don't have that yet so
though of adding these as helpers.
When we get a proper adc driver we can replace this with code calling adc.

~Vinod
