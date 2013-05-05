From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [RFC] Sound/HID: wiimote: add speaker support
Date: Sun, 5 May 2013 13:17:25 +0200
Message-ID: <CANq1E4SV+0nw=XY1k7g9vg2YJ75OyKoQGkwV-9onC+5JqDs1rg@mail.gmail.com>
References: <1366481693-5945-1-git-send-email-dh.herrmann@gmail.com>
 <5178D709.1060500@canonical.com>
 <CANq1E4SkUkqwR0EPfr2XWaNNf6=v1u7YtfTqzBnqN6YTdWBSyA@mail.gmail.com>
 <517A80E6.5010909@canonical.com>
 <CANq1E4RyAzGn1H5PN5iuyp0eVDfX8YEXNkVkkq3Jp3jMb=ea0w@mail.gmail.com>
 <517A8D87.5090800@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CFA3261689
 for <alsa-devel@alsa-project.org>; Sun,  5 May 2013 13:17:26 +0200 (CEST)
Received: by mail-ie0-f179.google.com with SMTP id c13so3170926ieb.38
 for <alsa-devel@alsa-project.org>; Sun, 05 May 2013 04:17:26 -0700 (PDT)
In-Reply-To: <517A8D87.5090800@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

On Fri, Apr 26, 2013 at 4:21 PM, David Henningsson
<david.henningsson@canonical.com> wrote:
> On 04/26/2013 03:56 PM, David Herrmann wrote:
>>
>> Hi
>>
>> On Fri, Apr 26, 2013 at 3:28 PM, David Henningsson
>> <david.henningsson@canonical.com> wrote:
>>>
>>> On 04/26/2013 03:00 PM, David Herrmann wrote:
>>>>
>>>>
>>>> Hi
>>>>
>>>> On Thu, Apr 25, 2013 at 9:11 AM, David Henningsson
>>>> <david.henningsson@canonical.com> wrote:
>>>>>
>>>>>
>>>>> On 04/20/2013 08:14 PM, David Herrmann wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> Classic Wii Remotes provide a speaker on the device. We can stream PCM
>>>>>> data, mute and change volume via special protocol requests and remote
>>>>>> audio registers.
>>>>>>
>>>>>> The device supports several different formats, but fully understood
>>>>>> are
>>>>>> only signed 8-bit PCM and something that looks like 4-bit Yamaha
>>>>>> ADPCM.
>>>>>> Theoretically, we can set data-rates from 183Hz up to 12MHz, but a
>>>>>> realistic range for Bluetooth l2cap is 1500-4000 Hz.
>>>>>>
>>>>>> Data is streamed as 20bytes blocks and must be sent in a constant
>>>>>> rate.
>>>>>> There is no way to read the current position. It would be way too
>>>>>> slow,
>>>>>> anyway.
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>> Fun project!
>>>>>
>>>>> I'm not sure I'm qualified to answer, but I would have allocated a
>>>>> buffer
>>>>> of
>>>>> kernel memory, say 64K (or maybe less, since the sample rate is so
>>>>> low).
>>>>> That would be the buffer you expose to userspace, and userspace would
>>>>> set
>>>>> period and buffer sizes according to this buffer.
>>>>>
>>>>> Your code doesn't really expose if/how you can tell if you're allowed
>>>>> to
>>>>> send 20 more bytes or not.
>>>>
>>>>
>>>>
>>>> I cannot tell at all. That's the problem. I just send data at the
>>>> expected rate and let the device deal with it. For instance with 8bit
>>>> PCM at 2000 Hz that makes one 20byte packet every 10ms. That's
>>>> 16kbit/s, which should work via Bluetooth l2cap.
>>>
>>>
>>>
>>> Btw, since this is something bluetooth related, have you checked with the
>>> bluez/bluetoothd project, so it isn't easier to integrate that way
>>> instead
>>> of in a kernel driver?
>>>
>>> That's how bluetooth audio is usually done.
>>
>>
>> Hehe, I'm involved in Bluetooth kernel development so I did check that
>> first ;)
>
>
> Cool, does this mean I can contact you if I have problems with Bluetooth
> chips and kernel drivers? That can come in handy ;-)

I don't get paid for this, but you can always try ;)

