From: Andreas Bulling <uek32z@phoenix.hadiko.de>
Subject: Re: problems with Terratec Aureon Sky 5.1
Date: Mon, 15 Mar 2004 19:04:50 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040315180450.GA12227@phoenix.hadiko.de>
References: <20040314164136.GA24447@phoenix.hadiko.de> <Pine.LNX.4.58.0403141751370.3332@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403141751370.3332@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 14, 2004 at 05:59:38PM +0100, Jaroslav Kysela wrote:
| [...]=20
| So, you need something like:
|=20
| pcm.duplicate {
| 	type plug
| 	slave.pcm "surround51"
| 	route_policy duplicate
| }
|=20
| And now, 'aplay -Dduplicate' will duplicate stream to all six channels.

|| On Sun, 14 Mar 2004, Andreas Bulling wrote:
|| > Hm... I tried that but it doesn't work - still sound only out of the f=
ront speakers with
|| > xmms and the duplicate output device. Do I need anything else?
||
|| If you have volumes up, then it should work.

Well, as I reported it didn't. But I made progress in the meanwhile:
Using "copy" didn't work either but adding "slave.channels 6" to your
config results in output also from the two rear speakers. YEAH! ;)
That means I can use this smaller config instead of my old and bigger
"ttable one" for stereo sources (device duplicate in xmms)
Problem fixed: YES [X]

Nevertheless, playing real 5.1 sound still doesn't work.
I was able to get it by using=20
"gmplayer dvd://1 -v -aid 128 -ao oss -channels 6"
but I would like to get it to work also with alsa.

What I tried next was using the following config and
"gmplayer dvd://1 -v -aid 128 -ao alsa9:default -channels 6"

---------------------------
pcm.!default {
    type plug
    slave ice1724_S32_LE;
}

pcm_slave.ice1724_S32_LE {
        pcm surround51;
        format S32_LE;
}
---------------------------

Also a little progress: Sound out of all 6 speakers without further
configuration. But unfortunately the channels got mixed up:
Gandalf is talking out of the left rear channel, now :(
Without "-channels 6" no more sound out of both rear speakers...

How can I check the assignment of channels and speakers and
how can I modify them?

That's the output using the "-channels 6" option:
---------------------------
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Opening audio decoder: [liba52] AC3 decoding with liba52
dec_audio: Allocating 3840 bytes for input buffer.
dec_audio: Allocating 18432 + 65536 =3D 83968 bytes for output buffer.
Using SSE optimized IMDCT transform
AC3: 5.1 (3f+2r+lfe)  48000 Hz  448,0 kbit/s
A52 flags before a52_frame: 0x37
A52 flags after a52_frame: 0x17
Using MMX optimized resampler
AUDIO: 48000 Hz, 6 ch, 16 bit (0x10), ratio: 56000->576000 (448,0 kbit)
Selected audio codec: [a52] afm:liba52 (AC3-liba52)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Opening video decoder: [mpegpes] MPEG 1/2 Video passthrough
VDec: vo config request - 720 x 576 (preferred csp: Mpeg PES)
Trying filter chain: vo
Could not find matching colorspace - retrying with -vf scale...
Opening video filter: [scale]
SwScale params: -1 x -1 (-1=3Dno scaling)
Trying filter chain: scale vo
The selected video_out device is incompatible with this codec.
VDecoder init failed :(
Opening video decoder: [libmpeg2] MPEG 1/2 Video decoder libmpeg2-v0.3.1
Selected video codec: [mpeg12] vfm:libmpeg2 (MPEG 1 or 2 (libmpeg2))
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Checking audio filter chain for 48000Hz/6ch/16bit -> 48000Hz/6ch/16bit...
[libaf] Adding filter dummy
[dummy] Was reinitialized, rate=3D48000Hz, nch =3D 6, format =3D 0x00000001=
 and bps =3D 2
AF_pre: af format: 2 bps, 6 ch, 48000 hz, little endian signed int
AF_pre: 48000Hz 6ch Signed 16-bit (Little-Endian)
alsa-init: requested format: 48000 Hz, 6 channels, Signed 16-bit (Little-En=
dian)
alsa-init: compiled for ALSA-1.0.3
alsa-init: soundcard set to default
alsa-init: pcm opend in block-mode
alsa-init: chunksize set to 1024
alsa-init: current val=3D11, fragcount=3D11
alsa-init: unable to set periods: Das Argument ist ung=FCltig
alsa-init: got buffersize=3D131040
alsa9: 48000 Hz/6 channels/12 bpf/131040 bytes buffer/Signed 16 bit Little =
Endian
AO: [alsa9] 48000Hz 6ch Signed 16-bit (Little-Endian) (2 bps)
AO: Description: ALSA-0.9.x audio output
AO: Author: Alex Beregszaszi, Joy Winter <joy@pingfm.org>
AO: Comment: under developement
Building audio filter chain for 48000Hz/6ch/16bit -> 48000Hz/6ch/16bit...
[dummy] Was reinitialized, rate=3D48000Hz, nch =3D 6, format =3D 0x00000001=
 and bps =3D 2
[dummy] Was reinitialized, rate=3D48000Hz, nch =3D 6, format =3D 0x00000001=
 and bps =3D 2
Starting playback...
alsa-space: free space =3D 131040, status=3D141277936, prepared --
=3D=3D> Found audio stream: 129
=3D=3D> Found audio stream: 130
VDec: vo config request - 720 x 576 (preferred csp: Planar YV12)
Trying filter chain: vo
VDec: using Planar YV12 as output csp (no 0)
Movie-Aspect is 1,78:1 - prescaling to correct movie aspect.
VO Config (720x576->1024x576,flags=3D0,'MPlayer',0x32315659)
VO: [xv] 720x576 =3D> 1024x576 Planar YV12
VO: Description: X11/Xv
VO: Author: Gerd Knorr <kraxel@goldbach.in-berlin.de> and others
Xvideo image format: 0x32595559 (YUY2) packed
Xvideo image format: 0x59565955 (UYVY) packed
Xvideo image format: 0x32315659 (YV12) planar
Xvideo image format: 0x30323449 (I420) planar
using Xvideo port 70 for hw scaling
[xv] dx: 0 dy: 0 dw: 1024 dh: 614
*** [vo] Allocating mp_image_t, 720x576x12bpp YUV planar, 622080 bytes
[xv] dx: 0 dy: 0 dw: 1024 dh: 576
alsa-control: unable to find simple control 'PCM',0 0%  0%  0,0% 0 0 23%
*** [vo] Allocating mp_image_t, 720x576x12bpp YUV planar, 622080 bytes
alsa-control: unable to find simple control 'PCM',0 0%  0%  0,0% 0 0 22%
*** [vo] Allocating mp_image_t, 720x576x12bpp YUV planar, 622080 bytes
alsa-control: unable to find simple control 'PCM',0 0%  0%  0,0% 0 0 21%
alsa-control: unable to find simple control 'PCM',0 0%  0%  0,0% 0 0 21%
alsa-control: unable to find simple control 'PCM',0 0%  0%  0,0% 0 0 21%
alsa-control: unable to find simple control 'PCM',0 0%  0%  0,0% 0 0 21%
alsa-control: unable to find simple control 'PCM',0 0%  0%  0,0% 0 0 21%
alsa-control: unable to find simple control 'PCM',0 0%  0%  0,0% 0 0 21%
alsa-control: unable to find simple control 'PCM',0 0%  0%  0,0% 0 0 21%
[and so on...]
---------------------------

Thanks,
Andreas=20


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
