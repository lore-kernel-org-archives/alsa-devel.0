From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: M-Audio transit: illegal sync type and noise on
	startup?
Date: Wed, 12 Aug 2015 23:07:51 -0500
Message-ID: <55CC1817.1020500@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D0BA260A5B
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 06:07:57 +0200 (CEST)
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

While playing with my M-Audio Transit USB device (0763:2006) I saw a synchronization type that doesn't exist in the USB audio class. I get audio out but often the start is garbled with white noise and cracks. Wondering what's going on.

more /proc/asound/card1/stream0 
M-Audio Transit USB at usb-0000:00:14.0-2, full speed : USB Audio

Playback:
  Status: Stop
  Interface 1
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 48001 - 96000 (continuous)u
  Interface 1
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (NONE)  <<<<<<< illegal
    Rates: 8000 - 48000 (continuous)
  Interface 1
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 3 OUT (ASYNC)
    Rates: 8000 - 48000 (continuous)

The only definitions in the spec are Asynchronous, Adaptive or Synchronous...

lsusb tells me that there seems to be a synch endpoint for this setting:
     
  Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0126  1x 294 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress         131
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         1 Milliseconds
          wLockDelay            100 Milliseconds
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN 
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0003  1x 3 bytes
        bInterval               1
        bRefresh                2
        bSynchAddress           0
    


I couldn't figure out what the code does in this case. I didn't find any sync URBs being retired so wondering if this is considered as a synchronous or asynchronous endpoint based on the additional sync endpoint? Any idea on how to debug further? It looks like there could be a second error in the descriptors: if this is a synchronous endpoint then the sync endpoint is meaningless, and if it is asynchronous then the information on locking time is irrelevant...

Regarding the noise on startup, should a delay be inserted after the mode is set? the spec recommends that the host sends silence periods for adaptive and synchronous modes. I see a set of mdelays being added in the quirks, should a new one be added?


Thanks for any pointers,
-Pierre
