From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [Jackit-devel] Re: should i be able to abort
 in the middle of snd_pcm_mmap_{begin,commit} ?
Date: Thu, 14 Feb 2002 18:37:34 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202141829480.510-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.44.0202141851050.3739-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: "jackit-devel@lists.sourceforge.net" <jackit-devel@lists.sourceforge.net>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 14 Feb 2002, Kai Vehmanen wrote:

> On Thu, 14 Feb 2002, Paul Davis wrote:
>
> >>- no xruns are detected even though after the timeout
> >>  alsa_driver_wait() took 56.4msec which is more than
> > cards, i am starting to suspect part of jack's design rather than
> > ALSA, but i have not yet managed to figure out what it could be. when
> > i check the channel_area_t addresses used by jack, they also appear to
> > be just as one would expect.
>
> It seems that the problem is:
>
> - engine->process() is possibly a slow operation
> - ALSA is unable to detect xruns inside mmap_begin()->mmap_commit()
>   code block

I wonder why you say this. There is really very short time period in which
the hardware pointer can cross the application pointer and PCM code won't
react on this situation. There are no locks for the xrun detection between
mmap_begin() and mmap_commit().

If you want to debug the real problem, try to print hw_ptr and appl_ptr
pointers when sound is garbled.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
