From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs42xx8: Check return value of
 regmap_read and report correct chipid value
Date: Thu, 3 Apr 2014 22:33:39 +0100
Message-ID: <20140403213339.GA14763@sirena.org.uk>
References: <1396511616.30532.2.camel@phoenix>
 <20140403153314.GB32327@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1077084000063678828=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DEC7E2656DE
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 23:33:58 +0200 (CEST)
In-Reply-To: <20140403153314.GB32327@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Axel Lin <axel.lin@ingics.com>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============1077084000063678828==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5cXpu7evJfjLw2dJ"
Content-Disposition: inline


--5cXpu7evJfjLw2dJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 03, 2014 at 11:33:15PM +0800, Nicolin Chen wrote:
> On Thu, Apr 03, 2014 at 03:53:36PM +0800, Axel Lin wrote:

> > +	ret = regmap_read(cs42xx8->regmap, CS42XX8_CHIPID, &val);
> > +	if (ret < 0) {
> >  		dev_err(dev, "failed to get device ID: %x", val);

> %d and ret would be better here since val won't be useful in this case.

Yes, they would - val won't have anything in particular in it if the I/O
fails.

--5cXpu7evJfjLw2dJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPdOwAAoJELSic+t+oim9DTEQAJj0hr36ReK/o/RV9ze3T3jP
XP+Hudhr8rmTjvc+rXhhVLx4umwGBzvnZfJiMxbxHU6lWJBmQ/3C9istE9La0eMd
KqtDN5PYs6X08VCysRUs9Fj1RZEMUvsUHar54l/YXJrcUTXjLVok0xO0kYCl7llS
u+sJqB6GoD/xFiPoRo/zXCcEQV2GFCk7XtxvuL82uw62F4d5+Lpbg/WKlinfEe/O
rJRfV4fcsjam6RpcdCQN1IaAIODXKQI8aRudNorZa68yF107fQIHpSvdYEOL2tcI
697Y3aZ+Lm6wUUHaRCKASmMQvOCixbJg2B9W1+HQrU6JZkOUaHLDSSEbXXaCf+zA
HkOfYwIFMEAndjy747dehHMUYyQHI8oeqGHRyiipcCEbkOTJvuAi4htiUrks74jh
+UDGeOghGZlz/04dBWGa8y1Aouv+0sPapcy9AdfFPUKB9MO6P0nnHg1TzzvbSENL
GqW1aMX8tY+iVhTAd43pYVHOPFIEfsVIfVgvH4FnSgHkntQYyknvF5UMYhTbJZOA
k+KMZ1CxuBrEr6U4j+bRfw8ufaZTvuWRx5q2DnLQyBZZZHWGTB1VSwDgxg0kUqNq
cy5L89R1ykBs5BaD2feXW9HsJLe95CXz9VFQBvAaZU+HAj5HO7GXdo3ZUGmlpUNQ
paM8ZgGROhmtBVdEMzJc
=wwmZ
-----END PGP SIGNATURE-----

--5cXpu7evJfjLw2dJ--

--===============1077084000063678828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1077084000063678828==--
