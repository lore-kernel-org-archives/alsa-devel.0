From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/13] ASoC: tlv320aic32x4: Model DAC/ADC
 dividers in CCF
Date: Tue, 19 Mar 2019 15:28:33 +0000
Message-ID: <20190319152833.GG5514@sirena.org.uk>
References: <20190319033756.20616-1-nh6z@nh6z.net>
 <20190319033756.20616-5-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2858565676744621257=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E506BF8968D
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 16:28:36 +0100 (CET)
In-Reply-To: <20190319033756.20616-5-nh6z@nh6z.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: alsa-devel@alsa-project.org, team@nwdigitalradio.com
List-Id: alsa-devel@alsa-project.org


--===============2858565676744621257==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hTiIB9CRvBOLTyqY"
Content-Disposition: inline


--hTiIB9CRvBOLTyqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2019 at 08:37:47PM -0700, Annaliese McDermond wrote:
>     Model and manage DAC/ADC dividers as components in the Core
>     Clock Framework.  This should allow us to do some more complex
>     clock management and power control.  Also, some of the
>     on-board chip clocks can be exposed to the outside, and this
>     change will make those clocks easier to consume by other
>     parts of the kernel.
>=20
>     Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
>=20
> Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>

Something seems to have gone weird with indentation in the commit
message here?

--hTiIB9CRvBOLTyqY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyRCqAACgkQJNaLcl1U
h9DHtAf+Ku7ELXvP0iL7jKgcfLZDPzl+wzNCKD/7aQB8bpNFlKPfgXJQGMTAUXAY
zQKV3tkRlWh9Ae9br+ZG1VfBY1ZmJvbaJFSo26LeFYfz6nMVyQdb9ZIRvgNoxuzC
XNkZ7UCtT0vaxPklsfC+tKGjMLxSSzWBQMQPT2KmSVXbLI55kp60mvZgU0bJSDqA
ZrD5UbaQ8yT7JeTh768bPR2TwrgkpIJEUFfTARJ1Xb3XX/ntHDH3bZdPnB/2b9k1
4u0hKZVxjmXjncBIMjiZNRAcEw8295PHCT0w3BqIZmIgj5jc8IUiJq9inU/v9Nuw
kabe9JR96iwISBAqplR+LzixuFCxvw==
=tiht
-----END PGP SIGNATURE-----

--hTiIB9CRvBOLTyqY--

--===============2858565676744621257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2858565676744621257==--
