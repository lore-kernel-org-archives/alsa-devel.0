From: Sebastian Kapfer <sebastian_kapfer@web.de>
Subject: Re: [BUG] alsa-lib leaves sound device open for child processes
Date: Thu, 6 Feb 2003 15:40:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030206154054.3b9ad91d.sebastian_kapfer@web.de>
References: <20030205205905.7800db0c.sebastian_kapfer@web.de>
	<20030205223922.80686.qmail@web40607.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030205223922.80686.qmail@web40607.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Rankin <rankincj@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 5 Feb 2003 22:39:22 +0000 (GMT)
Chris Rankin <rankincj@yahoo.com> wrote:

>  --- Sebastian Kapfer <sebastian_kapfer@web.de> wrote:
> > May I ask what the child process is supposed to to
> > with a raw ALSA file
> > descriptor? AFAICT, developers are supposed to use
> > the alsa-lib API, and
> > not write to FD's. So the underlying file descriptor
> > looks to me like a
> > mere implementation detail which 99% of all users
> > shouldn't need to care about.
> 
> I consider this situation analogous to the
> relationship between file descriptors and FILE*
> pointers. By your argument, libc should probably set
> the FD_CLOEXEC flag here, too. But it doesn't.

Can you explain _why_ this is the case? I can find a use for stdio FD's
in the new process either. The exec'd process can't even know which FD
corresponds to which file.

-- 
Best Regards,   |   Hi! I'm a .signature virus. Copy me into
 Sebastian      |   your ~/.signature to help me spread!


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
