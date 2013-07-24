From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 23/27] sound/soc/nuc900: don't check resource with
 devm_ioremap_resource
Date: Wed, 24 Jul 2013 15:34:35 +0100
Message-ID: <20130724143435.GF9858@sirena.org.uk>
References: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
 <1374602524-3398-24-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BT3sS6uW76RUUBOi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1374602524-3398-24-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--BT3sS6uW76RUUBOi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2013 at 08:01:56PM +0200, Wolfram Sang wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.

Applied, thanks.

--BT3sS6uW76RUUBOi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7+X3AAoJELSic+t+oim9F2kQAJCivINSpxF7xcpC2x+QzNCE
bNZuquFX6BKyvgIVV6XQBTHlFf8c/u1o3fMElzlRp4jR0D30y/Wk5c9LCWezkJts
doWWw45cfoHCuHE2lyC7qpk4u8WxKnFrz6xJMVAxia8uciB0KIR+AeCfz+6RWKU2
JDhtw++6bRxxu2cMDGHz/PGrx2JfMPHNH2Z7aUezfjKGJY4wv8DNNCMFwu3Ntuos
voYo9bbcWkgcBgk1HupPjerCQnmywrud2vKGuH8R2Oj7+2mnTt0q17eZ8lfK7ywS
RykEaTM6OMfEoW6Q1Y2uI+X31c4iig/6NMCssEZdXD6HY+N6+qiTKHSPmTIQl0bC
ad7t8zbRuDnGdvblzrzRiev6cH0ZcHz5SVnubbAeL2lELGgYNdvUGwrancnYv+NI
+2pFZsSEq6+EmzPvYGCbJ1ZsEfz/J7Bs2ZxxVKAQ6rKvzR3DCkYjfT9N67emHNjh
ps1jfGBKDvS5JvpOnsM8AMN/PwRVR7U7lLW5Z33N87uipb+IgX4Gok9r84H8hPXJ
kXE4AnBjquRvwob/nqzYB6R75+BbXqWBw9bcNkkDHSGB7t89jvWGPnmOjLYh0/dc
wl3pwWiZRPjGmtEsRpuRHhzjEGK2BlajwpLvNZFdu6EGDElKWMvfR0iUjnFhB9J7
cn2TLY7p0UCJTakH2bwv
=ktLY
-----END PGP SIGNATURE-----

--BT3sS6uW76RUUBOi--
