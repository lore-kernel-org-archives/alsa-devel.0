From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 6/6] ASoC: zx: add zx296702 hdmi codec
Date: Wed, 3 Jun 2015 16:09:09 +0100
Message-ID: <20150603150909.GN14071@sirena.org.uk>
References: <CABymUCNvM=k4tWJutpzoK-VFvKhBC4EGjh_OzWYMMRppUqvSOA@mail.gmail.com>
 <20150602181326.GB14071@sirena.org.uk>
 <CABymUCOWiHERfvw9c5ihsvgXXko1HLwv+7ectLOiQd3rGSHHPQ@mail.gmail.com>
 <20150603110123.GB14071@sirena.org.uk>
 <CABymUCMC3mZidbD6FPf=wSqbQoSwWL5z2uLgrXOS6jx96EFMtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3579200157372136555=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 736512606B7
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 17:09:18 +0200 (CEST)
In-Reply-To: <CABymUCMC3mZidbD6FPf=wSqbQoSwWL5z2uLgrXOS6jx96EFMtA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jun Nie <jun.nie@linaro.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "wan.zhijun" <wan.zhijun@zte.com.cn>, Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============3579200157372136555==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="efFJd/fQ0cD5Wc37"
Content-Disposition: inline


--efFJd/fQ0cD5Wc37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 03, 2015 at 08:40:31PM +0800, Jun Nie wrote:
> 2015-06-03 19:01 GMT+08:00 Mark Brown <broonie@kernel.org>:

> > Are you saying that the HDMI IP doesn't appear in DT at all?  If the
> > HDMI IP appears in DT it should be possible to reference it.

> Thanks for confirmation. Seems I have much to learn in DT. Will create
> a CODEC device in HDMI display driver and feed HDMI device to simple
> card as below to have a try. Thanks!
> Do you think other patches are OK to merge except the two HDMI patches?

Lars had some comments on the S/PDIF driver.  I didn't look at the I2S
driver yet, I'll try to do that today.

--efFJd/fQ0cD5Wc37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbxiUAAoJECTWi3JdVIfQxhsH/3+cO3q8ZWjTWzy8ClqrBdC6
uawcZOZ231IM0fbnqfF9OJgIV7cj2pnZlh+rbfE7Nz+xejmIrLz5H0+OLDAp7GuI
e9wUMEkha/QAc+uuNiiaNn942AB4POFFUjecfGCiVr41n7wpZQKLW5ZoCFMr9Upp
oBk0Tu6wWeYV7HpHMxyZbntiax8zG6rEfUpvvTQTH0UPggDpRbyJQA8+Tx0bItgI
iuYdxqVcH+Hj7G59ZonzgFXFuAmQijAdaO7nu4tP3Le/YCPxO4VplpM8ZWZfBA9E
yc64wFykB2Tye+zAbSFGREtSmcyBn7KIkUzzEIa4fuChf2BP30U3NJ6ywqy5zUo=
=VP1Z
-----END PGP SIGNATURE-----

--efFJd/fQ0cD5Wc37--

--===============3579200157372136555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3579200157372136555==--
