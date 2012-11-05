From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/2] ASoC: tlv320aic32x4: Add rstn gpio
 to platform data.
Date: Mon, 5 Nov 2012 09:15:51 +0100
Message-ID: <20121105081551.GD28886@opensource.wolfsonmicro.com>
References: <1351680814-13714-1-git-send-email-javier.martin@vista-silicon.com>
 <1351680814-13714-2-git-send-email-javier.martin@vista-silicon.com>
 <50913851.6060003@topic.nl>
 <20121101143514.GJ4413@opensource.wolfsonmicro.com>
 <CACKLOr0a+oUiP6gh_FNZ+cx7KkTiBef7mRWf3FO7xmRRUYUf0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4498601375353272995=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B009D2615B9
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2012 09:15:53 +0100 (CET)
In-Reply-To: <CACKLOr0a+oUiP6gh_FNZ+cx7KkTiBef7mRWf3FO7xmRRUYUf0A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, alsa-devel@alsa-project.org, lars@metafoo.de, lrg@ti.com, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============4498601375353272995==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Content-Disposition: inline


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 05, 2012 at 09:14:41AM +0100, javier Martin wrote:
> On 1 November 2012 15:35, Mark Brown

> > Probably easiest to just convert over to regmap, it handles paging fine.

> this is something I'd like to do when I have some spare time. Do you
> know any example of a codec driver that uses a similar approach for
> accessing registers?

The WM2200 uses paging, and grepping for regmap will turn up a bunch of
other drivers which use it.

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQl3WwAAoJELSic+t+oim9rMAP/i7nBa2Jp6U6dT8yBWUO6qXw
cRAoJFpv2zjGSA2+F9Pq5yxnhmmZP4ezm0dLuvtnmAckHKG2/xh5oxKwy1eSKwo7
4ij+WiUkovo7j1AwSo3QQIXtEUhCM+xeoqwm6mvjUbeylcoliDp8GUJKyRq5HCqN
S6H2U95d855daBfZzfo7RsQqARI4Ozw1V9e8tfGcDsLloGtlP1ry4zNm56x9Ey8G
Loi74i+vIsz9zAFwmFACaY9u8PyzdD/dm//9b9aO1mKq3c6IA+5DICnULfnoEZtN
VQ7ip29RfmcKRhdRluc1/JFhrqemWlb8QLmlCp3n8+sytcJoLUHq+5vReNDrc8mT
mjFu+2YTITj26K4w49/8fhXPkXVFtfV6Re006JMFhwzIqJ7RNwGY58MA9VmfuYdN
4A68ckKdwCScWCoxQsKDK45ZwCHVFcAm2bm58q3NaXZ3wVyUQcC6W2mnz+ddbgSr
C6L4nzoa9AAzJpVJlqy5Dw6MRKI4Lj0yfv41k0CN5mMWA7ye+eS9XGLFi/dV92mJ
FtMNEU8I0t3cXzy/02fPSASV0S95x0cg0ZXDNS1IYcxq7os8OBcyLKF+rs0xJmfq
JJfM9wmZ5sfxfI+L/9C/eYKFA6Cm+jOGgavLBt39oRGTM5zZajPp8CdcdhsXw/DJ
g5ks47MjJDx9KytwTtpl
=JXyl
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--

--===============4498601375353272995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4498601375353272995==--
