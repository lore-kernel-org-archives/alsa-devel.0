From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Using specific code for midi/gameport instead of
 generic one.
Date: Mon, 7 Feb 2005 10:35:01 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0502071024410.3379-100000@studcom.urz.uni-halle.de>
References: <4203CEEC.9000700@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <4203CEEC.9000700@free.fr>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: matthieu castet <castet.matthieu@free.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

matthieu castet wrote:
> what's the advantage of using specific code (via82xx.c for example) for
> managing midi/gameport instead of the generic module mpu401 and ns558 ?

The MPU-401 code in via82xx.c is used only for VT82C686 chips where
the MIDI port shares an interrupt with the AC'97 controller.

There is no reason for the gameport code, except that it would work
even if PnP happens to be disabled.

> These modules should be able to use pnp layer, so they should be able to
> know/change the io ports in use without writing directly in LPC pci device.

There is no driver that changes I/O ports by writing to the LPC bridge
device.  This wouldn't work anyway because the driver wouldn't know
how to reconfigure the SuperIO chip behind the bridge.


Best regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
