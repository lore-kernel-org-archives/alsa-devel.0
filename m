From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: hdsp driver status
Date: Thu, 3 Jul 2003 06:55:50 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGAEGMCKAB.mknecht@controlnet.com>
References: <32847.81.50.18.84.1057230774.squirrel@www.undata.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <32847.81.50.18.84.1057230774.squirrel@www.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thomas,
   Great to have you back! Looking forward to the matrix mixer actually
working one of these days. I hope you can work it into your design
somewhere.

Thanks,
Mark

> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Thomas
> Charbonnel
> Sent: Thursday, July 03, 2003 4:13 AM
> To: alsa-devel@lists.sourceforge.net
> Subject: [Alsa-devel] hdsp driver status
>
>
> Hi,
>
> I've been off the net and busy for a long time. I apologize to anyone
> whose mail I didn't answer during this period. I'm slowly catching up with
> the huge activity that has been going on this list, focusing on the hdsp
> driver issues. I'd like to summarize the driver status :
>
> Fixed :
> * Marcus, Jaroslav : thanks for having solved the long (ever ? :)
> lasting hdsp midi bug !
>
> Done:
> * Takashi : I succesfully tested your memory preallocation patch (only
> the hdsp part of it, actually), thanks for it. (Thanks too for the
> addition of hdspconf to cvs, it is indeed the latest version).
>
> Remaining:
> * HDSP9652: the matrix mixer isn't yet handled right.
> * Rev11 + Multiface: either the firmware file is wrong or the io-box
> firmware upload scenario has changed for this card revision. Has anyone
> ever had success with this combination (or rev11 + Digiface) ?
>
> The attached patch :
> * Reenables the hdsp_check_for_iobox function Paul bypassed in his
> previous patch. This function is needed for mobile setups. It handles the
> cases where the iobox has been unplugged/replugged or lost power supply.
> * Fixes the channel limit Mark has reported on the HDSP9652 (24 instead of
> 26).
> * Fixes a locking issue reported by Joshua N Pritikin.
>
> David, Jesse and Patrick, I'm back at work on the totalmix clone. It
> should be out for testing really soon. Sorry for having been so
> unresponsive lately.
>
> Thomas
>
>
>




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
