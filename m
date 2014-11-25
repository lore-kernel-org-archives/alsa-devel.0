From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: qi_lb60: Pass flags to gpiod_get()
Date: Tue, 25 Nov 2014 19:37:09 +0000
Message-ID: <20141125193709.GM7712@sirena.org.uk>
References: <1416943780-1016-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1605239811857329500=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 24B5C265945
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 20:39:16 +0100 (CET)
In-Reply-To: <1416943780-1016-1-git-send-email-lars@metafoo.de>
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


--===============1605239811857329500==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KhDKIZ8emI+Lr8f6"
Content-Disposition: inline


--KhDKIZ8emI+Lr8f6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 25, 2014 at 08:29:40PM +0100, Lars-Peter Clausen wrote:
> Pass flags to gpiod_get() to automatically configure the GPIOs. This is shorter
> and not passing any flags to gpiod_get() will eventually no longer be supported.

Applied, thanks.

--KhDKIZ8emI+Lr8f6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdNplAAoJECTWi3JdVIfQIPgH/3I96cI6+GX/2yzT0xFg+Bqu
Pac4a6+nE51Lriybq+v6SACA7S2Vefg0H2vf8Q+HZRBuNivk1GfeTLJMPVhC0P4M
W27ImMQ3FCMGfeYs48+JQ2DPqmbIDsaw3XnwUYT5TAkVyZtm2VCzcLpiB7TOWSSS
+1rDdmwNKo+REqoTbmHA+G9CLIuKPsck026anqqoSK/IDdvdWAJrtme3vmWGsti8
hVZtPAa5jU7ZAFT9tfw/XMuGieWNLP4fSxVFUrmlvKGyLOz+Cc+1fcc9j5Hbkjhz
QkY/BqmimmJHFZzbzMLSdRUjcmKitgpyUXDa+hJwwsNceeTnI1PlO9hqtSOR+B8=
=AP1L
-----END PGP SIGNATURE-----

--KhDKIZ8emI+Lr8f6--

--===============1605239811857329500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1605239811857329500==--
