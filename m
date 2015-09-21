From: sypwex <sypwex@gmail.com>
Subject: Re: [Alsa-user] snd-usb-caiaq (NI Maschine Mikro)
 device not recognised by alsa
Date: Mon, 21 Sep 2015 23:10:12 +0300
Message-ID: <CAGPstWuWNbYpveL56Tznr3TMVGVqprrfAT-F7bGbc5e3nJkCSg@mail.gmail.com>
References: <CAGPstWvoprjRHN2+xZe5w+=pPkOqcqQdR4t7bYY_MgXwKbPD4A@mail.gmail.com>
 <55EC7191.8020107@googlemail.com>
 <CAGPstWtnvg=mE54JGaU8y0gTU8BwxkzMqnOFXW-VSVmtQtkJmQ@mail.gmail.com>
 <560039B6.2000204@zonque.org>
Reply-To: sypwex@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f170.google.com (mail-ig0-f170.google.com
 [209.85.213.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 714CC26167D
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 22:10:13 +0200 (CEST)
Received: by igcrk20 with SMTP id rk20so68502546igc.1
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 13:10:12 -0700 (PDT)
In-Reply-To: <560039B6.2000204@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org, Clemens Ladisch <cladisch@googlemail.com>, daniel@caiaq.de, sypwex@gmail.com
List-Id: alsa-devel@alsa-project.org

Thanks for the reply!

>What does 'lsusb -v' show when you plug in the device?
the exactly `lsusb -v` out is here http://pastebin.com/raw.php?i=trmwPjGF

information only about 17cc:1110 (`sudo lsusb -D /dev/bus/usb/001/010`):

Device: ID 17cc:1110 Native Instruments
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x17cc Native Instruments
  idProduct          0x1110
  bcdDevice            0.37
  iManufacturer           1 Native Instruments
  iProduct                2 Maschine Mikro
  iSerial                 6 677AC139
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           57
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              450mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              4 Maschine Mikro HID
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     367
         Report Descriptors:
           ** UNAVAILABLE **
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
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       254 Application Specific Interface
      bInterfaceSubClass      1 Device Firmware Update
      bInterfaceProtocol      1
      iInterface              5 Maschine Mikro DFU
      Device Firmware Upgrade Interface Descriptor:
        bLength                             7
        bDescriptorType                    33
        bmAttributes                        7
          Will Not Detach
          Manifestation Tolerant
          Upload Supported
          Download Supported
        wDetachTimeout                    250 milliseconds
        wTransferSize                      64 bytes
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0000
  (Bus Powered)


-- 
Regards!
