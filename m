From: Abramo Bagnara <abramo@alsa-project.org>
Subject: Re: Re: should i be able to abort in the middle
 ofsnd_pcm_mmap_{begin,commit} ?
Date: Thu, 21 Feb 2002 11:00:53 +0100
Message-ID: <3C74C555.3C2D0174@alsa-project.org>
References: <Pine.LNX.4.44.0202211113080.3739-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Kai Vehmanen wrote:
> 
> On Thu, 21 Feb 2002, Abramo Bagnara wrote:
> 
> >>> if (avail > pcm->buffer_size)
> >> Yes, this condition is faulty. It should be 'avail >= pcm->stop_threshold'.
> > - if avail > buffer_size this means either played garbage (playback) or
> > overwritten samples (capture). The return of an error is perfectly
> > sensible (also because the value returned would not have any sensible
> > meaning).
> 
> Hmm, the mmap semantics of stop_threshold should be similar to the
> read()/write() API.

And this was already true. If you use mmap or read/write is irrelevant
wrt stream stop in XRUN state.

> The functions in alsa-kernel/core/pcm_lib.c seem to take care that
> read/write don't access outside the buffer area. On the other hand it is
> possible to process more bytes than buffer_size with one call.
> 
> Similarly the short pcm mmap example in the ALSA API documentation
> (alsa-lib/src/pcm/pcm.c), can also handle situations where avail_update()
> reports more frames than buffer_size (as can happen after Jaroslav today's
> changes). It always processes period_size at a time.
> 
> It's also true that without the change, stop_threshold didn't work
> properly with mmap access.

??? Why you think that?

> 
> Yes another pov is that Jaroslav changes might cause trouble to some

Not "might", the change already now break all plugins!

> applications (at least jackd will require patching as it sets
> stop_threshold to UINT_MAX - not a big thing in this case). Hmm, could
> this cahnge result in accessing illegal memory areas in some
> situations...?
> 
> > - the insertion of SND_PCM_IOCTL_XRUN is a nonsense, as the application
> > has explicitly asked to not stop the stream when xrun happens.
> 
> It's only called if stop_threshold is set to buffer_size or lower (-> app
> _has_ asked to stop if xrun occurs).

The point is that alsa-lib will stop the stream also when application
has asked to *not* do that.

I call this a _broken_ behaviour, don't you?

That apart perhaps to have a snd_pcm_xrun call (to couple with
snd_pcm_drop and snd_pcm_drain) might be useful (who knows, I don't
believe, but...)

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
