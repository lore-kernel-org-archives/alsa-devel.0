From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Tascam US-224 support: MIDI OK, Audio KO?
Date: Mon, 29 Mar 2004 12:34:25 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <44618.195.245.190.94.1080560065.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
References: 
In-Reply-To: 
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Please note that this is my first time on this list, and this has been
also posted on alsa-user. It's a rather long post, so sorry for the
inconvenience.

I am now just entering the Tascam USx2y arena on Linux and was hoping to
get some help before making any further... mistakes? :) It was just a
couple of days ago that I've got my hands on a US-224 and ran to test it
on my tuxie boxes. I must tell that I'm already committed to Linux audio,
and willing to get the most out of this piece of hardware under it.

On my early tests, which were all under a 2.6.4-ck1 kernel, with stock
ALSA 1.0.3, I could check that the firmware loads and the USB light gets
lit alright as expected. Then I could check on /proc/asound/cards and with
aconnect that the ALSA sequencer interfaces are roughly there. OK.

My first question goes whether us428control's not recognizing any USx2y
hardware dependant stuff (hwdep) either on hw:0 or hw:1. I'm almost sure
that it should be on hw:1 as the US-224 is configured as my second
soundcard under the ALSA configuration (i.e. alias snd-usb-usx2y
snd-card-1). But us428control does not find anything, at least after the
firmware gets loaded.

Strange enough, to me at least, us428control seems to work between the fw
and fpga loading steps. Using lsusb, I've noticed that the USB ids do
change from 1604:8004 to 1604:8005 while plugging in. Guess that's normal,
and it marks the momemt when fw is loaded and fpga is about to.

The second one is about the LEDs on the control surface: besides the USB
light, isn't that supposed to light up anything else? Everything else is
dead dark. Touching the knobs, pushing the buttons or whatever doesn't
make any visible difference. Is that supposed to be normal?

OK. I've tested on two different systems, a Compaq laptop w/Mandrake 10.0
(P4 2.533GHz, OHCI) and on a custom desktop w/SUSE 9.0 (P4 3.333GHz
SMP/HT, UHCI). On both, the firmware seems to get loaded and only visible
thing to note is that the USB light gets lit.

The only thing that i could get to work is the MIDI interface. AFAICT all
faders, buttons and the jog wheel do send MIDI control events, and I could
intercept those on the ALSA sequencer interface. MIDI seems pretty
functional then. I could also test the external raw MIDI interface, by
sending out some notes and it seems to work too.

It's the PCM audio part that gets me worried. ALSA reports both capture
and playback PCM interfaces. But on all my tests I could only ear silence.
Not a sound. Dead silence only. Although it all seems to be OK, at least
as reported by ALSA.

Quite traditionally this symptom is due to initially default muted mixer
channels, but running `alsamixer -c1` reports that there's no mixer elems.
So how can I unmute this beast?

By now, I had already tested on Windows and everything worked and sounded
almost perfectly while on Cubase. So hardware fault is not an issue ;)

I've already tryied the newest firmware (v3.24) as suggested on
"http://www.langerland.de/us122/development.html", but things didn't get
any better. Just an worrifying silent output.

Below you may find all the relevant reports I could gather about my latest
experiments, while on my SUSE 9.0 box, P4 3.333GHz, 1GB DDR400, ASUS
P4P800 Dlx Mobo, running kernel 2.6.4-ck1 and ALSA 1.0.3. BTW, the onboard
sound works flawlessly on snd-intel8x0.

