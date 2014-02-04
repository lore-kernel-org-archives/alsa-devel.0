From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: use device dependency clock
Date: Tue, 4 Feb 2014 18:27:49 +0000
Message-ID: <20140204182749.GR22609@sirena.org.uk>
References: <87wqhg6228.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0775948233666420709=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 058332619E1
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2014 19:27:57 +0100 (CET)
In-Reply-To: <87wqhg6228.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============0775948233666420709==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WjdkmbiurS+fPsbc"
Content-Disposition: inline


--WjdkmbiurS+fPsbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 30, 2014 at 11:30:26PM -0800, Kuninori Morimoto wrote:

> +	clk_orig	= clk_get(dev, NULL);
> +	adg->clk[CLKA]	= clk_get(dev, "clk_a");
> +	adg->clk[CLKB]	= clk_get(dev, "clk_b");
> +	adg->clk[CLKC]	= clk_get(dev, "clk_c");
> +	adg->clk[CLKI]	= clk_get(dev, "clk_i");
> +
> +	for_each_rsnd_clk(clk, adg, i) {
> +		if (clk_orig == clk) {
> +			dev_warn(dev,
> +				 "Audio clock doesn't support new style,"
> +				 "use old style\n");
> +			use_old_style = true;
> +			break;
> +		}
> +	}

This looks really strange though I appreciate it's a workaround for a
custom clock implementation.  I guess it's not possible for a kernel to
be built with both common and legacy clock implementations?  If that is
the case I think it would be clearer to just use an ifdef.

It's also better to not split error messages between lines, that makes
it easier to grep for the code that generated the error.

--WjdkmbiurS+fPsbc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8TEiAAoJELSic+t+oim9cXEP/3EYvYxf6flgDuI4wAC3qiXl
wAS26GWa9+ZpCo9EZUymDlxjxkDxGPX03oWhQmWKvRANwAp8zvOuJQ3uEFELQ4P8
rBaZNJgQFLbb6MuKBsVdNA+IAfN5w4cDQuTWU8hZ+jUKJeRf4aLFnQPdPRkrlJrl
N2ggj9pfugiy18guPPya3PVU+x42PwqO1pPy6AdTLhwMCpuspcF4stfKxXWms55y
ariglsapfRx8i4de7ulhbh/wR6ZR8O0F8duAX35QN8t2zqJIUIWR/3HrajNgko7+
NSsBdSHljp8rFvMhi00aJliCtWIJH4SHzOWjquAH/B2NnldkTgVuNU9hdPhGqsUv
Erd1wzev00opd0ZFRcZxhATnnu2HNdrxIIbTOcBL3MPuezkWYKzAChnDSy3DEvxh
6kP8s0cPUKxqwS8kvWVaxh77m/aAX6diFj8DMSezi/twh4tQHVxacodKYlhdH3/6
+y3ac915bPTZj49AsUZk379vrlCXeKIHQH3Tjt6D1MOaKXMhtVQGpfFV66TaqZhM
/2Wq5xBHrW1N+TM3TDV6cj8LN0P8vDFBTu1Ot49NYqzRzlxfVNWUJiQToE33UJ4z
OsAkcxS4NpF33mtxe70nmf38/YWzNQh75J/z29EbhL9FwnaTq+q0cQjr44X6YMKQ
shqAwlx144ILGUv8pant
=fPtn
-----END PGP SIGNATURE-----

--WjdkmbiurS+fPsbc--

--===============0775948233666420709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0775948233666420709==--
