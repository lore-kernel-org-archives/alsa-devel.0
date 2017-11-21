From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 2/7] ASoC: Intel: Kconfig:
 Simplify-clarify ACPI/PCI dependencies
Date: Tue, 21 Nov 2017 14:05:19 +0200
Message-ID: <1511265919.25007.336.camel@linux.intel.com>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
         <20171118000202.22302-3-pierre-louis.bossart@linux.intel.com>
         <1511024018.25007.310.camel@linux.intel.com>
         <5b2dde66-d30e-5cd6-15df-12f002850274@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5b2dde66-d30e-5cd6-15df-12f002850274@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2017-11-20 at 10:23 -0600, Pierre-Louis Bossart wrote:
> On 11/18/2017 10:53 AM, Andy Shevchenko wrote:
> > On Fri, 2017-11-17 at 18:01 -0600, Pierre-Louis Bossart wrote:

> >   and there is no publicly available firmware for
> > > Merrifield.
> > 
> > while this is not true. Intel Edison board is based on Merrifield
> > SoC
> > and I'm sure people are able to make a sound out of it.
> 
> I am aware that Edison could run with a modified 4.4 kernel,

Edison can just run vanilla (with some caveats, though not related to
LPE). But okay, there was last official Yocto kernel v3.10.98 based and
v4.4 with Brillo.

>  I just 
> don't know where the firmware is. I don't see anything for Merrifield
> in 
> /lib/firmware/intel?
> If there is a simple way of testing this I don't mind looking into
> this, 
> I just don't have the pointers.

In any case the official bundle has it (sha1):

fcedef11ac49405389b0fb83d526600e0bd933a3  /lib/firmware/fw_sst_119a.bin


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
