From: Hannu Savolainen <hannu@opensound.com>
Subject: Re: The ALSA Situation
Date: Thu, 11 Nov 2004 00:00:52 +0200 (EET)
Message-ID: <Pine.LNX.4.58.0411102331010.9215@zeus.compusonic.fi>
References: <200411100150.iAA1okCE029069@localhost.localdomain>
 <001e01c4c6ce$77672eb0$0a00000a@eugenia> <Pine.LNX.4.58.0411101152290.9089@pnote.perex-int.cz>
 <Pine.LNX.4.58.0411100821180.2301@ppc970.osdl.org>
 <Pine.LNX.4.58.0411101828320.22793@pnote.perex-int.cz>
 <Pine.LNX.4.58.0411101008280.2301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0411101008280.2301@ppc970.osdl.org>
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
Cc: Jaroslav Kysela <perex@suse.cz>, Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 10 Nov 2004, Linus Torvalds wrote:

> It's not "weak". It's just totally unsupported by _anything_ but the most
> perverse possible reading of POSIX. It's not supported by how other
> devices behave (*), and it's quite frankly not in my opinion supported by
> the wording in the document either. And it's pretty clearly not supported
> by how people want or expect things to act.
Thanks, Linus. I have to say I completely agree with you.

This block-on-open feature is used by /dev/audio in SunOS which may be
reason why ALSA and some of the OSS/Free drivers use it.

It has not been supported by "official" OSS and it will never be
supported in the future. The original reason was that this behaviour is
useless and totally undesirable.

However the main reason today is that average programmers will never ever
learn how to use it. They use O_NONBLOCK in open because they don't want
to wait. Unfortunately 9 programers out of 10 don't realize that O_NONBLOCK
must be turned off after open.

And sometimes it's so difficult explain to users what does the "Resource
temporarily unavailable" error mean. Some customers are so sure that it's
definitely caused by a bug in the driver. Or they may go to buy a new
sound card because some project deadline is approaching and the old one
doesn't have enough capacity for them.

So regardless of what POSIX or anything else says the blocking open
feature when the device is busy is total disater. It might be usefull with
slow tape drives that may need up to minutes to rewind the tape. But
waiting for some other application to close the device is stupid.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
