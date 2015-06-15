From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Mon, 15 Jun 2015 14:01:46 +0200
Message-ID: <557EBEAA.70004@metafoo.de>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
 <557E86DD.8020709@metafoo.de>
 <CAN8cciYApKja0e0U7Uy2YG2ySemfhvKfLGUueGyFx5ajjyqKBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-224.synserver.de (smtp-out-224.synserver.de
 [212.40.185.224])
 by alsa0.perex.cz (Postfix) with ESMTP id D0531260695
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 14:02:10 +0200 (CEST)
In-Reply-To: <CAN8cciYApKja0e0U7Uy2YG2ySemfhvKfLGUueGyFx5ajjyqKBA@mail.gmail.com>
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

On 06/15/2015 01:39 PM, Raymond Yau wrote:
>>>
>>> Hi folks,
>>> I'd like to bring this one up again, since we are currently in the
>>> sub-optimal position of forcing ~100 ms latency on USB devices. The
>>> original thread is here --
>>>
> http://mailman.alsa-project.org/pipermail/alsa-devel/2013-December/069666.html
>>>
>>> I see two flags that are possibly of consequence here:
>>> SNDRV_PCM_INFO_BATCH and SNDRV_PCM_INFO_BLOCK_TRANSFER. I'm not sure
>>> what these mean -- the documentation mentions "double buffering" for
>>> the batch flag, and just that the block transfer means "block
>>> transfer". :-)
>>>
>>> We've spoken about batch meaning either transfers in period size
>>> chunks, or some fixed chunk size. It seems that it would make more
>>> sense for it to mean the former, and block transfer to mean the
>>> latter.
>>>
>>> So I guess the first thing that would be nice to have is a clear
>>> meaning of these two flags. With this done, we could potentially get
>>> to the API to report the transfer size from the driver.
>>
>>
>> Yeah, the meaning of those flags is somewhat fuzzy and may have changed
> over time as well. Here is my understanding of the flags, might not
> necessarily be 100% correct.
>>
>> SNDRV_PCM_INFO_BLOCK_TRANSFER means that the data is copied from the user
> accessible buffer in blocks of one period. Typically these kinds of devices
> have some dedicated audio memory that is not accessible via normal memory
> access and a DMA is setup to copy data from main memory to the dedicated
> memory. This DMA transfers the data from the main memory to the dedicated
> memory in chunks of period size. But otherwise the controller might still
> be capable of reporting a accurate pointer position down to the
> sample/frame level.
>>
>> So SNDRV_PCM_INFO_BLOCK_TRANSFER is mainly important for rewind handling
> and devices with that flag set might need additional headroom since the
> data up to one period after the pointer position has already been copied to
> the dedicated memory and hence can no longer be overwritten.
>>
>> SNDRV_PCM_INFO_BATCH on the other hand has become to mean that the device
> is only capable of reporting the audio pointer with a coarse granularity.
> Typically this means a period sized granularity, but there are some other
> cases as well.
>>
>
> DSP_CAP_REALTIME bit tells if the device/operating system supports precise
> reporting of output pointer position using SNDCTL_DSP_GETxPTR. Precise
> means that accuracy of the reported playback pointer (time) is around few
> samples. Without this capability the playback/recording position is
> reported using precision of one fragment.
>
> DSP_CAP_BATCH bit means that the device has some kind of local storage for
> recording and/or playback. For this reason the information reported by
> SNDCTL_DSP_GETxPTR is very inaccurate.
>
> Are those alsa cap have the similar meaning of those oss cap ?

I would say historically SNDRV_PCM_INFO_BATCH had the same meaning as 
DSP_CAP_BATCH, but it has also come to have the inverse meaning to 
DSP_CAP_REALTIME. By default applications can assume that the pointer is 
accurate down to a few samples, but if SNDRV_PCM_INFO_BATCH is set it is 
less accurate and can be everything up to period size precession.

SNDRV_PCM_INFO_BLOCK_TRANSFER is different from all of them though.
