From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: The ALSA Situation
Date: Wed, 10 Nov 2004 16:13:21 -0500
Message-ID: <200411102113.iAALDLUN001061@localhost.localdomain>
References: <Pine.LNX.4.58.0411101051240.2301@ppc970.osdl.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 10 Nov 2004 11:09:07 PST."
             <Pine.LNX.4.58.0411101051240.2301@ppc970.osdl.org>
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

>That said, I don't see why a regular open() that doesn't wait shouldn't 
>act that way. I would suggest that "close()" wait for the buffer to drain, 
>unless interrupted by a signal. Again, this is how all other streaming 
>devices tend ot work - this is _not_ a new requirement.
>
>So if you have
>
>	#!/bin/sh
>	prog1
>	prog2
>	prog3
>
>and they all open the sound device, they _will_ be serialized by their
>closes. This is exactly why the VFS layer calls "->flush()" on each close,

i think you missed my point about program exit not being synonymous
with close(2). if prog1 closes the device but then does something else
for a while, prog2 doesn't run till prog1 exits (in the above shell
script). 

with the block-on-busy-open behaviour, prog2 runs but blocks on open
and then continues as soon as prog1 does the close(). with
EBUSY-on-busy and a script, prog2 doesn't run till prog1 exits.

btw, xmms is a sort-of relevant example of this. xmms opens and closes
the audio device several times during a typical use pattern, and
doesn't exit unless actually told explicitly to do so. so:

    xmms beep1
    otherprog beep2

would not actually do the right thing. one could fault xmms for this
behaviour, i suppose.

>Imagine a user that clicks on an icon to launch an application. What does
>he/she/it do when the app doesn't start? Clicks again. And again. Until
>bored. And then, five hours later, when xmms exits, you have a hundred
>applications suddenly all starting up at the same time. THAT is
>"non-obvious breakage".

100% agreed.

--p




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
