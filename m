From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: smix plugin available?
Date: Wed, 27 Nov 2002 15:24:16 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211271512370.532-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.21.0211271149000.2146-100000@mailserver.intern.bfad.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.21.0211271149000.2146-100000@mailserver.intern.bfad.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tomasz motylewski <T.Motylewski@bfad.de>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, Paul Davis <paul@linuxaudiosystems.com>, Florian Bomers <Florian.Bomers@sun.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Nov 2002, tomasz motylewski wrote:

> On Wed, 27 Nov 2002, Jaroslav Kysela wrote:
> 
> > In my brain, there is also totaly different solution with the zero context 
> > switching overhead - sharing the soundcard DMA buffer among more 
> > applications. There is only one problem: snd_pcm_rewind() implementation 
> 
> This is my personal preference. In this model the only service ALSA has to
> supply are:
> 
> 1. initial configuration/start/stop.
> 2. mmapable DMA buffer
> 3. fact and precise ioctl telling the current HW pointer in the buffer. If the
> card is not queried each time, then the "last period interrupt" timestamp
> should be included.

We have already this sort of timestamp - SNDRV_PCM_TSTAMP_MMAP, but it's 
quite useless when we haven't a continuous timer source. Hopefully, things 
will change after 2.5 when high-res timers are included.

> Please stop the complication of "available/delay" etc. Just the raw pointer.
> Each application knows where its application pointer is, so it can easily
> calculate delay/available and decide for itself whether there was an overrun or
> not.

I got your point. It would be good to let read hw_ptr and appl_ptr by 
application when it operates in "don't report xruns" mode (stop_threshold 
== ULONG_MAX). We can do it quite easy extending the current API.

> The driver does not care at all whether applications are writing to this buffer
> or not. There should be one thread (ISR, kernel or separate application) which
> zeroes part of the buffer just after the card has played it.
> 
> Each application/thread should not just copy the data to DMA buffer, but _add_
> to it - in this way we get very efficient mixing (zero copy). Of course here I
> assume that "add" operations on volatile buffers are atomic vs. context
> switches - probably not on all architectures - we may need mutexes.

Exactly, that's my idea. The question is the locking method. Mutexes are 
slow. Perhaps, we can try to write a king of "user land" spinlocks which 
contents is shared as the DMA ring buffer.

> ALSA API should also tell the applications how big the "hot zone" is (the area
> where the data is first played and then set to 0).

I think that hw_ptr is quite sufficient (application will start to write 
samples from hw_ptr + period_size).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
