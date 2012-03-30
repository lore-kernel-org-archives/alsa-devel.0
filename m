From: Grant Diffey <gdiffey@gmail.com>
Subject: lsusb -v for AKAI's new EIE pro interface
Date: Sat, 31 Mar 2012 09:03:31 +1100
Message-ID: <CACckToWdWZQFiFS_2GkjR=_0=TDdVApDxfwB0c_3HJ4bvjCejw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 86611104610
	for <alsa-devel@alsa-project.org>;
	Sat, 31 Mar 2012 00:03:32 +0200 (CEST)
Received: by werg1 with SMTP id g1so648883wer.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Mar 2012 15:03:31 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

So device is 4 in 4 out with inserts and midi

Composite with 2 interfaces. I can't tell if they're independent midi and
audio or more essoteric

anyone want to take a punt?



   1. Bus 001 Device 012: ID 09e8:0010 AKAI  Professional M.I. Corp.
   2. Device Descriptor:
   3.   bLength                18
   4.   bDescriptorType         1
   5.   bcdUSB               2.00
   6.   bDeviceClass          255 Vendor Specific Class
   7.   bDeviceSubClass       255 Vendor Specific Subclass
   8.   bDeviceProtocol       255 Vendor Specific Protocol
   9.   bMaxPacketSize0        64
   10.   idVendor           0x09e8 AKAI  Professional M.I. Corp.
   11.   idProduct          0x0010
   12.   bcdDevice            2.00
   13.   iManufacturer           1
   14.   iProduct                2
   15.   iSerial                 3
   16.   bNumConfigurations      1
   17.   Configuration Descriptor:
   18.     bLength                 9
   19.     bDescriptorType         2
   20.     wTotalLength           80
   21.     bNumInterfaces          2
   22.     bConfigurationValue     1
   23.     iConfiguration          0
   24.     bmAttributes         0x40
   25.       (Missing must-be-set bit!)
   26.       Self Powered
   27.     MaxPower                0mA
   28.     Interface Descriptor:
   29.       bLength                 9
   30.       bDescriptorType         4
   31.       bInterfaceNumber        0
   32.       bAlternateSetting       0
   33.       bNumEndpoints           0
   34.       bInterfaceClass       255 Vendor Specific Class
   35.       bInterfaceSubClass      0
   36.       bInterfaceProtocol      0
   37.       iInterface              0
   38.     Interface Descriptor:
   39.       bLength                 9
   40.       bDescriptorType         4
   41.       bInterfaceNumber        0
   42.       bAlternateSetting       1
   43.       bNumEndpoints           3
   44.       bInterfaceClass       255 Vendor Specific Class
   45.       bInterfaceSubClass      0
   46.       bInterfaceProtocol      0
   47.       iInterface              0
   48.       Endpoint Descriptor:
   49.         bLength                 7
   50.         bDescriptorType         5
   51.         bEndpointAddress     0x02  EP 2 OUT
   52.         bmAttributes            5
   53.           Transfer Type            Isochronous
   54.           Synch Type               Asynchronous
   55.           Usage Type               Data
   56.         wMaxPacketSize     0x009c  1x 156 bytes
   57.         bInterval               1
   58.       Endpoint Descriptor:
   59.         bLength                 7
   60.         bDescriptorType         5
   61.         bEndpointAddress     0x83  EP 3 IN
   62.         bmAttributes            2
   63.           Transfer Type            Bulk
   64.           Synch Type               None
   65.           Usage Type               Data
   66.         wMaxPacketSize     0x0200  1x 512 bytes
   67.         bInterval               4
   68.       Endpoint Descriptor:
   69.         bLength                 7
   70.         bDescriptorType         5
   71.         bEndpointAddress     0x04  EP 4 OUT
   72.         bmAttributes            2
   73.           Transfer Type            Bulk
   74.           Synch Type               None
   75.           Usage Type               Data
   76.         wMaxPacketSize     0x0200  1x 512 bytes
   77.         bInterval               4
   78.     Interface Descriptor:
   79.       bLength                 9
   80.       bDescriptorType         4
   81.       bInterfaceNumber        1
   82.       bAlternateSetting       0
   83.       bNumEndpoints           0
   84.       bInterfaceClass       255 Vendor Specific Class
   85.       bInterfaceSubClass      0
   86.       bInterfaceProtocol      0
   87.       iInterface              0
   88.     Interface Descriptor:
   89.       bLength                 9
   90.       bDescriptorType         4
   91.       bInterfaceNumber        1
   92.       bAlternateSetting       1
   93.       bNumEndpoints           2
   94.       bInterfaceClass       255 Vendor Specific Class
   95.       bInterfaceSubClass      0
   96.       bInterfaceProtocol      0
   97.       iInterface              0
   98.       Endpoint Descriptor:
   99.         bLength                 7
   100.         bDescriptorType         5
   101.         bEndpointAddress     0x81  EP 1 IN
   102.         bmAttributes            5
   103.           Transfer Type            Isochronous
   104.           Synch Type               Asynchronous
   105.           Usage Type               Data
   106.         wMaxPacketSize     0x0040  1x 64 bytes
   107.         bInterval               4
   108.       Endpoint Descriptor:
   109.         bLength                 7
   110.         bDescriptorType         5
   111.         bEndpointAddress     0x86  EP 6 IN
   112.         bmAttributes            2
   113.           Transfer Type            Bulk
   114.           Synch Type               None
   115.           Usage Type               Data
   116.         wMaxPacketSize     0x0200  1x 512 bytes
   117.         bInterval               1
   118. Device Status:     0x9000
   119.   (Bus Powered)
