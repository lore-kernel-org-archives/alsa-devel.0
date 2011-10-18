From: Wolfram Sang <w.sang@pengutronix.de>
Subject: ASoC: Amplifier behind codec?
Date: Tue, 18 Oct 2011 12:38:21 +0200
Message-ID: <20111018103821.GC1922@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8436610083250783012=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 2161E244B5
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Oct 2011 12:38:23 +0200 (CEST)
Received: from katana.hi.pengutronix.de ([2001:6f8:1178:2:221:70ff:fe71:1890]
	helo=pengutronix.de)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <w.sang@pengutronix.de>) id 1RG73u-0002Lp-Od
	for alsa-devel@alsa-project.org; Tue, 18 Oct 2011 12:38:22 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8436610083250783012==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I have here an amplifier (MAX9768) between codec output and the speaker,
all controlled via I2C. I noticed that other amplifier drivers export a
function called *_add_controls(), so the platform glue code can add the
amplifier controls to the codec. Now, all drivers working like this use
a single static instance of the i2c client, because there doesn't seem
to be a connection between the added control elements and the additional
i2c client.

Is the above approach still the preferred way of doing this?

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6dVx0ACgkQD27XaX1/VRvuxwCfXhocaEXkJ+4cKzB5YZ+gShGq
wT0An2OlQDbxviYBHBzbebri0Y86DwB9
=LV6N
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--

--===============8436610083250783012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8436610083250783012==--