--- `/var/log/messages` (output while the US-224 is being plugged in) Mar
28 23:33:15 gamma-suse1 kernel: usb 2-1: new full speed USB device using
address 2
Mar 28 23:33:18 gamma-suse1 /etc/hotplug/usb.agent[22372]: Bad USB agent
invocation
Mar 28 23:33:22 gamma-suse1 /etc/hotplug/usb.agent[22380]: modules.usbmap
unparsable line:
Mar 28 23:33:22 gamma-suse1 /etc/hotplug/usb.agent[22380]: .
Mar 28 23:33:22 gamma-suse1 /etc/hotplug/usb.agent[22380]: modules.usbmap
unparsable line:
Mar 28 23:33:22 gamma-suse1 /etc/hotplug/usb.agent[22380]: .
Mar 28 23:33:22 gamma-suse1 kernel: usb 2-1: USB disconnect, address 2 Mar
28 23:33:24 gamma-suse1 kernel: usb 2-1: new full speed USB device using
address 3
Mar 28 23:33:24 gamma-suse1 /sbin/hotplug[22469]: no runnable
/etc/hotplug/sound.agent is installed
Mar 28 23:33:24 gamma-suse1 /sbin/hotplug[22467]: no runnable
/etc/hotplug/sound.agent is installed
Mar 28 23:33:25 gamma-suse1 /etc/hotplug/usb.agent[22506]:
/proc/bus/usb/002/002: No such file or directory
Mar 28 23:33:28 gamma-suse1 /etc/hotplug/usb.agent[22528]: Bad USB agent
invocation
Mar 28 23:33:33 gamma-suse1 /etc/hotplug/usb.agent[22536]: Bad USB agent
invocation
Mar 28 23:33:36 gamma-suse1 /etc/hotplug/usb.agent[22544]: modules.usbmap
unparsable line:
Mar 28 23:33:36 gamma-suse1 /etc/hotplug/usb.agent[22544]: .
Mar 28 23:33:36 gamma-suse1 /etc/hotplug/usb.agent[22544]: modules.usbmap
unparsable line:
Mar 28 23:33:36 gamma-suse1 /etc/hotplug/usb.agent[22544]: .
Mar 28 23:33:39 gamma-suse1 /sbin/hotplug[22584]: no runnable
/etc/hotplug/sound.agent is installed
Mar 28 23:33:39 gamma-suse1 /sbin/hotplug[22585]: no runnable
/etc/hotplug/sound.agent is installed
Mar 28 23:33:39 gamma-suse1 /sbin/hotplug[22586]: no runnable
/etc/hotplug/sound.agent is installed
Mar 28 23:33:39 gamma-suse1 /sbin/hotplug[22589]: no runnable
/etc/hotplug/sound.agent is installed
Mar 28 23:33:39 gamma-suse1 /sbin/hotplug[22591]: no runnable
/etc/hotplug/sound.agent is installed
Mar 28 23:33:39 gamma-suse1 kernel: usb 2-1: control timeout on ep0in Mar
28 23:33:39 gamma-suse1 kernel: usbfs: USBDEVFS_CONTROL failed cmd
usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
Mar 28 23:33:40 gamma-suse1 kernel: usb 2-1: control timeout on ep0in Mar
28 23:33:40 gamma-suse1 kernel: usbfs: USBDEVFS_CONTROL failed cmd
usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
Mar 28 23:33:40 gamma-suse1 kernel: usb 2-1: control timeout on ep0in Mar
28 23:33:40 gamma-suse1 kernel: usbfs: USBDEVFS_CONTROL failed cmd
usbmodules dev 3 rqt 128 rq 6 len 18 ret -110

--- `lsusb` (output) -----------------------------------------
Bus 003 Device 002: ID 056a:0011 Wacom Co., Ltd Graphire 2
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 003: ID 1604:8005 Tascam
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000

--- `aadebug.sh` (output) ------------------------------------
ALSA Audio Debug v0.0.7 - Sun Mar 28 23:35:38 WEST 2004
http://alsa.opensrc.org/?aadebug

Kernel ----------------------------------------------------
Linux gamma-suse1 2.6.4-ck1.smp #1 SMP Fri Mar 12 16:01:11 WET 2004 i686
i686 i386 GNU/Linux

Loaded Modules --------------------------------------------
snd_seq                57872  2
snd_usb_usx2y          21700  1
snd_usb_audio          63680  1 snd_usb_usx2y
snd_hwdep               9760  2 snd_usb_usx2y
snd_intel8x0           32040  4
snd_ac97_codec         59268  1 snd_intel8x0
snd_pcm                98976  3 snd_usb_usx2y,snd_usb_audio,snd_intel8x0
snd_timer              25732  2 snd_seq,snd_pcm
snd_page_alloc         11908  3 snd_usb_usx2y,snd_intel8x0,snd_pcm
snd_mpu401_uart         8192  1 snd_intel8x0
snd_rawmidi            24864  2 snd_usb_audio,snd_mpu401_uart
snd_seq_device          8328  2 snd_seq,snd_rawmidi
snd                    56420  22
snd_seq,snd_usb_usx2y,snd_usb_audio,snd_hwdep,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device

Modprobe Conf ----------------------------------------------
alias char-major-116 snd
alias snd-card-0 snd-intel8x0
alias sound-slot-0 snd-intel8x0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-11 snd-mixer-oss
alias sound-service-0-12 snd-pcm-oss
alias snd-card-1 snd-usb-usx2y
alias sound-slot-1 snd-usb-usx2y
options snd-intel8x0 ac97_clock=0 enable=1 index=0
options snd-usb-usx2y index=1
#options snd cards_limit=2 major=116
install sound /bin/true
install sound-service-1-0 /bin/true
install sound-service-2-0 /bin/true
install sound-service-3-0 /bin/true
install sound-slot-1 /bin/true
install sound-slot-2 /bin/true

