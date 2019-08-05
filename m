From: Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 23/40] soundwire: stream: fix disable
 sequence
Date: Mon, 5 Aug 2019 22:02:33 +0530
Message-ID: <20190805163233.GA24889@buildpc-HP-Z230>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-24-pierre-louis.bossart@linux.intel.com>
 <20190805095620.GD22437@buildpc-HP-Z230>
 <12799e97-d6e3-5027-a409-0fe37dba86fd@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <12799e97-d6e3-5027-a409-0fe37dba86fd@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 05, 2019 at 10:33:25AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 8/5/19 4:56 AM, Sanyog Kale wrote:
> > On Thu, Jul 25, 2019 at 06:40:15PM -0500, Pierre-Louis Bossart wrote:
> > > When we disable the stream and then call hw_free, two bank switches
> > > will be handled and as a result we re-enable the stream on hw_free.
> > > 
> > 
> > I didnt quite get why there will be two bank switches as part of disable flow
> > which leads to enabling of stream?
> 
> You have two bank switches, one to stop streaming and on in de-prepare. It's
> symmetrical with the start sequence, where we do a bank switch to prepare
> and another to enable.

Got it. I misunderstood it that two bank switches are performed as part of
disable_stream.

> 
> Let's assume we are using bank0 when streaming.
> 
> Before the first bank switch, the channel_enable is set to false in the
> alternate bank1. When the bank switch happens, bank1 become active and the
> streaming stops. But bank0 registers have not been modified so when we do
> the second bank switch in de-prepare we make bank0 active, and the ch_enable
> bits are still set so streaming will restart... When we stop streaming, we
> need to make sure the ch_enable bits are cleared in the two banks.

This is clear. Even though the channels remains enabled, i believe there
won't be any data pushed on lines as stream will be closed.

Regarding mirroring approach, I assume after bank switch we will take
snapshot of active bank and program same in inactive bank.

> 
> 
> > 
> > > Make sure the stream is disabled on both banks.
> > > 
> > > TODO: we need to completely revisit all this and make sure we have a
> > > mirroring mechanism between current and alternate banks.
> > > 
> > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > ---
> > >   drivers/soundwire/stream.c | 19 ++++++++++++++++++-
> > >   1 file changed, 18 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> > > index 53f5e790fcd7..75b9ad1fb1a6 100644
> > > --- a/drivers/soundwire/stream.c
> > > +++ b/drivers/soundwire/stream.c
> > > @@ -1637,7 +1637,24 @@ static int _sdw_disable_stream(struct sdw_stream_runtime *stream)
> > >   		}
> > >   	}
> > > -	return do_bank_switch(stream);
> > > +	ret = do_bank_switch(stream);
> > > +	if (ret < 0) {
> > > +		dev_err(bus->dev, "Bank switch failed: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	/* make sure alternate bank (previous current) is also disabled */
> > > +	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
> > > +		bus = m_rt->bus;
> > > +		/* Disable port(s) */
> > > +		ret = sdw_enable_disable_ports(m_rt, false);
> > > +		if (ret < 0) {
> > > +			dev_err(bus->dev, "Disable port(s) failed: %d\n", ret);
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > >   }
> > >   /**
> > > -- 
> > > 2.20.1
> > > 
> > 

-- 
