From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/30] ASoC: Move jack registration to the
	card level
Date: Wed, 4 Mar 2015 17:11:06 +0000
Message-ID: <20150304171106.GO21293@sirena.org.uk>
References: <1425461626-21103-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7237247378440273405=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A464265233
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 18:11:30 +0100 (CET)
In-Reply-To: <1425461626-21103-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Yang A Fang <yang.a.fang@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Sean Cross <xobs@kosagi.com>, Dylan Reid <dgreid@chromium.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============7237247378440273405==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dXORoSZsDhHFGh8W"
Content-Disposition: inline


--dXORoSZsDhHFGh8W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 04, 2015 at 10:33:15AM +0100, Lars-Peter Clausen wrote:
> Audio jacks are typically card level elements and when initially introduced
> the API to register a jack took a card as its parameter. Back at that time
> there was only one CODEC per card and DAPM support was only available at the

Nice cleanup, applied all thanks.

--dXORoSZsDhHFGh8W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU9zypAAoJECTWi3JdVIfQydkH/3JHupZOKgXc+XRPjUMgnNA3
lVDpvOzuzM6geBQIfgLb/C/I3W5nI7aTCQtW2tbWkK9d+aSmSssmJzN3oyP0KdyC
uRKYr9GDyCzHFEbYearSCZLmiY+Kg/VtFbTXz6kmGO+Jf0REDGvStt7QRrvjcBh5
HL4zZEcaLCx30soLwj6pEokCdX/GXvZ2htKM/rsQTROUAjlyMtv0kCvaCfLI0KcR
0VtYRGVoZMot4DGe/BDa+QkBeWowpV0cr4P35WOswRbTfXeyJ2O3bReVIMSSseVX
8nFAe+qn3hc+s3dGKqIHluPASa7bLULGzB8Zoh5L/iutM/m/7W6kvy5g+abyEgI=
=beKu
-----END PGP SIGNATURE-----

--dXORoSZsDhHFGh8W--

--===============7237247378440273405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7237247378440273405==--
