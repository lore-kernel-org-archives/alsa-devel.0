From: Sebastian Kapfer <sebastian_kapfer@web.de>
Subject: Re: [BUG] alsa-lib leaves sound device open for child processes
Date: Fri, 7 Feb 2003 15:37:20 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030207153720.1410d9e6.sebastian_kapfer@web.de>
References: <20030206154054.3b9ad91d.sebastian_kapfer@web.de>
	<20030206231034.36902.qmail@web40607.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030206231034.36902.qmail@web40607.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 6 Feb 2003 23:10:34 +0000 (GMT)
Chris Rankin <rankincj@yahoo.com> wrote:

>  --- Sebastian Kapfer <sebastian_kapfer@web.de> wrote:
> > I can find a use for stdio FD's
> > in the new process either. The exec'd process can't
> > even know which FD corresponds to which file.
> 
> I'm assuming from the context of your message that you
> meant "CAN'T find a use ... either".

You're right, sorry :)

> But the whole point of a general purpose API (which is what libc is
> and presumably is what ALSA aspires to have) is to
> support *ALL* possible uses, whether you can imagine
> them or not.

Setting FD_CLOEXEC automatically doesn't make the library less powerful.
You can still unset the flag yourself __if you really need the feature__
of inherited ALSA FD's. But wouldn't FD_CLOEXEC be the "reasonable
default" setting, which is correct for 99% of all applications?

> It is the height of arrogance to assume that something has no use
> simply because you can't imagine using it.

I'm not implying that this feature should be banned... in fact it can't
be banned. As long as the programmer can retrieve the underlying FD
number from the ALSA library, he can always (un)set FD_CLOEXEC. My point
is that the current default behaviour is (at least IMHO) unfortunate.

-- 
Best Regards,   |   Hi! I'm a .signature virus. Copy me into
 Sebastian      |   your ~/.signature to help me spread!


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
