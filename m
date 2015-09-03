From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/12] ASoC: Fix module autoload for OF platform drivers
Date: Thu, 3 Sep 2015 13:56:45 +0100
Message-ID: <20150903125645.GB12027@sirena.org.uk>
References: <20150903105427.GA16658@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aBfuQK/t93Uihhfq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150903105427.GA16658@goodgumbo.baconseed.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Javier Martinez Canillas <javier@osg.samsung.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org


--aBfuQK/t93Uihhfq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 03, 2015 at 12:54:27PM +0200, Luis de Bethencourt wrote:

> This series adds the missing MODULE_DEVICE_TABLE() for OF to eport
> that information so modules have the correct aliases built-in and
> autoloading works correctly.

Please thread patch serieses together when submitting them (git
send-email can do this for you).  This makes things easier to follow.

--aBfuQK/t93Uihhfq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV6EOMAAoJECTWi3JdVIfQfUwH/AzmYW9IfpmhFRz4tFk97R+H
KJBisae8nwcGgcwhq/pkZm+fdfTgojomLK4cyUMEVvLh75h4Yibzd/BDIBItN+DM
qm8NR6qfGHsJX0Kj3NDL2vt8oRCPask5YXQMjHcnuN4YtHVKC+Kq6UCMyqNeNcVq
2+gXZvNoE89e528j4NfpN641Mzao7kERvq/aPilcR02miTTsosAsA0j8Y3f/2oVA
n+G93f3QjONRPhvs1G+AN+jXp81d8hhRm98v5bmdXaLxD8CpYBVPFTYVlfBMSdot
hY1vx4sh+a2l6jq/aD8KkN163nsHIlzH4Z6N0ZZSd2VDJWwtmk6Tj4wSGHuWUsk=
=eCNC
-----END PGP SIGNATURE-----

--aBfuQK/t93Uihhfq--
