From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: Fix UAC2 get_ctl request with a RANGE
 attribute
Date: Tue, 13 Feb 2018 17:27:42 +0100
Message-ID: <1212656b-5eae-c3fe-f001-e9594d7bdb80@gmail.com>
References: <20180129053755.20136-1-k.marinushkin@gmail.com>
 <s5hvaf95p4i.wl-tiwai@suse.de>
 <40196230-8f73-4cca-08e5-d67bfbea2d6e@gmail.com>
 <s5hinb2aauh.wl-tiwai@suse.de>
 <120bc0f8-f472-268d-1247-3245ae994fe5@gmail.com>
 <s5hk1vh4h02.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5hk1vh4h02.wl-tiwai@suse.de>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, alsa-devel@alsa-project.org, Stephen Barber <smbarber@chromium.org>, Bhumika Goyal <bhumirks@gmail.com>, Jaejoong Kim <climbbb.kim@gmail.com>, Julian Scheel <julian@jusst.de>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 02/13/18 06:04, Takashi Iwai wrote:
> On Mon, 12 Feb 2018 20:32:53 +0100,
> Kirill Marinushkin wrote:
>> Hello maintainers of <stable@vger.kernel.org>,
>>
>>
>> As discussed earlier in this thread, I propose this patch to stable.
>>
>> It fixes the issue, which exists since v2.6.34.
> It's already marked in the applied patch, so you don't need to ping
> stable kernel guys.
>
>
> thanks,
>
> Takashi

Hello Takashi,

Thank you for the clarification

Best Regards,
Kirill
>
>>
>> Best Regards,
>>
>> Kirill
>>
>> On 02/12/18 09:08, Takashi Iwai wrote:
>>> On Thu, 08 Feb 2018 07:21:36 +0100,
>>> Kirill Marinushkin wrote:
>>>> On 02/07/18 06:45, Takashi Iwai wrote:
>>>>> On Mon, 29 Jan 2018 06:37:55 +0100,
>>>>> Kirill Marinushkin wrote:
>>>>>> The layout of the UAC2 Control request and response varies depending on
>>>>>> the request type. With the current implementation, only the Layout 2
>>>>>> Parameter Block (with the 2-byte sized RANGE attribute) is handled
>>>>>> properly. For the Control requests with the 1-byte sized RANGE attribute
>>>>>> (Bass Control, Mid Control, Tremble Control), the response is parsed
>>>>>> incorrectly.
>>>>>>
>>>>>> This commit:
>>>>>> * fixes the wLength field value in the request
>>>>>> * fixes parsing the range values from the response
>>>>>>
>>>>>> Fixes: 23caaf19b11e ("ALSA: usb-mixer: Add support for Audio Class v2.0")
>>>>>> Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
>>>>>> Cc: Jaroslav Kysela <perex@perex.cz>
>>>>>> Cc: Takashi Iwai <tiwai@suse.com>
>>>>>> Cc: Jaejoong Kim <climbbb.kim@gmail.com>
>>>>>> Cc: Bhumika Goyal <bhumirks@gmail.com>
>>>>>> Cc: Stephen Barber <smbarber@chromium.org>
>>>>>> Cc: Julian Scheel <julian@jusst.de>
>>>>>> Cc: alsa-devel@alsa-project.org
>>>>>> Cc: linux-kernel@vger.kernel.org
>>>>> Sorry for the late reply, as I've been (and still) off.
>>>>>
>>>>> Does this bug actually hit on any real devices, or is it only a
>>>>> logical error so far?  In the former case, a Cc to stable is
>>>>> mandatory.
>>>>>
>>>>> In anyway, I'll review and merge it properly once after I back to
>>>>> work.
>>>>>
>>>>>
>>>>> thanks,
>>>>>
>>>>> Takashi
>>>> Hello Takashi,
>>>>
>>>> Thank you for your answer. I will wait until you are back to work, don't 
>>>> worry about the late replies.
>>>>
>>>> I did not hit the issue on a real device.
>>>>
>>>> During my UAC2 experiments, I reproduced this issue on the development 
>>>> board, and then tested my solution on it.
>>> OK, if it happened on a development system, it's a real issue, and we
>>> should put Cc to stable.  Now I applied the patch.
>>>
>>> Thanks!
>>>
>>>
>>> Takashi
