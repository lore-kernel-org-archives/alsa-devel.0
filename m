From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: refine DMA/FIQ dependencies
Date: Sun, 22 Jun 2014 11:58:32 +0100
Message-ID: <20140622105832.GO24291@sirena.org.uk>
References: <6452477.9e3eS6Cip1@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCFQJunhLz1tFGpX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6452477.9e3eS6Cip1@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org


--lCFQJunhLz1tFGpX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 03, 2014 at 02:11:56PM +0200, Arnd Bergmann wrote:
> Commit 31ee2bfd724ab ("ASoC: fsl: select SND_SOC_IMX_PCM_DMA
> where needed") started selecting SND_SOC_IMX_PCM_DMA and
> SND_SOC_IMX_PCM_FIQ for two drivers when building for i.MX.
> This has turned out too aggressive, as FIQ is only available
> for i.mx2 through i.mx5, but not i.mx6 or vybrid.

Applied, thanks.

--lCFQJunhLz1tFGpX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTprbVAAoJELSic+t+oim95K8P/AotDTD9x7gjCH8DzNNzvUm5
sXnA0UxM7Ysd8HrGVWcjW/55vPynmrbcKMeZY995dn0wt3K7QBH8h92MFRmzEeiY
EObNZqixOgmXGccsH4+vua6+W6tGeiPg5/8dq6OpwkO18DKsZWIDWtSH9xBDOotZ
WlzsCoVkBTqDD9QGL97R37E0gTWR4wfhf4BOOklnMSH39oli8utf7G+orgeZGo9P
GR2lxCpHiZJdGuihHXYqsm1eMn/oSMXpwTCgk5TPT8qRuQScx/MsQLY85VE2XFQK
fw6RkqNYtQoijkZXx63cfzVWkvul7wMF9pyNWWt09mXX/eIZtHUmGQi/pJSsn4Ja
eEmtz0xYBOfiSDfxm3+cYy02AlPDqc8Ok4h50laUQLDlNAjHMZ8GvKiX1xGb75Sf
AytiZW4dUHY0nHof2733E7fqrG/5+7bCtlWALOtcD08IyOgEohWYWQUH8avezYOl
f3MvFwfkQwGrgs9t5g8zTRAK/oFrrybooubiwlMCtr7nueQr5SdSTmgy0E80MU5W
tPnpQY5uRnfql1VITRtEddpwrsamcKHIZZ3TYq0hSBFE7xjs9lX04eD7gTg3jwDy
jSKZshEXRf4qpKI94iNlEWSDG2OgQvzJ3/Lu62pad70fd/stOYg9YL8Y4AGm6TZ8
Nc+GME8PYH0A1O9GXH6m
=mOSr
-----END PGP SIGNATURE-----

--lCFQJunhLz1tFGpX--
