From: Frank Barknecht <fbar@footils.org>
Subject: Some info about the Edirol UA-3 FX
Date: Mon, 2 Feb 2004 20:22:50 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040202192250.GA12719@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp1.netcologne.de (smtp1.netcologne.de [194.8.194.112])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA22722
	for <alsa-devel@alsa-project.org>; Mon, 2 Feb 2004 20:23:41 +0100
Received: from fliwatut.scifi (xdsl-213-196-226-9.netcologne.de [213.196.226.9])
	by smtp1.netcologne.de (Postfix) with ESMTP id 0211139A6A
	for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2004 20:22:53 +0100 (MET)
Received: from freak by fliwatut.scifi with local (Exim 3.36 #1 (Debian))
	id 1Anjek-0003MA-00
	for <alsa-devel@alsa-project.org>; Mon, 02 Feb 2004 20:22:50 +0100
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hallo,

I tested the Edirol UA-3 FX in my series of tests now, and this is
another device I cannot get to work. I get "no modules for USB product
582/50/100" in the logfiles. Attached is several diagnostics
information for later use. 

ciao
-- 
 Frank Barknecht                               _ ______footils.org__

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=edirolua3fx

=========
cat /proc/bus/usb/devices
=========

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.2-rc3 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:07.3
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.2-rc3 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:07.2
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 15 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=ff(vend.) Sub=00 Prot=ff MxPS= 8 #Cfgs=  1
P:  Vendor=0582 ProdID=0050 Rev= 1.00
S:  Manufacturer=EDIROL
S:  Product=UA-3FX
C:* #Ifs= 4 Cfg#= 1 Atr=80 MxPwr=250mA
I:  If#= 0 Alt= 0 #EPs= 0 Cls=ff(vend.) Sub=01 Prot=00 Driver=(none)
I:  If#= 1 Alt= 0 #EPs= 0 Cls=ff(vend.) Sub=02 Prot=00 Driver=(none)
I:  If#= 1 Alt= 1 #EPs= 1 Cls=ff(vend.) Sub=02 Prot=00 Driver=(none)
E:  Ad=01(O) Atr=09(Isoc) MxPS= 288 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 0 Cls=ff(vend.) Sub=02 Prot=00 Driver=(none)
I:  If#= 2 Alt= 1 #EPs= 1 Cls=ff(vend.) Sub=02 Prot=00 Driver=(none)
E:  Ad=82(I) Atr=05(Isoc) MxPS= 288 Ivl=1ms
I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=00 Driver=(none)
E:  Ad=03(O) Atr=02(Bulk) MxPS=   8 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS=   8 Ivl=0ms
=========
lsusb
=========
Bus 002 Device 001: ID 0000:0000  
Bus 001 Device 015: ID 0582:0050 Roland Corp. 
Bus 001 Device 001: ID 0000:0000  
=========
lsusb -vv
=========

Bus 002 Device 001: ID 0000:0000  
<snip>

Bus 001 Device 015: ID 0582:0050 Roland Corp. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         0 
  bDeviceProtocol       255 
  bMaxPacketSize0         8
  idVendor           0x0582 Roland Corp.
  idProduct          0x0050 
  bcdDevice            1.00
  iManufacturer           1 EDIROL
  iProduct                2 UA-3FX
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          193
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
    MaxPower              250mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      1 
      bInterfaceProtocol      0 
      iInterface              0 
  unknown descriptor type: 0a 24 01 00 01 34 00 02 01 02
  unknown descriptor type: 0c 24 02 01 01 01 00 02 03 00 00 00
  unknown descriptor type: 09 24 03 03 04 03 00 01 00
  unknown descriptor type: 0c 24 02 04 02 06 00 02 03 00 00 00
  unknown descriptor type: 09 24 03 07 01 01 00 04 00
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
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 
      bInterfaceProtocol      0 
      iInterface              0 
  unknown descriptor type: 07 24 01 01 00 01 00
  unknown descriptor type: 0b 24 02 01 02 03 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
        wMaxPacketSize        288
        bInterval               1
  unknown descriptor type: 07 25 01 00 02 00 02
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
  unknown descriptor type: 07 24 01 07 00 01 00
  unknown descriptor type: 0b 24 02 01 02 03 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize        288
        bInterval               1
  unknown descriptor type: 07 25 01 00 00 00 00
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize          8
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize          8
        bInterval               1
  Language IDs: (length=4)
     0409 English(US)

Bus 001 Device 001: ID 0000:0000  
<snip>

=========
/var/log/messages
=========
Feb  2 19:47:55 fliwatut kernel: hub 1-1:1.0: new USB device on port 1, assigned address 14
Feb  2 19:48:00 fliwatut kernel: usb 1-1.1: control timeout on ep0in
Feb  2 19:48:20 fliwatut last message repeated 4 times
Feb  2 20:00:46 fliwatut -- MARK --
Feb  2 20:01:49 fliwatut kernel: usb 1-1: USB disconnect, address 11
Feb  2 20:03:18 fliwatut kernel: hub 1-0:1.0: new USB device on port 2, assigned address 15
Feb  2 20:03:19 fliwatut usb.agent[12306]: ... no modules for USB product 582/50/100
Feb  2 20:03:19 fliwatut usb.agent[12285]: ... no modules for USB product 582/50/100
Feb  2 20:03:19 fliwatut usb.agent[12290]: ... no modules for USB product 582/50/100
Feb  2 20:03:19 fliwatut usb.agent[12278]: ... no modules for USB product 582/50/100

--zYM0uCDKw75PZbzx--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
