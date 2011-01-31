From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Any OSS changes from kernel 2.6.21 to 2.6.23?
	Something broke.
Date: Mon, 31 Jan 2011 11:09:20 +0800
Message-ID: <AANLkTimsADJPdk+vTcDOfkPnBjQ3Ha5abkN6ovtbTyOP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EF681037E3
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 04:09:24 +0100 (CET)
Received: by ewy19 with SMTP id 19so2128987ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 30 Jan 2011 19:09:21 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Reimar.Doeffinger@gmx.de
List-Id: alsa-devel@alsa-project.org

> Clemens Ladisch wrote:

>> Timur Tabi wrote:
>>> It turns out that ALSA (when using mplayer to play a divx video file via OSS
>>> emulation) is rapidly sending back-to-back SNDRV_PCM_TRIGGER_STOP and
>>> SNDRV_PCM_TRIGGER_START commands.  Why would it do that?
>>
>> To recover from underruns.

>I typically get the STOP command just milliseconds before the period ends.  ALSA
>is pretty impatient!  How does ALSA (in OSS emulation mode) know that an
>underrun has occurred?

>> There shouldn't be any difference, but maybe the buffer size of the
>> driver has changed.  Could you show the output of mplayer with the "-v"
>> option for both kernels?

>Unfortunately, I can't seem to get the original kernel to work now, so it's
>broken on all kernels.  Anywhere, here's the mplayer output on out 2.6.23-based
>kernel:

>Linux MPC8610HPCD 2.6.23-6 #20 Thu Nov 8 10:02:21 CST 2007 ppc GNU/Linux:

># mplayer -v -ao oss Cars480_1\[1\].5M.divx
>MPlayer 1.0rc2-3.3.5 (C) 2000-2007 MPlayer Team

>CommandLine: '-v' '-ao' 'oss' 'Cars480_1[1].5M.divx'

>==========================
>Found 'wf', 30 bytes of 18
>======= WAVE Format =======
>Format Tag: 85 (0x55)
>Channels: 2
>Samplerate: 44100
>avg byte/sec: 16000
>Block align: 1
>bits/sample: 0
>cbSize: 12
>mp3.wID=256
>mp3.fdwFlags=0x0
>mp3.nBlockSize=41729
>mp3.nFramesPerBlock=256
>mp3.nCodecDelay=28933


