From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8523: Set bclk ratio for master
	mode
Date: Fri, 12 Jun 2015 17:17:44 +0100
Message-ID: <20150612161744.GC1921@sirena.org.uk>
References: <1434117452-25223-1-git-send-email-julian@jusst.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1902060162720637085=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5785B26048C
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 18:18:03 +0200 (CEST)
In-Reply-To: <1434117452-25223-1-git-send-email-julian@jusst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1902060162720637085==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2pi4Gp0KyRJpQ5Nw"
Content-Disposition: inline


--2pi4Gp0KyRJpQ5Nw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2015 at 03:57:32PM +0200, Julian Scheel wrote:
> When running in master mode the bclk divider must be configured to generate a
> sane bitclock. Pick the smallest fs multiplicator, which can hold all
> transmitted bits.

Applied, thanks.

--2pi4Gp0KyRJpQ5Nw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVewYaAAoJECTWi3JdVIfQ2GMH/1GB866gwiAyALq6MZ9LiDz6
U1kMI/RjtdHgy4GIoX0d6kd8dY4sjPtYjLsSq8xXre45H6EyG1LM5KaeXTUlugAw
l6Xx3h0hUObrj0GQivKczAKCnFYSRQnJW/mCMBVwymf7AZ3p/WBvAoUm1XU69y7L
n3a1cX4q33xncue7Nw5eA21Lag7zsOpLOSniaLyuYEPPSBJR2oHL7iWh4sJnt4ZD
4sZ7/pH81gQbuWx0YLQ1G2YrZTo9wqhroAdsa5mymgpuKAhzZOSZx1sMXLz2ExRm
1mdIMXfduNXl6H/PqPik5xSROU/V/0+2mu8NnV0Y+C3M39TfNlesED4DmLiG0D8=
=I3hq
-----END PGP SIGNATURE-----

--2pi4Gp0KyRJpQ5Nw--

--===============1902060162720637085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1902060162720637085==--
