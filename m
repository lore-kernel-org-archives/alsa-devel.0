From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH] ASoC: add snd_soc_of_parse_master_clkdir() for dt
Date: Thu, 2 Jan 2014 02:57:22 +0000
Message-ID: <0e22852f970e476cb02a446094e3f7c4@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1388477444-18745-1-git-send-email-Li.Xiubo@freescale.com>
 <20131231120415.GL31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131231120415.GL31886@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


> Subject: Re: [PATCH] ASoC: add snd_soc_of_parse_master_clkdir() for dt
> 
> On Tue, Dec 31, 2013 at 04:10:44PM +0800, Xiubo Li wrote:
> 
> > I'm not very sure whether this patch is need for dt.
> 
> It's not clear to me - it's not adding much on top of just passing the
> full property string to _read_bool() directly really.
>

This was just inherited from the _daifmt formats. Maybe this is not very
correct here.

> > For the CPU and CODEC devices' sysclk directions maybe different of
> > the same DAI link.
> 
> Yes, this is common if one of them is generating the clock.

I will use one full name for the next verion.

 
Thanks,

--
Best Regards,
Xiubo
