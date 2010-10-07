From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Need expert's advice - Fast Track Ultra (8R)
 dropping samples
Date: Thu, 07 Oct 2010 10:50:43 +0200
Message-ID: <4CAD89E3.7080005@showlabor.de>
References: <4C9DC7A1.8050001@showlabor.de>
	<4CA5BF35.2030108@showlabor.de>	<4CA60C5B.6010809@ladisch.de>
	<4CA86E1A.30405@showlabor.de>	<4CAAD212.9090805@ladisch.de>
	<4CAC804A.8040806@showlabor.de>	<4CAC89EA.8080207@ladisch.de>
	<4CACA471.2000504@showlabor.de>	<4CAD6AA2.4050205@ladisch.de>
	<20101007081010.GZ7159@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000309040407040103060005"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203]) by alsa0.perex.cz (Postfix) with ESMTP id F19982440B
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Oct 2010 10:50:48 +0200 (CEST)
In-Reply-To: <20101007081010.GZ7159@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000309040407040103060005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Am 07.10.2010 10:10, schrieb Daniel Mack:
> On Thu, Oct 07, 2010 at 08:37:22AM +0200, Clemens Ladisch wrote:
>    
>>
>> So this device expects the computer to take the sample clock from the
>> capture data.   This is just like the UA-101; it should be possible to
>> write a similar driver (with opportunities for code sharing, and AFAIK
>> UAC 2 requires such a feedback mode, too).
>>      
> Ah, that makes sense, yes. UAC2 calls this mode "implicit feedback".
> Felix, can you provide a dump of "lsusb -v" for this device?
>
> Daniel
>    

I've attached a dump.

Thank you all for your increased interest!

Regards,

Felix

--------------000309040407040103060005
Content-Type: text/plain;
 name="lsusb-ftu8r.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="lsusb-ftu8r.txt"


Bus 001 Device 003: ID 0763:2081 Midiman M-Audio RunTime DFU
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 ?
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x0763 Midiman
  idProduct          0x2081 M-Audio RunTime DFU
  bcdDevice            1.51
  iManufacturer           1 M-Audio
  iProduct                2 Fast Track Ultra 8R
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          340
    bNumInterfaces          5
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         5
      bFunctionClass        255 Vendor Specific Class
      bFunctionSubClass       1 
      bFunctionProtocol       0 
      iFunction               2 Fast Track Ultra 8R
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      1 
      bInterfaceProtocol      0 
      iInterface              2 Fast Track Ultra 8R
      ** UNRECOGNIZED:  0b 24 01 00 01 34 00 03 01 02 03
      ** UNRECOGNIZED:  0c 24 02 01 03 06 00 08 03 00 00 00
      ** UNRECOGNIZED:  09 24 03 02 01 01 00 01 00
      ** UNRECOGNIZED:  0c 24 02 03 01 01 00 08 03 00 00 00
      ** UNRECOGNIZED:  09 24 03 04 03 06 00 03 00
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 
      bInterfaceProtocol      0 
      iInterface              0 
      ** UNRECOGNIZED:  07 24 01 03 01 01 00
      ** UNRECOGNIZED:  14 24 02 01 08 03 18 04 44 ac 00 80 bb 00 88 58 01 00 77 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0138  1x 312 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0003  1x 3 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 
      bInterfaceProtocol      0 
      iInterface              0 
      ** UNRECOGNIZED:  07 24 01 02 01 01 00
      ** UNRECOGNIZED:  14 24 02 01 08 03 18 04 44 ac 00 80 bb 00 88 58 01 00 77 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0138  1x 312 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 
      bInterfaceProtocol      0 
      iInterface              0 
      ** UNRECOGNIZED:  07 24 01 02 01 01 00
      ** UNRECOGNIZED:  14 24 02 01 08 03 18 04 44 ac 00 80 bb 00 88 58 01 00 77 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0138  1x 312 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      3 MIDI Streaming
      bInterfaceProtocol      0 
      iInterface              4 Fast Track Ultra 8R
      MIDIStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           63
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               1 Embedded
        bJackID                 1
        iJack                   0 
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               2 External
        bJackID                 2
        iJack                   0 
      MIDIStreaming Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
      Warning: Descriptor too short
        bJackType               1 Embedded
        bJackID                 3
        bNrInputPins            1
        baSourceID( 0)          2
        BaSourcePin( 0)         1
        iJack                   8 
      MIDIStreaming Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
      Warning: Descriptor too short
        bJackType               2 External
        bJackID                 4
        bNrInputPins            1
        baSourceID( 0)          1
        BaSourcePin( 0)         1
        iJack                   0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x07  EP 7 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval               8
        MIDIStreaming Endpoint Descriptor:
          bLength                 5
          bDescriptorType        37
          bDescriptorSubtype      1 (GENERAL)
          bNumEmbMIDIJack         1
          baAssocJackID( 0)       1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x87  EP 7 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval               0
        MIDIStreaming Endpoint Descriptor:
          bLength                 5
          bDescriptorType        37
          bDescriptorSubtype      1 (GENERAL)
          bNumEmbMIDIJack         1
          baAssocJackID( 0)       3
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       254 Application Specific Interface
      bInterfaceSubClass      1 Device Firmware Update
      bInterfaceProtocol      0 
      iInterface              5 M-Audio DFU
      Device Firmware Upgrade Interface Descriptor:
        bLength                             9
        bDescriptorType                    33
        bmAttributes                        1
          Will Not Detach
          Manifestation Intolerant
          Upload Unsupported
          Download Supported
        wDetachTimeout                   2000 milliseconds
        wTransferSize                    1024 bytes
        bcdDFUVersion                   10.01
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0001
  Self Powered

--------------000309040407040103060005
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000309040407040103060005--
