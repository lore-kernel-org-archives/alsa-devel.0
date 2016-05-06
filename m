From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 1/7] ASoC: mediatek: Refine mt8173 driver
 and change config option
Date: Fri, 6 May 2016 13:20:46 +0100
Message-ID: <20160506122046.GR6292@sirena.org.uk>
References: <1461934848-60011-1-git-send-email-garlic.tseng@mediatek.com>
 <1461934848-60011-2-git-send-email-garlic.tseng@mediatek.com>
 <20160504164306.GA6292@sirena.org.uk>
 <1462416342.25179.36.camel@mtksdaap41>
 <572B0511.80701@gmail.com>
 <1462444772.2873.70.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/0GU/Wxy4LypDMTk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462444772.2873.70.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Garlic Tseng <garlic.tseng@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, alsa-devel@alsa-project.org, ir.lian@mediatek.com, srv_heupstream@mediatek.com, tiwai@suse.de, linux-kernel@vger.kernel.org, koro.chen@mediatek.com, linux-mediatek@lists.infradead.org, PC.Liao@mediatek.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--/0GU/Wxy4LypDMTk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 05, 2016 at 06:39:32PM +0800, Garlic Tseng wrote:

> As mentioned above, the difference of the ASoCs between the two chips
> are too large that we have a hard time sharing the driver code.

The things you're describing all sound like scaling differences rather
than fundamental changes.  I'd expect to see at least some shared code
here, we don't want to be just duplicating the entire driver every time
there's a new hardware revision.

--/0GU/Wxy4LypDMTk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXLIwcAAoJECTWi3JdVIfQMu8IAIWLYIjk7MMsu6q4yme+od+V
cOG+qP9nLpPtkS1FyzU7VUpKja6d8Cq7PlhBJBaxbMGFaLP0f/SOca/j1KhrFbdt
mqeCiCvx4ryU/GwBDvdoTrwLJF7vymbhwi3aYtd1+1ryXtySecPg9+soOwQvyxFd
8886WwbO+YHAslydsewJJr9DcE/bGUcgyB2DCZITjdrzT+BjAzmgjCdB6+4W5f6Y
cqGVtgKudyk7GITjq9r/Ml9yHKmOwtICg8B5mjtaHikXBjton77DHleD2MZtxeSR
51DWjPeBi9Ip0C1e6g9NqxErVnDuoORX3e82a66//+ft7pi7aXUslkU24LH9IiA=
=esEW
-----END PGP SIGNATURE-----

--/0GU/Wxy4LypDMTk--
