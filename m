From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] Add imx3sound sound support.
Date: Sun, 11 Mar 2012 11:40:15 +0000
Message-ID: <20120311114014.GB3233@opensource.wolfsonmicro.com>
References: <1331304916-4724-1-git-send-email-philippe.retornaz@epfl.ch>
	<1331304916-4724-2-git-send-email-philippe.retornaz@epfl.ch>
	<1331304916-4724-3-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8677814796286158484=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8824E2433F
	for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2012 12:40:17 +0100 (CET)
In-Reply-To: <1331304916-4724-3-git-send-email-philippe.retornaz@epfl.ch>
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
Cc: juergen.lambrecht@gmail.com, s.hauer@pengutronix.de, festevam@gmail.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8677814796286158484==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2012 at 03:55:14PM +0100, Philippe R=E9tornaz wrote:

> +static int imx3sound_hifi_hw_free(struct snd_pcm_substream *substream)
> +{
> +	return 0;
> +}

Remove all empty functions.

> +	imx3sound_snd_device =3D platform_device_alloc("soc-audio", -1);
> +	if (!imx3sound_snd_device)
> +		return -ENOMEM;

No soc-audio usage, use snd_soc_register_card() from a platform device.

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPXI8XAAoJEBus8iNuMP3dJcgP/06/PO/Aj8/wty473dp/7lpc
OXG8uMqle2mPrDHJTK5xqHSqt+pyo3SvunkFTvId+XfErRXSgR2ePtJT9ux8IEPn
2rtlp0avMonisXwEXPtcnfDfuhNmmY0nRvjXEfAIA5UlgDRURbysz5LzoFiEc8FJ
QqGOwqPvwISPqaL3oHfCxkrb9uMfV6zK7IKthUkGRl36amRIv6ceDzeq+UdzwmUL
QrpYmf1cuYodAGFyO19s4SJEMV734k8+BER424sHzNyQnWj7Yjwr3wezmsyfsY08
YbnLRyzgfMm37RQk+4MJgY0uZhLCl3IvJeKxO+Bhn4vuHrk54trr48NT8ZgGHEt3
VWv2w5umntyzqX/QbbHZluL01g8L7YQNZQ0tNMrJQBsCp5CSMC2PblLQgkQv/sF/
q7YardHgOVDDoPq+MLgogp+GGmq0TYIoGYEJZL+INMEYy1l7r9EU2RrfpllWm+FX
QfeuNWoxQ097LqRfRbaqv6s/2LN0b/LGuHrR9GrkaiKihAtPqDteQe7el7tQ07vv
t2m8qDJ13q9mYiR8jShYo+nhihdW3GApK3l/6LgXW+bPnjvCHzXgGkZ84Ympd2EL
JtapXq+Pw7U69RBo9LewnZeTUdMkENNpMxmtRCf5HjmbyjvWXfhbMb9Pi1EmBASf
v/QygnhRcRAK7e6mZbn5
=DrDc
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--

--===============8677814796286158484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8677814796286158484==--
