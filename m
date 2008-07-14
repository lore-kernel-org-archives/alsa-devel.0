From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 1/3] ALSA SoC: Add OpenFirmware
	helper	for matching bus and codec drivers
Date: Mon, 14 Jul 2008 16:28:08 -0600
Message-ID: <20080714222808.GA7073@secretlab.ca>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080714134930.GC25448@sirena.org.uk>
	<9e4733910807140713r5739efedw81e65632006d101d@mail.gmail.com>
	<20080714150527.GD25448@sirena.org.uk>
	<487B7B71.9060606@freescale.com>
	<20080714165302.GG25448@sirena.org.uk>
	<fa686aa40807141021ka4f84e9ycc4ac78db760726c@mail.gmail.com>
	<20080714183632.GI25448@sirena.org.uk>
	<487B9D98.8010008@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 4137B24426
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jul 2008 00:28:34 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so2533696ywk.2
	for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2008 15:28:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <487B9D98.8010008@freescale.com>
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
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 14, 2008 at 01:40:24PM -0500, Timur Tabi wrote:
> Mark Brown wrote:
> 
> > Desktop Management Interface, a standard BIOS interface for getting
> > system data on x86 class hardware.  Of particular interest here is the
> > fact that it contains various ID strings for things like motherboard and
> > chassis - on Linux drivers can be automatically loaded based on these
> > strings.  See drivers/misc/thinkpad_acpi.c for an example of a driver
> > that does this.
> 
> The only problem with this is that the OF probing code in the kernel binds
> drivers to device tree nodes.  So when a driver claims a node, no other driver
> will be probed with it.

Yes, but that is only for the of_platform bus which is just one way to
setup device drivers from the device tree.  Setting it up from the
platform code is just as valid an option.  Or, each ASoC machine driver could
read the device tree itself in the module_init hook to decide whether or not
to instantiate itself.

Cheers,
g.
