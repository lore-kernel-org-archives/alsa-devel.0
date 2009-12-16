From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: DMA and delay feedback
Date: Wed, 16 Dec 2009 08:36:50 +0800
Message-ID: <4f3252890912151636m5b13a454pd88ac8df339c8ed1@mail.gmail.com>
References: <ad2655cb0912140602s138b7246u6db75e40a699c729@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53]) by alsa0.perex.cz (Postfix) with ESMTP id 5BD6424410
	for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2009 01:36:52 +0100 (CET)
Received: by pwi18 with SMTP id 18so838478pwi.32
	for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2009 16:36:51 -0800 (PST)
In-Reply-To: <ad2655cb0912140602s138b7246u6db75e40a699c729@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/12/14 James Courtier-Dutton <james.dutton@gmail.com>

> Hi,
>
> Would there be benefit in separating the DMA and the transfer of audio
> samples to the sound card hardware from the delay and hw position
> feedback.
> For example, If the playback position is 0, the hardware has probably
> already transferred one period of the sound card.
> So, one cannot write to playback position 2 and expect it to be output
> to the sound card if the period size is 1024.
>
> For transfer purposes, one only needs to know that DMA transfer is
> complete on period X so that period X can now be over-written.
> I believe that this is what the DMA interrupt indicates. One needs to
> reliably detect a missed interrupt.
> It one took this approach, one might be able to hide the "missed
> interrupt" problem.
> When the interrupt finally did arrive, we would know where the next
> free period X is, and continue writing samples to that, irrespective
> of what went wrong before.
> This would allow for auto-recovery of the audio stream without having
> to stop and start the ring buffers again.
>
> One then needs to determine how one can get accurate "delay" values
> back from all sound card types.
>

The accurate "delay" value may be different for different chipsets using the
same driver

snd_pcm_rewindable() should provide the value to rewind to the
period_boundary , if you want to play the audio as soon as possible , you
should reduce the period size

Using software mixing but unwilling to spend CPU time (power saving) and
using large period size does not make any sense at all.



> The "delay" value is used for applications like ensuring that audio
> and video play in sync.
> The problem ones at the moment appear to be the intel8x0 and hd-audio ones.
> There may be benefits from making the "delay" value return in
> nanoseconds instead of samples, particularly if gettimeofdate() is
> being used to try to produce accurate "delay" values.
>
> Kind Regards
>
> James
>
