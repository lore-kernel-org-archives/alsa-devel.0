From: Julius von kohout <juliusvonkohout@gmail.com>
Subject: C-Media 6632A unsupported (asus xonar u7)
Date: Thu, 27 Jun 2013 13:52:54 +0200
Message-ID: <CANOmF+myQN0dyJoogCju4w+ScvrcXBNq1EGk99keM048SE0HoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f180.google.com (mail-vc0-f180.google.com
 [209.85.220.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F7032655B9
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2013 13:52:55 +0200 (CEST)
Received: by mail-vc0-f180.google.com with SMTP id gf11so222933vcb.25
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2013 04:52:54 -0700 (PDT)
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

Hi ive got a new usb soundcard with the brand new C-Media 6632A chip and
want to help with debugging.

xonar u7 in usb 2.0 mode C-Media 6632A Ubuntu 13.04

julius@R850:~$ alsactl init 1
Found hardware: "USB-Audio" "USB Mixer" "USB1043:857c" "" ""
Hardware is initialized using a generic method

julius@R850:~$ alsamixer -c 1
cannot load mixer controls: Broken pipe

alsa hardware volume (numid=2,iface=MIXER,name='Speaker Playback Volume')
level on start is way to low and can only be adjusted via QasHctl.
The volume knob on soundcard works for pulseaudio volume.
spdif can only be used via direct alsa access without pulseaudio.

alsa-info script results http://pastebin.ca/2409660

julius@R850:~$ amixer -c 1 controls
numid=7,iface=MIXER,name='PCM Capture Source'
numid=5,iface=MIXER,name='PCM Capture Switch'
numid=6,iface=MIXER,name='PCM Capture Switch',index=1
numid=4,iface=MIXER,name='IEC958 In Playback Switch'
numid=3,iface=MIXER,name='Input Gain Pad Control'
numid=1,iface=MIXER,name='Speaker Playback Switch'
numid=2,iface=MIXER,name='Speaker Playback Volume'


[ 8219.399637] usb 2-1.2.3: new high-speed USB device number 22 using
ehci-pci
[ 8219.513315] usb 2-1.2.3: New USB device found, idVendor=1043,
idProduct=857c
[ 8219.513327] usb 2-1.2.3: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[ 8219.513333] usb 2-1.2.3: Product: Xonar U7
[ 8219.513338] usb 2-1.2.3: Manufacturer: ASUS
[ 8219.609328] input: ASUS Xonar U7 as
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2.3/2-1.2.3:1.4/input/input29
[ 8219.609743] hid-generic 0003:1043:857C.0016: input,hidraw4: USB HID
v1.00 Device [ASUS Xonar U7] on usb-0000:00:1d.0-1.2.3/input4
[ 8219.676164] cannot get ctl value: req = 0x81, wValue = 0x0, wIndex =
0x1400, type = 3
[ 8219.697280] cannot get ctl value: req = 0x81, wValue = 0x0, wIndex =
0x1400, type = 3
[ 8219.718770] cannot get ctl value: req = 0x81, wValue = 0x0, wIndex =
0x1400, type = 3
[ 8219.738130] cannot get ctl value: req = 0x81, wValue = 0x0, wIndex =
0x1400, type = 3
[ 8219.757999] cannot get ctl value: req = 0x81, wValue = 0x0, wIndex =
0x1400, type = 3
[ 8219.779861] cannot get ctl value: req = 0x81, wValue = 0x0, wIndex =
0x1400, type = 3
[ 8219.800222] cannot get ctl value: req = 0x81, wValue = 0x0, wIndex =
0x1400, type = 3
[ 8219.823964] cannot get ctl value: req = 0x81, wValue = 0x0, wIndex =
0x1400, type = 3
[ 8520.766440] cannot get ctl value: req = 0x81, wValue = 0x0, wIndex =
0x1400, type = 3
[ 8539.332352] cannot get ctl value: req = 0x81, wValue = 0x0, wIndex =
0x1400, type = 3


julius@R850:~$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version k3.8.0-25-generic.

julius@R850:~$ cat /proc/asound/cards
 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xc4820000 irq 50
 1 [U7             ]: USB-Audio - Xonar U7
                      ASUS Xonar U7 at usb-0000:00:1d.0-1.2.3, high speed

julius@R850:~$ lsmod | grep snd
snd_hda_codec_hdmi     36913  1
snd_hda_codec_realtek    78399  1
snd_usb_audio         140685  0
snd_usbmidi_lib        24938  1 snd_usb_audio
snd_hda_intel          39619  3
snd_hda_codec         136453  3
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_intel
snd_hwdep              13602  2 snd_usb_audio,snd_hda_codec
snd_pcm                97451  4
snd_usb_audio,snd_hda_codec_hdmi,snd_hda_codec,snd_hda_intel
snd_page_alloc         18710  2 snd_pcm,snd_hda_intel
snd_seq_midi           13324  0
snd_seq_midi_event     14899  1 snd_seq_midi
snd_rawmidi            30180  2 snd_usbmidi_lib,snd_seq_midi
snd_seq                61554  2 snd_seq_midi_event,snd_seq_midi
snd_seq_device         14497  3 snd_seq,snd_rawmidi,snd_seq_midi
snd_timer              29425  2 snd_pcm,snd_seq
snd                    68876  18
snd_hda_codec_realtek,snd_usb_audio,snd_hwdep,snd_timer,snd_hda_codec_hdmi,snd_pcm,snd_seq,snd_rawmidi,snd_usbmidi_lib,snd_hda_codec,snd_hda_intel,snd_seq_device
soundcore              12680  1 snd

julius@R850:~$ lsusb
Bus 001 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
Bus 002 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 002 Device 021: ID 18d1:4ee1 Google Inc.
Bus 002 Device 015: ID 0424:2514 Standard Microsystems Corp. USB 2.0 Hub
Bus 002 Device 016: ID 046d:c245 Logitech, Inc.
Bus 002 Device 017: ID 05a4:9881 Ortek Technology, Inc.
Bus 002 Device 022: ID 1043:857c iCreate Technologies Corp.
Bus 002 Device 020: ID 046a:0180 Cherry GmbH

julius@R850:~$ dpkg -l | grep alsa
ii  alsa-base                                 1.0.25+dfsg-0ubuntu4
          all          ALSA driver configuration files
ii  alsa-utils                                1.0.25-4ubuntu2
         amd64        Utilities for configuring and using ALSA
ii  bluez-alsa:amd64                          4.101-0ubuntu8b1
          amd64        Bluetooth ALSA support
ii  gstreamer0.10-alsa:amd64                  0.10.36-1.1ubuntu1
          amd64        GStreamer plugin for ALSA
ii  gstreamer1.0-alsa:amd64                   1.0.6-1
         amd64        GStreamer plugin for ALSA
