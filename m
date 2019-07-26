From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 01/40] soundwire: add debugfs support
Date: Fri, 26 Jul 2019 10:29:13 -0500
Message-ID: <1c9448c3-2a98-e5c3-fadf-910e361187ab@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-2-pierre-louis.bossart@linux.intel.com>
 <20190726140411.GA8767@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190726140411.GA8767@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


>> diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
>> new file mode 100644
>> index 000000000000..8d86e100516e
>> --- /dev/null
>> +++ b/drivers/soundwire/debugfs.c
>> @@ -0,0 +1,156 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> 
> No, for debugfs-specific code, that dual license makes no sense, right?
> Don't cargo-cult SPDX identifiers please.

It's a miss, I used EXPORT_GPL and missed this line, will fix.

> 
>> +// Copyright(c) 2017-19 Intel Corporation.
> 
> Spell the year out fully unless you want lawyers knocking on your door :)

haha, will fix.

> 
>> +
>> +#include <linux/device.h>
>> +#include <linux/debugfs.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/slab.h>
>> +#include <linux/soundwire/sdw.h>
>> +#include <linux/soundwire/sdw_registers.h>
>> +#include "bus.h"
>> +
>> +#ifdef CONFIG_DEBUG_FS
>> +struct dentry *sdw_debugfs_root;
>> +#endif
> 
> This whole file is not built if that option is not enabled, so why the
> #ifdef?

Ah, will look into this, thanks!
