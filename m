From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: The ALSA Situation
Date: Wed, 10 Nov 2004 18:45:32 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411101828320.22793@pnote.perex-int.cz>
References: <200411100150.iAA1okCE029069@localhost.localdomain>
 <001e01c4c6ce$77672eb0$0a00000a@eugenia> <Pine.LNX.4.58.0411101152290.9089@pnote.perex-int.cz>
 <Pine.LNX.4.58.0411100821180.2301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0411100821180.2301@ppc970.osdl.org>
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
Cc: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 10 Nov 2004, Linus Torvalds wrote:

> I don't care whether Eugenia has a point in her complaints or not (hey,
> it's a usability issue, you can make that decision yourself), but I _do_
> care about technical people making totally bogus arguments. And Jaroslav,
> that "posix says so" argument is totally and utterly bogus.

I see in all manual pages for open() on web these sentences:

  When opening a block special or character special file that supports 
  non-blocking opens, such as a terminal device:

    +  If neither O_NDELAY nor O_NONBLOCK is set, the open() function blocks
       until the device is ready or available.

    +  If O_NDELAY or O_NONBLOCK is set, the open() function returns without
       waiting for the device to be ready or available. Subsequent behavior
       of the device is device-specific.

The word 'available' clearly states the role of the O_NONBLOCK flag. There
is no specification if availability is restricted to hardware reasons.  
Applications can still break the busy-wait-loop using SIG_ALARM (or any
other signal).

Of course, if our interpretation is weak, then we can simply return to the
"standard" behaviour for the OSS API. While ALSA API documents this
feature and we use this flag for operation which cannot be substituted
easily from the applications (except replacing waiting for event with ugly
polling), I propose to leave the "blocking" behaviour for ALSA
applications.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
