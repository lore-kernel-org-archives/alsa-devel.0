From: "=?utf-8?B?5YiY5Lyf5Liw?=" <liuwf@sanlogic.com>
Subject: microphone recording got lower or higher tune than
	standard - 2
Date: Fri, 27 Dec 2013 14:17:12 +0800
Message-ID: <tencent_5F3EF9AD7D16F6A75CEE7CB8@qq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg63.qq.com (smtpbg63.qq.com [103.7.29.150])
 by alsa0.perex.cz (Postfix) with SMTP id 6E2AD261A34
 for <alsa-devel@alsa-project.org>; Fri, 27 Dec 2013 07:17:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?utf-8?B?YWxzYS1kZXZlbA==?= <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

part two:

these are my /proc/asound/cardXXX:

ls  /proc/asound/card*
/proc/asound/cards

/proc/asound/card0:
id  pcm0c  pcm0p

----------------------------------------------------------------
ls /proc/asound/card0/pcm0c
info  oss  sub0

cat /proc/asound/card0/pcm0c/oss    #nothing

cat /proc/asound/card0/pcm0c/info
card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: CS42L52 PCM cs42l52-0
name:
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

ls /proc/asound/card0/pcm0c/sub0/
hw_params  info  status  sw_params

cat /proc/asound/card0/pcm0c/sub0/hw_params
closed

cat /proc/asound/card0/pcm0c/sub0/status
closed

cat /proc/asound/card0/pcm0c/sub0/sw_params
closed

cat /proc/asound/card0/pcm0c/sub0/info
card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: CS42L52 PCM cs42l52-0
name:
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

----------------------------------------------------------------
cat /proc/asound/card0/pcm0p/oss    #nothing

cat /proc/asound/card0/pcm0p/info
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: CS42L52 PCM cs42l52-0
name:
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

ls /proc/asound/card0/pcm0p/sub0/
hw_params  info  status  sw_params

cat /proc/asound/card0/pcm0p/sub0/hw_params
closed

cat /proc/asound/card0/pcm0p/sub0/status
closed

cat /proc/asound/card0/pcm0p/sub0/sw_params
closed

cat /proc/asound/card0/pcm0p/sub0/info
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: CS42L52 PCM cs42l52-0
name:
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1



I'd  like post the ouput informations coming from when Audio Tuninf Wizard  start and, ones when I selected the first option above in Audio Tuninf  Wizard before alsa-info as I think the things maybe necessarily needed also:

#run mumble in a terminal:

administrator@sdn:~$ mumble
QGtkStyle was unable to detect the current GTK+ theme.
PulseAudio: Connection failure: Connection refused
G15LCDEngineUnix: Unable to connect to G15Daemon.
CELT bitstream 8000000b from libcelt0.so.0.0.0
Locale is en_US
TextToSpeech: Failed to contact speech dispatcher.
Database SQLite: "3.7.9"
WARNING The program 'mumble' uses the Apple Bonjour compatibility layer of Avahi.
WARNING Please fix your application to use the native API of Avahi!
WARNING For more information see http://0pointer.de/avahi-compat?s=libdns_sd&e=mumble
Overlay: Listening on "/home/administrator/.MumbleOverlayPipe"
GlobalShortcutX: Unable to open any keyboard input devices under /dev/input, falling back to XInput
GlobalShortcutX: Using XInput 2.2
GlobalShortcutX: XInput 4:Virtual core XTEST pointer
GlobalShortcutX: XInput 5:Virtual core XTEST keyboard
GlobalShortcutX: XInput 9:key_input
GlobalShortcutX: XInput 10:aml_keypad
GlobalShortcutX: XInput 6:Logitech USB Optical Mouse
GlobalShortcutX: XInput 7:Logitech USB Keyboard
GlobalShortcutX: XInput 8:Logitech USB Keyboard
No systemtrayicon available
AudioInput: 40000 bits/s, 48000 hz, 480 sample CELT
ALSAAudioOutput: Initialized
ALSAAudioOutput: ALSA reports 10000 output channels. Clamping to 2.
ALSAAudioOutput: Actual buffer 48000 hz, 2 channel 3072 samples [512 per period]
ALSAAudioOutput: Initializing 2 channel, 48000 hz mixer
AudioOutput: Initialized 2 channel 48000 hz mixer
ALSAAudioInput: Initing audiocapture default.
ALSAAudioInput: Actual buffer 48000 hz, 1 channel 4096 samples [512 per period]
AudioInput: Initialized mixer for 1 channel 48000 hz mic and 0 channel 48000 hz echo
warning: The VAD has been replaced by a hack pending a complete rewrite

#when the first option is selected:

ALSAAudioInput: Releasing ALSA Mic.
ALSAAudioOutput: Destroyed
AudioInput: 40000 bits/s, 48000 hz, 480 sample CELT
ALSAAudioOutput: Initialized
ALSAAudioInput: Initing audiocapture default.
ALSAAudioInput: Actual buffer 48000 hz, 1 channel 4096 samples [512 per period]
AudioInput: Initialized mixer for 1 channel 48000 hz mic and 0 channel 48000 hz echo
ALSAAudioInput: Releasing ALSA Mic.
ALSAAudioOutput: ALSA reports 10000 output channels. Clamping to 2.
ALSAAudioOutput: Actual buffer 48000 hz, 2 channel 3072 samples [512 per period]
ALSAAudioOutput: Initializing 2 channel, 48000 hz mixer
AudioOutput: Initialized 2 channel 48000 hz mixer
ALSAAudioOutput: Destroyed
AudioInput: 40000 bits/s, 48000 hz, 480 sample CELT
ALSAAudioOutput: Initialized
ALSAAudioInput: Initing audiocapture default.
ALSAAudioInput: Actual buffer 48000 hz, 1 channel 4096 samples [512 per period]
AudioInput: Initialized mixer for 1 channel 48000 hz mic and 0 channel 48000 hz echo
ALSAAudioOutput: ALSA reports 10000 output channels. Clamping to 2.
ALSAAudioOutput: Actual buffer 48000 hz, 2 channel 3072 samples [512 per period]
ALSAAudioOutput: Initializing 2 channel, 48000 hz mixer
AudioOutput: Initialized 2 channel 48000 hz mixer
warning: The VAD has been replaced by a hack pending a complete rewrite
ALSAAudioInput: Releasing ALSA Mic.
AudioInput: 40000 bits/s, 48000 hz, 480 sample CELT
ALSAAudioInput: Initing audiocapture hw:CARD=AMLCS42L52,DEV=0.
ALSAAudioInput: Actual buffer 48000 hz, 1 channel 4096 samples [512 per period]
AudioInput: Initialized mixer for 1 channel 48000 hz mic and 0 channel 48000 hz echo
warning: The VAD has been replaced by a hack pending a complete rewrite



thanks a lot

Liuwf
