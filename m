From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: adau1373: Replace w->codec with
 snd_soc_dapm_to_codec(w->dapm)
Date: Mon, 17 Nov 2014 10:27:20 +0000
Message-ID: <20141117102720.GR2722@sirena.org.uk>
References: <1416213456-5987-1-git-send-email-lars@metafoo.de>
 <1416213456-5987-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4495842799849290365=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 26C8D261643
 for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2014 11:28:43 +0100 (CET)
In-Reply-To: <1416213456-5987-2-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4495842799849290365==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="phbq2bkSb+hZnunM"
Content-Disposition: inline


--phbq2bkSb+hZnunM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 17, 2014 at 09:37:35AM +0100, Lars-Peter Clausen wrote:
> The codec field of the snd_soc_widget struct is eventually going to be
> removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Applied, thanks.

--phbq2bkSb+hZnunM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUac2HAAoJECTWi3JdVIfQeDwH/0WqWwAtXxfk3UDCDI1Wqnrs
/RoTOMGNz9hYnVJ031ODp6XUiio2rOr3jlywvS+MpOz8rVbeTnEQH6rxUqt89hxu
gGOxcUDiLul8VuiDo3AYDo8CbgF3rnnIS6FBS1/YxpcNb9ntqawLkxqPQCmoVkXv
ddoJ2vR2EN9m6JFP/QMGlLcL+XKSgoa7S9bga3j9q3c6H/Cqi1zk8JzpH5hPxurF
78sn9qMHbzz2AI+laVJoMTIX3xZ0JTanH8DGrcVSdRkupcZ3xr85ipEb0cl/oPcO
e8fXW25kY3Zz1G8c+itrwCJm78Uc49DvdjjFYp0icwJA/0lHJgDsqPpmVLTJ5TU=
=MJ84
-----END PGP SIGNATURE-----

--phbq2bkSb+hZnunM--

--===============4495842799849290365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4495842799849290365==--
