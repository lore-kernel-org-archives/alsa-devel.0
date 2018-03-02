From: Mark Brown <broonie@kernel.org>
Subject: Re: [BUG] Kernel crash on Allwinner H3 due to sound
	core changes
Date: Fri, 2 Mar 2018 12:40:50 +0000
Message-ID: <20180302124050.GF6255@sirena.org.uk>
References: <2424862.oPtAVTfrB9@jernej-laptop>
 <63331816.68OamKINx1@jernej-laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0183911518392999439=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AB752673A4
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 13:41:03 +0100 (CET)
In-Reply-To: <63331816.68OamKINx1@jernej-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org, wens@csie.org, maxime.ripard@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0183911518392999439==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="phCU5ROyZO6kBE05"
Content-Disposition: inline


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 11:23:57PM +0100, Jernej =C5=A0krabec wrote:

> I removed parts of the code from the sun4i codec driver and interestingly=
 it=20
> doesn't crash if I remove following lines:

> ret =3D devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
> if (ret) {
> 	dev_err(&pdev->dev, "Failed to register against DMAEngine\n");
> 	goto err_assert_reset;
> }

> Is it possible that NULL pointer causes troubles somewhere down the line?

Shouldn't be, that's just the configuration which is optional and not
what we're crashing trying to register, we can mostly configure things
by querying the capabilities of the DMA controller via the dmaengine API
these days.  You're removing all the DMA support there so cutting out a
huge segment of the initialization of both this driver and the machine
driver.  Other sunxi devices seem to be starting happily in -next so
there's something system dependent here...

--phCU5ROyZO6kBE05
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqZRlEACgkQJNaLcl1U
h9BgIgf/Q3GZOlQCfAnUF4m/v9NaH4QxNM0OA/bgzS8qZecbkX1umIBvadiVvQk2
5iUAggTvZY64JxScseXyAkR2/KnzUcrzn3wCzA+7tRbuHzAliU3hLw4ZKjJPjhPP
3MJ6D1S4OXijQBQV6ASWXU7D1IEWucfCo57SY1BVwCVuCXOy1UQixQrrRWbDG76e
Epe/i0ZFTxzI2+v2xJF2b3JKf0KaIUKFeVOYo5XtGBMqPjyDJcaIIg9xyBt5Oz63
e9zNDJ+7zQ/ydK0eGNLKCB4GvPTKGFkddbgArI9GJnfrb4fEzaavaqif+4ub5qm1
0F+GgKNInRSl0+f0HaDQorBPVNHf9A==
=6y1d
-----END PGP SIGNATURE-----

--phCU5ROyZO6kBE05--

--===============0183911518392999439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0183911518392999439==--
