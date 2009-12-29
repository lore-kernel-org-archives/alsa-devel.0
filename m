From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsa-util.c: snd_pcm_avail() returned a value that
	is exceptionally large: 349696 bytes (1821 ms).
Date: Tue, 29 Dec 2009 15:31:27 +0800
Message-ID: <4f3252890912282331l419eb860o2537f610a52a022f@mail.gmail.com>
References: <1261191766.18070.10.camel@localhost.localdomain>
	<4f3252890912191547x1996cf7es190e8dac71dacaae@mail.gmail.com>
	<1261352484.18070.47.camel@localhost.localdomain>
	<1261869811.30924.69.camel@localhost.localdomain>
	<4f3252890912261739x372fb678yde8a8e0edb93fe6e@mail.gmail.com>
	<1261947691.24632.29.camel@localhost.localdomain>
	<4f3252890912272114t6dcfa58bj4d5b5e6e606c5004@mail.gmail.com>
	<1262058553.20808.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f179.google.com (mail-pz0-f179.google.com
	[209.85.222.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AA57F24142
	for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2009 08:31:30 +0100 (CET)
Received: by pzk9 with SMTP id 9so7215459pzk.16
	for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2009 23:31:27 -0800 (PST)
In-Reply-To: <1262058553.20808.15.camel@localhost.localdomain>
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

Refer to the pulseaudio log which you have posted to pulseaudio mailing list


1) what is the buffer time used to calculate the sleeping time ?

I: alsa-sink.c: Using 3.0 fragments of size 6396 bytes (33.31ms), buffer
size is 19188 bytes (99.94ms)

D: alsa-util.c: Maximum hw buffer size is 341 ms




I: alsa-sink.c: Using 3.0 fragments of size 6396 bytes (33.31ms), buffer
size is 19188 bytes (99.94ms)
D: alsa-sink.c: hwbuf_unused=0
D: alsa-sink.c: setting avail_min=1
D: alsa-mixer.c: Activating path analog-output
D: alsa-mixer.c: Path analog-output (Analog Output), direction=1,
priority=100, probed=yes, supported=yes, has_mute=yes, has_volume=yes,
has_dB=yes, min_volume=0, max_volume=31, min_dB=-127.5, max_dB=12
D: alsa-mixer.c: Element Master, direction=1, switch=1, volume=1,
enumeration=0, required=0, required_absent=0, mask=0x3600000000f66,
n_channels=2, override_map=yes
D: alsa-mixer.c: Element Master Mono, direction=1, switch=2, volume=2,
enumeration=0, required=0, required_absent=0, mask=0x7ffffffffffff,
n_channels=1, override_map=no
D: alsa-mixer.c: Element Surround, direction=1, switch=1, volume=1,
enumeration=0, required=0, required_absent=0, mask=0x60, n_channels=2,
override_map=yes
D: alsa-mixer.c: Element Center, direction=1, switch=1, volume=1,
enumeration=0, required=0, required_absent=0, mask=0x4900000000018,
n_channels=1, override_map=yes
D: alsa-mixer.c: Element LFE, direction=1, switch=1, volume=1,
enumeration=0, required=0, required_absent=0, mask=0x80, n_channels=1,
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
I: alsa-sink.c: Hardware volume ranges from -127.50 dB to 12.00 dB.
I: alsa-sink.c: Fixing base volume to -12.00 dB
I: alsa-sink.c: Using hardware volume control. Hardware dB scale supported.
I: alsa-sink.c: Using hardware mute control.
D: alsa-util.c: snd_pcm_dump():
D: alsa-util.c: Hardware PCM card 0 'VIA 8237' device 0 subdevice 0
D: alsa-util.c: Its setup is:
D: alsa-util.c:   stream       : PLAYBACK
D: alsa-util.c:   access       : MMAP_INTERLEAVED
D: alsa-util.c:   format       : S16_LE
D: alsa-util.c:   subformat    : STD
D: alsa-util.c:   channels     : 2
D: alsa-util.c:   rate         : 48000
D: alsa-util.c:   exact rate   : 48000 (48000/1)
D: alsa-util.c:   msbits       : 16
D: alsa-util.c:   buffer_size  : 4797
D: alsa-util.c:   period_size  : 1599
D: alsa-util.c:   period_time  : 33312
D: alsa-util.c:   tstamp_mode  : ENABLE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 1599
D: alsa-util.c:   period_event : 0
D: alsa-util.c:   start_threshold  : -1
D: alsa-util.c:   stop_threshold   : 1257504768
D: alsa-util.c:   silence_threshold: 0
D: alsa-util.c:   silence_size : 0
D: alsa-util.c:   boundary     : 1257504768
D: alsa-util.c:   appl_ptr     : 0
D: alsa-util.c:   hw_ptr       : 0
D: alsa-sink.c: Thread starting up
D: alsa-sink.c: Requested volume: 0:  39% 1:  39%
D: alsa-sink.c: Got hardware volume: 0:  40% 1:  40%
D: alsa-sink.c: Calculated software volume: 0:  97% 1:  97%
(accurate-enough=no)
D: core-util.c: RealtimeKit worked.
I: core-util.c: Successfully enabled SCHED_RR scheduling for thread, with
priority 5.
I: alsa-sink.c: Starting playback.
D: alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
D: alsa-util.c: Managed to open front:0
D: alsa-util.c: Maximum hw buffer size is 341 ms
D: alsa-util.c: Set buffer size first, period size second.
I: alsa-util.c: Device front:0 doesn't support 44100 Hz, changed to 48000
Hz.
I: alsa-source.c: Successfully opened device front:0.
I: alsa-source.c: Selected mapping 'Analog Stereo' (analog-stereo).
I: alsa-source.c: Successfully enabled mmap() mode.
I: (alsa-lib)control.c: Invalid CTL front:0
I: alsa-mixer.c: Unable to attach to mixer front:0: No such file or
directory
I: alsa-mixer.c: Successfully attached to mixer 'hw:0'

2) I: (alsa-lib)setup.c: Cannot lock ctl elem



