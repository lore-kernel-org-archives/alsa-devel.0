From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: The ALSA Situation
Date: Wed, 10 Nov 2004 11:57:12 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411101152290.9089@pnote.perex-int.cz>
References: <200411100150.iAA1okCE029069@localhost.localdomain>
 <001e01c4c6ce$77672eb0$0a00000a@eugenia>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <001e01c4c6ce$77672eb0$0a00000a@eugenia>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eugenia Loli-Queru <eloli@eugenia.co.uk>
Cc: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net, torvalds@osdl.org
List-Id: alsa-devel@alsa-project.org

On Tue, 9 Nov 2004, Eugenia Loli-Queru wrote:

> 1. again with the mixing thing, browsers will stall and not load a flash 
> webpage if another app uses the sound device. It's tragic to see firefox not 
> loading www.macromedia.com for example, just because xmms is playing a 
> song...

You can disable this feature - look for nonblock_open in
Documentation/sound/alsa/OSS-Emulation.txt . We follow posix by default,
the original OSS API does not.

> 2. This: http://www.osnews.com/img/6443/audio.png Check the clean and 
> logical OSS options and then check the endless alsa ones (my monitor was not 
> wide enough to fit them all). Why things like that are not cleaned up? (it's 
> not gnome's volume control fault btw, I asked the developer, he said it's 
> Alsa's)

We have API which won't be changed. It's only an abstraction level which
is missing in alsa-lib. Actually, all mixer controls are automatically
mapped from the driver to application which is not ideal for complex
hardware. I'm working on layer which will solve this issue.

Things are not tragic as you've described.

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
