From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH 2/3] ASoC: core: Set the default I/O up try regmap.
Date: Fri, 28 Feb 2014 05:56:58 +0000
Message-ID: <1b89016263c84e0297655034a648032f@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1393494593-26310-1-git-send-email-Li.Xiubo@freescale.com>
 <1393494593-26310-3-git-send-email-Li.Xiubo@freescale.com>
 <20140228035244.GJ9383@sirena.org.uk>
 <c405df11848a40b7beda8d8fe747e7a7@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140228052904.GP9383@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140228052904.GP9383@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

> Subject: Re: [PATCH 2/3] ASoC: core: Set the default I/O up try regmap.
> 
> On Fri, Feb 28, 2014 at 04:00:38AM +0000, Li.Xiubo@freescale.com wrote:
> 
> > I'll send another patches to applied to use this for another CODEC drivers.
> > And there almost 80 files, Should I send them in one patch or split them
> into
> > individual patch for each CODEC driver ?
> 
> I'd suggest doing one patch that covers the boring drivers where the
> first thing they do is call set_cache_io() but split out the others into
> one patch per driver since the need more examination.

Got it.

Thanks,

--
Best Regards,
Xiubo
