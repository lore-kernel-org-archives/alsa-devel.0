From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: appl_ptr and DMA overrun at end of stream
Date: Mon, 11 May 2009 11:50:22 -0400
Message-ID: <9e4733910905110850g2b1620a3q47ad2e5a9421a69c@mail.gmail.com>
References: <9e4733910905070923i16683486n678653ba56c28b74@mail.gmail.com>
	<s5hfxfcaru3.wl%tiwai@suse.de>
	<9e4733910905110603i3d354ce9lfc74bcbeca6c6bed@mail.gmail.com>
	<alpine.LNX.2.00.0905111537090.25064@eeebox2.perex-int.cz>
	<9e4733910905110811k643d899bjf7bd37ea029ac5cc@mail.gmail.com>
	<s5hfxfbzlz6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by alsa0.perex.cz (Postfix) with ESMTP id DC4891037F5
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 17:50:24 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id k40so1217237wah.16
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2009 08:50:23 -0700 (PDT)
In-Reply-To: <s5hfxfbzlz6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, May 11, 2009 at 11:40 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 11 May 2009 11:11:55 -0400,
> Jon Smirl wrote:
>>
>> On Mon, May 11, 2009 at 9:45 AM, Jaroslav Kysela <perex@perex.cz> wrote:
>> > On Mon, 11 May 2009, Jon Smirl wrote:
>> >
>> >>> Right. =A0This is the value to check in your case.
>> >>
>> >> What do think about redesigning the ALSA DMA interface to support
>> >> detection of over and under run? Leaving the DMA engine in a loop and
>> >> not coordinating with ALSA as to where the valid data is does not seem
>> >> to be a safe way of exchanging data. That interface may be a source of
>> >> the problems pulseaudio is encountering.
>> >>
>> >> A simple solution would be for snd_pcm_period_elapsed() to return
>> >> physical address of the last valid sample. That would let me avoid
>> >> playing with =A0s->runtime->control->appl_ptr. You could provide the
>> >> same data in the pointer() function.
>> >
>> > More simpler solution is to check the stream state in the low level dr=
iver.
>> > If it's in DRAINING state, then end of stream is signaled from the
>> > application and driver might not queue next buffer. We may also add an=
other
>> > callback (or use ioctl callback) to pass this stream state change to t=
he
>> > lowlevel driver immediately, so the driver might react more quickly on=
 this
>> > situation.
>> >
>>
>> Quickness is the wrong way to think about this problem. ALSA knows exact=
ly
>> when it has placed valid data into the buffer.
>
> Not really. =A0When the mmap mode is used, the update isn't always
> notified to the driver and the transfer can be completely
> asynchronous.

This seems to me to be a broken design. ALSA is being put into the
position of guessing when the application has supplied new data.
Shouldn't the app be required to make a commit() call after filling in
the data? Without commit it is impossible to detect over/underrun.


>
>> It's the asynchronous nature of
>> the interface that is the problem. Leaving DMA free running and counting
>> on ALSA to be fast enough to keep data in front of the DMA engine is not
>> a reliable mechanism.
>>
>> Wouldn't it be better to get a synchronous notification and know for sure
>> what data is valid?
>
> The question is whether you need mmap or not. =A0If you don't need mmap,
> all the transfer and the buffer update could be much more simplified
> robust. =A0But if you support mmap, appl_ptr can be updated at any time
> even without the driver interaction, so the async support is
> required like the current model.
>
>> DRAINING might fix the end of stream, but what if the
>> user space app gets swapped out and can't provide data fast enough?
>>
>> Most reliable for me would be to add enough info so that in my IRQ handl=
er
>> and the pointer() routine, I can check and see whether ALSA has empty/fi=
lled
>> the DMA buffers and then only add them to the queue when they are full of
>> valid data.
>
> Actually, for a hardware like yours, the appl_ptr check could help
> indeed. =A0Similar implementations are found in
> include/sound/pcm-direct.h. =A0It's basically for a hardware with own
> buffer to transfer, but a similar idea can be used for the DMA queue
> type devices, and hopefully can be generalized in a better form...
>
>
> Takashi
>



-- =

Jon Smirl
jonsmirl@gmail.com
