From: sypwex <sypwex@gmail.com>
Subject: Re: [Alsa-user] snd-usb-caiaq (NI Maschine Mikro)
 device not recognised by alsa
Date: Sat, 19 Sep 2015 12:20:28 +0300
Message-ID: <CAGPstWtnvg=mE54JGaU8y0gTU8BwxkzMqnOFXW-VSVmtQtkJmQ@mail.gmail.com>
References: <CAGPstWvoprjRHN2+xZe5w+=pPkOqcqQdR4t7bYY_MgXwKbPD4A@mail.gmail.com>
 <55EC7191.8020107@googlemail.com>
Reply-To: sypwex@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f195.google.com (mail-ig0-f195.google.com
 [209.85.213.195])
 by alsa0.perex.cz (Postfix) with ESMTP id AB6AB260505
 for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2015 11:20:29 +0200 (CEST)
Received: by igcxw12 with SMTP id xw12so5079981igc.3
 for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2015 02:20:28 -0700 (PDT)
In-Reply-To: <55EC7191.8020107@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@googlemail.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org, daniel@caiaq.de, sypwex@gmail.com
List-Id: alsa-devel@alsa-project.org

ow, sorry! I not mentioned that there is no PID of Maschine Mikro (0x1110)
in caiaq device list
*https://github.com/torvalds/linux/blob/v4.2/sound/usb/caiaq/device.h
<https://github.com/torvalds/linux/blob/v4.2/sound/usb/caiaq/device.h>*

yes there is some endless dump from usbhid but I don't know how to deal
with it
$sudo usbhid-dump --entity=all --address=1:15
http://pastebin.com/raw.php?i=KC96ERSV (300KiB)

ok, I've tried to extend the driver and end up with following doodad
https://github.com/krasnobaev/linux/commits/feature/caiaq-mmikro-1
for every commit I've generated dmesg log
*http://pastebin.com/raw.php?i=pJzdAyf4
<http://pastebin.com/raw.php?i=pJzdAyf4>*
$amidi -l
have no devices
$cat /proc/asound/cards
 4 [MaschineMikro  ]: snd-usb-caiaq - Maschine Mikro
                      Native Instruments Maschine Mikro (usb-0000:00:02.1-8)
$cat /proc/asound/devices
 24: [ 4]   : control
$cat /proc/asound/oss/sndstat
Sound Driver:3.8.1a-980706 (ALSA emulation code)
Kernel: Linux ***** 3.19.0+ #1 SMP Sun Sep 13 10:44:23 MSK 2015 x86_64
Config options: 0

Installed drivers:
Type 10: ALSA emulation

Card config:
X-Fi Extreme Audio [SB0790] at 0xdc00 irq 18
HDA NVidia at 0xfcf7c000 irq 19
Aureal Vortex au8810 at 0xfbfc0000 irq 17
Webcam C170 at usb-0000:00:02.1-4, high speed
Native Instruments Maschine Mikro (usb-0000:00:02.1-8)

Audio devices:
0: CA0106 (DUPLEX)
2: au8810 adb (DUPLEX)
3: USB Audio

Synth devices: NOT ENABLED IN CONFIG

Midi devices:
0: CA0106 MPU-401 (UART)
2: au8810 MIDI 2

Timers:
31: system timer

Mixers:
0: CA0106
1: Nvidia GPU 1c HDMI/DP
2: Wolfson WM9701,WM9701A
3: USB Mixer
4: Maschine Mikro
$cat /proc/asound/oss/devices
 64: [4- 0]: mixer


So, currently customized driver fails (all info in dmesg log) on every
usb_submit_urb and usb_set_interface functions, so I've decided to watch
wireshark usb logs of windows driver

filtered windows log (usb.transfer_type != 0x01) && (usb.device_address ==
3)
http://filebin.ca/2G6kerv8x9TD/usbpcap-maschine-mikro-win7-x86-3maschinesoftw-usb.transfer_type0x01usb.device_address3.txt
RAW
http://filebin.ca/2G6g6civjKfI/usbpcap-maschine-mikro-win7-x86-3maschinesoftw.pcap

filtered log for custom driver
http://filebin.ca/2G6kFZxgTTKR/usbpcap-maschine-mikro-ubuntu15.04-linux3.19-x64-caiaq-mmikro-1-31d6809-usb.device_address10usb.transfer_type0x01.txt
RAW
http://filebin.ca/2G6oNuU6c6b5/usbpcap-maschine-mikro-ubuntu15.04-linux3.19-x64-caiaq-mmikro-1-31d6809.pcapng

the difference is...
 - windows driver do not send SET INTERFACE request while native caiaq
driver is.
 - windows driver receives Response and Status on each request while caiaq
recieves only Response
 - windows driver send two GET_REPORT with wValues: 0x03f8 and 0x0101 while
caiaq driver sends three GET_REPORT requests with wValues: 0x0101, 0x0120,
0x03f8
 - windows send 3 SET_REPORT requests with same wValue 0x03f8 while caiaq
driver do not send any SET_REPORT request

I do not know what means these wValues (0x0101, 0x0120, 0x03f8) and how to
find out.

Is there probability if linux driver send SET_REPORT requests in the same
way as do windows driver - the device will set up correctly?
How to send SET REPORT request?

I believe that there is no big difference between Maschine Controller and
Maschine Mikro.
BUT
there is no Maschine Mikro on caiaq portfolio
http://caiaq.de/references_en.html



On Sun, Sep 6, 2015 at 8:02 PM, Clemens Ladisch <cladisch@googlemail.com>
wrote:

> sypwex wrote:
> > Native Instruments Mashine Mikro which is snd-usb-caiaq.
>
> No it's not; the Maschine Mikro is not the same as the Maschine Controller.
>
> As far as I can see from your lsusb output, the Mikro either works as
> a HID input device, or needs a separate driver.  To check the first
> possibility, try a tool like <https://github.com/DIGImend/usbhid-dump>.
>
>
> Regards,
> Clemens
>

Cheers.
