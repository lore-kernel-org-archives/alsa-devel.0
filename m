From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: cleanup
 asoc_simple_card_parse_of() code
Date: Mon, 30 Dec 2013 12:11:13 +0000
Message-ID: <20131230121113.GQ31886@sirena.org.uk>
References: <1388114078-24517-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2861136680174085355=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C9201261687
 for <alsa-devel@alsa-project.org>; Mon, 30 Dec 2013 13:11:21 +0100 (CET)
In-Reply-To: <1388114078-24517-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============2861136680174085355==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7kZSb73GAX5WIGXJ"
Content-Disposition: inline


--7kZSb73GAX5WIGXJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 27, 2013 at 11:14:38AM +0800, Xiubo Li wrote:
> Since there is only one common format via "simple-audio-card,format"
> for simple card driver(CPU & CODEC DAI), there is no need to do the
> INV mask.

I don't understand this change, how is the fact that the CPU and CODEC
DAI share a common format related to using the inversion?  The inversion
specifies the format relative to the spec rather than relative to the
other end of the link and for any DAI link the two devices should be
using the same format.

--7kZSb73GAX5WIGXJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwWLeAAoJELSic+t+oim9WKIP/1XtQFsll2slTSVJhHOZlfGX
mXuVyqQHcrWbG76GLL0sMorItGaqW/SWHY37hFJv5HZ8t4yOq9dYrmJplypFuN8V
/ebUDhg1WpHCXudIaiGxA2BeikoykUZLn60s2+tNidqdRzzd/Mny6zjMWtS4yy6d
SlREyzTml00FeNboab7dlOaT7Vs3q1uikCLZCp/GExiAkzWDqhgJcROI+TlM59MB
dFI4A00WcaDhWSebE0zG1896NPKkqiFIJ/YUJVbdO4HATB+YY4sO/LPz2CTOfU0K
EI5VPRyCOC0XkoAZ94Teqd0yyIkBe2y99iGGHnhFUWMvSZO3ylcN/GP23MkLisAn
xauIxI+vjTQaIX87KDy/5LLywiBMaOabt/6+yqeTqF089r0FmCPz+ZUmXt2ADHgw
qPpusu9mIdKaFQzyjjPrn1KPa+C74H325/eSbD9PXB03NgyY8Bhizu5vM9VH8j0l
Lp8q2qMrzpLasnksx+mDQ38InX47YE8ojgh32bC4wsNQZn+2DtCiFtNZLkcxYU3b
7oy8DEb8La3jtPHJXO60Fe0XcHiTPJGRhi+jtSlbROoPJqIiWyQCKT7VfTSaIMDk
Q0E8enRblptjV5GVQq0cql1ofdAu84HiOGxtI8J/GcNqDa6C6sSTTdjihBn06WRk
MvuZMjD4wFvVLICNOVV1
=OZB0
-----END PGP SIGNATURE-----

--7kZSb73GAX5WIGXJ--

--===============2861136680174085355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2861136680174085355==--
