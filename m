From: James Miller <jamesstewartmiller@gmail.com>
Subject: steinberg ur44 - soundcard not connecting,
	acl problem (systemd?)
Date: Mon, 6 Apr 2015 19:45:43 +0100
Message-ID: <CAKJvYZGd4F0DDq0V4CxQeoOK1iN=yUzwb5h2yTuNwDOmHoMm9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f176.google.com (mail-ie0-f176.google.com
 [209.85.223.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 63AB326047B
 for <alsa-devel@alsa-project.org>; Mon,  6 Apr 2015 20:45:45 +0200 (CEST)
Received: by iebmp1 with SMTP id mp1so28231589ieb.0
 for <alsa-devel@alsa-project.org>; Mon, 06 Apr 2015 11:45:44 -0700 (PDT)
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

Hi, I've just bought a steinberg ur44.  It is reported as having worked in
an earlier kernel to the 3.18 rt custom/3.19 low latency generic that I am
using.  The low latency kernel is generic but the realtime is compiled with
the alsa quirks as described here:

http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/074120.html

On plugging it in, the card is recognised by udev but is disconnected after
seemingly being set up.   The same error seems to be occurring when I start
the machine with the card plugged in. There seems to be an ACL error
reported in journalctl.  I include the appropriate lines from the udevadm
and from journalctl

udevadm:

sudo udevadm monitor

monitor will print the received events for:
UDEV - the event which udev sends out after rule processing
KERNEL - the kernel uevent

KERNEL[2741.779546] add      /devices/pci0000:00/0000:00:1a.7/usb1/1-5 (usb)
KERNEL[2741.779705] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.0 (usb)
KERNEL[2741.781720] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1 (usb)
KERNEL[2741.787500] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3 (sound)
KERNEL[2741.787611] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/controlC3
(sound)
KERNEL[2741.787813] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/pcmC3D0p
(sound)
KERNEL[2741.787933] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/pcmC3D0c
(sound)
KERNEL[2741.788073] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/midiC3D0
(sound)
KERNEL[2741.788189] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/midi3 (sound)
KERNEL[2741.789228] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/dmmidi3
(sound)
KERNEL[2741.789294] remove
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/midi3 (sound)
KERNEL[2741.789315] remove
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/dmmidi3
(sound)
KERNEL[2741.789365] remove
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/midiC3D0
(sound)
KERNEL[2741.789418] remove
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/pcmC3D0p
(sound)
KERNEL[2741.789436] remove
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/pcmC3D0c
(sound)
KERNEL[2741.789487] remove
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/controlC3
(sound)
KERNEL[2741.789503] remove
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3 (sound)
KERNEL[2741.789556] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.2 (usb)
KERNEL[2741.789577] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.3 (usb)
KERNEL[2741.790043] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.4 (usb)
UDEV  [2741.810128] add      /devices/pci0000:00/0000:00:1a.7/usb1/1-5 (usb)
UDEV  [2741.810172] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.3 (usb)
UDEV  [2741.810195] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.2 (usb)
UDEV  [2741.810217] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1 (usb)
UDEV  [2741.810237] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3 (sound)
UDEV  [2741.810260] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/pcmC3D0c
(sound)
UDEV  [2741.810279] remove
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/pcmC3D0c
(sound)
UDEV  [2741.810301] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.4 (usb)
UDEV  [2741.815664] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/pcmC3D0p
(sound)
UDEV  [2741.815903] remove
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/pcmC3D0p
(sound)
UDEV  [2741.820639] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/midi3 (sound)
UDEV  [2741.821530] remove
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/midi3 (sound)
UDEV  [2741.823891] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/dmmidi3
(sound)
UDEV  [2741.823931] remove
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/dmmidi3
(sound)
UDEV  [2741.826596] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/midiC3D0
(sound)
UDEV  [2741.827398] remove
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/midiC3D0
(sound)
UDEV  [2741.837736] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/controlC3
(sound)
UDEV  [2741.839478] remove
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/controlC3
(sound)
UDEV  [2741.840171] remove
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3 (sound)
UDEV  [2742.842156] add
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.0 (usb)

journactl (on hotplug add):

Apr 06 19:26:09 super-R720 kernel: usb 1-5: USB disconnect, device number 4
Apr 06 19:26:09 super-R720 systemd-udevd[309]: error opening USB device
'descriptors' file
Apr 06 19:26:11 super-R720 kernel: usb 1-5: new high-speed USB device
number 5 using ehci-pci
Apr 06 19:26:12 super-R720 kernel: usb 1-5: New USB device found,
idVendor=0499, idProduct=150e
Apr 06 19:26:12 super-R720 kernel: usb 1-5: New USB device strings: Mfr=1,
Product=2, SerialNumber=0
Apr 06 19:26:12 super-R720 kernel: usb 1-5: Product: Steinberg UR44
Apr 06 19:26:12 super-R720 kernel: usb 1-5: Manufacturer: Yamaha Corporation
Apr 06 19:26:12 super-R720 kernel: snd-usb-audio: probe of 1-5:1.1 failed
with error -16
Apr 06 19:26:12 super-R720 mtp-probe[3550]: checking bus 1, device 5:
"/sys/devices/pci0000:00/0000:00:1a.7/usb1/1-5"
Apr 06 19:26:12 super-R720 mtp-probe[3550]: bus: 1, device: 5 was not an
MTP device
Apr 06 19:26:12 super-R720 systemd-udevd[3547]: error opening
ATTR{/sys/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/controlC3/
Apr 06 19:26:12 super-R720 systemd-udevd[3560]: Failed to apply ACL on
/dev/dmmidi3: No such file or directory
Apr 06 19:26:12 super-R720 systemd-udevd[3560]: Failed to apply ACL on
/dev/dmmidi3: No such file or directory
Apr 06 19:26:12 super-R720 systemd-udevd[3559]: Failed to apply ACL on
/dev/midi3: No such file or directory
Apr 06 19:26:12 super-R720 systemd-udevd[3559]: Failed to apply ACL on
/dev/midi3: No such file or directory
Apr 06 19:26:12 super-R720 systemd-udevd[3558]: Failed to apply ACL on
/dev/snd/midiC3D0: No such file or directory
Apr 06 19:26:12 super-R720 systemd-udevd[3558]: Failed to apply ACL on
/dev/snd/midiC3D0: No such file or directory
Apr 06 19:26:12 super-R720 systemd-udevd[3549]: Failed to apply ACL on
/dev/snd/pcmC3D0c: No such file or directory
Apr 06 19:26:12 super-R720 systemd-udevd[3549]: Failed to apply ACL on
/dev/snd/pcmC3D0c: No such file or directory
Apr 06 19:26:12 super-R720 systemd-udevd[3548]: Failed to apply ACL on
/dev/snd/pcmC3D0p: No such file or directory
Apr 06 19:26:12 super-R720 systemd-udevd[3548]: Failed to apply ACL on
/dev/snd/pcmC3D0p: No such file or directory
Apr 06 19:26:12 super-R720 systemd-udevd[3547]: Failed to apply ACL on
/dev/snd/controlC3: No such file or directory
Apr 06 19:26:12 super-R720 systemd-udevd[3547]: Failed to apply ACL on
/dev/snd/controlC3: No such file or directory

journalctl -b:

systemd-udevd[416]: error opening
ATTR{/sys/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5:1.1/sound/card3/controlC3/.

I can compile a kernel reasonably well, and can understand and program in
c, c++, but am not well versed in lower level usb hardware coding.  I'd be
grateful for any help, many thanks!

Many thanks

-- 
James Stewart Miller Bsc(hons) Psych.
