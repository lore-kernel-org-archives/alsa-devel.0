From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: Support TI Isabelle Audio driver
Date: Mon, 4 Jun 2012 11:35:19 +0100
Message-ID: <20120604103519.GE7538@opensource.wolfsonmicro.com>
References: <1338569514-18106-1-git-send-email-MR.Swami.Reddy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5409276401921934807=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 977EA104176
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 12:41:11 +0200 (CEST)
In-Reply-To: <1338569514-18106-1-git-send-email-MR.Swami.Reddy@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: MR.Swami.Reddy@ti.com
Cc: alsa-devel@alsa-project.org, vishwas.a.deshpande@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============5409276401921934807==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 01, 2012 at 10:21:54PM +0530, MR.Swami.Reddy@ti.com wrote:

>    o Used dev_get_regmap and devm_regmap_init_i2c APIs.

This looks mostly good so I've applied it but please send an incremental
patch to remove the use of regmap_exit() - the major point of devm_ APIs
is that you don't need to explicitly clean things up, removing a class
of potential leaks.

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPzI9EAAoJEBus8iNuMP3d0HIP/2e4FR6oHD79INs3RKs7fcnS
U1apv1jBHKbLmwnceui6WFZ7PkUvrANCc5Hw3p+75fDmsmnrY8fA+XTI0Tw8HGWp
zSoxoyh1HNFNXj/82t/MaBv4XlPEa0hLaknTYynqXcMrhUcAHoSUmykMDyglqcgE
CK0nhJgQ5sf9wsArFc/rgDFRUc67Uei0Gv+prnZ7iW1GEfGcHunSG0UXa8coCCjh
eJbBetEx36XRa5hQwkyjW4EoZ9CN2U3oUxEeJBFhWweqKtTIKHcjVr0y5C2ztAma
T67joaLdHT3ssBnF01JrYXdvkh68zHoitUgO5fNBDK6qNqa2+zGY2SdjaCn7f4yJ
tV8mvxVSCr/FMSVKRddSYoUFEhC+CRnxvpvrpuBbjeyV4dl4CMUYglbVq+e7Ai1v
4E5w62DVXuvKdzoOs5J1pR4fR8gpV5ZH8TUWEDJl7PPIReTvvo1XeF05r8rB4oAC
/WgnPo7KqjGcAmSO2sMkuPVXYDJXvIdQtDchmeHgBWah7o9aTnz3dFFAa11g0hFL
126ANNiygVGt44fYTIePzMAUMHwAXF6RgNI4DHJ+fav3M2Xu/NbDl414qIgzLTtP
7CfYOg3LA4vZKbbH4lleNnfkO17YuRIcRDaTCYKiuOOwoR85wALwtlUYRUufqnE5
+MJ/4Hgt0M3+mptsYKuc
=xydE
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--

--===============5409276401921934807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5409276401921934807==--