D: alsa-mixer.c: Checking for recording on Analog Mono (analog-mono)
D: alsa-util.c: Trying hw:1 with SND_PCM_NO_AUTO_FORMAT ...
D: alsa-util.c: Managed to open hw:1
D: alsa-util.c: Maximum hw buffer size is 743 ms
D: alsa-util.c: Set buffer size first, period size second.
I: alsa-util.c: Device hw:1 doesn't support 44100 Hz, changed to 44099 Hz.
D: alsa-mixer.c: Profile output:iec958-stereo+input:analog-mono supported.
D: alsa-mixer.c: Looking at profile output:iec958-stereo+input:analog-stereo
D: alsa-mixer.c: Checking for recording on Analog Stereo (analog-stereo)
D: alsa-util.c: Trying front:1 with SND_PCM_NO_AUTO_FORMAT ...
D: alsa-util.c: Managed to open front:1
D: alsa-util.c: Maximum hw buffer size is 371 ms
D: alsa-util.c: Set buffer size first, period size second.
I: alsa-util.c: Device front:1 doesn't support 44100 Hz, changed to 44099
Hz.
D: alsa-mixer.c: Profile output:iec958-stereo+input:analog-stereo supported.
D: alsa-mixer.c: Looking at profile output:iec958-stereo+input:iec958-stereo
D: alsa-mixer.c: Checking for recording on Digital Stereo (IEC958)
(iec958-stereo)
D: alsa-util.c: Trying iec958:1 with SND_PCM_NO_AUTO_FORMAT ...
D: alsa-util.c: Managed to open iec958:1
D: alsa-util.c: Maximum hw buffer size is 371 ms
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Set neither period nor buffer size.
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: alsa-util.c: snd_pcm_hw_params failed: Device or resource busy
D: alsa-util.c: Trying iec958:1 without SND_PCM_NO_AUTO_FORMAT ...
D: alsa-util.c: Managed to open iec958:1
D: alsa-util.c: Maximum hw buffer size is 371 ms
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Set neither period nor buffer size.
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: alsa-util.c: snd_pcm_hw_params failed: Device or resource busy
D: alsa-util.c: Trying plug:iec958:1 with SND_PCM_NO_AUTO_FORMAT ...
D: alsa-util.c: Managed to open plug:iec958:1
D: alsa-util.c: Maximum hw buffer size is 371 ms
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Set neither period nor buffer size.
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: alsa-util.c: snd_pcm_hw_params failed: Device or resource busy
D: alsa-util.c: Trying plug:iec958:1 without SND_PCM_NO_AUTO_FORMAT ...
D: alsa-util.c: Managed to open plug:iec958:1
D: alsa-util.c: Maximum hw buffer size is 371 ms
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Set neither period nor buffer size.
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: alsa-util.c: snd_pcm_hw_params failed: Device or resource busy

