From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/11] ASoC: ux500: Provide better checking for Device
 Tree and/or Platform Data
Date: Tue, 7 Jan 2014 15:37:34 +0000
Message-ID: <20140107153734.GL31886@sirena.org.uk>
References: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
 <1387468508-12286-4-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xZdiZ9E8vSzGEnb8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387468508-12286-4-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--xZdiZ9E8vSzGEnb8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 19, 2013 at 03:55:00PM +0000, Lee Jones wrote:
> These drivers will not work without platform specific data, which is
> passed in via Device Tree or Platform Data. To avoid the chance of
> NULL pointer dereferencing and alike, let's ensure we have at least
> one of the methods in play before continuing.

Applied, thanks.

--xZdiZ9E8vSzGEnb8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzB87AAoJELSic+t+oim9OVEQAIl1mJgu3QSNNwmZ4DwxyTsx
ZKQejHjL8mzi/CxqiWl8/WsA+Yoh0rt+xLCt59SG6TgAHiRyhbvf2HWm9B+WA0Y8
JTZ0Rl0G0Mkfo2uPeNBPw+O/cT9sPuXAlgYekapC0R7unV3HPmxVAg5j0TZOdQ9U
KZSamey0429+cAH3UTkoHd4lRm36qy9KVjHpc0zR1wxiLvcMjRrULJ8lv8aIt9Qu
WMLSXbmTMMOhwui5s0I5c8T+730J+OMkXnknccofvBzyVRp5dzaK6LItn5pXDiu8
Il3sO12OmUnQ2HMgPfG7cOJd3OXUv91gNa9Fv+EWQFK21ZtNjFAn0VWIMuGK4v1l
+hfgiTltY6Vwr/eCSdlIK5J3bV74fxKNuxxY7+xBA5z2ZWHYQQGJEpW1AIefJqAS
yCrRvWFn+ea1AxYBEUJtdQZcZsBQTc69/U3Za7NL0D93UAFIRHPz2K41fXTu1lxP
X9ZAl+u7gE4LwkbR/ARBsMiw7HmByeutxK0maIvj8GIKTHHtHHVqY2uHTHae0BJY
n2KG4SMaYz9qjhiIF1EkLouqB+RIk9nJyutVWImlSAqx+SG9jrH2IX/R1u6YNoGG
ywmaeh2ABumyYvIRA4gjf2CfrFd9+2SHOY7pt37ts4D8gvnBYKwKS1PxBaxrKl8W
7FiNKy3eRi9jyu8b5syF
=7XIr
-----END PGP SIGNATURE-----

--xZdiZ9E8vSzGEnb8--
