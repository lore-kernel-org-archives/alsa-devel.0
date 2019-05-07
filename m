From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 1/7] soundwire: Add sysfs support for
 master(s)
Date: Tue, 7 May 2019 17:49:48 -0500
Message-ID: <10fef156-7b01-7a08-77b4-ae3153eaaabc@linux.intel.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-2-pierre-louis.bossart@linux.intel.com>
 <20190504065242.GA9770@kroah.com>
 <b0059709-027e-26c4-25a1-bd55df7c507f@linux.intel.com>
 <20190507052732.GD16052@vkoul-mobl> <20190507055432.GB17986@kroah.com>
 <20190507110331.GL16052@vkoul-mobl> <20190507111956.GB1092@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190507111956.GB1092@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


>> The model here is that Master device is PCI or Platform device and then
>> creates a bus instance which has soundwire slave devices.
>>
>> So for any attribute on Master device (which has properties as well and
>> representation in sysfs), device specfic struct (PCI/platfrom doesn't
>> help). For slave that is not a problem as sdw_slave structure takes care
>> if that.
>>
>> So, the solution was to create the psedo sdw_master device for the
>> representation and have device-specific structure.
> 
> Ok, much like the "USB host controller" type device.  That's fine, make
> such a device, add it to your bus, and set the type correctly.  And keep
> a pointer to that structure in your device-specific structure if you
> really need to get to anything in it.

humm, you lost me on the last sentence. Did you mean using 
set_drv/platform_data during the init and retrieving the bus information 
with get_drv/platform_data as needed later? Or something else I badly 
need to learn?
