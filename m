From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH 1/4] ASoC: sn95031: add capture support
Date: Wed, 19 Jan 2011 21:58:11 +0530
Message-ID: <438BB0150E931F4B9CE701519A446301084470BBD1@bgsmsx502.gar.corp.intel.com>
References: <1295441169-32063-1-git-send-email-priya.harsha@intel.com>
	<20110119125131.GB31791@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id E8081244AD
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 17:28:20 +0100 (CET)
In-Reply-To: <20110119125131.GB31791@opensource.wolfsonmicro.com>
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

> 
> > +static int amic1_mic_bias(struct snd_soc_dapm_widget *w,
> > +				struct snd_kcontrol *k, int event)
> > +{
> > +	unsigned int value = 0;
> > +
> > +	if (SND_SOC_DAPM_EVENT_ON(event)) {
> > +		pr_debug("AMIC1 SND_SOC_DAPM_EVENT_ON doing\n");
> > +		value = BIT(2);
> > +	}
> > +	snd_soc_update_bits(w->codec, SN95031_MICBIAS, BIT(2), value);
> > +	return 0;
> > +}
> 
> I'm not clear why this is being done using an event?  It's updating a
> single register bit which is what the standard MICBIAS widget does.
> There's also another example of debug logging which replicates the
> standard feature facilities.
Sorry, somehow missed to remove this log :(
Yes this can be changed...

> > +static int dmic12_mic_bias(struct snd_soc_dapm_widget *w,
> > +				struct snd_kcontrol *k, int event)
> > +{
> > +	unsigned int ldo = 0, clk = 0, out = 0;
> > +
> > +	if (SND_SOC_DAPM_EVENT_ON(event)) {
> > +		pr_debug("DMIC12 SND_SOC_DAPM_EVENT_ON doing\n");
> > +		ldo = BIT(5)|BIT(4);
> > +		clk = BIT(0);
> > +		out = BIT(3);
> > +	}
> > +	/* program DMIC LDO */
> > +	snd_soc_update_bits(w->codec, SN95031_MICBIAS, BIT(5)|BIT(4), ldo);
> > +	msleep(1);
> > +	/* enable/disable DMIC clock and o/p */
> > +	snd_soc_update_bits(w->codec, SN95031_DMICLK, BIT(0), clk);
> > +	snd_soc_update_bits(w->codec, SN95031_DMICMUX, BIT(3), out);
> 
> How about using a supply widget for the LDO and the clock?  This would
> also ensure that...
Hmmm, so what you are saying is add a supply widget like we have "Headset" and
which does above. I thought about that, but what I have here is ADC with NULL
stream (to ensure ADCs are on only when AMICs are selected) and added virtual
AIF with capture stream, and all TX paths (and thereby DMIC and ADC connected
to that). If I add supply widgets, then how do I code the map? Should I do
AIF->TXPATH ->DMIC->Supply ?

> > +	if (SND_SOC_DAPM_EVENT_ON(event)) {
> > +		pr_debug("DMIC34 SND_SOC_DAPM_EVENT_ON doing\n");
> > +		ldo = BIT(5)|BIT(4);
> > +		clk = BIT(1);
> > +		out = BIT(4);
> 
> ...we don't end up disabling them when one of the DMICs is shut off but
> the other is left on.
Agreed this needs to be taken care of...


> > +	SND_SOC_DAPM_MIC("AMIC1", amic1_mic_bias), /* headset mic */
> > +	SND_SOC_DAPM_MIC("AMIC2", amic2_mic_bias),
> > +	SND_SOC_DAPM_MIC("DMIC1", dmic12_mic_bias),
> > +	SND_SOC_DAPM_MIC("DMIC2", dmic12_mic_bias),
> > +	SND_SOC_DAPM_MIC("DMIC3", dmic34_mic_bias),
> > +	SND_SOC_DAPM_MIC("DMIC4", dmic34_mic_bias),
> > +	SND_SOC_DAPM_MIC("DMIC5", dmic56_mic_bias),
> > +	SND_SOC_DAPM_MIC("DMIC6", dmic56_mic_bias),
> 
> These widgets are for use externally to the device in machine drivers.
> The pins on the CODEC should be _INPUT() widgets and the biases should
> be MICBIAS widgets.
Sure..


> 
> > +	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "MIC1 Enable", SN95031_MICAMP1,
> > +			0, 1, 1, 0),
> > +	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "MIC2 Enable", SN95031_MICAMP2,
> > +			0, 1, 1, 0),
> 
> These look awfully like they should just be normal PGA widgets?
Yes that can be done that way

~Vinod
