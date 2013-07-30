From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: bf5xx-ac97: Remove unused extern
	declaration
Date: Tue, 30 Jul 2013 13:00:35 +0100
Message-ID: <20130730120035.GT9858@sirena.org.uk>
References: <1375184050-21514-1-git-send-email-lars@metafoo.de>
 <1375184050-21514-2-git-send-email-lars@metafoo.de>
 <20130730115025.GR9858@sirena.org.uk> <51F7A958.9010106@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7176873280334520674=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 54E0C260729
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2013 14:00:39 +0200 (CEST)
In-Reply-To: <51F7A958.9010106@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7176873280334520674==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xNNtosFYolhJ0t1I"
Content-Disposition: inline


--xNNtosFYolhJ0t1I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2013 at 01:54:00PM +0200, Lars-Peter Clausen wrote:

> No, this is a different one. Your patch removed the extern declaration for
> bf5xx_ac97_ops this one removes it for ac97, which was on the next line.

OK, applied.

--xNNtosFYolhJ0t1I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR96rgAAoJELSic+t+oim9cX0P/2Mm2vzJebqef+grbIwJclqf
eDAZGfYJkz/yFyuqawVlGuZqAzX4pR+UuwKHPO15Qx9hCreRU66bpDSVJI84CuX2
KTxIWIMoQsYkcsTyH8++RFicm9tYwPGaq2+PbZZy91Ldks3cnoyGCqcTL/1NAsMs
gJ7PBKG7Ta0frksFNvafP273vcVfOvqKou0lBNQNnko6Vd7Lxgnt/wPFgpR4Hc4k
vw4fChKu+ujKc6xoQrwsgiJTIdH5nOl1Q7FdKqeOmXs64gST1Nzc9Xw0mP+sIbds
b0kio/g9NHsaqsLK4/N3519l/IHnCuryJ3vW19Wg/0VaCP+EuvTpKMRoAy1AJ3l0
uVMIW8ctdmy+7vIRhXct0KXx7KpHd4f9uWv44l7yO32wESgaBGgdQWfcSIN9YdKy
DGihydGUz29T7j76VKw4HbHR3OMEpn/kgJQyWhAzYa1rnYCVaxlQwhm3ddEEHYay
VqejIvstLpeG9535kjdTi1yh6uAuCEQU40yoxZ2hzu114NWnavNDPxy6vXSGLojI
A6jTL3hMxbbJ5QCiPXiGmbvaEULz3ySMZiHnSRxBWgJdTiSs4E9jcSNqL5JtAJBX
d48MQoMJt5BdettQvMj8FGW1CHPVSsMo35BpU2k+0Zb6Q1lmRGftwFmMHiGYoV0i
lrxcuKpzA8f9n8386aLY
=Ay6Q
-----END PGP SIGNATURE-----

--xNNtosFYolhJ0t1I--

--===============7176873280334520674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7176873280334520674==--
