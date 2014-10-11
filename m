From: Tristan Chambers <tristan.chambers@gmail.com>
Subject: Echo Audio Echo 2 USB Interface
Date: Sat, 11 Oct 2014 13:32:27 -0400
Message-ID: <CABuEqK7VqOxFg8dBTwXoiKEqP-ZZPSZxwH5bapAP0uugio9qbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f172.google.com (mail-ig0-f172.google.com
 [209.85.213.172])
 by alsa0.perex.cz (Postfix) with ESMTP id E8180260626
 for <alsa-devel@alsa-project.org>; Sat, 11 Oct 2014 19:32:48 +0200 (CEST)
Received: by mail-ig0-f172.google.com with SMTP id r2so6283510igi.5
 for <alsa-devel@alsa-project.org>; Sat, 11 Oct 2014 10:32:48 -0700 (PDT)
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

I picked up an Echo Audio Echo 2 USB Interface. The product specs list
iPad support through camera connection kit, so I assume it is class
compliant. http://echoaudio.com/blogs/news/6454472-echo-digital-audio-introduces-the-echo-2-usb-audio-interface

However, on most systems when I plug the device in, it shows up in my
sound settings panel under the Input tab, but not under the Output
tab.

Recording works. I can successfully record with arecord -vv -fdat -D
"plughw:CARD=Audio,DEV=0" echo.wav. I also can increase the sample
rate by changing the flags. I verified that the sample rate actually
increases by recording a 50khz test tone into the input and examining
the wave form in an editor. It's there! So this is very promising.
(anyone know of a test to verify bit depth? I want to make sure it's
actually recording at 24bits.)

Playback however, is nothing but trouble. Like I said, the output
device doesn't show up in the Output tab in my sound settings
(gnome/pulse). However, when I list devices and available PCMs with
aplay -l and aplay -L the device shows up on the lists. See specimens
#1, #2, and #3. When I try to play though I get about a 1/4 second of
audio and then nothing, and subsequent attempts to play sound output
nothing. The device then must be unplugged and plugged back in. I'm
playing with the command aplay -vv foo.wav
--device="plughw:CARD=Audio,DEV=0". See output screen on specimen #4.

I installed the latest kernel and had the exact same phenomenon. See
specimen #5.

To move forward here. What kind of debugging tools should I use to
help figure out where the problem is? Any suggestions you have to get
it working?

To be sure that the device is in good working order I hooked it up to
an OSX machine running 10.6.8. Everything works great with no
additional drivers installed, or special configurations.


Tanks for your help,

Tristan


--------------- #1 --------------------

