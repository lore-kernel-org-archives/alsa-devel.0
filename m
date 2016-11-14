From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [RFC 09/14] SoundWire: Add support to handle Slave status change
Date: Mon, 14 Nov 2016 16:08:05 +0000
Message-ID: <20161114160805.GO1575@localhost.localdomain>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
 <1477053673-16021-10-git-send-email-hardik.t.shah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477053673-16021-10-git-send-email-hardik.t.shah@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hardik Shah <hardik.t.shah@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 21, 2016 at 06:11:07PM +0530, Hardik Shah wrote:
> This patch adds the support for updating the Slave status to bus driver.
> Master driver updates Slave status change to the bus driver. Bus driver
> takes appropriate action on Slave status change like.
> 
> 	1. Registering new device if new Slave got enumerated on bus.
> 	2. Assigning the device number to the Slave device
> 	3. Marking Slave as un-attached if Slave got detached from bus.
> 	4. Handling Slave alerts.
> 
> Signed-off-by: Hardik Shah <hardik.t.shah@intel.com>
> Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/sdw/sdw.c      | 1074 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  sound/sdw/sdw_priv.h |   66 ++++
>  2 files changed, 1140 insertions(+)
> 
<snip>
> +static int sdw_slv_register(struct sdw_master *mstr)
> +{
> +	int ret, i;
> +	struct sdw_msg msg;
> +	u8 buf[SDW_NUM_DEV_ID_REGISTERS];
> +	struct sdw_slave *sdw_slave;
> +	int dev_num = -1;
> +	bool found = false;
> +
> +	/* Create message to read the 6 dev_id registers */
> +	sdw_create_rd_msg(&msg, 0, SDW_SCP_DEVID_0, SDW_NUM_DEV_ID_REGISTERS,
> +								buf, 0x0);
> +
> +	/*
> +	 * Multiple Slaves may report an Attached_OK status as Device0.
> +	 * Since the enumeration relies on a hardware arbitration and is
> +	 * done one Slave at a time, a loop needs to run until all Slaves
> +	 * have been assigned a non-zero DeviceNumber. The loop exits when
> +	 * the reads from Device0 devID registers are no longer successful,
> +	 * i.e. there is no Slave left to enumerate
> +	 */
> +	while ((ret = (snd_sdw_slave_transfer(mstr, &msg, SDW_NUM_OF_MSG1_XFRD))
> +					== SDW_NUM_OF_MSG1_XFRD)) {
> +
> +		/*
> +		 * Find is Slave is re-enumerating, and was already
> +		 * registered earlier.
> +		 */
> +		found = sdw_find_slv(mstr, &msg, &dev_num);
> +
> +		/*
> +		 * Reprogram the Slave device number if its getting
> +		 * re-enumerated. If that fails we continue finding new
> +		 * slaves, we flag error but don't stop since there may be
> +		 * new Slaves trying to get enumerated.
> +		 */
> +		if (found) {
> +			ret = sdw_program_dev_num(mstr, dev_num);
> +			if (ret < 0)
> +				dev_err(&mstr->dev, "Re-registering slave failed ret = %d", ret);
> +
> +			continue;
> +
> +		}
> +
> +		/*
> +		 * Find the free device_number for the new Slave getting
> +		 * enumerated 1st time.
> +		 */
> +		dev_num = sdw_find_free_dev_num(mstr, &msg);
> +		if (dev_num < 0) {
> +			dev_err(&mstr->dev, "Failed to find free dev_num ret = %d\n", ret);
> +			goto dev_num_assign_fail;
> +		}
> +
> +		/*
> +		 * Allocate and initialize the Slave device on first
> +		 * enumeration
> +		 */
> +		sdw_slave = kzalloc(sizeof(*sdw_slave), GFP_KERNEL);
> +		if (!sdw_slave) {
> +			ret = -ENOMEM;
> +			goto mem_alloc_failed;
> +		}
> +
> +		/*
> +		 * Initialize the allocated Slave device, set bus type and
> +		 * device type to SoundWire.
> +		 */
> +		sdw_slave->mstr = mstr;
> +		sdw_slave->dev.parent = &sdw_slave->mstr->dev;
> +		sdw_slave->dev.bus = &sdw_bus_type;
> +		sdw_slave->dev.type = &sdw_slv_type;
> +		sdw_slave->priv.addr = &mstr->sdw_addr[dev_num];
> +		sdw_slave->priv.addr->slave = sdw_slave;
> +
> +		for (i = 0; i < SDW_NUM_DEV_ID_REGISTERS; i++)
> +			sdw_slave->priv.dev_id[i] = msg.buf[i];
> +
> +		dev_dbg(&mstr->dev, "SDW slave slave id found with values\n");
> +		dev_dbg(&mstr->dev, "dev_id0 to dev_id5: %x:%x:%x:%x:%x:%x\n",
> +			msg.buf[0], msg.buf[1], msg.buf[2],
> +			msg.buf[3], msg.buf[4], msg.buf[5]);
> +		dev_dbg(&mstr->dev, "Dev number assigned is %x\n", dev_num);
> +
> +		/*
> +		 * Set the Slave device name, its based on the dev_id and
> +		 * to bus which it is attached.
> +		 */
> +		dev_set_name(&sdw_slave->dev, "sdw-slave%d-%02x:%02x:%02x:%02x:%02x:%02x",
> +			sdw_master_get_id(mstr),
> +			sdw_slave->priv.dev_id[0],
> +			sdw_slave->priv.dev_id[1],
> +			sdw_slave->priv.dev_id[2],
> +			sdw_slave->priv.dev_id[3],
> +			sdw_slave->priv.dev_id[4],
> +			sdw_slave->priv.dev_id[5]);
> +
> +		/*
> +		 * Set name based on dev_id. This will be used in match
> +		 * function to bind the device and driver.
> +		 */
> +		sprintf(sdw_slave->priv.name, "%02x:%02x:%02x:%02x:%02x:%02x",
> +				sdw_slave->priv.dev_id[0],
> +				sdw_slave->priv.dev_id[1],
> +				sdw_slave->priv.dev_id[2],
> +				sdw_slave->priv.dev_id[3],
> +				sdw_slave->priv.dev_id[4],
> +				sdw_slave->priv.dev_id[5]);
> +		ret = device_register(&sdw_slave->dev);
> +		if (ret) {
> +			dev_err(&mstr->dev, "Register slave failed ret = %d\n", ret);
> +			goto reg_slv_failed;
> +		}

There are some issues with this, as the slave driver only probes
when the device actually shows up on the bus. However often
(especially in embedded contexts) some things may need to be
done to enable the slave. For example it may be held in reset or
its power supplies switched off until they are need. As such it
generally helps if the device probe can be called before it shows
up on the bus, the device probe can then do the necessary actions
to enable the device at which point it will show up on the bus.

Thanks,
Charles
