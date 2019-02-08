From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH resend] ASoC: regulator notifier
 registration should be managed
Date: Fri, 8 Feb 2019 13:10:41 +0000
Message-ID: <20190208131041.GE6695@sirena.org.uk>
References: <alpine.DEB.2.20.1902060859440.14292@axis700.grange>
 <alpine.DEB.2.20.1902080838390.22709@axis700.grange>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7853626753540075145=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DCB76267483
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2019 14:10:48 +0100 (CET)
In-Reply-To: <alpine.DEB.2.20.1902080838390.22709@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============7853626753540075145==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DqhR8hV3EnoxUkKN"
Content-Disposition: inline


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 08:40:17AM +0100, Guennadi Liakhovetski wrote:

This doesn't build:

>  	if (ret) {
>  		dev_err(component->dev, "Failed to enable supplies: %d\n", ret);
> -		goto err_reg_get;
> +		retturn ret;
>  	}

sound/soc/codecs/wm8995.c: In function =E2=80=98wm8995_probe=E2=80=99:
sound/soc/codecs/wm8995.c:2043:3: error: unknown type name =E2=80=98retturn=
=E2=80=99
   retturn ret;
   ^~~~~~~
sound/soc/codecs/wm8995.c:2043:3: warning: ISO C90 forbids mixed declaratio=
ns and code [-Wdeclaration-after-statement]
sound/soc/codecs/wm8995.c:2043:11: warning: unused variable =E2=80=98ret=E2=
=80=99 [-Wunused-variable]
   retturn ret;
           ^~~

--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxdf9AACgkQJNaLcl1U
h9ASiwf+LALncVzTV+uROJaX4b3ZO7w5iDebzdmDV6YHtF5pvbW1SDOy7dxZz937
Pc7vWrQ3bfDAs8TYpgIj6eD1HCBi8YbNsnYuMjhx8f3atMKM4qONqHGJlH7+tqC0
HotKFwIBB1Onug1M6tnTL1wBdm7fkAaLP3fVqgxLBcubXakI4MLA59HBi8SSLHLr
ix15KvBleXkfb7hv4P8IZ8EujX+weDHz/J3s0JXNjDtDCm7sLALMHj3DuI+Q0mpL
1wJQ/qjhfgMUH8QEBHifOntZUD/RWDZdQzsON06fsJ2LjuESqqH008O6kwPiMCdo
gjj8PTLdyFzBwpY5U8tXiWcgtgYlzw==
=FEMX
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--

--===============7853626753540075145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7853626753540075145==--
