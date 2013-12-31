From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH] ASoC: simple-card: cleanup asoc_simple_card_parse_of()
 code
Date: Tue, 31 Dec 2013 03:27:53 +0000
Message-ID: <4c44077c52604d0b85c4babb59268eb7@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1388114078-24517-1-git-send-email-Li.Xiubo@freescale.com>
 <20131230121113.GQ31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131230121113.GQ31886@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


> Subject: Re: [PATCH] ASoC: simple-card: cleanup asoc_simple_card_parse_of()
> code
> 
> On Fri, Dec 27, 2013 at 11:14:38AM +0800, Xiubo Li wrote:
> > Since there is only one common format via "simple-audio-card,format"
> > for simple card driver(CPU & CODEC DAI), there is no need to do the
> > INV mask.
> 
> I don't understand this change, how is the fact that the CPU and CODEC
> DAI share a common format related to using the inversion?  The inversion
> specifies the format relative to the spec rather than relative to the
> other end of the link and for any DAI link the two devices should be
> using the same format.

Also, for most of the devices of the same DAI link, they use the same DAI
formats, but I have found some drivers like : "sound/soc/pxa/magician.c"
and "sound/soc/s6000/s6105-ipcam.c", etc, may have different DAI format
settings for some reasons(maybe some formats are the CPU/Codec devices
default setting that it needn't set it here or others).

I think maybe this is also the reason why the simple-card has common DAI
format and CPU/CODEC private DAI formats at the same time.


Thanks,

--
Best Regards,
Xiubo
