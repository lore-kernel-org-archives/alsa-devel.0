From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 5/5] ASoC: arizona: Use auto disable
	muxes for routing
Date: Wed, 6 May 2015 17:16:37 +0100
Message-ID: <20150506161637.GX22845@sirena.org.uk>
References: <1430480247-28753-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1430480247-28753-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9079757200467649442=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CE1C1260632
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 18:16:44 +0200 (CEST)
In-Reply-To: <1430480247-28753-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============9079757200467649442==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3F6smfiC21NXr0EM"
Content-Disposition: inline


--3F6smfiC21NXr0EM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 01, 2015 at 12:37:27PM +0100, Charles Keepax wrote:
> The mixer core on the Arizona devices is powered up whenever any routing
> is non-zero. This patch saves a little power and avoids a few difficult
> corner cases (around the mixer core being powered whilst there is no
> clock available), by using the autodisable mux functionality to only
> write out the settings for the muxes when they are powered up.

Applied, thanks.

--3F6smfiC21NXr0EM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSj5kAAoJECTWi3JdVIfQbegH/i7ghoNvKW8oMl6Hud7O/oub
hRdFE5qReL7k5bhFalWt9CPENh1WheIvz9X4SWJbcZ9gydpqXOXFjJzhmx0xfGlH
8eBlI/qJz64ZZs7Dr69k3AXShKRarGytkPhZ37bOPEFuyhDqqggnmN3q5DpeEljT
eRh1anSf3o3SRTpEUA/tQpYnrZldzQoIalY91bzbvMX3Xqll9qsyb8s9+d3PfUpm
aSFJt0nhGWWEuW/7hlOMaas60aFda3hwUe4pGDhsFfAgArxeOkEFw5d3T2OOgeao
HXyu1zF2sJv/IW/TXShGlrJ2gr9i32MoF5ZDtKSZr+5G67rUy/kR3GeOC3aEihw=
=aQAA
-----END PGP SIGNATURE-----

--3F6smfiC21NXr0EM--

--===============9079757200467649442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9079757200467649442==--
