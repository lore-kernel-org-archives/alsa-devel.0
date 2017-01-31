From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 4/8] ASoC: sun8i-codec-analog: Add
 amplifier event to fix first delay
Date: Tue, 31 Jan 2017 11:35:19 +0100
Message-ID: <20170131103519.5g5tmnwwyjz47zds@lukather>
References: <20170131100552.27949-1-mylene.josserand@free-electrons.com>
 <20170131100552.27949-5-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1934993176006559885=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id ACDD0267268
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 11:35:30 +0100 (CET)
In-Reply-To: <20170131100552.27949-5-mylene.josserand@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, wens@csie.org, broonie@kernel.org, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1934993176006559885==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kp5ixcuwysryccq6"
Content-Disposition: inline


--kp5ixcuwysryccq6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2017 at 11:05:48AM +0100, Myl=E8ne Josserand wrote:
> When playing a sound for the first time, a short delay, where the audio
> file is not played, can be noticed.
> On a second play (right after), the sound is played correctly.
> If we wait a short time (~5 sec which corresponds to the aplay
> timeout), the delay is back.
>=20
> This patch fixes it by using an event on headphone amplifier.
> It allows to keep the amplifier enable while playing a sound.
> A delay of 700ms allows to wait that the amplifier is powered-up
> before playing the sound.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--kp5ixcuwysryccq6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIbBAEBCAAGBQJYkGhnAAoJEBx+YmzsjxAgHPgP9R5pyLo+1PKh5MTmfLBGm1Q0
8eynv+kUw06+j48d4B6vprBhi1lUq1BhrsJwKVuKATS7UgmGLQTXYjkAWVw+3gp6
zGj08zRpS6/OltuASeL7ZJVw/clwdNCHvPvHeAyBS4BAXoq8r8qQv8skFVg34dFJ
O/rP2O3kcoWCtFPEZlLvcvnTbmtpUuZgNOCEMveryk0GcPXnRbERojUIaRGrUjA3
HCbvx7px2L2I5yZEHfzlewAP3VjUKzNFFt30K+y4TpUPIPUM8dt8Gm1hi8lZg3w5
VSey2xDrYeSbf4HmYcSO87Pmhs52hj5mG3GKOtRjb36DFd1z7qmw+Q1+Btm48xgP
y35DIZ8DOaqM3OBrnDM998c4Swi7bGLe9+Aj/c1wxbGtWDi/4zIb4dThfnlHEUpA
n4DJdpMavuUwu6kONk/9rnBsZAC+DNxJIA7NdPN95IK/nHKdMErHP7bWDp5SfIFF
TuxgSzdJr0/LoEttx0Z4pgBBNsLQEoVaNm8hlSHjcQe71kV62AIULU3SfoIy5xEO
UMDyTEjxiTe/964jUyJIQN3RSdQjq+zsMU2Hi2o8uMzll97jHus7C9YqW4K84hoN
mZNdH53H13r6PGVKZ3S/oAUkPX2qt+mAV/9b9pqcIgGns3ZuyytgDYQkRWih0paE
qzXPB//lZlYaQjF0ZeI=
=xZ6j
-----END PGP SIGNATURE-----

--kp5ixcuwysryccq6--

--===============1934993176006559885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1934993176006559885==--
