From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: about usb midi endpoints quirks
Date: Wed, 30 Jul 2003 09:58:18 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0307300927010.27054-100000@studcom.urz.uni-halle.de>
References: <20030729210926.GA10428@tuba.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20030729210926.GA10428@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Martin Langer wrote:
> looking into usbquirks.h I saw that audio endpoints follow the rule:
> 	0x0...  for output
> 	0x8...  for input
> I think that's absolutely ok!

This is for the endpoint field of the audioformat structure.

> And now: If I jump into the usb-midi world and try a similar quirk:
>        .out_ep = 0x06,
>        .in_ep = 0x86,
> it will end with an "usb_submit_urb: -22" :-(
>
> OTOH the use of
>     	.out_ep = 0x06,
> 	.in_ep = 0x06,
> will be accepted! :-)
> And I believe the USB MIDI device definition use 0x8.. values for inputs.

The USB protocol defines an endpoint number as a 4-bit integer.
Additionally, input and output endpoints are distinct, and are
distinguished, when necessary, with bit 7 (0x80).

The audioformat structure is the same for both input and output,
therefore it requires the "input" flag. The MIDI quirk structure has
separate fields for input and output endpoints, so you must not use
0x80 in this case.


HTH
Clemens




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
