From: Leo Combes <combesl@gmail.com>
Subject: MAYA44 USB audio device no inputs control (again)
Date: Wed, 26 Feb 2014 12:12:13 -0300
Message-ID: <CAGB4PGYYc0ujgZnSMeY8oRD7QzxaifAcBGTiZZ1=iCrhaD1r8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f176.google.com (mail-vc0-f176.google.com
 [209.85.220.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 62BC726572B
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:12:14 +0100 (CET)
Received: by mail-vc0-f176.google.com with SMTP id la4so1050849vcb.35
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 07:12:13 -0800 (PST)
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
I have bought a Maya 44 USB, with 4 output and 4 input channels.

http://www.esi-audio.com/products/maya44usb/

The soundcard works fine in playback, but in recording has some
problems, specificly there is no way to control the volume of the
recording on inputs.
It seems to be default setted to 50%.

Alsamixer, in playback section shows 3 controls, "speaker", "line" and "line1".
But, if I choose capture, it shows "This sound device does not have
any capture controls".
It seems like there are controls, and they work fine, running on Windows.

I searched the problem on Google and I found a lot of users with the
same problem.

The most interesting thread that I found, is one on this mailist,
sadly after some messages, user didn't catch up with the conversation:

http://mailman.alsa-project.org/pipermail/alsa-devel/2011-November/046242.html

I have a hardware mixer connected to 2 inputs of the Maya. If I try to
recording with Audacity or any other software, the volume of recording
is never greater than -6dB.
If I try increase the volume in the mixer to get louder recording, the
only thing I get is a completely distorted sound not louder than -6dB,
what tells me that Maya inputs have a presetted volume at 50%.
Besides, if I increase the volume in the mixer, Audicity's vumeter
confirm that it never go further than -6dB.

Following the thread that the user left unfinished, here goes the
information that I get with my system, to see if could find a
solution.


leo-ThinkPad leo # aplay -L
null
    Discard all samples (playback) or generate zero samples (capture)
pulse
    PulseAudio Sound Server
sysdefault:CARD=MID
    HDA Intel MID, CX20585 Analog
    Default Audio Device
front:CARD=MID,DEV=0
    HDA Intel MID, CX20585 Analog
    Front speakers
surround40:CARD=MID,DEV=0
    HDA Intel MID, CX20585 Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=MID,DEV=0
    HDA Intel MID, CX20585 Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=MID,DEV=0
    HDA Intel MID, CX20585 Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=MID,DEV=0
    HDA Intel MID, CX20585 Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=MID,DEV=0
    HDA Intel MID, CX20585 Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
dmix:CARD=MID,DEV=0
    HDA Intel MID, CX20585 Analog
    Direct sample mixing device
dsnoop:CARD=MID,DEV=0
    HDA Intel MID, CX20585 Analog
    Direct sample snooping device
hw:CARD=MID,DEV=0
    HDA Intel MID, CX20585 Analog
    Direct hardware device without any conversions
plughw:CARD=MID,DEV=0
    HDA Intel MID, CX20585 Analog
    Hardware device with all software conversions
hdmi:CARD=NVidia,DEV=0
    HDA NVidia, HDMI 0
    HDMI Audio Output
hdmi:CARD=NVidia,DEV=1
    HDA NVidia, HDMI 0
    HDMI Audio Output
hdmi:CARD=NVidia,DEV=2
    HDA NVidia, HDMI 0
    HDMI Audio Output
hdmi:CARD=NVidia,DEV=3
    HDA NVidia, HDMI 0
    HDMI Audio Output
dmix:CARD=NVidia,DEV=3
    HDA NVidia, HDMI 0
    Direct sample mixing device
dmix:CARD=NVidia,DEV=7
    HDA NVidia, HDMI 0
    Direct sample mixing device
dmix:CARD=NVidia,DEV=8
    HDA NVidia, HDMI 0
    Direct sample mixing device
dmix:CARD=NVidia,DEV=9
    HDA NVidia, HDMI 0
    Direct sample mixing device
dsnoop:CARD=NVidia,DEV=3
    HDA NVidia, HDMI 0
    Direct sample snooping device
dsnoop:CARD=NVidia,DEV=7
    HDA NVidia, HDMI 0
    Direct sample snooping device
dsnoop:CARD=NVidia,DEV=8
    HDA NVidia, HDMI 0
    Direct sample snooping device
dsnoop:CARD=NVidia,DEV=9
    HDA NVidia, HDMI 0
    Direct sample snooping device
hw:CARD=NVidia,DEV=3
    HDA NVidia, HDMI 0
    Direct hardware device without any conversions
hw:CARD=NVidia,DEV=7
    HDA NVidia, HDMI 0
    Direct hardware device without any conversions
hw:CARD=NVidia,DEV=8
    HDA NVidia, HDMI 0
    Direct hardware device without any conversions
hw:CARD=NVidia,DEV=9
    HDA NVidia, HDMI 0
    Direct hardware device without any conversions
plughw:CARD=NVidia,DEV=3
    HDA NVidia, HDMI 0
    Hardware device with all software conversions
plughw:CARD=NVidia,DEV=7
    HDA NVidia, HDMI 0
    Hardware device with all software conversions
plughw:CARD=NVidia,DEV=8
    HDA NVidia, HDMI 0
    Hardware device with all software conversions
plughw:CARD=NVidia,DEV=9
    HDA NVidia, HDMI 0
    Hardware device with all software conversions
sysdefault:CARD=USB
    MAYA44 USB+, USB Audio
    Default Audio Device
front:CARD=USB,DEV=0
    MAYA44 USB+, USB Audio
    Front speakers
surround40:CARD=USB,DEV=0
    MAYA44 USB+, USB Audio
    4.0 Surround output to Front and Rear speakers
surround41:CARD=USB,DEV=0
    MAYA44 USB+, USB Audio
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=USB,DEV=0
    MAYA44 USB+, USB Audio
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=USB,DEV=0
    MAYA44 USB+, USB Audio
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=USB,DEV=0
    MAYA44 USB+, USB Audio
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=USB,DEV=0
    MAYA44 USB+, USB Audio
    IEC958 (S/PDIF) Digital Audio Output
dmix:CARD=USB,DEV=0
    MAYA44 USB+, USB Audio
    Direct sample mixing device
dsnoop:CARD=USB,DEV=0
    MAYA44 USB+, USB Audio
    Direct sample snooping device
hw:CARD=USB,DEV=0
    MAYA44 USB+, USB Audio
    Direct hardware device without any conversions
plughw:CARD=USB,DEV=0
    MAYA44 USB+, USB Audio
    Hardware device with all software conversions


leo-ThinkPad leo # lsmod | grep snd
snd_hda_codec_hdmi     41684  4
snd_usb_audio         155972  3
snd_hda_codec_conexant    57181  1
snd_usbmidi_lib        29576  1 snd_usb_audio
snd_hda_intel          57183  2
snd_hda_codec         194881  3
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_intel
snd_hwdep              13613  2 snd_usb_audio,snd_hda_codec
snd_pcm               107140  6
snd_usb_audio,snd_hda_codec_hdmi,snd_hda_codec,snd_hda_intel
snd_page_alloc         18798  2 snd_pcm,snd_hda_intel
snd_seq_midi           13324  0
snd_seq_midi_event     14899  1 snd_seq_midi
snd_rawmidi            30465  2 snd_usbmidi_lib,snd_seq_midi
snd_seq                66061  2 snd_seq_midi_event,snd_seq_midi
snd_seq_device         14497  3 snd_seq,snd_rawmidi,snd_seq_midi
snd_timer              30038  2 snd_pcm,snd_seq
snd                    73802  22
snd_usb_audio,snd_hwdep,snd_timer,snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_pcm,snd_seq,snd_rawmidi,snd_usbmidi_lib,snd_hda_codec,snd_hda_intel,thinkpad_acpi,snd_seq_device,snd_seq_midi
soundcore              12680  1 snd


leo-ThinkPad leo # amixer contents
numid=2,iface=MIXER,name='Line Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=4,iface=MIXER,name='Line Playback Switch',index=1
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=3,iface=MIXER,name='Line Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=255,step=0
  : values=0,0
  | dBminmax-min=0.00dB,max=0.99dB
numid=5,iface=MIXER,name='Line Playback Volume',index=1
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=255,step=0
  : values=0,0
  | dBminmax-min=0.00dB,max=0.99dB
numid=6,iface=MIXER,name='Speaker Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=7,iface=MIXER,name='Speaker Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=255,step=0
  : values=255,255
  | dBminmax-min=0.00dB,max=0.99dB
numid=1,iface=PCM,name='Playback Channel Map'
  ; type=INTEGER,access=r----R--,values=4,min=0,max=36,step=0
  : values=3,4,0,0
  |     | TLV size error (257, 8, 0)!


leo-ThinkPad leo # amixer -c2
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.99dB] [on]
  Front Right: Playback 255 [100%] [0.99dB] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 0 [0%] [0.00dB] [off]
  Front Right: Playback 0 [0%] [0.00dB] [off]
Simple mixer control 'Line',1
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 0 [0%] [0.00dB] [off]
  Front Right: Playback 0 [0%] [0.00dB] [off]


Thanks in advance!
