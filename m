From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: problems using select() on alsa pcm.
Date: Thu, 25 Mar 2004 16:05:33 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403251602580.3867@pnote.perex-int.cz>
References: <200403251444.i2PEisl8003668@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200403251444.i2PEisl8003668@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 25 Mar 2004, Paul Davis wrote:

> >> select is generally deprecated in linux (linus says so!). but you can
> >> use the same pfds in select as in poll (select is implemented in the
> >> kernel using the poll code). the problem is interpreting the results
> >> you get back (as noted recently for the dmix plugin).
> >
> >Nope, the application must give results back to pfd array and call
> >snd_pcm_poll_descriptors_revents() function. In this way, everything
> >will work as expected.
> 
> i thought that the flags set by select(2) were different than those
> set by poll(2) ??

Yes, but the results are similar. So you have to do:

snd_pcm_poll_descriptors(pfds)
pfds->events -> FD_SET(x, y)
select()
FD_ISSET(x, y) -> pfds->revents
revents = snd_pcm_poll_descriptors_revents(pfds)
if (revents & POLLOUT)
  playback_event();
if (revents & POLLIN)
  capture_event();

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
