From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Re: should i be able to abort in the middle
 ofsnd_pcm_mmap_{begin,commit} ?
Date: Thu, 21 Feb 2002 11:39:09 +0200 (EET)
Message-ID: <Pine.LNX.4.44.0202211113080.3739-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <3C74B7C2.2CA47B86@alsa-project.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 21 Feb 2002, Abramo Bagnara wrote:

>>> if (avail > pcm->buffer_size)
>> Yes, this condition is faulty. It should be 'avail >= pcm->stop_threshold'.
> - if avail > buffer_size this means either played garbage (playback) or
> overwritten samples (capture). The return of an error is perfectly
> sensible (also because the value returned would not have any sensible
> meaning).

Hmm, the mmap semantics of stop_threshold should be similar to the 
read()/write() API.

The functions in alsa-kernel/core/pcm_lib.c seem to take care that
read/write don't access outside the buffer area. On the other hand it is
possible to process more bytes than buffer_size with one call.

Similarly the short pcm mmap example in the ALSA API documentation
(alsa-lib/src/pcm/pcm.c), can also handle situations where avail_update()  
reports more frames than buffer_size (as can happen after Jaroslav today's
changes). It always processes period_size at a time.

It's also true that without the change, stop_threshold didn't work
properly with mmap access.

Yes another pov is that Jaroslav changes might cause trouble to some
applications (at least jackd will require patching as it sets
stop_threshold to UINT_MAX - not a big thing in this case). Hmm, could
this cahnge result in accessing illegal memory areas in some
situations...?

> - the insertion of SND_PCM_IOCTL_XRUN is a nonsense, as the application
> has explicitly asked to not stop the stream when xrun happens.

It's only called if stop_threshold is set to buffer_size or lower (-> app
_has_ asked to stop if xrun occurs).

> As a side note (and as a broken record :-( ), I'd like you don't change
> the API without peer review. I hope you fully undertstand why...

I agree. Although as we are using CVS, changes are easy to take back.  
Official API is defined by the released versions. And of course in this
case the API change didn't break compatibility...

-- 
 http://www.eca.cx
 Audio software for Linux!


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
