From: Johan Hovold <johan@kernel.org>
Subject: Re: [alsa-devel] [PATCH v3 2/5] soundwire: fix style issues
Date: Wed, 17 Apr 2019 11:33:54 +0200
Message-ID: <20190417093354.GL775@localhost>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
 <20190411031701.5926-3-pierre-louis.bossart@linux.intel.com>
 <20190414095839.GG28103@vkoul-mobl>
 <08ea1442-361a-ecfc-ca26-d3bd8a0ec37b@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <08ea1442-361a-ecfc-ca26-d3bd8a0ec37b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 15, 2019 at 08:09:59AM -0500, Pierre-Louis Bossart wrote:
> 
> >>
> >> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >> ---
> >>   drivers/soundwire/Kconfig          |   2 +-
> >>   drivers/soundwire/bus.c            |  87 ++++++++--------
> >>   drivers/soundwire/bus.h            |  16 +--
> >>   drivers/soundwire/bus_type.c       |   4 +-
> >>   drivers/soundwire/cadence_master.c |  87 ++++++++--------
> >>   drivers/soundwire/cadence_master.h |  22 ++--
> >>   drivers/soundwire/intel.c          |  87 ++++++++--------
> >>   drivers/soundwire/intel.h          |   4 +-
> >>   drivers/soundwire/intel_init.c     |  12 +--
> >>   drivers/soundwire/mipi_disco.c     | 116 +++++++++++----------
> >>   drivers/soundwire/slave.c          |  10 +-
> >>   drivers/soundwire/stream.c         | 161 +++++++++++++++--------------
> > 
> > I would prefer this to be a patch per module. It doesnt help to have a
> > single patch for all the files!
> > 
> > It would be great to have cleanup done per logical group, for example
> > typos in a patch, aligns in another etc...
> 
> You've got to be kidding. I've never seen people ask for this sort of 
> detail.
> 
> > 
> >>   12 files changed, 313 insertions(+), 295 deletions(-)
> >>
> >> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> >> index 19c8efb9a5ee..84876a74874f 100644
> >> --- a/drivers/soundwire/Kconfig
> >> +++ b/drivers/soundwire/Kconfig
> >> @@ -4,7 +4,7 @@
> >>   
> >>   menuconfig SOUNDWIRE
> >>   	bool "SoundWire support"
> >> -	---help---
> >> +	help
> > 
> > Not sure if this is a style issue, kernel seems to have 2990 instances
> > of this!
> 
> this is reported by checkpatch.pl --strict.

Please don't run checkpatch on code that's already in the kernel, and
especially not with the --strict (a.k.a. --subjective) option enabled.

Don't try to fix what isn't broken.

Thanks,
Johan
