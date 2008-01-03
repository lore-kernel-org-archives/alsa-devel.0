From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Fri, 4 Jan 2008 10:51:56 +1100
Message-ID: <20080103235156.GE12883@localhost.localdomain>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>
	<477BAB67.4080003@freescale.com>
	<9e4733910801020734n115888cbt86351f67f2311629@mail.gmail.com>
	<477D2150.4020506@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	by alsa0.perex.cz (Postfix) with ESMTP id A0EFC246B7
	for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2008 03:39:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <477D2150.4020506@freescale.com>
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
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 03, 2008 at 11:54:24AM -0600, Timur Tabi wrote:
> Jon Smirl wrote:
> > On 1/2/08, Timur Tabi <timur@freescale.com> wrote:
> >> Jon Smirl wrote:
> >>> On 1/1/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> >>>> On 12/19/07, Timur Tabi <timur@freescale.com> wrote:
[snip]
> > Don't we want to follow the device tree policy of putting the device
> > on the controlling bus and then link it to the data bus?
> 
> Normally, that sounds like a good idea, but the cs4270 is an I2S
> device first, and an I2C device second.  I need to be able to find
> that codec from the I2S node.  My I2S driver would not know to scan
> all I2C devices to find the codec.

And what distinction are you drawing between "first" and "second"
here?  For the device tree, the primary bus should the the one by
which it's addressable - i.e. where the control registers are, not
the data path.

Why would the I2S need to scan for codecs?  Wouldn't it be up to the
codec driver to register with I2S?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
