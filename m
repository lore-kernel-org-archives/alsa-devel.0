From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Sat, 27 Jun 2015 20:28:56 +0500
Message-ID: <558EC138.8090906@gmail.com>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
 <557E86DD.8020709@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 by alsa0.perex.cz (Postfix) with ESMTP id AA48826062F
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2015 17:28:59 +0200 (CEST)
Received: by wicnd19 with SMTP id nd19so66609546wic.1
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2015 08:28:59 -0700 (PDT)
In-Reply-To: <557E86DD.8020709@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Arun Raghavan <arun@accosted.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, clemens@ladisch.de, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

15.06.2015 13:03, Lars-Peter Clausen wrote:
> On 06/12/2015 02:29 PM, Arun Raghavan wrote:
>> So I guess the first thing that would be nice to have is a clear
>> meaning of these two flags. With this done, we could potentially get
>> to the API to report the transfer size from the driver.
>
> Yeah, the meaning of those flags is somewhat fuzzy and may have changed
> over time as well. Here is my understanding of the flags, might not
> necessarily be 100% correct.
>
> SNDRV_PCM_INFO_BLOCK_TRANSFER means that the data is copied from the
> user accessible buffer in blocks of one period. Typically these kinds of
> devices have some dedicated audio memory that is not accessible via
> normal memory access and a DMA is setup to copy data from main memory to
> the dedicated memory. This DMA transfers the data from the main memory
> to the dedicated memory in chunks of period size. But otherwise the
> controller might still be capable of reporting a accurate pointer
> position down to the sample/frame level.
>
> So SNDRV_PCM_INFO_BLOCK_TRANSFER is mainly important for rewind handling
> and devices with that flag set might need additional headroom since the
> data up to one period after the pointer position has already been copied
> to the dedicated memory and hence can no longer be overwritten.
>
> SNDRV_PCM_INFO_BATCH on the other hand has become to mean that the
> device is only capable of reporting the audio pointer with a coarse
> granularity. Typically this means a period sized granularity, but there
> are some other cases as well.

I have tried to convert this text into something that can be added to 
the doxygen documentation in alsa-lib, but failed to verify the text. 
Here is why.

In kernel sources, sound/pci/hda/hda_controller.c mentions 
SNDRV_PCM_INFO_BLOCK_TRANSFER. However, sub-period rewinds work fine on 
this driver, and the avail granularity is something like 64 bytes. So, 
either the description is wrong (i.e., "large blocks, possibly up to one 
period size, but 64 bytes still counts as large" is actually meant - but 
that would be useless), or the flag is wrongly set in the driver.

-- 
Alexander E. Patrakov
