From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3 RESEND] ASoC: rt5645: make
	RT5650_TDM_CTRL_4 readable
Date: Wed, 10 Jun 2015 18:30:52 +0100
Message-ID: <20150610173052.GK14071@sirena.org.uk>
References: <1433918069-21917-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8631141403821957764=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 770FA265DEA
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 19:30:57 +0200 (CEST)
In-Reply-To: <1433918069-21917-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com, john.lin@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============8631141403821957764==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xCod2j9FiOMpaQ8M"
Content-Disposition: inline


--xCod2j9FiOMpaQ8M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2015 at 02:34:29PM +0800, Oder Chiou wrote:
> Register RT5650_TDM_CTRL_4(0x7A) is readable and used for mixer
> setting. It should be added in rt5645_readable_register function.

Applied, thanks.

--xCod2j9FiOMpaQ8M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVeHRMAAoJECTWi3JdVIfQCi8H/2nI8v7rXFjFRvmec70iAvfU
x5Bdr2s9pZyWMIK9lA7hcQSSok/FCuXOmD8SmbEQbNiDDn/fhuvE68OM47JbBQrH
KURox5X8qymWzy5d1upV1JTBlJd2Cf1D/kOX8YPVmjxUOBSOnh0SBqHcx269q373
UyYDyDPuHPFyDbt2W2Hy/X9mdPrx31zaMgM2h7RlEZ5U5mIXWnAsCVQbBnwXU5E8
6aqRwJ6oT97yJnPrr9tLwzgmevxgbSZcLw5M7+jorzNbqD+a8sNZrCFOY9RiNQxT
lEXvTQ+2tOYjkhzWKkGM9TKTkwD0NXbGGh4LZwLQSXObh3WzqWfo4Rm7L/vU2XM=
=gY/q
-----END PGP SIGNATURE-----

--xCod2j9FiOMpaQ8M--

--===============8631141403821957764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8631141403821957764==--
