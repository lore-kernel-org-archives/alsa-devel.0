From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 2/7] soundwire: add Slave sysfs support
Date: Mon, 6 May 2019 11:46:06 -0500
Message-ID: <be72bbb1-b51f-8201-fdff-958836ed94d1@linux.intel.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-3-pierre-louis.bossart@linux.intel.com>
 <20190504065444.GC9770@kroah.com>
 <c675ea60-5bfa-2475-8878-c589b8d20b32@linux.intel.com>
 <20190506151953.GA13178@kroah.com> <20190506162208.GI3845@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190506162208.GI3845@vkoul-mobl.Dlink>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 5/6/19 11:22 AM, Vinod Koul wrote:
> On 06-05-19, 17:19, Greg KH wrote:
>> On Mon, May 06, 2019 at 09:42:35AM -0500, Pierre-Louis Bossart wrote:
>>>>> +
>>>>> +int sdw_sysfs_slave_init(struct sdw_slave *slave)
>>>>> +{
>>>>> +	struct sdw_slave_sysfs *sysfs;
>>>>> +	unsigned int src_dpns, sink_dpns, i, j;
>>>>> +	int err;
>>>>> +
>>>>> +	if (slave->sysfs) {
>>>>> +		dev_err(&slave->dev, "SDW Slave sysfs is already initialized\n");
>>>>> +		err = -EIO;
>>>>> +		goto err_ret;
>>>>> +	}
>>>>> +
>>>>> +	sysfs = kzalloc(sizeof(*sysfs), GFP_KERNEL);
>>>>
>>>> Same question as patch 1, why a new device?
>>>
>>> yes it's the same open. In this case, the slave devices are defined at a
>>> different level so it's also confusing to create a device to represent the
>>> slave properties. The code works but I am not sure the initial directions
>>> are correct.
>>
>> You can just make a subdir for your attributes by using the attribute
>> group name, if a subdirectory is needed just to keep things a bit more
>> organized.
> 
> The key here is 'a subdir' which is not the case here. We did discuss
> this in the initial patches for SoundWire which had sysfs :)
> 
> The way MIPI disco spec organized properties, we have dp0 and dpN
> properties each of them requires to have a subdir of their own and that
> was the reason why I coded it to be creating a device.

Vinod, the question was not for dp0 and dpN, it's fine to have 
subdirectories there, but rather why we need separate devices for the 
master and slave properties.

> 
> Do we have a better way to handle this?
> 
>> Otherwise, you need to mess with having multiple "types" of struct
>> device all associated with the same bus.  It is possible, and not that
>> hard, but I don't think you are doing that here.
>>
>> thnaks,
>>
>> greg k-h
> 
