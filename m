From: Steve Harris <S.W.Harris@ecs.soton.ac.uk>
Subject: Re: anybody else OK with current CVS *and* SMP?
Date: Thu, 7 Aug 2003 20:19:26 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030807191926.GO18664@ecs.soton.ac.uk>
References: <1060280740.16467.24.camel@cmn37.stanford.edu> <200308071830.h77IUqLX028995@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200308071830.h77IUqLX028995@localhost.localdomain>
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

On Thu, Aug 07, 2003 at 02:30:52PM -0400, Paul Davis wrote:
> true, but JACK almost does this by itself. when run with -R, a highpri
> SCHED_FIFO task runs every 5 (?) seconds, and requires that the engine
> has checked in since the last time. this prevents loops within JACK
> from stalling the entire system.
> 
> anyway, the fact that ctrl-alt-sysrq doesn't work either is a good
> indication of a deeper problem than a runaway SCHED_FIFO task. i think.

I've had little luck with ctrl-alt-sysrq and usb keyboards.

- Steve


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
