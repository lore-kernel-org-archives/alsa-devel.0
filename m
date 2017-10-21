From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 06/14] soundwire: Add IO transfer
Date: Sat, 21 Oct 2017 17:10:28 +0530
Message-ID: <20171021114028.GH30097@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-7-git-send-email-vinod.koul@intel.com>
 <20171021092908.yevlinnkiv5lzus3@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171021092908.yevlinnkiv5lzus3@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 21, 2017 at 10:29:08AM +0100, Mark Brown wrote:
> On Thu, Oct 19, 2017 at 08:33:22AM +0530, Vinod Koul wrote:
> 
> > +static bool sdw_get_page(struct sdw_slave *slave, struct sdw_msg *msg)
> > +{
> > +	bool page = false, paging_support = false;
> > +
> > +	if (slave && slave->prop.paging_support)
> > +		paging_support = true;
> > +
> > +	/*
> > +	 * Programme SCP page addr for:
> > +	 * 1. addr_page1 and addr_page2 contains non-zero values.
> > +	 * 2. Paging supported by Slave.
> > +	 */
> > +	switch (msg->dev_num) {
> > +	case SDW_ENUM_DEV_NUM:
> > +	case SDW_BROADCAST_DEV_NUM:
> > +		break;
> > +
> > +	default:
> > +		if (paging_support && ((msg->addr_page1) || (msg->addr_page2)))
> > +			page = true;
> > +	}
> > +
> > +	return page;
> 
> So if a page was specified but we don't have paging support we silently
> just write to the base pagee?

yeah we should log this, will add

> > +int sdw_transfer(struct sdw_bus *bus, struct sdw_slave *slave,
> > +					struct sdw_msg *msg)
> > +{
> > +	bool page;
> > +	int ret;
> > +
> > +	mutex_lock(&bus->msg_lock);
> > +
> > +	page = sdw_get_page(slave, msg);
> 
> get_page() doesn't interact with the hardware at all so it could be
> outside the lock.

right

> 
> > +	ret = do_transfer(bus, msg, page);
> > +	if (ret != 0 && ret != -ENODATA) {
> > +		dev_err(bus->dev, "trf on Slave %d failed:%d\n",
> > +				msg->dev_num, ret);
> > +		goto error;
> > +	}
> > +
> > +	if (page)
> > +		ret = sdw_reset_page(bus, msg->dev_num);
> 
> Wouldn't it be safer to reset the page even on error so future messages
> go to the right place if the paging bit of the failed operation worked?

You have a valid point, let me check that part.

> > +int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
> > +{
> > +	struct sdw_msg msg;
> > +	int ret;
> > +
> > +	pm_runtime_get_sync(slave->bus->dev);
> 
> No error check.

will add

> > +	pm_runtime_get_sync(slave->bus->dev);
> > +
> > +	sdw_fill_msg(&msg, addr, count, slave->dev_num, SDW_MSG_FLAG_WRITE, val);
> 
> The device doesn't need to be powered up for us to fill in the data
> structures we're going to use.

Yes I can move it down a bit before do_transfer()

-- 
~Vinod
