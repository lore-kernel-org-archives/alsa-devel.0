From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: sgtl5000: Add MODULE_ALIAS
Date: Mon, 22 Jul 2013 00:53:48 +0100
Message-ID: <20130721235348.GC9858@sirena.org.uk>
References: <1374347763-18261-1-git-send-email-festevam@gmail.com>
 <1374347763-18261-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3393295808009183025=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B1207261661
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 01:53:52 +0200 (CEST)
In-Reply-To: <1374347763-18261-2-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============3393295808009183025==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zsz/KTM5+kqAkz1u"
Content-Disposition: inline


--zsz/KTM5+kqAkz1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2013 at 04:16:02PM -0300, Fabio Estevam wrote:

>  module_i2c_driver(sgtl5000_i2c_driver);
> =20
> +MODULE_ALIAS("platform:sgtl5000");

This shouldn't do anything useful for an I2C device?

--zsz/KTM5+kqAkz1u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7HSJAAoJELSic+t+oim94iwP/1ccBCCogp3IArRG+Iq1lul1
nuBMLBShpAiG9OYCyW5QjGSbwWlEKcZuknbCUiJ/qU3WWr+EVxl4haFIFpUK9OjQ
73uHVMh4vieCyYrMwZxo9GwaQtlcXNiGy2uZpEeHYDlztCknvpKnClba3F9VKoTx
qL/VPuF9Z0Taj96M057N/YrN8qONUOxVyXkFXOxJJXk4FVYa8GTVHaRW4Cfxxz8U
+hc1zrWKHBeB9a+3n4Gb9/qN8elWGyUHEcaC51ZHp3UTI4gexni2QsLDgpD6iVNF
58equCbtEMyXqlAv9+JZ39k3nG5tR8oPBbMI/9M6u2NH1mftwpQdIL6YeRQlf8Mk
1IUun4VlPV1ObRE5NIv/FtjCF8o413G/ZwSre42rhGbkryY85E79O8sxzAAfEsCK
SysNlyi4UP7Dp19A8/MQNc4F3faZOujVxwLwfioSajqZeljs6M6K88n1EF+FsZ7b
Or1TSeL7CJrmfW4zYwEPbAZKpmk8b2YUk6eOt/TlMaEstRcEQBy58c7QT2fcg7wI
OomQGTnvYQ5CNINEEuXAX/v6ald/49SKyxcJCt4hGXcymt/5Lfo73IAd1W9HzkpG
gHdbYysuW+C9snDIvPuuIYdwN0hGZ8ITjYSHbJqyt5qdGrCL+Wfhx/KRQ60f9WcR
hUjud1YBUQoPhbADUZRD
=7b5N
-----END PGP SIGNATURE-----

--zsz/KTM5+kqAkz1u--

--===============3393295808009183025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3393295808009183025==--
