From: Chris <cpollock@embarqmail.com>
Subject: Re: Which project to choose?
Date: Tue, 20 Jul 2010 17:49:50 -0500
Message-ID: <1279666190.18063.53.camel@localhost.localdomain>
References: <1279062131.24837.22.camel@localhost.localdomain>
	<AANLkTikEf4gf-oeQf4hNGUEvNi0YVrvutnSMCbxGwtJ8@mail.gmail.com>
	<1279065709.24837.29.camel@localhost.localdomain>
	<AANLkTimdM5__SzYFxrQqwsbOrxdit2uWOvkazPvZ4PND@mail.gmail.com>
	<1279071115.29042.0.camel@localhost.localdomain>
	<AANLkTimNSRELBq7i1Ypi9K2tmFu9NKLvQAOOqPwuU13x@mail.gmail.com>
	<1279074303.29042.3.camel@localhost.localdomain>
	<AANLkTimNYxIm9M6Mglrzh3YtJRiq1C8wdZwx-JUhLk9d@mail.gmail.com>
	<1279145758.29042.11.camel@localhost.localdomain>
	<AANLkTinN15BWNC2cn78rc5xCSXNo79SDE2_WkBNEg5I2@mail.gmail.com>
	<1279157921.2668.1.camel@localhost.localdomain>
	<i1n0mf$87c$1@dough.gmane.org>
	<AANLkTil8Zq_uJrdT2jcVSSDW-LN0OxpnHcGnI9aBR4Zz@mail.gmail.com>
	<1279508164.22741.27.camel@localhost.localdomain>
	<AANLkTilHj1RR50u0kN7cedIuV72qxqvTX1YDriT6ajqi@mail.gmail.com>
	<i210af$6gi$1@dough.gmane.org>
	<1279579946.18063.26.camel@localhost.localdomain>
	<AANLkTinIcGY_OwOftiZwICap7r_4VviWKqE-2zOZrgQM@mail.gmail.com>
	<1279592026.18063.44.camel@localhost.localdomain>
	<AANLkTimcx0Z1pkLJmCrpmBfo2xLA_Dtt-RG4L6V-JTGf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3228451074238314937=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay.embarq.synacor.com (mailrelay.embarq.synacor.com
	[208.47.184.3]) by alsa0.perex.cz (Postfix) with ESMTP id EC37C2436E
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 00:49:52 +0200 (CEST)
In-Reply-To: <AANLkTimcx0Z1pkLJmCrpmBfo2xLA_Dtt-RG4L6V-JTGf@mail.gmail.com>
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


--===============3228451074238314937==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-ZVnAkIkVn/+1s/mvt5f4"


--=-ZVnAkIkVn/+1s/mvt5f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-07-20 at 19:41 +0800, Raymond Yau wrote:

> >
> AFAIK , mplayer does not support CD playback ? ( seem only VCD or DVD )
>=20
> most likely mandriva had patched the shortcut of gmplayer to use padsp an=
d
> that 's why you can see "OSS Emulation[mplayer]" in the pulseaudio log
>=20
> How about using ALSA OSS emulation instead of padsp ?
>=20
> mplayer -v -ao oss any.wav
>=20
>=20
> Trying preferred audio driver 'oss', options '[none]'
> ao2: 44100 Hz  2 chans  s16le
> audio_setup: using '/dev/dsp' dsp device
> audio_setup: using '/dev/mixer' mixer device
> audio_setup: using 'pcm' mixer device
> audio_setup: sample format: s16le (requested: s16le)
> audio_setup: using 2 channels (requested: 2)
> audio_setup: using 44100 Hz samplerate (requested: 44100)
> audio_setup: frags:  16/16  (4096 bytes/frag)  free:  65536
>=20
>=20
> This force mplayer to use power two period size (4096 bytes) and this may
> meet the requirement of ens1371 if PCI data transfer are 8 Long bytes bru=
st
> transfer
>=20
> 5.5 PCI Data transfer
>=20
> Only brust read/write transfers are allowed. All data transfer are 8 Long
> Word brust transfers
>=20
> As your PA server using period size 1102  which is not multiple of 8 ( 32
> bytes )
>=20
> It seem that you have customised the deamon.conf since PA server using
> maximum buffer size
>=20
> The sound quality seem ok when playing audio using mplayer inside the
> virtualbox
>=20
> The following messages sometime come up at the beginning of the playback
> only when watching videos using mplayer -ao alsa:device=3Dpulse
>=20
> ao_alsa: write error: Broken pipe
> ao_alsa: trying to *reset* *soundcard*
> ao_alsa: write error: Broken pipe
> ao_alsa: trying to *reset* *soundcard*
>=20
> The sound quality is still fine when watching video using
>=20
> mplayer -v -ao alsa:device=3Dpulse
> mplayer -v -ao alsa:device=3Dhw=3D0
> mplayer -v -ao pulse
> mplayer -v ao oss
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Here's the output of the above:
[chris@localhost Documents]$ mplayer -v -ao oss gotmail00.wav
MPlayer SVN-1.rc4.0.r31086.3plf2010.1-4.4.3 (C) 2000-2010 MPlayer Team
CPU vendor name: AuthenticAMD  max cpuid level: 1
CPU: AMD Sempron(tm) Processor 2800+ (Family: 15, Model: 44, Stepping:
2)
extended cpuid-level: 24
extended cache-info: 16810304
Detected cache-line size is 64 bytes
Testing OS support for SSE... yes.
Tests of OS support for SSE passed.
CPUflags:  MMX: 1 MMX2: 1 3DNow: 1 3DNowExt: 1 SSE: 1 SSE2: 1 SSSE3: 0
Compiled with runtime CPU detection.
get_path('codecs.conf') -> '/home/chris/.mplayer/codecs.conf'
Reading /home/chris/.mplayer/codecs.conf: Can't open
'/home/chris/.mplayer/codecs.conf': No such file or directory
Reading /etc/mplayer/codecs.conf: Can't open '/etc/mplayer/codecs.conf':
No such file or directory
Using built-in default codecs.conf.
Configuration: --prefix=3D/usr --datadir=3D/usr/share/mplayer
--confdir=3D/etc/mplayer --libdir=3D/usr/lib --enable-largefiles
--enable-runtime-cpudetection --enable-mmx --enable-3dnow --enable-sse
--enable-sse2 --enable-fastmemcpy --enable-freetype --enable-nas
--disable-sighandler --enable-gui --language=3Dall
--disable-libdvdcss-internal --enable-lirc --enable-tv --enable-joystick
--enable-gl --disable-svga --enable-directfb --enable-mencoder
--enable-theora --enable-menu --disable-ggi --codecsdir=3D/usr/lib/codecs
--disable-arts --enable-pulse --disable-openal --enable-zr --enable-xvmc
--disable-ivtv
CommandLine: '-v' '-ao' 'oss' 'gotmail00.wav'
init_freetype
Using MMX (with tiny bit MMX2) Optimized OnScreenDisplay
get_path('fonts') -> '/home/chris/.mplayer/fonts'
Using nanosleep() timing
get_path('input.conf') -> '/home/chris/.mplayer/input.conf'
Can't open input config file /home/chris/.mplayer/input.conf: No such
file or directory
Can't open input config file /etc/mplayer/input.conf: No such file or
directory
Falling back on default (hardcoded) input config
Opening joystick device /dev/input/js0
Can't open joystick device /dev/input/js0: No such file or directory
Can't init input joystick
Setting up LIRC support...
mplayer: could not connect to socket
mplayer: No such file or directory
Failed to open LIRC support. You will not be able to use your remote
control.
get_path('gotmail00.wav.conf') ->
'/home/chris/.mplayer/gotmail00.wav.conf'

