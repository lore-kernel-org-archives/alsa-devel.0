From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: [BUG] alsa-lib leaves sound device open for child processes
Date: Fri, 7 Feb 2003 13:58:48 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030207135848.567.qmail@web40611.mail.yahoo.com>
References: <E18h870-0002nZ-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18h870-0002nZ-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 --- Paul Davis <paul@linuxaudiosystems.com> wrote:
> there's a little detail you're forgetting. unless
> the hw supports multi-open and the current number of
> subunits is below the limit of the number of opens,
> then having the descriptor will cause all other
> attempts to access the device to block (unless they
> explicitly request non-blocking open, which means
> they then have to unset that flag for normal
> application operation

I hadn't forgotten. The situation to which you are
referring is called "a bug in the *application*".
Determining the destinies of resources, delivery of
signals etc when spawning child processes is the
application-programmer's responsibility.

And yes, I have tracked down bugs like this before.
And I *did* fix the application.

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
