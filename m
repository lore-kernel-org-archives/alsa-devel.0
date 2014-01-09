From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: add RT5670 CODEC driver
Date: Thu, 9 Jan 2014 15:47:52 +0800
Message-ID: <1121E117AD4ECE49880A389A396215BB939A951093@rtitmbs7.realtek.com.tw>
References: <1387195916-3106-1-git-send-email-bardliao@realtek.com>
 <20131219122527.GX31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id C51F9261635
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 08:47:56 +0100 (CET)
In-Reply-To: <20131219122527.GX31886@sirena.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, December 19, 2013 8:25 PM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Flove; Oder Chiou
> Subject: Re: [PATCH] ASoC: add RT5670 CODEC driver
> 
> On Mon, Dec 16, 2013 at 08:11:56PM +0800, bardliao@realtek.com wrote:
> > From: Bard Liao <bardliao@realtek.com>
> 
> This patch is far too big, it really needs to be split up into a patch series to
> make it reviewable.  I'd suggest at least doing something like splitting it into
> one patch adding the CODEC functionality and then a second patch adding the
> DSP support.  Probably the header ought to be a separate patch too.

I will send the audio function part first.

> > +unsigned rt5670_pdm1_read(struct snd_soc_codec *codec, unsigned int
> > +reg) {
> 
> > +EXPORT_SYMBOL(rt5670_pdm1_read);
> 
> Why is this exported at all and why is it exported non-GPL?

If a pdm device connect to RT5670, it may need to be controlled by RT5670's pdm read/write commands.
I will export it with GPL.

> > +static int rt5670_asrc_event(struct snd_soc_dapm_widget *w,
> > +	struct snd_kcontrol *kcontrol, int event) {
> > +
> > +	switch (event) {
> > +	case SND_SOC_DAPM_POST_PMU:
> > +		snd_soc_write(w->codec, RT5670_ASRC_1, 0xffff);
> > +		snd_soc_write(w->codec, RT5670_ASRC_2, 0x1221);
> > +		snd_soc_write(w->codec, RT5670_ASRC_3, 0x0022);
> > +		break;
> > +	case SND_SOC_DAPM_PRE_PMD:
> > +		snd_soc_write(w->codec, RT5670_ASRC_1, 0);
> > +		snd_soc_write(w->codec, RT5670_ASRC_2, 0);
> > +		snd_soc_write(w->codec, RT5670_ASRC_3, 0);
> > +	default:
> > +		return 0;
> > +	}
> 
> This looks an awful lot like it might be writing some use case dependant
> parameters...  since it's just uncommented magic numbers it's hard to tell
> but there's no obvious configuration for the ASRC anywhere in the driver.

I will add control to configure ASRC's parameters.

> > +	if (rt5670->pdata.asrc_en) {
> > +		snd_soc_dapm_new_controls(&codec->dapm, rt5670_asrc_widgets,
> > +				ARRAY_SIZE(rt5670_dapm_widgets));
> > +		snd_soc_dapm_add_routes(&codec->dapm, rt5670_asrc_routes,
> > +				ARRAY_SIZE(rt5670_dapm_routes));
> > +	}
> 
> Why is this configured in platform data?

Usually, we don't enable ASRC function.
But in some platforms, they will need to enable ASRC function to get clock properly.
And I think this is not needed to configure in run time.

Thanks.
