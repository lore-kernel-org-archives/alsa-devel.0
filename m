From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The ALSA Situation
Date: Wed, 10 Nov 2004 11:09:07 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0411101051240.2301@ppc970.osdl.org>
References: <200411101841.iAAIf2Wn000911@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200411101841.iAAIf2Wn000911@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Wed, 10 Nov 2004, Paul Davis wrote:
> 
> although its hard to disagree with your reading of it, do consider
> this. with the current block-by-default behaviour, it is possible to
> do cute things like queue up N invocations of a program that does not
> use O_NONBLOCK and have them execute sequentially, each one starting
> precisely as the previous one closes the device.

If you actually think this is a useful feature, I would suggest trying to 
key it off O_EXCL or a new flag.

That said, I don't see why a regular open() that doesn't wait shouldn't 
act that way. I would suggest that "close()" wait for the buffer to drain, 
unless interrupted by a signal. Again, this is how all other streaming 
devices tend ot work - this is _not_ a new requirement.

So if you have

	#!/bin/sh
	prog1
	prog2
	prog3

and they all open the sound device, they _will_ be serialized by their
closes. This is exactly why the VFS layer calls "->flush()" on each close,
and "->release()" on the last close - so that people can have open->close
consistency, which is a _good_ thing.

NOTE! If you do flush on close, you should not wait forever until the
device is no longer busy. If another open keeps streaming data to the
device, you should definitely not wait for _that_ to stop.  The same way
that it's bad if an open() waits for an indeterminate long time, it's
wrong if a close() waits for a long time. You might even have a timeout,
in case of hw problems.  Others do the same thing.

As for actual concurrent opens (which the above is not), there are 
multiple options that are all perfectly reasonable:

 (a) returning EBUSY (simplest)
 (b) allowing "n" opens and retuning -EBUSY for "n+1", and mixing the data 
     (which basically boils down to (a) if "n" is 1). This would tend to 
     be one obvious way to go if the hw does mixing for you.
 (c) just using a common buffer (ie no mixing - you just write the data 
     sequentially, and the user _will_ notice). Anybody who wants mixing 
     would need to use an explicit mixing interface.

The (c) example above probably isn't as stupid as it sounds: it allows the
common case of intermixed "beeps" etc event notification, and it has the
advantage that when it doesn't work well, the user damn well notices
pretty much immediately. That may sound like a bad thing, but it's
actually a _good_ thing - if the user notices the problem, most people
will realize that the right answer is often "don't do that then".

I think that what really irritated Eugenia was how things didn't work in
pretty non-obvious ways (ie the "several hours later, the apps sprang to
life"). So (c) - while admittedly very very stupid - at least is broken in 
_obvious_ ways, rather than being broken in non-obvious ways.

Imagine a user that clicks on an icon to launch an application. What does
he/she/it do when the app doesn't start? Clicks again. And again. Until
bored. And then, five hours later, when xmms exits, you have a hundred
applications suddenly all starting up at the same time. THAT is
"non-obvious breakage".

The "mixing" approach is obviously likely to be the thing that most people 
want. Especially if coupled with "flush on close".

		Linus


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
