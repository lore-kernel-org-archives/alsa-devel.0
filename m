From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6] ASoC: add RT286 CODEC driver
Date: Wed, 4 Jun 2014 13:37:15 +0100
Message-ID: <20140604123715.GJ2520@sirena.org.uk>
References: <536B4708.8080203@metafoo.de>
 <20140512202918.GG12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73DE932@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5223413368621346273=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A620D264EED
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 14:37:44 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D73DE932@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============5223413368621346273==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MzdA25v054BPvyZa"
Content-Disposition: inline


--MzdA25v054BPvyZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 04, 2014 at 12:08:41PM +0000, Bard Liao wrote:

> > Kind of?  It solves the cache sync case and if it's write only then we won't need to
> > go to the register map for reads anyway (outside of interrupt handling and so on).

> Does "write only regmap" mean read (almost) everything from cache? If so, we
> don't need to care about the asymmetry read/write issue. In that case, can we
> use regmap for mixer/mux controls just like other drivers do?

Yes, exactly - most things should be able to get away with only using
the cache I'd expect.

--MzdA25v054BPvyZa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTjxL4AAoJELSic+t+oim96xIQAJNYD0NhDCvVIxT66DCKWOzm
oTGjWvEM0ID9NsNh9U9W9g+mTzHjn6UbKUO6Jz++jtj82kqZZbEMjdTpXUa4YrxJ
yRxAjtfGVnpwHpNKItdnu2oWZBaRadKgzHxUVT2BoNHGYmxmclmwjiw3A0AaowDJ
T9FaCQwv/0HIgWJpQIPSaBESo7yau9PkDSkGezMtc8fbFQSvIPOFaVlqmX+K5Cxo
sfCH+d1XHraWQnVHqE0t3I1zArjgiwma2L/nrXYVXmcTo4CPxxsP92JQDiXjVIpP
akvCfEeaMhTcxIHP/8a7jfU6yVR9QB3gj4/4jQEuBaHGOUsi5ZqGKUt77hH/hZTu
dz9Jq/bpeDT7WUoGq30/P1zF5lGQYv8ZEj4YyU0YiHWRzldh/vWNxL/t175z8yEy
O6aDNDk1xQzY+veZ8Hli6HxrRjK+VpIAxO/Y2z+act1vG08W2V+vJWuN2EYaBSB9
wLy9EtFGsQQgZlAbbFl87ZelxCIC4InPDEkHKFjBhzT1O3Sx9Z/e+X1UBgDz1Jqn
J3YR/4Webwat6DyyBnFqu4L0DQZZYzzr+H4fvMchwYQzL2QFeYdR9LlDWGZdo4Pb
RNrCjPZ0PE3T+CF36p/CU33F/j3XJU1TQC3s1sUE4aejXfFXy9Y7IN5ygJWctI/R
qc8bQyN3ZTg7ovBW0Rzx
=eVFH
-----END PGP SIGNATURE-----

--MzdA25v054BPvyZa--

--===============5223413368621346273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5223413368621346273==--
