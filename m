Return-Path: <alsa-devel-bounces@alsa-project.org>
Message-ID: <3d5a5368f3a43ffc0114daf09c306d7e.squirrel@mungewell.org>
Date: Wed, 13 Apr 2016 00:38:18 -0600
From: "Simon Wood" <simon@mungewell.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20160413003818_48718"
Subject: [alsa-devel] Tascam US-122L - Corrupt USB descriptor
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: alsa-devel@vger.kernel.org
List-ID: <alsa-devel@alsa-project.org>

------=_20160413003818_48718
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi all,
I have been struggling for the past few days to get a Tascam US-122L (USB
sound-card/midi interface) working, despite reading numerous forum
postings I have only been able to get the midi portion working.

I note that the USB descriptor seems to be corrupt. It declares 2
interfaces, but then describes 3 separate with the same interface number
for the last 2... could it be that this is confusing the Linux USB stack?

I have attached a copy of the descriptor and an annotated 'lsusb -vv'.


>From my experience with the HID subsystem, they have a mechanism for
patching HID descriptors, is the same possible for the base USB
descriptor? Trolling through 'drivers/usb' I didn't see anything... any
suggestions?

If this is possible I can try to increase the interface count and renumber
the last one.

Cheers,
Simon.

PS. For reference the device is:
Model No: US-122L
Serial: (21)0120xxx
Other barcode: 043774021628
------=_20160413003818_48718
Content-Type: text/plain; name="us-122l-descriptors.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="us-122l-descriptors.txt"

00000000  12 01 00 02 00 00 00 40  44 06 0e 80 00 01 01 02  |.......@D.......|
00000010  03 01 09 02 48 00 02 01  00 80 f0 09 04 00 00 00  |....H...........|
00000020  ff 00 00 00 09 04 01 00  00 ff 00 00 00 09 04 01  |................|
00000030  01 04 ff 00 00 00 09 05  81 05 4e 00 01 00 00 09  |..........N.....|
00000040  05 02 05 4e 00 01 00 00  09 05 83 02 09 00 04 00  |...N............|
00000050  00 09 05 04 02 00 02 04  00 00                    |..........|
0000005a



Bus 001 Device 042: ID 0644:800e TEAC Corp. TASCAM US-122L
--
00000000  12 01 00 02 00 00 00 40  44 06 0e 80 00 01 01 02  |.......@D.......|
00000010  03 01 __________________________________________  |....H...........|
--
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x0644 TEAC Corp.
  idProduct          0x800e TASCAM US-122L
  bcdDevice            1.00
  iManufacturer           1 (error)				<------ Here be Errors!
  iProduct                2 (error)
  iSerial                 3 (error)
  bNumConfigurations      1

  Configuration Descriptor:
--
00000010  _____ 09 02 48 00 02 01  00 80 f0 ______________  |....H...........|
--
    bLength                 9
    bDescriptorType         2
    wTotalLength           72
    bNumInterfaces          2					<------- 2 interfaces
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              480mA


    Interface Descriptor:					<------ that's 1
--
00000010  _________________________________ 09 04 00 00 00  |....H...........|
00000020  ff 00 00 00 ____________________________________  |................|
--
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 

    Interface Descriptor:					<------ that's 2
--
00000020  ___________ 09 04 01 00  00 ff 00 00 00 ________  |................|
--
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 

    Interface Descriptor:					<------ that's 3, err wait...
--
00000020  _______________________________________ 09 04 01  |................|
00000030  01 04 ff 00 00 00 ______________________________  |..........N.....|
--
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1					<------ interface duplicate!!
      bAlternateSetting       1
      bNumEndpoints           4
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 

      Endpoint Descriptor:
--
00000030  _________________ 09 05  81 05 4e 00 01 00 00 __  |..........N.....|
--
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x004e  1x 78 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0

      Endpoint Descriptor:
--
00000030  _____________________________________________ 09  |..........N.....|
00000040  05 02 05 4e 00 01 00 00  _______________________  |...N............|
--
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x004e  1x 78 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0

      Endpoint Descriptor:
--
00000040  _______________________  09 05 83 02 09 00 04 00  |...N............|
00000050  00 ___________________________                    |..........|
--
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               4
        bRefresh                0
        bSynchAddress           0
      Endpoint Descriptor:
--
00000050  __ 09 05 04 02 00 02 04  00 00                    |..........|
--
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               4
        bRefresh                0
        bSynchAddress           0
Device Status:     0x0001
  Self Powered
------=_20160413003818_48718
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_20160413003818_48718--


--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
