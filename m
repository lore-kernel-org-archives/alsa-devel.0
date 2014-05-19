From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: cs42xx8: Do not use rtd->codec
Date: Mon, 19 May 2014 13:58:28 +0000
Message-ID: <7ED526F4-A4F6-4FEB-92B0-F13189AD41AC@cirrus.com>
References: <1400479384-19108-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2039790019940015245=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0235.outbound.protection.outlook.com [207.46.163.235])
 by alsa0.perex.cz (Postfix) with ESMTP id 346AB2617AD
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 15:58:41 +0200 (CEST)
In-Reply-To: <1400479384-19108-1-git-send-email-lars@metafoo.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>, Mark Brown <broonie@kernel.org>, Nicolin Chen <Guangyu.Chen@freescale.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

--===============2039790019940015245==
Content-Language: en-US
Content-Type: multipart/signed;
	boundary="Apple-Mail=_88DACD12-BA8E-43B8-870A-06701390EC49";
	protocol="application/pgp-signature"; micalg=pgp-sha512

--Apple-Mail=_88DACD12-BA8E-43B8-870A-06701390EC49
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252


On May 19, 2014, at 1:03 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> rtd->codec does not necessarily point to the CODEC instance for which =
the
> callback was called (e.g. for CODEC<->CODEC or multi-CODEC links). Use
> dai->codec instead.
>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> =97
Thanks

Acked-by: Brian Austin <brian.austin@cirrus.com>


--Apple-Mail=_88DACD12-BA8E-43B8-870A-06701390EC49
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJTeg4LAAoJEHdXZdGWfiO7lx0IAIZoprfV8gBxv6DqwH92IsU+
SgKWhIgHRohT8K4P7Otgsxmg5bmroWej0cB1KNt7ZD49K2kvbQGuFiU9jhCgRpt6
PyZyBUwahPCjSSiu6ge9NO9p9FkD61UPXQQeOTSNN4gRbg2YO/llZqowgW8q6lO2
Kf/Kywo6yrXF1jPuu8sJABE/NKHp8KRb6wS+/PRG+/bGAf45Hog5OiDl41EO9riC
ZgtRlAsgYQbjDE/wXeyUdNk88omBkjDFBTtW3wRqL+8wyCucIeABe2U369MAH7Je
5WRP0SfJyn0aIvfKPHTiNva0MoUWE1r6QiS8PA+q+kMONKeK7CQYQs1w17jF+HM=
=5HrR
-----END PGP SIGNATURE-----

--Apple-Mail=_88DACD12-BA8E-43B8-870A-06701390EC49--

--===============2039790019940015245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2039790019940015245==--
