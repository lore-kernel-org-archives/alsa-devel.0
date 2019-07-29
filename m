From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 17/40] soundwire: bus: use
 runtime_pm_get_sync/pm when enabled
Date: Mon, 29 Jul 2019 17:07:39 -0500
Message-ID: <5a16d9e6-0a9c-a0a8-3b11-d046247f3879@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-18-pierre-louis.bossart@linux.intel.com>
 <45a912c5-134b-8642-70ef-8c1060389300@linux.intel.com>
 <20190726190823.GD9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190726190823.GD9224@smile.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, "Rafael J. Wysocki" <rafael@kernel.org>, tiwai@suse.de, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 7/26/19 2:08 PM, Andy Shevchenko wrote:
> On Fri, Jul 26, 2019 at 01:08:57PM -0500, Pierre-Louis Bossart wrote:
>> This thread became unreadable with interleaved top-posting, allow me restate
>> the options and ask PM folks what they think
>>
>> On 7/25/19 6:40 PM, Pierre-Louis Bossart wrote:
>>> Not all platforms support runtime_pm for now, let's use runtime_pm
>>> only when enabled.
> 
> Just a side note below...
> 
>>> -	ret = pm_runtime_get_sync(slave->bus->dev);
>>> -	if (ret < 0)
> 
> Here...
> 
>>> -		return ret;
>>> +	if (pm_runtime_enabled(slave->bus->dev)) {
>>> +		ret = pm_runtime_get_sync(slave->bus->dev);
>>> +		if (ret < 0)
> 
> ...and thus here...
> 
>>> +			return ret;
>>> +	}
>>>    	ret = sdw_transfer(slave->bus, &msg);
>>> -	pm_runtime_put(slave->bus->dev);
>>> +
>>> +	if (pm_runtime_enabled(slave->bus->dev))
>>> +		pm_runtime_put(slave->bus->dev);
>>
>> This is option1: we explicitly test if pm_runtime is enabled before calling
>> _get_sync() and _put()
>>
>> option2 (suggested by Jan Kotas): catch the -EACCESS error code
>>
>>   	ret = pm_runtime_get_sync(slave->bus->dev);
>> -	if (ret < 0)
>> +	if (ret < 0 && ret != -EACCES)
> 
> ...and here, the pm_runtime_put_noidle() call is missed.

yes but in the example you provided, they actually do more work than 
just decrement the device usage counter:

static int
radeonfb_open(struct fb_info *info, int user)
{
	struct radeon_fbdev *rfbdev = info->par;
	struct radeon_device *rdev = rfbdev->rdev;
	int ret = pm_runtime_get_sync(rdev->ddev->dev);
	if (ret < 0 && ret != -EACCES) {
		pm_runtime_mark_last_busy(rdev->ddev->dev);
		pm_runtime_put_autosuspend(rdev->ddev->dev);
		return ret;
	}
	return 0;
}

unless I am missing something pm_runtime_put_noidle() and 
_put_autosuspend() are not equivalent, are they?
