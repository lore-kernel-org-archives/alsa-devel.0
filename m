From: noreply@alsa-project.org
Subject: [ALSA - driver 0000061]: Creative Audigy 2 NX (USB) not working
Date: Sun, 27 Jun 2004 19:31:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <02142e6b5db36ef4e713c2cebb3119f1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


A BUGNOTE has been added to this bug.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0061
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                Davin
Assigned To:                Clemens Ladisch
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     61
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             02-14-2004 19:02 CET
Last Modified:              06-27-2004 19:31 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    Creative Audigy 2 NX (USB) not working
Description:=20
While I've found a single success report of someone getting this device t=
o
work (http://www.qbik.ch/usb/devices/showdev.php?id=3D2375), the details =
as
to how he did it are sparse and I've recieved no e-mail reply. There are =
a
handful of reports of this device not working, and it is not listed in
alsa-project.org's list of known sound cards. (as such, whether or not it
is or is not supported lacks mention)

As far as I can tell, it does not work. The device will show up in
alsamixer if one uses the snd-usb-audio. The first 'speaker 2' channel is
muted by default, which APPEARS to be the 'front' speaker jack. Unmuting
this channel makes the mute light on the device turn off.

Attempts to use this device with userland devices will fail, returning th=
e
program-specific "can't initialize audio" error. By increasing verbosity
further, I found the exact error being returned by alsalib:

"SNDRV_PCM_IOCTL_HW_PARAMS failed"

On further investigation, messages are also appearing in the kernel
message log, coinciding with these errors:

Feb 14 06:57:13 napalm 2:1:3 : invalid synch pipe
Feb 14 06:57:13 napalm 2:1:1 : invalid synch pipe=20

2:1:X bears little relevance I'm guessing, since I assume those to be the
USB subdevice IDs.

In short, I suspect this device does not work with the usb-audio driver a=
s
it currently stands.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 Davin - 02-14-2004 19:26 CET=20
----------------------------------------------------------------------
Err, let me be a little more specific on the error. Verbosity is a good
thing.

ALSA lib pcm_hw.c:324:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS
failed: Invalid argument

----------------------------------------------------------------------
 Davin - 02-15-2004 01:37 CET=20
----------------------------------------------------------------------
Ironicly enough, I recieved an e-mail from the person with success shortl=
y
after this. I was advised that I couldn't use the alsa drivers provided
with the 2.6 kernel, and that I would need more current ones.

I rebuilt my kernel (removing ALSA support entirely), built
alsa-driver-1.0.2c with support for usb-audio and sequencer, and rebooted=
.
I'm running into a very, very strange problem:

root@napalm root # modprobe snd_usb_audio
FATAL: Error inserting snd_usb_audio
(/lib/modules/2.6.2/kernel/sound/usb/snd-usb-audio.ko): Unknown symbol in
module, or unknown parameter (see dmesg)
root@napalm sound # dmesg | tail -5
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
snd_usb_audio: Unknown symbol usb_get_device_descriptor
snd_usb_audio: Unknown symbol usb_get_device_descriptor

