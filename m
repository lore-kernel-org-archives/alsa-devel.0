From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5682: fix jack type detection
	issue
Date: Mon, 18 Mar 2019 11:27:01 +0000
Message-ID: <20190318112701.GC6221@sirena.org.uk>
References: <20190318071713.20080-1-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0982738205323303872=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4AC42F80792
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2019 12:27:09 +0100 (CET)
In-Reply-To: <20190318071713.20080-1-shumingf@realtek.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: shumingf@realtek.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, hou-hsun.lee@intel.com, hychao@google.com, lijen@google.com, lgirdwood@gmail.com, albertchen@realtek.com, derek.fang@realtek.com, bard.liao@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0982738205323303872==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2019 at 03:17:13PM +0800, shumingf@realtek.com wrote:
> From: Shuming Fan <shumingf@realtek.com>
>=20
> The jack type detection needs the main bias power of analog.
> The modification makes sure the main bias power on/off while jack plug/un=
plug.

This doesn't apply against current code, please check and resend.

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyPgIQACgkQJNaLcl1U
h9DLagf+J/5/e+PDlIIV3t0vHZSmRC+ui9fScL/Mdyg936IsPnD5PpEAuMPPRpPE
OkiQgLJ13oboH1+l0pVdKUjN3S20h2c3BKMI/FeoRgzrZ4PQ8Te6DyoIyzH9iW7L
iN0oyBQml7FQqVba0jdEqlxsACON+HXhUy8vsuJcv8AqpZlIzwdnhJvvr2xlwSgk
NnVKyhS7gl+ssuB8bDTB7ddtCB2Fvmt7M06dKElhjL8/qT+hucIPp3d2A9EETwY4
0AjNMydkeMXz2EtJ9hdztJJLD9qneh+DLioZjRsmLhwp5p+YAb0RNjNsVPKFCWFy
HslJXK1go44dBxwVleqHrDCU7zqDjw==
=OQJI
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--

--===============0982738205323303872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0982738205323303872==--