3) W: asyncq.c: q overrun, queuing locally
D: memblock.c: Pool full

is not related to "alsa-util.c : snd_pcm_avail() returned a value that is
exceptionally large"
since this message did not appear in your pulseaudio.log

W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally
D: memblock.c: Pool full
W: asyncq.c: q overrun, queuing locally
W: ratelimit.c: 794 events suppressed
W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally
D: memblock.c: Pool full
D: memblock.c: Pool full
D: memblock.c: Pool full
W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally
W: ratelimit.c: 819 events suppressed
W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally



2009/12/29 Chris <cpollock@embarqmail.com>

> On Mon, 2009-12-28 at 13:14 +0800, Raymond Yau wrote:
> > Do you mean that you cannot find a test case to reproduce the bug ?
>
> Not exactly, for instance 20 seconds after freshclam ran I see this in
> my syslog:
>
> Dec 28 21:26:30 localhost pulseaudio[11266]: ratelimit.c: 52 events
> suppressed
> Dec 28 21:26:30 localhost pulseaudio[11266]: asyncq.c: q overrun,
> queuing locally
> Dec 28 21:26:30 localhost last message repeated 10 times
>
> then this:
>
> Dec 28 21:27:24 localhost pulseaudio[11266]: asyncq.c: q overrun,
> queuing locally
> Dec 28 21:27:24 localhost last message repeated 10 times
> Dec 28 21:27:37 localhost pulseaudio[11266]: alsa-util.c:
> snd_pcm_avail() returned a value that is exceptionally large: 839968
> bytes (4761 ms).
>
> The above is while the drive was 'thrashing' for a couple of minutes
>
> I've also determined via experimentation that with pulseaudio running
> copying a 1.2Gb file to a thumb drive takes an average of 30minutes.
> This what I've done:
>
> 1. Using Gnome Commander I attempted to copy the 1.2 Gb file to a thumb
> drive, after about 30 minutes I had to stop the transfer at about 35%.
> 2. Disabled pulseaudio in Mandriva command center, logged out and back
> in again.
> 3. Again tried to copy the save file to the thumb drive, this time it
> took about 3 minutes.
> 4. Re-enabled pulseaudio and again tried to copy the file, this time
> using pulseaudio -k ; pulseaudio -vvvv on the command line. I saw
> outputs like this:
>
> W: asyncq.c: q overrun, queuing locally
> W: asyncq.c: q overrun, queuing locally
> W: asyncq.c: q overrun, queuing locally
> W: asyncq.c: q overrun, queuing locally
> W: asyncq.c: q overrun, queuing locally
> W: asyncq.c: q overrun, queuing locally
> W: asyncq.c: q overrun, queuing locally
> W: asyncq.c: q overrun, queuing locally
> W: asyncq.c: q overrun, queuing locally
> W: asyncq.c: q overrun, queuing locally
> W: asyncq.c: q overrun, queuing locally
> W: ratelimit.c: 600 events suppressed
>
> I have the complete log as a 15k bziped file. Can it be sent to the
> list?
>
> Chris
>
> --
> KeyID 0xE372A7DA98E6705C
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
