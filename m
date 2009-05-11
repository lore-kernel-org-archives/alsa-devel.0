From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: appl_ptr and DMA overrun at end of stream
Date: Mon, 11 May 2009 09:03:14 -0400
Message-ID: <9e4733910905110603i3d354ce9lfc74bcbeca6c6bed@mail.gmail.com>
References: <9e4733910905070923i16683486n678653ba56c28b74@mail.gmail.com>
	<s5hfxfcaru3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 148072480A
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 15:03:15 +0200 (CEST)
Received: by qyk1 with SMTP id 1so3927139qyk.16
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2009 06:03:14 -0700 (PDT)
In-Reply-To: <s5hfxfcaru3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, May 11, 2009 at 5:53 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 7 May 2009 12:23:51 -0400,
> Jon Smirl wrote:
>>
>> I am having problem with DMA overrun at the end of the audio stream.
>> Is there an official way to know the address of the last valid audio
>> sample?
>>
>> mpc5200 ac97 is keeping a bunch of descriptors queued in a loop to
>> continuously play music. I believe this is the way ALSA wants it. Now
>> say the last period is
>> half full. ALSA fills the other half with silence. When that period
>> finishes playing it will generate an interrupt. ALSA comes back from
>> that interrupt with trigger(STOP).
>>
>> But, our CPU is slow compared to a 3Ghz desktop, there is considerable
>> latency from the period end interrupt to trigger(STOP) getting called.
>> =A0So the DMA hardware starts playing the next period before
>> trigger(STOP) can get the DMA stopped. =A0I turned off tried turning off
>> BestComm, flushing the FIFO, and turning off the audio clocks. =A0None
>> can be done fast enough. That next period contains stale data from
>> further back in the stream. When the front part of it plays it makes a
>> burst of noise.
>>
>> What I need is the address of the end of valid data in the buffer. I
>> need that address so that I can program the DMA automatically stop at
>> end of stream and not overrun. Search around in the guys of ALSA I
>> found appl_ptr. I can use appl_ptr to determine the location of end of
>> stream and prevent DMA overrun. When there is no valid data I don't
>> enqueue the
>> descriptor.
>
> Right. =A0This is the value to check in your case.

What do think about redesigning the ALSA DMA interface to support
detection of over and under run? Leaving the DMA engine in a loop and
not coordinating with ALSA as to where the valid data is does not seem
to be a safe way of exchanging data. That interface may be a source of
the problems pulseaudio is encountering.

A simple solution would be for snd_pcm_period_elapsed() to return
physical address of the last valid sample. That would let me avoid
playing with  s->runtime->control->appl_ptr. You could provide the
same data in the pointer() function.

If I know where the end of valid data is, I can program the hardware
to play silence instead of stale data. Don't other embedded systems
suffer from this same problem? Seems to me like every system has this
problem, but desktop machines are fast enough that you can't hear it.

>
>> =A0s->appl_ptr track the previous value of =A0s->runtime->control->appl_=
ptr.
>> The difference between these two is the amount of valid data in the buff=
er.
>> When this difference goes to zero, I stop queueing new buffers to ALSA.
>
> Yes, that'll work, I guess.
>
>
>> That fixes the DMA overrun.
>>
>> static void psc_dma_bcom_enqueue_next_buffer(struct psc_dma_stream *s)
>> {
>> =A0 =A0 =A0 =A0struct bcom_bd *bd;
>>
>> =A0 =A0 =A0 =A0while (s->appl_ptr < s->runtime->control->appl_ptr) {
>
> You'd need to think of boundary overlap, too.
> It's a bit nasty because we wrap the value at runtime->boundary...
>
>
> thanks,
>
> Takashi
>



-- =

Jon Smirl
jonsmirl@gmail.com
