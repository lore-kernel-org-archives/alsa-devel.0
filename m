From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: Re: [RFC PATCH 1/1] ASoC: soc-core: symmetry checking
 for each DAIs separately
Date: Fri, 26 Aug 2011 13:57:13 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F772226155@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1314351351-1018-1-git-send-email-b29396@freescale.com>
	<4E57824E.8000400@metafoo.de>
	<65EE16ACC360FA4D99C96DC085B3F7722260BF@039-SN1MPN1-001.039d.mgd.msft.net>
	<4E57A070.5090805@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	by alsa0.perex.cz (Postfix) with ESMTP id 6803D24640
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Aug 2011 15:57:21 +0200 (CEST)
In-Reply-To: <4E57A070.5090805@metafoo.de>
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
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
> Sent: Friday, August 26, 2011 9:33 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel@alsa-project.org; linux-arm-kernel@lists.infradead.org;
> broonie@opensource.wolfsonmicro.com; lrg@ti.com; s.hauer@pengutronix.de;
> w.sang@pengutronix.de
> Subject: Re: [RFC PATCH 1/1] ASoC: soc-core: symmetry checking for each
> DAIs separately
> 
> On 08/26/2011 03:17 PM, Dong Aisheng-B29396 wrote:
> >> -----Original Message-----
> >> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
> >> Sent: Friday, August 26, 2011 7:24 PM
> >> To: Dong Aisheng-B29396
> >> Cc: alsa-devel@alsa-project.org;
> >> linux-arm-kernel@lists.infradead.org;
> >> broonie@opensource.wolfsonmicro.com; lrg@ti.com;
> >> s.hauer@pengutronix.de; w.sang@pengutronix.de
> >> Subject: Re: [RFC PATCH 1/1] ASoC: soc-core: symmetry checking for
> >> each DAIs separately
> >>
> >> On 08/26/2011 11:35 AM, Dong Aisheng wrote:
> >>> [...]
> >>>  	/* runtime devices */
> >>> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c index
> >>> 1aee9fc..3f7ded7 100644
> >>> --- a/sound/soc/soc-pcm.c
> >>> +++ b/sound/soc/soc-pcm.c
> >>> @@ -32,33 +32,54 @@ static int soc_pcm_apply_symmetry(struct
> >> snd_pcm_substream *substream)
> >>>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> >>>  	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> >>>  	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> >>> +	unsigned int race;
> >>> +	unsigned int force_rate;
> >>>  	int ret;
> >>>
> >>> +	race = 0;
> >>> +	force_rate = 0;
> >>> +
> >>>  	if (!codec_dai->driver->symmetric_rates &&
> >>>  	    !cpu_dai->driver->symmetric_rates &&
> >>>  	    !rtd->dai_link->symmetric_rates)
> >>>  		return 0;
> >>>
> >>> +	if (codec_dai->active && codec_dai->driver->symmetric_rates ||
> >>> +	     codec_dai->active && rtd->dai_link->symmetric_rates) {
> >>
> >> parenthesis, please, when mixing && and || in the same expression.
> >> Makes it easier to comprehend and protects against accidental mistakes.
> > Thanks for reminder, I will take it.
> >
> >>> +		if (codec_dai->rate != 0)
> >>> +			force_rate = codec_dai->rate;
> >>> +		else
> >>> +			race = 1;
> >>> +	}
> >>> +
> >>> +	if (cpu_dai->active && cpu_dai->driver->symmetric_rates ||
> >>> +	    codec_dai->active && rtd->dai_link->symmetric_rates) {
> >>> +		if (cpu_dai->rate != 0)
> >>> +			force_rate = cpu_dai->rate;
> >>> +		else
> >>> +			race = 1;
> >>> +	}
> >>> +
> >>
> >> If both dais are active and require symmetry we should call
> >> snd_pcm_hw_constraint_minmax for both rates. This will ensure that if
> >> both are already active and are running at different rates that there
> >> will be no valid rate for the new pcm stream. Maybe extend this
> >> function to take the dai as an parameter and call it twice, once for
> >> the codec_dai and once for the cpu_dai.
> >> This would allow to keep the current structure of the function.
> > I was doing like the way as you said before, however, I found the
> > question is that do we have to call snd_pcm_hw_constraint_minmax for
> > the same substream two times?
> >
> > I just thought they should be running at the same rate if both are
> active.
> > Can you help point out in which case they may be different?
> >
> 
> This might be some rather obscure and theoretical setup but image the
> following
> situation:
> 
> A   C
>  \ / \
>   B   D
> 
> The link between A and B and the link between C and D are active and
> running at different rates. Activating the link between C and B should
> fail, since both are already active and are running at different rates.
> 
Yes, it's a theoretical case.
If we add the checking as below:
If (cpu_dai->active && codec_dai->active
    && cpu_dai->rate != codec_dai->rate)
	dev_err(...);
I guess this may not work since that it's possible when DAI is active while
it's rate is still not set.

Taking account of this case may bring a bit more complexity.
Do you have any other suggestion? 
Can we prevent it happen in machine layer?

Regards
Dong Aisheng
