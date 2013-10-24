From: Mark Brown <broonie@kernel.org>
Subject: Re: Is that reasonable to support pinctrl PM in ASoC
	core?
Date: Thu, 24 Oct 2013 12:52:24 +0100
Message-ID: <20131024115224.GD18506@sirena.org.uk>
References: <20131024110743.GD8385@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3662713171926307846=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 01773261A3A
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 13:52:33 +0200 (CEST)
In-Reply-To: <20131024110743.GD8385@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============3662713171926307846==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2013 at 07:07:43PM +0800, Nicolin Chen wrote:

> And I think this pinctrl PM might be also beneficial to cpu dai drivers
> since they might have actual pins, and they can hypnotize/wake them up
> along with runtime PM:

I think you're right that this is a useful and obvious feature but the
question I have is that since the standard implementation is going to be
to do the pinctrl calls in lockstep with the runtime PM handling and
since this is likely to be the same for pretty much any subsystem might
it be better to add the hooks at the runtime PM level rather than in the
subsystem?  Or perhaps we should just add them in subsystems and then
once some reasonable number of subsystems have done this then pull it
into the PM core?

Linus, any thoughts?

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSaQnwAAoJELSic+t+oim96U4P/itIy3dMylHkZ3YYvdN0PrYO
JH2zsJEZML8JxqEudaGCKg5aaaJmqcwkWkwiYVHBVpyb3gHilmZbhrG5OK5P14yo
zu92mdQldkGAIlvbjFAr3p/zdnoZcYcQnQkGAWq++A1+zPT4pp4m+AWAzOOsVK/4
X5FqEKroXVjAy5wDzOJO0Lm6tDl1RDoZONgLxKrJj8hLSDVRAdnIxaB1PNEDa0Hd
Vb/gwW8BwsLUxBM3nqBV7wD/yYAdCsm2IKE9GVudoWMfp1xAJxOWQUnSGikPTlhh
xW5lllnJRXJ+OCmtR24vUCUaK7cMX7qrn4ILrSFHyZIp5nTLU4SHfVAynCcnCZBQ
smVXo7skwUo7fEWsGqlcAwrMyWd2VP7rrWvq1aYRzY8dp1r1W9Lcn7tovuxwlbPl
W3y5JyZsBxeaRbyZiVcwwJ1fXleNhQCT06UcMaK89ljvAKGra6yrB9A/wFr4NYAs
AvEcypAJ1pfWUXtWyCg6sgjnxdai2ynB+5DJnlm7hHmzMhVdb8wxbDEuM6p4Kuty
9lozUbsR3q2rO8Honbc+VJgFaVOt3QFWcoMIe5/a+8LCGucvPqzRcV7xcwx11Ah2
YB6Y2jm01qjYO8Yw/FBJDNLI5tfoTvme3lRWWrXOv0czonVND09EaWc83S1DKCp4
qqoK1wWmLMHV98na3AEz
=uftO
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--

--===============3662713171926307846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3662713171926307846==--
