From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Creamware Noah, snd-usb-audio capable?
Date: Wed, 18 Feb 2004 09:03:02 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402180856160.27415-200000@studcom.urz.uni-halle.de>
References: <1077037445.3938.15.camel@chief.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_OT0dva03wiiaNfPJgpdGZw)"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1077037445.3938.15.camel@chief.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hartmut Geissbauer <nwgbh@swissonline.ch>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary_(ID_OT0dva03wiiaNfPJgpdGZw)
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT

Hartmut Geissbauer wrote:
> But to me it looks like, the audio interfaces are detected
> correctly as well.
>
> C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
> C:  #Ifs= 5 Cfg#= 2 Atr=c0 MxPwr=  0mA

Configuration #1 is still active.

> ... snd-usb-audio is in use. Don't ask me from whom. lsmod won't
> tell me.
>
> Module                  Size  Used by
> snd_usb_audio          70710  1
>
> ERROR: Removing 'snd_usb_audio': Device or resource busy
>
> It isn't released even if I unplug the device.

It seems it isn't possible to change the configuration at the place I
tried to do it, and the USB core gets thoroughly confused.

> > If that doesn't work, it would be possible to write a separate program
> > that switches the configuration, so that the audio driver can be
> > loaded later.
> >
> Am I right, that this separate program is handled by hotplug?

Yes (if somebody writes a hotplug script for it).

> Might the patch(the code in it) for usbaudio.c you posted before be
> helpfull for the program?

No. Please remove the patch.

Then compile the attached program (it requires libusb), and run it by
hand; after that, load snd-usb-audio.


> BTW: How many devices/"cards" is the snd-usb-audio driver able to
> handle?

8 (ALSA's card limit)


HTH
Clemens

--Boundary_(ID_OT0dva03wiiaNfPJgpdGZw)
Content-id: <Pine.HPX.4.33n.0402180903020.27415@studcom.urz.uni-halle.de>
Content-type: TEXT/PLAIN; charset=US-ASCII; name=noahinit.c
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=noahinit.c
Content-description: 

/*
 * noahinit.c - initialize a Creamware Noah to configuration #2
 *
 * ... blah blah ... freeware ... blah blah ... no warranty ... blah blah ...
 *
 * compile with "gcc -o noahinit noahinit.c -lusb"
 */

#include <stdio.h>
#include <usb.h>

static void noah_init(struct usb_device *dev)
{
	usb_dev_handle *h = usb_open(dev);
	if (!h) {
		puts("Open failed!");
		return;
	}

	puts("Setting configuration 2");
	usb_set_configuration(h, 2);

	usb_close(h);
}

int main(void)
{
	struct usb_bus *bus;
	struct usb_device *dev;

	usb_set_debug(1);

	usb_init();
	usb_find_busses();
	usb_find_devices();

	for (bus = usb_get_busses(); bus; bus = bus->next) {
		for (dev = bus->devices; dev; dev = dev->next) {
			if (dev->descriptor.idVendor == 0x1107 &&
			    dev->descriptor.idProduct == 0x0102) {
				printf("found Creamware Noah at %s\n", dev->filename);
				noah_init(dev);
			}
		}
	}
	return 0;
}

--Boundary_(ID_OT0dva03wiiaNfPJgpdGZw)--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
