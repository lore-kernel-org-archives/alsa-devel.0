From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Mon, 15 Jun 2015 16:16:02 +0200
Message-ID: <557EDE22.7080808@metafoo.de>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>	<557E86DD.8020709@metafoo.de>	<CAN8cciYApKja0e0U7Uy2YG2ySemfhvKfLGUueGyFx5ajjyqKBA@mail.gmail.com>	<557EBEAA.70004@metafoo.de>
 <CAN8cciZ4B2X+o4AXdCGEEAFCcX+iWqyf+FvMkEkrSu3Vt8Vx8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-020.synserver.de (smtp-out-023.synserver.de
 [212.40.185.23])
 by alsa0.perex.cz (Postfix) with ESMTP id A9486264F0D
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 16:16:04 +0200 (CEST)
In-Reply-To: <CAN8cciZ4B2X+o4AXdCGEEAFCcX+iWqyf+FvMkEkrSu3Vt8Vx8Q@mail.gmail.com>
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
Cc: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Arun Raghavan <arun@accosted.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 06/15/2015 03:34 PM, Raymond Yau wrote:
>
>  >>>>
>  >>>>
>  >>>> Hi folks,
>  >>>> I'd like to bring this one up again, since we are currently in the
>  >>>> sub-optimal position of forcing ~100 ms latency on USB devices. The
>  >>>> original thread is here --
>  >>>>
>  >>
> http://mailman.alsa-project.org/pipermail/alsa-devel/2013-December/069666.html
>  >>>>
>  >>>>
>  >>>> I see two flags that are possibly of consequence here:
>  >>>> SNDRV_PCM_INFO_BATCH and SNDRV_PCM_INFO_BLOCK_TRANSFER. I'm not sure
>  >>>> what these mean -- the documentation mentions "double buffering" for
>  >>>> the batch flag, and just that the block transfer means "block
>  >>>> transfer". :-)
>  >>>>
>  >>>> We've spoken about batch meaning either transfers in period size
>  >>>> chunks, or some fixed chunk size. It seems that it would make more
>  >>>> sense for it to mean the former, and block transfer to mean the
>  >>>> latter.
>  >>>>
>  >>>> So I guess the first thing that would be nice to have is a clear
>  >>>> meaning of these two flags. With this done, we could potentially get
>  >>>> to the API to report the transfer size from the driver.
>  >>>
>  >>>
>  >>>
>  >>> Yeah, the meaning of those flags is somewhat fuzzy and may have changed
>  >>
>  >> over time as well. Here is my understanding of the flags, might not
>  >> necessarily be 100% correct.
>  >>>
>  >>>
>  >>> SNDRV_PCM_INFO_BLOCK_TRANSFER means that the data is copied from the user
>  >>
>  >> accessible buffer in blocks of one period. Typically these kinds of devices
>  >> have some dedicated audio memory that is not accessible via normal memory
>  >> access and a DMA is setup to copy data from main memory to the dedicated
>  >> memory. This DMA transfers the data from the main memory to the dedicated
>  >> memory in chunks of period size. But otherwise the controller might still
>  >> be capable of reporting a accurate pointer position down to the
>  >> sample/frame level.
>  >>>
>  >>>
>  >>> So SNDRV_PCM_INFO_BLOCK_TRANSFER is mainly important for rewind handling
>  >>
>  >> and devices with that flag set might need additional headroom since the
>  >> data up to one period after the pointer position has already been copied to
>  >> the dedicated memory and hence can no longer be overwritten.
>  >>>
>  >>>
>  >>> SNDRV_PCM_INFO_BATCH on the other hand has become to mean that the device
>  >>
>  >> is only capable of reporting the audio pointer with a coarse granularity.
>  >> Typically this means a period sized granularity, but there are some other
>  >> cases as well.
>  >>>
>  >>>
>  >>
>  >> DSP_CAP_REALTIME bit tells if the device/operating system supports precise
>  >> reporting of output pointer position using SNDCTL_DSP_GETxPTR. Precise
>  >> means that accuracy of the reported playback pointer (time) is around few
>  >> samples. Without this capability the playback/recording position is
>  >> reported using precision of one fragment.
>  >>
>  >> DSP_CAP_BATCH bit means that the device has some kind of local storage for
>  >> recording and/or playback. For this reason the information reported by
>  >> SNDCTL_DSP_GETxPTR is very inaccurate.
>  >>
>  >> Are those alsa cap have the similar meaning of those oss cap ?
>  >
>  >
>  > I would say historically SNDRV_PCM_INFO_BATCH had the same meaning as
> DSP_CAP_BATCH, but it has also come to have the inverse meaning to
> DSP_CAP_REALTIME. By default applications can assume that the pointer is
> accurate down to a few samples, but if SNDRV_PCM_INFO_BATCH is set it is
> less accurate and can be everything up to period size precession.
>  >
>  > SNDRV_PCM_INFO_BLOCK_TRANSFER is different from all of them though.
>
> DMA_RESIDUE_GRANULARITY_DESCRIPTOR
> DMA_RESIDUE_GRANULARITY_SEGMENT
> DMA_RESIDUE_GRANULARITY_BURST
>
> Can this be regard as bad, normal and good accuracy ?

DMA_RESIDUE_GRANULARITY_DESCRIPTOR is more like completely and utterly 
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


DMA_RESIDUE_GRANULARITY_SEGMENT means the hardware/driver can report the 
pointer position with a period precession. In this case the BATCH flag will 
be set for the PCM.

DMA_RESIDUE_GRANULARITY_BURST means it can report the position with a 
granularity of a few samples. Typically half the audio FIFO size.

>
> https://bugs.freedesktop.org/show_bug.cgi?id=86262
>
> Although the resolution seem less than period size but the deviation is
> quite large , can we still regard this result are accurate up to one period ?

This looks like a separate issue that's just made visible by the BATCH flag 
patch with that particular hardware.

>
> http://lists.freedesktop.org/archives/pulseaudio-discuss/2015-June/024022.html
>
> This is accurate up to one period
>
> Why do we need flag for exactly one period since most of the driver use irq
> should increment one period when interrupt occur ?
>
> We only need to know those good accuracy can use timer base and those bad
> accuracy need special care

Yes, and that's what the BATCH flag tells us.
