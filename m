From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: Fix 'may be used uninitialized'
	warnings
Date: Thu, 27 Dec 2012 16:42:51 +0000
Message-ID: <20121227162617.GB5005@opensource.wolfsonmicro.com>
References: <1356371738-15997-1-git-send-email-festevam@gmail.com>
 <1356371738-15997-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3283528516246138984=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8A878264EAA
 for <alsa-devel@alsa-project.org>; Thu, 27 Dec 2012 17:42:53 +0100 (CET)
In-Reply-To: <1356371738-15997-2-git-send-email-festevam@gmail.com>
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


--===============3283528516246138984==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 24, 2012 at 03:55:38PM -0200, Fabio Estevam wrote:

> -	u16 reg_l, reg_r, dcs_cfg, dcs_reg;
> +	u16 reg_l = 0, reg_r = 0, dcs_cfg, dcs_reg;

No, this is a terrible idea.  Apart from the coding style thing all
you're doing here is just ensuring that a value is set in the variable
without any analysis saying that this is a sensible value to set or that
the compiler hasn't spotted a genuine issue.

There's also the possibility that the compiler is just buggy...

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ3HqBAAoJELSic+t+oim9ESMP/jDYQ0yCWPP8FNyI2UkrXw1+
pstu6DxCfROVK0yoS+j8X+nC7xXefB7qnBKfoHL7ywcinGEZMiUrgbWs8avm07OV
FQnTudZSO6uIWB0tcooBfBSaI65xVkTF/+5kdUswp/lJ+zyzfFnqI6l2WMg7FQRO
omzrunk8jBQzL5CpD9MVk+WRAoLg7YTdXKVlTgS2SSfTkgDaaxzm19TURZBtEZTX
Lk2QxeNb47q0P5xYbBWRKtP2k8jQlN047t/XWXXgg0dPYW2rG1SNGGwBq1mA0LsM
Ib6ZoMMuf8yV1zR22bF+8VV9JltoPMAZ31UejQ6GzVZSGibzPk7Dldgg/8eiLuA0
/9KN0/XqzA5DgOv9qQ2+qAMNydP8+Np10mAyDskanPOBS4ZKfAK26vEkv7o/Y13n
6alYvMMWvqmlGegri6DDhS3kZUAeeok0lamzIP6jeh/qhoxgTKknIxgRENiKU+gi
hppIBqYWveRC8BbyVwG3CFj6DKiqILpZvVPuZ6vUs5O9Zi2CLEtq1j2DwwrsGExC
7gMkr7N4h4psjTfxWrx5sHxwqfFE8PdVXfYIWvA79+ifD2Mj5/Tn6QjzqYI1vSEo
6vuvjo8buRF5pxygzPjZ1cFp0N3EOlRoEdLBAhO29kKbA203xIIQ6u0aw0V0qfqo
imjlySig73AKExU1ZrJV
=ZQuc
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--

--===============3283528516246138984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3283528516246138984==--
