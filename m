From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [Jackit-devel] Re: should i be able to abort
 in the middle of snd_pcm_mmap_{begin,commit} ?
Date: Thu, 14 Feb 2002 18:57:16 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202141856150.510-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.44.0202141930420.3739-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 14 Feb 2002, Kai Vehmanen wrote:

> On Thu, 14 Feb 2002, Kai Vehmanen wrote:
>
> > 2.a) way to notice that an xrun has happened during b->c
> >   b) ability to reset the streams
> > 3. way to make sure that engine->process() never takes longer
> >    than period_time*number_of_periods
>
> More debug information follows. I changed jackd code so that if the time
> between mmap_begin() -> mmap_commit() exceeds total amount of buffering,
> we do a forced restart.
>
> Normal 'snd_pcm_drop() -> snd_pcm_prepare() -> snd_pcm_start()' sequence
> doesn't solve the problem. Audio is still garbled. I didn't try full
> 'close() -> ... -> open() -> ..' cycle yet, as that would involve quite a
> lot of work (jackd's alsa_driver.c is a long piece of code).
>
> What I did try was replacing drop() with snd_pcm_drain() and this resulted
> in a hang (not a kernel hang, but process never returns to user-space) in
> the driver level. Here's the backtrace:
>
> #0  0x40127b54 in __ioctl () from /lib/libc.so.6
> #1  0x401f9da0 in __DTOR_END__ () from /usr/lib/libasound.so.2
> #2  0x401b0063 in snd_pcm_drain (pcm=0x805af58) at pcm.c:922
> #3  0x401735eb in alsa_driver_audio_stop (driver=0x8053ec0) at alsa_driver.c:616
> #4  0x401740c7 in alsa_driver_wait (driver=0x8053ec0) at alsa_driver.c:965
>
> After this, jackd needs to be killed with SIGKILL.

I'm curious what is saying this command:

cat /proc/asound/card0/pcm0p/sub0/*

(replace card0 with affected card)

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
