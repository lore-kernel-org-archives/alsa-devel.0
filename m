From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Mon, 27 Sep 2004 14:43:59 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409271433490.1733@pnote.perex-int.cz>
References: <200409270300.i8R30Ro1016070@localhost.localdomain>
 <4157B56F.9000905@pg.gda.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4157B56F.9000905@pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?UTF-8?B?QWRhbSBUbGHFgmth?= <atlka@pg.gda.pl>
Cc: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 27 Sep 2004, Adam Tla=B3ka wrote:

> > ALSA and the entire kernel development team have spent the last 5
> > years moving things *out* of kernel space. forget ALSA - you will have
> > a very, very hard time explaining to the kernel crew why this is
> > actually a good idea.
> Hmm, actually from my observation this approach (in lib mixing and=20
> effects) makes more problems and disadventages then doing this in a=20
> device manner and as a kernel RT thread. I tried to modify AOSS to use=20
> callbacks (works almost good but scheduling/swapping effects still=20
> there)

Are you using fully loaded ring buffer on the ALSA side with a decent=20
size?

> but I found an app which disables SIGIO for example.

It might be solved with the loopback device and a RT mixing daemon.

> So now I in a dead end. I think that ALSA lib approach has serious=20
> compability limitations which could not be solved.

I don't think that it's something which cannot be solved.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
