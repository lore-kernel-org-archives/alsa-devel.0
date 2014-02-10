From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: fsl-sai: convert to use regmap API for
 Freeacale SAI
Date: Mon, 10 Feb 2014 13:27:46 +0000
Message-ID: <20140210132746.GD1757@sirena.org.uk>
References: <1391841508-14025-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UsiV5d7KlsBC0zIw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1391841508-14025-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org


--UsiV5d7KlsBC0zIw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 08, 2014 at 02:38:28PM +0800, Xiubo Li wrote:
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>

Applied, thanks but I think this needs a select of REGMAP_MMIO in the
Kconfig to ensure that regmap-mmio is actually there (it might well be
OK due to implicit dependencies at the minute but should be fixed
properly).

--UsiV5d7KlsBC0zIw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+NPPAAoJELSic+t+oim9oKMP/jCZ15EEYQSzBOPuoKNTrGOq
k+x1vc9FlROcO5j2L8kOm9qiKP22pYIyVOzaXBYzY3p9qAMstXEuUDWPgWt31+XT
RJTi4gAd9YivbV3s1Iq65c/4jObvqA81Xw4Iso2iWT+6T+8e5qqxhQ1MckbzvVNS
Bhn07YDNJnABbQDa/D4iumSnq1X+2H78lidnqdrMeYdWO24aCnCIOk+vzSCSMCzN
XfpdI6TYhIWVrL88nrWlYI0msx3jKNFFSLQhxaJIDRe4Y3Lk9PX/wnee8fZ4IPa5
WMjkZgUTH5dgHHScbFrvM67MZXAvKzKLEQNUm4z5CNwpnXeQ01ruVwgxy4dfNJBT
I1t9PUeS+ouBUDSCs8bPMiPfsQipxB2e/k1lbVBmnREf10sx0bKPsfdPVoMz16hU
Xw6gKVZNuMRf1+1FUcK0+PPzISWZ7sa7BRglApixvwMQIMthKnII18pf7eAJ+SUQ
635U0ssLONqaC7PdIupzWGdhqB2ErfB6RAy0foIt4YFp7arKNiHnfFcfqH6yLdWU
ztu1oGi6OU6SZ8B4E+BOq+BJpuADz8+DaE20DoWqtA4jaMI/LUylYvxXbefXnOcB
bWMA5fEq41C3f6Dl3OW13HKnxsN8Tbo9+Hhv4j1dh6H3SkuRhIJlrWKZdIR2UPwD
FV4ILOfuEc3c+pvmDFe3
=95pU
-----END PGP SIGNATURE-----

--UsiV5d7KlsBC0zIw--
