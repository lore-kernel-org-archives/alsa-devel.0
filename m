From: Mark Hills <mark@xwax.org>
Subject: usb: Endpoints sharing the same interface
Date: Sun, 3 Mar 2013 17:53:53 +0000 (GMT)
Message-ID: <alpine.LNX.2.01.1303021621060.8986@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DD8326173C
 for <alsa-devel@alsa-project.org>; Sun,  3 Mar 2013 18:53:54 +0100 (CET)
Received: from cpc5-hari13-2-0-cust67.20-2.cable.virginmedia.com
 ([82.45.173.68] helo=localhost)
 by wes.ijneb.com with esmtpa (Exim 4.77)
 (envelope-from <mark@pogo.org.uk>) id 1UCD6g-0002ku-1j
 for alsa-devel@alsa-project.org; Sun, 03 Mar 2013 17:53:54 +0000
Received: from mark (helo=localhost) by localhost with local-esmtp (Exim 4.69)
 (envelope-from <mark@xwax.org>) id 1UCD6f-00068O-Jx
 for alsa-devel@alsa-project.org; Sun, 03 Mar 2013 17:53:53 +0000
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
List-Id: alsa-devel@alsa-project.org

Novation Twitch [1] is a USB device with audio capture and playback 
endpoints on the same bInterfaceNumber.

This has thrown up some tricky cases in the USB audio driver, and I'd 
appreciate some advice.

I'll follow up with my patches so far as an RFC.

This device has endpoints for 2 channels capture (0x01), 4 channels 
playback (0x82), both on interface #0. Interface #1 is raw MIDI.

I seem to be finding code that assumes pcm to always use the first 
endpoint on an interface. eg. problems with maxpacksize (see patch in 
thread)

Now I'm in a position where playback _or_ capture works reliably. But to 
start capture stops playback, and vice-versa (or sometimes causes hangs)

It seems like snd_pcm_prepare() concludes that need_setup_ep is required, 
but I think this may be based on something going on in 
set_sample_rate_v1() also looking to the first endpoint -- 
usb_sndctrlpipe(dev,0).

Before I do any more work on this, are there any hints where to go with 
this?

If we can overcome thse limitations then the same would likely apply to 
Saffire 6 USB and other Focusrite devices [2], and maybe some of the other 
devices with quirks that only support playback.

Many thanks

[1] http://uk.novationmusic.com/digital-dj/twitch/
[2] http://focusritedevelopmentteam.wordpress.com/category/drivers/

-- 
Mark


---
Bus 005 Device 010: ID 1235:0018 Novation EMS 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x1235 Novation EMS
  idProduct          0x0018 
  bcdDevice            1.00
  iManufacturer           1 Focusrite A.E. Ltd
  iProduct                2 Twitch
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           64
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              498mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x024c  1x 588 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0126  1x 294 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval               1
Device Status:     0x0000
  (Bus Powered)
