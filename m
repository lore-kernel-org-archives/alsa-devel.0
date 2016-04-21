From: PC Liao <pc.liao@mediatek.com>
Subject: Re: [PATCH 2/2 v6] ASoC: mediatek: Add second I2S on mt8173-rt5650
 machine driver
Date: Thu, 21 Apr 2016 17:38:58 +0800
Message-ID: <1461231538.2707.1.camel@mtksdaap41>
References: <1461134447-42001-1-git-send-email-pc.liao@mediatek.com>
	 <1461134447-42001-3-git-send-email-pc.liao@mediatek.com>
	 <57178482.9090705@gmail.com> <1461169664.8479.1.camel@mtksdaap41>
	 <57189BD1.40109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57189BD1.40109@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, srv_heupstream <srv_heupstream@mediatek.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Koro Chen =?UTF-8?Q?=28=E9=99=B3=E6=80=9D=E7=BF=B0=29?= <koro.chen@mediatek.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Matthias,

On Thu, 2016-04-21 at 17:22 +0800, Matthias Brugger wrote:
> 
> On 20/04/16 18:27, PC Liao wrote:
> > Hi Matthias,
> >
> > On Wed, 2016-04-20 at 21:30 +0800, Matthias Brugger wrote:
> >>
> >> For compatibility you should change this to something like:
> >>
> >>      dev_warn(card->dev, "Only one dai codec found in DTS, enabled rt5645
> >>                           AD filter\n");
> >>      rt5645_sel_asrc_clk_src(codec, RT5645_AD_STEREO_FILTER,
> >>                                     RT5645_CLK_SEL_I2S1_ASRC);
> >> }
> >>
> >
> > I will use this in next version.
> > Thanks!
> >
> 
> I think you forgot to add this to v7 of the patches.
> 
> Cheers,
> Matthias

Oh, sorry.
I misunderstand your suggestion.
I will upload.
Thanks!
