From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Subject: Re: problems using select() on alsa pcm.
Date: Thu, 25 Mar 2004 15:35:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000e01c41276$5e1e4720$161b14ac@boromir>
References: <200403250408.i2P48qDC021625@dhin.linuxaudiosystems.com><003301c41253$919b5c00$161b14ac@boromir> <s5h65ct58md.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, Paul Davis <paul@linuxaudiosystems.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > > >open pcm, and get a handle.
> > > >
> > > >snd_pcm_poll_descriptors(handle, &pfd, err);
> > > >
> > > >Get a poll file scriptor in pfd.
> > > >
> > > >select(nfds, rfds, wfds, efds, tvp);
> > > >
> > > >Is it possible to use this call with alsa ?
> > > 
> > > select is generally deprecated in linux (linus says so!). but you can
> > > use the same pfds in select as in poll (select is implemented in the
> > > kernel using the poll code). the problem is interpreting the results
> > > you get back (as noted recently for the dmix plugin).
> > 
> > select and pselect do allow for a more accurate timeout specification.
> 
> from the spec, yes.  but nsec resolution would be never implemented :)

Not nsec resolution perhaps, but a higher than msec resolution might
be useful in some cases. The fact that select was updated in the POSIX
specs to support a timespec timeout (pselect) and poll only supports
msec timeout might indicate that pselect is better suited for realtime
use. Not to mention that pselect supports at least a 31 day timeout and
that it can set the signal mask...


--ms




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
