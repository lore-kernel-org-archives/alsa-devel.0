From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: [BUG] alsa-lib leaves sound device open for child processes
Date: Wed, 5 Feb 2003 14:03:57 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030205140357.3700.qmail@web40605.mail.yahoo.com>
References: <s5hu1fig7d7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu1fig7d7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>
Cc: Sebastian Kapfer <sebastian_kapfer@web.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Speaking as a userspace developer, I expect file
descriptors to be inherited by child processes unless
I explicitly request otherwise. Yes, I usually make
sure that I *DO* request otherwise, but that's not the
point...

Cheers,
Chris

 --- Takashi Iwai <tiwai@suse.de> wrote: > At Wed, 5
Feb 2003 14:05:36 +0100 (CET),
> Jaroslav wrote:
> > 
> > On Wed, 5 Feb 2003, Takashi Iwai wrote:
> > 
> > > At Wed, 5 Feb 2003 12:20:23 +0100 (CET),
> > > Jaroslav wrote:
> > > > 
> > > > Well, I and Abramo think that it's better to
> force application developers 
> > > > to clean allocated things before they'll call
> exec().
> > > 
> > > the problem is not only the explicit exec()
> call.
> > > without this bit, you'll pass the fds to other
> processes even by
> > > popen() or system() or whatever.  that is, if
> your application calls
> > > an external program in the middle, it can block
> the operation.
> > > 
> > > i don't see any critical drawback of setting
> FD_CLOEXEC as default.
> > > the application which needs to pass the
> alsa-lib's fds _explicitly_
> > > can reset the bit via fcntl() again before
> calling exec().
> > 
> > Do we have any precedence? sockets? fopen? etc.?
> 
> it has nothing to do with what type of file
> descriptor is used, or
> for what purpose.
> 
> i meant simply which behavior is _safer_.
> sure, we can leave it as it was, and let users debug
> all.
> IMO, however, the FD_CLOEXEC would lead to less
> bugs, if you think
> which possibility is higher, whether to pass the fd
> intentionally,
> or not,
> 
> 
> Takashi
> 
> 
>
-------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld =
> Something 2 See!
> http://www.vasoftware.com
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/alsa-devel 

__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
