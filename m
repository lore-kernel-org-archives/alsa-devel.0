From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
 ALSA SoC drivers
Date: Tue, 27 Apr 2010 10:54:41 +0100
Message-ID: <20100427095440.GA15492@rakim.wolfsonmicro.main>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5D6722489F
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 11:54:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1272350168.24542.6.camel@pasglop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 27, 2010 at 04:36:08PM +1000, Benjamin Herrenschmidt wrote:

> Gross. Loses the linkage to device-tree etc... which is useful for audio
> especially. You should at least make sure the device node follows for
> the target driver to be able to use it :-) I'd like you to sync with
> Grant work on that matter if you are going to convert of_devices into
> platform_devices.

So, Liam already sent a message explaining the technical side of this -
the audio subsystem needs to glue together two or more components that
don't immediately have anything to do with each other from a device tree
point of view and may have rather complex interrelationships.

I'd just like to add that I *really* want to see you guys come to some
sort of firm and documented conclusion about the way to handle
situations like this.  Some variant of this seems to come up every
single time anyone tries to do anything to do with audio on a system
using the device tree and it's getting really repetitive.  What would be
really useful for audio at this point would be if we could get some sort
of decision about how to represent this stuff which we can point people
at so that work on systems using the device tree can be done without
having to deal with the device tree layout discussions that frequently
seem to be involved.
