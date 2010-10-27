From: Manu Abraham <abraham.manu@gmail.com>
Subject: Re: mapping externally allocated Scatter Gather DMA
	buffers
Date: Wed, 27 Oct 2010 10:33:08 +0530
Message-ID: <AANLkTik3CAaOjM9B10CNVE3g_TdxYoUAsNRYgdn=yhWW@mail.gmail.com>
References: <AANLkTik4VQmsvBiXyoj-wEu5jgjpPVRP0bF7gkp9GJ-E@mail.gmail.com>
	<alpine.LNX.2.00.1010260923070.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E716810381B
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Oct 2010 07:03:09 +0200 (CEST)
Received: by wye20 with SMTP id 20so246044wye.38
	for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2010 22:03:08 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1010260923070.29422@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 26, 2010 at 12:54 PM, Jaroslav Kysela <perex@perex.cz> wrote:

> On Tue, 26 Oct 2010, Manu Abraham wrote:
>
>  Hi,
>>
>> I have been wondering how to interface a Scatter Gather region as a DMA
>> buffer for an Audio Grabbing device.
>> The device is a NOC type device, similar to a SOC, the audio grabber is a
>> part of it, for realizing the audio
>> capabilities on the device.
>>
>> The hardware DMA is mostly a Scatter Gather based engine, and it can be
>> described thus, briefly.
>>
>
> Use snd_pcm_lib_preallocate_pages_for_all() - type SNDRV_DMA_TYPE_DEV_SG
> and snd_pcm_sgbuf_* routines. Check hda_intel.c source for more details




Thanks. I did take a deeper look at it, from a few angles. However still I
am not very clear on some aspects, especially due to the multiple SG buffers
involved. Let me try to make it a bit more clear ..

1. I have exactly 1 stream to be handled/grabbed

2. This single stream consists of 8 SG page tables (buffers), each buffer
can contain multiple frames, but initially to keep code complexity down, I
will have only a single frame per buffer.

3. The Pages (PTE's) in each SG buffer are virtually contiguous, ie, say
buf_pages are vmalloc'd. But one buffer is discontiguous from the other.

4. On the 1st interrupt, likely I can read from the buffer1, on the next
interrupt from buffer2 and so on in a round robin fashion.

5. The SG buffers are allocated much earlier along with hardware
initialization, So these SG buffers do exist, and hence cannot be allocated
again.

In such a circumstance, I wonder how I can populate runtime->dma_area.
Initially I thought that I would simply map the dmabuffer as it is, but
since they are 8 in number and discontiguous between the buffers, just
mapping the buffers alone wouldn't help. After a bit of thoughts, I came up
with a following thought.

A virtual map is created with 8 of these buffers and the base address of
this map is provided to runtime->dma_area

I wonder, whether such a concept will work ?


Best Regards,
Manu
