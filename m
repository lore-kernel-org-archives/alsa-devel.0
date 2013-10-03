From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: omap: Fix incorrect ARM dependency
Date: Thu, 3 Oct 2013 17:01:20 +0100
Message-ID: <20131003160120.GX27287@sirena.org.uk>
References: <1380651650-32131-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4168473952741930116=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EB302655AE
 for <alsa-devel@alsa-project.org>; Thu,  3 Oct 2013 18:01:25 +0200 (CEST)
In-Reply-To: <1380651650-32131-1-git-send-email-jarkko.nikula@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4168473952741930116==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KRJ4yArSHF8vY7I3"
Content-Disposition: inline


--KRJ4yArSHF8vY7I3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 01, 2013 at 09:20:50PM +0300, Jarkko Nikula wrote:
> Commit b0e0a4d ("ASoC: omap: Enable COMPILE_TEST build for DT platforms")
> added two incorrect CONFIG_ARCH_ARM dependencies making impossible to select
> audio support for Nokia RX-51. Fix this by using correct CONFIG_ARM.

Applied, thanks.

--KRJ4yArSHF8vY7I3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSTZTNAAoJELSic+t+oim9YGMP/inuSJUR5KEH33J7/KIm2AJb
o//KJTTZ4WW2q9+4dvbtucSo4s5W2xDuSQN2rQkgtTt4jfFS0LrtIRTIgT7VtkJp
JGZ1Vc0venlZIUclaemQENCjgRyMDE83PVbVBbHQkikw2pHcrvItpAQ74zue5B1P
edQCoBFZfYcTIt1IAbKf7wApccUp1C7CsPVksv9oF/7QiQVa7bbFg6rKYOKR7W1m
+YUE85hv4sZSxJj2zPzNoohME3CcVE6YCym1XyVXXDhBeUnp8M2HmEr5g3hclKb6
ijd1P/oAHhZI/dEYKcvE2YHOVQvvzPhWWMA3cvgiFnOPOIjtiTwTAqGRgWgwzcPT
9ZaN/1n+4Z0kzJpFePPgcwjS21qAn6CXeUxubtn+4+x7njO2xX9u9TIi7abHvo9u
uewuM7GEUXe137vWe+ozeRrMcbQ8QsfMv6wC4G98Q+ThpTtKsTO/77CWQ92McnJU
FfFLsHl+nY7guWEDZU7H4GdwQ1Z7IzdYdPh/sWEi79VRUYQjad+iqUWjKugkjart
CrAXCKUNXR4pyetuAE60E+7DpHWKD5h49h5GP0OcWmaFxApaW2ccbAViWNSsxU9Y
xivzwoiLG17p5YVN9tlnp9qDu4ULuvhatoiZfhr567+gOnTWTwptwcIpRzvmhMl1
omSahwsSJbr+uYdRoEMB
=Eh0O
-----END PGP SIGNATURE-----

--KRJ4yArSHF8vY7I3--

--===============4168473952741930116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4168473952741930116==--
