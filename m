From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: hw_pointer error message triggered without need
Date: Wed, 22 Oct 2003 12:58:53 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0310221256580.1483@pnote.perex-int.cz>
References: <3F9552BA.1020404@uni-oldenburg.de> <s5hd6cqcyry.wl@alsa2.suse.de>
 <Pine.LNX.4.53.0310211910520.1483@pnote.perex-int.cz> <s5h8ynecw5s.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8ynecw5s.wl@alsa2.suse.de>
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

> > > well, it's not unnecessary but too strict.
> > > especially, if the hardware generates too late (often seen on onboard
> > > chips), and if only two periods are used, this situation can happen.
> > >
> > > i think delta < (runtime->period_size/2) would be enough to check the
> > > negative (invalid) hwptr rather than delta < (runtime->buffer_size/2)
> > > as it is.
> >
> > Nope. This check will be wrong because we will fall to the wrap point and
> > increase hw_ptr_base with buffer_size.
>
> the problem is that this check is too strict when only two periods are
> used.  since buffer_size/2 == period_size, if the update of hwptr is
> delayed even for one sample, it won't pass.
>
> there is a little difference between snd_pcm_update_hw_ptr() and
> snd_pcm_update_hw_ptr_interrupt(), and this problem doesn't happen in
> the former but only in the latter function, which is invoked by
> snd_pcm_lib_write1().
>
> in the former function, delta is the difference between the expected
> pointer (lastptr + period_size) and the current pointer.  meanwhile,
> in the latter function, delta is the difference between the last
> pointer and the new pointer.
> hence, the calculation of delta in the latter function can be easily
> less than buffer_size/2 when nperiods = 2.
>
> > Anyway, I think that we should leave the check as is for debugging
> > purposes (we should know that something is failing).
>
> sure, it's harmless message (as long as it comes from
> snd_pcm_update_hw_ptr()) but too annoying.  there are too many
> sloppy hardwares...

I've tried to reduce the debugging output for some conditions where
periods is a small value. In this case, it's really difficult to determine
which pointer is bad.

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
