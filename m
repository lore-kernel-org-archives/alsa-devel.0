From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: snd_pcm_drain and partial periods
Date: Fri, 25 Nov 2011 11:37:34 -0500
Message-ID: <CA+7tXihNEmsjq=xkb5T22smnCcVM8vdBxMYwHSz4YFbMWo5_5g@mail.gmail.com>
References: <CA+7tXihfkZd6+UmnwJiyLgwo+6PoU9fWvzNhz7FKzy7DNgAWMw@mail.gmail.com>
	<CA+7tXii1Ah5Z7UxyHr0=jNALt-qORQ0fG8WcNiAGWuSxbMq=7g@mail.gmail.com>
	<4ECE5206.4060408@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C87E103F19
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 17:37:35 +0100 (CET)
Received: by bkat8 with SMTP id t8so3957135bka.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 08:37:35 -0800 (PST)
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When the driver schedules the final period, couldn't it check if the
device is draining, and if so try to end playback at the right time.
Of course, it would need to be able to play less than a period of
audio do that.

What is the proper way the finish playing if snd_pcm_drain() will go
past the end of the audio?

On Thu, Nov 24, 2011 at 9:17 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
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
>
> Regards,
> Clemens