Proc Asound -----------------------------------------------
Advanced Linux Sound Architecture Driver Version 1.0.3.
Compiled on Mar 12 2004 for kernel 2.6.4-ck1.smp (SMP).
0 [ICH5           ]: ICH - Intel ICH5
                     Intel ICH5 at 0xfebff800, irq 17
1 [USX2Y          ]: USB US-X2Y - TASCAM US-X2Y
                     TASCAM US-X2Y (1604:8005 if 0 at 002/003)
  0: [0- 0]: ctl
 20: [0- 4]: digital audio playback
 27: [0- 3]: digital audio capture
 26: [0- 2]: digital audio capture
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  1:       : sequencer
 33:       : timer
 32: [1- 0]: ctl
 36: [1- 0]: hardware dependent
 48: [1- 0]: digital audio playback
 56: [1- 0]: digital audio capture
 40: [1- 0]: raw midi
01-00: /proc/bus/usb/002/003
00-00: Intel ICH : Intel ICH5 : playback 1 : capture 1
00-01: Intel ICH - MIC ADC : Intel ICH5 - MIC ADC : capture 1
00-02: Intel ICH - MIC2 ADC : Intel ICH5 - MIC2 ADC : capture 1
00-03: Intel ICH - ADC2 : Intel ICH5 - ADC2 : capture 1
00-04: Intel ICH - IEC958 : Intel ICH5 - IEC958 : playback 1
01-00: US-X2Y Audio : US-X2Y Audio #0 : playback 1 : capture 1

Dev Snd ---------------------------------------------------
controlC0  hwC5D2    midiC2D4  midiC6D2  pcmC1D0c  pcmC2D7c  pcmC4D6c 
pcmC6D5c
controlC1  hwC5D3    midiC2D5  midiC6D3  pcmC1D0p  pcmC2D7p  pcmC4D6p 
pcmC6D5p
controlC2  hwC6D0    midiC2D6  midiC6D4  pcmC1D1c  pcmC3D0c  pcmC4D7c 
pcmC6D6c
controlC3  hwC6D1    midiC2D7  midiC6D5  pcmC1D1p  pcmC3D0p  pcmC4D7p 
pcmC6D6p
controlC4  hwC6D2    midiC3D0  midiC6D6  pcmC1D2c  pcmC3D1c  pcmC5D0c 
pcmC6D7c
controlC5  hwC6D3    midiC3D1  midiC6D7  pcmC1D2p  pcmC3D1p  pcmC5D0p 
pcmC6D7p
controlC6  hwC7D0    midiC3D2  midiC7D0  pcmC1D3c  pcmC3D2c  pcmC5D1c 
pcmC7D0c
controlC7  hwC7D1    midiC3D3  midiC7D1  pcmC1D3p  pcmC3D2p  pcmC5D1p 
pcmC7D0p
hwC0D0     hwC7D2    midiC3D4  midiC7D2  pcmC1D4c  pcmC3D3c  pcmC5D2c 
pcmC7D1c
hwC0D1     hwC7D3    midiC3D5  midiC7D3  pcmC1D4p  pcmC3D3p  pcmC5D2p 
pcmC7D1p
hwC0D2     midiC0D0  midiC3D6  midiC7D4  pcmC1D5c  pcmC3D4c  pcmC5D3c 
pcmC7D2c
hwC0D3     midiC0D1  midiC3D7  midiC7D5  pcmC1D5p  pcmC3D4p  pcmC5D3p 
pcmC7D2p
hwC1D0     midiC0D2  midiC4D0  midiC7D6  pcmC1D6c  pcmC3D5c  pcmC5D4c 
pcmC7D3c
hwC1D1     midiC0D3  midiC4D1  midiC7D7  pcmC1D6p  pcmC3D5p  pcmC5D4p 
pcmC7D3p
hwC1D2     midiC0D4  midiC4D2  pcmC0D0c  pcmC1D7c  pcmC3D6c  pcmC5D5c 
pcmC7D4c
hwC1D3     midiC0D5  midiC4D3  pcmC0D0p  pcmC1D7p  pcmC3D6p  pcmC5D5p 
pcmC7D4p
hwC2D0     midiC0D6  midiC4D4  pcmC0D1c  pcmC2D0c  pcmC3D7c  pcmC5D6c 
pcmC7D5c
hwC2D1     midiC0D7  midiC4D5  pcmC0D1p  pcmC2D0p  pcmC3D7p  pcmC5D6p 
pcmC7D5p
hwC2D2     midiC1D0  midiC4D6  pcmC0D2c  pcmC2D1c  pcmC4D0c  pcmC5D7c 
pcmC7D6c
hwC2D3     midiC1D1  midiC4D7  pcmC0D2p  pcmC2D1p  pcmC4D0p  pcmC5D7p 
pcmC7D6p
hwC3D0     midiC1D2  midiC5D0  pcmC0D3c  pcmC2D2c  pcmC4D1c  pcmC6D0c 
pcmC7D7c
hwC3D1     midiC1D3  midiC5D1  pcmC0D3p  pcmC2D2p  pcmC4D1p  pcmC6D0p 
pcmC7D7p
hwC3D2     midiC1D4  midiC5D2  pcmC0D4c  pcmC2D3c  pcmC4D2c  pcmC6D1c  seq
hwC3D3     midiC1D5  midiC5D3  pcmC0D4p  pcmC2D3p  pcmC4D2p  pcmC6D1p 
timer hwC4D0     midiC1D6  midiC5D4  pcmC0D5c  pcmC2D4c  pcmC4D3c 
pcmC6D2c hwC4D1     midiC1D7  midiC5D5  pcmC0D5p  pcmC2D4p  pcmC4D3p 
pcmC6D2p hwC4D2     midiC2D0  midiC5D6  pcmC0D6c  pcmC2D5c  pcmC4D4c 
pcmC6D3c hwC4D3     midiC2D1  midiC5D7  pcmC0D6p  pcmC2D5p  pcmC4D4p 
pcmC6D3p hwC5D0     midiC2D2  midiC6D0  pcmC0D7c  pcmC2D6c  pcmC4D5c 
pcmC6D4c hwC5D1     midiC2D3  midiC6D1  pcmC0D7p  pcmC2D6p  pcmC4D5p 
pcmC6D4p

