From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFT] ASoC: rt5645: Fix updating wrong
 register for T5645_AIF2 case
Date: Mon, 19 May 2014 17:23:23 +0100
Message-ID: <20140519162323.GE12304@sirena.org.uk>
References: <1400325452.22102.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4748541938732291850=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 90B8626087B
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 18:23:35 +0200 (CEST)
In-Reply-To: <1400325452.22102.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4748541938732291850==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VO17lTftWQqxnFH5"
Content-Disposition: inline


--VO17lTftWQqxnFH5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 17, 2014 at 07:17:32PM +0800, Axel Lin wrote:
> This looks like a copy-paste bug, fix it.

Applied, thanks.

--VO17lTftWQqxnFH5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTei/4AAoJELSic+t+oim9ebwP/juHv/gub6+nhGGv9xIoVNVY
JZdWHHePo5Kgn2dfYnFQFvyyse+knhPc3mpPsJuQW1LxGBLTSWL9PTEKnwRgvH5p
yuIxzJ3QXqg0RgcgljKchyaDp+aqwxIKXSEl1Qmag46UXoEw9LDeRjWHAyARFkpg
CfqTjsPbAAQAFFwqDtoS3eJpnlEVrE+lNHHVGj8qD48lyj6uGUS/DcblAUXPxErR
vn+/YQL2zKDcb7xtKAmskf3RyOPmwSlgopAjsrF8IpG2GCVVb7UIS4MAml+GoFxP
Vh38U4LDqWH3I0S88+DhAsEhTJWxdASdVEUlV4NiRfXPChTtvJ0HuCUzOhecL7uw
Epcv3ORp5dqlxXTLpqWF/XQuedXQSZYjNVIwlw0eTEZL8SaCTWbwBbZOhZlcgGaZ
V+Pdh3rxpDmQHr//v0GElsc9OmQfd1IaWSaSucMwjpVG2bQGqUO8Xw5bMQ3VjeQR
yWjBqD6uIVGZS46WESapd4N8tsX4xj5gtr8ia+6P+Q3oivt+BnvYrK5BnraR/gyR
xbBbGucsIzVHw/6d8zgg5NtUgLnJYjMT7wM2a2ea2aPvGOf9mHhYEdkDzG72QRQw
kJwUnuFb2wuPdQD2I0I0aBnJf30l6U99wiwdVLk0d/1k6VVAwGx+3o6qa/d/lThJ
tUUNCQBMfEVxu+K0uPKm
=FnUo
-----END PGP SIGNATURE-----

--VO17lTftWQqxnFH5--

--===============4748541938732291850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4748541938732291850==--
