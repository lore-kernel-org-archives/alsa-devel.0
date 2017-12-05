From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v4 06/15] soundwire: Add IO transfer
Date: Tue, 5 Dec 2017 07:43:46 -0600
Message-ID: <fb78b1c5-0a52-90b3-262e-8880aeb2da11@linux.intel.com>
References: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
 <1512122177-2889-7-git-send-email-vinod.koul@intel.com>
 <40d00228-2891-6e25-4c6f-789518a0e2c2@linux.intel.com>
 <20171203170418.GN32417@localhost>
 <d7ed6ffa-e9b3-a7c9-ae07-369d2d541eab@linux.intel.com>
 <20171205063114.GL32417@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171205063114.GL32417@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On 12/5/17 12:31 AM, Vinod Koul wrote:
> On Sun, Dec 03, 2017 at 09:01:41PM -0600, Pierre-Louis Bossart wrote:
>> On 12/3/17 11:04 AM, Vinod Koul wrote:
>>> On Fri, Dec 01, 2017 at 05:27:31PM -0600, Pierre-Louis Bossart wrote:
> 
> Sorry looks like I missed replying to this one earlier.
> 
>>>>> +static inline int find_response_code(enum sdw_command_response resp)
>>>>> +{
>>>>> +	switch (resp) {
>>>>> +	case SDW_CMD_OK:
>>>>> +		return 0;
>>>>> +
>>>>> +	case SDW_CMD_IGNORED:
>>>>> +		return -ENODATA;
>>>>> +
>>>>> +	case SDW_CMD_TIMEOUT:
>>>>> +		return -ETIMEDOUT;
>>>>> +
>>>>> +	default:
>>>>> +		return -EIO;
>>>>
>>>> the 'default' case will handle both SDW_CMD_FAIL (which is a bus event
>>>> usually due to bus clash or parity issues) and SDW_CMD_FAIL_OTHER (which is
>>>> an imp-def IP event).
>>>>
>>>> Do they really belong in the same basket? From a debug perspective there is
>>>> quite a bit of information lost.
>>>
>>> at higher level the error handling is same. the information is not lost as
>>> it is expected that you would log it at error source.
>>
>> I don't understand this. It's certainly not the same for me if you detect an
>> electric problem or if the IP is in the weeds. Logging at the source is fine
>> but this filtering prevents higher levels from doing anything different.
> 
> The point is higher levels like here cant do much than bail out and complain.
> 
> Can you point out what would be different behaviour in each of these cases?
> 
>>>>> +static inline int do_transfer(struct sdw_bus *bus, struct sdw_msg *msg)
>>>>> +{
>>>>> +	int retry = bus->prop.err_threshold;
>>>>> +	enum sdw_command_response resp;
>>>>> +	int ret = 0, i;
>>>>> +
>>>>> +	for (i = 0; i <= retry; i++) {
>>>>> +		resp = bus->ops->xfer_msg(bus, msg);
>>>>> +		ret = find_response_code(resp);
>>>>> +
>>>>> +		/* if cmd is ok or ignored return */
>>>>> +		if (ret == 0 || ret == -ENODATA)
>>>>
>>>> Can you document why you don't retry on a CMD_IGNORED? I know there was a
>>>> reason, I just can't remember it.
>>>
>>> CMD_IGNORED can be okay on broadcast. User of this API can retry all they
>>> want!
>>
>> So you retry if this is a CMD_FAILED but let higher levels retry for
>> CMD_IGNORED, sorry I don't see the logic.
> 
> Yes that is right.
> 
> If I am doing a broadcast read, lets say for Device Id registers, why in the
> world would I want to retry? CMD_IGNORED is a valid response and required to
> stop enumeration cycle in that case.
> 
> But if I am not expecting a CMD_IGNORED response, I can very well go ahead
> and retry from caller. The context is with caller and they can choose to do
> appropriate handling.
> 
> And I have clarified this couple of times to you already, not sure how many
> more times I would have to do that.

Until you clarify what you are doing.
There is ONE case where IGNORED is a valid answer (reading the Prepare 
not finished bits), and it should not only be documented but analyzed in 
more details.
For a write an IGNORED is never OK.

> 
>>>> Now that I think of it, the retry on TIMEOUT makes no sense to me. The retry
>>>> was intended for bus-level issues, where maybe a single bit error causes an
>>>> issue without consequences, but the TIMEOUT is a completely different beast,
>>>> it's the master IP that doesn't answer really, a completely different case.
>>>
>>> well in those cases where you have blue wires, it actually helps :)
>>
>> Blue wires are not supposed to change electrical behavior. TIMEOUT is only
>> an internal SOC level issue, so no I don't get how this helps.
>>
>> You have a retry count that is provided in the BIOS/firmware through disco
>> properties and it's meant to bus errors. You are abusing the definitions. A
>> command failed is supposed to be detected at the frame rate, which is
>> typically 20us. a timeout is likely a 100s of ms value, so if you retry on
>> top it's going to lock up the bus.
> 
> The world is not perfect! A guy debugging setups needs all the help. I do
> not see any reason for not to retry. Bus is anyway locked up while a
> transfer is ongoing (we serialize transfers).
> 
> Now if you feel this should be abhorred, I can change this for timeout.

This TIMEOUT thing is your own definition, it's not part of the spec, so 
I don't see how it can be lumped together with spec-related parts.

It's fine to keep a retry but please document what the expectations are 
for the TIMEOUT case.

> 
>>>>> +enum sdw_command_response {
>>>>> +	SDW_CMD_OK = 0,
>>>>> +	SDW_CMD_IGNORED = 1,
>>>>> +	SDW_CMD_FAIL = 2,
>>>>> +	SDW_CMD_TIMEOUT = 4,
>>>>> +	SDW_CMD_FAIL_OTHER = 8,
>>>>
>>>> Humm, I can't recall if/why this is a mask? does it need to be?
>>>
>>> mask, not following!
>>>
>>> Taking a wild guess that you are asking about last error, which is for SW
>>> errors like malloc fail etc...
>>
>> no, I was asking why this is declared as if it was used for a bitmask, why
>> not 0,1,2,3,4?
> 
> Oh okay, I think it was something to do with bits for errors, but don see it
> helping so I can change it either way...

Unless you use bit-wise operators and combined responses there is no 
reason to keep the current definitions.
