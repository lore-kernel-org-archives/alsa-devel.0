From: Abramo Bagnara <abramo@alsa-project.org>
Subject: Re: Re: should i be able to abort in the middle
 ofsnd_pcm_mmap_{begin,commit} ?
Date: Thu, 21 Feb 2002 11:42:25 +0100
Message-ID: <3C74CF11.D9987B3E@alsa-project.org>
References: <Pine.LNX.4.31.0202211107080.502-100000@pnote.perex-int.cz>
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
To: Jaroslav Kysela <perex@suse.cz>
Cc: Kai Vehmanen <kai.vehmanen@wakkanet.fi>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> > > Hmm, the mmap semantics of stop_threshold should be similar to the
> > > read()/write() API.
> >
> > And this was already true. If you use mmap or read/write is irrelevant
> > wrt stream stop in XRUN state.
> 
> Right, but the stream is RUNNING. My change does nothing else than
> checking if an xrun state occured in the user space and synchronizes
> the kernel code with this situation. Definitely the PCM state should be
> XRUN not RUNNING when snd_pcm_avail_update() returns -EPIPE. It was very
> misleading for application to receive these broken results.

I've thought more about this and I'm happy to say that I think you're
right about your patch.

This change a bit the "when" part of xrun detection (previously was
doable only by kernel space), but once documentented I think it's
correct.

I still have doubts about snd_pcm_avail_update return value.

Should it return a value > buffer_size when stop_threshold is high?

Actually snd_pcm_mmap_begin automatically will reduce this amount to
contiguous size...

So yes, I think it's a good work. At the time of the first reading it
looked awful at my eyes, but now I've seen the light.

Sorry for the noise.

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
