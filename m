From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ham radio OSS duplex realtime mmap program.
Date: Fri, 26 Sep 2003 16:33:22 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0309261631350.1362@pnote.perex-int.cz>
References: <200309261147.h8QBlUCK011127@oud> <3F744495.1000304@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F744495.1000304@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Paul Davis <paul@linuxaudiosystems.com>, =?ISO-8859-1?Q?=22Dr=2E_med=2E_G=FCnther_Montag=22?= <Safari.Doktor@addcom.de>, alsa-devel@lists.sourceforge.net, hfterm-hackers@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 26 Sep 2003, James Courtier-Dutton wrote:

> Paul Davis wrote:
> >>Hello
> >>I work at "hfkernel" by Tom Sailer, a program for pactor/rtty (soundcard =
> >>ham=20
> >>radio digimodes). It seems complicated, because it uses realtime scheduli=
> >>ng,=20
> >>select(), mmap(), and runs in 3 threads.=20
> >>It was made in 1996 for OSS; I am trying to get it running with ALSA.=20
> >
> >
> > JACK already does this kind of stuff. You'd save yourself major
> > headaches by starting off doing it as a JACK client. Alternatively,
> > use the JACK source as a guide, although its very complex because it
> > is intended to handle many channels in a very robust way, with
> > complete xrun detection.
> >
> > http://jackit.sf.net/
> >
> > another alternative source of ideas would be ecasound's own ALSA code.
> >
> > --p
> >
> I agree with Paul, that JACK would be a good place to work from, because
> it already deals with all the complicated realtime full duplex details,
> and leaves a relatively simple interface for the user application.

By the way, does JACK still rely on the float samples internally? Then it
is not a good solution for the soft-modem application (driver) where
everything should be highly optimized.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
