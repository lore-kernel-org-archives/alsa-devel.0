From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: The ALSA Situation
Date: Wed, 10 Nov 2004 13:41:01 -0500
Message-ID: <200411101841.iAAIf2Wn000911@localhost.localdomain>
References: <Pine.LNX.4.58.0411101008280.2301@ppc970.osdl.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 10 Nov 2004 10:15:05 PST."
             <Pine.LNX.4.58.0411101008280.2301@ppc970.osdl.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>It's not "weak". It's just totally unsupported by _anything_ but the most
>perverse possible reading of POSIX. It's not supported by how other
>devices behave (*), and it's quite frankly not in my opinion supported by
>the wording in the document either. And it's pretty clearly not supported
>by how people want or expect things to act.

although its hard to disagree with your reading of it, do consider
this. with the current block-by-default behaviour, it is possible to
do cute things like queue up N invocations of a program that does not
use O_NONBLOCK and have them execute sequentially, each one starting
precisely as the previous one closes the device.

with the ebusy-by-default behaviour, there isn't a way that i can see
to get that behaviour, since O_BLOCK doesn't exist. the current design
allows both behaviours; EBUSY allows only one (ignoring stupid hacks
like looping on open+sleep).

of you course, you could argue that

----------------------------------------
#!/bin/sh

prog1
prog2
prog3
----------------------------------------

is all you need to execute programs sequentially in this
fashion. practically speaking, this is often true, but from a
theoretical perspective, device closing is very different from program
exit. 

--p


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
