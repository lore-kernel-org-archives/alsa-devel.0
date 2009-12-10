From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: hw_ptr accuracy with intel8x0 -> PulseAudio issue
Date: Thu, 10 Dec 2009 11:41:05 +0800
Message-ID: <4f3252890912091941y34509e3brd235360485c8c967@mail.gmail.com>
References: <6160a5130912020115t45bd4635hceb0ac3de4fb1efe@mail.gmail.com>
	<4f3252890912021826g732292ecv8959a7cfbf574446@mail.gmail.com>
	<6160a5130912030828m5b2401f3w31a67b6b51e8d8b6@mail.gmail.com>
	<4f3252890912031442i56ccc905g935a4d6ed48f40c6@mail.gmail.com>
	<6160a5130912031650u5949c921jc86d0847b2844803@mail.gmail.com>
	<4f3252890912041817u7ab83a3eh7643476d64d709f3@mail.gmail.com>
	<s5h4oo1sisn.wl%tiwai@suse.de>
	<4f3252890912090355n70a2b5cfu4fbb74d473480a94@mail.gmail.com>
	<s5hr5r4ntus.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DFE1103813
	for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2009 04:41:07 +0100 (CET)
Received: by pwi18 with SMTP id 18so433334pwi.32
	for <alsa-devel@alsa-project.org>; Wed, 09 Dec 2009 19:41:06 -0800 (PST)
In-Reply-To: <s5hr5r4ntus.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/12/9 Takashi Iwai <tiwai@suse.de>

> At Wed, 9 Dec 2009 19:55:15 +0800,
> Raymond Yau wrote:
> >
> > 2009/12/8 Takashi Iwai <tiwai@suse.de>
> >
> > > At Sat, 5 Dec 2009 10:17:07 +0800,
> > > Raymond Yau wrote:
> > > >
> > > > 2009/12/4 pl bossart <bossart.nospam@gmail.com>
> > > >
> > > > > >>   17. hwptr 24351 buffer 16384 appl 24332, avail=16403
> > > > > >
> > > > > > appl pointer is behind hwprtr (  underrun ) , need timestamp to
> find
> > > out
> > > > > > whether PA is unable to write audio data in time since
> > > > >
> > > > >  I commented out the portion of the code that increases the
> watermark
> > > and
> > > > > clamped the number of available samples to the buffer size, and it
> > > works
> > > > > just fine, no audio
> > > > > underflows.
> > > > >
> > > >
> > > > Do you mean that the underrun is related the the portion of code that
> > > > increase the watermark (i.e It is a pulseaudio bug instead of driver
> bug
> > >  )
> > > > ?
> > >
> > > Or, we can try simply to change to periods_min = 2 whether this fixes
> > > the PA issues.
> > >
> > > periods_min = 1 is anyway fairly fragile.  With that setup, apps are
> > > supposed (implicitly) to wake up frequently enough to get pointers in
> > > sync.  This is because you can't trust whether the IRQ wake up is
> > > really fast enough.  There are machines that aren't.
> > >
> > >
> > > thanks,
> > >
> > > Takashi
> > >
> >
> > The intel8x0 driver has code to handle one period per buffer ,
>
> Yes, but it doesn't work so reliably.
> That's why I asked for testing periods_min = 2.
>
> > Is the feature "one period per buffer"  designed for dmix ?
>
> No.
>
> > The system timer may be running faster or slower than the sound card
> > on differnt machine
>
> Yes.
>
> > PA only adjust the watermark/sleeping time in one direction only
>
> Yes.
>
>
> thanks,
>
> Takashi
>

Unlike the convention sound card which has only one set of hardware
registers, aureal au88x0 chips has 4 set of hardware registers ( sub-buffers
as descibed in patent 6167465 )
The maximum period size is  4k bytes and the driver support 2 to 32 periods.


This is exactly as same as the sound card in the figure

*Image 1:* *Schematic overview of the playback buffer in the traditional
playback model, in the best way the author can visualize this with his
limited drawing abilities.*

http://0pointer.de/blog/projects/pulse-glitch-free.html



1) what is hwbuf_unused_frames ?

2) why PA use  snd_pcm_hw_params_get_buffer_size_max() instead of
snd_pcm_hw_params_get_buffer_size() after snd_pcm_hw_params() ?

D: alsa-util.c: Maximum hw buffer size is 371 ms

I: module-alsa-sink.c: Using 2 fragments of size 4096 bytes, buffer time is
46.44ms
D: alsa-util.c:   buffer_size  : 2048
D: alsa-util.c:   period_size  : 1024

3) why PA alway open CTL device "front:0" instead of "hw:0" ?

