From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] ASoC: fsl_ssi: Remove
 .num_reg_defaults_raw from regmap_config
Date: Tue, 20 Sep 2016 18:56:29 +0100
Message-ID: <20160920175629.GB7994@sirena.org.uk>
References: <20160919193029.8119-1-marex@denx.de>
 <20160919193029.8119-5-marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0918211422776420920=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 409E3266D9C
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 19:56:40 +0200 (CEST)
In-Reply-To: <20160919193029.8119-5-marex@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org


--===============0918211422776420920==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 19, 2016 at 09:30:29PM +0200, Marek Vasut wrote:

> Cc: Xiubo Li <Xiubo.Lee@gmail.com>
> --
> fsl-ssi-dai 202c000.ssi: No cache defaults, reading back from HW

This probably shouldn't have been part of the signoff chain and also
please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX4XhMAAoJECTWi3JdVIfQT7QH/i31jRfYjXUvxws2omBdLK+d
5fBX9gg1Cp4+RzyNT/VHfAl6DzDYglgJI3Bm/i43HDgq2tqgxeJVgFi3ObkuO4Dg
VG7i3GhkoIEayQvUC5Yv7EqiFZNWwPSUB86fBokdQJsef/gZCQc2rz+i8OphqoG7
+yHm3UUhGju+/WRNnmz13Gs3eLkrqtijHFXHDx/DuOwML/W3uQN3t4njDGUxMq5h
AhuZwQABZ1c66CQ+rrUZ8CcS9LAkGx16nZMomkGwCU0IQ9a85e8GL5gfW2o3tzBG
/yE3mxGIm806bqaW5OP7mwCaH7wlEtD2T0KdVD9fraKjDmqHfLN6n8HaIdY3zJI=
=TYJ2
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--

--===============0918211422776420920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0918211422776420920==--
