From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Subject: Re: problems using select() on alsa pcm.
Date: Thu, 25 Mar 2004 11:25:56 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <003301c41253$919b5c00$161b14ac@boromir>
References: <200403250408.i2P48qDC021625@dhin.linuxaudiosystems.com>
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
To: James Courtier-Dutton <James@superbug.demon.co.uk>, Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> >open pcm, and get a handle.
> >
> >snd_pcm_poll_descriptors(handle, &pfd, err);
> >
> >Get a poll file scriptor in pfd.
> >
> >select(nfds, rfds, wfds, efds, tvp);
> >
> >Is it possible to use this call with alsa ?
> 
> select is generally deprecated in linux (linus says so!). but you can
> use the same pfds in select as in poll (select is implemented in the
> kernel using the poll code). the problem is interpreting the results
> you get back (as noted recently for the dmix plugin).

select and pselect do allow for a more accurate timeout specification.
Why is select deprecated?

--ms




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
