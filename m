From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Tue, 16 Jun 2015 10:33:15 +0800
Message-ID: <CAN8cciaYSJVySbyAr_af+0f-govGXEp2CsmQkPLpr=mfc_Quhg@mail.gmail.com>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
 <557E86DD.8020709@metafoo.de>
 <CAN8cciYApKja0e0U7Uy2YG2ySemfhvKfLGUueGyFx5ajjyqKBA@mail.gmail.com>
 <557EBEAA.70004@metafoo.de>
 <CAN8cciZ4B2X+o4AXdCGEEAFCcX+iWqyf+FvMkEkrSu3Vt8Vx8Q@mail.gmail.com>
 <557EDE22.7080808@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
 [209.85.214.169])
 by alsa0.perex.cz (Postfix) with ESMTP id E2F5B260705
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 04:33:16 +0200 (CEST)
Received: by obctg8 with SMTP id tg8so2461387obc.3
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 19:33:15 -0700 (PDT)
In-Reply-To: <557EDE22.7080808@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Arun Raghavan <arun@accosted.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>> DMA_RESIDUE_GRANULARITY_DESCRIPTOR
>> DMA_RESIDUE_GRANULARITY_SEGMENT
>> DMA_RESIDUE_GRANULARITY_BURST
>>
>> Can this be regard as bad, normal and good accuracy ?
>
>
> DMA_RESIDUE_GRANULARITY_DESCRIPTOR is more like completely and utterly
useless. It means the driver can only tell whether the descriptor has
finished or not, in a cyclic transfer the descriptor will never finish so
the driver will always report the same. Currently we fall back to counting
the number of period completion callbacks we get in this mode. This is
slightly prone to race conditions since it is legal to coalesce two
completion callbacks if a second one is scheduled before the first has run.
This will only happen with a very high system load, but it can happen.
Luckily most DMA drivers that are used for audio do support
DMA_RESIDUE_GRANULARITY_SEGMENT now and there is a deprecation plan,
including eventually stopping to support them altogether, for drivers that
only support DMA_RESIDUE_GRANULARITY_DESCRIPTOR.
>
>
> DMA_RESIDUE_GRANULARITY_SEGMENT means the hardware/driver can report the
pointer position with a period precession. In this case the BATCH flag will
be set for the PCM.
>
> DMA_RESIDUE_GRANULARITY_BURST means it can report the position with a
granularity of a few samples. Typically half the audio FIFO size.
>
>

Residue is updated after each transferred
*  burst. This is typically only supported if the hardware has a progress
*  register of some sort (E.g. a register with the current read/write
address
*  or a register with the amount of bursts/beats/bytes that have been
*  transferred or still need to be transferred).

The pointer callback of both snd-hda-intel and snd-oxygen are reading from
hardware register

Do this mezn that only those driver which pointer callback read from
hardware register are suitable for timer schedluing ?

Do you need additional hardware specific feature (e.g. can disable period
interrupt ) ?

>>
>> https://bugs.freedesktop.org/show_bug.cgi?id=86262
>>
>> Although the resolution seem less than period size but the deviation is
>> quite large , can we still regard this result are accurate up to one
period ?
>
>
> This looks like a separate issue that's just made visible by the BATCH
flag patch with that particular hardware.

https://bugs.freedesktop.org/show_bug.cgi?id=86262#c19

The hw_ptr of those two usb audio devices seem increment in 5 to 6ms which
is quite different from

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/usb?id=976b6c064a957445eb0573b270f2d0282630e9b9

For example, testing shows that a high-speed device can handle 32
frames/period and 3 periods/buffer at 48 KHz, whereas the current driver
starts to get glitchy at 64 frames/period and 2 periods/buffer.

Do the result mean that only high speed device support 1.5ms latency while
the other usb audio devices may support 15 to 18 ms ?

>
>>
>>
http://lists.freedesktop.org/archives/pulseaudio-discuss/2015-June/024022.html
>>
>> This is accurate up to one period
>>
>> Why do we need flag for exactly one period since most of the driver use
irq
>> should increment one period when interrupt occur ?
>>
>> We only need to know those good accuracy can use timer base and those bad
>> accuracy need special care
>
>
> Yes, and that's what the BATCH flag tells us.

For those sound cards support low latency, the application must use smaller
petiod size which match the requestef latency. Most drivers only support
fixed latency. Only those sound card with good accuracy can adjust latency
without changing period size
