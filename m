From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The ALSA Situation
Date: Wed, 10 Nov 2004 08:43:38 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0411100821180.2301@ppc970.osdl.org>
References: <200411100150.iAA1okCE029069@localhost.localdomain>
 <001e01c4c6ce$77672eb0$0a00000a@eugenia> <Pine.LNX.4.58.0411101152290.9089@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0411101152290.9089@pnote.perex-int.cz>
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


[ Eugenia removed ]

On Wed, 10 Nov 2004, Jaroslav Kysela wrote:
> 
> You can disable this feature - look for nonblock_open in
> Documentation/sound/alsa/OSS-Emulation.txt . We follow posix by default,
> the original OSS API does not.

That's a load of BULL.

There is nothing in POSIX that says that you should block for the sound 
device to be non-busy. Claiming that this is "because of posix" is clearly 
totally mis-understanding what posix is all about.

First off, POSIX doesn't even specify that kind of detail, and second, if 
you actually think about it for a second, you will notice that no other 
subsystem actually behaves like you claim posix requires. If you open a 
ttyu device, it won't block until the tty is "free". It just opens it. 
Similarly, if you open a disk device, it won't block until there are no 
other users. It just opens it.

There is _one_ special case, which is for FIFO's, and that one is that you
should open the fifo even if there is _no_ other reader/writer, ie it's
explicitly exactly the _other_ way around from what you claim.

In fact, what O_NONBLOCK means in general is to set a flag that says that
subsequent reads and writes are non-blocking. But the open() itself
succeeds, _it_ doesn't block.

On block devices, O_NONBLOCK also is a way to say "don't try to do any 
device discovery", ie you can do a O_NONBLOCK open on a removable disk 
that doesn't even have any media in it. Again, this has _nothing_ to do 
with whether the device is "busy" or not.

I don't care whether Eugenia has a point in her complaints or not (hey,
it's a usability issue, you can make that decision yourself), but I _do_
care about technical people making totally bogus arguments. And Jaroslav,
that "posix says so" argument is totally and utterly bogus.

So if that's really the reason for "nonblock_open", then I would strongly
suggest that you default to that stupid feature _off_. Anybody who really
wants the blocking opens (sounds like nobody really would) could then turn
it on as desired.

Short summary:

 - O_NONBLOCK should generally be seen as just setting the O_NONBLOCK flag 
   "early" (ie it's conceptually equivalent to doing a "F_SETFL" fcntl 
   before the open. It _may_ affect the open itself, but when it does, it 
   is generally considered to mean that you can open something that isn't 
   even _reachable_.

 - POSIX doesn't say anything much about its behaviour, except for named 
   pipes, where it says the total reverse of what ALSA does. But that 
   doesn't actually mean anything, because even that is very much defined 
   as a special case by POSIX.

In other words, if your sound card had a sensor saying "speakers connected 
or not", then O_NONBLOCK might say "we'll open the damn thing even if 
there are no speakers". But it definitely doesn't say anything about other 
users.

Off on a tangent: some other device drivers have a notion of "exclusive
open", which says that only one process can open the device at a time. For 
example, something like a tape driver generally only accepts a single open 
at a time. But with those kinds of drivers, they do NOT wait for other 
opens to go away: they return EBUSY.

So please change this behaviour, or at least stop blaming POSIX for the
braindamage. Either return EBUSY if you really want exclusion, or just
allow concurrent access.

In general, it is almost universally felt that concurrent access is better
than EBUSY, unless there are fundamental reasons why it can't work (and I
think everybody understands what the fundamental reasons are for a tape
device. For a sound device, inability to do mixing might well fall under
the same heading).

Please?

			Linus


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
