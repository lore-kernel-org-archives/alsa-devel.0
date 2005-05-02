From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: re multiple C-Ports
Date: Mon, 2 May 2005 10:54:59 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0505021050550.21377-100000@studcom.urz.uni-halle.de>
References: <20050502045322.D3D77715CB@mail.netspace.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050502045322.D3D77715CB@mail.netspace.net.au>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Geoff Beasley <songshop@bizmedia.com.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Geoff Beasley wrote:
> The first thing I added was a ctl; ctl.both... jack needs this
> apparently.

Yes (but it shouldn't).

> I can see 24 outputs in half duplex and mount them in
> Ardour and play them back, however if we use spdif to sync the
> cards together the x-runs begin in earnest... no spdif and it
> works better, tho eventually we get the x-run avalanche.

I don't really know, but this would indicate that the cards aren't
really synchronized.  Perhaps you should ask somebody else who
actually has two ICE1712 cards.

> Capture won't work at all; jack just zombies no matter what.

What does it say?

> Another thing, alsa seems to be being started by something else.

The hotplug system automatically loads USB and PCI drivers.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