This is totally, totally bizarre in light of the following:
root@napalm root # cd /usr/src/linux
root@napalm linux # grep usb_get_device_descriptor *
System.map:c03370d4 T usb_get_device_descriptor
Binary file vmlinux matches
root@napalm linux # cd usb
bash: cd: usb: No such file or directory
root@napalm linux # cd drivers/usb
root@napalm usb # grep usb_get_device_descriptor */*
Binary file core/built-in.o matches
core/hub.c:             ret =3D usb_get_device_descriptor(dev,
sizeof(dev->descriptor));
Binary file core/hub.o matches
core/message.c: * usb_get_device_descriptor() for USB_DT_DEVICE (not
exported),
core/message.c: * usb_get_device_descriptor - (re)reads the device
descriptor
core/message.c:int usb_get_device_descriptor(struct usb_device *dev,
unsigned int size)
Binary file core/message.o matches
core/usb.c:             err =3D usb_get_device_descriptor(dev, 8);
core/usb.c:     err =3D usb_get_device_descriptor(dev,
sizeof(dev->descriptor));
core/usb.h:extern int usb_get_device_descriptor(struct usb_device *dev,
Binary file core/usb.o matches
Binary file core/usbcore.o matches

The symbol is obviously compiled into the kernel. I've always had USB
support in my kernel, and I'm certain that I booted off of the kernel
image without ALSA support.

----------------------------------------------------------------------
 Clemens Ladisch - 02-20-2004 18:37 CET=20
----------------------------------------------------------------------
usb_get_device_descriptor is obsolete in 2.6 kernels.

This has been fixed in CVS.  Either get the latest CVS version of ALSA, o=
r
apply the following path by hand:=20
http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/usb/usbaudio.c?r1=3D=
1.77&r2=3D1.78&diff_format=3Dl
(If you don't have an Extigy, you can simple remove the line from
usbaudio.c)

----------------------------------------------------------------------
 Davin - 02-22-2004 00:41 CET=20
----------------------------------------------------------------------
Tried CVS alsa-driver/lib/utils, programs refused to play audio.

Applied your suggested patch to alsa-driver 1.0.2c and switched to
alsa-lib/utils 1.0.2, programs still refuse to play audio.

Sample output from alsaplayer when running under the 1.0.2 (non-CVS
setup):

davin@napalm davin $ alsaplayer
ALSA lib pcm_hw.c:324:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS
failed: Invalid argument
Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (11609 11610)
PERIOD_SIZE: 512
PERIOD_BYTES: 2048
PERIODS: 16
BUFFER_TIME: (185759 185760)
BUFFER_SIZE: 8192
BUFFER_BYTES: 32768
TICK_TIME: 1000
ALSA lib pcm_hw.c:324:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS
failed: Invalid argument
Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (23219 23220)
PERIOD_SIZE: 1024
PERIOD_BYTES: 4096
PERIODS: 8
BUFFER_TIME: (185759 185760)
BUFFER_SIZE: 8192
BUFFER_BYTES: 32768
TICK_TIME: 1000
failed to configure output device...trying OSS

(program locks up unkillable here)

----------------------------------------------------------------------
 Clemens Ladisch - 02-24-2004 08:43 CET=20
----------------------------------------------------------------------
FORMAT: S16_LE
CHANNELS: 2
RATE: 44100

It may be possible that the device doesn't support this particular sample
format. Please look into /proc/asound/cardX/stream0 to determine the
device capabilities.

What happens when you run "aplay -v something.wav" (this should work in
any case)?

----------------------------------------------------------------------
 Davin - 02-25-2004 02:39 CET=20
----------------------------------------------------------------------
All mixer channels unmuted and set to 87. Speaker volume is not at minimu=
m.
Speakers and card work in Windows. With the above said, running 'aplay -v
chord.wav' returns silence and the following output. I've also included
the contents of /proc/asound/card0/stream0.




davin@napalm media $ aplay -v chord.wav
Playing WAVE 'chord.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Stereo
ALSA lib pcm_hw.c:324:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS
failed: Invalid argument
aplay: set_params:875: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 22050
PERIOD_TIME: (125011 125012)
PERIOD_SIZE: (2756 2757)
PERIOD_BYTES: (11024 11028)
PERIODS: (2 3)
BUFFER_TIME: (371519 371520)
BUFFER_SIZE: 8192
BUFFER_BYTES: 32768
TICK_TIME: 1000




root@napalm media # cat /proc/asound/card0/stream0
Creative Technology Ltd SB Audigy 2 NX at usb-0000:00:1d.7-2 : USB Audio

Playback:
  Status: Stop
  Interface 1
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 1 OUT (ASYNC)
    Rates: 44100
  Interface 1
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 1 OUT (ASYNC)
    Rates: 44100
  Interface 1
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 1 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 4
    Format: S24_3LE
    Channels: 2
    Endpoint: 1 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 5
    Format: S16_LE
    Channels: 2
    Endpoint: 1 OUT (ASYNC)
    Rates: 96000
  Interface 1
    Altset 6
    Format: S24_3LE
    Channels: 2
    Endpoint: 1 OUT (ASYNC)
    Rates: 96000
  Interface 1
    Altset 7
    Format: S16_LE
    Channels: 4
    Endpoint: 1 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 8
    Format: S24_3LE
    Channels: 4
    Endpoint: 1 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 9
    Format: S16_LE
    Channels: 4
    Endpoint: 1 OUT (ASYNC)
    Rates: 96000
  Interface 1
    Altset 10
    Format: S24_3LE
    Channels: 4
    Endpoint: 1 OUT (ASYNC)
    Rates: 96000
  Interface 1
    Altset 11
    Format: S16_LE
    Channels: 6
    Endpoint: 1 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 12
    Format: S24_3LE
    Channels: 6
    Endpoint: 1 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 13
    Format: S16_LE
    Channels: 6
    Endpoint: 1 OUT (ASYNC)
    Rates: 96000
  Interface 1
    Altset 14
    Format: S24_3LE
    Channels: 6
    Endpoint: 1 OUT (ASYNC)
    Rates: 96000
  Interface 1
    Altset 15
    Format: S16_LE
    Channels: 8
    Endpoint: 1 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 16
    Format: S24_3LE
    Channels: 8
    Endpoint: 1 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 17
    Format: S16_LE
    Channels: 8
    Endpoint: 1 OUT (ASYNC)
    Rates: 96000
  Interface 1
    Altset 18
    Format: S24_3LE
    Channels: 8
    Endpoint: 1 OUT (ASYNC)
    Rates: 96000

Capture:
  Status: Stop
  Interface 2
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 2 IN (NONE)
    Rates: 32000
  Interface 2
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 2 IN (NONE)
    Rates: 32000
  Interface 2
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 2 IN (NONE)
    Rates: 44100
  Interface 2
    Altset 4
    Format: S24_3LE
    Channels: 2
    Endpoint: 2 IN (NONE)
    Rates: 44100
  Interface 2
    Altset 5
    Format: S16_LE
    Channels: 2
    Endpoint: 2 IN (NONE)
    Rates: 48000
  Interface 2
    Altset 6
    Format: S24_3LE
    Channels: 2
    Endpoint: 2 IN (NONE)
    Rates: 48000
  Interface 2
    Altset 7
    Format: S16_LE
    Channels: 2
    Endpoint: 2 IN (NONE)
    Rates: 96000
  Interface 2
    Altset 8
    Format: S24_3LE
    Channels: 2
    Endpoint: 2 IN (NONE)
    Rates: 96000

----------------------------------------------------------------------
 Clemens Ladisch - 02-25-2004 10:09 CET=20
----------------------------------------------------------------------
> $ aplay -v chord.wav
> Playing WAVE 'chord.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Stereo
> aplay: set_params:875: Unable to install hw params:

The Audigy2NX does not support 22050 Hz.  In theory, the "default" should
resample this file, but you probably have redefined this in your
.asoundrc.

Please try "aplay -Dplughw:0 -v chord.wav".

----------------------------------------------------------------------
 Davin - 02-26-2004 04:08 CET=20
----------------------------------------------------------------------
I have no .asoundrc, so that isn't the reason why. The following should
look familiar:

root@napalm media # aplay -Dplughw:0 -v chord.wav
Playing WAVE 'chord.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Stereo
ALSA lib pcm_hw.c:324:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS
failed: Invalid argument
aplay: set_params:875: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 22050
PERIOD_TIME: (125011 125012)
PERIOD_SIZE: (2756 2757)
PERIOD_BYTES: (11024 11028)
PERIODS: (2 3)
BUFFER_TIME: (371519 371520)
BUFFER_SIZE: 8192
BUFFER_BYTES: 32768
TICK_TIME: 1000

----------------------------------------------------------------------
 Clemens Ladisch - 02-26-2004 16:23 CET=20
----------------------------------------------------------------------
Just for testing, create a file .asoundrc in your home directory with the
following contents:

pcm.test {
    type plug
    slave.pcm "hw:0"
    slave.rate 48000
}

and then try to run "aplay -D test  ..."

----------------------------------------------------------------------
 Davin - 02-26-2004 23:54 CET=20
----------------------------------------------------------------------
davin@napalm media $ cat ~/.asoundrc
pcm.test {
 type plug
 slave.pcm "hw:0"
 slave.rate 48000
 }

davin@napalm media $ aplay -D test chord.wav
Playing WAVE 'chord.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Stereo
ALSA lib pcm_hw.c:324:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS
failed: Invalid argument
aplay: set_params:875: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 22050
PERIOD_TIME: 125000
PERIOD_SIZE: (2756 2757)
PERIOD_BYTES: (11024 11028)
PERIODS: (2 3)
BUFFER_TIME: (341315 341316)
BUFFER_SIZE: 7526
BUFFER_BYTES: 30104
TICK_TIME: 1000

----------------------------------------------------------------------
 Clemens Ladisch - 03-01-2004 18:43 CET=20
----------------------------------------------------------------------
What does "aplay -Dtest -v chord.wav" say?

----------------------------------------------------------------------
 Davin - 03-01-2004 19:51 CET=20
----------------------------------------------------------------------
Exactly the same.

I've switched to kernel 2.6.3 on advisory from the person I know who has
his Audigy 2 NX working in Linux. (2.6.3 has updates from alsa-driver CVS=
)
This test was run using 2.6.3's kernel driver, as opposed to the patched
2.0.1c I used per your suggestion - the results are the same.

I'm going to ask him what versions of alsa-lib and alsa-utils he's using.


davin@napalm media $ aplay -Dtest -v chord.wav
Playing WAVE 'chord.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Stereo
ALSA lib pcm_hw.c:324:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS
failed: Invalid argument
aplay: set_params:875: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 22050
PERIOD_TIME: 125000
PERIOD_SIZE: (2756 2757)
PERIOD_BYTES: (11024 11028)
PERIODS: (2 3)
BUFFER_TIME: (341315 341316)
BUFFER_SIZE: 7526
BUFFER_BYTES: 30104
TICK_TIME: 1000

----------------------------------------------------------------------
 Davin - 03-01-2004 19:53 CET=20
----------------------------------------------------------------------
I still have the compiled version of the alsa-driver instance I was using=
.
Let me know if you want me to switch back. (I'm expecting it)

----------------------------------------------------------------------
 Davin - 03-01-2004 20:02 CET=20
----------------------------------------------------------------------
Pardon, when I said 2.0.1c I meant 1.0.2c.

----------------------------------------------------------------------
 Davin - 03-01-2004 20:27 CET=20
----------------------------------------------------------------------
The 2.6.3 CVS sources have the same problem, it's looking like. Let me kn=
ow
if it ever gets to the point where you'd prefer direct machine access, I
have no problem giving you a temp root password over a more secure
medium.

> Same here

On Mon, 1 Mar 2004, Davin Boling wrote:
>> Just out of curiousity, what version of alsa-lib and alsa-utils are
you
>> using in conjunction with 2.6.3? I'm using 1.0.2 instances of each.

----------------------------------------------------------------------
 Clemens Ladisch - 03-02-2004 17:01 CET=20
----------------------------------------------------------------------
> (snd_pcm_hw_hw_params) Invalid argument
> RATE: 22050

It seems ALSA tries to make the hardware play at 22 kHz although your
device doesn't support this.  In theory, the "plug" plugin should
automatically convert the sample rate.

This may be a bug in the driver.  Please try the 1.0.3 packages.

(my e-mail address is clemens@ladisch.de)

----------------------------------------------------------------------
 Davin - 03-03-2004 05:01 CET=20
----------------------------------------------------------------------
Updated alsa-driver/lib/utils to 1.03. Same ol' story.

----------------------------------------------------------------------
 Davin - 03-03-2004 05:08 CET=20
----------------------------------------------------------------------
Now that I'm starting to get a feel for what you're testing for...

Cache fill:  0.00% (0 bytes)    MPEG-PS file format detected.
VIDEO:  MPEG1  320x240  (aspect 1)  30.00 fps    0.0 kbps ( 0.0 kbyte/s)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Opening audio decoder: [mp3lib] MPEG layer-2, layer-3
MP3lib: init layer2&3 finished, tables done
AUDIO: 44100 Hz, 2 ch, 16 bit (0x10), ratio: 24000->176400 (192.0 kbit)
Selected audio codec: [mp3] afm:mp3lib (mp3lib MPEG layer-2, layer-3)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Opening video filter: [pp]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Opening video decoder: [mpegpes] MPEG 1/2 Video passthrough
VDec: vo config request - 320 x 240 (preferred csp: Mpeg PES)
[PP] Using external postprocessing filter, max q =3D 6.
Could not find matching colorspace - retrying with -vop scale...
Opening video filter: [scale]
The selected video_out device is incompatible with this codec.
VDecoder init failed :(
Opening video decoder: [libmpeg2] MPEG 1/2 Video decoder v2.0
libmpeg2: Using MMXEXT for IDCT transform
libmpeg2: Using MMXEXT for motion compensation
VDec: vo config request - 320 x 240 (preferred csp: Planar YV12)
[PP] Using external postprocessing filter, max q =3D 6.
VDec: using Planar YV12 as output csp (no 0)
Movie-Aspect is undefined - no prescaling applied.
VO: [xv] 320x240 =3D> 320x240 Planar YV12
Selected video codec: [mpeg12] vfm:libmpeg2 (MPEG 1 or 2 (libmpeg2))
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Checking audio filter chain for 44100Hz/2ch/16bit -> 44100Hz/2ch/16bit...
AF_pre: af format: 2 bps, 2 ch, 44100 hz, little endian signed int
AF_pre: 44100Hz 2ch Signed 16-bit (Little-Endian)
SDL: Samplerate: 44100Hz Channels: Stereo Format Signed 16-bit
(Little-Endian)
SDL: using alsa audio driver
ALSA lib pcm_hw.c:324:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS
failed: Invalid argument
gmplayer: pcm.c:1004: snd_pcm_drain: Assertion `pcm->setup' failed.

Note how the problem exists even if the output is 44100, a supported
format.

----------------------------------------------------------------------
 Davin - 03-03-2004 05:12 CET=20
----------------------------------------------------------------------
(unless of course it's trying to play this 44kHz stream at 22, I realize
that my last statement overlooked that fact)

I'm setting a temp root password and e-mailing it to you, I think this
could be solved much faster if you had hands-on access in this case.

----------------------------------------------------------------------
 Clemens Ladisch - 03-04-2004 14:31 CET=20
----------------------------------------------------------------------
Well, it wasn't some wrong sample format at all.  Somehow I had forgotten
about the "invalid synch pipe" message.

The error is caused by bugs in the firmware of the device.  I have change=
d
the driver to work around this.

It seems recording generates too much data, please check if the captured
data has the correct sample rate and format.

BTW: did you install the latest firmware update for this device?

----------------------------------------------------------------------
 Davin - 03-04-2004 15:17 CET=20
----------------------------------------------------------------------
I'm assuming you mean the latest Creative Labs supplied firmware update,
since I'm clueless as to how the alsa-firmware package gets used!

At any rate, yes, I am using the latest firmware from Creative. The most
recent drivers provided by Creative (Dec 23) include an automatic firmwar=
e
update for the device. I installed these drivers in Windows before
attempting to get the device working in Linux.

I should find out what version of the firmware the person who has the
device working already is using - it's quite possible that the latest
firmware actually introduces the bug in question.

Thanks for all of your help and patience in the meantime. Where do I find
the patch you've made? I'll test it once I get home from work and if all
goes well we can wrap this bug up.

----------------------------------------------------------------------
 Davin - 03-04-2004 15:39 CET=20
----------------------------------------------------------------------
Nevermind on 'where' to find the patch, snooping around in
/root/.bash_history on your own system is a perfectly legitimate practice=
.
O:) Making a copy of your modified usb-audio.c, though for all I know it'=
s
hit CVS already.

Still need to test the actual speaker output and possible recording quirk
you mentioned, I'm not home from work yet.

----------------------------------------------------------------------
 Davin - 03-04-2004 16:31 CET=20
----------------------------------------------------------------------
> I'm using the latest (that I know of) firmware

Very strange. When I get home I'll see if I can find a revision identifie=
r
and find what his is. Failing that, I have no idea why mine exhibits this
bug and his does not.

----------------------------------------------------------------------
 Davin - 03-04-2004 18:30 CET=20
----------------------------------------------------------------------
You weren't the only one who forgot some important info. The guy I've bee=
n
having a correspondance with shared this info with me in a previous
e-mail:

> Did you have any luck yet? With the 2.6.3-rc3 it works much better...
One
> thing I definitely discovered is that you need to make it avoid
running(or
> trying) to run at 480mbps thats where I get the invalid synch pipe. If
I
> move it to a 12mbps port it works fine.

I assumed when I originally read this that it was working for him despite
the invalid synch pipe message, but I don't think this is the case now. I
think this explains the difference in behavior.

----------------------------------------------------------------------
 Davin - 03-05-2004 01:13 CET=20
----------------------------------------------------------------------
Well, it was a step in the right direction anyway. But no go. Sound does
hit the speakers, but playing any of the basic windows .wav files does no=
t
return the proper audio. Typically a single sound, though nothing high
frequency or similarly harmful to the ears...of the ones I've tried so fa=
r
anyway.

Root password is still the same, but I don't know what you can do now
since you don't have a way of hearing what I do.

Well, no, that's not true. I do have another sound card I could connect. =
I
could run the speaker output of the USB device into the PCI's input. That
way you could capture the sound and tell whether or not it's working.

Sound like a plan? Unless you have a better suggestion, of course.

----------------------------------------------------------------------
 Davin - 03-05-2004 06:52 CET=20
----------------------------------------------------------------------
Didn't have enough time to figure out how to to recording in Linux with
what little time I had tonight. You're welcome to toy around anyway if
you'd like, I just never got to a point where I could directly hear the
USB device through the audio-in of the other audio device.

Just so you know, device 0 is an on-board audio chip that I re-enabled. I
have a cable connecting the speaker output of the Audigy 2 NX (device 1)
to the audio input of device 0. Should theoreticly be enough for you to
make recordings of the NX's actual speaker output.

I have the weekend off, so if you'd like to set aside a specific block of
time I'd be more than happy to work with you directly. (no matter how
insane the hour might be in my local timezone)

----------------------------------------------------------------------
 Clemens Ladisch - 03-05-2004 13:42 CET=20
----------------------------------------------------------------------
I think both the playback and capture problems are caused by the fact tha=
t
the driver calculates frame numbers based on USB 1.1 speeds.  I'll have t=
o
review the driver code.  (there won't be any results before next week)

----------------------------------------------------------------------
 nilsr - 03-16-2004 21:39 CET=20
----------------------------------------------------------------------
I tried the highspeed patch on a stock 2.6.3 kernel where it applies
cleanly. Trying to play a S16LE_48000 .wav file with aplay results in
the kernel message

drivers/usb/host/ehci-hcd.c: no split iso support yet
cannot submit datapipe for urb 0, err =3D -38

That appears to be a different message from the one reported earlier.
There is commented out in linux-2.6.3/drivers/usb/host/ehci-hcd.c
that should enable a different response, but I did not try to enable that=
.

----------------------------------------------------------------------
 Clemens Ladisch - 03-18-2004 09:00 CET=20
----------------------------------------------------------------------
> no split iso support yet

You tried to play to a full speed device through a high speed hub.  This
will be supported in 2.6.5.

Try to connect the device directly to your computer.

----------------------------------------------------------------------
 Clemens Ladisch - 03-18-2004 09:09 CET=20
----------------------------------------------------------------------
The highspeed.patchfile file was an old version that wouldn't work, I've
uploaded the new one.

----------------------------------------------------------------------
 nilsr - 03-18-2004 21:29 CET=20
----------------------------------------------------------------------
Ok, plugging the audigy directly into the computer did work and aplay
made a nice sound. Thanks for the tip.

The computer hang hard however, when I did a cat
/proc/asound/card0/stream0, which was just at the end of playing, came at
the wrong time I suppose.

I'll try the new highspeed patch now, and I also
got a patch that is supposed to support split iso for ehci.

----------------------------------------------------------------------
 Davin - 03-29-2004 00:56 CEST=20
----------------------------------------------------------------------
Sorry for the delay, I should be getting back to this by tomorrow evening=
.

----------------------------------------------------------------------
 Davin - 04-23-2004 21:45 CEST=20
----------------------------------------------------------------------
Life gets busy sometimes, what can I say.

At any rate, I'm going to be reinstalling Linux from scratch this evening
to address some concerns of mine about possible file corruption. Somethin=
g
related to hotplug + usbaudio had been giving my system immense trouble
while I was troubleshooting the below problem, and my resulting audio
problems may be a result of running on an installation with ~30 unclean
uses of the reset button. (definately compiling MagicSysRq in next time)

I'll post a followup once I've got the new install up and running.

----------------------------------------------------------------------
 micmac - 06-27-2004 17:16 CEST=20
----------------------------------------------------------------------
Hello,

I'm an owner of one of these cards since yesterday, too. So maybe I can
provide useful infos for devs that do not have these cards in order to
squash some bugs or whatever.
I have Gentoo running on an Acer Laptop. The Laptop offers USB2 and it's
working great. The setup looks like this. The USB soundcard is plugged
into the lappy and an optical SPDIF cable is the connection between
soundcard and my Yamaha Receiver. The kernel is gentoo-dev-sources-2.6.7.
I have alsa-lib/alsa-utils-1.0.5 installed. The card sounded bad in the
beginning when playing 44.1kHz MP3s, while the 48kHz sound from DVD
sounded good. I circumvent that problem with an .asoundrc (which I attach=
)
that I found in some forum. So it is not from me but it works.
Ok. So... when starting the lappy I always had to use alsamixer to change
the status from Speaker2 and DigitalIn from 'off' to 'on'. After that it
would work ok. But it's not funny that you have to do that every time you
restart. So I went looking for info on the net and found that some users
said they have more success with this card after upgrading it's firmware.
So I took the long way and made a backup of my drives, installed windows,
installed the drivers of the soundcard that came with it on a cdrom, then
installed another driver upgrade from the net. This upgraded the firmware
of the drive. After that I used my backup to get my linux back into the
box. Afterwards I was pleased to see that now I don't have to toggle
between on/off anymore to use the card. I could say it works ok now. The
only thing that bothers me a little is that I can't raise/lower the volum=
e
say with xmms. XMMS's mixer device setting allows me to chose from
"speaker", "speaker" and "speaker" (no joke). None of them works.=20

What would be nice to have?

For starters:

- a way to update this darn firmware without installing/using Windows

For all:

- a way to lower/raise volume in applications like xmms
- changes to the snd-usb-audio modules that it recognises the NX properly
and sets sampling to 48kHz as default. So the .asoundrc file would become
obsolete (in order to have the card work right from the start to honor
user friendly behaviour :)

Thanks for reading!

Best regards
Sebastian

P.S.: I'd do nearly anything. So if you devs need info just say so. I'll
be checking this site from now on from time to time.
Bye
Sebastian

----------------------------------------------------------------------
 micmac - 06-27-2004 19:31 CEST=20
----------------------------------------------------------------------
Ok. I think I made a wrong statement. I do have to toggle "Speaker2" and
"DigitalIn" to 'on' after a restart :(

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
02-14-04 19:02 Davin          New Bug                                    =
 =20
02-14-04 19:26 Davin          Bugnote Added: 0000240                     =
 =20
02-14-04 19:27 Davin          Bug Monitored: Davin                       =
 =20
02-15-04 01:37 Davin          Bugnote Added: 0000241                     =
 =20
02-20-04 18:37 Clemens LadischBugnote Added: 0000276                     =
 =20
02-22-04 00:41 Davin          Bugnote Added: 0000288                     =
 =20
02-24-04 08:43 Clemens LadischBugnote Added: 0000300                     =
 =20
02-25-04 02:39 Davin          Bugnote Added: 0000308                     =
 =20
02-25-04 10:09 Clemens LadischBugnote Added: 0000311                     =
 =20
02-25-04 10:12 Clemens LadischBug Monitored: Clemens Ladisch             =
      =20
02-26-04 04:08 Davin          Bugnote Added: 0000331                     =
 =20
02-26-04 16:23 Clemens LadischBugnote Added: 0000354                     =
 =20
02-26-04 23:54 Davin          Bugnote Added: 0000377                     =
 =20
03-01-04 18:43 Clemens LadischBugnote Added: 0000412                     =
 =20
03-01-04 19:51 Davin          Bugnote Added: 0000421                     =
 =20
03-01-04 19:53 Davin          Bugnote Added: 0000422                     =
 =20
03-01-04 20:02 Davin          Bugnote Added: 0000423                     =
 =20
03-01-04 20:27 Davin          Bugnote Added: 0000425                     =
 =20
03-02-04 17:01 Clemens LadischBugnote Added: 0000442                     =
 =20
03-03-04 05:01 Davin          Bugnote Added: 0000449                     =
 =20
03-03-04 05:08 Davin          Bugnote Added: 0000450                     =
 =20
03-03-04 05:12 Davin          Bugnote Added: 0000451                     =
 =20
03-04-04 14:31 Clemens LadischBugnote Added: 0000478                     =
 =20
03-04-04 15:17 Davin          Bugnote Added: 0000480                     =
 =20
03-04-04 15:39 Davin          Bugnote Added: 0000481                     =
 =20
03-04-04 16:31 Davin          Bugnote Added: 0000483                     =
 =20
03-04-04 18:30 Davin          Bugnote Added: 0000486                     =
 =20
03-05-04 01:13 Davin          Bugnote Added: 0000494                     =
 =20
03-05-04 06:52 Davin          Bugnote Added: 0000496                     =
 =20
03-05-04 13:42 Clemens LadischBugnote Added: 0000503                     =
 =20
03-08-04 10:57 Clemens LadischFile Added: highspeed.patch                =
   =20
03-16-04 21:39 nilsr          Bugnote Added: 0000631                     =
 =20
03-17-04 20:43 nilsr          Bug Monitored: nilsr                       =
 =20
03-18-04 09:00 Clemens LadischBugnote Added: 0000637                     =
 =20
03-18-04 09:01 Clemens LadischFile Deleted: highspeed.patch              =
     =20
03-18-04 09:04 Clemens LadischFile Added: highspeed.patch                =
   =20
03-18-04 09:09 Clemens LadischBugnote Added: 0000638                     =
 =20
03-18-04 21:29 nilsr          Bugnote Added: 0000643                     =
 =20
03-29-04 00:56 Davin          Bugnote Added: 0000715                     =
 =20
04-23-04 21:45 Davin          Bugnote Added: 0000918                     =
 =20
06-27-04 17:02 micmac         File Added: .asoundrc                      =
 =20
06-27-04 17:16 micmac         Bugnote Added: 0001339                     =
 =20
06-27-04 19:31 micmac         Bugnote Added: 0001340                     =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
