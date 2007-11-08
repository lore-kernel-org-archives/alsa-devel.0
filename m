From: Timur Tabi <timur@freescale.com>
Subject: Re: Any OSS changes from kernel 2.6.21 to 2.6.23?
 Something broke.
Date: Thu, 08 Nov 2007 11:35:31 -0600
Message-ID: <473348E3.3060404@freescale.com>
References: <472B4416.8060009@freescale.com> <s5hfxzkwyvo.wl%tiwai@suse.de>
	<47325517.2000407@freescale.com>
	<1194507244.16131.1220189539@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E60D2492C
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 18:37:37 +0100 (CET)
In-Reply-To: <1194507244.16131.1220189539@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Timur Tabi wrote:
>> It turns out that ALSA (when using mplayer to play a divx video file via OSS 
>> emulation) is rapidly sending back-to-back SNDRV_PCM_TRIGGER_STOP and 
>> SNDRV_PCM_TRIGGER_START commands.  Why would it do that?
> 
> To recover from underruns.

I typically get the STOP command just milliseconds before the period ends.  ALSA 
is pretty impatient!  How does ALSA (in OSS emulation mode) know that an 
underrun has occurred?

> There shouldn't be any difference, but maybe the buffer size of the
> driver has changed.  Could you show the output of mplayer with the "-v"
> option for both kernels?

Unfortunately, I can't seem to get the original kernel to work now, so it's 
broken on all kernels.  Anywhere, here's the mplayer output on out 2.6.23-based 
kernel:

Linux MPC8610HPCD 2.6.23-6 #20 Thu Nov 8 10:02:21 CST 2007 ppc GNU/Linux:

# mplayer -v -ao oss Cars480_1\[1\].5M.divx
MPlayer 1.0rc2-3.3.5 (C) 2000-2007 MPlayer Team
AltiVec found
CPU: PowerPC
get_path('codecs.conf') -> '/root/.mplayer/codecs.conf'
Reading /root/.mplayer/codecs.conf: Can't open '/root/.mplayer/codecs.conf': No
such file or directory
Reading /usr/local/etc/mplayer/codecs.conf: Can't open 
'/usr/local/etc/mplayer/codecs.conf': No such file or directory
Using built-in default codecs.conf.
Configuration:
CommandLine: '-v' '-ao' 'oss' 'Cars480_1[1].5M.divx'
get_path('font/font.desc') -> '/root/.mplayer/font/font.desc'
font: can't open file: /root/.mplayer/font/font.desc
font: can't open file: /usr/local/share/mplayer/font/font.desc
Using Unoptimized OnScreenDisplay
Using nanosleep() timing
get_path('input.conf') -> '/root/.mplayer/input.conf'
Can't open input config file /root/.mplayer/input.conf: No such file or directory
Can't open input config file /usr/local/etc/mplayer/input.conf: No such file or
directory
Falling back on default (hardcoded) input config
get_path('Cars480_1[1].5M.divx.conf') -> '/root/.mplayer/Cars480_1[1].5M.divx.conf'

Playing Cars480_1[1].5M.divx.
get_path('sub/') -> '/root/.mplayer/sub/'
[file] File size is 11142774 bytes
STREAM: [file] Cars480_1[1].5M.divx
STREAM: Description: File
STREAM: Author: Albeu
STREAM: Comment: based on the code from ??? (probably Arpi)
LAVF_check: avi format
AVI file format detected.
list_end=0x264
======= AVI Header =======
us/frame: 41710  (fps=23.975)
max bytes/sec: 0
padding: 0
MainAVIHeader.dwFlags: (272) HAS_INDEX IS_INTERLEAVED
frames  total: 1319   initial: 0
streams: 2
Suggested BufferSize: 0
Size:  848 x 352
==========================
list_end=0xDC
==> Found video stream: 0
[aviheader] Video stream found, -vid 0
====== STREAM Header =====
Type: sdiv   FCC: XVID (58564944)
Flags: 0
Priority: 0   Language: 0
InitialFrames: 0
Rate: 23975/1000 = 23.975
Start: 0   Len: 1319
Suggested BufferSize: 93750
Quality 0
Sample size: 0
==========================
Found 'bih', 40 bytes of 40
======= VIDEO Format ======
   biSize 40
   biWidth 848
   biHeight 352
   biPlanes 1
   biBitCount 24
   biCompression 808802372='05XD'
   biSizeImage 895488
