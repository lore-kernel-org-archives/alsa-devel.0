From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/21] ASoC: Use static DAI format setup
Date: Tue, 6 Jan 2015 17:34:17 +0000
Message-ID: <20150106173417.GG2634@sirena.org.uk>
References: <1420128990-6872-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0692402500198421788=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DD782604D1
 for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2015 18:35:02 +0100 (CET)
In-Reply-To: <1420128990-6872-1-git-send-email-lars@metafoo.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Denis Carikli <denis@eukrea.com>, Manuel Lauss <manuel.lauss@googlemail.com>, Bo Shen <voice.shen@atmel.com>, Shawn Guo <shawn.guo@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org


--===============0692402500198421788==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C6GqtNjDdnDsBy9k"
Content-Disposition: inline


--C6GqtNjDdnDsBy9k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 01, 2015 at 05:16:09PM +0100, Lars-Peter Clausen wrote:
> There is still a rather large amount of board driver which manually call
> snd_soc_dai_set_fmt() for both the CPU and the CODEC DAI, while pretty much
> all of them can use static DAI setup by setting the dai_fmt field in the
> snd_soc_dai_link struct.

Applied all, thanks.

--C6GqtNjDdnDsBy9k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrByYAAoJECTWi3JdVIfQvS8H/RwJ+PL3fn7ykFMJ3ssAaZ7g
9YNufBDqnCIDgSFp0CdG/YtMghCQhTa9E0DNUzGx5erI5VWEiD1pOIwop/tcF5CR
8gzjsES/zcW88/Regg++sG/0XZB/4zhQRBcNVyJPLYOyw96IVejRcbFGwS7yugAH
MaQie/8Tm7ikcxUdEYcTnWEBfPnzzfg2R9roPH7Jhqx6avRafSmNdCEUM7cu6kO3
E3EZ6phdneq1B5FfwFmF+2a/oQI/0q3MOn0YNYJBpmf3xqqXc1SHnRNAnw6wE951
MNffuNs+Umk9uq46N7D/fcxbj2j9bkdW7zLbaafw8d65UlBecSXVWtWdH7pZivI=
=917t
-----END PGP SIGNATURE-----

--C6GqtNjDdnDsBy9k--

--===============0692402500198421788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0692402500198421788==--
