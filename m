From: Jaroslav Kysela <perex@suse.cz>
Subject: RE: Interrupt-driven (or callback/handler?), Full-duplex
 (simultaneous capture/playback) without using JACK
Date: Sun, 9 Nov 2003 09:37:49 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0311090927040.3073@pnote.perex-int.cz>
References: <000001c3a67a$93b5ec20$264440ab@roboserv1>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <000001c3a67a$93b5ec20$264440ab@roboserv1>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ryan Cassidy <rcassidy@stanford.edu>
Cc: 'Paul Davis' <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 8 Nov 2003, Ryan Cassidy wrote:

> > the ALSA PCM API doesn't have "handlers". it doesn't provide any kind
> > of callback mechanism. what it does do is to provide a poll(2)
> > interface, allowing callback-like mechanisms to be built around it
> > (like JACK).
> >
>
> Will snd_async_add_pcm_handler() not do the trick?  It says
> "asynchronous," which doesn't sound like what I want, but the "handler"
> part sounds promising :).
>
> If that doesn't work, it's sort of a bummer that ALSA doesn't offer a
> callback-mechanism for simultaneous audio i/o, non?  This means that to
> get "what I want" (i.e. allowing my program to do useful work while
> waiting for new audio samples), I need to use snd_pcm_wait() and fork
> off an extra process to do the "useful work," right?

Yes, snd_async_add_pcm_handler() might help you and it works. It's
originated in the interrupt handler. But please note that the handler is
in the unix style signal callback thus there are many restrictions (you
should avoid to do most of syscalls in this code etc.).

But for mmaped access and the standard ALSA transfer mechanism (use only
snd_pcm_avail_update() to get the right position) it is the fast way to
create an interrupt based handlers in the applications.

For the synchronization: You must do it in your application. We work with
two diferrent streams and although the streams are hardware synchronized,
there might be some buffering issues (FIFOs) so the playback and capture
pointers do not match exactly. So the best way is to obtain the current
pointer using snd_pcm_avail_update() and compute how many frames you can
process for the duplex operation (I mean for both streams).

For a playback example, you might look to alsa-lib/test/pcm.c - see
the async_callback() function contents.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
