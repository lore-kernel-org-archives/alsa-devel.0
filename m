From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [BUG] alsa-lib leaves sound device open for child
 processes
Date: Wed, 5 Feb 2003 14:05:36 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302051405150.1303-100000@pnote.perex-int.cz>
References: <s5hwukegaq0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwukegaq0.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Sebastian Kapfer <sebastian_kapfer@web.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 5 Feb 2003, Takashi Iwai wrote:

> At Wed, 5 Feb 2003 12:20:23 +0100 (CET),
> Jaroslav wrote:
> > 
> > Well, I and Abramo think that it's better to force application developers 
> > to clean allocated things before they'll call exec().
> 
> the problem is not only the explicit exec() call.
> without this bit, you'll pass the fds to other processes even by
> popen() or system() or whatever.  that is, if your application calls
> an external program in the middle, it can block the operation.
> 
> i don't see any critical drawback of setting FD_CLOEXEC as default.
> the application which needs to pass the alsa-lib's fds _explicitly_
> can reset the bit via fcntl() again before calling exec().

Do we have any precedence? sockets? fopen? etc.?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