Playing gotmail00.wav.
get_path('sub/') -> '/home/chris/.mplayer/sub/'
[file] File size is 9946 bytes
STREAM: [file] gotmail00.wav
STREAM: Description: File
STREAM: Author: Albeu
STREAM: Comment: based on the code from ??? (probably Arpi)
LAVF_check: WAV format
Checking for YUV4MPEG2
ASF_check: not ASF guid!
Checking for REAL
Checking for SMJPEG
Searching demuxer type for filename gotmail00.wav ext: .wav
Trying demuxer 17 based on filename extension
=3D=3D> Found audio stream: 0
=3D=3D=3D=3D=3D=3D=3D WAVE Format =3D=3D=3D=3D=3D=3D=3D
Format Tag: 1 (0x1)
Channels: 1
Samplerate: 11000
avg byte/sec: 11000
Block align: 1
bits/sample: 8
cbSize: 0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
demux_audio: audio data 0x2C - 0x26D9 =20
Audio only file format detected.
get_path('sub/') -> '/home/chris/.mplayer/sub/'
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Opening audio decoder: [pcm] Uncompressed PCM audio decoder
dec_audio: Allocating 2048 + 65536 =3D 67584 bytes for output buffer.
AUDIO: 11000 Hz, 1 ch, u8, 88.0 kbit/100.00% (ratio: 11000->11000)
Selected audio codec: [pcm] afm: pcm (Uncompressed PCM)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Building audio filter chain for 11000Hz/1ch/u8 -> 0Hz/0ch/??...
[libaf] Adding filter dummy=20
[dummy] Was reinitialized: 11000Hz/1ch/u8
[dummy] Was reinitialized: 11000Hz/1ch/u8
Trying preferred audio driver 'oss', options '[none]'
ao2: 11000 Hz  1 chans  u8
audio_setup: using '/dev/dsp' dsp device
audio_setup: using '/dev/mixer' mixer device
audio_setup: using 'pcm' mixer device
audio_setup: sample format: u8 (requested: u8)
audio_setup: using 1 channels (requested: 1)
audio_setup: using 11000 Hz samplerate (requested: 11000)
audio_setup: frags:   2/2  (8192 bytes/frag)  free:  16384
AO: [oss] 11000Hz 1ch u8 (1 bytes per sample)
AO: Description: OSS/ioctl audio output
AO: Author: A'rpi
Building audio filter chain for 11000Hz/1ch/u8 -> 11000Hz/1ch/u8...
[dummy] Was reinitialized: 11000Hz/1ch/u8
[dummy] Was reinitialized: 11000Hz/1ch/u8
Video: no video
Freeing 0 unused video chunks.
Starting playback...
ds_fill_buffer: EOF reached (stream: audio) =20
ds_fill_buffer: EOF reached (stream: audio) =20
Increasing filtered audio buffer size from 0 to 9901
ds_fill_buffer: EOF reached (stream: audio) =20
ds_fill_buffer: EOF reached (stream: audio) =20
EOF code: 1  9) of 0.9 (00.9)  0.0%=20

Uninit audio filters...
[libaf] Removing filter dummy=20
Uninit audio: pcm
vo: x11 uninit called but X11 not initialized..


--=20
Chris
KeyID 0xE372A7DA98E6705C


--=-ZVnAkIkVn/+1s/mvt5f4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkxGKA4ACgkQ43Kn2pjmcFwpdACfdqxfpteYujfdXdKUIlO0lknI
JHgAn0Mp2YU8Hr3x84Xz0TibrQWynEME
=HZ4E
-----END PGP SIGNATURE-----

--=-ZVnAkIkVn/+1s/mvt5f4--


--===============3228451074238314937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3228451074238314937==--
