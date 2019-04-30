From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [alsa-devel] [PATCH v3 2/5] soundwire: fix style issues
Date: Tue, 30 Apr 2019 14:21:53 +0530
Message-ID: <20190430085153.GS3845@vkoul-mobl.Dlink>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 15-04-19, 08:09, Pierre-Louis Bossart wrote:
> 
> > > 
> > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > ---
> > >   drivers/soundwire/Kconfig          |   2 +-
> > >   drivers/soundwire/bus.c            |  87 ++++++++--------
> > >   drivers/soundwire/bus.h            |  16 +--
> > >   drivers/soundwire/bus_type.c       |   4 +-
> > >   drivers/soundwire/cadence_master.c |  87 ++++++++--------
> > >   drivers/soundwire/cadence_master.h |  22 ++--
> > >   drivers/soundwire/intel.c          |  87 ++++++++--------
> > >   drivers/soundwire/intel.h          |   4 +-
> > >   drivers/soundwire/intel_init.c     |  12 +--
> > >   drivers/soundwire/mipi_disco.c     | 116 +++++++++++----------
> > >   drivers/soundwire/slave.c          |  10 +-
> > >   drivers/soundwire/stream.c         | 161 +++++++++++++++--------------
> > 
> > I would prefer this to be a patch per module. It doesnt help to have a
> > single patch for all the files!
> > 
> > It would be great to have cleanup done per logical group, for example
> > typos in a patch, aligns in another etc...
> 
> You've got to be kidding. I've never seen people ask for this sort of
> detail.

Nope this is the way it should be. A patch is patch and which
should do one thing! Even if it is a cleanup one.

I dislike a patch which touches everything, core, modules, so please
split up. As a said in review it takes guesswork to find why a change
was done, was it whitespace fix, indentation or not, so please split up
based on type of fixes.

> 
> > 
> > >   12 files changed, 313 insertions(+), 295 deletions(-)
> > > 
> > > diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> > > index 19c8efb9a5ee..84876a74874f 100644
> > > --- a/drivers/soundwire/Kconfig
> > > +++ b/drivers/soundwire/Kconfig
> > > @@ -4,7 +4,7 @@
> > >   menuconfig SOUNDWIRE
> > >   	bool "SoundWire support"
> > > -	---help---
> > > +	help
> > 
> > Not sure if this is a style issue, kernel seems to have 2990 instances
> > of this!
> 
> this is reported by checkpatch.pl --strict.
> 
> > 
> > >   	if (msg->page)
> > >   		sdw_reset_page(bus, msg->dev_num);
> > > @@ -243,7 +244,7 @@ int sdw_transfer(struct sdw_bus *bus, struct sdw_msg *msg)
> > >    * Caller needs to hold the msg_lock lock while calling this
> > >    */
> > >   int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg,
> > > -				struct sdw_defer *defer)
> > > +		       struct sdw_defer *defer)
> > 
> > this does not seem aligned to me!
> 
> It is, I checked. 2 tabs and 7 spaces.
> 
> > 
> > >   int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
> > > -		u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf)
> > > +		 u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf)
> > 
> > this one too
> 
> 2 tabs and one space.
> 
> > 
> > > @@ -458,13 +458,13 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
> > >   		mutex_unlock(&slave->bus->bus_lock);
> > >   		if (dev_num < 0) {
> > >   			dev_err(slave->bus->dev, "Get dev_num failed: %d",
> > > -								dev_num);
> > > +				dev_num);
> > 
> > It might read better if we move the log to second line along with
> > dev_num...

?

> > 
> > >   int sdw_configure_dpn_intr(struct sdw_slave *slave,
> > > -			int port, bool enable, int mask)
> > > +			   int port, bool enable, int mask)
> > 
> > not aligned
> 
> it is in the code. It's a diff illusion.
> 
> > 
> > >   void sdw_extract_slave_id(struct sdw_bus *bus,
> > > -			u64 addr, struct sdw_slave_id *id);
> > > +			  u64 addr, struct sdw_slave_id *id);
> > 
> > Not aligned
> 
> it is in the code. It's a diff illusion.
> 
> > >   enum sdw_command_response
> > >   cdns_xfer_msg_defer(struct sdw_bus *bus,
> > > -		struct sdw_msg *msg, struct sdw_defer *defer)
> > > +		    struct sdw_msg *msg, struct sdw_defer *defer)
> > 
> > this one too..
> > 
> > >   static int cdns_port_params(struct sdw_bus *bus,
> > > -		struct sdw_port_params *p_params, unsigned int bank)
> > > +			    struct sdw_port_params *p_params, unsigned int bank)
> > 
> > here as well.. (and giving up on rest)
> 
> Please check for yourself that this is a diff illusion w/ tab space.

-- 
~Vinod
