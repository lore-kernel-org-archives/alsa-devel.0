From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: usx2y: known problems with us122 and alsa-drivers-1.0.1?
Date: Sun, 11 Jan 2004 14:49:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401111449.06508.annabellesgarden@yahoo.de>
References: <1073762822.1019.14.camel@serrano>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1073762822.1019.14.camel@serrano>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bill Gribble <grib@billgribble.com>
Cc: alsa-devel@lists.sourceforge.net, Martin Langer <martin-langer@gmx.de>
List-Id: alsa-devel@alsa-project.org

Am Samstag, 10. Januar 2004 20:27 schrieben Sie:
> Hi,
>
> I have built and installed ALSA 1.0.1 from tarballs for use with my new
> Tascam US-122.  As far as I can tell, ALSA is correctly recognizing and
> loading firmware for this device.  The USB light is on, the device shows
> up in /proc/asound as card # 0, etc.  ALSA works properly on the
> internal card for this laptop, which is loaded as the second card, I can
> produce sound and so on.  However, when I attempt to play a soundfile
> through the US-122 using aplay, it fails as follows.
>
> My question to you is: do you have any known problems with US-122 and
> alsa-1.0.1?
no known problem for the US-428 here with a 2.4.23 kernel. Did not yet try any 
2.6 kernel & don't have an US-122.

>
> I did have to make a small change to alsa-kernel/usb/usbaudio.h in the
> tarball distro to add back some definitions for USB_DT_CS_* that are
> needed by the usb audio driver.  Maybe this is evidence that the 1.0.1
> distro is out of sync with authoritative source for usb-audio?
>
> Here is some possibly useful information about my system.  Thanks in
> advance for any help you can provide.
>
> $ cat /proc/asound/version
> Advanced Linux Sound Architecture Driver Version 1.0.1.
> Compiled on Jan 10 2004 for kernel 2.6.0.
>
> $ cat /proc/asound/cards
> 0 [USX2Y          ]: USB US-X2Y - TASCAM US-X2Y
>                      TASCAM US-X2Y (1604:8007 if 0 at 003/006)
> 1 [A5451          ]: ALI5451 - ALI 5451
>                      ALI 5451 at 0x1000, irq 5
please give us the output of $ cat /proc/asound/devices!

>
>
> $ aplay -D hw:0 ~/gillian.wav
> Playing WAVE '/home/grib/gillian.wav' : Signed 16 bit Little Endian,
> Rate 44100 Hz, Stereo
> ALSA lib pcm_hw.c:324:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS
> failed: No such device
> aplay: set_params:875: Unable to install hw params:
> ACCESS:  RW_INTERLEAVED
> FORMAT:  S16_LE
> SUBFORMAT:  STD
> SAMPLE_BITS: 16
> FRAME_BITS: 32
> CHANNELS: 2
> RATE: 44100
> PERIOD_TIME: (125011 125012)
> PERIOD_SIZE: 5513
> PERIOD_BYTES: 22052
> PERIODS: (2 3)
> BUFFER_TIME: (371519 371520)
> BUFFER_SIZE: 16384
> BUFFER_BYTES: 65536
> TICK_TIME: 1000
>
> I have tried many normal variations of buffer sizes and so on but no
> change.  Here is some other possibly useful information:
>
> OK, and it's in /dev also:
>
> $ ls -l /dev/snd
> total 0
> crw-rw----    1 root     audio    116,   0 Dec 31  1969 controlC0
> crw-rw----    1 root     audio    116,  32 Dec 31  1969 controlC1
> crw-rw----    1 root     audio    116,   4 Dec 31  1969 hwC0D0
> crw-rw----    1 root     audio    116,   8 Dec 31  1969 midiC0D0
> crw-rw----    1 root     audio    116,  24 Dec 31  1969 pcmC0D0c
> crw-rw----    1 root     audio    116,  16 Dec 31  1969 pcmC0D0p
> crw-rw----    1 root     audio    116,  56 Dec 31  1969 pcmC1D0c
> crw-rw----    1 root     audio    116,  48 Dec 31  1969 pcmC1D0p
> crw-rw----    1 root     audio    116,  33 Dec 31  1969 timer
>
> When I attached the USB device, here's the message I saw in
> /var/log/messages:
>
> Jan 10 12:50:10 serrano kernel: hub 3-0:1.0: new USB device on port 2,
> assigned
> address 5
> Jan 10 12:50:10 serrano kernel: midi: probe of 3-2:1.0 failed with error
> -5
> Jan 10 12:50:11 serrano /etc/hotplug/usb/tascam_fw: load
> /usr/share/alsa/firmware/usx2yloader/us122fw.ihx for 1604/8006/100 to
> /proc/bus/usb/003/005
> Jan 10 12:50:11 serrano kernel: usb 3-2: USB disconnect, address 5
> Jan 10 12:50:13 serrano kernel: hub 3-0:1.0: new USB device on port 2,
> assigned
> address 6
> Jan 10 12:50:13 serrano kernel: midi: probe of 3-2:1.0 failed with error
> -5
> Jan 10 12:50:13 serrano /etc/hotplug/usb/tascam_fpga: calling
> /usr/bin/usx2yloader for /proc/bus/usb/003/006
> Jan 10 12:50:15 serrano /etc/hotplug/usb/tascam_fpga: starting  for
> /proc/bus/usb/003/006
> Jan 10 12:50:15 serrano /etc/hotplug/usb/tascam_fpga: leaving



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
