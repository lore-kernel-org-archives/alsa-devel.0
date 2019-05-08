From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 2/7] soundwire: add Slave sysfs support
Date: Wed, 8 May 2019 11:51:24 -0500
Message-ID: <9b61fd6f-69a1-ff70-a652-b45654f5dd96@linux.intel.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-3-pierre-louis.bossart@linux.intel.com>
 <20190504065444.GC9770@kroah.com>
 <c675ea60-5bfa-2475-8878-c589b8d20b32@linux.intel.com>
 <20190506151953.GA13178@kroah.com> <20190506162208.GI3845@vkoul-mobl.Dlink>
 <be72bbb1-b51f-8201-fdff-958836ed94d1@linux.intel.com>
 <20190507051959.GC16052@vkoul-mobl>
 <fde9c4cd-518b-cb67-5b05-1608c9d029e4@linux.intel.com>
 <20190508074009.GU16052@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190508074009.GU16052@vkoul-mobl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


>>>> Vinod, the question was not for dp0 and dpN, it's fine to have
>>>> subdirectories there, but rather why we need separate devices for the master
>>>> and slave properties.
>>>
>>> Slave does not have a separate device. IIRC the properties for Slave are
>>> in /sys/bus/soundwire/device/<slave>/...
>>
>> I am not sure this is correct
>>
>> ACPI defines the slaves devices under
>> /sys/bus/acpi/PRP0001, e.g.
> 
> Yes the bus will create 'soundwire slave' device type (In acpi case
> created from ACPI walk) and we do link the ACPI as the firmware node.
> This is 'not' created for properties but for soundwire representation of
> slave devices. This is the one code driver attaches to.
>   
>> /sys/bus/acpi/devices/PRP00001:00/device:17# ls
> 
> Yes this would the companion ACPI device

I see, I must admit I missed this part.

I guess it's not technically broken but was is really necessary though 
to use this notion of companion ACPI device? For the controller it makes 
sense, that's how to match ACPI and PCI, but since Soundwire slaves are 
not fully enumerable, precisely why we need all these _DSD properties, 
couldn't we just use ACPI devices directly?
