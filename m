From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: anybody else OK with current CVS *and* SMP?
Date: Thu, 7 Aug 2003 09:41:54 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0308070933030.861-100000@ecabase.localdomain>
References: <200308051417.h75EHwpr020319@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200308051417.h75EHwpr020319@localhost.localdomain>
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

On Tue, 5 Aug 2003, Paul Davis wrote:

> i am having a repeated problem with system lockups using current CVS
> with JACK running SCHED_FIFO on an SMP system, with the Planet's
> 2.4.21 kernel.

No lockups so far with the following setup:

2.4.19-ll
ALSA CVS of today 
JACK CVS of today
snd-ens1371/snd-ice1712/snd-dummy low-level drivers (tried all three)
jackd run SCHED_FIFO with -n 3 -p 256
two or more JACK clients active

Do you get lockups if you use snd-dummy as the lowlevel driver? How about
without ardour (just jackd and some example clients running)?

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
