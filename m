From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Edirol UA-25
Date: Wed, 11 Aug 2004 11:02:26 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0408111043460.15385-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.58.0408101424520.17110@wotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.58.0408101424520.17110@wotan.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Matthias Nagorni <mana@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Matthias Nagorni wrote:
> what is the status regarding ALSA support for the new Edirol UA-25
> ?
> I heard that Edirol takes a lot of care to obey the USB audio
> specs, so perhaps it works out-of-the-box with ALSA ?

If a device obeys the USB audio specs, Windows will use the standard
Microsoft USB Audio driver to handle it -- but this driver has (had)
quite a few restrictions in older Windows versions, so things like
higher sample rates or MIDI wouldn't be available.  Therefore, most
Edirol devices have an "Advanced Driver" switch to select between
standard-but-restricted and advanced-but-needs-special-driver modes.

ALSA will support the UA-25 in standard mode, but then the device has
only 16 bits at 44.1 kHz and (probably) no MIDI.

To support MIDI I need to take a look at the Windows driver to
determine the product ID and interface numbers.  (The driver isn't yet
on Edirol's driver page.)

To support advanced sample formats, somebody has to show the "lsusb -v"
output of the device so that a quirk entry can be added to the driver.

> It might be that the UA-25 uses USB 2.0.

It doesn't, otherwise there would be no reason to disallow full duplex
at 96 kHz.

> Would this pose any problem ?

I think that the USB 2.0 support in the driver might work, and that
the problems with the two USB 2.0 devices known so far are caused by
something else.


Regards,
Clemens




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
