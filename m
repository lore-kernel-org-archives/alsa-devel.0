From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The ALSA Situation
Date: Wed, 10 Nov 2004 10:08:15 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0411100946490.2301@ppc970.osdl.org>
References: <200411100150.iAA1okCE029069@localhost.localdomain>
 <001e01c4c6ce$77672eb0$0a00000a@eugenia> <Pine.LNX.4.58.0411101152290.9089@pnote.perex-int.cz>
 <Pine.LNX.4.58.0411100821180.2301@ppc970.osdl.org> <s5h3bzhharx.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3bzhharx.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Wed, 10 Nov 2004, Takashi Iwai wrote:
>
>         * If O_NONBLOCK is clear, the open() function shall block the
>           calling thread until the device is ready or available before
>           returning. 

They key here being "ready or available". but also common sense and, in 
the case of POSIX, existing practice.

The sound card IS available. It IS ready. It clearly is, since somebody
else can use it. It doesn't have any issues like "I must load the media"
or similar. 

Basically, the "ready or available" thing is about an issue of DEVICE
STATE. A device that is _not_ available is, for example, a tape robot that
doesn't have the right tape loaded yet. It needs to wait for the tape to
load. Or it might be a device that needs to load a device driver (think
"modprobe") or firmware in order to be "ready or available". Or it needs
to open a connection over the network. Or any number of actual things you 
need to do to make sure that the device is actually ready to be used.

And even then, if the "make it ready" requires human intervention, a
device will not just wait. It will tell the user with an error. So for
example, a tape robot that actually can load the tape itself will load the
tape (and wait until it is loaded), but a empty tape drive that needs the
user to load a tape will NOT just silently wait forever. It will tell the
user that it has no tape with an error code.

Somebody else having the device open does not make it "not available". It
might make it _busy_, but that's a totally different thing. That's what
you have EBUSY for.

Sure, you can try to read it some other way, but the fact is, such a
reading is not only totally nonsensical it is also clearly against
existing practices. Just look at pretty much ANY other character/block
special device. ttys, block devices, mice, you name it. If they have 
single-use restrictions, they return EBUSY, they don't wait.

		Linus


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
