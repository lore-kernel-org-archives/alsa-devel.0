From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mmp-pcm: config pcm slave via
 generic dmaengine
Date: Wed, 18 Dec 2013 11:03:18 +0000
Message-ID: <20131218110318.GC28455@sirena.org.uk>
References: <1387268544-31222-1-git-send-email-zhouqiao@marvell.com>
 <20131217124954.GY3185@sirena.org.uk> <52B062EC.2050605@metafoo.de>
 <52B138CE.3000800@marvell.com> <52B167F4.1080806@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4518263881101756446=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 10827261646
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 12:03:23 +0100 (CET)
In-Reply-To: <52B167F4.1080806@metafoo.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "haojian.zhuang@gmail.com" <haojian.zhuang@gmail.com>, Qiao Zhou <zhouqiao@marvell.com>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4518263881101756446==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="83Y2sXKo4f/n2njO"
Content-Disposition: inline


--83Y2sXKo4f/n2njO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 18, 2013 at 10:16:36AM +0100, Lars-Peter Clausen wrote:

> +#ifdef CONFIG_CPU_MMP2
> +	/*
> +	 * Temporary hack until we have a generic gen_pool lookup
> +	 * infrastructure.
> +	 */
> +	if (!pool)
> +		pool = sram_get_gpool("asram");
> +#endif

I worry about what this'd do on a multiplatform kernel - it seems
unlikely that someone has a pool with the same name but that sounds like
famous last words.  Nothing in mainline does though so...

--83Y2sXKo4f/n2njO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsYDzAAoJELSic+t+oim9nugQAIdqXKJXqqWGBbDNbJ6Hx66X
FvhNGRYdFp29ZhroAgeDogupeG/U7OC1SuwR6UEh8NqBRxh9Di9um+EzahLqxDPd
d1VpryFZC83JaAuT8ABTP6YGF9xm16xQPV50zSHwW3X2SeEKPC3YnQelVipwTCy3
3E+vfNTfQBtd/4lJMkQ7u8CyAoOc5bhE0buzSyow8WL/9U6RzzyTs31ten6QfwOL
kxsrBpj9gMgqZFLIdfg6925HDTtCIq0rAzQ7KOGoUG8iv54PcB4YzIAB/l8txeg/
FaBUAtwfU8zQndpf1AaA6JPwE6k6ARoZmSOdKbB1nbAS3fDPdvE5hcWYs/6R+U0/
s9LWKYam/0J6pfEeFlccYmHcsKZkVGTqPLTBWkGJLOELh50bLFaOVXJIUbQuLWcS
0vMH8vat27QTz3LRsGMVNAr6EG0sBtV4sHSPDB97zUvSVpW7XV91DDorW/S0Mjx5
LJy1dwEPOGlnONYBeRQXyIDVL96C56DTBYsfVpnkmXVQiBN71bywzzlhZjPsCa6g
Z+NP+dqEkfcjXkF19Ja9SQ7cZhutKegBX36mIy9z5WeG7qPN6g2t2qevdOM2dPSd
g0DD2gCB/4xAzoaWvoT7YTcAdgPZknuoQjL5yp3qNCutUQt9DkcWmXs+eFQAuCBO
5UVvJ8yDHVANUN8DT6aV
=14XY
-----END PGP SIGNATURE-----

--83Y2sXKo4f/n2njO--

--===============4518263881101756446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4518263881101756446==--