CPU -------------------------------------------------------
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
cpu MHz         : 3361.785
cpu MHz         : 3361.785

RAM -------------------------------------------------------
MemTotal:      1033432 kB
SwapTotal:     1951816 kB

Hardware --------------------------------------------------
00:00.0 Host bridge: Intel Corp. 82865G/PE/P Processor to I/O Controller
(rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB AC'97 Audio
Controller (rev 02)

--- `aplay -l` (output) --------------------------------------
**** List of PLAYBACK Hardware Devices ****
card 0: ICH5 [Intel ICH5], device 0: Intel ICH [Intel ICH5]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: ICH5 [Intel ICH5], device 4: Intel ICH - IEC958 [Intel ICH5 - IEC958]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
**** List of PLAYBACK Hardware Devices ****
card 1: USX2Y [TASCAM US-X2Y], device 0: US-X2Y Audio [US-X2Y Audio #0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

--- `aconnect -li` (output) --------------------------------
client 0: 'System' [type=kernel]
    0 'Timer           '
    1 'Announce        '
client 72: 'TASCAM US-X2Y - Rawmidi 1' [type=kernel]
    0 'TASCAM US-X2Y MIDI 1'
client 129: 'US-428' [type=user]
    0 'Controls        '

--- `aconnect -lo` (output) --------------------------------
 client 72: 'TASCAM US-X2Y - Rawmidi 1' [type=kernel]
    0 'TASCAM US-X2Y MIDI 1'
client 128: 'KAMix' [type=user]
    0 'qamix           '

--- `lsusb -v -d 1604:8005` (output) -----------------------
Bus 002 Device 003: ID 1604:8005 Tascam
  Language IDs: none (invalid length string descriptor bf; len=0)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            0 Interface
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x1604 Tascam
  idProduct          0x8005
  bcdDevice            0.01
  iManufacturer           0
  iProduct                0
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          169
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      Remote Wakeup
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           5
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize         21
        bInterval              10
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x06  EP 6 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       1
      bNumEndpoints           7
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize         21
        bInterval              10
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x06  EP 6 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x88  EP 8 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize        200
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x0a  EP 10 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize        200
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       2
      bNumEndpoints           7
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize         21
        bInterval              10
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x06  EP 6 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x88  EP 8 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize        300
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x0a  EP 10 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize        300
        bInterval               1
  Language IDs: none (invalid length string descriptor bf; len=0)

--- `aplay -v -D hw:1 "DrumLoopA 01.wav"` ------------------
Playing WAVE 'DrumLoopA 01.wav' : Signed 16 bit Little Endian, Rate 44100
Hz, Stereo
Hardware PCM card 1 'TASCAM US-X2Y' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 16384
period_size  : 5513
period_time  : 125011
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 5513
xfer_align   : 5513
start_threshold  : 11026
stop_threshold   : 16384
silence_threshold: 0
silence_size : 0
boundary     : 1073741824

--- No errors, only silence :(


I'm pretty desperate on this. If someone can point out a clue on this
puzzle I'll appreciate very much.

As I said, I'm open to try everything at my reach to make this thing work,
even if that means going deep into driver source code and/or debugging. In
fact, I'm eager to do that, just need some initial pointers and advice.
I'm sure I can help somehow.

Karsten?
Martin?

Pleeeeease?
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
