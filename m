From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Multiple Sound Streams out of a single card
Date: Sun, 14 Sep 2003 02:06:30 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309140606.h8E66UCi032132@oud>
References: <1063511049.30701.164.camel@localhost>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "13 Sep 2003 20:44:09 PDT."
             <1063511049.30701.164.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: AthlonRob <athlonrob@wrenters.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>In Windows, I'm able to have WinAmp running in the background and still
>hear event sounds from other applications.
>
>In Linux, only one thing can play at a time, without the use of
>high-latency audio servers.

not true. ALSA now offers the "dmix" plugin layer that allows multiple
applications to write to a PCM device without locks. just tell an ALSA
aware app to use "dmix:0" and both it and many other apps will all be
able to share the device.

>Is this a fundamental difference between Windows and ALSA driver
>architectures, something the Alsa or OSS people haven't gotten around to
>yet, a big mystery, or what?  Maybe Windows runs some fairly low-latency
>sound server type setup?

yes, there is a fundamental difference between Windows various driver
architectures and ALSA's. if you had to pick on Windows driver model
that ALSA is more similar to, its would probably be ASIO, though ALSA
is a lot more flexible. ASIO doesn't allow multiple apps to use the
soundcard simultaneously. 

and remember that Linux (and Mac OS X) also have JACK, which offers a
service that isn't exactly matched on Windows, though rewire comes
close, sort of.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
