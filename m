From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [BUG] alsa-lib leaves sound device open for child
 processes
Date: Sat, 8 Feb 2003 12:50:01 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302081248510.1141-100000@pnote.perex-int.cz>
References: <20030207194628.20880.qmail@web40604.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030207194628.20880.qmail@web40604.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Cc: Sebastian Kapfer <sebastian_kapfer@web.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 7 Feb 2003, [iso-8859-1] Chris Rankin wrote:

>  --- Sebastian Kapfer <sebastian_kapfer@web.de> wrote:
> >> Setting FD_CLOEXEC automatically doesn't make the
> > library less powerful.
> > You can still unset the flag yourself __if you
> > really need the feature__
> > of inherited ALSA FD's. But wouldn't FD_CLOEXEC be
> > the "reasonable
> > default" setting, which is correct for 99% of all
> > applications?
> 
> Most of those "99% of all applications" don't spawn
> child processes at all and so don't care one way or
> another. (And did you know that 98.68% of all
> statistics are invented ;-)?)
> 
> All of the remaining applications should be
> considering what will happen to their resources on
> exec(), and I see no reason why careless programmers
> should have a few of their bugs swept under the rug
> for them.

I fully agree here.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
