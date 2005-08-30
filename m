From: Harald Welte <laforge@gnumonks.org>
Subject: Re: No sound on ATI IXP with Realtek ALC655 rev0 (MSI Megabook S270)
Date: Tue, 30 Aug 2005 15:06:52 +0200
Message-ID: <20050830130652.GI4295@rama.de.gnumonks.org>
References: <200508291419.34270.rene@exactcode.de> <200508301130.42008.rene@exactcode.de> <s5hhdd73glc.wl%tiwai@suse.de> <200508301149.46320.rene@exactcode.de> <s5hek8b3fpu.wl%tiwai@suse.de> <s5h7je33d59.wl%tiwai@suse.de> <20050830122423.GC4295@rama.de.gnumonks.org> <s5hek8bk34d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrvsYIebpInmECXG"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hek8bk34d.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--lrvsYIebpInmECXG
Content-Type: multipart/mixed; boundary="jt0yj30bxbg11sci"
Content-Disposition: inline


--jt0yj30bxbg11sci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 30, 2005 at 02:42:26PM +0200, Takashi Iwai wrote:

> > And unfortunately this patch also doesn't make the speakers work for me,
> > sorry :(
>=20
> Hmm, did you turn on "External Amplifer" mixer switch?

I tried it with enabled and disabled EA mixer switch, no change :(

However, I didn't reboot, I just unloaded snd_atiixp and snd-pcm-ac97
(unpatched), loaded snd-pcm-ac97 (patched) and snd_atiixp on top of it.
Will try a "clean boot" just now.

> Anyway, could you attach the contents of
> /proc/asound/card0/codec97#0/* files again after the patch?

See below.

Thanks!

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--jt0yj30bxbg11sci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=f1

0-0/0: Realtek ALC658 rev 0

Revision         : 0x00
Compat. Class    : 0x00
Subsys. Vendor ID: 0xffff
Subsys. ID       : 0xffff

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Double rate slots: 10/11
Extended ID      : codec=0 rev=2 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=6/9 VRA
PCM front DAC    : 8000Hz
PCM Surr DAC     : 8000Hz
PCM LFE DAC      : 8000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz

--jt0yj30bxbg11sci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=f2

0:00 = 0180
0:02 = 1112
0:04 = 0000
0:06 = 0000
0:08 = 0000
0:0a = 000e
0:0c = 001f
0:0e = 820e
0:10 = 0c0c
0:12 = 0d0d
0:14 = 0000
0:16 = 0d0d
0:18 = 0a0a
0:1a = 0000
0:1c = 0000
0:1e = 8000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 09c7
0:2a = 05e1
0:2c = 1f40
0:2e = 1f40
0:30 = 1f40
0:32 = bb80
0:34 = bb80
0:36 = 1a18
0:38 = 1a1a
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
0:60 = 0000
0:62 = 0000
0:64 = 0808
0:66 = 0808
0:68 = 0aea
0:6a = b001
0:6c = 4601
0:6e = 0002
0:70 = 0008
0:72 = 0000
0:74 = 011f
0:76 = 0000
0:78 = 0007
0:7a = 40b0
0:7c = 414c
0:7e = 4780

--jt0yj30bxbg11sci--

--lrvsYIebpInmECXG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDFFnsXaXGVTD0i/8RAlSXAJ4xRmnkC/estUBQPyn5zG0X7qPyggCfVJPm
TptRKS9HTj91BFLQT/cI9uU=
=l35R
-----END PGP SIGNATURE-----

--lrvsYIebpInmECXG--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
