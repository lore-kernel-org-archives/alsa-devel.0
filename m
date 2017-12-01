From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v4 08/15] soundwire: Add Slave status
 handling helpers
Date: Fri, 1 Dec 2017 17:36:47 -0600
Message-ID: <4b464ced-5801-724e-1ec0-bae5b468b4dd@linux.intel.com>
References: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
 <1512122177-2889-9-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512122177-2889-9-git-send-email-vinod.koul@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On 12/1/17 3:56 AM, Vinod Koul wrote:
> From: Sanyog Kale <sanyog.r.kale@intel.com>
> 
> SoundWire Slaves report status to bus. Add helpers to handle
> the status changes.
> 
> Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
> Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>   drivers/soundwire/bus.c       | 202 ++++++++++++++++++++++++++++++++++++++++++
>   drivers/soundwire/bus.h       |  14 +++
>   include/linux/soundwire/sdw.h |   1 +
>   3 files changed, 217 insertions(+)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 2f108f162905..09126ddd3cdd 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -372,6 +372,93 @@ int sdw_write(struct sdw_slave *slave, u32 addr, u8 value)
>   }
>   EXPORT_SYMBOL(sdw_write);
>   
> +/*
> + * SDW alert handling
> + */
> +
> +/* called with bus_lock held */
> +static struct sdw_slave *sdw_get_slave(struct sdw_bus *bus, int i)
> +{
> +	struct sdw_slave *slave = NULL;
> +
> +	list_for_each_entry(slave, &bus->slaves, node) {
> +		if (slave->dev_num == i)
> +			return slave;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id)
> +{
> +
> +	if ((slave->id.unique_id != id.unique_id) ||
> +	    (slave->id.mfg_id != id.mfg_id) ||
> +	    (slave->id.part_id != id.part_id) ||
> +	    (slave->id.class_id != id.class_id))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +/* called with bus_lock held */
> +static int sdw_get_device_num(struct sdw_slave *slave)
> +{
> +	int bit;
> +
> +	bit = find_first_zero_bit(slave->bus->assigned, SDW_MAX_DEVICES);
> +	if (bit == SDW_MAX_DEVICES) {
> +		bit = -ENODEV;
> +		goto err;

My brain is starting to fry but is this correct? Bit11 seems like a 
valid value. Should it be bit > 15 (assuming bit 12,13,14 are set to 
avoid using groups and master)?


> +	}
> +
> +	/*
> +	 * Do not update dev_num in Slave data structure here,
> +	 * Update once program dev_num is successful
> +	 */
> +	set_bit(bit, slave->bus->assigned);
> +
> +err:
> +	return bit;
> +}
> +
> +static int sdw_assign_device_num(struct sdw_slave *slave)
> +{
> +	int ret, dev_num;
> +
> +	/* check first if device number is assigned, if so reuse that */
> +	if (!slave->dev_num) {
> +		mutex_lock(&slave->bus->bus_lock);
> +		dev_num = sdw_get_device_num(slave);
> +		mutex_unlock(&slave->bus->bus_lock);
> +		if (dev_num < 0) {
> +			dev_err(slave->bus->dev, "Get dev_num failed: %d",
> +								dev_num);
> +			return dev_num;
> +		}
> +	} else {
> +		dev_info(slave->bus->dev,
> +				"Slave already registered dev_num:%d",
> +				slave->dev_num);
> +
> +		/* Clear the slave->dev_num to transfer message on device 0 */
> +		dev_num = slave->dev_num;
> +		slave->dev_num = 0;
> +
> +	}
> +
> +	ret = sdw_write(slave, SDW_SCP_DEVNUMBER, dev_num);
> +	if (ret < 0) {
> +		dev_err(&slave->dev, "Program device_num failed: %d", ret);
> +		return ret;
> +	}
> +
> +	/* After xfer of msg, restore dev_num */
> +	slave->dev_num = dev_num;
> +
> +	return 0;
> +}
> +
>   void sdw_extract_slave_id(struct sdw_bus *bus,
>   			u64 addr, struct sdw_slave_id *id)
>   {
> @@ -400,3 +487,118 @@ void sdw_extract_slave_id(struct sdw_bus *bus,
>   				id->unique_id, id->sdw_version);
>   
>   }
> +
> +static int sdw_program_device_num(struct sdw_bus *bus)
> +{
> +	u8 buf[SDW_NUM_DEV_ID_REGISTERS] = {0};
> +	struct sdw_slave *slave, *_s;
> +	struct sdw_slave_id id;
> +	struct sdw_msg msg;
> +	bool found = false;
> +	int count = 0, ret;
> +	u64 addr;
> +
> +	/* No Slave, so use raw xfer api */
> +	ret = sdw_fill_msg(&msg, NULL, SDW_SCP_DEVID_0,
> +			SDW_NUM_DEV_ID_REGISTERS, 0, SDW_MSG_FLAG_READ, buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	do {
> +		ret = sdw_transfer(bus, NULL, &msg);
> +		if (ret == -ENODATA) { /* end of device id reads */
> +			ret = 0;
> +			break;
> +		}
> +		if (ret < 0) {
> +			dev_err(bus->dev, "DEVID read fail:%d\n", ret);
> +			break;
> +		}
> +
> +		/*
> +		 * Construct the addr and extract. Cast the higher shift
> +		 * bits to avoid truncation due to size limit.
> +		 */
> +		addr = buf[5] | (buf[4] << 8) | (buf[3] << 16) |
> +			(buf[2] << 24) | ((unsigned long long)buf[1] << 32) |
> +			((unsigned long long)buf[0] << 40);
> +
> +		sdw_extract_slave_id(bus, addr, &id);
> +
> +		/* Now compare with entries */
> +		list_for_each_entry_safe(slave, _s, &bus->slaves, node) {
> +			if (sdw_compare_devid(slave, id) == 0) {
> +				found = true;
> +
> +				/*
> +				 * Assign a new dev_num to this Slave and
> +				 * not mark it present. It will be marked
> +				 * present after it reports ATTACHED on new
> +				 * dev_num
> +				 */
> +				ret = sdw_assign_device_num(slave);
> +				if (ret) {
> +					dev_err(slave->bus->dev,
> +						"Assign dev_num failed:%d",
> +						ret);
> +					return ret;
> +				}
> +
> +				break;
> +			}
> +		}
> +
> +		if (found == false) {
> +			/* TODO: Park this device in Group 13 */
> +			dev_err(bus->dev, "Slave Entry not found");
> +		}
> +
> +		count++;
> +
> +	} while (ret == 0 && count < (SDW_MAX_DEVICES * 2));

explain that the last condition is intentional - this is not a bug -, 
some devices can drop off during enumeration and rejoin so might be 
counted twice.

> +
> +	return ret;
> +}
> +
> +static void sdw_modify_slave_status(struct sdw_slave *slave,
> +				enum sdw_slave_status status)
> +{
> +	mutex_lock(&slave->bus->bus_lock);
> +	slave->status = status;
> +	mutex_unlock(&slave->bus->bus_lock);
> +}
> +
> +static int sdw_initialize_slave(struct sdw_slave *slave)
> +{
> +	struct sdw_slave_prop *prop = &slave->prop;
> +	int ret;
> +	u8 val;
> +
> +	/* Set bus clash and parity interrupt mask */
> +	val = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
> +
> +	/* Enable SCP interrupts */
> +	ret = sdw_update(slave, SDW_SCP_INTMASK1, val, val);
> +	if (ret < 0) {
> +		dev_err(slave->bus->dev,
> +				"SDW_SCP_INTMASK1 write failed:%d", ret);
> +		return ret;
> +	}
> +
> +	/* No need to continue if DP0 is not present */
> +	if (!slave->prop.dp0_prop)
> +		return 0;
> +
> +	/* Enable DP0 interrupts */
> +	val = prop->dp0_prop->device_interrupts;
> +	val |= SDW_DP0_INT_PORT_READY | SDW_DP0_INT_BRA_FAILURE;
> +
> +	ret = sdw_update(slave, SDW_DP0_INTMASK, val, val);
> +	if (ret < 0) {
> +		dev_err(slave->bus->dev,
> +				"SDW_DP0_INTMASK read failed:%d", ret);
> +		return val;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index bde5f840ca96..b491e86f2c4c 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -53,4 +53,18 @@ int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_slave *slave,
>   int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
>   		u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf);
>   
> +/* Read-Modify-Write Slave register */
> +static inline int
> +sdw_update(struct sdw_slave *slave, u32 addr, u8 mask, u8 val)
> +{
> +	int tmp;
> +
> +	tmp = sdw_read(slave, addr);
> +	if (tmp < 0)
> +		return tmp;
> +
> +	tmp = (tmp & ~mask) | val;
> +	return sdw_write(slave, addr, tmp);
> +}
> +
>   #endif /* __SDW_BUS_H */
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index d3337b5b882b..09619d042909 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -15,6 +15,7 @@ struct sdw_slave;
>   /* SDW Enumeration Device Number */
>   #define SDW_ENUM_DEV_NUM		0
>   
> +#define SDW_NUM_DEV_ID_REGISTERS	6
>   #define SDW_MAX_DEVICES			11
>   
>   /**
> 
