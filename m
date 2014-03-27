From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Add isr to deal with error
	flag
Date: Thu, 27 Mar 2014 10:36:18 +0800
Message-ID: <20140327023617.GB16197@MrMyself>
References: <1395834517-16426-1-git-send-email-Guangyu.Chen@freescale.com>
 <11a8271c31044515bd2657a93aefdaec@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 481D326517E
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 03:43:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <11a8271c31044515bd2657a93aefdaec@BY2PR03MB505.namprd03.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li-B47053 <Li.Xiubo@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 27, 2014 at 10:13:48AM +0800, Xiubo Li-B47053 wrote:
> > +	regmap_read(sai->regmap, FSL_SAI_TCSR, &xcsr);
> > +	regmap_write(sai->regmap, FSL_SAI_TCSR, xcsr);
> > +
> > +	if (xcsr & FSL_SAI_CSR_WSF)
> > +		dev_dbg(dev, "isr: Start of Tx word detected\n");
> > +
> > +	if (xcsr & FSL_SAI_CSR_SEF)
> > +		dev_dbg(dev, "isr: Tx Frame sync error detected\n");
> > +
> > +	if (xcsr & FSL_SAI_CSR_FEF)
> > +		dev_dbg(dev, "isr: Transmit underrun detected\n");
> > +
> 
> Actually, the above three isrs should to write a logic 1 to this field
> to clear this flag.
> 
> 
> > +	if (xcsr & FSL_SAI_CSR_FWF)
> > +		dev_dbg(dev, "isr: Enabled transmit FIFO is empty\n");
> > +
> > +	if (xcsr & FSL_SAI_CSR_FRF)
> > +		dev_dbg(dev, "isr: Transmit FIFO watermark has been reached\n");
> > +
> 
> While are these ones really needed to clear manually ?

The reference manual doesn't mention about the requirement. So SAI should do
the self-clearance.
