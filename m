From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: [BUG] alsa-lib leaves sound device open for child processes
Date: Thu, 6 Feb 2003 23:10:34 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030206231034.36902.qmail@web40607.mail.yahoo.com>
References: <20030206154054.3b9ad91d.sebastian_kapfer@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030206154054.3b9ad91d.sebastian_kapfer@web.de>
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
> I can find a use for stdio FD's
> in the new process either. The exec'd process can't
> even know which FD corresponds to which file.

I'm assuming from the context of your message that you
meant "CAN'T find a use ... either". But the whole
point of a general purpose API (which is what libc is
and presumably is what ALSA aspires to have) is to
support *ALL* possible uses, whether you can imagine
them or not.

The API does not *need* to set the FD_CLOEXEC flag,
and so it should not. It is the height of arrogance to
assume that something has no use simply because you
can't imagine using it.

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
