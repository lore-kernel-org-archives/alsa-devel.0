From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 4/5] ASoC: dapm: Add support for
 autodisable mux controls
Date: Wed, 6 May 2015 17:12:38 +0100
Message-ID: <20150506161238.GW22845@sirena.org.uk>
References: <1430480247-28753-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1430480247-28753-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7317615110531361859=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E15D7260632
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 18:12:54 +0200 (CEST)
In-Reply-To: <1430480247-28753-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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


--===============7317615110531361859==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jTqjQgicGfXXgWG+"
Content-Disposition: inline


--jTqjQgicGfXXgWG+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 01, 2015 at 12:37:26PM +0100, Charles Keepax wrote:
> Commit 57295073b6ac ("ASoC: dapm: Implement mixer input auto-disable")
> added support for autodisable controls, controls whose values are only
> written to the hardware when their respective widgets are powered up.
> But it only added support for controls based on the mixer abstraction.

Applied, thanks.

--jTqjQgicGfXXgWG+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSj11AAoJECTWi3JdVIfQgqYIAIKgBMs7jycZcuoMUXrmZ1OW
5rEacvA1a5+Tmp994qjYFmBn/9D/gWKEiiRT8fCdLFlWFZ1AzBwr2E0eXtLAVtDC
PWY+8HEuXuguymq9yvdJ6v4ktNn/EzmAe+RNVxxQJW0Dwsvc0m67hN45hkRLGL1w
lSBpJUamksnbmg83aF/MGKj1dPSOjgUkfdtAtXvZQUiHPh2TGjkbyUoUFP/Uu1O/
oPvbpgQB4h0mYeUYE3SHGNDKGZzoG1y8n2vAqUMs8b/gFgu6TGnUxTYuz5/S+7Yr
gn3Y78HBRHsmSGr2hdy48mNuMOtM/LblDczsSTPrrenaIHMuX/1anwhb1ubsJ+c=
=sqMU
-----END PGP SIGNATURE-----

--jTqjQgicGfXXgWG+--

--===============7317615110531361859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7317615110531361859==--
