From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 08/14] soundwire: Add Slave status handling
 helpers
Date: Wed, 1 Nov 2017 16:10:08 -0500
Message-ID: <11066ca7-f71c-5867-67f5-3c597b26bf61@linux.intel.com>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-9-git-send-email-vinod.koul@intel.com>
 <s5h60bbqmkz.wl-tiwai@suse.de> <20171031130412.GW3187@localhost>
 <98f1b39a-b48d-2603-8e9d-88b4f804e2c8@linux.intel.com>
 <20171101090820.GA3187@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171101090820.GA3187@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Sagar Dharia <sdharia@codeaurora.org>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sudheer Papothi <spapothi@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On 11/1/17 4:08 AM, Vinod Koul wrote:
> On Wed, Nov 01, 2017 at 02:49:15AM +0530, Pierre-Louis Bossart wrote:
>>
>>>
>>>>> +		if (found == false) {
>>>>> +			/* TODO: Park this device in Group 13 */
>>>>> +			dev_err(bus->dev, "Slave Entry not found");
>>>>
>>>> No break here?  Otherwise...
>>>
>>> Thats intentional. We want to still read next device that show up
>>>
>>>>
>>>>> +		}
>>>>> +
>>>>> +	} while (ret == 0);
>>>>
>>>> ... the outer loop may go endlessly.
>>>> This condition doesn't look effective.
>>>
>>> not really. We cant keep reading successfully. At some point all slaves will
>>> ignore and return ENODATA and we exit. Bus errors will also make it exit
>>>
>>> BUT given that we have seen stuff i am inclined to add a counter, we cant
>>> have more than 11 device so that's a sane value to use :)
>>
>> Yep. Keep in mind however that there could be theoretical corner cases: if a
>> device is enumerated, loses sync and becomes attached again while you deal
>> with others, you'd have more than 11 iterations.
> 
> Not really as that would be another interrupt and another status report.

You are in a loop where you keep reading the devId registers, and that 
really has nothing to do with interrupts or status report. The point was 
that the number of times you read may be higher that the number of 
devices with a device being handled several times.
As mentioned above you need to limit this loop to a sane value.
