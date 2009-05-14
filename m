From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: appl_ptr and DMA overrun at end of stream
Date: Thu, 14 May 2009 11:29:40 -0400
Message-ID: <9e4733910905140829q129e03cbt21eb9bba868adff9@mail.gmail.com>
References: <9e4733910905070923i16683486n678653ba56c28b74@mail.gmail.com>
	<s5hd4afzl5r.wl%tiwai@suse.de>
	<9e4733910905110928g618475bj2a4f47d62e4c5e14@mail.gmail.com>
	<s5h8wl3zj2j.wl%tiwai@suse.de>
	<9e4733910905111009w10017c21kdcf31e1d26ec231d@mail.gmail.com>
	<alpine.LNX.2.00.0905111915350.25064@eeebox2.perex-int.cz>
	<9e4733910905111100o19e2c368s6fd9e3957c84260f@mail.gmail.com>
	<s5h63g4vuh2.wl%tiwai@suse.de>
	<9e4733910905140725l23a4c4farb42e97923dab8b52@mail.gmail.com>
	<s5hbppvvi64.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DF812442B
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 17:29:41 +0200 (CEST)
Received: by qyk1 with SMTP id 1so2424674qyk.16
	for <alsa-devel@alsa-project.org>; Thu, 14 May 2009 08:29:40 -0700 (PDT)
In-Reply-To: <s5hbppvvi64.wl%tiwai@suse.de>
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

On Thu, May 14, 2009 at 11:05 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 14 May 2009 10:25:22 -0400,
> Jon Smirl wrote:
>>
>> On Thu, May 14, 2009 at 6:39 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Mon, 11 May 2009 14:00:59 -0400,
>> > Jon Smirl wrote:
>> >>
>> >> On Mon, May 11, 2009 at 1:37 PM, Jaroslav Kysela <perex@perex.cz> wro=
te:
>> >> > On Mon, 11 May 2009, Jon Smirl wrote:
>> >> >
>> >> >> Checking for over/under run in software is not reliable since the =
DMA
>> >> >> hardware runs asynchronously with the CPU. There will always be
>> >> >> variable latencies between when the CPU detects the condition and =
when
>> >> >> it can control the DMA hardware. =A0The only reliable way to do th=
is is
>> >> >> to program the DMA hardware to do itself. AFAIK all DMA modern
>> >> >> hardware can be programed to do this if the right information is m=
ade
>> >> >> available. Programming the DMA hardware to do this is a 100% relia=
ble
>> >> >> solution and not subject to random latency problems.
>> >> >
>> >> > I comment playback for simplicity.
>> >> >
>> >> > The key point is when you fill DMA engine. Nothing forces you to qu=
eue whole
>> >> > ring buffer in the scatter-gather list. You may queue just one peri=
od and
>> >> > then next one (including partial). The available samples can be det=
ermined
>> >> > using snd_pcm_playback_hw_avail() function at any time. If you have=
 large
>> >>
>> >> I didn't know about this function. I can use it to replace the direct
>> >> manipulation of appl_ptr.
>> >
>> > Well, this computes a value between appl_ptr and hw_ptr. =A0That is, it
>> > relies on the current hw_ptr value. =A0Just to make sure...
>> >
>> >> > FIFO and you receive interrupt before FIFO goes empty, you can fill=
 partial
>> >> > period. The elapsed notifier does not require any change.
>> >> >
>> >> > The underruns should be avoided as first step, because it's really =
unwanted
>> >> > system behaviour. All methods to fix underruns fails in some respec=
ts.
>> >> >
>> >> > Also note that we have also mode when appl_ptr is not updated at al=
l (when
>> >> > stop_threshold =3D=3D boundary).
>> >>
>> >> How does this mode work? Could it be hidden inside
>> >> snd_pcm_playback_hw_avail() such that low level drivers don't have to
>> >> worry about it?
>> >
>> > Hm, no, in this case, it won't work properly.
>> > *_avail() simply tells you a bogus value, even a negative one.
>> >
>> > Basically this is a free-wheeling mode, e.g. used by dmix.
>> > In this mode, you simply ignore appl_ptr but assume that period_size
>> > samples are available at each period update. =A0So, this would be a
>> > different implementation.
>>
>> Free-wheeling mode is basically unreliable. Wouldn't it be better to
>> start phasing dmix out in favor of pulseaudio?
>
> That's not what developers can decide.

Sure you can. Add a deprecation notification to dmix right now that
says dmix is going to be phased out in the future. Print it in the log
once at dmix startup time. Write a blurb for LKML/LWN.net that says
dmix is being phased out in favor of pulse.  You want to do this to
stop new people from starting to use dmix.  Work with distributions to
start removing it when they feel pulse is ready.  After the major
distributions convert remove dmix from the standard alsa build
packaging.  Anything can be removed by giving sufficient notice and
providing a clear migration path.

Until you make the announcement that dmix is not the way of the
future, there is no incentive for anyone to migrate.

>
>> Why is OSS still in the kernel?
>
> Why? =A0It is designed so :)

Leaving old code in the kernel with no one maintaining it is worse
than removing it. Old code will slowly suffer from bit rot as the
kernel evolves. Unsuspecting people will try and use it and it will
fail in random ways. It is better to make a one year notification and
then remove it.

Don't forget that removing OSS from the kernel only effects people
going forward. People using OSS on an ancient 2.4 kernels will still
have it. You want to stop creating new OSS users.


>
>
> Takashi
>



-- =

Jon Smirl
jonsmirl@gmail.com
