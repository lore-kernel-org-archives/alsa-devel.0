From: Martin Langer <martin-langer@gmx.de>
Subject: Re: about usb midi endpoints quirks
Date: Wed, 30 Jul 2003 21:49:36 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030730194936.GA21226@tuba.home>
References: <20030729210926.GA10428@tuba.home> <Pine.HPX.4.33n.0307300927010.27054-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0307300927010.27054-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 30, 2003 at 09:58:18AM +0200, Clemens Ladisch wrote:
> Martin Langer wrote:
> > looking into usbquirks.h I saw that audio endpoints follow the rule:
> > 	0x0...  for output
> > 	0x8...  for input
> > I think that's absolutely ok!
> 
> This is for the endpoint field of the audioformat structure.
> 
> > And now: If I jump into the usb-midi world and try a similar quirk:
> >        .out_ep = 0x06,
> >        .in_ep = 0x86,
> > it will end with an "usb_submit_urb: -22" :-(
> >
> > OTOH the use of
> >     	.out_ep = 0x06,
> > 	.in_ep = 0x06,
> > will be accepted! :-)
> > And I believe the USB MIDI device definition use 0x8.. values for inputs.
> 
> The USB protocol defines an endpoint number as a 4-bit integer.
> Additionally, input and output endpoints are distinct, and are
> distinguished, when necessary, with bit 7 (0x80).
> 
> The audioformat structure is the same for both input and output,
> therefore it requires the "input" flag. The MIDI quirk structure has
> separate fields for input and output endpoints, so you must not use
> 0x80 in this case.

must not???

It doesn't work with the 0x80 flag!!! 
Only the 0x00 flag works! That was the point I've tried to explain. 

But I agree that the "must not" way would be a nice solution.
.......................maybe in the future?


martin


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
