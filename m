From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: sigmadsp: safeload should be used
	from 4 bytes
Date: Wed, 22 Aug 2018 15:57:52 +0200
Message-ID: <78b4902e-3601-97e2-b705-f0e03b3d7709@metafoo.de>
References: <20180822061131.13191-1-robertr@axis.com>
 <ef680c4a-3b28-e28c-0164-085330ec2dee@metafoo.de>
 <b480bfae-8a3b-a619-f7c4-1aede7969dda@axis.com>
 <c71004c9-eb37-74aa-5b87-6eea0515fb43@metafoo.de>
 <e0914f4b-ded8-570f-3fe3-003a4bf75dd7@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id CA799267663
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2018 15:57:54 +0200 (CEST)
In-Reply-To: <e0914f4b-ded8-570f-3fe3-003a4bf75dd7@axis.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Danny Smith <danny.smith@axis.com>, Robert Rosengren <robertr@axis.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/22/2018 03:40 PM, Danny Smith wrote:
> 
> 
> On 08/22/2018 03:05 PM, Lars-Peter Clausen wrote:
>> On 08/22/2018 09:53 AM, Danny Smith wrote:
>>>
>>> On 08/22/2018 08:34 AM, Lars-Peter Clausen wrote:
>>>> On 08/22/2018 08:11 AM, Robert Rosengren wrote:
>>>>> From: Danny Smith <dannys@axis.com>
>>>>>
>>>>> Fixed range in safeload conditional to allow safeload to be used from
>>>>> 4 bytes.
>>>> Hi,
>>>>
>>>> Thanks for the patch. The reason why 4 bytes is excluded is that up to 4
>>>> bytes can be updated atomically with a single register write. But I could
>>>> see that if the firmware reads the same parameter multiple times during the
>>>> same run you could get inconsistent results.
>>>>
>>>> Can you explain a bit more why you need this?
>>>>
>>>> If we want to allow safeload for 4 byte parameters the same reasoning
>>>> applies for parameters with less than 4 bytes as well and so the check
>>>> should be removed completely.
>>>>
>>>> - Lars
>>> Hi,
>>>
>>> Thanks for the feedback. It is correct that up to 4 bytes can be updated
>>> atomically but does that also guarantee that the data is safeloaded, i.e.
>>> updated when the parameter is not in use? Maybe updating up to 4 byte
>>> parameters without safeload does not cause audio glitches?
>> The datasheet says:
>>
>> """
>> To update parameters in real time while avoiding pop and click
>> noises on the output, the ADAU1761 uses a software safeload
>> mechanism. The software safeload mechanism enables the
>> SigmaDSP core to load new parameters into RAM while guaranteeing
>> that the parameters are not in use. This prevents an
>> undesirable condition where an instruction could execute with
>> a mix of old and new parameters.
>> """
>>
>> The way I understand the last sentence is that there is no issue when
>> loading only 4 bytes or less since there is no risk of mixing old and new
>> data.
>>
>> I don't mind changing this, I was just curious if you had seen any issues
>> with a 4 byte parameter update.
>>
>> - Lars
> I have not seen any issues doing a 4byte parameter update without safeload
> but have not performed any extensive testing on the subject. The reason for
> the patch was that I noticed that sigmastudio uses safeload when doing 4byte
> writes but I cannot say if it is necessary or not.

Ok, then lets change the driver, but drop the test completely so that
anything up to 20 bytes uses safeload.
