From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Wed, 17 Jun 2015 10:27:08 +0200
Message-ID: <55812F5C.8010502@metafoo.de>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>	<557E86DD.8020709@metafoo.de>	<CAN8cciYApKja0e0U7Uy2YG2ySemfhvKfLGUueGyFx5ajjyqKBA@mail.gmail.com>	<557EBEAA.70004@metafoo.de>	<CAN8cciZ4B2X+o4AXdCGEEAFCcX+iWqyf+FvMkEkrSu3Vt8Vx8Q@mail.gmail.com>	<557EDE22.7080808@metafoo.de>
 <CAN8cciaYSJVySbyAr_af+0f-govGXEp2CsmQkPLpr=mfc_Quhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-037.synserver.de (smtp-out-037.synserver.de
 [212.40.185.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 73ECA265B72
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 10:27:12 +0200 (CEST)
In-Reply-To: <CAN8cciaYSJVySbyAr_af+0f-govGXEp2CsmQkPLpr=mfc_Quhg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Arun Raghavan <arun@accosted.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 06/16/2015 04:33 AM, Raymond Yau wrote:
>
>  >> DMA_RESIDUE_GRANULARITY_DESCRIPTOR
>  >> DMA_RESIDUE_GRANULARITY_SEGMENT
>  >> DMA_RESIDUE_GRANULARITY_BURST
>  >>
>  >> Can this be regard as bad, normal and good accuracy ?
>  >
>  >
>  > DMA_RESIDUE_GRANULARITY_DESCRIPTOR is more like completely and utterly
> useless. It means the driver can only tell whether the descriptor has
> finished or not, in a cyclic transfer the descriptor will never finish so
> the driver will always report the same. Currently we fall back to counting
> the number of period completion callbacks we get in this mode. This is
> slightly prone to race conditions since it is legal to coalesce two
> completion callbacks if a second one is scheduled before the first has run.
> This will only happen with a very high system load, but it can happen.
> Luckily most DMA drivers that are used for audio do support
> DMA_RESIDUE_GRANULARITY_SEGMENT now and there is a deprecation plan,
> including eventually stopping to support them altogether, for drivers that
> only support DMA_RESIDUE_GRANULARITY_DESCRIPTOR.
>  >
>  >
>  > DMA_RESIDUE_GRANULARITY_SEGMENT means the hardware/driver can report the
> pointer position with a period precession. In this case the BATCH flag will
> be set for the PCM.
>  >
>  > DMA_RESIDUE_GRANULARITY_BURST means it can report the position with a
> granularity of a few samples. Typically half the audio FIFO size.
>  >
>  >
>
> Residue is updated after each transferred
> *  burst. This is typically only supported if the hardware has a progress
> *  register of some sort (E.g. a register with the current read/write address
> *  or a register with the amount of bursts/beats/bytes that have been
> *  transferred or still need to be transferred).
>
> The pointer callback of both snd-hda-intel and snd-oxygen are reading from
> hardware register
>
> Do this mezn that only those driver which pointer callback read from
> hardware register are suitable for timer schedluing ?

Yes, more or less, but not exclusively. The pointer callback needs to a have 
a low enough precession for timer based scheduling to work. Where the 
threshold is where it starts and stops to work is a bit hard to say. Period 
based resolution is not good enough, a few samples based resolution is very 
good. USB seems to be somewhere in the middle between those two, the 
resolution is better then a full period, but more than just a few samples. 
But it seems to be good enough for the timer based scheduling algorithm to 
work. It still gets disabled for USB though since the USB driver stets the 
BATCH flag.

The main issue is that there is currently no method for a driver to 
advertise the exact pointer granularity to userspace applications. There is 
either BATCH flag not set which means very good accuracy or BATCH flag set 
which means very bad accuracy. USB which does not have a very good accuracy, 
but still a reasonably good accuracy, is somewhere in the middle between 
those two extremes.

>
> Do you need additional hardware specific feature (e.g. can disable period
> interrupt ) ?

No. Disabling the period interrupt is a feature that can be used to reduce 
power consumption and is optional.

>
>  >>
>  >> https://bugs.freedesktop.org/show_bug.cgi?id=86262
>  >>
>  >> Although the resolution seem less than period size but the deviation is
>  >> quite large , can we still regard this result are accurate up to one
> period ?
>  >
>  >
>  > This looks like a separate issue that's just made visible by the BATCH
> flag patch with that particular hardware.
>
> https://bugs.freedesktop.org/show_bug.cgi?id=86262#c19
>
> The hw_ptr of those two usb audio devices seem increment in 5 to 6ms which
> is quite different from
>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/usb?id=976b6c064a957445eb0573b270f2d0282630e9b9
>
> For example, testing shows that a high-speed device can handle 32
> frames/period and 3 periods/buffer at 48 KHz, whereas the current driver
> starts to get glitchy at 64 frames/period and 2 periods/buffer.
>
> Do the result mean that only high speed device support 1.5ms latency while
> the other usb audio devices may support 15 to 18 ms ?
>
>  >
>  >>
>  >>
> http://lists.freedesktop.org/archives/pulseaudio-discuss/2015-June/024022.html
>  >>
>  >> This is accurate up to one period
>  >>
>  >> Why do we need flag for exactly one period since most of the driver use irq
>  >> should increment one period when interrupt occur ?
>  >>
>  >> We only need to know those good accuracy can use timer base and those bad
>  >> accuracy need special care
>  >
>  >
>  > Yes, and that's what the BATCH flag tells us.
>
> For those sound cards support low latency, the application must use smaller
> petiod size which match the requestef latency. Most drivers only support
> fixed latency. Only those sound card with good accuracy can adjust latency
> without changing period size

Yes, without a good precession pointer the lower bound for the latency will 
be determined by the period size. A smaller period size means less latency.
