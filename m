From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 08/14] soundwire: Add Slave status handling
 helpers
Date: Tue, 31 Oct 2017 18:34:12 +0530
Message-ID: <20171031130412.GW3187@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-9-git-send-email-vinod.koul@intel.com>
 <s5h60bbqmkz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2916126727C
 for <alsa-devel@alsa-project.org>; Tue, 31 Oct 2017 14:01:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h60bbqmkz.wl-tiwai@suse.de>
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
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, patches.audio@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, Sagar Dharia <sdharia@codeaurora.org>, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sudheer Papothi <spapothi@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 19, 2017 at 03:44:12PM +0200, Takashi Iwai wrote:
> On Thu, 19 Oct 2017 05:03:24 +0200,
> Vinod Koul wrote:

Sorry looks like I missed replying on this one, my apologies

> > +static struct sdw_slave *sdw_get_slave(struct sdw_bus *bus, int i)
> > +{
> > +	struct sdw_slave *slave;
> > +
> > +	list_for_each_entry(slave, &bus->slaves, node) {
> > +		if (slave->dev_num == i)
> > +			return slave;
> > +	}
> > +
> > +	return NULL;
> 
> Is this performed always in bus_lock, right?
> Better to document it.

Thanks we need to have lock here, fixed

> > +static int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id)
> > +{
> > +
> > +	if ((slave->id.unique_id != id.unique_id) ||
> > +			(slave->id.mfg_id != id.mfg_id) ||
> > +			(slave->id.part_id != id.part_id) ||
> > +			(slave->id.class_id != id.class_id))
> 
> Align indentations.

sure

> > +static int sdw_get_device_num(struct sdw_slave *slave)
> > +{
> > +	bool assigned = false;
> > +	int i;
> > +
> > +	mutex_lock(&slave->bus->bus_lock);
> > +	for (i = 1; i <= SDW_MAX_DEVICES; i++) {
> > +		if (slave->bus->assigned[i] == true)
> > +			continue;
> > +
> > +		slave->bus->assigned[i] = true;
> > +		assigned = true;
> > +
> > +		/*
> > +		 * Do not update dev_num in Slave data structure here,
> > +		 * Update once program dev_num is successful
> > +		 */
> > +		break;
> 
> With the bitmap, it's easier, you can use find_next_zero_bit() :)

yes already done

> > +static int sdw_program_device_num(struct sdw_bus *bus)
> > +{
> > +	u8 buf[SDW_NUM_DEV_ID_REGISTERS] = {0};
> > +	unsigned long long addr;
> 
> Use u64.

yes fixed

> > +	struct sdw_slave *slave;
> > +	struct sdw_slave_id id;
> > +	struct sdw_msg msg;
> > +	bool found = false;
> > +	int ret;
> > +
> > +	/* No Slave, so use raw xfer api */
> > +	sdw_fill_msg(&msg, SDW_SCP_DEVID_0, SDW_NUM_DEV_ID_REGISTERS,
> > +					0, SDW_MSG_FLAG_READ, buf);
> > +
> > +	do {
> > +		ret = sdw_transfer(bus, NULL, &msg);
> > +		if (ret == -ENODATA)
> > +			break;
> > +		if (ret < 0) {
> > +			dev_err(bus->dev, "DEVID read fail:%d\n", ret);
> > +			break;
> 
> So here we break, and the function returns zero.  Is this the expected
> behavior?

nope, thats a bug fixed now

> > +		if (found == false) {
> > +			/* TODO: Park this device in Group 13 */
> > +			dev_err(bus->dev, "Slave Entry not found");
> 
> No break here?  Otherwise...

Thats intentional. We want to still read next device that show up

> 
> > +		}
> > +
> > +	} while (ret == 0);
> 
> ... the outer loop may go endlessly.
> This condition doesn't look effective.

not really. We cant keep reading successfully. At some point all slaves will
ignore and return ENODATA and we exit. Bus errors will also make it exit

BUT given that we have seen stuff i am inclined to add a counter, we cant
have more than 11 device so that's a sane value to use :)

-- 
~Vinod
