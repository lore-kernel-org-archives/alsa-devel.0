From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The ALSA Situation
Date: Wed, 10 Nov 2004 10:15:05 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0411101008280.2301@ppc970.osdl.org>
References: <200411100150.iAA1okCE029069@localhost.localdomain>
 <001e01c4c6ce$77672eb0$0a00000a@eugenia> <Pine.LNX.4.58.0411101152290.9089@pnote.perex-int.cz>
 <Pine.LNX.4.58.0411100821180.2301@ppc970.osdl.org>
 <Pine.LNX.4.58.0411101828320.22793@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0411101828320.22793@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Wed, 10 Nov 2004, Jaroslav Kysela wrote:
> 
> Of course, if our interpretation is weak

It's not "weak". It's just totally unsupported by _anything_ but the most
perverse possible reading of POSIX. It's not supported by how other
devices behave (*), and it's quite frankly not in my opinion supported by
the wording in the document either. And it's pretty clearly not supported
by how people want or expect things to act.

		Linus

(*) POSIX is not a "new standard" either - it was created very much to
codify existing practices and avoid splintering UNIX more. So if you think
you can read the POSIX standard two different ways, and existing practices
imply one over the other, then that _is_ what it's about. The POSIX
committee very much avoided introducing new behaviour (and they documented
that too).

Sometimes they had to choose one implementation over another, and
sometimes when it was impossible to do they introduced a new interface to
make things unambiguous, but nowhere can I see how somebody thinks that
"ready and available" means "exclusive".

If the POSIX wording had meant "exclusive", it would _say_ "exclusive". It 
would not say "ready and available".


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
