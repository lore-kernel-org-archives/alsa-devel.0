From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/4] More componentization preparation
Date: Tue, 22 Jul 2014 23:14:53 +0100
Message-ID: <20140722221453.GU17528@sirena.org.uk>
References: <1405627268-23939-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8246270712927155941=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D6077265176
 for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2014 00:15:19 +0200 (CEST)
In-Reply-To: <1405627268-23939-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org


--===============8246270712927155941==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ltihE5wS63FR6l1A"
Content-Disposition: inline


--ltihE5wS63FR6l1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 17, 2014 at 10:01:04PM +0200, Lars-Peter Clausen wrote:
> Now that the multi-CODEC patches have been merged we can continue with the
> componentization. Since it is already rather late in the development cycle again
> this series only has a small set of cleanup and preparation patches so we have
> that out of the way. The first patch removes the unused snd_soc_card
> platform_list, the other three patches move the card field from the
> snd_soc_platform and snd_soc_codec struct and consolidates the registration of
> controls on top of that.

Applied all, thanks.

--ltihE5wS63FR6l1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTzuJUAAoJELSic+t+oim9q+MP/jqa+b6TRuNupwp+dnoIE8vl
oOtD3Z5T1TkwTRXjYPVu6BKDjA2aas4H/7z6wn4qu+WTD11BLKr1VyRZUSUurw49
Izt5DpybW0vanSEvyGbrOfiJBAJIZFT4uMNXLT1hXJs1ewPTCqN5wdE8HYUv8TNh
avmf7VNeGlcAkgiz2cqKRVU5sem2ikF6dI2/l7fE1TnM/SqTXawBQ2ciTGVDmPEt
7Y+LdeVt2h2FzKm8MGSM0lOLPyR6YXMy6OqdlPPvPRfGHvjlV/uoT071r2ptFfqN
Psi7kbF6H4XoQ+gxXgVhrpuCI6zFO9fA1h+Pbvyq6KP8VM0pCbx5dH6oGvc0qEeH
bQIFvZBrvUsslFbOYY8P5uRMCAZ6xhaKE7tj32j+yrdWoNpNMHxBGZALh+1RYH06
TUCxnhzcax65gs6U3hVA3zOBZ9R8ATlMnwpL2a145kLi0PXtDJ5TKkRo1dNJs9lh
URuq1s/WUVCaKCThPlnh+QncQ4zdEpyi1FDZ/ay3Mi0H04QaDjpc+ESI3gXfU6on
6Q8as4f5xuNt/j9xgjPw2zYX9AUuxvESnrJtP9+uSo9DlcwtMVohAfYXzUZVdt2Z
0lRP0uDpq/eh4QpBz1U/meBZ+uKLxl2520wIObirroRdTKiu712iBCCaDAc3zgTo
4+TTccMNTw9sdY+BAo35
=6K9C
-----END PGP SIGNATURE-----

--ltihE5wS63FR6l1A--

--===============8246270712927155941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8246270712927155941==--
