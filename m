From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: [BUG] alsa-lib leaves sound device open for child processes
Date: Wed, 5 Feb 2003 22:39:22 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030205223922.80686.qmail@web40607.mail.yahoo.com>
References: <20030205205905.7800db0c.sebastian_kapfer@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030205205905.7800db0c.sebastian_kapfer@web.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sebastian Kapfer <sebastian_kapfer@web.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 --- Sebastian Kapfer <sebastian_kapfer@web.de> wrote:
> May I ask what the child process is supposed to to
> with a raw ALSA file
> descriptor? AFAICT, developers are supposed to use
> the alsa-lib API, and
> not write to FD's. So the underlying file descriptor
> looks to me like a
> mere implementation detail which 99% of all users
> shouldn't need to care about.

I consider this situation analogous to the
relationship between file descriptors and FILE*
pointers. By your argument, libc should probably set
the FD_CLOEXEC flag here, too. But it doesn't.

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
