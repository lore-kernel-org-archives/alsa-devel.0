From: "Lonnie Mendez" <lmendez19@austin.rr.com>
Subject: Problem with snd-usb-audio (usbmixer)
Date: Tue, 17 Aug 2004 18:33:27 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000f01c484b2$9a712d10$0200a8c0@jedi>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

(See description below)

Specs:
linux kernel 2.6.8.1 (sound subsystem built-in, usb-audio module from USB
Support not compiled)
alsa-driver 1.0.6a (usb-audio module selected)

Problem occurs on:
uhci/ehci intel p3 abit bh6 and uhci intel p3 laptop

Relevant messages:

dmesg:
ALSA /work/alsa-driver-1.0.6a/usb/usbaudio.c:2573: 8:1:1: add audio endpoint
0x2

ALSA /work/alsa-driver-1.0.6a/usb/usbaudio.c:2573: 8:1:2: add audio endpoint
0x2

ALSA /work/alsa-driver-1.0.6a/alsa-kernel/usb/usbmixer.c:866: [3] FU [PCM
Playback Switch] ch = 1, val = 0/1/1

ALSA /work/alsa-driver-1.0.6a/alsa-kernel/usb/usbmixer.c:866: [3] FU [PCM
Playback Volume] ch = 2, val = -32768/0/256

ALSA /work/alsa-driver-1.0.6a/alsa-kernel/usb/usbmixer.c:313: cannot get ctl
value: req = 0x83, wValue = 0x200, wIndex = 0x300, type = 4

ALSA /work/alsa-driver-1.0.6a/alsa-kernel/usb/usbmixer.c:611: 3:0: cannot
get min/max values for control 2 (id 3)

ALSA /work/alsa-driver-1.0.6a/alsa-kernel/usb/usbmixer.c:866: [3] FU [PCM
Playback Volume] ch = 1, val = 0/1/1


/proc/asound

  devices:
0: [0- 0]: ctl

16: [0- 0]: digital audio playback

33: : timer

  cards:
0 [PCM2702 ]: USB-Audio - Burr-Brown Japan PCM2702

Burr-Brown Japan Burr-Brown Japan PCM2702 at usb-0000:00:0b.3-6.4, full
speed



alsamixer fails with:

alsamixer: function snd_mixer_load failed: Invalid argument

amixer fails with:

amixer: Mixer default load error: Invalid argument

alsasound script given command stop will yield these results:

Shutting down driver: /usr/sbin/alsactl: get_control:194: Cannot read
control '2,0,0,PCM Playback Volume,1': Invalid argument


You can view lsusb -vv output here:

http://geocities.com/i0xox0i/lsusboutput.txt

Every time I try loading the snd-usb-audio module usbmixer will fail to get
or set values.  I'm guessing this device is going to require a custom mixer
map to be created in usbmixer_maps.c?  How exactly should this be written
given the output from the lsusb in verbose mode?



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
