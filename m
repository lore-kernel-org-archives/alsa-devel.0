From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8993: Remove unused pointer in wm8993_remove()
Date: Tue, 25 Feb 2014 13:34:58 +0900
Message-ID: <20140225043458.GS25940@sirena.org.uk>
References: <20140222160016.372a3683@spike>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5ZS7wi46EbtzMhVf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140222160016.372a3683@spike>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Engelmayer <cengelma@gmx.at>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--5ZS7wi46EbtzMhVf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 22, 2014 at 04:00:16PM +0100, Christian Engelmayer wrote:
> Commit 88b5bdfd (ASoC: wm8993: drop regulator_bulk_free of devm_ allocated
> data) eliminated the last user of driver data pointer 'wm8993' in function
> wm8993_remove() - Thus remove it. Detected by Coverity: CID 1186208.

Applied, thanks.

--5ZS7wi46EbtzMhVf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDB1vAAoJELSic+t+oim9jswP/1HBP/5HotLTxnDsD/5xwRpl
DEWl+PGhg+7/kX/XXDFr6edO/zKlhLNUjiHlXysIWOPqwtvTxLgMHw1ISni1CLJW
JD2DrTwq/xixtDH2P0D+JRTSrbR4PRLga0c8n2coZzry7vsO7woYz4FAVuYDaIpA
AFGEi6EWpIKFPDGG85sgcmYW8leNpYn0+dKpK0C3MoZ/BpBADejHfrLNjJrh35Gx
54lmcnd2syyaCc4OfOuIGzswRH8lOCUjj0Ir7Os8UOL8utKGbw8sMgaf9bjPik09
XNmNv28x0VKGFYShshFOYeRXz8vjwwCRVHUP1hQouScaRmPnyzQchtb1Tr2DmA7j
AYZWdNV5zYHcN4p2P8Usi15npftT092rl3g4uGU6QFs1Xpwy2RtaSgWeY8XgNmoN
WPMNr+XbbjdSyTXcGXNSpkNgl9CIDG85DjtGEUEsWYubyq8Z+G8c5F8qWt7YQ2ra
kbfRcPnBrq2iyo3udgb3ox9nHpUjCo5Y0TbT4Ciy65FiV8+2/BqHhHFodDQI08bz
Iawbk349RapWbj+82HsR/5KWNLizjnurNIjeTwfAUzO/deSijgoRp9M154nkTWwX
18e/LX5W/r6GtT3mhZEA/9zUAsw5rftEEEJH5YKO+YNj4Knl1ZlEBU7Nwq5/iGCz
rLFs1+J34OsZFOBGGLSE
=6tyz
-----END PGP SIGNATURE-----

--5ZS7wi46EbtzMhVf--
