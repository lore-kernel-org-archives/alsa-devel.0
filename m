From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: [ANN] hdspmixer-1.1
Date: Wed, 30 Jul 2003 13:08:24 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32966.10.0.0.1.1059563304.squirrel@www.undata.org>
References: <289844.1059532392410.JavaMail.java@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <289844.1059532392410.JavaMail.java@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: frankgaetano@collegeclub.com
Cc: jesse@essej.net, alsa-devel@lists.sourceforge.net, thomas@undata.org
List-Id: alsa-devel@alsa-project.org

>
> Hello everyone,
>  Does this mean that all of the software is now working with the newest
> version of the firmware for the HDSP? I have been out of the loop since
> May. I am sorry if I am eating up bandwidth. I just want to know if I
> should try working with the HDSP in Linux now rather than crappy
> Windose. :)
>
> Frank
>
>

It depends on what you call newest :)
If, as your mail seems to imply, you bought your card before May,  I guess
you have 0xb (rev 11) and everything is working fine now if you use the
latest alsa-driver and alsa-tools packages.
If you bought your card this month, then you may have 0x32 (rev 50). I
posted a small patch a few days ago to support these new cards, it should
work fine, but you'll have build the driver from cvs.

Thomas





-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
