From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: poll_descriptors_count
Date: Mon, 1 Jul 2002 23:33:08 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0207012331310.2013-100000@pnote>
References: <20020701171541.GA13023@reverberate.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020701171541.GA13023@reverberate.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Joshua Haberman <joshua@haberman.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 1 Jul 2002, Joshua Haberman wrote:

> * Paul Davis (pbd@op.net) wrote:
> > >Also, how should programs interpret multiple poll descriptors: if the
> > >poll succeeds on some descriptors but not others, does this mean the
> > >stream is only "partially" ready?
> > 
> > yes. see the internals of JACK's jack/drivers/alsa/alsa_driver.c
> 
> Honestly, I'm afraid to look at that file too carefully since it is GPL
> and PortAudio is BSD.  This puts me in kind of a weird situation.
> 
> > >Also, is snd_pcm_poll_descriptors_revents() understood to return the
> > >events that have triggered on just *one* poll descriptor or on *all*?  In
> > >other words, are you ANDing bitmasks or ORing them?  Right now the
> > >semantics are impossible to deduce because the function just returns the
> > >revents verbatim since there is only one poll descriptor.
> > 
> > The semantics are those of POSIX poll(2): it returns the status for
> > each file descriptor. ALSA's low level and mid level drivers don't
> > modify this in anyway. If there 3 fd's for playback and 2 for capture,
> > then the return data would indicate status for each of the 5 fd's
> > (assuming you asked for it for all 5).
> 
> The prototype for this function is:
> 
> int snd_pcm_poll_descriptors_revents  ( snd_pcm_t *pcm,
>                                         struct pollfd *pfds,
>                                         unsigned int   nfds,
>                                         unsigned short *   revents
>                                       )
> 
> Are you saying that the revents paramter is treated as an array?  I was
> under the impression that it is treated as a pointer to a single short.
> This code fragment from test/pcm.c seems to confirm this interpretation:
> 
> static int wait_for_poll(snd_pcm_t *handle, struct pollfd *ufds, unsigned
>                          int count)
> {
>     unsigned short revents;
> 
>     while (1) {
>         poll(ufds, count, -1);
>         snd_pcm_poll_descriptors_revents(handle, ufds, count, &revents);
>         if (revents & POLLERR)
>             return -EIO;
>         if (revents & POLLOUT)
>             return 0;
>     }
> }
> 
> This gives me the impression that snd_pcm_poll_descriptors_revents() is a
> function that somehow "summarizes" all of the pfds into a single revents
> that speaks to the status of the entire PCM handle.

Yes, it translates multiple revents into one for application. Please, use
this function for the library flexibility.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
