From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Mon, 15 Jun 2015 10:03:41 +0200
Message-ID: <557E86DD.8020709@metafoo.de>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-224.synserver.de (smtp-out-224.synserver.de
 [212.40.185.224])
 by alsa0.perex.cz (Postfix) with ESMTP id 32B5E26069D
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 10:03:45 +0200 (CEST)
In-Reply-To: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arun Raghavan <arun@accosted.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, clemens@ladisch.de, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 06/12/2015 02:29 PM, Arun Raghavan wrote:
> Hi folks,
> I'd like to bring this one up again, since we are currently in the
> sub-optimal position of forcing ~100 ms latency on USB devices. The
> original thread is here --
> http://mailman.alsa-project.org/pipermail/alsa-devel/2013-December/069666.html
>
> I see two flags that are possibly of consequence here:
> SNDRV_PCM_INFO_BATCH and SNDRV_PCM_INFO_BLOCK_TRANSFER. I'm not sure
> what these mean -- the documentation mentions "double buffering" for
> the batch flag, and just that the block transfer means "block
> transfer". :-)
>
> We've spoken about batch meaning either transfers in period size
> chunks, or some fixed chunk size. It seems that it would make more
> sense for it to mean the former, and block transfer to mean the
> latter.
>
> So I guess the first thing that would be nice to have is a clear
> meaning of these two flags. With this done, we could potentially get
> to the API to report the transfer size from the driver.

Yeah, the meaning of those flags is somewhat fuzzy and may have changed over 
time as well. Here is my understanding of the flags, might not necessarily 
be 100% correct.

SNDRV_PCM_INFO_BLOCK_TRANSFER means that the data is copied from the user 
accessible buffer in blocks of one period. Typically these kinds of devices 
have some dedicated audio memory that is not accessible via normal memory 
access and a DMA is setup to copy data from main memory to the dedicated 
memory. This DMA transfers the data from the main memory to the dedicated 
memory in chunks of period size. But otherwise the controller might still be 
capable of reporting a accurate pointer position down to the sample/frame level.

So SNDRV_PCM_INFO_BLOCK_TRANSFER is mainly important for rewind handling and 
devices with that flag set might need additional headroom since the data up 
to one period after the pointer position has already been copied to the 
dedicated memory and hence can no longer be overwritten.

SNDRV_PCM_INFO_BATCH on the other hand has become to mean that the device is 
only capable of reporting the audio pointer with a coarse granularity. 
Typically this means a period sized granularity, but there are some other 
cases as well.

>
> I did notice that there is a snd_pcm_hw_params_get_fifo_size(). Is
> this something we could use for the purpose of transfer size
> reporting, by any chance?

I think the idea with fifo_size() is mainly to aide with audio latency 
measurement. I.e. how many samples before the pointer() position are still 
inside the audio pipeline and have not yet reached the analog domain. But 
since there are now users that rely on it a lot of driver don't really 
bothered with setting it to the correct value. And for the use case here 
data is on the wrong side of the pointer() value as well. What we need is 
some kind of indication of the fuzziness of the pointer() value. E.g. how 
far can it be away from the actual position in the stream.

- Lars
