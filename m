From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv3 1/3] ASoC: codec: Simplify ASoC probe code.
Date: Mon, 10 Mar 2014 03:51:40 +0000
Message-ID: <0dbba1debfd149a6a5e3985349a95793@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1393814545-15002-1-git-send-email-Li.Xiubo@freescale.com>
 <1393814545-15002-2-git-send-email-Li.Xiubo@freescale.com>
 <20140303045952.GO2411@sirena.org.uk>
 <5bc570ec866541a68df5813ffbe3168e@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140304043603.GI2411@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140304043603.GI2411@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> Subject: Re: [PATCHv3 1/3] ASoC: codec: Simplify ASoC probe code.
> 
> On Mon, Mar 03, 2014 at 07:24:36AM +0000, Li.Xiubo@freescale.com wrote:
> 
> > > >  	/* Default to using ALC auto offset calibration mode. */
> > > >  	snd_soc_update_bits(codec, DA7213_ALC_CTRL1,
> > > >  			    DA7213_ALC_CALIB_MODE_MAN, 0);
> 
> > > This one will fail.
> 
> > Sorry, I'm not very understand why will this fail ? Before the ASoC probe,
> > the ASoC core will set the I/O.
> > :)
> 
> OK, that's now been refactored.

@Mark, @Lars,

Has there any other problems about this patch series? And this I had tested on
our Vybrid-Twr board based on SGTL5000 codec and SAI drivers. If not, I can
continue with my second patches series about " Remove set_cache_io entirely from
ASoC probe".

Thanks very much.

--
Best Regards,
Xiubo
