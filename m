From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc/multi-component: fsl: add support for
 variable SSI FIFO depth
Date: Thu, 5 Aug 2010 19:18:32 +0100
Message-ID: <20100805181832.GA32359@rakim.wolfsonmicro.main>
References: <1280952264-21813-1-git-send-email-timur@freescale.com>
	<20100805111010.GA13146@rakim.wolfsonmicro.main>
	<AANLkTinYjH-r3Myv=YavQBS0ULu-T0U4LPscsMOUtujR@mail.gmail.com>
	<20100805135153.GB14470@opensource.wolfsonmicro.com>
	<69A042BE-A5B7-4BD5-91FF-B3F635AF7839@freescale.com>
	<20100805145430.GB26801@opensource.wolfsonmicro.com>
	<5610599F537DD74A8D1F5CC946A750730347914E@az33exm25.fsl.freescale.net>
	<20100805160310.GA17454@opensource.wolfsonmicro.com>
	<5610599F537DD74A8D1F5CC946A750730347914F@az33exm25.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 894A8245C1
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 20:18:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5610599F537DD74A8D1F5CC946A750730347914F@az33exm25.fsl.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 05, 2010 at 09:21:15AM -0700, Tabi Timur-B04825 wrote:

> the FIFO depth, the drivers need to know that information.  The only way to 
> pass that info to the drivers is via the device tree.

Clearly this is not entirely true, people manage to write non-DT kernels
after all.  In a strongly device tree oriented model it does need to be
via the device tree, but even there there's options for how the data
gets there - for example, we can supply it by looking at the CPU type
and fixing up the DTS prior to the driver seeing it, or any one of a
number of other methods.  I'd probably not have queried this so much if
I'd noticed some sort of handling for such a method.

It's not so much this particular property I'm worried about as the
general style for things like this so CCing in Grant.

> Mark Brown wrote:

> > I'd have strongly expected that the
> > device tree was able to incoporate all the properties that are standard
> > to the CPU by reference somehow (with that data being distributed
> > separately to the per system device tree).

> Separately?  Why?  Look at the device trees we have today.  They are full of 
> nodes with all sorts of device-specific properties that describe minor 
> differences among the devices across various SOCs.

Separately because people make and distribute systems with a parts on
them well before software is finalised in mainline.  Requiring that both
the DTS and the kernel match up and get updated for new feature support
means that you've got two different things (potentially maintained by
different groups in the end user environment) to distribute and get
updated on systems separately.  Failure to update one may result in
problems on another, either with features not getting enabled or with
newer kernel versions not wanting to run on systems with older device
trees.

It also seems like busy work for users to have to add things like this
to their device trees.  I think what I'd expect to see in a strongly
device tree model is something like the tree for a board saying it's
using a given SoC and then a standard device tree for the SoC which is
shared between all the different users of that SoC getting merged in
early in boot (probably from the kernel).  That way if we gain support
for a new feature on the SoC or discover something that needs to be
flagged up for workaround then every board using the SoC will pick it
up.  This seems particularly useful for things like crypto engines that
are physically internal to the SoC and so don't normally require
per-board hookup.  In ASoC terms you do need board specific hookup so
that's a bit less of an issue but it looses us some of the benefit of
having standard chip drivers by pushing some of the chip generic
knowledge into a per-machine location.

The fact that the PowerPC systems are currently doing this isn't
something I'd rely on with other architectures, the vendor and customer
bases may be very different.