>Opening audio decoder: [mp3lib] MPEG layer-2, layer-3
>dec_audio: Allocating 4608 + 65536 = 70144 bytes for output buffer.
>mp3lib: using AltiVec optimized decore!
>MP3lib: init layer2&3 finished, tables done
>MPEG 1.0, Layer III, 44100 Hz 128 kbit Joint-Stereo, BPF: 418
>Channels: 2, copyright: No, original: No, CRC: No, emphasis: 0
>AUDIO: 44100 Hz, 2 ch, s16be, 128.0 kbit/9.07% (ratio: 16000->176400)
>Selected audio codec: [mp3] afm: mp3lib (mp3lib MPEG layer-2, layer-3)
>==========================================================================
>Building audio filter chain for 44100Hz/2ch/s16be -> 0Hz*/0ch/*??...
>[libaf] Adding filter dummy
>[dummy] Was reinitialized: 44100Hz/2ch/s16be
>[dummy] Was reinitialized: 44100Hz/2ch/s16be
>ao2: 44100 Hz  2 chans  s16be
>audio_setup: using '/dev/dsp' dsp device
>audio_setup: using '/dev/mixer' mixer device
>audio_setup: using 'pcm' mixer device
>audio_setup: sample format: s16be (requested: s16be)
>audio_setup: using 2 channels (requested: 2)
>audio_setup: using 44100 Hz samplerate (requested: 44100)
>audio_setup: frags:   2/2  (4104 bytes/frag)  free:   8208
>AO: [oss] 44100Hz 2ch s16be (2 bytes per sample)
>AO: Description: OSS/ioctl audio output
>AO: Author: A'rpi
>Building audio filter chain for 44100Hz/2ch/s16be -> 44100Hz/2ch/s16be...
>[dummy] Was reinitialized: 44100Hz/2ch/s16be
>[dummy] Was reinitialized: 44100Hz/2ch/s16be
>Starting playback...


I also get shuttering with mplayer SVN-r32829-4.3.2 after mplayer display
"Increasing filtered audio buffer size from 65536 to 67584" using oss
or alsa with sound card which has max buffer bytes 65536 bytes ,
but it does not happen with "pulse" or hda driver with max buffer
bytes > 65536 bytes

dec_audio: Allocating 2048 + 65536 = 67584 bytes for output buffer.

audio_setup: frags:  16/16  (4096 bytes/frag)  free:  65536

2048 bytes is only half of the frag size 4096 bytes

why mplayer increasing filtered audio buffer size by half frag or half
period size ?

it look like related to R24920
Change decode_audio() interface

Rewrite decode_audio to better deal with filters that handle input in
large blocks. It now always places output in sh_audio->a_out_buffer
(which was always given as a parameter before) and reallocates the
buffer if needed. After the changes filters can return arbitrarily
large blocks of data without some of it being lost. The new version
also allows simplifying some code.



mplayer -ao oss stereo.wav

======= WAVE Format =======
Format Tag: 1 (0x1)
Channels: 2
Samplerate: 44100
avg byte/sec: 176400
Block align: 4
bits/sample: 16
cbSize: 0
==========================================================================
demux_audio: audio data 0x2C - 0x308002C
Audio only file format detected.
Load subtitles in ./
get_path('sub/') -> '/home/raymond/.mplayer/sub/'
==========================================================================
Opening audio decoder: [pcm] Uncompressed PCM audio decoder
dec_audio: Allocating 2048 + 65536 = 67584 bytes for output buffer.
AUDIO: 44100 Hz, 2 ch, s16le, 1411.2 kbit/100.00% (ratio: 176400->176400)
Selected audio codec: [pcm] afm: pcm (Uncompressed PCM)
==========================================================================
Building audio filter chain for 44100Hz/2ch/s16le -> 0Hz/0ch/??...
[libaf] Adding filter dummy
[dummy] Was reinitialized: 44100Hz/2ch/s16le
[dummy] Was reinitialized: 44100Hz/2ch/s16le
Trying preferred audio driver 'oss', options '[none]'
ao2: 44100 Hz  2 chans  s16le
audio_setup: using '/dev/dsp' dsp device
audio_setup: using '/dev/mixer' mixer device
audio_setup: using 'pcm' mixer device
audio_setup: sample format: s16le (requested: s16le)
audio_setup: using 2 channels (requested: 2)
audio_setup: using 44100 Hz samplerate (requested: 44100)
audio_setup: frags:  16/16  (4096 bytes/frag)  free:  65536
AO: [oss] 44100Hz 2ch s16le (2 bytes per sample)
AO: Description: OSS/ioctl audio output
AO: Author: A'rpi
Building audio filter chain for 44100Hz/2ch/s16le -> 44100Hz/2ch/s16le...
[dummy] Was reinitialized: 44100Hz/2ch/s16le
[dummy] Was reinitialized: 44100Hz/2ch/s16le
Video: no video
Freeing 0 unused video chunks.
Starting playback...
Increasing filtered audio buffer size from 0 to 65536
A: 127.7 (02:07.6) of 288.0 (04:48.0)  0.1%
Increasing filtered audio buffer size from 65536 to 67584
A: 287.9 (04:47.9) of 288.0 (04:48.0)  0.1%
ds_fill_buffer: EOF reached (stream: audio)
ds_fill_buffer: EOF reached (stream: audio)
A: 287.9 (04:47.9) of 288.0 (04:48.0)  0.1%
ds_fill_buffer: EOF reached (stream: audio)
A: 288.0 (04:47.9) of 288.0 (04:48.0)  0.1%
EOF code: 1

Uninit audio filters...
[libaf] Removing filter dummy
Uninit audio: pcm



mplayer -ao alsa:device=hw=0 stereo.wav


======= WAVE Format =======
Format Tag: 1 (0x1)
Channels: 2
Samplerate: 44100
avg byte/sec: 176400
Block align: 4
bits/sample: 16
cbSize: 0
==========================================================================
demux_audio: audio data 0x2C - 0x308002C
Audio only file format detected.
Load subtitles in ./
get_path('sub/') -> '/home/raymond/.mplayer/sub/'
==========================================================================
Opening audio decoder: [pcm] Uncompressed PCM audio decoder
dec_audio: Allocating 2048 + 65536 = 67584 bytes for output buffer.
AUDIO: 44100 Hz, 2 ch, s16le, 1411.2 kbit/100.00% (ratio: 176400->176400)
Selected audio codec: [pcm] afm: pcm (Uncompressed PCM)
==========================================================================
Building audio filter chain for 44100Hz/2ch/s16le -> 0Hz/0ch/??...
[libaf] Adding filter dummy
[dummy] Was reinitialized: 44100Hz/2ch/s16le
[dummy] Was reinitialized: 44100Hz/2ch/s16le
Trying preferred audio driver 'alsa', options 'device=hw=0'
alsa-init: requested format: 44100 Hz, 2 channels, 9
alsa-init: using ALSA 1.0.23
alsa-init: setup for 1/2 channel(s)
alsa-init: using device hw:0
alsa-init: pcm opened in blocking mode
alsa-init: got buffersize=65536
alsa-init: got period size 1024
alsa: 44100 Hz/2 channels/4 bpf/65536 bytes buffer/Signed 16 bit Little Endian
AO: [alsa] 44100Hz 2ch s16le (2 bytes per sample)
AO: Description: ALSA-0.9.x-1.x audio output
AO: Author: Alex Beregszaszi, Zsolt Barat <joy@streamminister.de>
AO: Comment: under development
Building audio filter chain for 44100Hz/2ch/s16le -> 44100Hz/2ch/s16le...
[dummy] Was reinitialized: 44100Hz/2ch/s16le
[dummy] Was reinitialized: 44100Hz/2ch/s16le
Video: no video
Freeing 0 unused video chunks.
Starting playback...
Increasing filtered audio buffer size from 0 to 65536
A:   3.0 (02.9) of 288.0 (04:48.0)  0.1%
Increasing filtered audio buffer size from 65536 to 67584
A: 287.9 (04:47.9) of 288.0 (04:48.0)  0.1%
ds_fill_buffer: EOF reached (stream: audio)
ds_fill_buffer: EOF reached (stream: audio)
A: 287.9 (04:47.9) of 288.0 (04:48.0)  0.1%
ds_fill_buffer: EOF reached (stream: audio)
A: 288.0 (04:47.9) of 288.0 (04:48.0)  0.1%
EOF code: 1

Uninit audio filters...
[libaf] Removing filter dummy
Uninit audio: pcm
alsa-uninit: pcm closed


mplayer -ao alsa:device=pulse stereo.wav

======= WAVE Format =======
Format Tag: 1 (0x1)
Channels: 2
Samplerate: 44100
avg byte/sec: 176400
Block align: 4
bits/sample: 16
cbSize: 0
==========================================================================
demux_audio: audio data 0x2C - 0x308002C
Audio only file format detected.
Load subtitles in ./
get_path('sub/') -> '/home/raymond/.mplayer/sub/'
==========================================================================
Opening audio decoder: [pcm] Uncompressed PCM audio decoder
dec_audio: Allocating 2048 + 65536 = 67584 bytes for output buffer.
AUDIO: 44100 Hz, 2 ch, s16le, 1411.2 kbit/100.00% (ratio: 176400->176400)
Selected audio codec: [pcm] afm: pcm (Uncompressed PCM)
==========================================================================
Building audio filter chain for 44100Hz/2ch/s16le -> 0Hz/0ch/??...
[libaf] Adding filter dummy
[dummy] Was reinitialized: 44100Hz/2ch/s16le
[dummy] Was reinitialized: 44100Hz/2ch/s16le
Trying preferred audio driver 'alsa', options 'device=pulse'
alsa-init: requested format: 44100 Hz, 2 channels, 9
alsa-init: using ALSA 1.0.23
alsa-init: setup for 1/2 channel(s)
alsa-init: using device pulse
alsa-init: pcm opened in blocking mode
alsa-init: got buffersize=88200
alsa-init: got period size 1378
alsa: 44100 Hz/2 channels/4 bpf/88200 bytes buffer/Signed 16 bit Little Endian
AO: [alsa] 44100Hz 2ch s16le (2 bytes per sample)
AO: Description: ALSA-0.9.x-1.x audio output
AO: Author: Alex Beregszaszi, Zsolt Barat <joy@streamminister.de>
AO: Comment: under development
Building audio filter chain for 44100Hz/2ch/s16le -> 44100Hz/2ch/s16le...
[dummy] Was reinitialized: 44100Hz/2ch/s16le
[dummy] Was reinitialized: 44100Hz/2ch/s16le
Video: no video
Freeing 0 unused video chunks.
Starting playback...
Increasing filtered audio buffer size from 0 to 65536
A: 287.7 (04:47.7) of 288.0 (04:48.0)  0.1%
ds_fill_buffer: EOF reached (stream: audio)
ds_fill_buffer: EOF reached (stream: audio)
A: 287.7 (04:47.7) of 288.0 (04:48.0)  0.1%
ds_fill_buffer: EOF reached (stream: audio)
A: 287.8 (04:47.7) of 288.0 (04:48.0)  0.1%
EOF code: 1

Uninit audio filters...
[libaf] Removing filter dummy
Uninit audio: pcm
alsa-uninit: pcm closed
