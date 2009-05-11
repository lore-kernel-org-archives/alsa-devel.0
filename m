From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: appl_ptr and DMA overrun at end of stream
Date: Mon, 11 May 2009 11:11:55 -0400
Message-ID: <9e4733910905110811k643d899bjf7bd37ea029ac5cc@mail.gmail.com>
References: <9e4733910905070923i16683486n678653ba56c28b74@mail.gmail.com>
	<s5hfxfcaru3.wl%tiwai@suse.de>
	<9e4733910905110603i3d354ce9lfc74bcbeca6c6bed@mail.gmail.com>
	<alpine.LNX.2.00.0905111537090.25064@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by alsa0.perex.cz (Postfix) with ESMTP id A42402487B
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 17:11:57 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so2240788wfg.23
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2009 08:11:56 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0905111537090.25064@eeebox2.perex-int.cz>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, May 11, 2009 at 9:45 AM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Mon, 11 May 2009, Jon Smirl wrote:
>
>>> Right. =A0This is the value to check in your case.
>>
>> What do think about redesigning the ALSA DMA interface to support
>> detection of over and under run? Leaving the DMA engine in a loop and
>> not coordinating with ALSA as to where the valid data is does not seem
>> to be a safe way of exchanging data. That interface may be a source of
>> the problems pulseaudio is encountering.
>>
>> A simple solution would be for snd_pcm_period_elapsed() to return
>> physical address of the last valid sample. That would let me avoid
>> playing with =A0s->runtime->control->appl_ptr. You could provide the
>> same data in the pointer() function.
>
> More simpler solution is to check the stream state in the low level drive=
r.
> If it's in DRAINING state, then end of stream is signaled from the
> application and driver might not queue next buffer. We may also add anoth=
er
> callback (or use ioctl callback) to pass this stream state change to the
> lowlevel driver immediately, so the driver might react more quickly on th=
is
> situation.
>

Quickness is the wrong way to think about this problem. ALSA knows exactly
when it has placed valid data into the buffer. It's the asynchronous nature=
 of
the interface that is the problem. Leaving DMA free running and counting
on ALSA to be fast enough to keep data in front of the DMA engine is not
a reliable mechanism.

Wouldn't it be better to get a synchronous notification and know for sure
what data is valid? DRAINING might fix the end of stream, but what if the
user space app gets swapped out and can't provide data fast enough?

Most reliable for me would be to add enough info so that in my IRQ handler
and the pointer() routine, I can check and see whether ALSA has empty/filled
the DMA buffers and then only add them to the queue when they are full of
valid data.


> All other cases are bad (underruns / overruns) and I'm not sure if we can=
 do
> much. There is silence mode in the midlevel of kernel API to fill some
> samples in the ring buffer ahead with silence so applications can choose =
if
> last samples will be played in the underrun case or if silence will be
> played.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>



-- =

Jon Smirl
jonsmirl@gmail.com
