From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] clk: bcm2835: enable management of PCM clock
Date: Sun, 10 Jan 2016 11:58:58 +0000
Message-ID: <20160110115858.GV6588@sirena.org.uk>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
 <1452331558-2520-3-git-send-email-kernel@martin.sperl.org>
 <4332640.jBKM55TPAo@wuerfel>
 <CAMuHMdWOt4aCzu8Ode0ZrQ-c80nqAhwD5dd17nhgVbLrRYT5og@mail.gmail.com>
 <4B891DE1-6340-4D3D-BEE3-F61D9A5D289B@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iFtobK8oO579scb0"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4B891DE1-6340-4D3D-BEE3-F61D9A5D289B@martin.sperl.org>
Sender: linux-clk-owner@vger.kernel.org
To: Martin Sperl <kernel@martin.sperl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Remi Pommarel <repk@triplefau.lt>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Matthias Reichl <hias@horus.com>, lFlorian Meier <florian.meier@koalo.de>
List-Id: alsa-devel@alsa-project.org


--iFtobK8oO579scb0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 10, 2016 at 11:55:48AM +0100, Martin Sperl wrote:

> So if someone with a better idea how to keep those dt-binding includes
> synchronized with the definitions used by the code step forward and
> propose a better solution how to get that implemented?

> I guess there will be a few more occurrences of clocks that are
> currently not defined, which will need to get introduced in the future
> PWM and PCM were just the last in this series.

Presumably just making the code not rely on having a define for the
number of clocks would deal with the problem (eg, using ARRAY_SIZE
internally).

--iFtobK8oO579scb0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWkkeCAAoJECTWi3JdVIfQWOAH/2E/d7rl4agqhkmZevCjxAkS
TaESt6F6YFn308HEuTvcBlqOP5YEvoCZ1rJ8wlkXC1LUdISEknBXaqY2XIHioe2P
mF5Qj/p4REkgsaA404SyEE3nLsInnnANUuJfO3Wx2fsSCD3cDKxotS0nr2yGHlDx
3VaQpZNN92tSnSsZzJtGFsRINtkQeJXbSTswaEYwQggJlqF5VaK1o0MjqQWHrl2Y
fEvyWb57TFduXmtJLTkxgbt3H6bA52OyK5ffN0GtxfvJAHc/cGZmcgv2kq9krYsm
Iy610rqi+NkDJQg/TeGM+VG8A+SWF25EbqoauEY95z7GtVEgtsg5+Zww56SBwT8=
=Jt0m
-----END PGP SIGNATURE-----

--iFtobK8oO579scb0--
