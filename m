From: Richard Chan <rspchan@starhub.net.sg>
Subject: [PATCH] Add Yamaha KX49 (USB MIDI controller) to
	usbquirks.h
Date: Wed, 09 Jul 2008 21:23:59 +0800
Message-ID: <4874BBEF.3000701@starhub.net.sg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_GcH3pHevCl172UY4rHAc+w)"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kbspmxp1.starhub.net.sg (kbsmtao175.starhub.net.sg
	[203.116.2.175]) by alsa0.perex.cz (Postfix) with ESMTP id 99ECA243D4
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jul 2008 15:24:02 +0200 (CEST)
Received: from southgate.starhub.net.sg (southgate.starhub.net.sg
	[203.117.3.5])
	by kbspmxp1.starhub.net.sg (8.13.7+Sun/8.13.7) with ESMTP id
	m69DEcfC007138
	for <alsa-devel@alsa-project.org>; Wed, 9 Jul 2008 21:14:38 +0800 (SGT)
Received: from presario.tancredi.dyndns.biz ([116.88.0.48])
	by kbsmtao1.starhub.net.sg
	(Sun Java System Messaging Server 6.2-9.07 (built Oct 18 2007))
	with ESMTPP id <0K3Q00MDHQJZFVA0@kbsmtao1.starhub.net.sg> for
	alsa-devel@alsa-project.org; Wed, 09 Jul 2008 21:23:59 +0800 (SGT)
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

This is a multi-part message in MIME format.

--Boundary_(ID_GcH3pHevCl172UY4rHAc+w)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT


This patch is for the Yamaha USB MIDI controller KX49.
http://www.yamahasynth.com/products/kx/index.html
It has a 3-port MIDI interface and an HID interface (it has a tiny 
keyboard subset).

--------------dmesg----------------------------------------------------------------
usb 6-2: new full speed USB device using uhci_hcd and address 3
usb 6-2: configuration #1 chosen from 1 choice
input: YAMAHA Corporation YAMAHA KX as 
/devices/pci0000:00/0000:00:1d.1/usb6/6-2/6-2:1.1/input/input12
input,hidraw1: USB HID v1.00 Keyboard [YAMAHA Corporation YAMAHA KX] on 
usb-0000:00:1d.1-2
usb 6-2: New USB device found, idVendor=0499, idProduct=104e
usb 6-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 6-2: Product: YAMAHA KX
usb 6-2: Manufacturer: YAMAHA Corporation
ALSA /home/richard/tmp/usb/usbmidi.c:1312: created 3 output and 3 input 
ports
usbcore: registered new interface driver snd-usb-audio
-------------end 
dmesg--------------------------------------------------------------


diff -u -r alsa-kernel/usb/usbquirks.h b/usb/usbquirks.h
--- alsa-kernel/usb/usbquirks.h    2008-07-08 21:35:42.000000000 +0800
+++ b/usb/usbquirks.h    2008-07-09 20:45:20.000000000 +0800
@@ -210,6 +210,7 @@
 YAMAHA_DEVICE(0x1043, NULL),
 YAMAHA_DEVICE(0x1044, NULL),
 YAMAHA_DEVICE(0x1045, NULL),
+YAMAHA_DEVICE(0x104E, "KX49"),
 YAMAHA_DEVICE(0x2000, "DGP-7"),
 YAMAHA_DEVICE(0x2001, "DGP-5"),
 YAMAHA_DEVICE(0x2002, NULL),


--Boundary_(ID_GcH3pHevCl172UY4rHAc+w)
Content-type: text/plain; name=PATCH
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=PATCH

diff -u -r alsa-kernel/usb/usbquirks.h b/usb/usbquirks.h
--- alsa-kernel/usb/usbquirks.h	2008-07-08 21:35:42.000000000 +0800
+++ b/usb/usbquirks.h	2008-07-09 20:45:20.000000000 +0800
@@ -210,6 +210,7 @@
 YAMAHA_DEVICE(0x1043, NULL),
 YAMAHA_DEVICE(0x1044, NULL),
 YAMAHA_DEVICE(0x1045, NULL),
+YAMAHA_DEVICE(0x104E, "KX49"),
 YAMAHA_DEVICE(0x2000, "DGP-7"),
 YAMAHA_DEVICE(0x2001, "DGP-5"),
 YAMAHA_DEVICE(0x2002, NULL),

--Boundary_(ID_GcH3pHevCl172UY4rHAc+w)
Content-type: text/plain; name=yamaha-lsusb.txt
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=yamaha-lsusb.txt

Bus 006 Device 003: ID 0499:104e Yamaha Corp. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0499 Yamaha Corp.
  idProduct          0x104e 
  bcdDevice            1.00
  iManufacturer           1 YAMAHA Corporation
  iProduct                2 YAMAHA KX
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          109
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 
      bInterfaceProtocol    255 
      iInterface              0 
      ** UNRECOGNIZED:  07 24 01 00 01 42 00
      ** UNRECOGNIZED:  06 24 02 02 01 00
      ** UNRECOGNIZED:  06 24 02 02 02 00
      ** UNRECOGNIZED:  06 24 02 02 03 00
      ** UNRECOGNIZED:  09 24 03 02 01 01 01 01 00
      ** UNRECOGNIZED:  09 24 03 02 02 01 01 01 00
      ** UNRECOGNIZED:  09 24 03 02 03 01 01 01 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      1 Keyboard
      iInterface              3 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.00
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      45
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10
Device Status:     0x0001
  Self Powered

--Boundary_(ID_GcH3pHevCl172UY4rHAc+w)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary_(ID_GcH3pHevCl172UY4rHAc+w)--