>
>> The thing is, Nintendo did a pretty bad job with audio on the
>> Wiimote. Bluetooth provides SCO channels specifically for audio but
>> Nintendo tunnels audio through an HID connection, yay! On the other
>> hand, the speaker is mostly used for small sound-effects so that
>> explains why they didn't care for higher rates.
>>
>> As l2cap+HID is handled in the kernel, I would have to provide a
>> char-interface or sysfs PCM-stream or whatever for user-space so they
>> can send HID reports with audio data while the kernel sends it's own
>> HID reports for normal HID operation. That does work, but I thought if
>> I already have all the device handling in the kernel, I should at
>> least try to do it as sound-driver. If it doesn't work out I can
>> always fall back to this option.
>
>
> Ok.
>
>
>>>> Even 10x the
>>>> sample-rate (20kHz) with 160kbit/s should be possible, but the latency
>>>> gets pretty high that I doubt I can do that with a 20byte buffer. I
>>>> haven't figured out how big the real buffer of the device is so until
>>>> then I expect it to be as low as 20 bytes (the proprietary driver does
>>>> that, too).
>>>>
>>>> If the transmission buffer overflows, I just drop packages so there is
>>>> currently no easy way for me to see whether there's enough room for a
>>>> next package or not. But the connection is reliable so once a packet
>>>> is in the buffer, it's "guaranteed" to be transmitted in order to the
>>>> device.
>>>>
>>>> What's the expected thing to do if the connection is too slow? Should
>>>> I pause and resume or drop packets?
>>>
>>>
>>>
>>> Not sure what you mean here. Maybe bluetooth people know this problem
>>> better.
>>>
>>>
>>>>
>>>>> But assuming you have a timer running at a
>>>>> reasonable interval, that code would do something like:
>>>>>
>>>>> if (ready_to_send_packet_to_wiimote()) {
>>>>>     send_20_bytes_to_wiimote(kernel_buffer_ptr + offset);
>>>>>     offset += 20;
>>>>>     offset %= buffer_size;
>>>>>     if (offset % period_size < 20)
>>>>>       snd_pcm_period_elapsed();
>>>>> }
>>>>
>>>>
>>>>
>>>> Ah, ok, so I just send the data in the timer-interrupt and call
>>>> snd_pcm_period_elapsed() if the fill-state gets smaller than 20 bytes?
>>>> I guess snd_pcm_period_elapsed() is atomic so I can expect it to
>>>> prepare the buffer so the next timer-interrupt is guaranteed to have a
>>>> valid buffer or a cleared buffer?
>>>
>>>
>>>
>>> snd_pcm_period_elapsed() just tells userspace that userspace can start
>>> filling up a new period in the ringbuffer. snd_pcm_period_elapsed() does
>>> not
>>> prepare anything.
>>>
>>> E g, if userspace requests a buffer of 64K and period of 16K, you should
>>> call snd_pcm_period_elapsed() every time you cross a period boundary.
>>> Perhaps "offset % period_size < 20" can be more clearly written as
>>> "(offset
>>> / period_size) != (old_offset / period_size)", if that's more
>>> understandable?
>>
>>
>> Ah, now I understand. I thought the period-size is the maximum
>> transmission size that I can use in the driver (20 in this case). Ok,
>> your explanation helped. I think I understand the "period" concept
>> now.
>>
>> Apart from that, should I provide an mmap() interface for the buffer
>> so I can map it into the clients address-space? Or should I prevent
>> mmap() and let them use read/write? I guess I wouldn't need the .copy
>> and .silence callbacks if I provide mmap(), right? And a
>> vm_insert_pfn() would be quite simple to do..
>
>
> I believe a mmap() interface would be more efficient, and thus recommended.
> And some sound applications depend on an mmap interface being present
> (although, really, they shouldn't).
>
> There are some mmap helper functions in pcm.h that can probably help you
> here - as for which callbacks you need to provide, you can probably figure
> that out as quick as I can, as you're used to kernel development.
>
>
>> What happens if user-space cannot keep up with the rates? Do I just
>> continue sending garbage from the buffer or does the alsa core pause
>> the transmission or silence it until user-space catches up?
>
>
> If userspace cannot keep up, I believe snd_pcm_period_elapsed() will make
> sure userspace gets an underrun error.

I now got a working implementation (with the snd_pcm_vmalloc_*()
helpers) and I can (if I listen closely) recognize the sound that I
play on the Wii-Remote, but quality is worse than horrible. I also get
weird protocol errors. Seems like I need to do some more
reverse-engineering to figure it out.
But at least the driver works correctly. I will try to figure out why
the remote discards some requests and if everything works out I will
repost the driver here.

Thanks for your help!
Regards
David
