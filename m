From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: wm8804: Use
	devm_regulator_bulk_get()
Date: Wed, 30 Apr 2014 20:35:38 -0700
Message-ID: <20140501033538.GS3245@sirena.org.uk>
References: <1398862240-4432-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3265959510892001876=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CE4E2607B6
 for <alsa-devel@alsa-project.org>; Thu,  1 May 2014 05:35:52 +0200 (CEST)
In-Reply-To: <1398862240-4432-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3265959510892001876==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E1BPhOSoTthPQdPL"
Content-Disposition: inline


--E1BPhOSoTthPQdPL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2014 at 09:50:39AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Using devm_regulator_bulk_get() can make the code cleaner and smaller as =
we
> do not need to call regulator_bulk_free() in the error and remove paths.

I already seem to have applied this patch, why has it been resent?

--E1BPhOSoTthPQdPL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYcEHAAoJELSic+t+oim9fvoQAJWG3XQWbiBc6WV/xdawE2tY
x/v9SgZZmhEprecKV6GCBaSQffiuhgKwuf5LAxkVTxt/rgbc/Mn6vTNsdIMbiUye
zH2Ak8sBt51fcGC7CbRMxaykY8fH5sOi3eGAnNi0Nj5rghiTWLmJEZbD39YQzlHV
cKRPZhb+pCf5dLjR8umz5s996QSjbyFpa2DHW3X25eTTG6Fulfif6x7l1wOMz+SE
VS31AOxfBbPPb8V5sMtES6YbPF3lCZIPECarU0AdSzMYtI8sksnx/b+Uz0Qm3xMe
bVleNHUIW/IPDKpKc6bAr1qmctzFV70X74mpjrBe6vuPh4/SuySsDa/eN3bOMITc
ayhGwtodXA5t38hvVy/3P8s8i5Ij+NybFUj3a2E/7B7VIbyi99KPhbnaDJAAZVS5
3d6zZCf+Vj11Yehklb2awqbfgF4gNisHsIZkUhQUvM2lpZUB1O/8hvQ6oFPcxM/M
WtAeGAZsRoWN/q1YlOqQjUgJrmQLkiLxOZ/sZ/6JxFo5K5MTQ9jZz/yZMtU+fHCB
43o67JvN9Ml/c1iz5d27wv59PBu5S7IKpT9T1K2x2ohz2pc2IJxoJitzbM6YoXFD
hKpvwaI5YMC2fld/R1kjy//x1Id8DF4QednSv0ChC1me8DL4gFqcSPSa+xnInV6R
nJztYa3bazDfCKo3GSNa
=9kQG
-----END PGP SIGNATURE-----

--E1BPhOSoTthPQdPL--

--===============3265959510892001876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3265959510892001876==--
