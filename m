From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: my first usb-midi experiment ends with segmentation fault
Date: Tue, 30 Jul 2002 23:43:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207302343.32848.plcl@telefonica.net>
References: <20020728213924.GA522@tuba.home> <3D46C107.2E108CEB@ladisch.de> <20020730181834.GA494@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020730181834.GA494@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: martin-langer@gmx.de, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

El Mar 30 Jul 2002 20:18, Martin Langer escribió:
> The only strange thing I found are the unknown parts of the lsusb output
> (broken descriptor?) and the impossible module reload = segfault.
>

These 'unknown descriptor' lines at lsusb output are jack descriptors and MS 
endpoint descriptors, as required by the specification documents (see 
midi10.pdf, pages 39-43). The lsusb utility should be updated.

I will try to manually decode that descriptors.

>
> Bus 001 Device 002: ID 0a4d:008e
>   Language IDs: none (invalid length string descriptor bf; len=0)
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.00
>   bDeviceClass            1 Audio
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x0a4d
>   idProduct          0x008e
>   bcdDevice            2.00
>   iManufacturer           1
>   iProduct                2
>   iSerial                 0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength          101
>     bNumInterfaces          2
>     bConfigurationValue     1
>     iConfiguration          3
>     bmAttributes         0xc0
>       Self Powered
>     MaxPower                0mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      1 Control Device
>       bInterfaceProtocol      0
>       iInterface              0
>       AudioControl Interface Descriptor:
>         bLength                 9
>         bDescriptorType        36
>         bDescriptorSubtype      1 (HEADER)
>         bcdADC               1.00
>         wTotalLength            9
>         bInCollection           1
>         baInterfaceNr( 0)       1
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      3 Non Streaming
>       bInterfaceProtocol      0
>       iInterface              0
>   unknown descriptor type: 07 24 01 00 01 41 00
		Class Specific Interface Descriptor
			bLength				7
			bDescriptorType		0x24  (CS_INTERFACE)
			bDescriptorSubtype		1  header
			bcdADC				1.0
			wTotalLength			65 

>   unknown descriptor type: 06 24 02 01 01 00
		MIDI Jack Descriptor
			bLength				6
			bDescriptorType		0x24
			bDescriptorSubtype		2  IN
			bJackType				1  EMBEDDED
			bJackID				1

>   unknown descriptor type: 06 24 02 02 02 00
		MIDI Jack Descriptor
			bLength				6
			bDescriptorType		0x24
			bDescriptorSubtype		2  IN
			bJackType				2  EXTERNAL
			bJackID				2

>   unknown descriptor type: 09 24 03 01 03 01 02 01 00
		MIDI Jack Descriptor
			bLength				9
			bDescriptorType		0x24
			bDescriptorSubtype		3  OUT
			bJackType				1  EMBEDDED
			bJackID				3
			bNrInputPins			1
			BaSourceID			2
			BaSourcePin			1

>   unknown descriptor type: 09 24 03 02 04 01 01 01 00
		MIDI Jack Descriptor
			bLength				9
			bDescriptorType		0x24
			bDescriptorSubtype		3  OUT
			bJackType				2  EXTERNAL
			bJackID				4
			bNrInputPins			1
			BaSourceID			1
			BaSourcePin			1

>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               none
>         wMaxPacketSize         64
>         bInterval               0
>         bRefresh                0
>         bSynchAddress           0
>   unknown descriptor type: 05 25 01 01 03
			MIDIStreaming Bulk Endpoint Descriptor
				bLength				5
				bDescriptorType		0x25 (CS_ENDPOINT)
				bDescriptorSubtype		1 MS_GENERAL
				bNumEmbMIDIJack		1
				BaAssocJackID			3

>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x02  EP 2 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               none
>         wMaxPacketSize         64
>         bInterval               0
>         bRefresh                0
>         bSynchAddress           0
>   unknown descriptor type: 05 25 01 01 01
			MIDIStreaming Bulk Endpoint Descriptor
				bLength				5
				bDescriptorType		0x25 (CS_ENDPOINT)
				bDescriptorSubtype		1 MS_GENERAL
				bNumEmbMIDIJack		1
				BaAssocJackID			1

>   Language IDs: none (invalid length string descriptor bf; len=0)

Regards,
Pedro





-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
