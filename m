From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: Re: [Jackit-devel] the big jack bug... > crappy
 audio on XRUNS
Date: Mon, 7 Nov 2005 13:00:39 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0511071253210.13839@denise.shiny.it>
References: <436E25DB.2070804@inwind.it> <7qek5tadsr.fsf@io.com>
 <436E3CAC.2000200@inwind.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <436E3CAC.2000200@inwind.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: federico <xaero@inwind.it>
Cc: Jack O'Quin <joq@io.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Sun, 6 Nov 2005, federico wrote:

> >>it happens randomly, while I play a soft synth, that jack XRUNs once,
> >>and the audio become crappy, noisy, like a kinda of digital
> >>effect....bit crusher?
> >>
> >>then all synthesizers (all audio apps) sound the same sh*t...
> >>i tried recording with ardour the output, and the output is clean, so
> >>I guess is a problem of sync or something that has to do with the
> >>hardware (soundcard).
> >>
> >
> >This is likely a hardware problem.
> >
> >Have you reported it on alsa-devel?  What card do you have?
> >
> >
> it is an Echoaudio Gina24
> the problem seems to came up more frequently with lower period sizes

It happened to me a lot of time ago before I discovered an hw quirk
(irq are generated at boundaries of 32 frames) and a driver bug (buffer
size was not an integer multiple of period size). After the fix, it never
happened anymore. I fixed it before the driver was merged into
alsa-driver. BTW, it was extremely difficult to reproduce and I never
undestood exactly why alsa wasn't able to recover from such a weird state.

I need to know: sample rate, # of running substreams, period and buffer
size of each substream, anything else you thing may be useful.


--
Giuliano.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
