From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: disable soft volume control
Date: Tue, 5 Jul 2016 10:34:22 +0200
Message-ID: <20160705083422.GN6247@sirena.org.uk>
References: <1467696235-31566-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4177001868599591359=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 642C626061B
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 10:34:48 +0200 (CEST)
In-Reply-To: <1467696235-31566-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, koro.chen@mediatek.com, PC.Liao@mediatek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4177001868599591359==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YVi6Gft925wFjdem"
Content-Disposition: inline


--YVi6Gft925wFjdem
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 05, 2016 at 01:23:55PM +0800, Bard Liao wrote:
> With soft volume control function, rt5645/rt5650 will start with 0dB
> volume and take a little time to adjust volume to given value. And it
> will cause a bad user experience. This patch disable it.

This seems like something that it'd be better to give users control over
- some users will be annoyed by a soft ramp but there will be others who
welcome it.

--YVi6Gft925wFjdem
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXe3ENAAoJECTWi3JdVIfQicoH/RHYQ9+yFLvFoZhPM+fZsXnn
eEXxCj53PVKXp2+i91wQjXSkpVcSX7x4VBNI9qzZzoy0BViqvxAwIDoDZ/Vt6CdY
moel+b5o0cLMdIp4N6F9I3nU+L/GvqdyfkulO5vAwgvYvrvRfAgyHU9gQesViu39
iP9jEcHnEK6YFFgYQL+2TnjK9D7ubAPAxKPn2dTaVkRto2CTj//rX/06r69ZH5fD
n4zik0LHsnAbhgpktaqZqUwKubpntq5EZptoH+FCq/YFAn5FkcqYDzzSu2/hyN/e
GuSkXgD53H4PgmPD4WeX+YnJo63AN66mep30/oJZVDPmz2q8IB9v2Wx2TRHX7Tw=
=s3dr
-----END PGP SIGNATURE-----

--YVi6Gft925wFjdem--

--===============4177001868599591359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4177001868599591359==--
