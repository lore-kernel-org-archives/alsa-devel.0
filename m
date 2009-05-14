From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: appl_ptr and DMA overrun at end of stream
Date: Thu, 14 May 2009 10:25:22 -0400
Message-ID: <9e4733910905140725l23a4c4farb42e97923dab8b52@mail.gmail.com>
References: <9e4733910905070923i16683486n678653ba56c28b74@mail.gmail.com>
	<s5hfxfbzlz6.wl%tiwai@suse.de>
	<9e4733910905110850g2b1620a3q47ad2e5a9421a69c@mail.gmail.com>
	<s5hd4afzl5r.wl%tiwai@suse.de>
	<9e4733910905110928g618475bj2a4f47d62e4c5e14@mail.gmail.com>
	<s5h8wl3zj2j.wl%tiwai@suse.de>
	<9e4733910905111009w10017c21kdcf31e1d26ec231d@mail.gmail.com>
	<alpine.LNX.2.00.0905111915350.25064@eeebox2.perex-int.cz>
	<9e4733910905111100o19e2c368s6fd9e3957c84260f@mail.gmail.com>
	<s5h63g4vuh2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.246])
	by alsa0.perex.cz (Postfix) with ESMTP id DDD2E10397A
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 16:25:24 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id k29so651007rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 14 May 2009 07:25:23 -0700 (PDT)
In-Reply-To: <s5h63g4vuh2.wl%tiwai@suse.de>
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

On Thu, May 14, 2009 at 6:39 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 11 May 2009 14:00:59 -0400,
> Jon Smirl wrote:
>>
>> On Mon, May 11, 2009 at 1:37 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>> > On Mon, 11 May 2009, Jon Smirl wrote:
>> >
>> >> Checking for over/under run in software is not reliable since the DMA
>> >> hardware runs asynchronously with the CPU. There will always be
>> >> variable latencies between when the CPU detects the condition and when
>> >> it can control the DMA hardware. =A0The only reliable way to do this =
is
>> >> to program the DMA hardware to do itself. AFAIK all DMA modern
>> >> hardware can be programed to do this if the right information is made
>> >> available. Programming the DMA hardware to do this is a 100% reliable
>> >> solution and not subject to random latency problems.
>> >
>> > I comment playback for simplicity.
>> >
>> > The key point is when you fill DMA engine. Nothing forces you to queue=
 whole
>> > ring buffer in the scatter-gather list. You may queue just one period =
and
>> > then next one (including partial). The available samples can be determ=
ined
>> > using snd_pcm_playback_hw_avail() function at any time. If you have la=
rge
>>
>> I didn't know about this function. I can use it to replace the direct
>> manipulation of appl_ptr.
>
> Well, this computes a value between appl_ptr and hw_ptr. =A0That is, it
> relies on the current hw_ptr value. =A0Just to make sure...
>
>> > FIFO and you receive interrupt before FIFO goes empty, you can fill pa=
rtial
>> > period. The elapsed notifier does not require any change.
>> >
>> > The underruns should be avoided as first step, because it's really unw=
anted
>> > system behaviour. All methods to fix underruns fails in some respects.
>> >
>> > Also note that we have also mode when appl_ptr is not updated at all (=
when
>> > stop_threshold =3D=3D boundary).
>>
>> How does this mode work? Could it be hidden inside
>> snd_pcm_playback_hw_avail() such that low level drivers don't have to
>> worry about it?
>
> Hm, no, in this case, it won't work properly.
> *_avail() simply tells you a bogus value, even a negative one.
>
> Basically this is a free-wheeling mode, e.g. used by dmix.
> In this mode, you simply ignore appl_ptr but assume that period_size
> samples are available at each period update. =A0So, this would be a
> different implementation.

Free-wheeling mode is basically unreliable. Wouldn't it be better to
start phasing dmix out in favor of pulseaudio?

Why is OSS still in the kernel? Things never seem to die in the audio
world. Other areas add a deprecation warning and then delete the old
systems a year latter.

>
> I don't know whether this mode has to be implemented for the hardware
> like yours. =A0I feel it's better to avoid the free-wheel mode by some
> condition (a new pcm_info flag?)
>
>
> thanks,
>
> Takashi
>



-- =

Jon Smirl
jonsmirl@gmail.com
