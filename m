From: Paul Davis <paul@linuxaudiosystems.com>
Subject: anybody else OK with current CVS *and* SMP?
Date: Tue, 5 Aug 2003 10:17:58 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308051417.h75EHwpr020319@localhost.localdomain>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

i am having a repeated problem with system lockups using current CVS
with JACK running SCHED_FIFO on an SMP system, with the Planet's
2.4.21 kernel.

can anyone report that a similar configuration is working for them?
there is no way to diagnose the situation, because the kernel hangs
totally and completely, and its not possible to get the output from
either an oops or the magic-request key(s).

it seems to be less of a problem when JACK is running without
SCHED_FIFO. 

--p


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
