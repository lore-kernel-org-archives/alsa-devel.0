From: iain <iain@prettypeople.org>
Subject: Extigy mixer issues + problems with resampling
Date: 04 May 2003 17:26:33 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1052065593.1119.16.camel@discomachinegun.prettypeople.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-1hhixTiJL0Db4IopzZFF"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-1hhixTiJL0Db4IopzZFF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

I've got an Extigy card, and am having issues with mixers. Attached
(dmesg.log) is the dmesg output of the card being started. The drivers
have been compiled with --with-debug=detect

When I run alsamixer I get 
[iain@dmg]$ alsamixer
alsamixer: function snd_mixer_load failed: Invalid argument

and 
ALSA ../alsa-kernel/usb/usbmixer.c:299: cannot get ctl value: req =
0x81, wValue = 0x0, wIndex = 0x500, type = 3

is added to dmesg.

Running amixer gives:
[iain@dmg]$ amixer
amixer: Mixer load error: default

and the same line as above is added to dmesg.

Second problem: As you know the Extigy can't deal with many sample rates
so you need to use plughw to get the sample rate conversion, but this
doesn't seem to work.

Running the pcm program in alsa-lib/test gives
[iain@dmg]$ ./pcm
Playback device is plughw:0,0
Stream parameters are 44100Hz, S16_LE, 1 channels
Sine wave rate is 440.0000Hz
Using transfer method: write
ALSA lib pcm_hw.c:466:(snd_pcm_hw_prepare) SNDRV_PCM_IOCTL_PREPARE
failed: Invalid argument
Unable to set hw params for playback: Invalid argument
Setting of hwparams failed: Invalid argument

and this line gets added to dmesg
ALSA ../alsa-kernel/usb/usbaudio.c:1025: cannot set format: format =
S16_LE, rate = 44100, channels = 2

Should the sample rate not be changed to something the Extigy can
handle?

alsa-lib and alsa-driver are CVS from 3rd May, running linux 2.4.18 and
Redhat 8. Extigy will play back fine if I force a sample rate conversion
somehow (gstreamer, xine and mplayer have options to do it) but it would
be nice if ALSA did it automatically, like I think its supposed to.

Let me know if there's any more info needed
iain

-- 
"Miss Celine Dion sings lovesongs while our cities burn"

--=-1hhixTiJL0Db4IopzZFF
Content-Description: Editted dmesg showing relevant ALSA stuff
Content-Type: application/octet-stream
Content-Disposition: inline; filename=dmesg.log
Content-Transfer-Encoding: 7bit

