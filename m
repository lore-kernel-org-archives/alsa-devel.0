From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH v4 08/15] soundwire: Add Slave status
 handling helpers
Date: Sun, 3 Dec 2017 22:38:19 +0530
Message-ID: <20171203170818.GO32417@localhost>
References: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
 <1512122177-2889-9-git-send-email-vinod.koul@intel.com>
 <4b464ced-5801-724e-1ec0-bae5b468b4dd@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4b464ced-5801-724e-1ec0-bae5b468b4dd@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 01, 2017 at 05:36:47PM -0600, Pierre-Louis Bossart wrote:

> >+/* called with bus_lock held */
> >+static int sdw_get_device_num(struct sdw_slave *slave)
> >+{
> >+	int bit;
> >+
> >+	bit = find_first_zero_bit(slave->bus->assigned, SDW_MAX_DEVICES);
> >+	if (bit == SDW_MAX_DEVICES) {
> >+		bit = -ENODEV;
> >+		goto err;
> 
> My brain is starting to fry but is this correct? Bit11 seems like a valid
> value. Should it be bit > 15 (assuming bit 12,13,14 are set to avoid using
> groups and master)?

this is correct. You are confusing SDW concept and API return types!
That should be hint for you to start weekend if you didn't do so :D

This API returns max value it was provided (last arg) if it doesn't
find free bit. That's an indication to caller that we ran out of devices
hence ENODEV error!

> >+static int sdw_program_device_num(struct sdw_bus *bus)
> >+{
> >+	u8 buf[SDW_NUM_DEV_ID_REGISTERS] = {0};
> >+	struct sdw_slave *slave, *_s;
> >+	struct sdw_slave_id id;
> >+	struct sdw_msg msg;
> >+	bool found = false;
> >+	int count = 0, ret;
> >+	u64 addr;
> >+
> >+	/* No Slave, so use raw xfer api */
> >+	ret = sdw_fill_msg(&msg, NULL, SDW_SCP_DEVID_0,
> >+			SDW_NUM_DEV_ID_REGISTERS, 0, SDW_MSG_FLAG_READ, buf);
> >+	if (ret < 0)
> >+		return ret;
> >+
> >+	do {
> >+		ret = sdw_transfer(bus, NULL, &msg);
> >+		if (ret == -ENODATA) { /* end of device id reads */
> >+			ret = 0;
> >+			break;
> >+		}
> >+		if (ret < 0) {
> >+			dev_err(bus->dev, "DEVID read fail:%d\n", ret);
> >+			break;
> >+		}
> >+
> >+		/*
> >+		 * Construct the addr and extract. Cast the higher shift
> >+		 * bits to avoid truncation due to size limit.
> >+		 */
> >+		addr = buf[5] | (buf[4] << 8) | (buf[3] << 16) |
> >+			(buf[2] << 24) | ((unsigned long long)buf[1] << 32) |
> >+			((unsigned long long)buf[0] << 40);
> >+
> >+		sdw_extract_slave_id(bus, addr, &id);
> >+
> >+		/* Now compare with entries */
> >+		list_for_each_entry_safe(slave, _s, &bus->slaves, node) {
> >+			if (sdw_compare_devid(slave, id) == 0) {
> >+				found = true;
> >+
> >+				/*
> >+				 * Assign a new dev_num to this Slave and
> >+				 * not mark it present. It will be marked
> >+				 * present after it reports ATTACHED on new
> >+				 * dev_num
> >+				 */
> >+				ret = sdw_assign_device_num(slave);
> >+				if (ret) {
> >+					dev_err(slave->bus->dev,
> >+						"Assign dev_num failed:%d",
> >+						ret);
> >+					return ret;
> >+				}
> >+
> >+				break;
> >+			}
> >+		}
> >+
> >+		if (found == false) {
> >+			/* TODO: Park this device in Group 13 */
> >+			dev_err(bus->dev, "Slave Entry not found");
> >+		}
> >+
> >+		count++;
> >+
> >+	} while (ret == 0 && count < (SDW_MAX_DEVICES * 2));
> 
> explain that the last condition is intentional - this is not a bug -, some
> devices can drop off during enumeration and rejoin so might be counted
> twice.

ok will add

-- 
~Vinod
