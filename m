From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: s6000-i2s: Fix
	s6000_i2s_remove() return type
Date: Fri, 4 Jul 2014 18:58:38 +0100
Message-ID: <20140704175838.GB14896@sirena.org.uk>
References: <1404115299-24109-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3128890573587511211=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F6852659E6
 for <alsa-devel@alsa-project.org>; Fri,  4 Jul 2014 19:58:46 +0200 (CEST)
In-Reply-To: <1404115299-24109-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Daniel =?iso-8859-1?Q?Gl=F6ckner?= <daniel-gl@gmx.net>
List-Id: alsa-devel@alsa-project.org


--===============3128890573587511211==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 30, 2014 at 10:01:37AM +0200, Lars-Peter Clausen wrote:
> The platform_driver remove callback return type is int not void.

Applied all, thanks.

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtutLAAoJELSic+t+oim9dK0P/i28UkkXBIsxP0l8bq8EITWY
jphbp5pAPSf0nGt33epGb7LN3cE3sPqAFEGVKcBaGAknQc19rMhTctCIQbcPuxj8
p5Z5xlVskvpMFQ4d6FsVZV0TtAkya8yWN4xlSnoCTcyORDuuOVZT74BAvvYX4Pj0
rNs5YtwhOID4viZXDf6Lx3sOemRiyT7d0l9ajZ02SDIoXCsj/njKnM15QJOjoErn
Zg/w5FvxwEEZXpAKBYnXlO5GryacGbPLeiDNs1EOrtDcLngqDFUtD/2Q4Gy0TagA
EmWB782JeGGRNL1h9Acd3//i3n8kl/v1dpBBcYFJdQlG++pWc7pwFVzDuoshPitT
YoWmc27d5KIveq5ECPtkkICfeO3wAYN4GfdFQcroihKlAbRn50p75Pn2wkbw54PQ
o8anY39jC5AH41eZiBrdprQLXojeOqUA+zfd6dRrY1YaILClL6iBlnqwn6L3Y6HE
XjQ8nbtZdAnCY0f+RHPm6iYAajuqZM6EO7jWKQk5qJ6gGdsLYoJUlXfslIUqEekW
KfhCHli44C6JZQ9Bb69T8UuWkKyDXDeOs1Y8b2xaQZxXNIEHG6aWkJFx3zXbNPKt
8DmWDn3F+NoT+3Y5x4AqnUUrnTsE4wJRm9HfohjPhWy1QhgIOcRxu4uIu2owqdB1
sl06E7nibxp6weZFEtj8
=PyD0
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--

--===============3128890573587511211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3128890573587511211==--