I: (alsa-lib)control.c: Invalid CTL front:0
I: alsa-util.c: Unable to attach to mixer front:0: No such file or directory
I: alsa-util.c: Successfully attached to mixer 'hw:0'

4) did PA has any data to play when the server probe the devices ?

D: module-alsa-sink.c: Thread starting up
D: rtpoll.c: Acquired POSIX realtime signal SIGRTMIN+29
I: module-alsa-sink.c: Starting playback.

5) it seem bug in snd_pcm_sw_params_set_avail_min() since 4661 is larger
than the buffer size 2048 since PA still think that 371ms is the maximum
buffer size


D: alsa-util.c:   buffer_size  : 2048
D: alsa-util.c:   period_size  : 1024
D: alsa-util.c:   period_time  : 23219
D: alsa-util.c:   tstamp_mode  : NONE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 4661

6) when using the minimum period size of alsa-pulse plugin and aplay on
pulseaudio 0.9.19

it seem that underrun occur between aplay and PA server

I: alsa-sink.c: Increasing wakeup watermark to 7,98 ms
D: protocol-native.c: Underrun on 'ALSA Playback', 0 bytes in queue.
D: sink-input.c: Requesting rewind due to corking



For pulseaudio-0.9.14 on Fedora 10

D: module-hal-detect.c: Not loaded device
/org/freedesktop/Hal/devices/pci_12eb_2_sound_card_0_alsa_playback_1
D: module-hal-detect.c: Loading module-alsa-sink with arguments 'device_id=0
sink_name=alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0 tsched=1'
D: alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
D: alsa-util.c: Maximum hw buffer size is 371 ms

...

I: module-alsa-sink.c: Successfully opened device front:0.
I: module-alsa-sink.c: Successfully enabled mmap() mode.
I: module-alsa-sink.c: Successfully enabled timer-based scheduling mode.
I: (alsa-lib)control.c: Invalid CTL front:0
I: alsa-util.c: Unable to attach to mixer front:0: No such file or directory
I: alsa-util.c: Successfully attached to mixer 'hw:0'
I: alsa-util.c: Using mixer control "Master".
I: sink.c: Created sink 0
"alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0" with sample spec s16le
2ch 44100Hz and channel map front-left,front-right
I: source.c: Created source 0
"alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0.monitor" with sample
spec s16le 2ch 44100Hz and channel map front-left,front-right
I: module-alsa-sink.c: Using 2 fragments of size 4096 bytes, buffer time is
46.44ms
I: module-alsa-sink.c: Time scheduling watermark is 20.00ms
D: module-alsa-sink.c: hwbuf_unused_frames=0
D: module-alsa-sink.c: setting avail_min=4661
I: module-alsa-sink.c: Volume ranges from 0 to 31.
I: module-alsa-sink.c: Volume ranges from -46.50 dB to 0.00 dB.
I: alsa-util.c: All 2 channels can be mapped to mixer channels.
I: module-alsa-sink.c: Using hardware volume control. Hardware dB scale
supported.
D: alsa-util.c: snd_pcm_dump():
D: alsa-util.c: Hardware PCM card 0 'Aureal Vortex au8830' device 0
subdevice 0
D: alsa-util.c: Its setup is:
D: alsa-util.c:   stream       : PLAYBACK
D: alsa-util.c:   access       : MMAP_INTERLEAVED
D: alsa-util.c:   format       : S16_LE
D: alsa-util.c:   subformat    : STD
D: alsa-util.c:   channels     : 2
D: alsa-util.c:   rate         : 44100
D: alsa-util.c:   exact rate   : 44100 (44100/1)
D: alsa-util.c:   msbits       : 16
D: alsa-util.c:   buffer_size  : 2048
D: alsa-util.c:   period_size  : 1024
D: alsa-util.c:   period_time  : 23219
D: alsa-util.c:   tstamp_mode  : NONE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 4661
D: alsa-util.c:   period_event : 0
D: alsa-util.c:   start_threshold  : -1
D: alsa-util.c:   stop_threshold   : -1
D: alsa-util.c:   silence_threshold: 0
D: alsa-util.c:   silence_size : 0
D: alsa-util.c:   boundary     : 1073741824
D: alsa-util.c:   appl_ptr     : 0
D: alsa-util.c:   hw_ptr       : 0
D: module-alsa-sink.c: Read hardware volume: 0:  64% 1:  64%
D: module-alsa-sink.c: Thread starting up
D: rtpoll.c: Acquired POSIX realtime signal SIGRTMIN+29
I: module-alsa-sink.c: Starting playback.

...


