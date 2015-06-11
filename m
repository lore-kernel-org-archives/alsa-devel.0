From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [alsa-devel][PATCH] ASoC: fsl: add imx-wm8960 machine driver
Date: Thu, 11 Jun 2015 08:51:07 -0700
Message-ID: <20150611155106.GA3036@Asurada>
References: <b2a3c323a0507f3706041e1da98da8375aa61576.1433923593.git.zidan.wang@freescale.com>
 <20150610183619.GA3103@Asurada-CZ80>
 <20150611110958.GA23742@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150611110958.GA23742@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.de, timur@tabi.org, Xiubo.Lee@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 11, 2015 at 07:10:00PM +0800, Zidan Wang wrote:

> > > This imx-wm8960 device-tree-only machine driver works with sai driver
> > > and have below feature.
> > > * support codec master and slave mode
> > > * support headphone jack detect
> > > * support headphone and micphone jack event
> > > * support asrc<->sai<->wm8960 mode
> > > 
> > > Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> > 
> > Above all, could you merge this into fsl-asoc-card?
> > 
> > It'd be nicer to have jack detection over there. And we can
> > put PLL settings to the codec driver as Mark suggested.

> I want to modify imx-wm8960 and upstream it because our release is using it now. After
> upstreaming imx-wm8960, i will try to merge it to fsl-asoc-card.

I knew your intention. That's why I suggested you to merge it directly
to fsl-asoc-card instead of making a duplicated copy of that. Remember
that getting code upstream should be a chance for us to improve thing.

If you find painstaking to handle it in parallel, you can focus on the
improvements of the WM8960 driver while I would help you on the dai-
link part. How about this?

Nicolin