usb.c: registered new driver snd-usb-audio
ALSA ../alsa-kernel/usb/usbaudio.c:2290: extigy_boot: boot length = 1701
ALSA ../alsa-kernel/usb/usbaudio.c:2091: 3:1:1: add audio endpoint 0x2
ALSA ../alsa-kernel/usb/usbaudio.c:1878: 3:1:2 : format type 0 is detected, processed as PCM
ALSA ../alsa-kernel/usb/usbaudio.c:2091: 3:1:2: add audio endpoint 0x2
ALSA ../alsa-kernel/usb/usbaudio.c:1878: 3:1:3 : format type 0 is detected, processed as PCM
ALSA ../alsa-kernel/usb/usbaudio.c:2091: 3:1:3: add audio endpoint 0x2
ALSA ../alsa-kernel/usb/usbaudio.c:1878: 3:1:4 : format type 0 is detected, processed as PCM
ALSA ../alsa-kernel/usb/usbaudio.c:2091: 3:1:4: add audio endpoint 0x2
ALSA ../alsa-kernel/usb/usbaudio.c:1878: 3:1:5 : format type 0 is detected, processed as PCM
ALSA ../alsa-kernel/usb/usbaudio.c:2091: 3:1:5: add audio endpoint 0x2
ALSA ../alsa-kernel/usb/usbaudio.c:1878: 3:1:6 : format type 0 is detected, processed as PCM
ALSA ../alsa-kernel/usb/usbaudio.c:2091: 3:1:6: add audio endpoint 0x2
ALSA ../alsa-kernel/usb/usbaudio.c:1878: 3:1:7 : format type 0 is detected, processed as PCM
ALSA ../alsa-kernel/usb/usbaudio.c:2091: 3:1:7: add audio endpoint 0x2
ALSA ../alsa-kernel/usb/usbaudio.c:1878: 3:1:8 : format type 0 is detected, processed as PCM
ALSA ../alsa-kernel/usb/usbaudio.c:2091: 3:1:8: add audio endpoint 0x2
ALSA ../alsa-kernel/usb/usbaudio.c:1878: 3:1:9 : format type 0 is detected, processed as PCM
ALSA ../alsa-kernel/usb/usbaudio.c:2091: 3:1:9: add audio endpoint 0x2
ALSA ../alsa-kernel/usb/usbaudio.c:1878: 3:1:10 : format type 0 is detected, processed as PCM
ALSA ../alsa-kernel/usb/usbaudio.c:2091: 3:1:10: add audio endpoint 0x2
ALSA ../alsa-kernel/usb/usbaudio.c:1878: 3:1:11 : format type 0 is detected, processed as PCM
ALSA ../alsa-kernel/usb/usbaudio.c:2091: 3:1:11: add audio endpoint 0x2
ALSA ../alsa-kernel/usb/usbaudio.c:1878: 3:1:12 : format type 0 is detected, processed as PCM
ALSA ../alsa-kernel/usb/usbaudio.c:2091: 3:1:12: add audio endpoint 0x2
ALSA ../alsa-kernel/usb/usbaudio.c:1878: 3:1:13 : format type 0 is detected, processed as PCM
ALSA ../alsa-kernel/usb/usbaudio.c:2091: 3:1:13: add audio endpoint 0x2
ALSA ../alsa-kernel/usb/usbaudio.c:1878: 3:1:14 : format type 0 is detected, processed as PCM
ALSA ../alsa-kernel/usb/usbaudio.c:2091: 3:1:14: add audio endpoint 0x2
ALSA ../alsa-kernel/usb/usbaudio.c:1878: 3:1:15 : format type 0 is detected, processed as PCM
ALSA ../alsa-kernel/usb/usbaudio.c:2091: 3:1:15: add audio endpoint 0x2
ALSA ../alsa-kernel/usb/usbaudio.c:1878: 3:1:16 : format type 0 is detected, processed as PCM
ALSA ../alsa-kernel/usb/usbaudio.c:2091: 3:1:16: add audio endpoint 0x2
ALSA ../alsa-kernel/usb/usbaudio.c:2091: 3:2:1: add audio endpoint 0x86
ALSA ../alsa-kernel/usb/usbaudio.c:2091: 3:2:2: add audio endpoint 0x86
ALSA ../alsa-kernel/usb/usbaudio.c:2091: 3:2:3: add audio endpoint 0x86
ALSA ../alsa-kernel/usb/usbaudio.c:2091: 3:2:4: add audio endpoint 0x86
ALSA ../alsa-kernel/usb/usbaudio.c:2091: 3:2:5: add audio endpoint 0x86
ALSA ../alsa-kernel/usb/usbaudio.c:1869: 3:3:1 : format type 2 is not supported yet
ALSA ../alsa-kernel/usb/usbaudio.c:1869: 3:3:2 : format type 3 is not supported yet
ALSA ../alsa-kernel/usb/usbmidi.c:812: MIDIStreaming version 01.00
ALSA ../alsa-kernel/usb/usbmidi.c:838: EP 07: 1 jack(s)
ALSA ../alsa-kernel/usb/usbmidi.c:849: EP 88: 1 jack(s)
ALSA ../alsa-kernel/usb/usbmidi.c:782: created 1 output and 1 input ports
ALSA ../alsa-kernel/usb/usbmixer.c:860: [2] FU [PCM Playback Switch] ch = 1, val = 0/1/1
ALSA ../alsa-kernel/usb/usbmixer.c:334: cannot set ctl value: req = 0x4, wValue = 0x200, wIndex = 0x200, type = 4, data = 0x40/0x0
ALSA ../alsa-kernel/usb/usbmixer.c:860: [2] FU [PCM Playback Volume] ch = 1, val = -25600/0/128
ALSA ../alsa-kernel/usb/usbmixer.c:1416: [5] SU [Digital In Playback Source] items = 2
ALSA ../alsa-kernel/usb/usbmixer.c:860: [6] FU [Digital In Switch] ch = 1, val = 0/1/1
ALSA ../alsa-kernel/usb/usbmixer.c:334: cannot set ctl value: req = 0x4, wValue = 0x200, wIndex = 0x600, type = 4, data = 0x40/0x0
ALSA ../alsa-kernel/usb/usbmixer.c:860: [6] FU [Digital In Volume] ch = 1, val = -25600/0/128
ALSA ../alsa-kernel/usb/usbmixer.c:860: [8] FU [Line Playback Switch] ch = 1, val = 0/1/1
ALSA ../alsa-kernel/usb/usbmixer.c:334: cannot set ctl value: req = 0x4, wValue = 0x201, wIndex = 0x800, type = 4, data = 0x40/0x0
ALSA ../alsa-kernel/usb/usbmixer.c:860: [8] FU [Line Playback Volume] ch = 2, val = -25600/0/128
ALSA ../alsa-kernel/usb/usbmixer.c:334: cannot set ctl value: req = 0x4, wValue = 0x200, wIndex = 0x800, type = 4, data = 0x40/0x0
ALSA ../alsa-kernel/usb/usbmixer.c:860: [8] FU [Line Playback Volume] ch = 1, val = -25600/0/128
ALSA ../alsa-kernel/usb/usbmixer.c:1209: [15] PU [3D Stereo Extender Switch] ch = 1, val = 0/1
ALSA ../alsa-kernel/usb/usbmixer.c:860: [10] FU [Mic Playback Switch] ch = 1, val = 0/1/1
ALSA ../alsa-kernel/usb/usbmixer.c:334: cannot set ctl value: req = 0x4, wValue = 0x200, wIndex = 0xa00, type = 4, data = 0x40/0x0
ALSA ../alsa-kernel/usb/usbmixer.c:860: [10] FU [Mic Playback Volume] ch = 1, val = -25600/0/128
ALSA ../alsa-kernel/usb/usbmixer.c:1209: [17] PU [Up Down Switch] ch = 1, val = 0/1
ALSA ../alsa-kernel/usb/usbmixer.c:299: cannot get ctl value: req = 0x83, wValue = 0x200, wIndex = 0x1100, type = 3
ALSA ../alsa-kernel/usb/usbmixer.c:597: 17:0: cannot get min/max values for control 2 (id 17)
ALSA ../alsa-kernel/usb/usbmixer.c:1209: [17] PU [Up Down Mode Select] ch = 1, val = 1/2
ALSA ../alsa-kernel/usb/usbmixer.c:1416: [11] SU [Capture Source] items = 3
ALSA ../alsa-kernel/usb/usbmixer.c:860: [12] FU [Capture Switch] ch = 1, val = 0/1/1
ALSA ../alsa-kernel/usb/usbmixer.c:334: cannot set ctl value: req = 0x4, wValue = 0x200, wIndex = 0xc00, type = 4, data = 0x40/0x0
ALSA ../alsa-kernel/usb/usbmixer.c:860: [12] FU [Capture Volume] ch = 1, val = -25600/0/128
ALSA ../alsa-kernel/usb/usbmixer.c:860: [18] FU [Master Playback Switch] ch = 1, val = 0/1/1
ALSA ../alsa-kernel/usb/usbmixer.c:334: cannot set ctl value: req = 0x4, wValue = 0x201, wIndex = 0x1200, type = 4, data = 0x40/0x0
ALSA ../alsa-kernel/usb/usbmixer.c:860: [18] FU [Master Playback Volume] ch = 6, val = -25600/0/128
ALSA ../alsa-kernel/usb/usbmixer.c:334: cannot set ctl value: req = 0x4, wValue = 0x200, wIndex = 0x1200, type = 4, data = 0x40/0x0
ALSA ../alsa-kernel/usb/usbmixer.c:860: [18] FU [Master Playback Volume] ch = 1, val = -25600/0/128
ALSA ../alsa-kernel/usb/usbmixer.c:860: [18] FU [Tone Control - Bass] ch = 1, val = -48/48/1
ALSA ../alsa-kernel/usb/usbmixer.c:860: [18] FU [Tone Control - Treble] ch = 1, val = -48/48/1
ALSA ../alsa-kernel/usb/usbmixer.c:860: [28] FU [Speaker Playback Switch] ch = 1, val = 0/1/1
ALSA ../alsa-kernel/usb/usbmixer.c:860: [22] FU [Digital Out Playback Switch] ch = 1, val = 0/1/1
ALSA ../alsa-kernel/usb/usbmixer.c:860: [23] FU [Digital Out1 Playback Switch] ch = 1, val = 0/1/1
ALSA ../alsa-kernel/usb/usbmixer.c:860: [25] FU [Digital Out2 Playback Switch] ch = 1, val = 0/1/1
ALSA ../alsa-kernel/usb/usbaudio.c:1025: cannot set format: format = S16_LE, rate = 44100, channels = 2
ALSA /usr/local/src/alsa-driver/alsa-kernel/core/oss/pcm_oss.c:540: snd_pcm_oss_prepare: SNDRV_PCM_IOCTL_PREPARE failed
ALSA ../alsa-kernel/usb/usbaudio.c:1025: cannot set format: format = S16_LE, rate = 44100, channels = 2
ALSA /usr/local/src/alsa-driver/alsa-kernel/core/oss/pcm_oss.c:540: snd_pcm_oss_prepare: SNDRV_PCM_IOCTL_PREPARE failed

--=-1hhixTiJL0Db4IopzZFF--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