tristan@ilya:~$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC259 Analog [ALC259 Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Audio [Echo 2 Audio], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

tristan@ilya:~$ aplay -L
default
    Playback/recording through the PulseAudio sound server
sysdefault:CARD=PCH
    HDA Intel PCH, ALC259 Analog
    Default Audio Device
front:CARD=PCH,DEV=0
    HDA Intel PCH, ALC259 Analog
    Front speakers
surround40:CARD=PCH,DEV=0
    HDA Intel PCH, ALC259 Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=PCH,DEV=0
    HDA Intel PCH, ALC259 Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=PCH,DEV=0
    HDA Intel PCH, ALC259 Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=PCH,DEV=0
    HDA Intel PCH, ALC259 Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=PCH,DEV=0
    HDA Intel PCH, ALC259 Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
hdmi:CARD=PCH,DEV=0
    HDA Intel PCH, HDMI 0
    HDMI Audio Output
dmix:CARD=PCH,DEV=0
    HDA Intel PCH, ALC259 Analog
    Direct sample mixing device
dmix:CARD=PCH,DEV=3
    HDA Intel PCH, HDMI 0
    Direct sample mixing device
dsnoop:CARD=PCH,DEV=0
    HDA Intel PCH, ALC259 Analog
    Direct sample snooping device
dsnoop:CARD=PCH,DEV=3
    HDA Intel PCH, HDMI 0
    Direct sample snooping device
hw:CARD=PCH,DEV=0
    HDA Intel PCH, ALC259 Analog
    Direct hardware device without any conversions
hw:CARD=PCH,DEV=3
    HDA Intel PCH, HDMI 0
    Direct hardware device without any conversions
plughw:CARD=PCH,DEV=0
    HDA Intel PCH, ALC259 Analog
    Hardware device with all software conversions
plughw:CARD=PCH,DEV=3
    HDA Intel PCH, HDMI 0
    Hardware device with all software conversions
sysdefault:CARD=Audio
    Echo 2 Audio, USB Audio
    Default Audio Device
front:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    Front speakers
surround40:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    4.0 Surround output to Front and Rear speakers
surround41:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    IEC958 (S/PDIF) Digital Audio Output
dmix:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    Direct sample mixing device
dsnoop:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    Direct sample snooping device
hw:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    Direct hardware device without any conversions
plughw:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    Hardware device with all software conversions


--------------- #2 --------------------

tristan@ilya:~$ arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC259 Analog [ALC259 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Audio [Echo 2 Audio], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

tristan@ilya:~$ arecord -L
default
    Playback/recording through the PulseAudio sound server
sysdefault:CARD=PCH
    HDA Intel PCH, ALC259 Analog
    Default Audio Device
front:CARD=PCH,DEV=0
    HDA Intel PCH, ALC259 Analog
    Front speakers
surround40:CARD=PCH,DEV=0
    HDA Intel PCH, ALC259 Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=PCH,DEV=0
    HDA Intel PCH, ALC259 Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=PCH,DEV=0
    HDA Intel PCH, ALC259 Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=PCH,DEV=0
    HDA Intel PCH, ALC259 Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=PCH,DEV=0
    HDA Intel PCH, ALC259 Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
dmix:CARD=PCH,DEV=0
    HDA Intel PCH, ALC259 Analog
    Direct sample mixing device
dsnoop:CARD=PCH,DEV=0
    HDA Intel PCH, ALC259 Analog
    Direct sample snooping device
hw:CARD=PCH,DEV=0
    HDA Intel PCH, ALC259 Analog
    Direct hardware device without any conversions
plughw:CARD=PCH,DEV=0
    HDA Intel PCH, ALC259 Analog
    Hardware device with all software conversions
sysdefault:CARD=Audio
    Echo 2 Audio, USB Audio
    Default Audio Device
front:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    Front speakers
surround40:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    4.0 Surround output to Front and Rear speakers
surround41:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    IEC958 (S/PDIF) Digital Audio Output
dmix:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    Direct sample mixing device
dsnoop:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    Direct sample snooping device
hw:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    Direct hardware device without any conversions
plughw:CARD=Audio,DEV=0
    Echo 2 Audio, USB Audio
    Hardware device with all software conversions

---------------- #3 -------------------

tristan@ilya:/proc/asound/card1$ cat stream0
ECHO Digital Audio Echo 2 Audio at usb-0000:00:14.0-1, high speed : USB Audio

Playback:
  Status: Stop
  Interface 1
    Altset 1
    Format: S32_LE
    Channels: 4
    Endpoint: 1 OUT (ASYNC)
    Rates: 44100, 48000, 88200, 96000, 176400, 192000
    Data packet interval: 125 us

Capture:
  Status: Stop
  Interface 2
    Altset 1
    Format: S32_LE
    Channels: 2
    Endpoint: 2 IN (ASYNC)
    Rates: 44100, 48000, 88200, 96000, 176400, 192000
    Data packet interval: 125 us

------------------- #4 ------------------

aplay -vv foo.wav --device="plughw:CARD=Audio,DEV=0"

Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 4
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 24000
  period_size  : 6000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 6000
  period_event : 0
  start_threshold  : 24000
  stop_threshold   : 24000
  silence_threshold: 0
  silence_size : 0
  boundary     : 1572864000
  appl_ptr     : 0
  hw_ptr       : 0
############+                                      | 23%


------------------- #5 ------------------

tristan@ilya:~$ uname -a
Linux ilya 3.17.0-031700-lowlatency #201410060605 SMP PREEMPT Mon Oct
6 11:06:16 UTC 2014 i686 i686 i686 GNU/Linux
tristan@ilya:~$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version k3.17.0-031700-lowlatency.
