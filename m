From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: codecs: add const to
 snd_soc_codec_driver structures
Date: Thu, 10 Aug 2017 16:20:10 +0100
Message-ID: <20170810152010.hl2ea5tuyo7mhndf@sirena.org.uk>
References: <1501776020-3328-1-git-send-email-bhumirks@gmail.com>
 <1501776020-3328-2-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8822236745526332796=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 93A602665D5
 for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2017 17:20:37 +0200 (CEST)
In-Reply-To: <1501776020-3328-2-git-send-email-bhumirks@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, lars@metafoo.de, support.opensource@diasemi.com, linux-kernel@vger.kernel.org, tiwai@suse.com, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, peter.ujfalusi@ti.com, julia.lawall@lip6.fr, wens@csie.org, vishwas.a.deshpande@ti.com, mr.swami.reddy@ti.com, patches@opensource.cirrus.com, bardliao@realtek.com, maxime.ripard@free-electrons.com, peda@axentia.se, linux-arm-kernel@lists.infradead.org, baohua@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============8822236745526332796==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gkwa6ppgu6dmm3er"
Content-Disposition: inline


--gkwa6ppgu6dmm3er
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 03, 2017 at 09:30:19PM +0530, Bhumika Goyal wrote:

>  sound/soc/codecs/88pm860x-codec.c      | 2 +-
>  sound/soc/codecs/ab8500-codec.c        | 2 +-
>  sound/soc/codecs/ac97.c                | 2 +-
>  sound/soc/codecs/ad1836.c              | 2 +-
>  sound/soc/codecs/ad193x.c              | 2 +-
>  sound/soc/codecs/ad1980.c              | 2 +-
>  sound/soc/codecs/ad73311.c             | 2 +-
>  sound/soc/codecs/adau1373.c            | 2 +-
>  sound/soc/codecs/adau1701.c            | 2 +-

This is difficult to apply against current code as it is a single commit
over lots of files but the ASoC tree has lots of branches.  I've figured
out the dependencies but it's easier to split things up (and avoids
collisions with other changes causing the whole thing to not apply).

--gkwa6ppgu6dmm3er
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmMeakACgkQJNaLcl1U
h9Alnwf+ISX733BOQGC2aQomRhNC7F7J2dHAuDey7CSP4RmhFTG9W8kUt3ObAsWo
/iPCcxg+AmHCGTP/CJWUXTOvtLNSOjWT08eIdVTXfO64SFhIugLMf0xXMAjvMFs/
q1JE6ztW0zglVMn+ARI860Inm1nPFIMLTVHlxJf3++J+hNqvge5zghruCG99SDtV
ml4YakXx/eMNX8ZWxBjVPdWSyqjV/C/EkCKRVSlqSgAvh+EIldlp1EI+il4dYKLH
iyx8x5KKInUfH4zY642VMubhKLS5RlFE/OSYmXZCAWa3jz/0fuOCSbo9etxBjZ+b
zym6UbVCoX2utY5SGe8kAXhVIVf4dg==
=cqXG
-----END PGP SIGNATURE-----

--gkwa6ppgu6dmm3er--

--===============8822236745526332796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8822236745526332796==--
