From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 06/14] soundwire: Add IO transfer
Date: Fri, 20 Oct 2017 11:00:06 +0530
Message-ID: <20171020053006.GJ30097@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-7-git-send-email-vinod.koul@intel.com>
 <s5hefpzts8j.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 95CC5266A51
 for <alsa-devel@alsa-project.org>; Fri, 20 Oct 2017 07:25:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hefpzts8j.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, patches.audio@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 19, 2017 at 11:13:48AM +0200, Takashi Iwai wrote:
> On Thu, 19 Oct 2017 05:03:22 +0200,
> Vinod Koul wrote:
> > 
> > +static inline int find_error_code(unsigned int sdw_ret)
> > +{
> > +	switch (sdw_ret) {
> > +	case SDW_CMD_OK:
> > +		return 0;
> > +
> > +	case SDW_CMD_IGNORED:
> > +		return -ENODATA;
> > +
> > +	case SDW_CMD_TIMEOUT:
> > +		return -ETIMEDOUT;
> > +	}
> > +
> > +	return -EIO;
> > +}
> > +
> > +static inline int do_transfer(struct sdw_bus *bus,
> > +			struct sdw_msg *msg, bool page)
> > +{
> > +	int retry = bus->prop.err_threshold;
> > +	int ret, i;
> > +
> > +	for (ret = 0, i = 0; i <= retry; i++) {
> 
> Initializing ret here is a bit messy.  Better to do it outside.

sounds good

> > +		ret = bus->ops->xfer_msg(bus, msg, page);
> > +		ret = find_error_code(ret);
> > +		/* if cmd is ok or ignored return */
> > +		if (ret == 0 || ret == -ENODATA)
> > +			return ret;
> 
> Hmm, it's not good to use the same variable for representing two
> different things.  Either drop the substitution to ret for
> bus->ops->xfer_msg() call, or use another variable to make clear which
> one is for SDW_CMD_* and which one is for -EXXX.  The former should be
> basically an enum.

yes will do, sometimes we should not reuse :)

> > +/**
> > + * sdw_transfer: Synchronous transfer message to a SDW Slave device
> > + *
> > + * @bus: SDW bus
> > + * @slave: SDW Slave
> > + * @msg: SDW message to be xfered
> > + */
> > +int sdw_transfer(struct sdw_bus *bus, struct sdw_slave *slave,
> > +					struct sdw_msg *msg)
> > +{
> > +	bool page;
> > +	int ret;
> > +
> > +	mutex_lock(&bus->msg_lock);
> > +
> > +	page = sdw_get_page(slave, msg);
> > +
> > +	ret = do_transfer(bus, msg, page);
> > +	if (ret != 0 && ret != -ENODATA) {
> > +		dev_err(bus->dev, "trf on Slave %d failed:%d\n",
> > +				msg->dev_num, ret);
> > +		goto error;
> > +	}
> > +
> > +	if (page)
> > +		ret = sdw_reset_page(bus, msg->dev_num);
> > +
> > +error:
> > +	mutex_unlock(&bus->msg_lock);
> > +
> > +	return ret;
> 
> So the logic here is that when -ENODATA is returned and page is false,
> this function should return -ENODATA to the caller,  but when page
> is set, it returns 0?

Sorry no. do_transfer can succced (0) or in some case where Slaves didn't
care for return error (ENODATA), or other errors.
No ENODATA can be error depending on message sent so we dont treat this as
failure and let caller decide.

In case of errors (others) we don't need to reset page and we bail out

> 
> > +static inline int sdw_fill_msg(struct sdw_msg *msg, u16 addr,
> > +				size_t count, u16 dev_num, u8 flags, u8 *buf)
> > +{
> > +	msg->addr = (addr >> SDW_REG_SHIFT(SDW_REGADDR));
> > +	msg->len = count;
> > +	msg->dev_num = dev_num;
> > +	msg->addr_page1 = (addr >> SDW_REG_SHIFT(SDW_SCP_ADDRPAGE1_MASK));
> > +	msg->addr_page2 = (addr >> SDW_REG_SHIFT(SDW_SCP_ADDRPAGE2_MASK));
> > +	msg->flags = flags;
> > +	msg->buf = buf;
> > +	msg->ssp_sync = false;
> > +
> > +	return 0;
> 
> This function can be void.

yup

-- 
~Vinod
