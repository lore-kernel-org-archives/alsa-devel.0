From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: reduce power consumption
Date: Fri, 31 Oct 2014 11:08:51 +0000
Message-ID: <20141031110851.GL18557@sirena.org.uk>
References: <1414738336-17371-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0547904237984701411=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 05337260597
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 12:09:17 +0100 (CET)
In-Reply-To: <1414738336-17371-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0547904237984701411==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DI3e56nQDAJ1LWZd"
Content-Disposition: inline


--DI3e56nQDAJ1LWZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2014 at 02:52:16PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> This patch will optimize the power consumption of rt286.
>=20
> Signed-off-by: Bard Liao <bardliao@realtek.com>

So, I've applied this but I'm not at all happy with the changelog - it
really should be explaining how the patch is achieving the goal it
states.  Looking at the code it's fairly clear this is by converting to
use DAPM to dynamically manage things but the changelog should say
something about that.

Please also fix the comment style in this driver - spaces around the /* */=
=20

--DI3e56nQDAJ1LWZd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUU23DAAoJECTWi3JdVIfQkdEH/iTH5l64jTYs72gXjcrQe4GU
u7YAyATxXA8Am9kP78ni3jgzv07FKFJ2pqr1lAh4U5HZJk3JxPB1msX0YiozJ1oY
8RfUpbhPDrRZHtdCCgC04aHIu3q2SD57wlejtihbU8i8/hX8XgzqbYpoJhhJ7L4e
RKKnW38R6/YE368HJT8GPW4CIXl3oNH1Mky/TFMDEE89pF9xzPy5mfl7vwlPuxzB
tdflAICADx/sePqn2uy2JbD8yq+eCdtZ+Hbikr5BuFSrv1lWrz8jrDFRAGkdh8aS
dzmvsxonOS/Haz5b7QJhgPbphfszikP5t7W0FgBUgargSZr5NJW9+kzMF1+R6/I=
=rXju
-----END PGP SIGNATURE-----

--DI3e56nQDAJ1LWZd--

--===============0547904237984701411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0547904237984701411==--
