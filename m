From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000745]: Crash when unplugging USB Headset
Date: Mon, 27 Dec 2004 12:55:42 +0100
Message-ID: <b6a8185b16601568bc304cdc4e03f359@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9FBF2110
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2004 12:55:42 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=745> 
======================================================================
Reported By:                greve
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   745
Category:                   USB - usb-audio
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian GNU/Linux
Kernel Version:             2.6.10-rc3 (also happened with 2.6.9)
======================================================================
Date Submitted:             12-24-2004 12:56 CET
Last Modified:              12-27-2004 12:55 CET
======================================================================
Summary:                    Crash when unplugging USB Headset
Description: 
Discovered this when trying to get a Logitech USB Headset to work.

All this with 2.6.9:

When first plugging it in, snd-usb-audio was missing, so recompiled
kernel, loaded module without rebooting (yes. i know. i was lazy.) and the
Headset worked perfectly fine.

When booting the machine the next time, headset was recognized propely,
usb-audio driver loaded, /proc/asound showed Headset soundcard, mixer
worked fine, no warning messages, but: NO SOUND. Everything CLAIMED to be
working fine, but the headset remained silent.

Tried around a couple of times with different settings of compiling things
into the kernel/as module and eventually gave kernel 2.6.10-rc3 a try.

While trying around with 2.6.9 and 2.6.10-rc3 both, at some time the
keyboard would stop to work while fiddling with the USB Headset
(pluggin/unplugging), while the mouse (also USB) was still working fine.
The machine would hang during reboot and had to be reset by button.

Below is the syslog output from the kernel for the latest crash.

I know this may not be the most helpful error report ever written -- but I
don't quite know where to look. Help appreciated.

If you need more info, please let me know.
======================================================================

----------------------------------------------------------------------
 greve - 12-26-04 20:39 
----------------------------------------------------------------------
Did some more investigation -- same behaviour on two different machines,
both running Debian GNU/Linux Sarge with kernel 2.6.10. Headset seems to
be recognized and everything seems to be working fine when doing playback
through usb-audio PCM device:

cat /proc/asound/card1/stream0:

 Logitech Logitech USB Headset at usb-0000:00:1d.0-2, full speed : USB
Audio

 Playback:
  Status: Running
    Interface = 1
    Altset = 1
    URBs = 5 [ 4 4 4 4 4 ]
    Packet Size = 192
    Momentary freq = 44100 Hz
  Interface 1
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 1 OUT (ADAPTIVE)
    Rates: 8000, 11025, 22050, 44100, 48000
  Interface 1
    Altset 2
    Format: S16_LE
    Channels: 1
    Endpoint: 1 OUT (ADAPTIVE)
    Rates: 8000, 11025, 22050, 44100, 48000

 Capture:
  Status: Stop
  Interface 2
    Altset 1
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (ADAPTIVE)
    Rates: 8000, 11025, 22050, 44100, 48000


cat /proc/asound/card1/pcm0p/sub0/hw_params:
 
 access: RW_INTERLEAVED
 format: S16_LE
 subformat: STD
 channels: 2
 rate: 44100 (44100/1)
 period_size: 1024
 buffer_size: 16384
 tick_time: 1000
 OSS format: S16_LE
 OSS channels: 2
 OSS rate: 44100
 OSS period bytes: 4096
 OSS periods: 16
 OSS period frames: 1024


However -- there is NO SOUND coming from the headset.

Oddly, when unplugging the Headset, the keyboard stops working and the
machine has to be rebooted. Could not reproduce this effect with a
debugging-enabled kernel -- everything as above, only that the keyboard
remains operational.

This is the output from syslog when plugging in Headset, trying to play
sound and unplugging the Headset:

Plugging in USB Headset:

 hub 4-0:1.0: state 5 ports 6 chg ffc0 evt 0002
 ehci_hcd 0000:00:1d.7: GetStatus port 1 status 001803 POWER sig=j  CSC
