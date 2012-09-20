From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH v2] ASoC: codecs: Add DA9055 codec driver
Date: Thu, 20 Sep 2012 17:28:55 +0530
Message-ID: <1348142335.18996.17.camel@matrix>
References: <1347622057.16763.27.camel@matrix>
 <20120919025035.GI8832@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C0712652E8
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 13:47:43 +0200 (CEST)
In-Reply-To: <20120919025035.GI8832@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org


> > +	/* DAC Routing control */
> > +	SOC_ENUM("DAC Left Select", da9055_dac_l_select),
> > +	SOC_ENUM("DAC Right Select", da9055_dac_r_select),
> 
> DAPM.  This even says its a routing control...

Yes, let me see if I can make it DAPM based.

> 
> > +	/* To select if MIC Bias powers MIC 1 or MIC 2 */
> > +	SOC_ENUM("Mic Bias Select", da9055_mic_bias_select),
> 
> This would normally be something controlled by the board...  what
> exactly is this doing?  How does the MICBIAS relate to the microphone
> inputs?

Yes, it should be controlled by the board.
This control selects which of the two MIC Bias pins acts as the BIAS
source. Earlier we misinterpreted it because of a hardware modification
which was present on the board without our knowledge.

> 
> > +	case SND_SOC_BIAS_STANDBY:
> > +		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
> > +			/* Enable VMID reference & master bias */
> > +			snd_soc_update_bits(codec, DA9055_REFERENCES,
> > +					    DA9055_VMID_EN | DA9055_BIAS_EN,
> > +					    DA9055_VMID_EN | DA9055_BIAS_EN);
> > +		}
> > +		regcache_sync(da9055->regmap);
> 
> Doing the sync every time is very odd, why is it only done on
> transitions from _OFF?

It was a typo :-( I intend to put the sync inside if().

> Given that there's no regulator support here
> it's also a bit surprising that you need to do a sync outside of system
> suspend...
> 

I am not sure if I understood this fully. Do you mean a sync is not
required here?


> > +	da9055->mclk_rate       = 0;    /* This will be set from set_sysclk() */
> > +	da9055->master          = 0;    /* This will be set from set_fmt() */
> 
> You use kzalloc...
> 

Yeah!
