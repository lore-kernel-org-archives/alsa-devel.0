From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [alsa-devel] [PATCH 2/3] ASoC: core: Set the default I/O up try
 regmap.
Date: Fri, 28 Feb 2014 06:40:37 +0000
Message-ID: <d872d0fd60eb4c01b38af98014c802aa@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1393494593-26310-1-git-send-email-Li.Xiubo@freescale.com>
 <1393494593-26310-3-git-send-email-Li.Xiubo@freescale.com>
 <20140228035244.GJ9383@sirena.org.uk>
 <c405df11848a40b7beda8d8fe747e7a7@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140228052904.GP9383@sirena.org.uk>
 <1b89016263c84e0297655034a648032f@BY2PR03MB505.namprd03.prod.outlook.com>
 <53102EE4.80702@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53102EE4.80702@metafoo.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


> Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: core: Set the default I/O up try
> regmap.
> 
> On 02/28/2014 06:56 AM, Li.Xiubo@freescale.com wrote:
> >> Subject: Re: [PATCH 2/3] ASoC: core: Set the default I/O up try regmap.
> >>
> >> On Fri, Feb 28, 2014 at 04:00:38AM +0000, Li.Xiubo@freescale.com wrote:
> >>
> >>> I'll send another patches to applied to use this for another CODEC drivers.
> >>> And there almost 80 files, Should I send them in one patch or split them
> >> into
> >>> individual patch for each CODEC driver ?
> >>
> >> I'd suggest doing one patch that covers the boring drivers where the
> >> first thing they do is call set_cache_io() but split out the others into
> >> one patch per driver since the need more examination.
> >
> > Got it.
> 
> Btw. be careful, just removing the set_cache_io() call will not work for all
> drivers. There are some MFD child devices which use regmap from the parent
> device. So dev_get_regmap() will return NULL for those.
> 

@Lars,

Do you mean the CODEC drivers like wm5110 and wm8997 ?

Thanks,

--
Best Regards,
Xiubo
 
