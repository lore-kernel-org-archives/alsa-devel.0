From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_pcm_drain and partial periods
Date: Mon, 28 Nov 2011 09:16:27 +0800
Message-ID: <CAN8cciYK2fmj226GW_4wiw0e4pR2gX09GFEtZNH1XFrQ=b4UTA@mail.gmail.com>
References: <CA+7tXihfkZd6+UmnwJiyLgwo+6PoU9fWvzNhz7FKzy7DNgAWMw@mail.gmail.com>
	<CA+7tXii1Ah5Z7UxyHr0=jNALt-qORQ0fG8WcNiAGWuSxbMq=7g@mail.gmail.com>
	<4ECE5206.4060408@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FDB9103881
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 02:16:29 +0100 (CET)
Received: by bkat8 with SMTP id t8so6902517bka.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 17:16:28 -0800 (PST)
In-Reply-To: <4ECE5206.4060408@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/11/24 Clemens Ladisch <clemens@ladisch.de>:
> Trent Piepho wrote:
>> Say an application does not write a full multiple of the period size
>> with snd_pcm_writei(). =A0It's playing a clip and the clip ends and it
>> doesn't happen to end on a multiple of 6000 frames or whatever the
>> period size is.
>>
>> Now the application calls snd_pcm_drain() to wait for the clip to finish.
>>
>> How does the driver know to stop when it gets to the end of the
>> supplied data?
>
> It doesn't.
>
>> It seems like the driver will keep playing until it calls
>> snd_pcm_period_elapsed() at the end of the final period. =A0Then the
>> alsa pcm layer will call the ->trigger() method and stop the stream.
>
> Yes.
>
>> Hopefully before the driver has started the next DMA for the next
>> period!
>
> Let's hope that the FIFOs are large enough so that the actual playback
> hasn't yet reached the period boundary ...
>
>> I don't see any documentation for snd_pcm_drain() that says it will
>> keep playing until it finishes a period, even if the data runs out
>> before hand. =A0"For playback wait for all pending frames to be played
>> and then stop the PCM." =A0Seems pretty clear that only the pending
>> frames are played and not the rest of a period.
>
> ALSA will stop the device when it realizes that it has run out of data
> (just like an underrun). =A0This might happen before the period boundary
> if there is some call to snd_pcm_status() or _delay() that reads the
> current position (and if the hardware also supports reading the current
> position).
>
>
> It's racy and undocumented, but there's nothing a driver can do about
> this.
>

How about snd-usb-audio which one period consists of one or more urbs  ?

if alsa stop the device at underrun

How can snd_pcm_recover() work as expected when usb-audio does not
provide accurate current position ?

The other cases are those hardware mixing sound cards (e.g. cs46xx,
ymfpci, au88x0 and emu10k1)

emu10k1 and au88x0 can provide current position

The period size of au88x0 and cs46xx are limited to power of two
ymfpci and emu10k1 has not limitation on period size but ymfpci 's dsp
mix at 1024 bytes

Does snd_pcm_recover() restart at the stop position or period boundary ?
