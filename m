From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1] ASoC: bcm2835: Remove redundant channel
 checking code in hw_params
Date: Wed, 1 Feb 2017 10:53:29 +0000
Message-ID: <20170201105329.vr4ro5bjf676dwtk@sirena.org.uk>
References: <1484443043-13623-1-git-send-email-flatmax@flatmax.org>
 <1485924303-30869-1-git-send-email-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4877190558367099137=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BB9A26742C
 for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2017 11:53:45 +0100 (CET)
In-Reply-To: <1485924303-30869-1-git-send-email-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, phil@raspberrypi.org, Eric Anholt <eric@anholt.net>, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4877190558367099137==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="otkxwz2qsorplw4n"
Content-Disposition: inline


--otkxwz2qsorplw4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 01, 2017 at 03:45:03PM +1100, Matt Flax wrote:

> This redundant channel count check may seem like it will not cause
> any problems however some sound cards (such as the 8 channel
> AudioInjector Octo sound card) require the execution of the
> bcm2835_i2s_hw_params function when channels_max in the
> bcm2835_i2s_dai structure has been increased to 8.

> As the channel checking code in bcm2835_i2s_hw_params is redundant
> and stops certain cards from working it has been removed.

If those cards add support for higher channel counts they should be
adding real support for that in the driver, not just hacking out
defensive code.  If the device can usefully do 8 channels then modify
the driver to do 8 channels.  Otherwise people are going to need to
modify the driver anyway to remove the limits in the constraints.

--otkxwz2qsorplw4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliRvigACgkQJNaLcl1U
h9Bg3wf/VEvJivZnOjG4AarK1C4d2C6b5M4Ai+WrAf658LCkl+lJn1RYbprttnji
XUouruUqP+/JOxlZaBE+GOMviOdOueWTwniJPuOttO4PBCqU0yGGdnY8Cu+8Ep6E
CVj60pc8NTgwJtaPMuhLaUpgI8rANrJqTcmJfyOnanGKyhv5XeRL5f0O8h4H0Rzk
hoFaFhcYa0Y86Am7drYGdgWc4r2ttfUjEKuJ2z04zneXcHLVjAJwlAUn3KyJw+gX
U5775aZqr77oTjdft2ZSxnIVUVf3+cocaGI+SU80NFhQjMQy/bba2ba+gm2NZfau
Ys7LHwR8YWIpGgyCx2Bx4WhYof3UFw==
=ykIV
-----END PGP SIGNATURE-----

--otkxwz2qsorplw4n--

--===============4877190558367099137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4877190558367099137==--
