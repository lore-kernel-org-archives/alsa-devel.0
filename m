From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 5/7] soundwire: add debugfs support
Date: Mon, 6 May 2019 11:54:11 -0500
Message-ID: <f1b632e7-e62d-bbd4-e160-36009ee57249@linux.intel.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-6-pierre-louis.bossart@linux.intel.com>
 <20190504070301.GD9770@kroah.com>
 <a9e1c3d2-fe29-1683-9253-b66034c62010@linux.intel.com>
 <20190506163810.GK3845@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190506163810.GK3845@vkoul-mobl.Dlink>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 5/6/19 11:38 AM, Vinod Koul wrote:
> On 06-05-19, 09:48, Pierre-Louis Bossart wrote:
> 
>>>> +struct dentry *sdw_bus_debugfs_get_root(struct sdw_bus_debugfs *d)
>>>> +{
>>>> +	if (d)
>>>> +		return d->fs;
>>>> +	return NULL;
>>>> +}
>>>> +EXPORT_SYMBOL(sdw_bus_debugfs_get_root);
>>>
>>> _GPL()?
>>
>> Oops, that's a big miss. will fix, thanks for spotting this.
> 
> Not really. The Soundwire code is dual licensed. Many of the soundwire
> symbols are indeed exported as EXPORT_SYMBOL. But I agree this one is
> 'linux' specific so can be made _GPL.
> 
> Pierre, does Intel still care about this being dual licensed or not?

Debugfs was never in scope for the dual-licensed parts, we've already 
agreed for SOF to move to _GPL.

> 
>>
>>>
>>> But why is this exported at all?  No one calls this function.
>>
>> I will have to check.
> 
> It is used by codec driver which are not upstream yet. So my suggestion
> would be NOT to export this and only do so when we have users for it
> That would be true for other APIs exported out as well.

It'll just make the first codec driver patchset more complicated but fine.
