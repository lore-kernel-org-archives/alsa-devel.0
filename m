From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASoC: add imx-mc13783 sound support
Date: Tue, 15 May 2012 19:30:35 +0100
Message-ID: <20120515183035.GG19592@opensource.wolfsonmicro.com>
References: <1337082832-9764-1-git-send-email-philippe.retornaz@epfl.ch>
	<1337082832-9764-2-git-send-email-philippe.retornaz@epfl.ch>
	<1337082832-9764-3-git-send-email-philippe.retornaz@epfl.ch>
	<1337082832-9764-4-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6624654839405477596=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 17BDB24DDE
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2012 20:30:38 +0200 (CEST)
In-Reply-To: <1337082832-9764-4-git-send-email-philippe.retornaz@epfl.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: alsa-devel@alsa-project.org, torbenh@linutronix.de, sameo@linux.intel.com, s.hauer@pengutronix.de, festevam@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6624654839405477596==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9/eUdp+dLtKXvemk"
Content-Disposition: inline


--9/eUdp+dLtKXvemk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 15, 2012 at 01:53:51PM +0200, Philippe R=E9tornaz wrote:

> +	ret =3D snd_soc_dai_set_fmt(codec_dai, FMT_SSI);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D snd_soc_dai_set_fmt(cpu_dai, FMT_SSI);
> +	if (ret)
> +		return ret;

Set this in the dai_link structure.  Please fix incrementally unless you
respin, same comments about apply if Samuel is OK as the CODEC driver.

> +	ret =3D snd_soc_dai_set_sysclk(codec_dai, MC13783_CLK_CLIA, 26000000, 0=
);
> +	if (ret)
> +		return ret;

We should probably have something for this in the dai_link too but we
don't.

--9/eUdp+dLtKXvemk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPsqC4AAoJEBus8iNuMP3dgt4P/RJnmpuI/i4J91cKlKWHSlNC
XOirYfTMLvGL2cz71MEmlW3e3Trd9Z2G4oxzlr0CX2DV6oTzdsvmt5qUbbNNN9DI
XZeOLpxfkZHkZDt1ECLFpVwBgPBUcQVqAHc+9UEgGzbSMjL+m0I5bY8fEtFGgsH2
asZrBonq9rEDVXVIOBmNaQc8NCG/8XTCCWoXNlRA3h9i3UunVSnlfRYKksMQCROr
WkQac1ZgXu7hExyHOuHk3RfeWfHwbyIo/sOizqPd6M/N1Xb15Cw4mEcqXNlF8b81
KJLB3bvcYN3Feq8WMI7MXHFXBsPHRuGxULRiZ6zIPM/mJ6wbh47H50iMJ4wP/2f+
nWQ9IK66F/moAarlIyuEY1JMk71KcHemaH11gJWO6rq0IYC4T1nYh87GA5XGDGTZ
M6+hyJ68ThFvBZzlBgY8AONxa1vpcFfETGEm2eD3lsCpjMQifuMtnxR90+uTeyA+
QKqnIL/8EYJHqqzf8Lt6ChWeDCQb2FP9eND9BFtbwnReOXs0YO9OLKFWErp2sen3
IoRFJka9tewJIeb1eSWulGOeP0DPK5V8sP+1cweGs5Ekd03VgJDoUyDZ/3USb6Dp
yA4iBw3L+HLlI7KczBcF9VGBU2K8GNUiRgpWfLrXvokCcpt6swerbEtYvyFUWGHd
tOMkQxGgg8Ix62Miu0mg
=CT6d
-----END PGP SIGNATURE-----

--9/eUdp+dLtKXvemk--

--===============6624654839405477596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6624654839405477596==--
