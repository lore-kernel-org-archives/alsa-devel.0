From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 02/13] ASoC: qcom: move ipq806x specific bits out of
 lpass driver.
Date: Thu, 21 May 2015 21:11:51 +0100
Message-ID: <20150521201151.GG21577@sirena.org.uk>
References: <1431779462-1732-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1431779537-1907-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="etg/Ry6vb8quy2uR"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431779537-1907-1-git-send-email-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--etg/Ry6vb8quy2uR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 16, 2015 at 01:32:17PM +0100, Srinivas Kandagatla wrote:
> This patch tries to make the lpass driver more generic by moving the
> ipq806x specific bits out of the cpu and platform driver, also allows the
> SOC specific drivers to add the correct register offsets.

Applied, thanks.

--etg/Ry6vb8quy2uR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXjwGAAoJECTWi3JdVIfQCFIH+QEcewaxDJe9WC/JkIen+Pqr
7GcXXiFCBleIbTLzgDI1/N3vha51pnsa0Gg1pgiAkOhDqkMmoZpcTP6PbdFzdUiB
eMl9TL+hFK0AP+O7X+tsI8Acb/lMWQv7vQH8pYEB+eCfdF/zj2ZSTuGR2pBndJCz
bnx6NFqG1qlSrRcNF5d4pZzOOPr5cGN2vuvAk4PhbFMX0s1Wn6ir73srNrFYfzJs
p3wW9M//PnR+Z6gY7xysdj7ry0jW69y5OSDHtjcAr6j4h9nM0pIKhIH3wuEXb3xN
zefG/HHPAVtU8Cp6guliOMZbvJTfp473pvBlW+TIWyF+VX/i4gZQfX/z2CSrfE0=
=S2EK
-----END PGP SIGNATURE-----

--etg/Ry6vb8quy2uR--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
