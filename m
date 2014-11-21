From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sirf-audio-codec: Replace w->codec
 snd_soc_dapm_to_codec(w->dapm)
Date: Fri, 21 Nov 2014 18:15:49 +0000
Message-ID: <20141121181549.GB3815@sirena.org.uk>
References: <1416515295-30851-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5355128656735795636=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E6D32606E1
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 19:17:22 +0100 (CET)
In-Reply-To: <1416515295-30851-1-git-send-email-lars@metafoo.de>
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
Cc: Rongjun Ying <rongjun.ying@csr.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5355128656735795636==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xhjcXM1aJSdKukf7"
Content-Disposition: inline


--xhjcXM1aJSdKukf7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 20, 2014 at 09:28:15PM +0100, Lars-Peter Clausen wrote:
> The codec field of the snd_soc_widget struct is eventually going to be
> removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Applied, thanks.

--xhjcXM1aJSdKukf7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUb4FVAAoJECTWi3JdVIfQwxwH/jJjF+yr0r8C11QrM2i7ujoE
ldZJWyIfJVdX+O8LpNoaXgyA3gySVpHywyNglTaONEUJW9PyPd7JGYIepnx6n0WZ
l3UtjnTPh7JYhObMAswJ0v+MEJcsTfPxKrvtuL5HixxpDNtM26hS3MQBYRYdznIA
SY90EskaIm7GO2iVMbE7+FFZsaf69k4lAk2k4tGOZ0U28jZoOeEUEGyC0EF4haQx
TqDZemaLc5YaI8FsfbYAT5JDYwrrGwvG4MbD5L55w2L0F/2huwY6fSLfaS9tx+x4
KslXN76fxLpGbS4CrlaNY8htMAvMKMdLGue0h/1w3CyV9ib9TnqhEZN0PGaex4M=
=euyj
-----END PGP SIGNATURE-----

--xhjcXM1aJSdKukf7--

--===============5355128656735795636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5355128656735795636==--
