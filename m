From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: problems using select() on alsa pcm.
Date: Thu, 25 Mar 2004 16:38:37 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403251637400.3867@pnote.perex-int.cz>
References: <200403250408.i2P48qDC021625@dhin.linuxaudiosystems.com>
 <Pine.LNX.4.58.0403251037200.1807@pnote.perex-int.cz> <4062F71E.50802@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4062F71E.50802@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 25 Mar 2004, James Courtier-Dutton wrote:

> Jaroslav Kysela wrote:
> > On Wed, 24 Mar 2004, Paul Davis wrote:
> > 
> > 
> >>>open pcm, and get a handle.
> >>>
> >>>snd_pcm_poll_descriptors(handle, &pfd, err);
> >>>
> >>>Get a poll file scriptor in pfd.
> >>>
> >>>select(nfds, rfds, wfds, efds, tvp);
> >>>
> >>>Is it possible to use this call with alsa ?
> >>
> >>select is generally deprecated in linux (linus says so!). but you can
> >>use the same pfds in select as in poll (select is implemented in the
> >>kernel using the poll code). the problem is interpreting the results
> >>you get back (as noted recently for the dmix plugin).
> > 
> > 
> > Nope, the application must give results back to pfd array and call
> > snd_pcm_poll_descriptors_revents() function. In this way, everything
> > will work as expected.
> > 
> > 						Jaroslav
> So which of the following is needed: -
> 
> snd_pcm_poll_descriptors(handle, &pfd, err);
> select(nfds, rfds, wfds, efds, tvp);
> snd_pcm_poll_descriptors_revents()  <- decode the results of the select.

This one. The *revents() function mangles the returned ->revents back to 
the useful meaning for applications.

> or
> snd_pcm_poll_descriptors(handle, &pfd, err);
> snd_pcm_poll_descriptors_revents()  <- rearrange the pfd so that select 
> works as expected.
> select(nfds, rfds, wfds, efds, tvp);

That's wrong.

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
