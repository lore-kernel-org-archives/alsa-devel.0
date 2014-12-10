From: mobidyc <mobidyc@gmail.com>
Subject: Audio USB disappears suddenly
Date: Wed, 10 Dec 2014 19:58:36 +0100
Message-ID: <CAM4quvZC3L_mcQtt3giUjUqVnN1N1A05m=fP379xh61TDi_-mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f178.google.com (mail-lb0-f178.google.com
 [209.85.217.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BF2B2605A3
 for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2014 19:58:57 +0100 (CET)
Received: by mail-lb0-f178.google.com with SMTP id f15so3192922lbj.9
 for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2014 10:58:57 -0800 (PST)
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

Hello,

don't know if I need to report my problem in alsa-dev list for the driver
or linux-dev list for the usb interface, please correct me if I post in
wrong mailing.

sometimes, my USB audio device disappears from the system, the only way to
make it appears again is to disconnect/reconnect the usb wire.

Here are the traces I took :

USB DAC suddenly disappears, from dmesg I can see:

[13083.161157] usb 1-1.3: 1:2: usb_set_interface failed (-110)
[13083.316344] usb 1-1.3: 1:2: usb_set_interface failed (-71)
[13083.471927] usb 1-1.3: 1:2: usb_set_interface failed (-71)
[13083.789810] usb 1-1.3: 1:2: usb_set_interface failed (-71)

rmmod/modprobe snd-usb-audio:

[13882.343950] usbcore: deregistering interface driver snd-usb-audio
[13891.187513] usb 1-1.3: parse_audio_format_rates_v2(): unable to find
clock source (clock -71)
[13891.200234] usb 1-1.3: parse_audio_format_rates_v2(): unable to find
clock source (clock -71)
[13891.242722] usb 1-1.3: cannot get ctl value: req = 0x83, wValue = 0x201,
wIndex = 0xa00, type = 4
[13891.242728] usb 1-1.3: 10:0: cannot get min/max values for control 2 (id
10)
[13891.255466] usb 1-1.3: cannot get ctl value: req = 0x83, wValue = 0x200,
wIndex = 0xa00, type = 4
[13891.255471] usb 1-1.3: 10:0: cannot get min/max values for control 2 (id
10)
[13891.255737] usbcore: registered new interface driver snd-usb-audio
[13891.276723] usb 1-1.3: cannot get ctl value: req = 0x81, wValue = 0x101,
wIndex = 0xa00, type = 1
[13891.284222] usb 1-1.3: cannot get ctl value: req = 0x81, wValue = 0x101,
wIndex = 0xa00, type = 1
[13891.290842] usb 1-1.3: cannot get ctl value: req = 0x81, wValue = 0x101,
wIndex = 0xa00, type = 1
[13891.297210] usb 1-1.3: cannot get ctl value: req = 0x81, wValue = 0x101,
wIndex = 0xa00, type = 1

from "aplay -l" the card is seen as :
card 1: U0x249c0x9313 [USB Device 0x249c:0x9313], device 0: USB Audio [USB
Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

after disconnected/reconnected the usb wire:
card 1: UAC2 [YoungDSD UAC2], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

[16005.411254] usb 1-1.3: USB disconnect, device number 4
[16007.132442] usb 1-1.3: new high-speed USB device number 6 using ehci-pci
[16007.250087] input: M2Tech YoungDSD UAC2 as
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3:1.3/0003:249C:9313.0006/input/input22
[16007.250233] hid-generic 0003:249C:9313.0006: input,hidraw2: USB HID
v1.10 Device [M2Tech YoungDSD UAC2] on usb-0000:00:1a.0-1.3/input3

Is there any debug i could turn on to get more informations?

Additional informations:
 # ./aadebug
ALSA Audio Debug v0.2.0 - Wed Dec 10 19:56:00 CET 2014
http://alsa.opensrc.org/aadebug
http://www.gnu.org/licenses/agpl-3.0.txt

Kernel ----------------------------------------------------
Linux TEVERE 3.16.3 #1 SMP Sun Nov 23 16:17:25 CET 2014 x86_64 GNU/Linux
Advanced Linux Sound Architecture Driver Version k3.16.3.

Loaded Modules --------------------------------------------
snd_usb_audio         105962  1
snd_hda_codec_hdmi     31141  1
snd_hda_codec_realtek    47854  1
snd_hda_codec_generic    39920  1 snd_hda_codec_realtek
snd_usbmidi_lib        16134  1 snd_usb_audio
snd_rawmidi            14042  1 snd_usbmidi_lib
snd_hda_intel          18271  0
snd_hda_controller     15146  1 snd_hda_intel
snd_hda_codec          73127  5
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller
snd_hwdep               4949  2 snd_usb_audio,snd_hda_codec
snd_pcm                59473  6
snd_usb_audio,snd_hda_codec_hdmi,snd_hda_codec,snd_hda_intel,snd_hda_controller

Proc Asound -----------------------------------------------
 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xf7c10000 irq 45
 1 [UAC2           ]: USB-Audio - YoungDSD UAC2
                      M2Tech YoungDSD UAC2 at usb-0000:00:1a.0-1.3, high
speed
  2: [ 1]   : control
  3: [ 1- 0]: digital audio playback
  4: [ 0]   : control
  5: [ 0- 0]: digital audio playback
  6: [ 0- 0]: digital audio capture
  7: [ 0- 1]: digital audio playback
  8: [ 0- 2]: digital audio capture
  9: [ 0- 3]: digital audio playback
 10: [ 0- 7]: digital audio playback
 11: [ 0- 2]: hardware dependent
 12: [ 0- 3]: hardware dependent
 33:        : timer
00-02: HDA Codec 2
00-03: HDA Codec 3
00-00: ALC892 Analog : ALC892 Analog : playback 1 : capture 1
00-01: ALC892 Digital : ALC892 Digital : playback 1
00-02: ALC892 Alt Analog : ALC892 Alt Analog : capture 1
00-03: HDMI 0 : HDMI 0 : playback 1
00-07: HDMI 1 : HDMI 1 : playback 1
01-00: USB Audio : USB Audio : playback 1
cat: can't open '/proc/asound/seq/clients': No such file or directory

Dev Snd ---------------------------------------------------
total 0
drwxr-xr-x    2 root     root            60 Dec 10 18:28 by-id
drwxr-xr-x    2 root     root            80 Dec 10 18:28 by-path
crw-rw----    1 root     audio     116,   4 Dec 10 14:01 controlC0
crw-rw----    1 root     audio     116,   2 Dec 10 18:28 controlC1
crw-rw----    1 root     audio     116,  11 Dec 10 14:01 hwC0D2
crw-rw----    1 root     audio     116,  12 Dec 10 14:01 hwC0D3
crw-rw----    1 root     audio     116,   6 Dec 10 14:01 pcmC0D0c
crw-rw----    1 root     audio     116,   5 Dec 10 19:27 pcmC0D0p
crw-rw----    1 root     audio     116,   7 Dec 10 14:01 pcmC0D1p
crw-rw----    1 root     audio     116,   8 Dec 10 14:01 pcmC0D2c
crw-rw----    1 root     audio     116,   9 Dec 10 14:01 pcmC0D3p
crw-rw----    1 root     audio     116,  10 Dec 10 14:01 pcmC0D7p
crw-rw----    1 root     audio     116,   3 Dec 10 19:29 pcmC1D0p
crw-rw----    1 root     audio     116,  33 Dec 10 14:01 timer

CPU -------------------------------------------------------
model name    : Intel(R) Celeron(R) CPU G470 @ 2.00GHz
cpu MHz        : 1711.718
model name    : Intel(R) Celeron(R) CPU G470 @ 2.00GHz
cpu MHz        : 1697.812

RAM -------------------------------------------------------
MemTotal:        1859156 kB
SwapTotal:             0 kB

Hardware --------------------------------------------------
00:02.0 VGA compatible controller: Intel Corporation 2nd Generation Core
Processor Family Integrated Graphics Controller (rev 09)
00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset Family
High Definition Audio Controller (rev 04)

Interupts -------------------------------------------------
           CPU0       CPU1
  0:         14          0   IO-APIC-edge      timer
  1:          2          0   IO-APIC-edge      i8042
  8:          1          0   IO-APIC-edge      rtc0
  9:          3          0   IO-APIC-fasteoi   acpi
 12:          4          0   IO-APIC-edge      i8042
 16:   15139141          0   IO-APIC-fasteoi   ehci_hcd:usb1
 23:         37          0   IO-APIC-fasteoi   ehci_hcd:usb2
 40:     386062          0   PCI-MSI-edge      i915
 41:       9653          0   PCI-MSI-edge      ahci
 42:     815667          0   PCI-MSI-edge      eth0
 43:          0          0   PCI-MSI-edge      eth1
 44:          0          0   PCI-MSI-edge      xhci_hcd
 45:      19140          0   PCI-MSI-edge      snd_hda_intel
NMI:         48         32   Non-maskable interrupts
LOC:    4562425    1085862   Local timer interrupts
SPU:          0          0   Spurious interrupts
PMI:         48         32   Performance monitoring interrupts
IWI:          0          0   IRQ work interrupts
RTR:          1          0   APIC ICR read retries
RES:      21236      17958   Rescheduling interrupts
CAL:        136        121   Function call interrupts
TLB:       2095       2460   TLB shootdowns
ERR:          0
MIS:          0


Thanks for helping me understand this problem.

--
Mobidyc
