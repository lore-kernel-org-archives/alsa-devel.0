From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci: vcif must be a module if SND_DAVINCI_SOC
 is
Date: Mon, 29 Sep 2014 17:12:17 +0100
Message-ID: <20140929161217.GT16977@sirena.org.uk>
References: <2771900.ce8bYznKIN@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6axCafNXXMM8qu6Q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2771900.ce8bYznKIN@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org


--6axCafNXXMM8qu6Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 29, 2014 at 05:32:17PM +0200, Arnd Bergmann wrote:
> It is possible to configure a kernel with SND_DAVINCI_SOC=m and
> SND_DM365_VOICE_CODEC=y, which results in a link error:

Applied, thanks.

--6axCafNXXMM8qu6Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUKYTgAAoJECTWi3JdVIfQhSoH/jeEOwQkwtrvFGYV/24eEZF1
ujE9yhVRtVnvQmhcYqFdTce8/cberOPg3w41nuqzTadyssOMJEXw3vuYVCoCwdE5
ITaztKCarG+Q4TnRuzWe/uTuqUBYCVbPaBHK/zfTHR1yj9yEfVUqDl1Oe0ZyyRHj
cFYSpV/LvwvXStJt0GKlGofcrlCNGXJVm3/Toaa6jiMcBgaKiBtHTs2gzxKAuK7g
71AXh6/A6EBRdyONLa5djNV5DZd5PmEj5h7V+BquWA0jaf+65REwMnLObPllY4Yk
HhynbNXCEFo/mDLBSvg8hndidPxZR1iGJqXFEgHh87PBsnaAqK5OrxkyNVNk8H8=
=2imw
-----END PGP SIGNATURE-----

--6axCafNXXMM8qu6Q--
