From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Use SND_SOC_DAPM_INIT_REG_VAL in
 SND_SOC_DAPM_MUX
Date: Fri, 22 Nov 2013 19:48:05 +0000
Message-ID: <20131122194805.GR14725@sirena.org.uk>
References: <1385141358-21956-1-git-send-email-swarren@wwwdotorg.org>
 <20131122183216.GP14725@sirena.org.uk>
 <528FA3DD.8030507@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZaW/dtY/7oMe/vLp"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <528FA3DD.8030507@wwwdotorg.org>
Sender: stable-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, ac100@lists.launchpad.net, Stephen Warren <swarren@nvidia.com>, stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--ZaW/dtY/7oMe/vLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 22, 2013 at 11:35:09AM -0700, Stephen Warren wrote:

> I think it's not the mux values/routing that matter, but the mux power
> gating.

Ah, that mask - yes, none of the devices I've been testing with have
power control for their muxes.

--ZaW/dtY/7oMe/vLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSj7TyAAoJELSic+t+oim9Vk4QAIxHBixVKeJOurcHhbXcudUA
9meXVmC0WwMZ4QcATHFS4z3A5Lorqiy59RxTSbc1fTiFUvAd5g0GqTNbsisKJNkL
tVwV2RHrDujqOAUB7eBJPZ0aCwO9EoBs5A45Q0Tk7svqZDI8PM7V91ogOGziHlko
RAVvLIGer5uqR0DBQIW8gXG7rDA1N3Q34LcxqVBQ+/7UnTMsgnt3X7iyB+S2Lu1C
bEdgtC9KKNZKkQO4K9HQowlMGRwXvd+1H5Qrid6b8vIKKUe9JyxLMVBYPTwT5GJj
vXTMpAXVR7Yfuj3VArCo7SfOpiAOn+F7jVbW7HMbje54KagG8dEVAYJcuo08LqhN
4h0YcL9NSTmZcJRtvn1B5bEECCmL73iz09kjVkuCyA4CqUnNKmiKcgtt/PuEABQi
Fa/fC6aA10XNex5ojUD1YMAO88vK2IJHOKQvjnu5aVewEMmTVonRrZoEljJxQWFN
wYy/GYmbCpGlAgATyfyB9t2WVI2b4CxaO7RSdQnAIoia4jO1eCAn0pS71QWxViiG
ZUQ2y3W3tx/oea2VX6M4bNuzy+2yOkpooP1GBDlqiSN7DRvxTjHWgyzS0rbnIp55
pgrb1LqsXfYr5VjMuO23YIcnd0zuQe6gRFrCBpi522jj4BVImQVbTiPWLEmqfOWU
4/KnvS/DHtKLdiMIm91n
=6clV
-----END PGP SIGNATURE-----

--ZaW/dtY/7oMe/vLp--
