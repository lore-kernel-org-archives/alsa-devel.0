From: "Andreas Kuckartz" <A.Kuckartz@ping.de>
Subject: Re: Edirol UA-1X
Date: 1 Feb 2004 18:07:11 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <003301c3e8e5$d5454f70$a501a8c0@computer2>
References: <20040201163131.GA1549@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank Barknecht <fbar@footils.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I am using an Edirol UA-1X with the standard Demudi-kernel (version 2.4.22
with ALSA 0.9.8). While I also see the "default" id I do not have the
problems which you describe. I have also successfully used the UA-1X with
SuSE 8.2.

I have not yet really tried to use it with a 2.6 kernel and a newer version
of ALSA.

Cheers,
Andreas

----- Original Message ----- 
From: "Frank Barknecht" <fbar@footils.org>
To: <alsa-devel@lists.sourceforge.net>
Sent: Sunday, February 01, 2004 5:31 PM
Subject: [Alsa-devel] Edirol UA-1X


> Hallo,
>
> here's the second one of my current USB bulk messages:
>
> I'm trying to get the Edirol UA-1X to work, which I didn't find in the
> list of supported devices yet, so maybe this has some interesting
> information for driver developers.
>
> Plugging in the device into a 2.6.1 kernel with ALSA cvs from
> yesterday, gives these log-messages:
>
> Feb  1 17:16:21 fliwatut kernel: hub 1-0:1.0: new USB device on port 1,
assigned address 2
> Feb  1 17:16:22 fliwatut usb.agent[1429]: ... no modules for USB product
8bb/2902/100
> Feb  1 17:16:22 fliwatut usb.agent[1445]: ... no modules for USB product
8bb/2902/100
> Feb  1 17:16:22 fliwatut usb.agent[1461]: kernel driver hid already loaded
> Feb  1 17:16:22 fliwatut kernel: drivers/usb/input/hid-core.c: ctrl urb
status -75 received
> Feb  1 17:16:27 fliwatut kernel: usb 1-1: control timeout on ep0out
>
> After that /proc/asound/cards recognizes (?) it like this (card 0 not
> shown):
>
> 1 [default        ]: USB-Audio - USB Audio CODEC
> Burr-Brown from TI               USB Audio CODEC  at usb-0000:00:07.2-1
>
> which is a bit strange, because "default" should be a reserved id,
> shouldn't it?
>
> If I try to play over hw:1 or plughw:1 with aplay, or if I try to open
> alsamixer on it or if I try to do anything involving the card, the
> relevant process hangs forever. Even the alsasound init script hangs
> when it tries to store the mixer settings on reboot, so I have to use
> the Magic Sysreq keys to actually be able to reboot. Otherwise the
> machine works fine, I still can use the first soundcard.
>
> Below's the usual lsusb -vv output, but to my eyes this looks as if the
> Edirol device isn't among the displayed settings. Feel free to ask for
> more debugging info. Any chances to get this to work?
>
> lsusb:
>
> Bus 002 Device 001: ID 0000:0000
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.10
>   bDeviceClass            9 Hub
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0         8
>   idVendor           0x0000
>   idProduct          0x0000
>   bcdDevice            2.06
>   iManufacturer           3 Linux 2.6.1 uhci_hcd
>   iProduct                2 UHCI Host Controller
>   iSerial                 1 0000:00:07.3
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           25
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0x40
>       Self Powered
>     MaxPower                0mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         9 Hub
>       bInterfaceSubClass      0
>       bInterfaceProtocol      0
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               none
>         wMaxPacketSize          2
>         bInterval             255
>   Language IDs: (length=4)
>      0409 English(US)
>
> Bus 001 Device 001: ID 0000:0000
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.10
>   bDeviceClass            9 Hub
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0         8
>   idVendor           0x0000
>   idProduct          0x0000
>   bcdDevice            2.06
>   iManufacturer           3 Linux 2.6.1 uhci_hcd
>   iProduct                2 UHCI Host Controller
>   iSerial                 1 0000:00:07.2
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           25
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0x40
>       Self Powered
>     MaxPower                0mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         9 Hub
>       bInterfaceSubClass      0
>       bInterfaceProtocol      0
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               none
>         wMaxPacketSize          2
>         bInterval             255
>   Language IDs: (length=4)
>      0409 English(US)
>
> ciao
> -- 
>  Frank Barknecht                               _ ______footils.org__
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
