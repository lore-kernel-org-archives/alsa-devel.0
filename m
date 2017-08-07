From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [alsa-devel] [PATCH 08/11] ALSA: vsnd: Add timer for period
 interrupt emulation
Date: Mon, 7 Aug 2017 14:30:21 +0300
Message-ID: <f2f54b55-3145-2533-c74a-9c3ea803739e@gmail.com>
References: <1502091796-14413-1-git-send-email-andr2000@gmail.com>
 <1502091796-14413-9-git-send-email-andr2000@gmail.com>
 <ba0dd78b-8853-5cf9-197f-bed3b9f4bdb8@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ba0dd78b-8853-5cf9-197f-bed3b9f4bdb8@ladisch.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, xen-devel@lists.xen.org, linux-kernel@vger.kernel.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

Hi, Clemens!

On 08/07/2017 01:27 PM, Clemens Ladisch wrote:
> Oleksandr Andrushchenko wrote:
>> Front sound driver has no real interrupts, so
>> playback/capture period passed interrupt needs to be emulated:
>> this is done via timer. Add required timer operations,
>> this is based on sound/drivers/dummy.c.
> A 'real' sound card use the interrupt to synchronize the stream position
> between the hardware and the driver.  The hardware triggers an interrupt
> immediately after a period has been completely read (for playback) from
> the ring buffer by the DMA unit; this tells the driver that it is now
> again allowed to write to that part of the buffer.
Yes, I know that, thank you
> The dummy driver has no hardware that accesses the buffer, so the period
> interrupts are not synchronized to anything.
Exactly
>    This is not a suitable
> implementation when the samples are actually used.

> If you issue interrupts based on the system timer, the position reported
> by the .pointer callback and the position where the hardware (backend)
> actually accesses the buffer will diverge, which will eventually corrupt
> data.
Makes sense, but in my case the buffer from the frontend
is copied into backend's memory, so they don't share the
same buffer as real HW does. But it is still possible that
the new portion of data may arrive and backend will overwrite
the memory which hasn't been played yet because pointers are not
synchronized
> You have to implement period interrupts (and the .pointer callback)
> based on when the samples are actually moved from/to the backend.
Do you think I can implement this in a slightly different way,
without a timer at all, by updating
substream->runtime->hw_ptr_base explicitly in the frontend driver?
Like it was implemented [1], see virtualcard_pcm_pointer
(unfortunately, that driver didn't make it to the kernel).
So, that way, whenever I get an ack/response from the backend that it has
successfully played the buffer I can update hw_ptr_base at the frontend
and thus be always in sync to the backend.
> Regards,
> Clemens
Thank you,
Oleksandr

[1] http://marc.info/?l=xen-devel&m=142185395013970&w=4
