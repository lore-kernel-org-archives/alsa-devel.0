From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [ANN] hdspmixer-1.1
Date: Wed, 30 Jul 2003 07:43:42 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307301143.h6UBhgCq019918@localhost.localdomain>
References: <32966.10.0.0.1.1059563304.squirrel@www.undata.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 30 Jul 2003 13:08:24 +0200."
             <32966.10.0.0.1.1059563304.squirrel@www.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: frankgaetano@collegeclub.com, jesse@essej.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>It depends on what you call newest :)
>If, as your mail seems to imply, you bought your card before May,  I guess
>you have 0xb (rev 11) and everything is working fine now if you use the
>latest alsa-driver and alsa-tools packages.
>If you bought your card this month, then you may have 0x32 (rev 50). I
>posted a small patch a few days ago to support these new cards, it should
>work fine, but you'll have build the driver from cvs.

although thomas and i both agree that there are still some issues
following cold boots for any h/w supported by the hdsp driver. the
solution in most cases is to reboot, but wait to either load the
driver (for pcmcia interfaces) or wait to run hdsploader (for pci
interfaces) till after the system is up. we have no idea what causes
this at this point in time.

warm boots seem to work 100%.

--p



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
