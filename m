From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Creamware Noah, snd-usb-audio capable?
Date: Wed, 11 Feb 2004 10:46:02 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402111036160.24733-100000@studcom.urz.uni-halle.de>
References: <20040210213617.GH10941@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20040210213617.GH10941@fliwatut.scifi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank Barknecht <fbar@footils.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Frank Barknecht wrote:
> Hartmut Geissbauer hat gesagt: // Hartmut Geissbauer wrote:
>
> > reading the different entries in usbquirks.h it looks like they are
> > taken from the usb-infos like lsusb provides. Is it very difficult to
> > take the infos from lsusb and translate it to an quirk?

It depends.  If the class-specific descriptors are missing, you have
to guess and try what the sample format actually is.

> [...] I was investigating why the Midi jacks on the Terratec Phase
> 26 aren't supported.
>
> I looked up the specification of usb-midi in
> http://www.usb.org/developers/devclass_docs/midi10.pdf and also looked
> very closely and for a long time at the lsusb output.  This interface
> descriptor then looks very much like it must be the midi interface:
>
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        3
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      3
>       bInterfaceProtocol      0
>       iInterface              3 TerraTec PHASE 26 USB
>   unknown descriptor type: 07 24 01 00 01 41 00
>   unknown descriptor type: 06 24 02 01 10 00
>   unknown descriptor type: 06 24 02 02 11 00
>   unknown descriptor type: 09 24 03 01 12 01 11 01 00
>   unknown descriptor type: 09 24 03 02 13 01 10 01 00
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x05  EP 5 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               none
>         wMaxPacketSize         64
>         bInterval               0
>         bRefresh                0
>         bSynchAddress           0
>   unknown descriptor type: 05 25 01 01 10
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x86  EP 6 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               none
>         wMaxPacketSize         64
>         bInterval               0
>         bRefresh                0
>         bSynchAddress           0
>   unknown descriptor type: 05 25 01 01 12
>
> The main reason for my assumption is the value for bInterfaceNumber
> which is "3" or 0x03 as it should be according to the USB spec which
> requires for a "MIDI Adapter Standard MIDIStreaming Interface
> Descriptor" to have this field set as follows:
>
> Offset Field                Size  Value   Description
> ...
> 6      bInterfaceSubclass   1     0x03   MIDISTREAMING.
> ...

The bInterfaceNumber field simply specifies the number (i.e., the
index) of the interface.  Interfaces must be numbered 0, 1, 2, etc.

>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      3
>       bInterfaceProtocol      0

The problem is that bInterfaceClass isn't set to 1 (Audio).

The class-specific descriptors are there (lsusb shows them as
"unknown" because it doesn't try to parse vendor-specific things), so
it should be possible to use the MIDI_STANDARD_INTERFACE quirk (see
below).


Regards,
Clemens

-- 

Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.26
diff -u -r1.26 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	20 Jan 2004 15:31:59 -0000	1.26
+++ alsa-kernel/usb/usbquirks.h	11 Feb 2004 09:33:45 -0000
@@ -688,4 +688,14 @@

 },

+{
+	USB_DEVICE_VENDOR_SPEC(0x0ccd, 0x0013),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Terratec",
+		.product_name = "PHASE 26",
+		.ifnum = 3,
+		.type = QUIRK_MIDI_STANDARD_INTERFACE
+	}
+},
+
 #undef USB_DEVICE_VENDOR_SPEC




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
