From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/4] ASoC: davinci-mcasp: Provide
 correct filter_data for dmaengine for non-DT boot
Date: Mon, 17 Mar 2014 16:21:47 +0000
Message-ID: <20140317162147.GN11706@sirena.org.uk>
References: <1394808168-32608-1-git-send-email-peter.ujfalusi@ti.com>
 <1394808168-32608-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5380420615886348115=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BCEE261A0A
 for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2014 17:21:56 +0100 (CET)
In-Reply-To: <1394808168-32608-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5380420615886348115==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rzq/nSLlHy1djmXS"
Content-Disposition: inline


--Rzq/nSLlHy1djmXS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 14, 2014 at 04:42:46PM +0200, Peter Ujfalusi wrote:
> When we boot with non-DT mode the damengine will need the channel number and
> a filter function in order to get the channel.
> The filter_data is filled in the DAI driver while the filter_function will
> be provided by the edma-pcm driver.

Applied, thanks.

--Rzq/nSLlHy1djmXS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTJyEYAAoJELSic+t+oim9xpoQAIvjQHpLveSMuIhCFOSaJcsp
6Y0GX8VQWyUmPFdVc7gcRHKrqVW+9RJMh+w8aO/6dOlSquci1iI+08WCoc8EjwUX
/aqMdV0/arGuAcJSvhZm4bUX/VhoiyGdTy7wc6GCLOfCl9ZtsbxD/nSq8yg9z95L
vWTawI5MOi8hZNA0j7vAv4w49HohiqyfbLwyJgEceiuUa6OqP9wysRhH3tnEmmXm
x8jW/WeEr/fq74IlbYGMR6ad0WfeqNx4KCkyv7Kb2Ch1JH4JiopeJCSPHr6Da14d
7slPQWQJIGf3tcq2PMGu+8EIFDSkpJWkQomaUf9OIpp3LjHhGdqYqXRBej2Yhu/F
BqpwMgbigFOeVqJ5pbeHaRMgOhty+R9f1rp7rlCuO7qwSxsWp/lgh+cJK6OeCiov
RUBI7f2YJgQBb9ThKx4mXdIxzCo5fXoUypQtbbqJVKn8c4Mc71iryV21ADwUGlEF
+eQzY5Xw19wFr6raHrsAOFpnwi5gVDwKRb+2urI09L7PTKyO34kzIh5cNL37oHXb
lVujdHUdScd849q6Jt16PR+V9klUTwybMjuxNZL9LM8dy+YotKE/1OKFzAx9OGZb
fu9akcOAH4NEEjLgMHKoEe4pijXmBXTusdzsijnY/vSU+K9ZAHIaceD+NGwKWMZv
uJBOP5JffwIgx2FSNw2j
=Ncmu
-----END PGP SIGNATURE-----

--Rzq/nSLlHy1djmXS--

--===============5380420615886348115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5380420615886348115==--
