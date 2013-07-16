From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: sgtl5000: defer the probe if
	clock is not found
Date: Tue, 16 Jul 2013 18:54:35 +0100
Message-ID: <20130716175435.GX22506@sirena.org.uk>
References: <1373937447-28722-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1933921818364306186=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DE37F265094
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 19:54:37 +0200 (CEST)
In-Reply-To: <1373937447-28722-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1933921818364306186==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cjVziHhGDpplWqiR"
Content-Disposition: inline


--cjVziHhGDpplWqiR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 16, 2013 at 09:17:27AM +0800, Shawn Guo wrote:
> It's not always the case that clock is already available when sgtl5000
> get probed at the first time, e.g. the clock is provided by CPU DAI
> which may be probed after sgtl5000.  So let's defer the probe when
> devm_clk_get() call fails and give it chance to try later.

Meh, I went ahead and applied this but I'm not happy - there's been a
lot of problems with this code recently and this issue isn't being
discussed at the right level but there's users.  So please look into a
more general solution in the clock API.

--cjVziHhGDpplWqiR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5YjYAAoJELSic+t+oim9T/AP/3+zHAJ4RUX78W5nMypLbxC4
k/hqx5kpoxBunJreyZt37+GD/AObBTr1K0dh0To+CoBRKv+RRi0cTnnCT6qTfl/h
5tsYKzboXDyqgI/cWqU9UEzIhGtqvDvvr927/dNlaeR5Y5Ki/EDb5e0psmv1wyNG
OswDmgKbOxuaNcsdOaYt8r6VxGeel/HT2Zkq8IdRgzIXeJBZl99fbJu35Ty508oY
GrzDTrXa0720Ui1sIjOOqjP/rNM3ulCsyTibV8cLherVtq2D13RnIeaFXozX0oLP
HFxXItXuWcXKIPLE/7JCjlyfX/xokxJZ/HhldD6IS4BzXv04CjeiE6xGn5uTwBS0
xmR/oydBZaUEr2hJTk6gsYqOU3mQ22CcjSiRAMa50huwFG7glUiueiWh2EAPOoDO
x7v5+UcvlAozrG7X/K9ArXE0eHt0KBo+x4nYbDvwdTdzsEpBafreDxcbpuNVEk6T
9Eq8isW+KHhzfYuM1IarH9qQT/1wWkPgVsjjTQfOKPo0YylmEQbMpHpRWXRnlfs7
EsGmagaTpYvVkV6Sz9q7LSB2wrFKYj334KgK/sjdVY8Ym/o23L6ZArROV3LbzKsA
WSltm8f7ceMFTgxGtBI/+FVmxIFh/TlOGaKAySl71vyPlzJ5pDFVoulS8hZ5O9Dv
Hq7MNdCmag+F697hwSGL
=EX5z
-----END PGP SIGNATURE-----

--cjVziHhGDpplWqiR--

--===============1933921818364306186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1933921818364306186==--
