From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [RFC PATCH 01/40] soundwire: add debugfs support
Date: Fri, 26 Jul 2019 11:22:10 +0200
Message-ID: <35a3936d-12d5-d301-2c8e-9e90163dd86e@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-2-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 2019-07-26 01:39, Pierre-Louis Bossart wrote:
> +static ssize_t sdw_slave_reg_read(struct file *file, char __user *user_buf,
> +				  size_t count, loff_t *ppos)
> +{
> +	struct sdw_slave *slave = file->private_data;
> +	unsigned int reg;
> +	char *buf;
> +	ssize_t ret;
> +	int i, j;
> +
> +	buf = kzalloc(RD_BUF, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
> +	ret += scnprintf(buf + ret, RD_BUF - ret, "\nDP0\n");
> +
> +	for (i = 0; i < 6; i++)
> +		ret += sdw_sprintf(slave, buf, ret, i);

In most cases explicit reg macro is used, here it's implicit. Align with 
the rest?

> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
> +	ret += sdw_sprintf(slave, buf, ret, SDW_DP0_CHANNELEN);
> +	for (i = SDW_DP0_SAMPLECTRL1; i <= SDW_DP0_LANECTRL; i++)
> +		ret += sdw_sprintf(slave, buf, ret, i);
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
> +	ret += sdw_sprintf(slave, buf, ret,
> +			SDW_DP0_CHANNELEN + SDW_BANK1_OFFSET);
> +	for (i = SDW_DP0_SAMPLECTRL1 + SDW_BANK1_OFFSET;
> +			i <= SDW_DP0_LANECTRL + SDW_BANK1_OFFSET; i++)
> +		ret += sdw_sprintf(slave, buf, ret, i);

I'd advice to revisit macros declarations first.
There should be SDW_DP0_SAMPLECTRL1_B(bank) declared. In general all 
macros for SDW should be "bank-less" (name wise). Additionally, 
SDW_BANK_OFFSET(bank) could be provided for convenience i.e.: return 0 
for bank0.
Yeah, there might be some speed loss in terms of operation count but in 
most cases it is negligible.

Would simplify this entire reg dump greatly.
const array on top with {0, 1} elements and replacing explicit "bank0/1" 
strings with "bank%d" gets code size reduced while not losing on 
readability.

> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret, "\nSCP\n");
> +	for (i = SDW_SCP_INT1; i <= SDW_SCP_BANKDELAY; i++)
> +		ret += sdw_sprintf(slave, buf, ret, i);
> +	for (i = SDW_SCP_DEVID_0; i <= SDW_SCP_DEVID_5; i++)
> +		ret += sdw_sprintf(slave, buf, ret, i);
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
> +	ret += sdw_sprintf(slave, buf, ret, SDW_SCP_FRAMECTRL_B0);
> +	ret += sdw_sprintf(slave, buf, ret, SDW_SCP_NEXTFRAME_B0);
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
> +	ret += sdw_sprintf(slave, buf, ret, SDW_SCP_FRAMECTRL_B1);
> +	ret += sdw_sprintf(slave, buf, ret, SDW_SCP_NEXTFRAME_B1);
> +
> +	for (i = 1; i < 14; i++) {

Explicit valid slave addresses would be preferred.

> +		ret += scnprintf(buf + ret, RD_BUF - ret, "\nDP%d\n", i);
> +		reg = SDW_DPN_INT(i);
> +		for (j = 0; j < 6; j++)
> +			ret += sdw_sprintf(slave, buf, ret, reg + j);
> +
> +		ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
> +		reg = SDW_DPN_CHANNELEN_B0(i);
> +		for (j = 0; j < 9; j++)
> +			ret += sdw_sprintf(slave, buf, ret, reg + j);
> +
> +		ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
> +		reg = SDW_DPN_CHANNELEN_B1(i);
> +		for (j = 0; j < 9; j++)
> +			ret += sdw_sprintf(slave, buf, ret, reg + j);

Some sort of MAX_CHANNELS would be nice here too.

> +	}
> +
> +	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
> +	kfree(buf);
> +
> +	return ret;
> +}
> +
> +static const struct file_operations sdw_slave_reg_fops = {
> +	.open = simple_open,
> +	.read = sdw_slave_reg_read,
> +	.llseek = default_llseek,
> +};
> +
> +struct dentry *sdw_slave_debugfs_init(struct sdw_slave *slave)
> +{
> +	struct dentry *master;
> +	struct dentry *d;
> +	char name[32];
> +
> +	master = slave->bus->debugfs;
> +
> +	/* create the debugfs slave-name */
> +	snprintf(name, sizeof(name), "%s", dev_name(&slave->dev));
> +	d = debugfs_create_dir(name, master);
> +
> +	debugfs_create_file("registers", 0400, d, slave, &sdw_slave_reg_fops);

Pointer returned by _create_file gets completely ignored here. At least 
dbg msg would be nice if it fails.

> +	return d;
> +}
> +
