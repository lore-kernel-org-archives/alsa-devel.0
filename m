From: "Ryan Cassidy" <rcassidy@stanford.edu>
Subject: RE: Interrupt-driven (or callback/handler?), Full-duplex (simultaneous capture/playback) without using JACK
Date: Sat, 8 Nov 2003 20:33:02 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000001c3a67a$93b5ec20$264440ab@roboserv1>
References: <200311090342.hA93g9Bg031897@oud.linuxaudiosystems.com>
Reply-To: <rcassidy@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200311090342.hA93g9Bg031897@oud.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Paul Davis' <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul,

Many thanks for the speedy reply!  See responses below...

> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net [mailto:alsa-devel-
> admin@lists.sourceforge.net] On Behalf Of Paul Davis
> Sent: Saturday, November 08, 2003 7:42 PM
> To: rcassidy@stanford.edu
> Cc: alsa-devel@lists.sourceforge.net; ryanc@ieee.org
> Subject: Re: [Alsa-devel] Interrupt-driven (or callback/handler?),
Full-
> duplex (simultaneous capture/playback) without using JACK
> 
> >I am trying to write an application that uses ALSA interrupt-driven
> >(which I guess is obtained by adding PCM handler(s) in ALSA?),
> >full-duplex (simultaneous capture/playback) using the ALSA PCM API
> >directly (i.e. not using JACK).
> >
> >My question: do I only need to register one callback/handler function
to
> >take care of both capture and playback?  My hope is that when I link
the
> >capture and playback streams, and register a single handler with
either
> >capture or playback, this handler will be called whenever there is
BOTH
> >capture data to be read and a free playback buffer to be written (?).
> >Is this the case?
> 
> the ALSA PCM API doesn't have "handlers". it doesn't provide any kind
> of callback mechanism. what it does do is to provide a poll(2)
> interface, allowing callback-like mechanisms to be built around it
> (like JACK).
> 

Will snd_async_add_pcm_handler() not do the trick?  It says
"asynchronous," which doesn't sound like what I want, but the "handler"
part sounds promising :).

If that doesn't work, it's sort of a bummer that ALSA doesn't offer a
callback-mechanism for simultaneous audio i/o, non?  This means that to
get "what I want" (i.e. allowing my program to do useful work while
waiting for new audio samples), I need to use snd_pcm_wait() and fork
off an extra process to do the "useful work," right?

> the snd_pcm_wait() function isn't enough for what you want to do, and
> using it to what you want to do is equivalent to reimplenting the JACK
> ALSA driver. a couple of people have asked that the core of JACK's
> ALSA driver's inner loop be merged into alsa-lib, since it would do
> what you want (take N PCM handles, block and return when all of them
> have at least X frames of audio ready to read or write). at this time,
> this has not happened, and there is no sign that it will be.
> 
> if you really don't want to use JACK, then i would suggest that,
> assuming your program is be either private or distributed under the
> GPL, you just take the JACK ALSA driver and use that as a template for
> your efforts. its not simple, because full-duplex, interrupt-driven
> audio i/o is not simple unless you're a JACK client :) if you want to
> write the "server", you have to work a lot harder.

I'm willing to go over to JACK eventually, but I'd like to see "how it's
done" directly with ALSA (for academic purposes, I suppose) first.

> 
> either that, or take a look at ecasound's ALSA i/o code, since i think
> that kai implemented that "correctly" also.
> 
> --p
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: ApacheCon 2003,
> 16-19 November in Las Vegas. Learn firsthand the latest
> developments in Apache, PHP, Perl, XML, Java, MySQL,
> WebDAV, and more! http://www.apachecon.com/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
