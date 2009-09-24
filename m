From: Anuj Aggarwal <anuj.aggarwal@gmail.com>
Subject: Re: Application supporting forward/rewind APIs
Date: Thu, 24 Sep 2009 14:31:55 +0530
Message-ID: <2ee9e08d0909240201l5cf5675m111b6da1434cff60@mail.gmail.com>
References: <2ee9e08d0909240034t6fdab6aftc24e733621638f09@mail.gmail.com>
	<s5hocp0vlm6.wl%tiwai@suse.de>
	<4f3252890909240057l1a2b5b88m861dea551f69afce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f175.google.com (mail-yx0-f175.google.com
	[209.85.210.175])
	by alsa0.perex.cz (Postfix) with ESMTP id DD79A103817
	for <Alsa-devel@alsa-project.org>;
	Thu, 24 Sep 2009 11:02:16 +0200 (CEST)
Received: by yxe5 with SMTP id 5so1930172yxe.24
	for <Alsa-devel@alsa-project.org>; Thu, 24 Sep 2009 02:02:15 -0700 (PDT)
In-Reply-To: <4f3252890909240057l1a2b5b88m861dea551f69afce@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Yeah, I am looking for some sample application to test forward/rewind
functionality.

Regards,
Anuj

On Thu, Sep 24, 2009 at 1:27 PM, Raymond Yau
<superquad.vortex2@gmail.com> wrote:
> Do you mean that there is no test program to verify the implementation is
> correct ?
>
> Some sound card 's hardware has FIFO buffer.
>
> For example , au88x0
>
> according to patent 6167465
>
> Additionally, a first-in-first-out (FIFO) buffer is established for the DMA
> channel. Then a DMA request is generated in order to begin filling the FIFO
> buffer with data from the first data segment 150(0) using the information
> provided by CPU 210.
>
>
> The FIFO buffer may be any suitable size capable of handling bus latencies
> while small enough such that the memory requirement is not overly
> burdensome. In one embodiment of the present invention, the FIFO buffer is
> 32 samples or words in depth, which would withstand a maximum bus latency of
> about 4 microseconds. By way of example, if 48 DMA channels trigger
> simultaneously, with a trigger level set at half the buffer size (16
> samples), each DMA channel can wait 16 samples (20 microseconds per sample),
> or approximately 320 microseconds before running out of data.
>
>
> It seem that alsa-lib should not allow application to rewind the application
> pointer to hardware pointer since you cannot write the next sample because
> of FIFO buffer even using mmap read/write
>
> or bug in *snd_pcm_rewindable() ?*
>
>
> 2009/9/24 Takashi Iwai <tiwai@suse.de>
>
>> At Thu, 24 Sep 2009 13:04:24 +0530,
>> Anuj Aggarwal wrote:
>> >
>> > Hi,
>> >
>> > I want to try the forward/rewind APIs supported by the ALSA library.
>> > Can someone point to an ALSA application which exercises these APIs?
>>
>> Pulseaudio is using snd_pcm_rewind().
>> About snd_pcm_forward(), I don't know of...
>>
>>
>> Takashi
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- 
Best Regards,
Anuj Aggarwal
