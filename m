From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8810: Add driver for Nuvoton
	codec chip NAU88C10
Date: Wed, 17 Aug 2016 10:42:21 +0100
Message-ID: <20160817094221.GG9347@sirena.org.uk>
References: <1471251743-32084-1-git-send-email-KCHSU0@nuvoton.com>
 <20160815140604.GK9347@sirena.org.uk>
 <57B28F1D.8070409@nuvoton.com>
 <20160816103854.GP9347@sirena.org.uk>
 <57B3B107.9080702@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5849288196101050312=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 77B41265FFA
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2016 11:42:29 +0200 (CEST)
In-Reply-To: <57B3B107.9080702@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: WTLI@nuvoton.com, YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5849288196101050312==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5p9QWNAcIBsfgc97"
Content-Disposition: inline


--5p9QWNAcIBsfgc97
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 17, 2016 at 08:34:15AM +0800, John Hsu wrote:
> On 8/16/2016 6:38 PM, Mark Brown wrote:

> > You're not open coding this, this is using regmap!

> Yes, the regmap raw read will use regmap finally. But it needs
> format_val to make the value and it is not registered because
> no such value width, 9 bits. The system will crash if the driver
> uses regmap_raw_read with 9 bits value.

The whole point with raw read is that it isn't reformatting the value.

--5p9QWNAcIBsfgc97
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXtDF8AAoJECTWi3JdVIfQutAH/3uDfz3xbCOw7F2HL49g2Vg6
9F5zzP5v+MVUw3+Fgjr6kYhNdw8FBlyQKQgl0gUWcKekv0TtQdKIFxrJbSvEK9lr
gx01gC6cq4p07jhrmhVKP7HnqZSXEj7mFDI3HQFeh64N0d2Wu/3sbct7dNm/yoh5
EKPibn7UY/Kv+YthBeWPnvow8dPePJ3LLs0jc/WdGDQlS+IHfrWsXlVJokxzi9/j
7QLK2BBuHn4U1U3vCSs3Gt6tPOI+GbWDiuIK1C8uOp9t49fQG6ccfp/yPvFSedHR
+AMTAi2+JcABnjotSUSxnF+KR4tTlD0nKdg1Mo7hAx0RhwHGA9ZpYS+ZaAc7qZM=
=lCPy
-----END PGP SIGNATURE-----

--5p9QWNAcIBsfgc97--

--===============5849288196101050312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5849288196101050312==--
