From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: anybody else OK with current CVS *and* SMP?
Date: Thu, 07 Aug 2003 00:20:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F317F27.7010702@cucumelo.org>
References: <200308051417.h75EHwpr020319@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

>
>
>i am having a repeated problem with system lockups using current CVS
>with JACK running SCHED_FIFO on an SMP system, with the Planet's
>2.4.21 kernel.
>
>can anyone report that a similar configuration is working for them?
>there is no way to diagnose the situation, because the kernel hangs
>totally and completely, and its not possible to get the output from
>either an oops or the magic-request key(s).
>
>it seems to be less of a problem when JACK is running without
>SCHED_FIFO. 
>  
>
A couple of month agoo I've tried to upgrade the ALSA CVS, and I 
remember that I got
almost exactly the same sympton that you are describing.

Sometimes when running JACK without X, the SysRQ key works, however
I did not get any useful information from it, I did not get any 
interactive response
from the developer list, and I've been very lasy ....

Since that I'm using a very old ALSA CVS version from May 17, that seems
to work fine with SMP.

/Benny



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
