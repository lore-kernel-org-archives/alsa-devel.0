From: David Liontooth <liontooth@cogweb.net>
Subject: IEC958 volume and balance control
Date: Tue, 03 Aug 2004 14:40:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <410F87B6.6050407@cogweb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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


Greetings!

A week or so ago, Jason Fuchs discovered out how to make the headphone 
jack on the vpr
Matrix 2005a laptop work: you activate IEC958 and turn off the volume on 
IEC958 Playback
AC97-SPSA (http://www.goodfellow.net/VPRMatrixLinux/). The laptop also 
has a keyboard
switch for S/PDIF and this must be set to off.  It took the small group 
of people who use this
laptop nearly two years to figure this out. For my own part, I assumed 
the headphone jack
had some idiosyncratic arrangement that ALSA didn't support -- the 
vendor advertizes it
upsamples from 96 to 192 ("Sonopur"). However, it is now working great, 
with these
reservations:

 1. Most players and mixers cannot control the volume level of the 
headphone sound

I've tried kmix, alsamixer/alsamixergui, aumix/gtk-aumix, xine, beep, 
xmms, quark, you
name it. There is one honorable exception: alsaplayer. Its volume slider 
controls the
volume perfectly. So my first question:

 Q1: What is the component used in alsaplayer to control volume? Can I 
map this in some
     useful manner so that it can be accessed by other mixers / players?

 2. The players and mixers cannot control left/right balance

Here even alsaplayer fails -- its balance slider works like an inverse 
volume knob.

 Q2: Any way to control balance in IEC958?

 3. As far as I can tell all I'm getting is mono sound

Even though alsaplayer says it's stereo, I hear only mono. The plug 
looks like it's
working fine (though before the first reboot with the new stored values 
I had some
pretty significant distortion). Is there a setting I'm missing?

 Q3: Any reason stereo is not coming through?

Let me emphasize that the sound quality in the headphones is excellent, 
and I'm very
grateful for all the great work you guys have done on this project. It 
rocks bigtime.
Seriously.

Background information below. I don't know what if anything here is 
really a bug, so I'm
asking you guys first.

Cheers,
David


Hardware: 0000:00:06.0 Multimedia audio controller: ALi Corporation 
M5451 PCI AC-Link
Controller Audio Device (rev 02). The advertizing sheet for the laptop 
says "The
exclusive vpr Matrix Sonopur audio system uses 24/192 upsampling to 
provide vivid,
lifelike audiophile grade sound you can use with even the highest-end 
headphones and
external audio components". The vendor is Best Buy, a US electronics chain.

None of the Linux users were able to figure out how to get this working 
until recently
-- it was simply dead. However, by activating IEC958 and turning off the 
volume on
IEC958 Playback AC97-SPSA, sound comes through just great. I can't tell 
if it's really
upsampling or not, but the quality sounds better than from the built-in 
speakers.  Once
the values have been set correctly, I can use any player to play music 
to the
headphones, but most can't regulate volume and none get the balance control.

Software: I'm currently running the 2.6.6 kernel from Debian sid, so 
boot shows

 Starting ALSA (version 1.0.4rc2):
   ALSA appears to be compiled statically.
 Restoring ALSA mixer settings ... done.

alsa-base and alsa-headers are 1.0.5a-1 and alsa-utils 1.0.5-3. In the 
kernel I'm using
the modules snd snd_pcm_oss snd_mixer_oss snd-ali5451 snd_ac97_codec snd_pcm
snd_page_alloc snd_timer, which are loaded on boot.

I include the AC97 status and register dump below, along with PCM status.

AC97 status

:~# cat /proc/asound/card0/codec97#0/*
0-0/0: Analog Devices AD1981A

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 16-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 AMAP DSA=0 SPDIF VRA
Extended status  : SPCV SPDIF=3/4 SPDIF VRA
PCM front DAC    : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz

Register dump

AD18XX configuration
Unchained        : 0x1000,0x0000,0x0000
Chained          : 0x0000,0x0000,0x0000
0:00 = 0090
0:02 = 0505
0:04 = 0000
0:06 = 0000
0:08 = 0000
0:0a = 0000
0:0c = 8000
0:0e = 0040
0:10 = 0101
0:12 = 0000
0:14 = 0000
0:16 = 0808
0:18 = 1010
0:1a = 0101
0:1c = 0b0b
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 800f
0:28 = 0605
0:2a = 0405
0:2c = bb80
0:2e = 0000
0:30 = 0000
0:32 = bb80
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 2824
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 8080
0:62 = 0000
0:64 = 8000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0000
0:72 = 0000
0:74 = 1005
0:76 = 2010
0:78 = 0000
0:7a = 0000
0:7c = 4144
0:7e = 5372

PCM status

:~# cat /proc/asound/card0/pcm0p/sub0/*
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 2048
buffer_size: 16384
tick_time: 1000
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: ALI 5451
name: ALI 5451
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 32
subdevices_avail: 30
64
state: PREPARED
trigger_time: 1091533083.351869000
tstamp      : 1091534948.213148000
delay       : 0
avail       : 16384
avail_max   : 2825
-----
hw_ptr      : 0
appl_ptr    : 0
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 2048
xfer_align: 1
start_threshold: 2048
stop_threshold: 16384
silence_threshold: 0
silence_size: 0
boundary: 1073741824




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
