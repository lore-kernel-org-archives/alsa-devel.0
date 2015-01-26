From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ASoC: Fix wm97xx touchscreen driver
Date: Mon, 26 Jan 2015 19:15:39 +0000
Message-ID: <20150126191539.GE21293@sirena.org.uk>
References: <1422026497-23180-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7001365627807441479=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DD88A26042F
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 20:15:49 +0100 (CET)
In-Reply-To: <1422026497-23180-1-git-send-email-lars@metafoo.de>
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
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7001365627807441479==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ag0ALTx5bNxCf4La"
Content-Disposition: inline


--Ag0ALTx5bNxCf4La
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 23, 2015 at 04:21:35PM +0100, Lars-Peter Clausen wrote:
> The wm97xx touchscreen driver will bind itself to the snd_ac97 device
> registered by CODEC drivers and expects that the device has already been
> reset by the CODEC driver. Previous to commit 6794f709b712 ("ASoC: ac97:

Applied both, thanks.

--Ag0ALTx5bNxCf4La
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUxpJaAAoJECTWi3JdVIfQd/wH/jmLjf7s7CliMkErYI8NfzaW
DwK0MQOX9E149Q5VbVgL5goWpcqYv1cHgawucBsx0J0F/4wZwh5EzHlBPJFNkJx/
CUX/o/LgUTHIevIt5E2CSmeERIbkbEL9LJG9kS7K/qjMICkC9DY8jMqOmDH1DVaY
VecJevOJbxrfh5Xly68sr3Yuvo5j4CDcaMHtDFuMDdpyqxEXbsAeKTWirYP0222+
9QeWbl/lyyQvoHw93dz/iOrh5KXZw5Vvh+3//ndSo5txCFzKH+mrRm5r91WwGC3n
WLcUESnxcW+Kd8RzcrJd/t//iLda+gZJFGYww3d/QlHiqVvVSJPDpuKppGW74yU=
=wbR6
-----END PGP SIGNATURE-----

--Ag0ALTx5bNxCf4La--

--===============7001365627807441479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7001365627807441479==--
