From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: No need to use strncmp()
Date: Wed, 31 Jul 2013 12:01:47 +0100
Message-ID: <20130731110147.GI9858@sirena.org.uk>
References: <1375260253-23376-1-git-send-email-dp@opensource.wolfsonmicro.com>
 <20130731090726.GF9858@sirena.org.uk>
 <20130731094814.GA7231@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7643178277854674447=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B7412615DD
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 13:01:50 +0200 (CEST)
In-Reply-To: <20130731094814.GA7231@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============7643178277854674447==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="omsRjDKoe2J0/37r"
Content-Disposition: inline


--omsRjDKoe2J0/37r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 31, 2013 at 10:48:14AM +0100, Dimitris Papastamos wrote:
> On Wed, Jul 31, 2013 at 10:07:26AM +0100, Mark Brown wrote:
> > On Wed, Jul 31, 2013 at 09:44:13AM +0100, Dimitris Papastamos wrote:
> > > Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

> > Why?

> Hm, strncmp() suggests that we might not care about the entire string.
> Although trivial, I thought strcmp() is clearer in this context.

One of the reasons we use strncmp() here is to avoid going beyond the
end of the fixed size buffer.

--omsRjDKoe2J0/37r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+O6YAAoJELSic+t+oim98ccP/1MhO0NCdi0KEOc/SqD2S/oe
af7Z3paJijImdNKk1h6zu+uxON2iFFfRYDH1TNXb+9gX5WfYzWHjcyX1WLfAAx41
HKu5sKesXDyzv3WEzPxuEEfeHQx3NcJMO6AfTMMxy/Qs9ggvj4Ix14vtgDenFvoC
4gbCvR3H8LOsQFr8rJM4XN88FF7bi7rPJ3s2JyBsKx+IAhIiPYQTf9p0ja71X5NL
+CU5mBg8lQHAnSeULJH6McJBt92WAW9g8qMrxHlVTxLbT9EteqsF0ndmQwGpm09J
4a6/fQaBjo20y2i3iEjIis5jVmuFMGZ/YLtrB6Of6RN9FUh9WSodv8peut9nyi8E
BslbPGmApRHwExS8VQiTIwwYZ6t0JLcSFFff0SfKxv8N2A7Dr2Hp73iXpG7AESvo
A9tOsLSxkRBZakhuyPPr5Y9P0wiblXywOETVB08d40q7dHNxB9IE0ekx8KGGNcrc
gtqfXkLO18H1XZRNzNBkh1Nune40FcPFbNzN9FcBEkn7nH5GD2H2wyJje2l7p2jt
zyhf0qh8AadoS8fozfApDjFW8g9MbWOnRCn7aGeqG6BCpdNvZTwxoNib6mvMZCUK
KuqPo0XwIII1lhN3g1+9dTQr3dcHDgIEcs8uMsEsej1u9JsuBp0Ji9zZnnzYMAQl
v510mi8xZYP0elu0LiEp
=HgXv
-----END PGP SIGNATURE-----

--omsRjDKoe2J0/37r--

--===============7643178277854674447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7643178277854674447==--
