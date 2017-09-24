From: Nathan Fraser <ndf@metarace.com.au>
Subject: Roland Boutique USB Implicit Feedback Weirdness
Date: Sun, 24 Sep 2017 05:07:57 +0000
Message-ID: <CAPq31ueehhUQPwaEBSRSM=ktcank5HHuSwHYOwQWz4rLH2B+nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f171.google.com (mail-ua0-f171.google.com
 [209.85.217.171])
 by alsa0.perex.cz (Postfix) with ESMTP id EA41C266991
 for <alsa-devel@alsa-project.org>; Sun, 24 Sep 2017 07:08:00 +0200 (CEST)
Received: by mail-ua0-f171.google.com with SMTP id 72so2688023uas.8
 for <alsa-devel@alsa-project.org>; Sat, 23 Sep 2017 22:08:00 -0700 (PDT)
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

Hi,

I've been trying to get some Roland Boutique devices to work with
ALSA, and have had some initial success, but I've hit a wall and was
wondering if anyone on the list might be able to help point me in the
right direction to get it done.

Some background: The Roland Boutique series is a collection of small
drum machines and synthesizers from Roland that include a compposite
USB interface which carries both PCM and MIDI. The PCM on most units
is 2 channels in and out, on some there are additional channels.

The devices present themselves to ALSA as many Roland devices seem to,
and all the interfaces seem to be correctly auto-detected with current
ALSA code.

For example, the JP-08 (0582:01b5):

$ amidi -l
Dir Device    Name
IO  hw:2,0,0  Boutiq MIDI 1

