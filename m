From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: cs42l73: Replace w->codec
 snd_soc_dapm_to_codec(w->dapm)
Date: Fri, 21 Nov 2014 18:21:25 +0000
Message-ID: <20141121182125.GI3815@sirena.org.uk>
References: <1416513940-28717-1-git-send-email-lars@metafoo.de>
 <1416513940-28717-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0301725147287664994=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CAC242606E0
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 19:23:06 +0100 (CET)
In-Reply-To: <1416513940-28717-2-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============0301725147287664994==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qe+viS1ZI30ztcs5"
Content-Disposition: inline


--qe+viS1ZI30ztcs5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 20, 2014 at 09:05:39PM +0100, Lars-Peter Clausen wrote:
> The codec field of the snd_soc_widget struct is eventually going to be
> removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Applied, thanks.

--qe+viS1ZI30ztcs5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUb4KkAAoJECTWi3JdVIfQRBgH/jnMa3/rAh064ucZCO2hekqz
tgy32cv/rCSAsw3DPmr9+MGxqdBs8kpwbLRv2k1Hv8uQNdKL7jOOoLEGmBkgjrtR
30VZcgTqUhhPAkhnXaZmHej5cm3c29UgQENbH6d4BGrD1rwU8sgeH4F5f2v9pbOI
s9NkVi1ieOhY4rtofVcwUV0Olwmf1IhEfFkID+cl3MJb3/x6AkPlqmO/+3CO6MEk
7Ld/q9tvV7LysNWTh+QgzSTc0GdFL/t4AxsWUve5HkI9QnVP+oX2qT8yLOETCVrn
zaRmkvNi9ncZDTvjS1HQEpz+98LcsgMXr/tVGenIEbbDJD8ZnpTl6m+t84fHBkU=
=oLX1
-----END PGP SIGNATURE-----

--qe+viS1ZI30ztcs5--

--===============0301725147287664994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0301725147287664994==--
