From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Re: should i be able to abort in the middle of
 snd_pcm_mmap_{begin,commit} ?
Date: Thu, 21 Feb 2002 10:35:58 +0200 (EET)
Message-ID: <Pine.LNX.4.44.0202210912360.3739-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.44.0202210745340.3739-100000@ecabase.localdomain>
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

Answering to my own mail...

> Looking at jackd code, one possibility is that the we are only getting an
> EPIPE from snd_pcm_avail_update(), but the stream is still in RUNNING 
> state. At least in alsa-lib/src/pcm/pcm_hw.c:snd_pcm_hw_avail_update()
> we have a test for:
[...]
> if (avail > pcm->buffer_size)
> 	return -EPIPE;

This seems to be the case. It does look very unlikely that an xrun 
could go unnoticed. It would take quite a latency spike to 
allow hw_ptr to wrap around pcm->boundary. :)

I guess more probable explanation is something like:

loop:
    start = timer()
    poll()
    <interrupt -> hw_ptr += period_size>
    snd_pcm_avail_update()
    snd_pcm_mmap_begin()
    ...
    snd_pcm_mmap_commit()
    <interrupt -> hw_ptr += period_size>
    stop = timer()

If the interrupts occur at the right time, 'stop-start' 
might exceed 'period_time * period_count' even though 
snd_pcm_avail_update() never returns EPIPE. This is
probably what I saw when debugging jackd (and is, of
course, perfectly legal).

-- 
 http://www.eca.cx
 Audio software for Linux!


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