I: module-alsa-sink.c: Trying resume...
D: alsa-util.c: Maximum hw buffer size is 371 ms
D: module-alsa-sink.c: hwbuf_unused_frames=0
D: module-alsa-sink.c: setting avail_min=4661
I: module-alsa-sink.c: Resumed successfully...
I: module-alsa-sink.c: Starting playback.
D: module-suspend-on-idle.c: Sink
alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0 becomes idle.
D: module-suspend-on-idle.c: Sink
alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0 becomes busy.
D: memblockq.c: memblockq requested: maxlength=33554432, tlength=0, base=4,
prebuf=0, minreq=1 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=33554432, tlength=33554432,
base=4, prebuf=0, minreq=4 maxrewind=0
I: sink-input.c: Created input 1 "ALSA Playback" on
alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0 with sample spec s16le
2ch 44100Hz and channel map front-left,front-right
I: protocol-native.c: Requested tlength=500.00 ms, minreq=124.99 ms
D: protocol-native.c: Early requests mode enabled, configuring sink latency
to minreq.
D: memblockq.c: memblockq requested: maxlength=4194304, tlength=88200,
base=4, prebuf=66152, minreq=22048 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=4194304, tlength=88200,
base=4, prebuf=66152, minreq=22048 maxrewind=0
I: protocol-native.c: Final latency 624.99 ms = 250.02 ms + 2*124.99 ms +
124.99 ms
D: module-alsa-sink.c: latency set to 46.44ms
D: module-alsa-sink.c: hwbuf_unused_frames=1
D: module-alsa-sink.c: setting avail_min=4662
D: module-alsa-sink.c: Requesting rewind due to latency change.
D: module-alsa-sink.c: Requested to rewind 8192 bytes.
D: module-alsa-sink.c: Limited to 3712 bytes.
D: module-alsa-sink.c: before: 928
D: module-alsa-sink.c: after: 928
D: module-alsa-sink.c: Rewound 3712 bytes.
D: sink.c: Processing rewind...
D: sink-input.c: Have to rewind 3712 bytes on render memblockq.


https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4776

hyper_sonic 's au8830 a bit lagged .But if switch to integrated i8x0 sound
chip music played very well. on pulseaudio 0.9.19

PA seem to use 16 fragments instead of 2 fragments for au8830


I: alsa-sink.c: Using 16,0 fragments of size 4096 bytes (23,22ms), buffer
size is 65536 bytes (371,52ms)
I: alsa-sink.c: Time scheduling watermark is 20,00ms
D: alsa-sink.c: hwbuf_unused=0
D: alsa-sink.c: setting avail_min=15502
D: alsa-mixer.c: Activating path analog-output-lfe-on-mono
D: alsa-mixer.c: Path analog-output-lfe-on-mono (Analog Output (LFE)),
direction=1, priority=40, probed=yes, supported=yes, has_mute=yes,
has_volume=yes, has_dB=yes, min_volume=0, max_volume=31, min_dB=-81,
max_dB=12
D: alsa-mixer.c: Element Master, direction=1, switch=1, volume=1,
enumeration=0, required=0, required_absent=0, mask=0x3600000000f66,
n_channels=2, override_map=yes
D: alsa-mixer.c: Element Master Mono, direction=1, switch=1, volume=1,
enumeration=0, required=4, required_absent=0, mask=0x80, n_channels=1,
override_map=yes
D: alsa-mixer.c: Element PCM, direction=1, switch=1, volume=1,
enumeration=0, required=0, required_absent=0, mask=0x402b600000000f66,
n_channels=2, override_map=yes
D: alsa-mixer.c: Element External Amplifier, direction=1, switch=4,
volume=0, enumeration=0, required=0, required_absent=0, mask=0x0,
n_channels=0, override_map=no
D: alsa-mixer.c: Option on (output-amplifier-on/Amplifier) index=1,
priority=10
D: alsa-mixer.c: Option off (output-amplifier-off/No Amplifier) index=0,
priority=0
D: alsa-mixer.c: Setting output-amplifier-on (Amplifier) priority=10
D: alsa-mixer.c: Setting output-amplifier-off (No Amplifier) priority=0
I: alsa-sink.c: Hardware volume ranges from -81,00 dB to 12,00 dB.
I: alsa-sink.c: Fixing base volume to -12,00 dB
I: alsa-sink.c: Using hardware volume control. Hardware dB scale supported.
I: alsa-sink.c: Using hardware mute control.
D: alsa-util.c: snd_pcm_dump():
D: alsa-util.c: Hardware PCM card 1 'Aureal Vortex au8830' device 0
subdevice 0
D: alsa-util.c: Its setup is:
D: alsa-util.c:   stream       : PLAYBACK
D: alsa-util.c:   access       : MMAP_INTERLEAVED
D: alsa-util.c:   format       : S16_LE
D: alsa-util.c:   subformat    : STD
