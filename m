From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH 06/14] soundwire: Add IO transfer
Date: Fri, 20 Oct 2017 21:18:03 +0530
Message-ID: <20171020154803.GQ30097@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-7-git-send-email-vinod.koul@intel.com>
 <s5hefpzts8j.wl-tiwai@suse.de>
 <20171020053006.GJ30097@localhost>
 <s5ho9p2uwm2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5ho9p2uwm2.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, patches.audio@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, Sagar Dharia <sdharia@codeaurora.org>, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sudheer Papothi <spapothi@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 20, 2017 at 09:06:13AM +0200, Takashi Iwai wrote:
> On Fri, 20 Oct 2017 07:30:06 +0200,
> Vinod Koul wrote:
> > 
> > On Thu, Oct 19, 2017 at 11:13:48AM +0200, Takashi Iwai wrote:
> > > On Thu, 19 Oct 2017 05:03:22 +0200,
> > > Vinod Koul wrote:
> > > > 
> > > > +/**
> > > > + * sdw_transfer: Synchronous transfer message to a SDW Slave device
> > > > + *
> > > > + * @bus: SDW bus
> > > > + * @slave: SDW Slave
> > > > + * @msg: SDW message to be xfered
> > > > + */
> > > > +int sdw_transfer(struct sdw_bus *bus, struct sdw_slave *slave,
> > > > +					struct sdw_msg *msg)
> > > > +{
> > > > +	bool page;
> > > > +	int ret;
> > > > +
> > > > +	mutex_lock(&bus->msg_lock);
> > > > +
> > > > +	page = sdw_get_page(slave, msg);
> > > > +
> > > > +	ret = do_transfer(bus, msg, page);
> > > > +	if (ret != 0 && ret != -ENODATA) {
> > > > +		dev_err(bus->dev, "trf on Slave %d failed:%d\n",
> > > > +				msg->dev_num, ret);
> > > > +		goto error;
> > > > +	}
> > > > +
> > > > +	if (page)
> > > > +		ret = sdw_reset_page(bus, msg->dev_num);
> > > > +
> > > > +error:
> > > > +	mutex_unlock(&bus->msg_lock);
> > > > +
> > > > +	return ret;
> > > 
> > > So the logic here is that when -ENODATA is returned and page is false,
> > > this function should return -ENODATA to the caller,  but when page
> > > is set, it returns 0?
> > 
> > Sorry no. do_transfer can succced (0) or in some case where Slaves didn't
> > care for return error (ENODATA), or other errors.
> > No ENODATA can be error depending on message sent so we dont treat this as
> > failure and let caller decide.
> > 
> > In case of errors (others) we don't need to reset page and we bail out
> 
> Well, the question is the handling of ENODATA.  Whether the function
> returns 0 or -ENODATA depends on page flag.  If page flag is true,
> -ENODATA is cleared.  My question was whether this behavior is
> intended or not.
> 
> If -ENODATA should be returned whenever it gets that from
> do_transfer(), the code has a potential bug there.

Ah right, the return from do_transfer needs to preserved in that case. I
will fix that up, thanks for spotting :)

-- 
~Vinod
