From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Problem with multiopen on SB Audigy 2
Date: Wed, 8 Oct 2003 16:24:33 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0310081619270.1357@pnote.perex-int.cz>
References: <3F82F126.4000800@superbug.demon.co.uk> <s5h4qylkmbk.wl@alsa2.suse.de>
 <3F833B40.9070009@superbug.demon.co.uk> <Pine.LNX.4.53.0310081307320.1357@pnote.perex-int.cz>
 <s5hekxnalsl.wl@alsa2.suse.de> <Pine.LNX.4.53.0310081545030.1357@pnote.perex-int.cz>
 <s5hbrsrakps.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbrsrakps.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 8 Oct 2003, Takashi Iwai wrote:

> > but if DVD (or other 4+.0+ format) is used, then use channels
> > independently. It appears that James is trying to do something
> > non-standard (perhaps playing two DVDs simultaneously), so I am not sure,
> > if we should have these things in our configurations.
> >
> > It's something like "auto" stuff, but I would like to avoid user
> > confusion.
>
> hmm, now i see the problem.  i think disabling "wave surround, center,
> lfe" doesn't belong to the rear or center/lfe pcm, but it's necessary
> for front pcm.  or even better if we have FX bus bypassing these
> duplications.

Yes, new FX bus will solve it, but on plain EMU10K1 chips, we're running
out of GPRs.

> > Anyway, users are already confused with emu10k1+ mixers, so we have to do
> > things more simple.
>
> yep, i'd like to see the new design of the routing/volume.
>
> at least, it'd be nice to have:
>
> - a new real "master" volume for all channels

I'm still not sure, if we should handle these things in the driver.
Hardware is not designed in this way and we should describe hardware
in the driver as most accurate as we can.

> - ac97 master -> front
>   ac97 pcm    -> front pcm ?
> - bypass the duplication of front signals (other FX bus?)

Yes, it looks good.

> - hide "emu10k1*" stuffs from alsamixer (a new flag?)

I vote to leave things asis for this case and wait for new mixer APIs.
Then we can extend the alsamixer for new APIs to handle standard (ordinary
;-) behaviour for normal users.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
