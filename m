From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: skip legacy dai naming if dai driver has all the
 information
Date: Thu, 21 May 2015 22:22:22 +0100
Message-ID: <20150521212222.GQ21577@sirena.org.uk>
References: <1431682707-26452-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HlZi+g8Ywt2nzGP6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431682707-26452-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--HlZi+g8Ywt2nzGP6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2015 at 10:38:27AM +0100, Srinivas Kandagatla wrote:
> Original issue is that the id field in the dai is not same as the id
> in dai_driver when dai driver count == 1. This is due to the legacy

Applied, thanks.

--HlZi+g8Ywt2nzGP6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXkyNAAoJECTWi3JdVIfQtpgH/iqSHq5p7o1Wj2tXxpL9qwf9
GW4hFcH5zb6xAq0frB9e5Iv7B66MVmhdIxih7X3xpcO4oKoKR+yomEllVjmA0cQf
c+242qFPOp7LTuo0x6NeLQHSMcUS8MCO0GSiJh+aPFz/7OoRDzDfUfzh1JBo654Y
U9NesYY4FQLC/6OzctpDU+MCQw1P+sVNPTPKjPATn4uREW7HVW5UESmQZPMMHjhW
PfCZRG86qnFQExNH5y3Cfhx3wpOVUsOaKwzU4MV3I3qbz9U3Vk/Zl+ORfZH6LPWn
G61e7R5swBUEWVFbhjRzoQ6VZjq0ZHvQQCtqvcfidUtXlee3NVKFnmHuxIC3b5I=
=LT4C
-----END PGP SIGNATURE-----

--HlZi+g8Ywt2nzGP6--
