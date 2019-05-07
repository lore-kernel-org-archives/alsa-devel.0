From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/8] soundwire: intel: filter SoundWire controller device
 search
Date: Tue, 7 May 2019 09:43:15 -0500
Message-ID: <47fd3ca6-6910-f101-9b63-f653cd1443f9@linux.intel.com>
References: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
 <20190504002926.28815-2-pierre-louis.bossart@linux.intel.com>
 <20190507122651.GO16052@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190507122651.GO16052@vkoul-mobl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 5/7/19 7:26 AM, Vinod Koul wrote:
> On 03-05-19, 19:29, Pierre-Louis Bossart wrote:
>> The convention is that the SoundWire controller device is a child of
>> the HDAudio controller. However there can be more than one child
>> exposed in the DSDT table, and the current namespace walk returns the
>> last device.
>>
>> Add a filter and terminate early when a valid _ADR is provided,
>> otherwise keep iterating to find the next child.
> 
> So what are the other devices in DSDT here..

this is what I see:

Scope (HDAS)
         {
             Device (IDA)
             {
                 Name (_ADR, 0x00020001)  // _ADR: Address
             }
         }

I thought this was nonsense but your question triggered me to look into 
the Intel SST ACPI specs (not public I am afraid but shared with the OS 
who shall not be named).
Using the same source of information as below, I *believe* this is 
HDaudio related, bits 31..16 mean HDaudio with codec SDI 2, and NodeId 1 
for the function group. This would make sense as I believe there are two 
codecs on the board that can be pin-strapped to boot either in HDaudio 
or SoundWire mode- but this is a conjecture only.

At any rate, we need a hardware rework and mutual exclusion between 
HDaudio and SoundWire, so we have to ignore this one when SoundWire is 
enabled.

>> +
>> +	/*
>> +	 * On some Intel platforms, multiple children of the HDAS
>> +	 * device can be found, but only one of them is the SoundWire
>> +	 * controller. The SNDW device is always exposed with
>> +	 * Name(_ADR, 0x40000000) so filter accordingly
>> +	 */
>> +	if (adr != 0x40000000)
> 
> I do not recall if 4 corresponds to the links you have or soundwire
> device type, is this number documented somewhere is HDA specs?

I thought it was a magic number, but I did check and for once it's 
documented and the values match the spec :-)
I see in the ACPI docs bits 31..28 set to 4 indicate a SoundWire Link 
Type and bits 3..0 indicate the SoundWire controller instance, the rest 
is reserved to zero.

> 
> Also it might good to create a define for this

I will respin this one to add the documentation above, and only filter 
on the 4 ms-bits. Thanks for forcing me to RTFM :-)