$ ./alsacap  -C 2
*** Scanning for playback devices on card 2 ***
Card 2, ID `Boutiq', name `Boutiq'
  Device 0, ID `USB Audio', name `USB Audio', 1 subdevices (1 available)
    2 channels, sampling rate 44100..44100 Hz
    Sample formats: S32_LE
      Subdevice 0, name `subdevice #0'

$ ./alsacap  -R -C 2
*** Scanning for recording devices on card 2 ***
Card 2, ID `Boutiq', name `Boutiq'
  Device 0, ID `USB Audio', name `USB Audio', 1 subdevices (1 available)
    2 channels, sampling rate 44100..44100 Hz
    Sample formats: S32_LE
      Subdevice 0, name `subdevice #0'

The MIDI works flawlessley, but the playback and capture interfaces do
not. When the device is connected, an error usually appears comething
like:

[   15.737868] usb 2-1: Manufacturer: Roland
[   15.737871] usb 2-1: SerialNumber: BQJP352DDA054653353337241943
[   15.765216] snd-usb-audio: probe of 2-1:1.0 failed with error -5
[   15.767884] usbcore: registered new interface driver snd-usb-audio
[   15.803631] usb 2-1: Unable to change format on ep #8e: already in use
[   15.803659] usb 2-1: Unable to change format on ep #8e: already in use
...

When playing from aplay or arecord, nothing happens and eventually the
program exits with an input/output error:

$ aplay -vv -D hw:CARD=Boutiq,DEV=0 -t raw -c 2 -r 44100 -f S32_LE /dev/urandom
Playing raw data '/dev/urandom' : Signed 32 bit Little Endian, Rate
44100 Hz, Stereo
Hardware PCM card 2 'Boutiq' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 32
  buffer_size  : 22050
  period_size  : 5513
  period_time  : 125011
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 5513
  period_event : 0
  start_threshold  : 22050
  stop_threshold   : 22050
  silence_threshold: 0
  silence_size : 0
  boundary     : 6206523236469964800
  appl_ptr     : 0
  hw_ptr       : 0
##################################################+| 99%aplay:
pcm_write:1939: write error: Input/output error


As far as I can tell, most of the Boutique models have the same
problem, and it seems to be related to the audio streaming implicit
feedback. I was able to get the JP-08 and SE-02 PCM to work by
interrupting the code that adds the feedback interface as follows:

--- linux-4.13.3/sound/usb/pcm.c    2017-09-20 16:28:17.000000000 +1000
+++ linux-4.13.3_uh/sound/usb/pcm.c    2017-09-24 04:54:17.950406081 +1000
@@ -367,6 +367,10 @@
         search_roland_implicit_fb(dev, altsd->bInterfaceNumber + 1,
                       altsd->bAlternateSetting,
                       &alts, &ep) >= 0) {
+        dev_err(&dev->dev,
+            "   > roland fb search found ep %x for %x\n",
+                             ep, subs->ep_num);
+        return 0;
         goto add_sync_ep;
     }

When this patch is applied and the unit connected, you can see the
search matching the correct interfaces for feedback, but they are not
added. Interestingly, the probe error -5 on 1-1:1.0 is no longer
present:

[   24.832193] usb 1-1: Manufacturer: Roland
[   24.832194] usb 1-1: SerialNumber: BQJP352DDA054653353337241943
[   24.846986] usbcore: registered new interface driver snd-usb-audio
[   24.869113] usb 1-1:    > roland fb search found ep 8e for d
[   24.882599] usb 1-1:    > roland fb search found ep 8e for d

Now when you playback aith aplay, it works:

$ aplay -vv -D hw:CARD=Boutiq,DEV=0 -t raw -c 2 -r 44100 -f S32_LE /dev/urandom
Playing raw data '/dev/urandom' : Signed 32 bit Little Endian, Rate
44100 Hz, Stereo
Hardware PCM card 2 'Boutiq' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 32
  buffer_size  : 22050
  period_size  : 5513
  period_time  : 125011
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 5513
  period_event : 0
  start_threshold  : 22050
  stop_threshold   : 22050
  silence_threshold: 0
  silence_size : 0
  boundary     : 6206523236469964800
  appl_ptr     : 0
  hw_ptr       : 0
##################################################+| 99%^C
Aborted by signal Interrupt...

Capture also works, but only if you have a playback in process. If you
try to use arecord on its own, you get input/output error as before.
However, if you start the playback, and then capture, it works fine:

$ aplay -D hw:CARD=Boutiq,DEV=0 -t raw -c 2 -r 44100 -f S32_LE /dev/urandom &
Playing raw data '/dev/urandom' : Signed 32 bit Little Endian, Rate
44100 Hz, Stereo
$ arecord -vv -D hw:CARD=Boutiq,DEV=0 -c 2 -r 44100 -f S32_LE test.wav
Recording WAVE 'test.wav' : Signed 32 bit Little Endian, Rate 44100 Hz, Stereo
Hardware PCM card 2 'Boutiq' device 0 subdevice 0
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 32
  buffer_size  : 22050
  period_size  : 5513
  period_time  : 125011
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 5513
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 22050
  silence_threshold: 0
  silence_size : 0
  boundary     : 6206523236469964800
  appl_ptr     : 0
  hw_ptr       : 0
###########+                                       | 21%^C
Aborted by signal Interrupt...


So it seems like even though the feedback system should be working for
these units, some part of the setup process is not working quite as
Roland expects, and as a result they just seem to hang. Skipping the
feedback search for these units doesn't seem like the correct fix,
especially when the feedback mechanism seems to be working. I just
don't know where to look. If anyone could shed some light on what's
going on, or point me toward a possible solution, that would be
fantastic.

For reference, the USB info for the JP-08 is as follows (the SE-02 has
an identical interface layout):

$ lsusb -v -d 0582:01b5

Bus 001 Device 003: ID 0582:01b5 Roland Corp.
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         0
  bDeviceProtocol       255
  bMaxPacketSize0        64
  idVendor           0x0582 Roland Corp.
  idProduct          0x01b5
  bcdDevice            1.00
  iManufacturer           1
  iProduct                2
  iSerial                 3
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          258
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol      0
      iInterface              0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      2
      iInterface              0
      ** UNRECOGNIZED:  06 24 f1 01 00 00
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      2
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 01 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 04 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x0d  EP 13 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0038  1x 56 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      2
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 01 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 04 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x0d  EP 13 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0038  1x 56 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      1
      iInterface              0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      1
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 07 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 04 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x8e  EP 14 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x0038  1x 56 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      1
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 07 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 04 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x8e  EP 14 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x0038  1x 56 bytes
        bInterval               1
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
      ** UNRECOGNIZED:  06 24 f1 02 01 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
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
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               4
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               4


Thanks,

Nathan Fraser
--
