From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: alsasound init script (Re: possible problems with rc6 aplay )
Date: Fri, 20 Dec 2002 23:53:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200212202353.13933.plcl@telefonica.net>
References: <E18PTTN-0004YV-00@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18PTTN-0004YV-00@sc8-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Friday 20 December 2002 21:09, Clemens Ladisch wrote:
> Takashi Iwai wrote:
> > Mark Knecht wrote:
> > > I was wondering what would happen in this process if someone had two r
> > > three identical USB devices, like the MidiMan 2X2? OR also two
> > > identical cards like the RME HDSP 9652?
> >
> > when a module is loaded and two or more identical (or supported)
> > devices are connected, the module will initialize the all such devices
> > at once.
> >
> > for multiple devices, you can specify the options separated by commas,
> >
> > > It is important that the system recognize the same hardware as the same
> > > sound device every time the machine booted, and whether the machine is
> > > warm or cold booted.
> >
> > in the case of usb, it's not 100% sure, because it's anyway
> > hotpluggable.  but usually the order of probing is identical, so it's
> > ok.

The probing order is the same if you plug everytime the same device at the 
same USB bus/port. Hotplug agent also receives an environment variable,  
DEVICE=/proc/bus/usb/001/002 or something like this, being the last numbers 
the USB bus and device numbers.

> It is possible to force USB devices to a specific index with the vid/pid
> parameters for the vendor/product id, even when hotplugging.
> However, this won't work when you hotplug two identical devices (with the
> same product id).

The vid/pid parameters work well for me, as i have two USB MIDI devices from  
different vendors. It works regarding the plug order, or the USB port used. 
Perhaps another parameter like usbdev=001/002 or something else could be 
useful in case that someone has several identical devices?

Clemens, I remember that /proc/asound/cards returned this bus/device  
information for USB MIDI devices some time ago (rc3?), like it does for my SB 
128 PCI.

Regards,
Pedro

-- 
ALSA Library Bindings for Pascal
http://alsapas.alturl.com



-------------------------------------------------------
This SF.NET email is sponsored by:  The Best Geek Holiday Gifts!
Time is running out!  Thinkgeek.com has the coolest gifts for
your favorite geek.   Let your fingers do the typing.   Visit Now.
T H I N K G E E K . C O M        http://www.thinkgeek.com/sf/
