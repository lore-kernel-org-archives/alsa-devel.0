From: <xl600@teamspode.org>
Subject: Re: Roland UM-ONE support
Date: Mon, 13 Jun 2011 15:21:47 -0500
Message-ID: <3e82b73e7f9f511affe34efaa5772869@teamspode.org>
References: <9F52C3B0-26E8-4F7E-A805-4983F1C615B0@teamspode.org>
	<1307959152.4085.5.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bracey.site5.com (bracey.site5.com [174.120.252.82])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C49D243D8
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Jun 2011 22:21:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1] helo=webmail.teamspode.org)
	by bracey.site5.com with esmtpa (Exim 4.69)
	(envelope-from <xl600@teamspode.org>) id 1QWDdr-002QsB-MP
	for alsa-devel@alsa-project.org; Mon, 13 Jun 2011 15:21:47 -0500
In-Reply-To: <1307959152.4085.5.camel@mattotaupa>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 I looked through the 1.0.24.2 code and couldn't find any mention of the 
 UM-ONE or it's product ID.  Not a surprise considering this came out 
 only a few days ago.

 The UM-1G:

 Bus 005 Device 003: ID 0582:0105 Roland Corp.
 Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.10
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x0582 Roland Corp.
   idProduct          0x0105
   bcdDevice            1.00
   iManufacturer           1 Roland
   iProduct                2 UM-1G
   iSerial                 0
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength          101
     bNumInterfaces          2
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0x80
     MaxPower               60mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           0
       bInterfaceClass         1 Audio
       bInterfaceSubClass      1 Control Device
       bInterfaceProtocol      0
       iInterface              0
       AudioControl Interface Descriptor:
         bLength                 9
         bDescriptorType        36
         bDescriptorSubtype      1 (HEADER)
         bcdADC               1.00
         wTotalLength            9
         bInCollection           1
         baInterfaceNr( 0)       1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       0
       bNumEndpoints           2
       bInterfaceClass         1 Audio
       bInterfaceSubClass      3 MIDI Streaming
       bInterfaceProtocol      0
       iInterface              0
       MIDIStreaming Interface Descriptor:
         bLength                 7
         bDescriptorType        36
         bDescriptorSubtype      1 (HEADER)
         bcdADC               1.00
         wTotalLength           65
       MIDIStreaming Interface Descriptor:
         bLength                 6
         bDescriptorType        36
         bDescriptorSubtype      2 (MIDI_IN_JACK)
         bJackType               1 Embedded
         bJackID                64
         iJack                   0
       MIDIStreaming Interface Descriptor:
         bLength                 6
         bDescriptorType        36
         bDescriptorSubtype      2 (MIDI_IN_JACK)
         bJackType               2 External
         bJackID               128
         iJack                   0
       MIDIStreaming Interface Descriptor:
         bLength                 9
         bDescriptorType        36
         bDescriptorSubtype      3 (MIDI_OUT_JACK)
         bJackType               1 Embedded
         bJackID                32
         bNrInputPins            1
         baSourceID( 0)        128
         BaSourcePin( 0)         1
         iJack                   0
       MIDIStreaming Interface Descriptor:
         bLength                 9
         bDescriptorType        36
         bDescriptorSubtype      3 (MIDI_OUT_JACK)
         bJackType               2 External
         bJackID                16
         bNrInputPins            1
         baSourceID( 0)         64
         BaSourcePin( 0)         1
         iJack                   0
       Endpoint Descriptor:
         bLength                 9
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               0
         bRefresh                0
         bSynchAddress           0
         MIDIStreaming Endpoint Descriptor:
           bLength                 5
           bDescriptorType        37
           bDescriptorSubtype      1 (GENERAL)
           bNumEmbMIDIJack         1
           baAssocJackID( 0)      64
       Endpoint Descriptor:
         bLength                 9
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               0
         bRefresh                0
         bSynchAddress           0
         MIDIStreaming Endpoint Descriptor:
           bLength                 5
           bDescriptorType        37
           bDescriptorSubtype      1 (GENERAL)
           bNumEmbMIDIJack         1
           baAssocJackID( 0)      32

 That appears as a pretty normal MIDI interface.

 The UM-ONE however, does not seem to be following the same rules:

 Bus 005 Device 004: ID 0582:012a Roland Corp.
 Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.10
   bDeviceClass          255 Vendor Specific Class
   bDeviceSubClass         0
   bDeviceProtocol       255
   bMaxPacketSize0        64
   idVendor           0x0582 Roland Corp.
   idProduct          0x012a
   bcdDevice            1.00
   iManufacturer           1 Roland
   iProduct                2 UM-ONE
   iSerial                 0
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           67
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0x80
     MaxPower               70mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           2
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      3
       bInterfaceProtocol      0
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x02  EP 2 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               0
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       1
       bNumEndpoints           2
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      3
       bInterfaceProtocol      0
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x02  EP 2 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               1

 Obviously, alsa will not be able to detect this as a generic USB midi 
 interface.  Roland seems to have ignored the USB standard and set the 
 bInterfaceClass to a non standard value (Should be 0x01).  Is this doom 
 for alsa and the UM-ONE then?

>
> ALSA 1.0.17 is pretty old. I guess you should try the current version
> 1.0.24.2 or build it from source.
>
> If you still have problems you should read the debug information [2] 
> and
> provide the necessary information if you still encounter problems.
>
>
> Thanks,
>
> Paul
>
>
> [1] http://www.alsa-project.org/main/index.php/Main_Page
> [2] http://www.alsa-project.org/main/index.php/Help_To_Debug
