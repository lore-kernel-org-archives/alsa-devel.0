From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 1/2] ASoC: ep93xx: get rid of
 ep93xx-pcm-audio struct device
Date: Wed, 18 Dec 2013 18:53:53 +0000
Message-ID: <20131218185353.GJ31886@sirena.org.uk>
References: <1386704086-28624-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1888153133865326876=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id CAF8B2617B6
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 19:53:57 +0100 (CET)
In-Reply-To: <1386704086-28624-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, Ryan Mallon <rmallon@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, H Hartley Sweeten <hsweeten@visionengravers.com>
List-Id: alsa-devel@alsa-project.org


--===============1888153133865326876==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sT9gWZPUZYhvPS56"
Content-Disposition: inline


--sT9gWZPUZYhvPS56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2013 at 12:34:45PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Modify the ep93xx PCM driver so that it's a utility library that can be
> registered on each DAI, rather than a separate struct device. This is
> more in line with how many recent DT-converted platforms operate, and
> avoids the need for yet another struct device.

Applied both, thanks.

--sT9gWZPUZYhvPS56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSse8+AAoJELSic+t+oim9Z7UQAJAHfAEQriw1Sxj9SdADmAaP
14KKy+FL9SrkBwUzFFsfLGdfKUjPEwxyLSPOjpoYZIT8sU8gs9aw/XMt1oqv9gvi
4NU3F+ydKYYNxI4dgokBPRjYH+dFpVhxjqfBtGGsAwOpWJ5aXqjloRO5A4HTkwMM
mewSSQ6w+LTl22BQg+4e/gUlvMqbJVkTfhse6c1gJ0ms4BrJ7EwV9gF/PxXXXeBs
DtZBRvn3O+fZTTBioEHdzB8zXn1pwp4vcTnlLlao1iy9UkasmWImGutr+HUNRET9
pfYuLl7TVpEBnk7K5LUppf4vlRGc7gMfB/UAsqlQrC/pz6Rg3PwW2h5KyfWF1oVJ
f4nr2x9RymTVbIi+TjGI67YDmhzK8Cm2bf2Z3MXAputaItOW2AfhXVxxj4tpqonv
ACnAQ8pulV/V/TmAuWxI/XX+BP5Y0XpLpk6dXltuHA6Im7a/JAQHNo2rNV3+Vvl3
roFuV6bTenq+tkOCwcycDyvVdNGmc3/7S2kJcb7qO/4IGZnZRsDLe5vx1ClsbXwK
R7WW5bDnam8vNPe0ce0kJpj51V4L/EJBRzTBqXfuu3aepP1XQY18v00im2DZzmAZ
C3J0TjP/LONzVkzShoQqjmbSYfsz/qpY1iSNN0rKvH3bREmdZERv9jsTJG7987jq
extM9GwuGUIgDEvluxd1
=/0PS
-----END PGP SIGNATURE-----

--sT9gWZPUZYhvPS56--

--===============1888153133865326876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1888153133865326876==--
