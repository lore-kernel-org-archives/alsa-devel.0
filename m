From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH] ASoC: fsl_sai: Add isr to deal with error flag
Date: Thu, 27 Mar 2014 02:53:50 +0000
Message-ID: <1e2d210764724c7e834c5307b54c37ab@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1395834517-16426-1-git-send-email-Guangyu.Chen@freescale.com>
 <11a8271c31044515bd2657a93aefdaec@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140327023617.GB16197@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140327023617.GB16197@MrMyself>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> On Thu, Mar 27, 2014 at 10:13:48AM +0800, Xiubo Li-B47053 wrote:
> > > +	regmap_read(sai->regmap, FSL_SAI_TCSR, &xcsr);
> > > +	regmap_write(sai->regmap, FSL_SAI_TCSR, xcsr);
> > > +
> > > +	if (xcsr & FSL_SAI_CSR_WSF)
> > > +		dev_dbg(dev, "isr: Start of Tx word detected\n");
> > > +
> > > +	if (xcsr & FSL_SAI_CSR_SEF)
> > > +		dev_dbg(dev, "isr: Tx Frame sync error detected\n");
> > > +
> > > +	if (xcsr & FSL_SAI_CSR_FEF)
> > > +		dev_dbg(dev, "isr: Transmit underrun detected\n");
> > > +
> >
> > Actually, the above three isrs should to write a logic 1 to this field
> > to clear this flag.
> >
> >
> > > +	if (xcsr & FSL_SAI_CSR_FWF)
> > > +		dev_dbg(dev, "isr: Enabled transmit FIFO is empty\n");
> > > +
> > > +	if (xcsr & FSL_SAI_CSR_FRF)
> > > +		dev_dbg(dev, "isr: Transmit FIFO watermark has been reached\n");
> > > +
> >
> > While are these ones really needed to clear manually ?
> 
> The reference manual doesn't mention about the requirement. So SAI should do
> the self-clearance.

Yes, I do think we should let it do the self-clearance, and shouldn't interfere
of them...
