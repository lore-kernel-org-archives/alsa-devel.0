From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: fix broadwell module removing
	failed issue
Date: Thu, 28 May 2015 10:28:03 +0100
Message-ID: <20150528092803.GQ21577@sirena.org.uk>
References: <1432793658-9463-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4684825232250184834=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7ABF72604A7
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 11:28:10 +0200 (CEST)
In-Reply-To: <1432793658-9463-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: tiwai@suse.de, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4684825232250184834==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P33sUzWjYpDtphzm"
Content-Disposition: inline


--P33sUzWjYpDtphzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2015 at 02:14:18PM +0800, Jie Yang wrote:
> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
>=20
> In haswell-pcm module unloading, we can't free runtime modules
> directly, for they may be already freed in runtime suspend.

Applied, thanks.

--P33sUzWjYpDtphzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZt+iAAoJECTWi3JdVIfQiZYH/RqnkPbxHeZLQUxGs0OxbTRP
3bwVLlW2+vSqlfN3I5fy6e53NeAtfxaOCxJTDHesNmN16j/VrqeYFu/IiBevIUgp
+D9D1zia4We1PMawgVRB8Fqcudlxnx69BcNdX5VLVHl6Fkg75FUjAtfmsMfX35Pl
U2ClrAlNZaWGAgDM+26xvfl0rOnoHXBW75gQdBwPVkqacEsSN7A0cWTx9JBdCNIs
APVV+YF/3vMrAYqeROIkaeW/0QBnDjgiG168tvhViN95loLgn/68FhBOysHnGr8o
KAIdQ8I/VIEG1O+TWj2px9zke2aeD63PVvEtd3cuHDSW6hNm6YuIhsZZAMolXZs=
=o9Sr
-----END PGP SIGNATURE-----

--P33sUzWjYpDtphzm--

--===============4684825232250184834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4684825232250184834==--