===========================
Regenerating keyframe table for MPEG-4 video.
list_end=0x15C
==> Found audio stream: 1
[aviheader] Audio stream found, -aid 1
====== STREAM Header =====
Type: sdua   FCC:  (0)
Flags: 0
Priority: 0   Language: 0
InitialFrames: 1
Rate: 16000/1 = 16000.000
Start: 0   Len: 879574
Suggested BufferSize: 8000
Quality -1
Sample size: 1
==========================
Found 'wf', 30 bytes of 18
======= WAVE Format =======
Format Tag: 85 (0x55)
Channels: 2
Samplerate: 44100
avg byte/sec: 16000
Block align: 1
bits/sample: 0
cbSize: 12
mp3.wID=256
mp3.fdwFlags=0x0
mp3.nBlockSize=41729
mp3.nFramesPerBlock=256
mp3.nCodecDelay=28933
==========================================================================
list_end=0x264
AVI: dmlh found (size=244) (total_frames=1319)
list_end=0xA9624E
Found movie at 0x80C - 0xA9624E
Reading INDEX block, 2626 chunks for 1319 frames (fpos=11100758).
AVI index offset: 0x808 (movi=0x80C idx0=0x4 idx1=0x1F4C)
Auto-selected AVI audio ID = 1
Auto-selected AVI video ID = 0
AVI: Searching for audio stream (id:1)
AVI video size=10196805 (1319) audio size=879574 (879574)
VIDEO:  [DX50]  848x352  24bpp  23.975 fps  1482.7 kbps (181.0 kbyte/s)
[V] filefmt:3  fourcc:0x30355844  size:848x352  fps:23.98  ftime:=0.0417
get_path('sub/') -> '/root/.mplayer/sub/'
using /dev/fb0
==========================================================================
Opening video decoder: [ffmpeg] FFmpeg's libavcodec codec family
INFO: libavcodec init OK!
Selected video codec: [ffodivx] vfm: ffmpeg (FFmpeg MPEG-4)
==========================================================================
==========================================================================
Opening audio decoder: [mp3lib] MPEG layer-2, layer-3
dec_audio: Allocating 4608 + 65536 = 70144 bytes for output buffer.
mp3lib: using AltiVec optimized decore!
MP3lib: init layer2&3 finished, tables done
MPEG 1.0, Layer III, 44100 Hz 128 kbit Joint-Stereo, BPF: 418
Channels: 2, copyright: No, original: No, CRC: No, emphasis: 0
AUDIO: 44100 Hz, 2 ch, s16be, 128.0 kbit/9.07% (ratio: 16000->176400)
Selected audio codec: [mp3] afm: mp3lib (mp3lib MPEG layer-2, layer-3)
==========================================================================
Building audio filter chain for 44100Hz/2ch/s16be -> 0Hz/0ch/??...
[libaf] Adding filter dummy
[dummy] Was reinitialized: 44100Hz/2ch/s16be
[dummy] Was reinitialized: 44100Hz/2ch/s16be
ao2: 44100 Hz  2 chans  s16be
audio_setup: using '/dev/dsp' dsp device
audio_setup: using '/dev/mixer' mixer device
audio_setup: using 'pcm' mixer device
audio_setup: sample format: s16be (requested: s16be)
audio_setup: using 2 channels (requested: 2)
audio_setup: using 44100 Hz samplerate (requested: 44100)
audio_setup: frags:   2/2  (4104 bytes/frag)  free:   8208
AO: [oss] 44100Hz 2ch s16be (2 bytes per sample)
AO: Description: OSS/ioctl audio output
AO: Author: A'rpi
Building audio filter chain for 44100Hz/2ch/s16be -> 44100Hz/2ch/s16be...
[dummy] Was reinitialized: 44100Hz/2ch/s16be
[dummy] Was reinitialized: 44100Hz/2ch/s16be
Starting playback...
Compiler did not align stack variables. Libavcodec has been miscompiled
and may be very slow or crash. This is not a bug in libavcodec,
but in the compiler. You may try recompiling using gcc >= 4.2.
Do not report crashes to FFmpeg developers.
[ffmpeg] aspect_ratio: 2.409091
VDec: vo config request - 848 x 352 (preferred colorspace: Planar YV12)
Trying filter chain: vo
Could not find matching colorspace - retrying with -vf scale...
Opening video filter: [scale]
SwScale params: -1 x -1 (-1=no scaling)
Trying filter chain: scale vo
VDec: using Planar YV12 as output csp (no 0)
Movie-Aspect is 2.41:1 - prescaling to correct movie aspect.
VO Config (848x352->848x352,flags=0,'MPlayer',0x32315659)
[swscaler @ 0x1068d964]ALTIVEC: Color Space ARGB
[swscaler @ 0x1068d964]SwScaler: using unscaled yuv420p -> rgb32 special converter
REQ: flags=0x403  req=0x0
VO: [fbdev] 848x352 => 848x352 ARGB
VO: Description: Framebuffer Device
VO: Author: Szabolcs Berecz <szabi@inf.elte.hu>
Can't set graphics mode: Invalid argument
var info:
xres: 1280
yres: 1024
xres_virtual: 1280
yres_virtual: 1024
xoffset: 0
yoffset: 0
bits_per_pixel: 32
grayscale: 0
red: 16 8 0
green: 8 8 0
blue: 0 8 0
transp: 24 8 0
nonstd: 10
fix info:
framebuffer size: 5242880 bytes
type: 0
type_aux: 0
visual: 2
line_length: 5120 bytes
fb_bpp: 32
fb_pixel_size: 4 bytes
other:
in_width: 848
in_height: 352
out_width: 848
out_height: 352
first_row: 0
last_row: 352
Uninit video: ffmpeg

-- 
Timur Tabi
Linux kernel developer at Freescale
