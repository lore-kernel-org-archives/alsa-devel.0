From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 3 Jan 2008 15:44:32 +1100
Message-ID: <20080103044432.GB25357@localhost.localdomain>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
	<477BADF5.9060003@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	by alsa0.perex.cz (Postfix) with ESMTP id C7FE224536
	for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2008 09:51:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <477BADF5.9060003@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 02, 2008 at 09:29:57AM -0600, Timur Tabi wrote:
> Jon Smirl wrote:
> > On 12/19/07, Timur Tabi <timur@freescale.com> wrote:
> >>  sound/soc/fsl/fsl_ssi.c                      |  614 +++++++++++++++++++
> >>  sound/soc/fsl/fsl_ssi.h                      |  224 +++++++
> > 
> > I'm confused about this part. You built a driver for the mpc8610 ssi
> > port.  This port has a device tree entry.
> > 
> > +		ssi@16000 {
> > +			compatible = "fsl,ssi";
> > +			cell-index = <0>;
> > +			reg = <16000 100>;
> > +			interrupt-parent = <&mpic>;
> > +			interrupts = <3e 2>;
> > +			fsl,mode = "i2s-slave";
> > +			codec {
> > +				compatible = "cirrus,cs4270";
> > +				/* MCLK source is a stand-alone oscillator */
> > +				bus-frequency = <bb8000>;
> > +			};
> > +		};
> > 
> > But then you don't create an of_platform_driver for this device.
> > Instead you create one for the fabric driver, struct
> > of_platform_driver mpc8610_hpcd_of_driver, and directly link the SSI
> > driver into it.
> 
> That's the best plan I came up with.  This is apparently fixed in ASoC 
> V2.  From ASoC V1's perspective, the fabric driver must be the master. 
> However, it doesn't make sense to have a node in the device tree for the 
> fabric driver, because there is no such "device".  The fabric driver is 
> an abstraction.  So I need to chose some other node to probe the fabric 
> driver with.  I chose the SSI, since each SSI can have only one
> codec.

Instantiating the fabric driver off any node is wrong, precisely
because it is an abstraction.  The fabric driver should be
instantiated by the platform code.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
