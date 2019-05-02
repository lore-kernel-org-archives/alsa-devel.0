From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v4 22/22] soundwire: add missing newlines in
 dynamic debug logs
Date: Thu, 2 May 2019 09:55:43 -0500
Message-ID: <5e81b8ff-b5e0-47a0-8bb9-d63e7532bf14@linux.intel.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
 <20190501155745.21806-23-pierre-louis.bossart@linux.intel.com>
 <20190502053746.GE3845@vkoul-mobl.Dlink> <20190502063219.GB14347@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190502063219.GB14347@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 5/2/19 1:32 AM, Greg KH wrote:
> On Thu, May 02, 2019 at 11:07:46AM +0530, Vinod Koul wrote:
>> On 01-05-19, 10:57, Pierre-Louis Bossart wrote:
>>> For some reason the newlines are not used everywhere. Fix as needed.
>>>
>>> Reported-by: Joe Perches <joe@perches.com>
>>> Reviewed-by: Takashi Iwai <tiwai@suse.de>
>>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>> ---
>>>   drivers/soundwire/bus.c            |  74 +++++++++----------
>>>   drivers/soundwire/cadence_master.c |  12 ++--
>>>   drivers/soundwire/intel.c          |  12 ++--
>>>   drivers/soundwire/stream.c         | 110 ++++++++++++++---------------
>>
>> Sorry this needs to be split up. I think bus.c and stream.c should go
>> in patch with cadence_master.c and intel.c in different ones
> 
> Again, _way_ too picky.  You can't look a gift horse _too_ closely in
> the mouth...
> 
> greg k-h

Vinod, your distinction between subsystem and driver is quite arbitrary 
and borderline unreasonable. I would counter that the Intel parts have 
actually nothing to do in this drivers/soundwire directory and should be 
moved to the SOF tree if you push your own logic one step. There already 
known variations on capabilities and number of links which would be 
better handled in sound/soc/sof/intel, just like SoundWire slaves are 
expected to be in sound/soc/codecs.

Besides this fixes *newlines*...

I will send an update but I am not happy about the directions here.
