From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 01/14] Documentation: Add SoundWire summary
Date: Sun, 22 Oct 2017 15:36:32 +0530
Message-ID: <32258d12-f405-a62d-143a-c801ad06e097@linux.intel.com>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-2-git-send-email-vinod.koul@intel.com>
 <20171021085744.hpuvp34e4hckoisl@sirena.org.uk>
 <20171021112840.GD30097@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171021112840.GD30097@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Takashi <tiwai@suse.de>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On 10/21/17 4:58 PM, Vinod Koul wrote:
> On Sat, Oct 21, 2017 at 09:57:44AM +0100, Mark Brown wrote:
>> On Thu, Oct 19, 2017 at 08:33:17AM +0530, Vinod Koul wrote:
>>
>>> +The SoundWire protocol supports up to eleven Slave interfaces. All the
>>
>> There's lots of perfectly normal nouns in this document like Slave here
>> which are randomly capitalized.  Is there some great reason for this?
>> It makes the document pretty distracting to read.
> 
> Slave, SoundWire etc are MIPI definitions hence capitalized.

I insisted to follow the conventions in the specification, it's not 
random at all.

> 
>>> +Bus implements API to read standard Master MIPI properties and also provides
>>> +callback in Master ops for Master driver to implement own functions that
>>
>> implement it's own functions.
> 
> ok
> 
>>
>>> +provides capabilities information. DT support is not implemented at this
>>> +time but should be trivial to add since capabilities are enabled with the
>>> +device_property_ API.
>>
>> Since we're making this up from whole cloth rather than following an
>> existing standard let's get a DT binding document together and review
>> the properties that are getting defined.

The properties are already defined in the DisCo spec (publicly 
accessible) and were reviewed by MIPI contributors, they are not Intel 
specific and not invented by Intel.
We can put together a DT binding document that follows the Disco spec 
but it'd be a bad idea to change the definitions or come up with new ones...

> 
> I don't have a DT to test, but looking at Slimbus code I guess assumptions
> are fair and we seem to have similar concepts and implementation.
> 
>>
>>> +	/* Check ACPI for Slave devices */
>>> +        sdw_acpi_find_slaves(bus);
>>
>> Tab/space issues here.
> 
> fixed now
> 
>>
>>> +The MIPI specification requires each Slave interface to expose a unique
>>> +48-bit identifier, stored in 6 read only dev_id registers. This dev_id
>>> +identifier contains vendor and part information, as well as a field enabling
>>> +to differentiate between identical components. An additional class field is
>>> +currently unused. Slave driver is written for the specific 48-bit
>>> +identifier, Bus enumerates the Slave device based on the 48-bit identifier.
>>
>> So this says that the instance identifer is part of the device
>> identifier but the driver should bind to the whole device identifer?
>> I'd expect the driver to bind to everything except the instance
>> identifer.
> 
> Other parts are still TBD and not really used, like Device Class, Spec
> version. We are using only mfg id and part id for binding.

Yes, for now the only useful information is manufacturer ID/part ID, the 
spec version is not necessary since there is compatibility between 1.0 
and 1.1 and the changes are documented in properties.
