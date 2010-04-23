From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: Re: "Resource temporarily unavailable" while reading
 although poll returns POLLIN event
Date: Fri, 23 Apr 2010 13:16:31 +0200
Message-ID: <4BD1818F.7070902@gmail.com>
References: <4BCEE140.5060704@gmail.com>
	<4BCF24AC.3000301@gmail.com>	<y2n4f3252891004212128x22c1be90pd22a4fa58a31a57c@mail.gmail.com>	<4BD029CD.6030200@gmail.com>
	<o2v4f3252891004230045v905bc0d3gc23c6de490779021@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from keymachine.tbmn.org (mail.tbmn.org [87.118.84.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 137F224577
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Apr 2010 13:16:34 +0200 (CEST)
In-Reply-To: <o2v4f3252891004230045v905bc0d3gc23c6de490779021@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Raymond Yau wrote:
> you output did not show the values of buffer size
> [...]
> 00d0    fd ff fc ff 01 00 04 00 02 00 06 00 07 00 06 00
> 00e0    05 00 03 00 02 00 06 00 0a 00 09 00 02 00 fd ff
> 00f0    fb ff fa ff fd ff ff ff 01 00 ff ff f9 ff f5 ff
> 0100    f3 ff f7 ff fb ff f7 ff f6 ff fc ff fb ff fd ff
> 0110    fd ff f6 ff f7 ff fc ff f9 ff fb ff fc ff f5 ff
> 0120    f6 ff f7 ff f3 ff f6 ff f8 ff f7 ff f6 ff f9 ff
> 0130    fc ff f6 ff f4 ff f6 ff f4 ff fa ff f8 ff f2 ff
> 
> demangled poll:  on playback device
> demangled poll:  on capture device
> demangled poll: POLLOUT  on playback device
> wrote 160 frames
> demangled poll: POLLIN  on capture device
> could not read from capture device: Resource temporarily unavailable


thanks for posting the full output.
I added a call to snd_pcm_avail_update() in the code which shows how
many frames are available after poll() returns.

As you can see in the output below, although avail_min is set to 160
frames, the POLLIN event on the capture PCM is returned after only 11
frames are available for reading:

------------------------------------------------------------------------------
snd_pcm_avail_update(playback): 0
demangled poll:  on playback device
snd_pcm_avail_update(capture): 171
demangled poll: POLLIN  on capture device
read 160 frames
hexdump(): 320 bytes
0000	fc ff fc ff fc ff fc ff fc ff fc ff fc ff fe ff
0010	fc ff fd ff fb ff fc ff fc ff fc ff fd ff fc ff
0020	fc ff fc ff fd ff fc ff fc ff fc ff fd ff fd ff
0030	fc ff fc ff fc ff fc ff fc ff fb ff fc ff fc ff
0040	fd ff fc ff fc ff fc ff fc ff fc ff fd ff fc ff
0050	fd ff fc ff fc ff fc ff fd ff fc ff fc ff fa ff
0060	fc ff fc ff fc ff fb ff fc ff fd ff fc ff fd ff
0070	fc ff fc ff fd ff fc ff fc ff fc ff fc ff fc ff
0080	fb ff fd ff fc ff fc ff fc ff fc ff fc ff fc ff
0090	fb ff fd ff fc ff fd ff fb ff fd ff fc ff fc ff
00a0	fd ff fd ff fc ff fc ff fc ff fc ff fc ff fc ff
00b0	fc ff fc ff fb ff fc ff fc ff fc ff fc ff fd ff
00c0	fc ff fc ff fd ff fc ff fc ff fc ff fc ff fc ff
00d0	fc ff fc ff fc ff fc ff fc ff fd ff fc ff fc ff
00e0	fd ff fc ff fc ff fc ff fd ff fd ff fc ff fc ff
00f0	fc ff fb ff fc ff fd ff fd ff fc ff fc ff fc ff
0100	fc ff fc ff fc ff fc ff fc ff fc ff fc ff fc ff
0110	fc ff fc ff fc ff fc ff fc ff fc ff fc ff fc ff
0120	fc ff fc ff fc ff fc ff fd ff fc ff fc ff fc ff
0130	fc ff fc ff fc ff fc ff fc ff fc ff fc ff fc ff

snd_pcm_avail_update(playback): 0
demangled poll:  on playback device
snd_pcm_avail_update(capture): 11
demangled poll: POLLIN  on capture device
could not read from capture device: Resource temporarily unavailable
ALSA <-> PulseAudio PCM I/O Plugin
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 640
  period_size  : 160
  period_time  : 20000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 160
  period_event : 0
  start_threshold  : 160
  stop_threshold   : 320
  silence_threshold: 0
  silence_size : 0
  boundary     : 5764607523034234880
------------------------------------------------------------------------------

In one of your previous posts you also said that the pulseaudio log
would be helpful.
You can see it below.
In order to keep it brief, I included only the logs between pulseaudio
startup and the end of the audio application.

------------------------------------------------------------------------------
$ pulseaudio -vvv
I: caps.c: Limited capabilities successfully to CAP_SYS_NICE.
I: caps.c: Dropping root privileges.
I: caps.c: Limited capabilities successfully to CAP_SYS_NICE.
D: main.c: Started as real root: no, suid root: yes
I: main.c: We're in the group 'pulse-rt', allowing high-priority scheduling.
I: main.c: setrlimit(RLIMIT_NICE, (31, 31)) failed: Operation not permitted
I: main.c: setrlimit(RLIMIT_RTPRIO, (9, 9)) failed: Operation not permitted
I: core-util.c: Successfully gained nice level -11.
D: main.c: Can realtime: yes, can high-priority: yes
I: main.c: Giving up CAP_NICE
D: main.c: Can realtime: no, can high-priority: no
I: main.c: This is PulseAudio 0.9.14
D: main.c: Compilation host: x86_64-pc-linux-gnu
D: main.c: Compilation CFLAGS: -g -O2 -g -Wall -O3 -Wall -W -Wextra
-pedantic -pipe -Wno-long-long -Wvla -Wno-overlength-strings
-Wconversion -Wundef -Wformat -Wlogical-op -Wpacked -Wformat-security
-Wmissing-include-dirs -Wformat-nonliteral -Wold-style-definition
-Wdeclaration-after-statement -Wfloat-equal -Wmissing-declarations
-Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls
-Wmissing-noreturn -Wshadow -Wendif-labels -Wpointer-arith -Wcast-align
-Wwrite-strings -Wno-unused-parameter -ffast-math
D: main.c: Running on host: Linux x86_64 2.6.28-18-generic #59-Ubuntu
SMP Thu Jan 28 01:40:19 UTC 2010
I: main.c: Page size is 4096 bytes
D: main.c: Compiled with Valgrind support: no
D: main.c: Running in valgrind mode: no
D: main.c: Optimized build: yes
I: main.c: Machine ID is d05a505180ca4c5382d620fc498da356.
I: main.c: Using runtime directory
/home/mne/.pulse/d05a505180ca4c5382d620fc498da356:runtime.
I: main.c: Using state directory /home/mne/.pulse.
I: main.c: Running in system mode: no
I: main.c: Fresh high-resolution timers available! Bon appetit!
D: memblock.c: Using shared memory pool with 1024 slots of size 64.0 KiB
each, total size is 64.0 MiB, maximum usable slot size is 65472
D: cli-command.c: Checking for existance of
'/usr/lib/pulse-0.9/modules/module-gconf.so': success
D: module-gconf.c: Loading module 'module-combine' with args '' due to
GConf configuration.
I: sink.c: Created sink 0 "combined" with sample spec s16le 2ch 44100Hz
and channel map front-left,front-right
I: source.c: Created source 0 "combined.monitor" with sample spec s16le
2ch 44100Hz and channel map front-left,front-right
D: module-combine.c: Thread starting up
D: rtpoll.c: Acquired POSIX realtime signal SIGRTMIN+29
I: module.c: Loaded "module-combine" (index: #0; argument: "").
I: module.c: Loaded "module-gconf" (index: #1; argument: "").
D: module-suspend-on-idle.c: Sink combined becomes idle.
D: module-suspend-on-idle.c: Source combined.monitor becomes idle.
I: module.c: Loaded "module-suspend-on-idle" (index: #2; argument: "").
I: module-device-restore.c: Sucessfully opened database file
'/home/mne/.pulse/d05a505180ca4c5382d620fc498da356:device-volumes.x86_64-pc-linux-gnu.gdbm'.
I: module.c: Loaded "module-device-restore" (index: #3; argument: "").
I: module-stream-restore.c: Sucessfully opened database file
'/home/mne/.pulse/d05a505180ca4c5382d620fc498da356:stream-volumes.x86_64-pc-linux-gnu.gdbm'.
I: module.c: Loaded "module-stream-restore" (index: #4; argument: "").
D: cli-command.c: Checking for existance of
'/usr/lib/pulse-0.9/modules/module-hal-detect.so': success
I: module-hal-detect.c: Trying capability alsa
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/computer_alsa_timer
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/computer_alsa_sequencer
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_playback_4
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_midi_3
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_playback_2
D: module-hal-detect.c: Loading module-alsa-source with arguments
'device_id=0
source_name=alsa_input.pci_1102_4_sound_card_0_alsa_capture_0 tsched=0'
D: alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
I: module-alsa-source.c: Successfully opened device front:0.
I: module-alsa-source.c: Successfully enabled mmap() mode.
I: (alsa-lib)control.c: Invalid CTL front:0
I: alsa-util.c: Unable to attach to mixer front:0: No such file or directory
I: alsa-util.c: Successfully attached to mixer 'hw:0'
I: alsa-util.c: Cannot find mixer control "Capture" or mixer control is
no combination of switch/volume.
I: alsa-util.c: Using mixer control "Mic".
I: module-device-restore.c: Restoring volume for source
alsa_input.pci_1102_4_sound_card_0_alsa_capture_0.
I: module-device-restore.c: Restoring mute state for source
alsa_input.pci_1102_4_sound_card_0_alsa_capture_0.
I: source.c: Created source 1
"alsa_input.pci_1102_4_sound_card_0_alsa_capture_0" with sample spec
s16le 2ch 44100Hz and channel map front-left,front-right
I: module-alsa-source.c: Using 2 fragments of size 7168 bytes, buffer
time is 81.27ms
D: module-alsa-source.c: hwbuf_unused=0
D: module-alsa-source.c: setting avail_min=1
I: module-alsa-source.c: Volume ranges from 0 to 31.
I: module-alsa-source.c: Volume ranges from -34.50 dB to 12.00 dB.
I: alsa-util.c: ALSA device lacks independant volume controls for each
channel.
I: module-alsa-source.c: Using hardware volume control. Hardware dB
scale supported.
D: alsa-util.c: snd_pcm_dump():
D: alsa-util.c: Hooks PCM
D: alsa-util.c: Its setup is:
D: alsa-util.c:   stream       : CAPTURE
D: alsa-util.c:   access       : MMAP_INTERLEAVED
D: alsa-util.c:   format       : S16_LE
D: alsa-util.c:   subformat    : STD
D: alsa-util.c:   channels     : 2
D: alsa-util.c:   rate         : 44100
D: alsa-util.c:   exact rate   : 44100 (44100/1)
D: alsa-util.c:   msbits       : 16
D: alsa-util.c:   buffer_size  : 3584
D: alsa-util.c:   period_size  : 1792
D: alsa-util.c:   period_time  : 40634
D: alsa-util.c:   tstamp_mode  : ENABLE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 1792
D: alsa-util.c:   period_event : 0
D: alsa-util.c:   start_threshold  : -1
D: alsa-util.c:   stop_threshold   : 8070450532247928832
D: alsa-util.c:   silence_threshold: 0
D: alsa-util.c:   silence_size : 0
D: alsa-util.c:   boundary     : 8070450532247928832
D: alsa-util.c: Slave: Hardware PCM card 0 'Audigy 2 [SB0240]' device 0
subdevice 0
D: alsa-util.c: Its setup is:
D: alsa-util.c:   stream       : CAPTURE
D: alsa-util.c:   access       : MMAP_INTERLEAVED
D: alsa-util.c:   format       : S16_LE
D: alsa-util.c:   subformat    : STD
D: alsa-util.c:   channels     : 2
D: alsa-util.c:   rate         : 44100
D: alsa-util.c:   exact rate   : 44100 (44100/1)
D: alsa-util.c:   msbits       : 16
D: alsa-util.c:   buffer_size  : 3584
D: alsa-util.c:   period_size  : 1792
D: alsa-util.c:   period_time  : 40634
D: alsa-util.c:   tstamp_mode  : ENABLE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 1792
D: alsa-util.c:   period_event : 0
D: alsa-util.c:   start_threshold  : -1
D: alsa-util.c:   stop_threshold   : 807045053224
D: module-alsa-source.c: Thread starting up
D: module-alsa-source.c: Requested volume: 0: 100% 1: 100%
D: rtpoll.c: Acquired POSIX realtime signal SIGRTMIN+28
D: module-alsa-source.c: Got hardware volume: 0: 100% 1: 100%
D: module-alsa-source.c: Calculated software volume: 0: 100% 1: 100%
D: module-suspend-on-idle.c: Source
alsa_input.pci_1102_4_sound_card_0_alsa_capture_0 becomes idle.
I: module.c: Loaded "module-alsa-source" (index: #5; argument:
"device_id=0
source_name=alsa_input.pci_1102_4_sound_card_0_alsa_capture_0 tsched=0").
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_capture_4
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_playback_3
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_capture_2
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_midi_2
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_capture_1
D: module-hal-detect.c: Loading module-alsa-sink with arguments
'device_id=0
sink_name=alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 tsched=0'
D: alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying front:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:front:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:front:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: alsa-util.c: PCM device plug:front:0 refused our hw parameters:
Device or resource busy
D: alsa-util.c: Trying surround40:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying surround40:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:surround40:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:surround40:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: alsa-util.c: PCM device plug:surround40:0 refused our hw parameters:
Device or resource busy
D: alsa-util.c: Trying surround41:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying surround41:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:surround41:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:surround41:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: alsa-util.c: PCM device plug:surround41:0 refused our hw parameters:
Device or resource busy
D: alsa-util.c: Trying surround50:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying surround50:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:surround50:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:surround50:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: alsa-util.c: PCM device plug:surround50:0 refused our hw parameters:
Device or resource busy
D: alsa-util.c: Trying surround51:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying surround51:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:surround51:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:surround51:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: alsa-util.c: PCM device plug:surround51:0 refused our hw parameters:
Device or resource busy
D: alsa-util.c: Trying surround71:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying surround71:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:surround71:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:surround71:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: alsa-util.c: PCM device plug:surround71:0 refused our hw parameters:
Device or resource busy
D: alsa-util.c: Trying hw:0 as last resort...
D: alsa-util.c: Trying hw:0 with SND_PCM_NO_AUTO_FORMAT ...
I: module-alsa-sink.c: Successfully opened device hw:0.
I: module-alsa-sink.c: Successfully enabled mmap() mode.
I: alsa-util.c: Successfully attached to mixer 'hw:0'
I: alsa-util.c: Cannot find mixer control "Master" or mixer control is
no combination of switch/volume.
W: alsa-util.c: Cannot find fallback mixer control "PCM" or mixer
control is no combination of switch/volume.
I: alsa-util.c: Using mixer control "PCM".
I: module-device-restore.c: Restoring volume for sink
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0.
I: module-device-restore.c: Restoring mute state for sink
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0.
I: sink.c: Created sink 1
"alsa_output.pci_1102_4_sound_card_0_alsa_playback_0" with sample spec
s16le 2ch 44100Hz and channel map front-left,front-right
I: module-device-restore.c: Restoring volume for source
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0.monitor.
I: module-device-restore.c: Restoring mute state for source
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0.monitor.
I: source.c: Created source 2
"alsa_output.pci_1102_4_sound_card_0_alsa_playback_0.monitor" with
sample spec s16le 2ch 44100Hz and channel map front-left,front-right
I: module-alsa-sink.c: Using 8 fragments of size 1764 bytes, buffer time
is 80.00ms
D: module-alsa-sink.c: hwbuf_unused=0
D: module-alsa-sink.c: setting avail_min=1
I: module-alsa-sink.c: Volume ranges from 0 to 100.
I: module-alsa-sink.c: Volume ranges from -40.00 dB to 0.00 dB.
I: alsa-util.c: ALSA device lacks independant volume controls for each
channel.
I: module-alsa-sink.c: Using hardware volume control. Hardware dB scale
supported.
I: module-alsa-sink.c: Using software mute control.
D: alsa-util.c: snd_pcm_dump():
D: alsa-util.c: Hardware PCM card 0 'Audigy 2 [SB0240]' device 0 subdevice 0
D: alsa-util.c: Its setup is:
D: alsa-util.c:   stream       : PLAYBACK
D: alsa-util.c:   access       : MMAP_INTERLEAVED
D: alsa-util.c:   format       : S16_LE
D: alsa-util.c:   subformat    : STD
D: alsa-util.c:   channels     : 2
D: alsa-util.c:   rate         : 44100
D: alsa-util.c:   exact rate   : 44100 (44100/1)
D: alsa-util.c:   msbits       : 16
D: alsa-util.c:   buffer_size  : 3528
D: alsa-util.c:   period_size  : 441
D: alsa-util.c:   period_time  : 10000
D: alsa-util.c:   tstamp_mode  : ENABLE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 441
D: alsa-util.c:   period_event : 0
D: alsa-util.c:   start_threshold  : -1
D: alsa-util.c:   stop_threshold   : 7944349742681554944
D: alsa-util.c:   silence_threshold: 0
D: alsa-util.c:   silence_size : 0
D: alsa-util.c:   boundary     : 7944349742681554944
D: module-alsa-sink.c: Thread starting up
D: module-alsa-sink.c: Requested volume: 0:  77% 1:  77%
D: rtpoll.c: Acquired POSIX realtime signal SIGRTMIN+27
D: module-alsa-sink.c: Got hardware volume: 0:  77% 1:  77%
D: module-alsa-sink.c: Calculated software volume: 0: 100% 1: 100%
I: module-alsa-sink.c: Starting playback.
D: module-suspend-on-idle.c: Source
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0.monitor becomes idle.
D: module-suspend-on-idle.c: Sink
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 becomes idle.
I: module-combine.c: Configuring new sink:
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0
D: memblockq.c: memblockq requested: maxlength=16777216,
tlength=16777216, base=4, prebuf=1, minreq=0 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=16777216,
tlength=16777216, base=4, prebuf=4, minreq=4 maxrewind=0
I: module-stream-restore.c: Not restore device for stream
sink-input-by-media-role:filter, because already set.
I: module-stream-restore.c: Restoring volume for sink input
sink-input-by-media-role:filter.
I: module-stream-restore.c: Restoring mute state for sink input
sink-input-by-media-role:filter.
D: module-suspend-on-idle.c: Sink
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 becomes busy.
I: resampler.c: Using resampler 'trivial'
I: resampler.c: Using s16le as working format.
D: memblockq.c: memblockq requested: maxlength=33554432, tlength=0,
base=4, prebuf=0, minreq=1 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=33554432,
tlength=33554432, base=4, prebuf=0, minreq=4 maxrewind=0
I: sink-input.c: Created input 0 "Simultaneous output on Audigy 2
[SB0240] - ADC Capture/Standard PCM Playback" on
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 with sample spec
s16le 2ch 44100Hz and channel map front-left,front-right
D: module-alsa-sink.c: hwbuf_unused=0
D: module-alsa-sink.c: setting avail_min=1
I: module.c: Loaded "module-alsa-sink" (index: #6; argument:
"device_id=0
sink_name=alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 tsched=0").
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_midi_1
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_midi_0
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_hw_specific_2
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_hw_specific_0
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_control__1
I: module-hal-detect.c: Loaded 2 modules.
I: module.c: Loaded "module-hal-detect" (index: #7; argument: "tsched=0").
D: cli-command.c: Checking for existance of
'/usr/lib/pulse-0.9/modules/module-esound-protocol-unix.so': success
I: module.c: Loaded "module-esound-protocol-unix" (index: #8; argument: "").
I: module.c: Loaded "module-native-protocol-unix" (index: #9; argument: "").
I: module-default-device-restore.c: Restored default sink
'alsa_output.pci_1102_4_sound_card_0_alsa_playback_0'.
D: core-subscribe.c: Dropped redundant event due to change event.
I: module-default-device-restore.c: Restored default source
'alsa_input.pci_1102_4_sound_card_0_alsa_capture_0'.
I: module.c: Loaded "module-default-device-restore" (index: #10;
argument: "").
I: module.c: Loaded "module-rescue-streams" (index: #11; argument: "").
I: module.c: Loaded "module-always-sink" (index: #12; argument: "").
I: client.c: Created 0 "ConsoleKit Session
/org/freedesktop/ConsoleKit/Session3"
D: module-console-kit.c: Added new session
/org/freedesktop/ConsoleKit/Session3
I: module.c: Loaded "module-console-kit" (index: #13; argument: "").
I: module.c: Loaded "module-position-event-sounds" (index: #14;
argument: "").
I: main.c: Daemon startup complete.
D: module-hal-detect.c: dbus: interface=org.freedesktop.DBus,
path=/org/freedesktop/DBus, member=NameAcquired
D: module-console-kit.c: dbus: interface=org.freedesktop.DBus,
path=/org/freedesktop/DBus, member=NameAcquired
D: module-hal-detect.c: dbus: interface=org.freedesktop.ConsoleKit.Seat,
path=/org/freedesktop/ConsoleKit/Seat1, member=SessionAdded
D: module-console-kit.c: dbus:
interface=org.freedesktop.ConsoleKit.Seat,
path=/org/freedesktop/ConsoleKit/Seat1, member=SessionAdded
D: module-hal-detect.c: dbus: interface=org.freedesktop.ConsoleKit.Seat,
path=/org/freedesktop/ConsoleKit/Seat1, member=SessionRemoved
D: module-console-kit.c: dbus:
interface=org.freedesktop.ConsoleKit.Seat,
path=/org/freedesktop/ConsoleKit/Seat1, member=SessionRemoved
^CI: main.c: Got signal SIGINT.
I: main.c: Exiting.
I: main.c: Daemon shutdown initiated.
I: module.c: Unloading "module-combine" (index: #0).
D: module-alsa-sink.c: hwbuf_unused=0
D: module-alsa-sink.c: setting avail_min=1
D: module-suspend-on-idle.c: Sink
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 becomes idle.
D: module-suspend-on-idle.c: Sink
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 becomes idle.
I: sink-input.c: Freeing input 0 "Simultaneous output on Audigy 2
[SB0240] - ADC Capture/Standard PCM Playback"
D: module-rescue-streams.c: No sink inputs to move away.
D: module-rescue-streams.c: No source outputs to move away.
D: core-subscribe.c: Dropped redundant event due to remove event.
D: core-subscribe.c: Dropped redundant event due to remove event.
D: module-combine.c: Thread shutting down
I: sink.c: Freeing sink 0 "combined"
I: source.c: Freeing source 0 "combined.monitor"
I: module.c: Unloaded "module-combine" (index: #0).
I: module.c: Unloading "module-gconf" (index: #1).
D: module-gconf.c: Unloading module #0
I: module.c: Unloaded "module-gconf" (index: #1).
I: module.c: Unloading "module-suspend-on-idle" (index: #2).
I: module.c: Unloaded "module-suspend-on-idle" (index: #2).
I: module.c: Unloading "module-device-restore" (index: #3).
I: module.c: Unloaded "module-device-restore" (index: #3).
I: module.c: Unloading "module-stream-restore" (index: #4).
I: module.c: Unloaded "module-stream-restore" (index: #4).
I: module.c: Unloading "module-alsa-source" (index: #5).
D: module-rescue-streams.c: No source outputs to move away.
D: module-alsa-source.c: Thread shutting down
I: source.c: Freeing source 1
"alsa_input.pci_1102_4_sound_card_0_alsa_capture_0"
I: module.c: Unloaded "module-alsa-source" (index: #5).
I: module.c: Unloading "module-alsa-sink" (index: #6).
D: module-always-sink.c: Autoloading null-sink as no other sinks detected.
I: sink.c: Created sink 2 "auto_null" with sample spec s16le 2ch 44100Hz
and channel map front-left,front-right
I: source.c: Created source 3 "auto_null.monitor" with sample spec s16le
2ch 44100Hz and channel map front-left,front-right
D: module-null-sink.c: Thread starting up
D: rtpoll.c: Acquired POSIX realtime signal SIGRTMIN+29
I: module.c: Loaded "module-null-sink" (index: #15; argument:
"sink_name=auto_null").
D: module-rescue-streams.c: No sink inputs to move away.
D: module-rescue-streams.c: No source outputs to move away.
D: module-alsa-sink.c: Thread shutting down
I: sink.c: Freeing sink 1
"alsa_output.pci_1102_4_sound_card_0_alsa_playback_0"
I: source.c: Freeing source 2
"alsa_output.pci_1102_4_sound_card_0_alsa_playback_0.monitor"
I: module.c: Unloaded "module-alsa-sink" (index: #6).
I: module.c: Unloading "module-hal-detect" (index: #7).
I: module.c: Unloaded "module-hal-detect" (index: #7).
I: module.c: Unloading "module-esound-protocol-unix" (index: #8).
I: module.c: Unloaded "module-esound-protocol-unix" (index: #8).
I: module.c: Unloading "module-native-protocol-unix" (index: #9).
I: module.c: Unloaded "module-native-protocol-unix" (index: #9).
I: module.c: Unloading "module-default-device-restore" (index: #10).
I: module.c: Unloaded "module-default-device-restore" (index: #10).
I: module.c: Unloading "module-rescue-streams" (index: #11).
I: module.c: Unloaded "module-rescue-streams" (index: #11).
I: module.c: Unloading "module-always-sink" (index: #12).
I: module.c: Unloaded "module-always-sink" (index: #12).
I: module.c: Unloading "module-console-kit" (index: #13).
D: module-console-kit.c: Removing session
/org/freedesktop/ConsoleKit/Session3
I: client.c: Freed 0 "ConsoleKit Session
/org/freedesktop/ConsoleKit/Session3"
I: module.c: Unloaded "module-console-kit" (index: #13).
I: module.c: Unloading "module-position-event-sounds" (index: #14).
I: module.c: Unloaded "module-position-event-sounds" (index: #14).
I: module.c: Unloading "module-null-sink" (index: #15).
D: core-subscribe.c: Dropped redundant event due to remove event.
D: core-subscribe.c: Dropped redundant event due to remove event.
D: module-null-sink.c: Thread shutting down
I: sink.c: Freeing sink 2 "auto_null"
I: source.c: Freeing source 3 "auto_null.monitor"
I: module.c: Unloaded "module-null-sink" (index: #15).
D: core-subscribe.c: Dropped redundant event due to remove event.
I: main.c: Daemon terminated.
mne@nanoflex:~$ pulseaudio -vvv
I: caps.c: Limited capabilities successfully to CAP_SYS_NICE.
I: caps.c: Dropping root privileges.
I: caps.c: Limited capabilities successfully to CAP_SYS_NICE.
D: main.c: Started as real root: no, suid root: yes
I: main.c: We're in the group 'pulse-rt', allowing high-priority scheduling.
I: main.c: setrlimit(RLIMIT_NICE, (31, 31)) failed: Operation not permitted
I: main.c: setrlimit(RLIMIT_RTPRIO, (9, 9)) failed: Operation not permitted
I: core-util.c: Successfully gained nice level -11.
D: main.c: Can realtime: yes, can high-priority: yes
I: main.c: Giving up CAP_NICE
D: main.c: Can realtime: no, can high-priority: no
I: main.c: This is PulseAudio 0.9.14
D: main.c: Compilation host: x86_64-pc-linux-gnu
D: main.c: Compilation CFLAGS: -g -O2 -g -Wall -O3 -Wall -W -Wextra
-pedantic -pipe -Wno-long-long -Wvla -Wno-overlength-strings
-Wconversion -Wundef -Wformat -Wlogical-op -Wpacked -Wformat-security
-Wmissing-include-dirs -Wformat-nonliteral -Wold-style-definition
-Wdeclaration-after-statement -Wfloat-equal -Wmissing-declarations
-Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls
-Wmissing-noreturn -Wshadow -Wendif-labels -Wpointer-arith -Wcast-align
-Wwrite-strings -Wno-unused-parameter -ffast-math
D: main.c: Running on host: Linux x86_64 2.6.28-18-generic #59-Ubuntu
SMP Thu Jan 28 01:40:19 UTC 2010
I: main.c: Page size is 4096 bytes
D: main.c: Compiled with Valgrind support: no
D: main.c: Running in valgrind mode: no
D: main.c: Optimized build: yes
I: main.c: Machine ID is d05a505180ca4c5382d620fc498da356.
I: main.c: Using runtime directory
/home/mne/.pulse/d05a505180ca4c5382d620fc498da356:runtime.
I: main.c: Using state directory /home/mne/.pulse.
I: main.c: Running in system mode: no
I: main.c: Fresh high-resolution timers available! Bon appetit!
D: memblock.c: Using shared memory pool with 1024 slots of size 64.0 KiB
each, total size is 64.0 MiB, maximum usable slot size is 65472
D: cli-command.c: Checking for existance of
'/usr/lib/pulse-0.9/modules/module-gconf.so': success
D: module-gconf.c: Loading module 'module-combine' with args '' due to
GConf configuration.
I: sink.c: Created sink 0 "combined" with sample spec s16le 2ch 44100Hz
and channel map front-left,front-right
I: source.c: Created source 0 "combined.monitor" with sample spec s16le
2ch 44100Hz and channel map front-left,front-right
D: module-combine.c: Thread starting up
D: rtpoll.c: Acquired POSIX realtime signal SIGRTMIN+29
I: module.c: Loaded "module-combine" (index: #0; argument: "").
I: module.c: Loaded "module-gconf" (index: #1; argument: "").
D: module-suspend-on-idle.c: Sink combined becomes idle.
D: module-suspend-on-idle.c: Source combined.monitor becomes idle.
I: module.c: Loaded "module-suspend-on-idle" (index: #2; argument: "").
I: module-device-restore.c: Sucessfully opened database file
'/home/mne/.pulse/d05a505180ca4c5382d620fc498da356:device-volumes.x86_64-pc-linux-gnu.gdbm'.
I: module.c: Loaded "module-device-restore" (index: #3; argument: "").
I: module-stream-restore.c: Sucessfully opened database file
'/home/mne/.pulse/d05a505180ca4c5382d620fc498da356:stream-volumes.x86_64-pc-linux-gnu.gdbm'.
I: module.c: Loaded "module-stream-restore" (index: #4; argument: "").
D: cli-command.c: Checking for existance of
'/usr/lib/pulse-0.9/modules/module-hal-detect.so': success
I: module-hal-detect.c: Trying capability alsa
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/computer_alsa_timer
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/computer_alsa_sequencer
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_playback_4
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_midi_3
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_playback_2
D: module-hal-detect.c: Loading module-alsa-source with arguments
'device_id=0
source_name=alsa_input.pci_1102_4_sound_card_0_alsa_capture_0 tsched=0'
D: alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
I: module-alsa-source.c: Successfully opened device front:0.
I: module-alsa-source.c: Successfully enabled mmap() mode.
I: (alsa-lib)control.c: Invalid CTL front:0
I: alsa-util.c: Unable to attach to mixer front:0: No such file or directory
I: alsa-util.c: Successfully attached to mixer 'hw:0'
I: alsa-util.c: Cannot find mixer control "Capture" or mixer control is
no combination of switch/volume.
I: alsa-util.c: Using mixer control "Mic".
I: module-device-restore.c: Restoring volume for source
alsa_input.pci_1102_4_sound_card_0_alsa_capture_0.
I: module-device-restore.c: Restoring mute state for source
alsa_input.pci_1102_4_sound_card_0_alsa_capture_0.
I: source.c: Created source 1
"alsa_input.pci_1102_4_sound_card_0_alsa_capture_0" with sample spec
s16le 2ch 44100Hz and channel map front-left,front-right
I: module-alsa-source.c: Using 2 fragments of size 7168 bytes, buffer
time is 81.27ms
D: module-alsa-source.c: hwbuf_unused=0
D: module-alsa-source.c: setting avail_min=1
I: module-alsa-source.c: Volume ranges from 0 to 31.
I: module-alsa-source.c: Volume ranges from -34.50 dB to 12.00 dB.
I: alsa-util.c: ALSA device lacks independant volume controls for each
channel.
I: module-alsa-source.c: Using hardware volume control. Hardware dB
scale supported.
D: alsa-util.c: snd_pcm_dump():
D: alsa-util.c: Hooks PCM
D: alsa-util.c: Its setup is:
D: alsa-util.c:   stream       : CAPTURE
D: alsa-util.c:   access       : MMAP_INTERLEAVED
D: alsa-util.c:   format       : S16_LE
D: alsa-util.c:   subformat    : STD
D: alsa-util.c:   channels     : 2
D: alsa-util.c:   rate         : 44100
D: alsa-util.c:   exact rate   : 44100 (44100/1)
D: alsa-util.c:   msbits       : 16
D: alsa-util.c:   buffer_size  : 3584
D: alsa-util.c:   period_size  : 1792
D: alsa-util.c:   period_time  : 40634
D: alsa-util.c:   tstamp_mode  : ENABLE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 1792
D: alsa-util.c:   period_event : 0
D: alsa-util.c:   start_threshold  : -1
D: alsa-util.c:   stop_threshold   : 8070450532247928832
D: alsa-util.c:   silence_threshold: 0
D: alsa-util.c:   silence_size : 0
D: alsa-util.c:   boundary     : 8070450532247928832
D: alsa-util.c: Slave: Hardware PCM card 0 'Audigy 2 [SB0240]' device 0
subdevice 0
D: alsa-util.c: Its setup is:
D: alsa-util.c:   stream       : CAPTURE
D: alsa-util.c:   access       : MMAP_INTERLEAVED
D: alsa-util.c:   format       : S16_LE
D: alsa-util.c:   subformat    : STD
D: alsa-util.c:   channels     : 2
D: alsa-util.c:   rate         : 44100
D: alsa-util.c:   exact rate   : 44100 (44100/1)
D: alsa-util.c:   msbits       : 16
D: alsa-util.c:   buffer_size  : 3584
D: alsa-util.c:   period_size  : 1792
D: alsa-util.c:   period_time  : 40634
D: alsa-util.c:   tstamp_mode  : ENABLE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 1792
D: alsa-util.c:   period_event : 0
D: alsa-util.c:   start_threshold  : -1
D: alsa-util.c:   stop_threshold   : 807045053224
D: module-alsa-source.c: Thread starting up
D: module-alsa-source.c: Requested volume: 0: 100% 1: 100%
D: rtpoll.c: Acquired POSIX realtime signal SIGRTMIN+28
D: module-alsa-source.c: Got hardware volume: 0: 100% 1: 100%
D: module-alsa-source.c: Calculated software volume: 0: 100% 1: 100%
D: module-suspend-on-idle.c: Source
alsa_input.pci_1102_4_sound_card_0_alsa_capture_0 becomes idle.
I: module.c: Loaded "module-alsa-source" (index: #5; argument:
"device_id=0
source_name=alsa_input.pci_1102_4_sound_card_0_alsa_capture_0 tsched=0").
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_capture_4
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_playback_3
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_capture_2
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_midi_2
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_capture_1
D: module-hal-detect.c: Loading module-alsa-sink with arguments
'device_id=0
sink_name=alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 tsched=0'
D: alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying front:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:front:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:front:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: alsa-util.c: PCM device plug:front:0 refused our hw parameters:
Device or resource busy
D: alsa-util.c: Trying surround40:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying surround40:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:surround40:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:surround40:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: alsa-util.c: PCM device plug:surround40:0 refused our hw parameters:
Device or resource busy
D: alsa-util.c: Trying surround41:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying surround41:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:surround41:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:surround41:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: alsa-util.c: PCM device plug:surround41:0 refused our hw parameters:
Device or resource busy
D: alsa-util.c: Trying surround50:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying surround50:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:surround50:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:surround50:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: alsa-util.c: PCM device plug:surround50:0 refused our hw parameters:
Device or resource busy
D: alsa-util.c: Trying surround51:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying surround51:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:surround51:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:surround51:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: alsa-util.c: PCM device plug:surround51:0 refused our hw parameters:
Device or resource busy
D: alsa-util.c: Trying surround71:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying surround71:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:surround71:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:surround71:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: alsa-util.c: PCM device plug:surround71:0 refused our hw parameters:
Device or resource busy
D: alsa-util.c: Trying hw:0 as last resort...
D: alsa-util.c: Trying hw:0 with SND_PCM_NO_AUTO_FORMAT ...
I: module-alsa-sink.c: Successfully opened device hw:0.
I: module-alsa-sink.c: Successfully enabled mmap() mode.
I: alsa-util.c: Successfully attached to mixer 'hw:0'
I: alsa-util.c: Cannot find mixer control "Master" or mixer control is
no combination of switch/volume.
W: alsa-util.c: Cannot find fallback mixer control "PCM" or mixer
control is no combination of switch/volume.
I: alsa-util.c: Using mixer control "PCM".
I: module-device-restore.c: Restoring volume for sink
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0.
I: module-device-restore.c: Restoring mute state for sink
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0.
I: sink.c: Created sink 1
"alsa_output.pci_1102_4_sound_card_0_alsa_playback_0" with sample spec
s16le 2ch 44100Hz and channel map front-left,front-right
I: module-device-restore.c: Restoring volume for source
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0.monitor.
I: module-device-restore.c: Restoring mute state for source
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0.monitor.
I: source.c: Created source 2
"alsa_output.pci_1102_4_sound_card_0_alsa_playback_0.monitor" with
sample spec s16le 2ch 44100Hz and channel map front-left,front-right
I: module-alsa-sink.c: Using 8 fragments of size 1764 bytes, buffer time
is 80.00ms
D: module-alsa-sink.c: hwbuf_unused=0
D: module-alsa-sink.c: setting avail_min=1
I: module-alsa-sink.c: Volume ranges from 0 to 100.
I: module-alsa-sink.c: Volume ranges from -40.00 dB to 0.00 dB.
I: alsa-util.c: ALSA device lacks independant volume controls for each
channel.
I: module-alsa-sink.c: Using hardware volume control. Hardware dB scale
supported.
I: module-alsa-sink.c: Using software mute control.
D: alsa-util.c: snd_pcm_dump():
D: alsa-util.c: Hardware PCM card 0 'Audigy 2 [SB0240]' device 0 subdevice 0
D: alsa-util.c: Its setup is:
D: alsa-util.c:   stream       : PLAYBACK
D: alsa-util.c:   access       : MMAP_INTERLEAVED
D: alsa-util.c:   format       : S16_LE
D: alsa-util.c:   subformat    : STD
D: alsa-util.c:   channels     : 2
D: alsa-util.c:   rate         : 44100
D: alsa-util.c:   exact rate   : 44100 (44100/1)
D: alsa-util.c:   msbits       : 16
D: alsa-util.c:   buffer_size  : 3528
D: alsa-util.c:   period_size  : 441
D: alsa-util.c:   period_time  : 10000
D: alsa-util.c:   tstamp_mode  : ENABLE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 441
D: alsa-util.c:   period_event : 0
D: alsa-util.c:   start_threshold  : -1
D: alsa-util.c:   stop_threshold   : 7944349742681554944
D: alsa-util.c:   silence_threshold: 0
D: alsa-util.c:   silence_size : 0
D: alsa-util.c:   boundary     : 7944349742681554944
D: module-alsa-sink.c: Thread starting up
D: module-alsa-sink.c: Requested volume: 0:  77% 1:  77%
D: rtpoll.c: Acquired POSIX realtime signal SIGRTMIN+27
D: module-alsa-sink.c: Got hardware volume: 0:  77% 1:  77%
D: module-alsa-sink.c: Calculated software volume: 0: 100% 1: 100%
I: module-alsa-sink.c: Starting playback.
D: module-suspend-on-idle.c: Source
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0.monitor becomes idle.
D: module-suspend-on-idle.c: Sink
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 becomes idle.
I: module-combine.c: Configuring new sink:
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0
D: memblockq.c: memblockq requested: maxlength=16777216,
tlength=16777216, base=4, prebuf=1, minreq=0 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=16777216,
tlength=16777216, base=4, prebuf=4, minreq=4 maxrewind=0
I: module-stream-restore.c: Not restore device for stream
sink-input-by-media-role:filter, because already set.
I: module-stream-restore.c: Restoring volume for sink input
sink-input-by-media-role:filter.
I: module-stream-restore.c: Restoring mute state for sink input
sink-input-by-media-role:filter.
D: module-suspend-on-idle.c: Sink
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 becomes busy.
I: resampler.c: Using resampler 'trivial'
I: resampler.c: Using s16le as working format.
D: memblockq.c: memblockq requested: maxlength=33554432, tlength=0,
base=4, prebuf=0, minreq=1 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=33554432,
tlength=33554432, base=4, prebuf=0, minreq=4 maxrewind=0
I: sink-input.c: Created input 0 "Simultaneous output on Audigy 2
[SB0240] - ADC Capture/Standard PCM Playback" on
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 with sample spec
s16le 2ch 44100Hz and channel map front-left,front-right
D: module-alsa-sink.c: hwbuf_unused=0
D: module-alsa-sink.c: setting avail_min=1
I: module.c: Loaded "module-alsa-sink" (index: #6; argument:
"device_id=0
sink_name=alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 tsched=0").
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_midi_1
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_midi_0
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_hw_specific_2
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_hw_specific_0
D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_1102_4_sound_card_0_alsa_control__1
I: module-hal-detect.c: Loaded 2 modules.
I: module.c: Loaded "module-hal-detect" (index: #7; argument: "tsched=0").
D: cli-command.c: Checking for existance of
'/usr/lib/pulse-0.9/modules/module-esound-protocol-unix.so': success
I: module.c: Loaded "module-esound-protocol-unix" (index: #8; argument: "").
I: module.c: Loaded "module-native-protocol-unix" (index: #9; argument: "").
I: module-default-device-restore.c: Restored default sink
'alsa_output.pci_1102_4_sound_card_0_alsa_playback_0'.
D: core-subscribe.c: Dropped redundant event due to change event.
I: module-default-device-restore.c: Restored default source
'alsa_input.pci_1102_4_sound_card_0_alsa_capture_0'.
I: module.c: Loaded "module-default-device-restore" (index: #10;
argument: "").
I: module.c: Loaded "module-rescue-streams" (index: #11; argument: "").
I: module.c: Loaded "module-always-sink" (index: #12; argument: "").
I: client.c: Created 0 "ConsoleKit Session
/org/freedesktop/ConsoleKit/Session3"
D: module-console-kit.c: Added new session
/org/freedesktop/ConsoleKit/Session3
I: module.c: Loaded "module-console-kit" (index: #13; argument: "").
I: module.c: Loaded "module-position-event-sounds" (index: #14;
argument: "").
I: main.c: Daemon startup complete.
D: module-hal-detect.c: dbus: interface=org.freedesktop.DBus,
path=/org/freedesktop/DBus, member=NameAcquired
D: module-console-kit.c: dbus: interface=org.freedesktop.DBus,
path=/org/freedesktop/DBus, member=NameAcquired
I: module-suspend-on-idle.c: Source combined.monitor idle for too long,
suspending ...
I: module-suspend-on-idle.c: Sink combined idle for too long, suspending ...
D: module-alsa-sink.c: hwbuf_unused=0
D: module-alsa-sink.c: setting avail_min=1
D: module-suspend-on-idle.c: Sink
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 becomes idle.
D: module-suspend-on-idle.c: Sink
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 becomes idle.
I: sink-input.c: Freeing input 0 "Simultaneous output on Audigy 2
[SB0240] - ADC Capture/Standard PCM Playback"
I: module-combine.c: Device suspended...
I: module-suspend-on-idle.c: Source
alsa_input.pci_1102_4_sound_card_0_alsa_capture_0 idle for too long,
suspending ...
I: module-alsa-source.c: Device suspended...
I: module-suspend-on-idle.c: Source
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0.monitor idle for too
long, suspending ...
I: client.c: Created 1 "Native client (UNIX socket client)"
I: client.c: Freed 1 "Native client (UNIX socket client)"
I: protocol-native.c: Connection died.
I: client.c: Created 2 "Native client (UNIX socket client)"
D: protocol-native.c: Protocol version: remote 14, local 14
I: protocol-native.c: Got credentials: uid=1000 gid=1000 success=1
D: protocol-native.c: SHM possible: yes
D: protocol-native.c: Negotiated SHM: yes
I: module-stream-restore.c: Restoring device for stream
source-output-by-application-name:ALSA plug-in [duplex].
I: module-alsa-source.c: Trying resume...
D: module-alsa-source.c: hwbuf_unused=0
D: module-alsa-source.c: setting avail_min=1
I: module-alsa-source.c: Resumed successfully...
D: module-suspend-on-idle.c: Source
alsa_input.pci_1102_4_sound_card_0_alsa_capture_0 becomes idle.
D: module-suspend-on-idle.c: Source
alsa_input.pci_1102_4_sound_card_0_alsa_capture_0 becomes busy.
D: resampler.c: Channel matrix:
D: resampler.c:        I00   I01
D: resampler.c:     +------------
D: resampler.c: O00 | 1.000 1.000
I: resampler.c: Using resampler 'src-linear'
I: resampler.c: Using float32le as working format.
D: memblockq.c: memblockq requested: maxlength=33554432, tlength=0,
base=4, prebuf=0, minreq=1 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=33554432,
tlength=33554432, base=4, prebuf=0, minreq=4 maxrewind=0
I: source-output.c: Created output 0 "ALSA Capture" on
alsa_input.pci_1102_4_sound_card_0_alsa_capture_0 with sample spec s16le
1ch 8000Hz and channel map mono
D: memblockq.c: memblockq requested: maxlength=4194304, tlength=0,
base=2, prebuf=1, minreq=0 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=4194304, tlength=4194304,
base=2, prebuf=2, minreq=2 maxrewind=0
I: protocol-native.c: Final latency 40.00 ms = 20.00 ms + 20.00 ms
D: module-alsa-source.c: hwbuf_unused=0
D: module-alsa-source.c: setting avail_min=1
D: module-alsa-source.c: hwbuf_unused=0
D: module-alsa-source.c: setting avail_min=1
I: client.c: Created 3 "Native client (UNIX socket client)"
D: protocol-native.c: Protocol version: remote 14, local 14
I: protocol-native.c: Got credentials: uid=1000 gid=1000 success=1
D: protocol-native.c: SHM possible: yes
D: protocol-native.c: Negotiated SHM: yes
I: module-stream-restore.c: Restoring device for stream
sink-input-by-application-name:ALSA plug-in [duplex].
I: module-stream-restore.c: Restoring volume for sink input
sink-input-by-application-name:ALSA plug-in [duplex].
D: module-stream-restore.c: Not restoring mute state for sink input
sink-input-by-application-name:ALSA plug-in [duplex], because already set.
D: module-suspend-on-idle.c: Sink
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 becomes busy.
D: resampler.c: Channel matrix:
D: resampler.c:        I00
D: resampler.c:     +------
D: resampler.c: O00 | 1.000
D: resampler.c: O01 | 1.000
I: resampler.c: Using resampler 'src-linear'
I: resampler.c: Using float32le as working format.
D: memblockq.c: memblockq requested: maxlength=33554432, tlength=0,
base=4, prebuf=0, minreq=1 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=33554432,
tlength=33554432, base=4, prebuf=0, minreq=4 maxrewind=0
I: sink-input.c: Created input 1 "ALSA Playback" on
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 with sample spec
s16le 1ch 8000Hz and channel map mono
I: protocol-native.c: Requested tlength=80.00 ms, minreq=20.00 ms
D: protocol-native.c: Early requests mode enabled, configuring sink
latency to minreq.
D: memblockq.c: memblockq requested: maxlength=4194304, tlength=1280,
base=2, prebuf=960, minreq=320 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=4194304, tlength=1280,
base=2, prebuf=960, minreq=320 maxrewind=0
I: protocol-native.c: Final latency 100.00 ms = 40.00 ms + 2*20.00 ms +
20.00 ms
D: module-alsa-sink.c: hwbuf_unused=0
D: module-alsa-sink.c: setting avail_min=1
D: module-alsa-source.c: hwbuf_unused=0
D: module-alsa-source.c: setting avail_min=1
D: module-suspend-on-idle.c: Source
alsa_input.pci_1102_4_sound_card_0_alsa_capture_0 becomes idle.
D: module-suspend-on-idle.c: Source
alsa_input.pci_1102_4_sound_card_0_alsa_capture_0 becomes idle.
I: source-output.c: Freeing output 0 "ALSA Capture"
I: module-stream-restore.c: Restoring device for stream
source-output-by-application-name:ALSA plug-in [duplex].
D: module-suspend-on-idle.c: Source
alsa_input.pci_1102_4_sound_card_0_alsa_capture_0 becomes busy.
D: resampler.c: Channel matrix:
D: resampler.c:        I00   I01
D: resampler.c:     +------------
D: resampler.c: O00 | 1.000 1.000
I: resampler.c: Using resampler 'src-linear'
I: resampler.c: Using float32le as working format.
D: memblockq.c: memblockq requested: maxlength=33554432, tlength=0,
base=4, prebuf=0, minreq=1 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=33554432,
tlength=33554432, base=4, prebuf=0, minreq=4 maxrewind=0
I: source-output.c: Created output 1 "ALSA Capture" on
alsa_input.pci_1102_4_sound_card_0_alsa_capture_0 with sample spec s16le
1ch 8000Hz and channel map mono
D: memblockq.c: memblockq requested: maxlength=4194304, tlength=0,
base=2, prebuf=1, minreq=0 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=4194304, tlength=4194304,
base=2, prebuf=2, minreq=2 maxrewind=0
I: protocol-native.c: Final latency 40.00 ms = 20.00 ms + 20.00 ms
D: module-alsa-source.c: hwbuf_unused=0
D: module-alsa-source.c: setting avail_min=1
D: module-alsa-source.c: hwbuf_unused=0
D: module-alsa-source.c: setting avail_min=1
D: module-alsa-sink.c: hwbuf_unused=0
D: module-alsa-sink.c: setting avail_min=1
D: module-suspend-on-idle.c: Sink
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 becomes idle.
D: module-suspend-on-idle.c: Sink
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 becomes idle.
I: sink-input.c: Freeing input 1 "ALSA Playback"
I: module-stream-restore.c: Restoring device for stream
sink-input-by-application-name:ALSA plug-in [duplex].
I: module-stream-restore.c: Restoring volume for sink input
sink-input-by-application-name:ALSA plug-in [duplex].
D: module-stream-restore.c: Not restoring mute state for sink input
sink-input-by-application-name:ALSA plug-in [duplex], because already set.
D: module-suspend-on-idle.c: Sink
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 becomes busy.
D: resampler.c: Channel matrix:
D: resampler.c:        I00
D: resampler.c:     +------
D: resampler.c: O00 | 1.000
D: resampler.c: O01 | 1.000
I: resampler.c: Using resampler 'src-linear'
I: resampler.c: Using float32le as working format.
D: memblockq.c: memblockq requested: maxlength=33554432, tlength=0,
base=4, prebuf=0, minreq=1 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=33554432,
tlength=33554432, base=4, prebuf=0, minreq=4 maxrewind=0
I: sink-input.c: Created input 2 "ALSA Playback" on
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 with sample spec
s16le 1ch 8000Hz and channel map mono
I: protocol-native.c: Requested tlength=80.00 ms, minreq=20.00 ms
D: protocol-native.c: Early requests mode enabled, configuring sink
latency to minreq.
D: memblockq.c: memblockq requested: maxlength=4194304, tlength=1280,
base=2, prebuf=960, minreq=320 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=4194304, tlength=1280,
base=2, prebuf=960, minreq=320 maxrewind=0
I: protocol-native.c: Final latency 100.00 ms = 40.00 ms + 2*20.00 ms +
20.00 ms
D: module-alsa-sink.c: hwbuf_unused=0
D: module-alsa-sink.c: setting avail_min=1
D: protocol-native.c: Requesting rewind due to end of underrun.
D: module-alsa-sink.c: hwbuf_unused=0
D: module-alsa-sink.c: setting avail_min=1
D: module-suspend-on-idle.c: Sink
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 becomes idle.
D: module-suspend-on-idle.c: Sink
alsa_output.pci_1102_4_sound_card_0_alsa_playback_0 becomes idle.
I: sink-input.c: Freeing input 2 "ALSA Playback"
I: client.c: Freed 3 "ALSA plug-in [duplex]"
I: protocol-native.c: Connection died.
D: module-alsa-source.c: hwbuf_unused=0
D: module-alsa-source.c: setting avail_min=1
D: module-suspend-on-idle.c: Source
alsa_input.pci_1102_4_sound_card_0_alsa_capture_0 becomes idle.
D: module-suspend-on-idle.c: Source
alsa_input.pci_1102_4_sound_card_0_alsa_capture_0 becomes idle.
I: source-output.c: Freeing output 1 "ALSA Capture"
I: client.c: Freed 2 "ALSA plug-in [duplex]"
I: protocol-native.c: Connection died.
------------------------------------------------------------------------------
