From: nick83ola <nick83ola@gmail.com>
Subject: Edirol UA-20 in advanced mode
Date: Thu, 29 Jan 2009 19:08:34 +0100
Message-ID: <ed82be370901291008h57b88039s950f64e5d228150b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 09540243A6
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 19:08:35 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 9so23910ywk.2
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 10:08:34 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-audio-user@lists.linuxaudio.org
List-Id: alsa-devel@alsa-project.org

Hello to all

I have an old edirol UA-20 that not work with advanced driver, or perhaps I
see it, i can send midi in and out from it but audio don't work.
I have ubuntu intrepid and Jaunty (all the same problem!!!)
The sound card works perfectly with advanced driver off, but  in this mode
is useless (no midi/no low latency audio/no 24 bit)

here's the output of some command

damnick@damnick-nb:~$ lsusb
Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 003: ID 0582:0025 Roland Corp. EDIROL UA-20
Bus 001 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
damnick@damnick-nb:~$ sudo lsusb -v -d 0582:0025
[sudo] password for damnick:

Bus 001 Device 003: ID 0582:0025 Roland Corp. EDIROL UA-20
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         0
  bDeviceProtocol       255
  bMaxPacketSize0         8
  idVendor           0x0582 Roland Corp.
  idProduct          0x0025 EDIROL UA-20
  bcdDevice            1.01
  iManufacturer           1 Roland
  iProduct                2 EDIROL UA-20
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          322
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              170mA
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
      ** UNRECOGNIZED:  0a 24 01 00 01 34 00 02 01 02
      ** UNRECOGNIZED:  0c 24 02 01 01 01 00 02 03 00 00 00
      ** UNRECOGNIZED:  09 24 03 03 04 03 00 01 00
      ** UNRECOGNIZED:  0c 24 02 04 01 06 00 02 03 00 00 00
      ** UNRECOGNIZED:  09 24 03 07 01 01 00 04 00
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
      ** UNRECOGNIZED:  07 24 01 01 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x0120  1x 288 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
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
      ** UNRECOGNIZED:  07 24 01 07 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0120  1x 288 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      3
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 00 01 25 00
      ** UNRECOGNIZED:  06 24 02 01 10 00
      ** UNRECOGNIZED:  06 24 02 02 20 00
      ** UNRECOGNIZED:  09 24 03 01 30 01 20 01 00
      ** UNRECOGNIZED:  09 24 03 02 40 01 10 01 00
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               0
        bRefresh                0
        bSynchAddress           0
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               0
        bRefresh                0
        bSynchAddress           0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      3
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 00 01 25 00
      ** UNRECOGNIZED:  06 24 02 01 10 00
      ** UNRECOGNIZED:  06 24 02 02 20 00
      ** UNRECOGNIZED:  09 24 03 01 30 01 20 01 00
      ** UNRECOGNIZED:  09 24 03 02 40 01 10 01 00
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               0
        bRefresh                0
        bSynchAddress           0
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
Device Status:     0x0001
  Self Powered
damnick@damnick-nb:~$ aplay -l
**** Lista di PLAYBACK dispositivi hardware ****
scheda 0: ICH6 [Intel ICH6], dispositivo 0: Intel ICH [Intel ICH6]
  Sottoperiferiche: 1/1
  Sottoperiferica #0: subdevice #0
scheda 0: ICH6 [Intel ICH6], dispositivo 4: Intel ICH - IEC958 [Intel ICH6 -
IEC958]
  Sottoperiferiche: 1/1
  Sottoperiferica #0: subdevice #0
scheda 1: UA20 [UA-20], dispositivo 0: USB Audio [USB Audio]
  Sottoperiferiche: 1/1
  Sottoperiferica #0: subdevice #0

damnick@damnick-nb:~$ dmesg|tail
[  123.661964] [drm] Num pipes: 1
[  151.700439] ieee80211_crypt: registered algorithm 'TKIP'
[  155.428103] CPU0 attaching NULL sched-domain.
[  155.428227] CPU0 attaching NULL sched-domain.
[  194.768219] ACPI: EC: non-query interrupt received, switching to
interrupt mode
[  194.771985] ACPI: EC: GPE storm detected, transactions will use polling
mode
[ 1247.360077] usb 1-1: USB disconnect, address 2
[ 1257.952020] usb 1-1: new full speed USB device using uhci_hcd and address
3
[ 1258.228810] usb 1-1: configuration #1 chosen from 1 choice
[ 1287.914930] cannot submit datapipe for urb 0, error -90: internal error
damnick@damnick-nb:~$ aplay -D plughw:UA20 /usr/share/sounds/question.wav
Riproduzione in corso WAVE '/usr/share/sounds/question.wav' : Signed 16 bit
Little Endian, Frequenza 44100 Hz, Mono
^C
Interrotto dal segnale Interrupt...

and no sound.... jack hangs when I try to open the device....

I have seen an open discussion here

http://lists.linuxaudio.org/pipermail/linux-audio-user/2005-November/028696.html

I have the same output with lsusb... but the thread ends here and no
fixes!!!

Anyone can help me????

Please???
Nicola Lunghi
