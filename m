From: Gregoire Favre <greg@ulima.unil.ch>
Subject: Re: SPDIF and cs46xx ?
Date: Wed, 12 Mar 2003 00:35:03 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030311233503.GF10785@ulima.unil.ch>
References: <20030308144119.GB29709@ulima.unil.ch> <3E6A2856.1040602@cucumelo.org> <20030308175244.GA32168@ulima.unil.ch> <s5hu1eb471j.wl@alsa2.suse.de> <20030310144608.GB14537@ulima.unil.ch> <s5hsmtv46kv.wl@alsa2.suse.de> <20030310211540.GA31584@ulima.unil.ch> <s5h65qp3kt8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h65qp3kt8.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 11, 2003 at 05:54:59PM +0100, Takashi Iwai wrote:

> 44.1kHz ac3 ?  then it likely doesn't work because ac3dec assumes
> 48k only.

OK :-(
So I made another ac3 files recording Pro-7 and using ds.jar:
./ac3dec -6 -R /video2/esa1.ac3
2.0 Mode 48.0 KHz 448 kbps Complete Main Audio Service
Using PCM device 'iec958:AES0=3D0x0,AES1=3D0x82,AES2=3D0x0,AES3=3D0x2'

And I can hear in only in stereo... maybe the -6 option is not the right
one?

So I take a DVD with which I am really sure have 5.1, with ds.jar I
demux it and with -R I can hear, but only stereo and with the other
option I can't???

> the spdif device is hw:0,2.
> i guess ther is an option in mplayer to specify the pcm name for
> ALSA.  use "spdif" there instead of "hw:0,2".

Well:

mplayer -vo null -ao alsa9:spdif -abs 1 -channels 2 gives me:

Cache fill:  0.00% (0 bytes)    MPEG-PS file format detected.
VIDEO:  MPEG2  720x576  (aspect 3)  25.00 fps  8750.0 kbps (1093.8
kbyte/s)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Opening audio decoder: [liba52] AC3 decoding with liba52
Using SSE optimized IMDCT transform
AC3: 5.1 (3f+2r+lfe)  48000 Hz  448.0 kbit/s
Using MMX optimized resampler
AUDIO: 48000 Hz, 2 ch, 16 bit (0x10), ratio: 56000->192000 (448.0 kbit)
Selected audio codec: [a52] afm:liba52 (AC3-liba52)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Opening video decoder: [mpegpes] MPEG 1/2 Video passthrough
VDec: vo config request - 720 x 576 (preferred csp: Mpeg PES)
VDec: using Mpeg PES as output csp (no 0)
Movie-Aspect is 1.78:1 - prescaling to correct movie aspect.
VO: [null] 720x576 =3D> 1024x576 Mpeg PES  [fs]
Selected video codec: [mpegpes] vfm:mpegpes (Mpeg PES output (.mpg or
Dxr3/DVB card))
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Checking audio filter chain for 48000Hz/2ch/16bit ->
48000Hz/2ch/16bit...
AF_pre: af format: 2 bps, 2 ch, 48000 hz, little endian signed int=20
AF_pre: 48000Hz 2ch Signed 16-bit (Little-Endian)
alsa-init: testing and bugreports are welcome.
alsa-init: requested format: 48000 Hz, 2 channels, Signed 16-bit
(Little-Endian)
alsa-init: soundcard set to spdif
alsa9: 48000 Hz/2 channels/4 bpf/32768 bytes buffer/Signed 16 bit Little
Endian
AO: [alsa9] 48000Hz 2ch Signed 16-bit (Little-Endian) (2 bps)
Building audio filter chain for 48000Hz/2ch/16bit ->
48000Hz/2ch/16bit...

And I could hear great stereo sound just before, but
mplayer -vo null -ao alsa9:spdif -abs 1 -channels 6 gives me:


MPEG-PS file format detected.
VIDEO:  MPEG2  720x576  (aspect 3)  25.00 fps  8750.0 kbps (1093.8
kbyte/s)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Opening audio decoder: [liba52] AC3 decoding with liba52
Using SSE optimized IMDCT transform
AC3: 5.1 (3f+2r+lfe)  48000 Hz  448.0 kbit/s
Using MMX optimized resampler
AUDIO: 48000 Hz, 6 ch, 16 bit (0x10), ratio: 56000->576000 (448.0 kbit)
Selected audio codec: [a52] afm:liba52 (AC3-liba52)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Opening video decoder: [mpegpes] MPEG 1/2 Video passthrough
VDec: vo config request - 720 x 576 (preferred csp: Mpeg PES)
VDec: using Mpeg PES as output csp (no 0)
Movie-Aspect is 1.78:1 - prescaling to correct movie aspect.
VO: [null] 720x576 =3D> 1024x576 Mpeg PES  [fs]
Selected video codec: [mpegpes] vfm:mpegpes (Mpeg PES output (.mpg or
Dxr3/DVB card))
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Checking audio filter chain for 48000Hz/6ch/16bit ->
48000Hz/6ch/16bit...
AF_pre: af format: 2 bps, 6 ch, 48000 hz, little endian signed int=20
AF_pre: 48000Hz 6ch Signed 16-bit (Little-Endian)
alsa-init: testing and bugreports are welcome.
alsa-init: requested format: 48000 Hz, 6 channels, Signed 16-bit
(Little-Endian)
alsa-init: soundcard set to spdif
alsa-init: unable to set channels: Invalid argument
Could not open/initialize audio device -> no sound.
Audio: no sound

And all I can hear is a sound like "cards on a bike"...

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
