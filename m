From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: [BUG] alsa-lib leaves sound device open for child processes
Date: Fri, 7 Feb 2003 19:54:28 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030207195428.87517.qmail@web40602.mail.yahoo.com>
References: <s5hk7gc133d.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk7gc133d.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 --- Takashi Iwai <tiwai@suse.de> wrote:
> i don't think it's a bug of the alsa-lib, too.
> it's a bug of mplayer.  mplayer should be fixed. 
> period.

Hooray! ;-)

> but, the problem is that this kind of bugs can be
> rarely found (nor appear).

I found lsof to be a most useful tool.

> on the contrary, if
> FD_CLOEXEC is set, you'll be able to notice what's

On the contrary, if FD_CLOEXEC is set then these kind
of bugs will be harder to spot because the library
will bury the bodies. But the application bugs will
still be there.

Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
