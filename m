From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: [BUG] alsa-lib leaves sound device open for child processes
Date: Wed, 5 Feb 2003 18:50:26 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030205185026.18038.qmail@web40604.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, Sebastian Kapfer <sebastian_kapfer@web.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Fair enough, but my point is that I'd expect the
close-on-exec flag NOT to be set unless I explicitly
set it myself. Same as with every other way of getting
a file descriptor.

Chris

 --- Paul Davis <paul@linuxaudiosystems.com> wrote: >
>Speaking as a userspace developer, I expect file
> >descriptors to be inherited by child processes
> unless
> >I explicitly request otherwise. Yes, I usually make
> >sure that I *DO* request otherwise, but that's not
> the
> >point...
> 
> the question is not about inheritance by child
> processes. its about
> close-on-exec behaviour. nobody is proposing any
> change to the
> situation after a simple fork(2).
> 
> --p 

__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
