From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 09/12] ASoC: s6105-ipcam: Convert to
 table based DAPM setup
Date: Thu, 13 Mar 2014 11:43:45 +0000
Message-ID: <20140313114345.GP366@sirena.org.uk>
References: <1394634460-15889-1-git-send-email-lars@metafoo.de>
 <1394634460-15889-10-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4071320527428415352=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D970026519B
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 12:44:03 +0100 (CET)
In-Reply-To: <1394634460-15889-10-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Ryan Mallon <rmallon@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Daniel =?iso-8859-1?Q?Gl=F6ckner?= <daniel-gl@gmx.net>, Benoit Cousson <bcousson@baylibre.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============4071320527428415352==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h9WqFG8zn/Mwlkpe"
Content-Disposition: inline


--h9WqFG8zn/Mwlkpe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2014 at 03:27:37PM +0100, Lars-Peter Clausen wrote:
> Use table based setup to register the DAPM widgets and routes. This on one hand
> makes the code a bit shorter and cleaner and on the other hand the board level
> DAPM elements get registered in the card's DAPM context rather than in the
> CODEC's DAPM context.

Applied, thanks.

--h9WqFG8zn/Mwlkpe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIZnuAAoJELSic+t+oim9zscQAJe8zYZ/+RJ737ezXSsaxkmG
kkfXzE3tugebhzLk/HtqBH3GC0x96OXgUXHFBY0Nlf7ZD4xXYTI6wlRgIqtjZMQY
hrH0Fu2Pm3UCJfdT2FW3k/QXF9h49Yf3AVlrRsIps/6ZUCZtXiQ0mGdvYKWM+8D2
mT1UZSOXTk7F/rDTvWZmWYuAFI3UMF5vGR9rpDsc3JsafOuWMXbCmKu/zBbSCSLE
Hqb54oiK375E6Ze45Z5+uXfN9n/gBnuTP0L3Z8mVBGiVfWiZyFuTqIoUeS9RQhYb
J4KPjJMQmYifBCk7IGk/nEgXgcfkJ/FItYwqaE/eORmI7liz3dcZW0GRHlx0ZjQR
9+HHV0z41q6L+B82OdIZxnIdllK/JZ09obNHZmmv9wQBl/lPOjlVwHYNel4XcYGG
GWssS2aI2CDUTp3I8gou8j9NWO6yT8vCzoBOubWI7+rkAYVIrX12DJPWAeevhi1a
xUgM4aZse62yHH0ph9s6y2QGyYzYmkOheVwT+xvAdhzpF4mw5SKLy7zmnh2O8/mP
1jTygviU7cqSM6bB2UiPlaadG3hAxikkzEzSNRGX1XKRSvqkQG2butfmajvZkcOT
A5yADzyfaQs0TnTseC1oaZM8JTJeBgcrCI5BFc9dYYg7qxKrWcfhX7bUMA61Ulfj
L/zKkOdE9BGnMcP9/ALu
=/hDA
-----END PGP SIGNATURE-----

--h9WqFG8zn/Mwlkpe--

--===============4071320527428415352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4071320527428415352==--
