From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/7] ASoC: wm5100: remove bitwise
 operations involving GPIO level value
Date: Wed, 3 Jun 2015 12:07:45 +0100
Message-ID: <20150603110745.GD14071@sirena.org.uk>
References: <1433200031-6748-1-git-send-email-vz@mleia.com>
 <1433200158-6890-5-git-send-email-vz@mleia.com>
 <20150602194558.GI14071@sirena.org.uk> <556E10CD.3090301@mleia.com>
 <CA+7tXijtaM4tn3Mb+tbsd7JFbGjeh1yT=zTXPuCiFjqnvRjdvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6476004227448763709=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A287F26058B
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 13:07:54 +0200 (CEST)
In-Reply-To: <CA+7tXijtaM4tn3Mb+tbsd7JFbGjeh1yT=zTXPuCiFjqnvRjdvg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <tpiepho@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, Takashi Iwai <tiwai@suse.de>, Linus Walleij <linus.walleij@linaro.org>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, linux-gpio@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============6476004227448763709==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wdXZ0KDsOFX3OpPb"
Content-Disposition: inline


--wdXZ0KDsOFX3OpPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 03, 2015 at 03:50:04AM -0700, Trent Piepho wrote:

> BTW, with a little C algebra:
> const unsigned int val = value ?  0x1 << WM5100_GP1_LVL_SHIFT : 0;
> const unsigned int val = (value ?  0x1 : 0) << WM5100_GP1_LVL_SHIFT;
> const unsigned int val = (!!value) << WM5100_GP1_LVL_SHIFT;  // definition
> of ! operator

> And now we're back to where we started, so I don't really see why this is
> even necessary.  The semantics of the ! operator will be changed in a
> future C version?

Yes, this is exactly the point I was trying to make.

--wdXZ0KDsOFX3OpPb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbuABAAoJECTWi3JdVIfQM1AH/jiL0eUhUFiG9mjfom5Uqmhp
UiuGeTTKrFDyV+6yePiU0Naifk2Es8lSj6BKY3ibs0E/JctbHaqNR42g7tZ9IhGf
cPYqfY3OnFUbgkFc+YVV2t+JioNPlzHeRePSIUhkQcFlwyAWUg+w7OgIQ6c2qYeO
GD6uMWzt4VRlYzqoqZ39hDKtRuEDOQmAM5mpyRMCTR7PJw9GBWuMpWdQzEXnfHsA
SAbFJkp3DO/417R+ZdUs8Ovv5IDZZsbjPNgm01X0qB5fVF13E/c1dIrGY/Kv6KRS
yqz//55K3UF2yggmV+dJADYmCOXHxbXMBzkgS7NOb7Iz2k7HfeIFIg3Zru9Pdag=
=XJf4
-----END PGP SIGNATURE-----

--wdXZ0KDsOFX3OpPb--

--===============6476004227448763709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6476004227448763709==--
