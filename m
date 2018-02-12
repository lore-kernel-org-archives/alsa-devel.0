From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/9] add UniPhier audio system support
Date: Mon, 12 Feb 2018 12:48:58 +0000
Message-ID: <20180212124858.GC12976@sirena.org.uk>
References: <20180119092536.22501-1-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180119092536.22501-1-suzuki.katsuhiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Katsuhiro Suzuki <suzuki.katsuhiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Masami Hiramatsu <masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 19, 2018 at 06:25:27PM +0900, Katsuhiro Suzuki wrote:
> This series adds support for Socionext audio system for
> UniPhier LD11/LD20 SoCs. This driver supports I2S output
> for Line-In, Line-Out and S/PDIF output.

These look fine so I'll apply them however a patch series from
Morimoto-san (CCed) moving things to use components rather than
CODEC/platform/whatever driver types that was sent about the same time
has just gone in - the driver will require the same conversions.

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqBjTkACgkQJNaLcl1U
h9B97Af/WZ98YjR9pqKv2q9x07O8um3kwXtYVGFUp3gFYX13OQZUW+sfFSg1q2YG
W7386wNTVqEYCyA7w2O024GFRc62ued4u2vjt0VlegFTkEt8xhc07DLEjvFamGwl
ve6DxpuOVwd9UTQxeuiq/xxQE6wtDXKjX/Xn0u9+Zc+2w0dQGyZCX0AE9jgb/dD5
vnsn7+3EPa8uip7x4Tnur8Y+aXJl9skenvuJ0jGIWgahclRKd/nXpNxxVHcwJmJc
ZGSD4fca4ORnPMaV2UDNavg+fnZIZet4uJaIBBHVP68N+Cn+htpOlxuVCdHj1UZz
J0vPIhagpoWOl7k843pQgtUROpmn7A==
=J7Qc
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
