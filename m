From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 01/40] soundwire: add debugfs support
Date: Fri, 26 Jul 2019 08:57:29 -0500
Message-ID: <1e0c8b9c-8e02-2735-df2d-7f82bdbb74a8@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-2-pierre-louis.bossart@linux.intel.com>
 <35a3936d-12d5-d301-2c8e-9e90163dd86e@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <35a3936d-12d5-d301-2c8e-9e90163dd86e@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Thanks for the feedback Cezary.

>> +static ssize_t sdw_slave_reg_read(struct file *file, char __user 
>> *user_buf,
>> +                  size_t count, loff_t *ppos)
>> +{
>> +    struct sdw_slave *slave = file->private_data;
>> +    unsigned int reg;
>> +    char *buf;
>> +    ssize_t ret;
>> +    int i, j;
>> +
>> +    buf = kzalloc(RD_BUF, GFP_KERNEL);
>> +    if (!buf)
>> +        return -ENOMEM;
>> +
>> +    ret = scnprintf(buf, RD_BUF, "Register  Value\n");
>> +    ret += scnprintf(buf + ret, RD_BUF - ret, "\nDP0\n");
>> +
>> +    for (i = 0; i < 6; i++)
>> +        ret += sdw_sprintf(slave, buf, ret, i);
> 
> In most cases explicit reg macro is used, here it's implicit. Align with 
> the rest?

I don't see what you are referring to, or I need more coffee.
we use this function sdw_printf in a number of places. Or are you 
referring to the magic value 6? That should indeed be a macro.

>> +
>> +    ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
>> +    ret += sdw_sprintf(slave, buf, ret, SDW_DP0_CHANNELEN);
>> +    for (i = SDW_DP0_SAMPLECTRL1; i <= SDW_DP0_LANECTRL; i++)
>> +        ret += sdw_sprintf(slave, buf, ret, i);
>> +
>> +    ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
>> +    ret += sdw_sprintf(slave, buf, ret,
>> +            SDW_DP0_CHANNELEN + SDW_BANK1_OFFSET);
>> +    for (i = SDW_DP0_SAMPLECTRL1 + SDW_BANK1_OFFSET;
>> +            i <= SDW_DP0_LANECTRL + SDW_BANK1_OFFSET; i++)
>> +        ret += sdw_sprintf(slave, buf, ret, i);
> 
> I'd advice to revisit macros declarations first.
> There should be SDW_DP0_SAMPLECTRL1_B(bank) declared. In general all 
> macros for SDW should be "bank-less" (name wise). Additionally, 
> SDW_BANK_OFFSET(bank) could be provided for convenience i.e.: return 0 
> for bank0.
> Yeah, there might be some speed loss in terms of operation count but in 
> most cases it is negligible.
> 
> Would simplify this entire reg dump greatly.
> const array on top with {0, 1} elements and replacing explicit "bank0/1" 
> strings with "bank%d" gets code size reduced while not losing on 
> readability.

This could require a lot of changes in other parts of the code, and I 
don't want to do this just for debugfs. It's valid point that maybe the 
code can be simplified, but the changes are an across-the-board change 
to be done when we don't add new functionality. I'll keep this on the 
todo list.

> 
>> +
>> +    ret += scnprintf(buf + ret, RD_BUF - ret, "\nSCP\n");
>> +    for (i = SDW_SCP_INT1; i <= SDW_SCP_BANKDELAY; i++)
>> +        ret += sdw_sprintf(slave, buf, ret, i);
>> +    for (i = SDW_SCP_DEVID_0; i <= SDW_SCP_DEVID_5; i++)
>> +        ret += sdw_sprintf(slave, buf, ret, i);
>> +
>> +    ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
>> +    ret += sdw_sprintf(slave, buf, ret, SDW_SCP_FRAMECTRL_B0);
>> +    ret += sdw_sprintf(slave, buf, ret, SDW_SCP_NEXTFRAME_B0);
>> +
>> +    ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
>> +    ret += sdw_sprintf(slave, buf, ret, SDW_SCP_FRAMECTRL_B1);
>> +    ret += sdw_sprintf(slave, buf, ret, SDW_SCP_NEXTFRAME_B1);
>> +
>> +    for (i = 1; i < 14; i++) {
> 
> Explicit valid slave addresses would be preferred.

no, these are ports. we should use a macro instead of the magic 14 but 
it's fine to try and read all ports. As I explained it's a good way to 
figure out how many ports the Slave device supports even in the absence 
of documentation. This also helps figure out if the DisCo properties 
make sense.

> 
>> +        ret += scnprintf(buf + ret, RD_BUF - ret, "\nDP%d\n", i);
>> +        reg = SDW_DPN_INT(i);
>> +        for (j = 0; j < 6; j++)
>> +            ret += sdw_sprintf(slave, buf, ret, reg + j);
>> +
>> +        ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
>> +        reg = SDW_DPN_CHANNELEN_B0(i);
>> +        for (j = 0; j < 9; j++)
>> +            ret += sdw_sprintf(slave, buf, ret, reg + j);
>> +
>> +        ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
>> +        reg = SDW_DPN_CHANNELEN_B1(i);
>> +        for (j = 0; j < 9; j++)
>> +            ret += sdw_sprintf(slave, buf, ret, reg + j);
> 
> Some sort of MAX_CHANNELS would be nice here too.

Yes, need to use macros indeed.

>> +struct dentry *sdw_slave_debugfs_init(struct sdw_slave *slave)
>> +{
>> +    struct dentry *master;
>> +    struct dentry *d;
>> +    char name[32];
>> +
>> +    master = slave->bus->debugfs;
>> +
>> +    /* create the debugfs slave-name */
>> +    snprintf(name, sizeof(name), "%s", dev_name(&slave->dev));
>> +    d = debugfs_create_dir(name, master);
>> +
>> +    debugfs_create_file("registers", 0400, d, slave, 
>> &sdw_slave_reg_fops);
> 
> Pointer returned by _create_file gets completely ignored here. At least 
> dbg msg would be nice if it fails.
> 
>> +    return d;

I understood that Greg KH doesn't want us to depend on the result of 
debugfs calls, but a dev_dbg is likely ok.
