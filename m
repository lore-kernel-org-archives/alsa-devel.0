From: Martin Langer <martin-langer@gmx.de>
Subject: about usb midi endpoints quirks
Date: Tue, 29 Jul 2003 23:09:26 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030729210926.GA10428@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


Hi,

looking into usbquirks.h I saw that audio endpoints follow the rule:
	0x0...  for output
	0x8...  for input
I think that's absolutely ok!

And now: If I jump into the usb-midi world and try a similar quirk:
       .out_ep = 0x06,
       .in_ep = 0x86,
it will end with an "usb_submit_urb: -22" :-(

OTOH the use of 
    	.out_ep = 0x06,
	.in_ep = 0x06,
will be accepted! :-)
And I believe the USB MIDI device definition use 0x8.. values for inputs.

Is that ALSA design (0x0.. numbers for input endpoints) really wanted?
Ok, it's also possible that my Tascam US-122 is far away from any standard
out there...


martin





-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
