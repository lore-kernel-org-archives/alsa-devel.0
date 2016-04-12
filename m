From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/11] ASoC: hdac_hdmi: Add multichannel support
Date: Tue, 12 Apr 2016 06:54:35 +0100
Message-ID: <20160412055435.GX3351@sirena.org.uk>
References: <1460437293-8509-1-git-send-email-subhransu.s.prusty@intel.com>
 <s5hd1pvidpc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1983948789=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <s5hd1pvidpc.wl-tiwai@suse.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1983948789==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rG8Oha4Ryswg1dZ8"
Content-Disposition: inline


--rG8Oha4Ryswg1dZ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 12, 2016 at 07:43:59AM +0200, Takashi Iwai wrote:

> But the problem is more complicated because you're changing drm stuff,
> too.  This is usually managed in drm tree.  So this cross over three
> different trees.

The DRM folks tend to leave this up to us, or at least review on any of
these crossover patches has been extremely light.

> Do we really need this?  Even the direct reference is pretty much
> obvious.  e.g. I see no big difference between two lines below:
> 	spk_alloc = drm_eld_get_spk_alloc(some_eld);
> 	spk_alloc = some_eld[DRM_ELD_SPAEKER];

That'd make things even easier of course.

--rG8Oha4Ryswg1dZ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDI2aAAoJECTWi3JdVIfQ4usH/RMIeZUF8mK3K/OC2bxx9STJ
MoZfjQUslWPZ8jr1QxGbwFRiGI46rBz40c8i8U5bIEkMXlMbadCfxF+tOyxVRYuV
sWuf27e8Oa41oeY1OycIWF9XXPGoYphy5UKc6QegKX3SM9AkMOaKgksgNG6yEDb2
ui1DQxOK6vUzLADjGGF2d2UXz9QzoMDcUfulK8p7oZkBz8m5oeAZFJ2xjjAbpmG5
GzERPG4RRuNWS7RhgGh+K/STWu5WKnExM2hudjp4iNFC2b7UWRnqExX+UGyHzbT9
L8102tXbi9ybJgNYxdA3RsSw2+lLM7IDnL5sg7FwmuZVSemB/0DTU8Pb8rEYi4g=
=wcJE
-----END PGP SIGNATURE-----

--rG8Oha4Ryswg1dZ8--

--===============1983948789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1983948789==--