CONNECT
 hub 4-0:1.0: port 1, status 0501, change 0001, 480 Mb/s
 hub 4-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x501
 ehci_hcd 0000:00:1d.7: port 1 full speed --> companion
 ehci_hcd 0000:00:1d.7: GetStatus port 1 status 003801 POWER OWNER sig=j 
CONNECT
 uhci_hcd 0000:00:1d.0: wakeup_hc
 hub 1-0:1.0: state 5 ports 2 chg fffc evt 0002
 uhci_hcd 0000:00:1d.0: port 1 portsc 0093,00
 hub 1-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
 hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
 usb 1-1: new full speed USB device using uhci_hcd and address 2
 usb 1-1: ep0 maxpacket = 8
 usb 1-1: skipped 11 descriptors after interface
 usb 1-1: skipped 2 descriptors after interface
 usb 1-1: skipped 1 descriptor after endpoint
 usb 1-1: skipped 2 descriptors after interface
 usb 1-1: skipped 1 descriptor after endpoint
 usb 1-1: skipped 2 descriptors after interface
 usb 1-1: skipped 1 descriptor after endpoint
 usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=0
 usb 1-1: default language 0x0409
 usb 1-1: Product: Logitech USB Headset
 usb 1-1: Manufacturer: Logitech
 usb 1-1: hotplug
 usb 1-1: adding 1-1:1.0 (config
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1, interface 0)
 usb 1-1:1.0: hotplug
 snd-usb-audio 1-1:1.0: usb_probe_interface
 snd-usb-audio 1-1:1.0: usb_probe_interface - got id
 2:1:1: add audio endpoint 0x1
 current rate 8000 is different from the runtime rate 48000
 2:1:2: add audio endpoint 0x1
 current rate 8000 is different from the runtime rate 48000
 2:2:1: add audio endpoint 0x84
 [6] FU [Mic Playback Switch] ch = 1, val = 0/1/1
 cannot set ctl value: req = 0x4, wValue = 0x200, wIndex = 0x600, type =
4, data = 0x8/0x0
 [6] FU [Mic Playback Volume] ch = 1, val = -10496/-3072/16
 [1] FU [Speaker Playback Switch] ch = 1, val = 0/1/1
 cannot set ctl value: req = 0x4, wValue = 0x201, wIndex = 0x100, type =
4, data = 0x80/0x0
 [1] FU [Speaker Playback Volume] ch = 2, val = -10496/768/256
 [2] FU [Mic Capture Switch] ch = 1, val = 0/1/1
 cannot set ctl value: req = 0x4, wValue = 0x200, wIndex = 0x200, type =
4, data = 0x80/0x0
 [2] FU [Mic Capture Volume] ch = 1, val = 4096/7424/256
 usb 1-1: adding 1-1:1.1 (config
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1, interface 1)
 usb 1-1:1.1: hotplug
 usb 1-1: adding 1-1:1.2 (config
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1, interface 2)
 usb 1-1:1.2: hotplug
 hub 1-0:1.0: state 5 ports 2 chg fffc evt 0002


Trying to play audio via USB Headset PCM Device:

 setting usb interface 1:1
 current rate 48000 is different from the runtime rate 8000
 current rate 48000 is different from the runtime rate 44100
      osl-0957 [4450] os_wait_semaphore     : Failed to acquire
semaphore[c1460cc0|1|0], AE_TIME
      osl-0957 [4446] os_wait_semaphore     : Failed to acquire
semaphore[c1460cc0|1|0], AE_TIME


Unplugging USB Headset

 hub 4-0:1.0: state 5 ports 6 chg ffc0 evt 0002
 ehci_hcd 0000:00:1d.7: GetStatus port 1 status 001002 POWER sig=se0  CSC
 hub 4-0:1.0: port 1, status 0100, change 0001, 12 Mb/s
 hub 4-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
 hub 1-0:1.0: state 5 ports 2 chg fffc evt 0002
 uhci_hcd 0000:00:1d.0: port 1 portsc 008a,00
 hub 1-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
 usb 1-1: USB disconnect, address 2
 usb 1-1: usb_disable_device nuking all URBs
 usb 1-1: unregistering interface 1-1:1.0
 usb 1-1:1.0: hotplug
 usb 1-1: unregistering interface 1-1:1.1
 usb 1-1:1.1: hotplug
 usb 1-1: unregistering interface 1-1:1.2
 usb 1-1:1.2: hotplug
 usb 1-1: unregistering device
 usb 1-1: hotplug
 hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
 uhci_hcd 0000:00:1d.0: suspend_hc


