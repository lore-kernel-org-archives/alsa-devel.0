From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: appl_ptr and DMA overrun at end of stream
Date: Mon, 11 May 2009 14:00:59 -0400
Message-ID: <9e4733910905111100o19e2c368s6fd9e3957c84260f@mail.gmail.com>
References: <9e4733910905070923i16683486n678653ba56c28b74@mail.gmail.com>
	<alpine.LNX.2.00.0905111537090.25064@eeebox2.perex-int.cz>
	<9e4733910905110811k643d899bjf7bd37ea029ac5cc@mail.gmail.com>
	<s5hfxfbzlz6.wl%tiwai@suse.de>
	<9e4733910905110850g2b1620a3q47ad2e5a9421a69c@mail.gmail.com>
	<s5hd4afzl5r.wl%tiwai@suse.de>
	<9e4733910905110928g618475bj2a4f47d62e4c5e14@mail.gmail.com>
	<s5h8wl3zj2j.wl%tiwai@suse.de>
	<9e4733910905111009w10017c21kdcf31e1d26ec231d@mail.gmail.com>
	<alpine.LNX.2.00.0905111915350.25064@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C47310380D
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 20:01:02 +0200 (CEST)
Received: by qyk1 with SMTP id 1so4266603qyk.16
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2009 11:01:00 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0905111915350.25064@eeebox2.perex-int.cz>
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

On Mon, May 11, 2009 at 1:37 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Mon, 11 May 2009, Jon Smirl wrote:
>
>> Checking for over/under run in software is not reliable since the DMA
>> hardware runs asynchronously with the CPU. There will always be
>> variable latencies between when the CPU detects the condition and when
>> it can control the DMA hardware. =A0The only reliable way to do this is
>> to program the DMA hardware to do itself. AFAIK all DMA modern
>> hardware can be programed to do this if the right information is made
>> available. Programming the DMA hardware to do this is a 100% reliable
>> solution and not subject to random latency problems.
>
> I comment playback for simplicity.
>
> The key point is when you fill DMA engine. Nothing forces you to queue wh=
ole
> ring buffer in the scatter-gather list. You may queue just one period and
> then next one (including partial). The available samples can be determined
> using snd_pcm_playback_hw_avail() function at any time. If you have large

I didn't know about this function. I can use it to replace the direct
manipulation of appl_ptr.

> FIFO and you receive interrupt before FIFO goes empty, you can fill parti=
al
> period. The elapsed notifier does not require any change.
>
> The underruns should be avoided as first step, because it's really unwant=
ed
> system behaviour. All methods to fix underruns fails in some respects.
>
> Also note that we have also mode when appl_ptr is not updated at all (when
> stop_threshold =3D=3D boundary).

How does this mode work? Could it be hidden inside
snd_pcm_playback_hw_avail() such that low level drivers don't have to
worry about it?


>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>
>



-- =

Jon Smirl
jonsmirl@gmail.com
