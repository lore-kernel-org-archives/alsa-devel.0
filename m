From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: RME HDSP 9632 driver
Date: Mon, 11 Aug 2003 09:00:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32833.62.106.184.128.1060585201.squirrel@www.undata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

> Is there an RME HDSP 9632 driver in development?
> The current hdsp driver from 0.9.6 will not load claiming the device is
not  present.
>
> Thank you.
>
>

No that I know of. The hdsp 9632 is quite different from the other hdsp
cards. Supporting it will require non-trivial driver adaptation. Right now
the driver claims the device is not present because it doesn't recognise
the card revision number (>= 0x96). I've asked RME about the card, I'll
let you know.

Thomas





-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
