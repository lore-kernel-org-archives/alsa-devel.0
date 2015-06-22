From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Mon, 22 Jun 2015 17:10:58 +0500
Message-ID: <5587FB52.9070401@gmail.com>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
 <557E86DD.8020709@metafoo.de>
 <CAN8cciYApKja0e0U7Uy2YG2ySemfhvKfLGUueGyFx5ajjyqKBA@mail.gmail.com>
 <557EBEAA.70004@metafoo.de>
 <CAN8cciZ4B2X+o4AXdCGEEAFCcX+iWqyf+FvMkEkrSu3Vt8Vx8Q@mail.gmail.com>
 <557EDE22.7080808@metafoo.de>
 <CAN8ccibPTkiayx_9ETOwjw1dSF+UPsxjgcqWJR+mm149c69WBg@mail.gmail.com>
 <5587AE77.1020709@metafoo.de> <5587D845.4040309@ladisch.de>
 <CAN8ccibQvDmdydn3QjHH==mNNizWuH+FOwRMu_BFRYGAfu9ukw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B7E3261B19
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 14:09:11 +0200 (CEST)
Received: by lagx9 with SMTP id x9so20448224lag.1
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 05:09:09 -0700 (PDT)
In-Reply-To: <CAN8ccibQvDmdydn3QjHH==mNNizWuH+FOwRMu_BFRYGAfu9ukw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Arun Raghavan <arun@accosted.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

22.06.2015 16:54, Raymond Yau wrote:
>>>> Are all soc audio driver use cyclic dma ?
>>>
>>> I'm not sure I understand the question. All audio drivers use some
>>> kind of cyclic DMA.
>>
>> The ALSA API requires the driver to provide a cyclic sample buffer (or
>> something that behaves like one).
>>
>> However, not all hardware works this way.  USB and FireWire require the
>> driver to continually queue new packets, whose size and timing are
>> determined by the bus clock and are not directly related to the ALSA
>> ring buffer.  These drivers use double buffering; the actual DMA happens
>> from those packets, not from the ring buffer.
>>
>
> If those queued packets/urb cannot be rewind, snd_pcm_rewindable should
> return zero for those driver

Not really.

As I understand it, the kernel periodically converts a piece of the ring 
buffer (located in RAM) into an URB, and it gets sent through the USB 
bus. Parts of the buffer that are not yet converted to URB are perfectly 
rewindable.

In other words, for USB devices, the kernel already implements the 
"low-latency background thread that makes unrewindable devices 
rewindable" idea that I discussed (as a strawman proposal) here for 
userspace:

http://mailman.alsa-project.org/pipermail/alsa-devel/2014-September/080868.html

-- 
Alexander E. Patrakov
