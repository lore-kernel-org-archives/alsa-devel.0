From: Abramo Bagnara <abramo@alsa-project.org>
Subject: Re: Re: [Jackit-devel] Re: should i be able to abortin the
 middle of snd_pcm_mmap_{begin,commit} ?
Date: Fri, 15 Feb 2002 15:02:47 +0100
Message-ID: <3C6D1507.D1672C26@alsa-project.org>
References: <Pine.LNX.4.44.0202141941020.3739-100000@ecabase.localdomain>
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
Cc: jackit-devel@lists.sourceforge.net, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Kai Vehmanen wrote:
> 
> On Thu, 14 Feb 2002, Jaroslav Kysela wrote:
> 
> >> - ALSA is unable to detect xruns inside mmap_begin()->mmap_commit()
> >>   code block
> > I wonder why you say this. There is really very short time period in which
> > the hardware pointer can cross the application pointer and PCM code won't
> > react on this situation. There are no locks for the xrun detection between
> > mmap_begin() and mmap_commit().
> 
> Quoting Paul: "i recall abramo saying that if the xrun happens within an
> mmap_begin/commit pair, the driver can't detect it, or something like
> that."

Caution here... Paul is not very accurate quoting me, I'll try to
rephrase.

Take as an example HW PCM case, snd_pcm_mmap_begin and commit don't
enter kernel space and don't check for anything.

Note also that it's very hard to know if an xrun is actually happened or
not. We might use a conservative approach (i.e. all frames are
considered written on buffer only at commit call) a less severe one
(i.e. all frames are considered written at begin call), or a mixed
approach.

Current assumption is that between snd_pcm_avail_update call and
snd_pcm_mmap_commit we always put more data than hardware can read
(playback case)

Of course preemption can give us surpries, but that's life...

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
