From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [alsa-devel] [PATCH 08/11] ALSA: vsnd: Add timer for period
 interrupt emulation
Date: Tue, 8 Aug 2017 09:09:31 +0300
Message-ID: <4c89ecb8-5d53-0d58-0b03-7988f4985d30@gmail.com>
References: <1502091796-14413-1-git-send-email-andr2000@gmail.com>
 <1502091796-14413-9-git-send-email-andr2000@gmail.com>
 <ba0dd78b-8853-5cf9-197f-bed3b9f4bdb8@ladisch.de>
 <f2f54b55-3145-2533-c74a-9c3ea803739e@gmail.com>
 <4ce45eec-8657-66c4-c8c7-b851250da46a@ladisch.de>
 <45738e58-7ed2-8315-8d9c-138c3d3a2ecc@gmail.com>
 <e857f6cf-0e82-aa2b-9291-6d0c40ac918a@ladisch.de>
 <b6a3f40e-a5c3-1f66-b8e7-1d480e51e362@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b6a3f40e-a5c3-1f66-b8e7-1d480e51e362@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, xen-devel@lists.xen.org, linux-kernel@vger.kernel.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On 08/07/2017 06:14 PM, Oleksandr Andrushchenko wrote:
>
> On 08/07/2017 04:55 PM, Clemens Ladisch wrote:
>> Oleksandr Andrushchenko wrote:
>>> On 08/07/2017 04:11 PM, Clemens Ladisch wrote:
>>>> How does that interface work?
>>> For the buffer received in .copy_user/.copy_kernel we send
>>> a request to the backend and get response back (async) when it has 
>>> copied
>>> the bytes into HW/mixer/etc, so the buffer at frontend side can be 
>>> reused.
>> So if the frontend sends too many (too large) requests, does the
>> backend wait until there is enough free space in the buffer before
>> it does the actual copying and then acks?
> Well, the frontend should be backend agnostic,
> In our implementation backend is a user-space application which sits
> either on top of ALSA driver or PulseAudio: so, it acks correspondingly,
> e.g, when, for example, ALSA driver completes .copy_user and returns
> from the kernel
>> If yes, then these acks can be used as interrupts.
> we can probably teach our backend to track periods elapsed for ALSA,
> but not sure if it is possible for PulseAudio - do you know if this is 
> also
> doable for pulse?
>
> Let's assume backend blocks until the buffer played/consumed...
>>    (You still
>> have to count frames, and call snd_pcm_period_elapsed() exactly
>> when a period boundary was reached or crossed.)
> ... and what if the buffer has multiple periods? So, that the backend 
> sends
> a single response for multiple periods (buffers with fractional period 
> number
> can be handled separately)?
> We will have to either send snd_pcm_period_elapsed once (wrong, because
> multiple periods consumed) or multiple times at one time with no delay 
> (wrong,
> because there will be a confusion that multiple periods were not 
> reported for quite
> some long time and then there is a burst of events)
> Either way the behavior will not be the one desired (please correct me
> if I am wrong here)
>>
>> Splitting a large read/write into smaller requests to the backend
>> would improve the granularity of the known stream position.
>>
>> The overall latency would be the sum of the sizes of the frontend
>> and backend buffers.
>>
>>
>> Why is the protocol designed this way?
> We also work on para-virtualizing display device and there we tried to 
> use
> page flip events from backend to frontend to signal similar to
> period interrupt for audio. When multiple displays (read multiple 
> audio streams)
> were in place we flooded with the system interrupts (which are period 
> events in our case)
> and performance dropped significantly. This is why we switched to
> interrupt emulation, here via timer for audio. The main measures were:
> 1. Number of events between front and back
> 2. Latency
> With timer approach we reduce 1) to the minimum which is a must (no 
> period
> interrupts), but 2) is still here
> With emulated period interrupts (protocol events) we have issue with 1)
> and still 2) remains.
>
BTW, there is one more approach to solve this [1],
but it uses its own Xen sound protocol and heavily relies
on Linux implementation, which cannot be a part of a generic protocol
> So, to me, neither approach solves the problem for 100%, so we decided
> to stick to timers. Hope, this gives more background on why we did things
> the way we did.
>>   Wasn't the goal to expose
>> some 'real' sound card?
>>
> yes, but it can be implemented in different ways, please see above
>> Regards,
>> Clemens
> Thank you for your interest,
> Oleksandr

[1] 
https://github.com/OpenXT/pv-linux-drivers/blob/master/archive/openxt-audio/main.c#L356