And this is the output of lsusb -vvv for the Headset while plugged in:

Bus 001 Device 003: ID 046d:0a01 Logitech, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x046d Logitech, Inc.
  idProduct          0x0a01 
  bcdDevice           10.12
  iManufacturer           1 Logitech
  iProduct                2 Logitech USB Headset
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          318
    bNumInterfaces          3
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength          117
        bInCollection           2
        baInterfaceNr( 0)       1
        baInterfaceNr( 1)       2
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID            13
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bNrChannels             1
        wChannelConfig     0x0001
          Left Front (L)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 6
        bSourceID              13
        bControlSize            1
        bmaControls( 0)      0x03
          Mute
          Volume
        bmaControls( 1)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID            12
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      4 (MIXER_UNIT)
        bUnitID                 9
        bNrInPins               2
        baSourceID( 0)         12
        baSourceID( 1)          6
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        bmControls         0x00
        iMixer                  0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 1
        bSourceID               9
        bControlSize            1
        bmaControls( 0)      0x01
          Mute
        bmaControls( 1)      0x02
          Volume
        bmaControls( 2)      0x02
          Volume
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            14
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID               1
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID            11
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bNrChannels             1
        wChannelConfig     0x0001
          Left Front (L)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 2
        bSourceID              11
        bControlSize            1
        bmaControls( 0)      0x03
          Mute
          Volume
        bmaControls( 1)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      4 (MIXER_UNIT)
        bUnitID                 7
        bNrInPins               1
        baSourceID( 0)          2
        bNrChannels             1
        wChannelConfig     0x0001
          Left Front (L)
        iChannelNames           0 
        bmControls         0x00
        iMixer                  0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            10
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               7
        iTerminal               0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          12
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                23
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            5 Discrete
        tSamFreq[ 0]         8000
        tSamFreq[ 1]        11025
        tSamFreq[ 2]        22050
        tSamFreq[ 3]        44100
        tSamFreq[ 4]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x00c0  1x 192 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          12
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                23
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            5 Discrete
        tSamFreq[ 0]         8000
        tSamFreq[ 1]        11025
        tSamFreq[ 2]        22050
        tSamFreq[ 3]        44100
        tSamFreq[ 4]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x0060  1x 96 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          10
        bDelay                  0 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                23
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            5 Discrete
        tSamFreq[ 0]         8000
        tSamFreq[ 1]        11025
        tSamFreq[ 2]        22050
        tSamFreq[ 3]        44100
        tSamFreq[ 4]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x0060  1x 96 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay              1 Decoded PCM samples

Hope this helps.



----------------------------------------------------------------------
 greve - 12-27-04 12:55 
----------------------------------------------------------------------
Since I am not 100% sure whether this is a USB or ALSA code problem, or
maybe a combination/interaction of the two, also submitted it to the
Kernel bugtracker as bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3954, available at

http://bugzilla.kernel.org/show_bug.cgi?id=3954

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-24-04 12:56 greve          New Issue                                    
12-24-04 12:56 greve          Distribution              => Debian GNU/Linux
12-24-04 12:56 greve          Kernel Version            => 2.6.10-rc3 (also
happened with 2.6.9)
12-24-04 13:03 greve          Note Added: 0002930                          
12-26-04 18:13 greve          Note Added: 0002941                          
12-26-04 18:14 greve          Note Deleted: 0002930                        
12-26-04 20:39 greve          Note Edited: 0002941                         
12-27-04 12:55 greve          Note Added: 0002959                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
