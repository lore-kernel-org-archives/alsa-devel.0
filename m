From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC and pulseaudio
Date: Tue, 15 Mar 2016 08:45:44 +0000
Message-ID: <20160315084544.GF2566@sirena.org.uk>
References: <CAL9uMOHRjcCJomr6zzR0ySh384AVj1FRvASZSp3KsPqfeS8Lzw@mail.gmail.com>
 <56C8AEFD.4060808@linux.intel.com> <1456225994.6424.35.camel@loki>
 <B51200AC81AB024499A3C2C9A1BB90A83D3AABF9@SHSMSX101.ccr.corp.intel.com>
 <1457943567.3888.18.camel@loki>
 <20160314160654.GA2566@sirena.org.uk>
 <1458021688.8522.16.camel@loki>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0134843400=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <1458021688.8522.16.camel@loki>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Linux Upstreaming Team <linux@endlessm.com>, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, "han.lu" <han.lu@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0134843400==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CXFpZVxO6m2Ol4tQ"
Content-Disposition: inline


--CXFpZVxO6m2Ol4tQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 15, 2016 at 06:01:28AM +0000, Liam Girdwood wrote:

> 1) Shortname is board/machine name. This can come from DMI or device
> tree. e.g. "Asus T100"

That seems more useful for users.

> 2) Long name is 1 + driver name + optional firmware name. (I've just
> added the FW name here too as we can have potentially > 1 FW per driver
> - BYT is an example) e.g. "Asus T00: byt-rt5640: IntSST1.bin".

Shouldn't we use whatever we use to figure out which firmware to load
rather than the firmware name?  Someone might do something like try to
replace one firmware with another and get everything confused.

--CXFpZVxO6m2Ol4tQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW58u3AAoJECTWi3JdVIfQZpgH/1WMhZCqrYDitwQGxrvuY72T
CsMOQQKJMsXSANOGw4sPUB/ubQm6E5XoUlAs2+0tQUxLvCIETSf4XCm4WK2FRljP
NvsAwCFb0kUXZBZu6uxPjNIBWq5641HPb8Q9CQsYyL63CVXav9YLNgWIBcSwBC9c
YoLq9J4271zK4N5tgFoXu0HcZiGismwmp6SMvfx0rM44nihXnRCAiuCnUy3f5PAQ
KIK8/JgRqTLfdRIQeKfFcwhpERTewn7N+Frj1vV2iJtkFpG0Md3wu+XCE57zcqFT
0VRfXSjtjDMydUjx8EKZ59MVJKOj5Bcd4Qs9Nx3+ml2ictV28qzaCU2dDDQtrvc=
=a04b
-----END PGP SIGNATURE-----

--CXFpZVxO6m2Ol4tQ--

--===============0134843400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vcHVs
c2VhdWRpby1kaXNjdXNzCg==

--===============0134843400==--
