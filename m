From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: hw_pointer error message triggered without need
Date: Tue, 21 Oct 2003 19:24:04 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0310211910520.1483@pnote.perex-int.cz>
References: <3F9552BA.1020404@uni-oldenburg.de> <s5hd6cqcyry.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd6cqcyry.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Tobias Peters <tpeters@uni-oldenburg.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 21 Oct 2003, Takashi Iwai wrote:

> At Tue, 21 Oct 2003 17:37:30 +0200,
> Tobias Peters wrote:
> >
> > I'm using linux-2.4.22 with alsa drivers 0.9.7c. Sound card driver in
> > use was intel 8x0 (but I doubt it's responsible in this case).
> >
> > ALSA ../alsa-kernel/core/pcm_lib.c:216: Unexpected hw_pointer value
> > (stream = 0, delta: -255, max jitter = 256): wrong interrupt acknowledge?
> >
> > If I understand the relevant code correctly, then this error message is
> > triggered unnecessarily if the hardware buffer is only two periods in
> > size.  It is triggered when the hardware pointer has already been
> > increased by one sample since the last period completed.
> >
> > Not so if there are more periods per buffer.
>
> well, it's not unnecessary but too strict.
> especially, if the hardware generates too late (often seen on onboard
> chips), and if only two periods are used, this situation can happen.
>
> i think delta < (runtime->period_size/2) would be enough to check the
> negative (invalid) hwptr rather than delta < (runtime->buffer_size/2)
> as it is.

Nope. This check will be wrong because we will fall to the wrap point and
increase hw_ptr_base with buffer_size.

Looking to code, it seems that an interrupt was lost. Its quite impossible
to create a realiable check for lost interrupts when you have only two
periods in the midlevel code. Or the interrupt was generated too early.

Anyway, I think that we should leave the check as is for debugging
purposes (we should know that something is failing).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
