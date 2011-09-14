From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: [linux-next] ASoC: sound/soc/samsung/neo1973_wm8753.c build
	failure
Date: Thu, 15 Sep 2011 00:38:39 +0100
Message-ID: <20110914233838.GB22946@flint.arm.linux.org.uk>
References: <1315991893.17271.2.camel@phoenix> <20110914191917.GA30518@flint.arm.linux.org.uk> <20110914232808.GC2953@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110914232808.GC2953@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Axel Lin <axel.lin@gmail.com>, Harald Welte <laforge@openezx.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 15, 2011 at 12:28:09AM +0100, Mark Brown wrote:
> On Wed, Sep 14, 2011 at 08:19:17PM +0100, Russell King wrote:
> 
> > Therefore, I suggest that the GTA01 will never be submitted now, moreover
> 
> I'm not entirely sure about that, while...
> 
> > I suggest that neo1973_gta01 was probably a prototype and neo1973_gta02
> > was probably the production platform.
> 
> ...this is true a substantial proportion of the GTA01 devices out there
> are in the hands of people who might hack on it.

Point at a mainline kernel which includes support for the neo1973_gta01
platform.

I assert that there have been none - had there been it would not have
been removed from mach-types, as it would've been marked as existing
in mainline.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
