From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [BUG] alsa-lib leaves sound device open for child processes
Date: Fri, 07 Feb 2003 08:03:24 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18h870-0002nZ-00@sc8-sf-list1.sourceforge.net>
References: <20030206231034.36902.qmail@web40607.mail.yahoo.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 06 Feb 2003 23:10:34 GMT."
             <20030206231034.36902.qmail@web40607.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Rankin <rankincj@yahoo.com>
Cc: Sebastian Kapfer <sebastian_kapfer@web.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>The API does not *need* to set the FD_CLOEXEC flag,
>and so it should not. It is the height of arrogance to
>assume that something has no use simply because you
>can't imagine using it.

there's a little detail you're forgetting. unless the hw supports
multi-open and the current number of subunits is below the limit of
the number of opens, then having the descriptor will cause all other
attempts to access the device to block (unless they explicitly request
non-blocking open, which means they then have to unset that flag for
normal application operation). this means that even if the parent has
closed the ALSA device, the child still (unwittingly) has it open. its
easy to imagine situations where the user will be completely puzzled
to find that another program cannot start up because they believe they
exited from the previous audio program. they don't understand that the
child process it started (say, a bug reporting system) still has the
device open.

this is quite different from how file descriptors that refer to disk
files, ttys and most other devices operate.

of course, its questionable whether the block-on-open approach is
correct, but so far discussions on this list have supported it.

--p


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
