From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC v1 7/9] ASoC: msm8x16: Add sound mixer controls.
Date: Tue, 16 Feb 2016 20:21:13 +0000
Message-ID: <20160216202113.GH7544@sirena.org.uk>
References: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1455644008-1917-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455644008-1917-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 16, 2016 at 05:33:28PM +0000, Srinivas Kandagatla wrote:

> +static const char * const msm8x16_wcd_spk_boost_ctrl_text[] = {
> +		"DISABLE", "ENABLE"};

On/off switches should be presented to usersrpace as on/off switches
with "Switch" at the end of their name not as SHOUTING enums.  The
indentation and brace placement are also weird here.

I'm going to stop reviewing at this point.  It really feels like this
code could benefit from taking a look at some modern CODEC drivers and
following the ways they do things, there appear to be a lot of these
issues throughout the series.

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWw4S4AAoJECTWi3JdVIfQWZ4H/Aqy37+IMcoBtNVkdUowWb0i
MPV/hiQUC47QAEaSE71Tjvlf8U7UAb5UwJhNQRK4gMpUo8tn07b1Vfii1K0lzUvL
CWDdAM0ZJsKJ3InPpZ224BeuQiLNvDFFt9v2LxTIXPYrs516n+RJHClKZrQK//mB
wHk3msNzhxV2ya7Y8zheEQSKkNmTbJx0ioKjSmwwZtH+sA7KKw/qW4+/puH+IeoF
Lr0qdXxvz9kCVt6aET05FYZMbfyrax3M0fCHe4au21fU60Kv0UPkYXDGuPfWsDFZ
/518+Il64Q4hdWAd65m+5ymA1jckA5hy5zE6tG6WZP7OmFmQ4SZbO6VXAzds04U=
=M6ex
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--
