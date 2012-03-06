From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add missing regmap_init_i2c in
	wm8804_i2c_probe
Date: Tue, 6 Mar 2012 12:23:02 +0000
Message-ID: <20120306122302.GO19635@opensource.wolfsonmicro.com>
References: <1331017613.11182.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1165112554447937349=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D77651044C7
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 13:23:05 +0100 (CET)
In-Reply-To: <1331017613.11182.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Ian Lartey <ian@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1165112554447937349==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y5wfsVCgeKAcINk2"
Content-Disposition: inline


--Y5wfsVCgeKAcINk2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 06, 2012 at 03:06:53PM +0800, Axel Lin wrote:
> commit 891271c "ASoC: Convert wm8804 to direct regmap API usage"
> only converts wm8804_spi_probe to use regmap_init_spi.

Applied, thanks.

--Y5wfsVCgeKAcINk2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVgF5AAoJEBus8iNuMP3d+c8P/1SZ4pnJob4IOe5Sr6Wv/Cgn
xs0qb9/0I6u/p0AV0VQgjr2MIAQRryuHmGrSXo/X+gdWnNw6qksfUE9OwWiYXpxb
ycH7kYmpmjGNI6HtrqLUxTvTuXruEbedurbAd7sB7SCa2XbltQylLWRIEd2gpfO/
xN0S1/U7BYf3Dntu+3mHsg5EalPZN8hD+uL82vTpwDUQmQxGrCeYdcJ34o38oMTA
sC1qoes/VlvlVkC+bJpoUha0AozEkyJMWRJQK/iqFtnIa+4WS6G4o7Io3dQ/z6yM
51WGJfopNO8H5YIgufIAQr363fTBHeeqtjY4NPuj/WMq9NUOzqTp5CgfVfhB0BQQ
Dy2g9NmhtfdOkXTxZEKYzbTmPGAQbv8ZjPCTHgvDYScw7lGYceBefiIhZJ8wDtga
9N6mdDnqMldyh9SOeCKqYFnnXsiq50fbSo2F2cMcnKsEG22NhmX4f1YIk9QiiCed
Pb1ZfyWSOaWD43MjbdTNO85zP3/aAQJpNSQnN+PhlVUDpgJBzUdbMeBncZyABRSM
0RSzpuYw6bh6JNYjbDxfZOsQWskv3Ek3Xv9naR2Lr2oQYehykvdqUuGlDZ8NjlOY
8IAMWQ8g6jbEvIujqcOC7bEzZu0+o3TX4hPFb/JcMjnFF675Kp1oX/8SiCHwUMqS
VHuqbgrJZussegLAq2RK
=YGwv
-----END PGP SIGNATURE-----

--Y5wfsVCgeKAcINk2--

--===============1165112554447937349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1165112554447937349==--
