From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 1/3] soundwire: fix style issues
Date: Thu, 4 Apr 2019 14:37:05 -0500
Message-ID: <52a3a4a0-c81c-3daf-78b3-7668b621ecf1@linux.intel.com>
References: <20190404182204.31262-1-pierre-louis.bossart@linux.intel.com>
 <20190404182204.31262-2-pierre-louis.bossart@linux.intel.com>
 <98050a8abfdd9ec015d4de846b276cf046115e3f.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <98050a8abfdd9ec015d4de846b276cf046115e3f.camel@perches.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, jank@cadence.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Thanks for the review Joe,

@@ -458,13 +458,13 @@ static int sdw_assign_device_num(struct sdw_slave 
*slave)

>>   		mutex_unlock(&slave->bus->bus_lock);
>>   		if (dev_num < 0) {
>>   			dev_err(slave->bus->dev, "Get dev_num failed: %d",
>> -								dev_num);
>> +				dev_num);
> You could also add the missing terminating '\n' to these formats like:
>
>   			dev_err(slave->bus->dev, "Get dev_num failed: %d\n",
>
Yes indeed, I just fixed that tools reported, but that is a miss. Will 
fix with a v2 (hopefully with other comments).

-Pierre
