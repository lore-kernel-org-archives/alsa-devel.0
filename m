From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [alsa-devel] [PATCH 08/11] ALSA: vsnd: Add timer for period
 interrupt emulation
Date: Mon, 7 Aug 2017 16:38:06 +0300
Message-ID: <45738e58-7ed2-8315-8d9c-138c3d3a2ecc@gmail.com>
References: <1502091796-14413-1-git-send-email-andr2000@gmail.com>
 <1502091796-14413-9-git-send-email-andr2000@gmail.com>
 <ba0dd78b-8853-5cf9-197f-bed3b9f4bdb8@ladisch.de>
 <f2f54b55-3145-2533-c74a-9c3ea803739e@gmail.com>
 <4ce45eec-8657-66c4-c8c7-b851250da46a@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4ce45eec-8657-66c4-c8c7-b851250da46a@ladisch.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, xen-devel@lists.xen.org, linux-kernel@vger.kernel.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On 08/07/2017 04:11 PM, Clemens Ladisch wrote:
> Oleksandr Andrushchenko wrote:
>> On 08/07/2017 01:27 PM, Clemens Ladisch wrote:
>>> You have to implement period interrupts (and the .pointer callback)
>>> based on when the samples are actually moved from/to the backend.
>> Do you think I can implement this in a slightly different way,
>> without a timer at all, by updating
>> substream->runtime->hw_ptr_base explicitly in the frontend driver?
> As far as I am aware, hw_ptr_base is an internal field that drivers
> are not supposed to change.
I know that and always considered not a good solution,
this is why I have timer to emulate things
> Just use your own variable, and return it from the .pointer callback.
this can work, but see below
>> So, that way, whenever I get an ack/response from the backend that it has
>> successfully played the buffer
> That response should come after every period.

> How does that interface work?
For the buffer received in .copy_user/.copy_kernel we send
a request to the backend and get response back (async) when it has copied
the bytes into HW/mixer/etc, so the buffer at frontend side can be reused.
So, the amount of bytes in this exchange is not necessarily
a multiply of the period. Also, there is no way to synchronize period
sizes in the front driver and backend to make those equal.
There is also no event from the backend in the
protocol to tell that the period has elapsed, so
sending data in period's size buffers will not probably
help because of possible underruns
>   Is it possible to change the period size,
> or at least to detect what it is?

Unfortunately no, this is not in the protocol.

>
>
> Regards,
> Clemens
you can see the protocol at [1]

Thank you,
Oleksandr

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/include/xen/interface/io/sndif.h?h=for-next
