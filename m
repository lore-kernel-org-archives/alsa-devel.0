From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: dmaengine-pcm: Add support for
 querying stream position from DMA device
Date: Mon, 11 Jun 2012 17:20:09 +0200
Message-ID: <4FD60CA9.3070701@metafoo.de>
References: <1339416253-4121-1-git-send-email-lars@metafoo.de> <1339416253-4121-2-git-send-email-lars@metafoo.de> <20120611132409.GG11168@n2100.arm.linux.org.uk> <20120611145735.GU11439@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120611145735.GU11439@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 06/11/2012 04:57 PM, Mark Brown wrote:
> On Mon, Jun 11, 2012 at 02:24:09PM +0100, Russell King - ARM Linux wrote:
> 
>> What we need to do is to get rid of this idea that reporting the residue
>> is optional for DMA engine drivers.  Let's make it absolutely required
>> in order to support cyclic transfers.
> 
> I tend to agree, if we are going to let things not implement this we
> need to provide an out of bounds way for them to signal that they don't
> support it and make it an error to use the interface at all.  Otherwise
> the interface complexity increases as you get into special cases and so
> on.  We only need to fix the drivers that are used with ASoC immediately
> and there's not so many of them which is easier than being forced to get
> every driver upgraded at once.

I think the previous discussions have made it clear that we don't want to
make it optional for drivers to implement residue reporting for cyclic
transfers.

Another option is to provide the current implementation of the pcm_pointer
as a standalone legacy function, which can be used by the old platforms
until their dmaengine drivers have cached up. And add a new residue-only
implementation which will be mandatory for new drivers. That would make it
more explicit that those platforms are sort of broken and need to be fixed.
After all of them have been fixed the legacy pcm_pointer implementation can
be removed.

I still think though that residue should never be reported as 0 for active
cyclic transfers.

- Lars
