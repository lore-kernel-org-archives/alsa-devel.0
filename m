From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ad193x: Keep DAC output stage active
	in idle
Date: Wed, 5 Nov 2014 16:33:29 +0000
Message-ID: <20141105163329.GD8509@sirena.org.uk>
References: <1415204393-30970-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8617267523199939776=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E8B012650CA
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 17:33:43 +0100 (CET)
In-Reply-To: <1415204393-30970-1-git-send-email-lars@metafoo.de>
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


--===============8617267523199939776==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 05, 2014 at 05:19:53PM +0100, Lars-Peter Clausen wrote:
> Setting the DAC power-down bit for the ad193x will also disable the DAC
> output amplifier. This will cause audible clicks and pops when starting or
> stopping playback. To prevent this a new widget is introduced that controls

Applied, thanks.

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWlFYAAoJECTWi3JdVIfQKOwH/RUbwLUqx2mW0PGQqByO/Uxq
xC0ArOMK9YtczhG+9TzKYjO+yrFTUX77RArZgdVVZCVT1gaEtkECqZSqb41ViRMe
by3q/xFWdtRErFQq9XTN5W0zLBz7kay2+oS0qRPvhHuORiDzePLslwlOmmz4qcYU
gGvZ2h02Ly4wYtycYhoH7wjSAdxX/yuZ4I3Qs6VQCJcRPXztw2xoRucgCbc0uwFd
OHrwVaS1PHwvBNlBzN9owx4+9tqUv9cfgas1zPBVqpCWaIzfSRKK/6EbzkzZhLJC
Pv+fUxTx2AAFJO360G0lP4lTEPQgZJlJasfaZQYp0nm15mp4pOkk68QEYCuYVoc=
=cNOI
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--

--===============8617267523199939776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8617267523199939776==--
