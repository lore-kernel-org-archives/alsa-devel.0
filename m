From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC : Add an IC bit and frame master
 mode (SoC and Codec slave).
Date: Wed, 15 Mar 2017 19:02:12 +0000
Message-ID: <20170315190212.x5c3kyyl4osrs4gu@sirena.org.uk>
References: <cover.1487997974.git.flatmax@flatmax.org>
 <057bbc69c3dcbb5199782ae6fe44d73862b8a1d1.1487997974.git.flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7769826670572577610=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DB1DD267066
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 20:02:18 +0100 (CET)
In-Reply-To: <057bbc69c3dcbb5199782ae6fe44d73862b8a1d1.1487997974.git.flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: hias@horus.com, alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, phil@raspberrypi.org, Liam Girdwood <lgirdwood@gmail.com>, Eric Anholt <eric@anholt.net>, florian.kauer@koalo.de, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, ckeepax@opensource.wolfsonmicro.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7769826670572577610==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2bbpp5t43ooqg27r"
Content-Disposition: inline


--2bbpp5t43ooqg27r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 25, 2017 at 04:03:12PM +1100, Matt Flax wrote:
> This patch adds a new clock mode to the SoC system. The new mode
> allows for an IC (between the SoC and the Codec) to be bit and
> frame master.
>=20
> As SoC and codec drivers default to return -EINVAL, this new mode
> can not set either as master.

I think I'd expect to see this device represented as a CODEC with two
CODEC-CODEC links rather than transparently as here.

--2bbpp5t43ooqg27r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljJj7MACgkQJNaLcl1U
h9CSagf/eJ791TqKWhVQB8L1GeOWH1qQl3/f8e8aW9vZb+xLcjkczafMqLBNZN5A
j06JGyD9r9P57mwfUOMpQvaBm0msULwFryU97QLkAbTK4eMnCLS82f4s+aaanoBF
5VIn3qYY1QzGnYaSzvSpGx5kLqKlpI759hsYV2ghFm/U5x+0EY7AVRLhLv0r1YKM
QcUlxYz/ZHAveusMVRhtEacgLKvTzmZMva/LEhJdDTlCDxkc1v7vf9mBc7GVhUyA
sgvPW+WpgN2cA01CJmwFl0N1B0xJpbEQbfDTAStTkTh00iweacDTXhuIjDFusE1B
rhNdwXYXPzCbkI6LzkukNr9rwPL7SA==
=M9EI
-----END PGP SIGNATURE-----

--2bbpp5t43ooqg27r--

--===============7769826670572577610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7769826670572577610==--
