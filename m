From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: wm8994: Ensure microphone
 detection state is reset on removal
Date: Thu, 30 May 2013 13:46:10 +0100
Message-ID: <20130530124610.GK5180@sirena.org.uk>
References: <1369917750-7322-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1369917750-7322-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0537028329137905572=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 30D352651A3
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 14:46:22 +0200 (CEST)
In-Reply-To: <1369917750-7322-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============0537028329137905572==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLauP2uySp+9cKYP"
Content-Disposition: inline


--SLauP2uySp+9cKYP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 30, 2013 at 01:42:27PM +0100, Mark Brown wrote:

> +		wm8994->mic_detecting = false;

Wrong version, should be true.

--SLauP2uySp+9cKYP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRp0oOAAoJELSic+t+oim9VX8P/RmYP31JTclWdrGw8oGjBgbY
8mweI6YINu6PkYJyQ5uNbhWlfiNQL2FF8egJAbDvm9tLWK4VYre/Q92pkrvlULFO
0rNtyr5W0Rbn8GPdS4fcsRTyKzKoPw8eJkBdQE1rP05m3HZqDZCNFEj2ID4oOBAe
vY84MQAueICNdWO0WMijhJRcvWG04wCV5KBLCJ6SS0+cT3r7QXCJhVUvBtn+W/a7
DyDZuvKh1wGQrXVe2L7gBOTMs23V6hJQ/AUkRylxFIL2XxpYoaKbCIRYNYZGB3Sx
7OmlMLIeF6uowYrfRoIUmkyc68ANzyQkI3nIlN0WUUwAZIv6Y18Adf8iM0/oJyHl
DKIDmmS7MyRiCmZQoZcihhK/3C4gRRPY2tpjblUEhtRjCoOrUWUpafsFR8uF4JMp
Wv45PF6lVfWu574jUR/tUw6YJ2Grh/G9tcFqYXPVBXR+J2wXzpd1JUg9PfNqNdkP
cUSWXffS1GfpNkaEXyJMwFYAt1q9mqNO684aC2dqH8OvgoPpw4ESQsaTtCZYFjK/
IjbC4nMy3ArzMwZ+uZ1uYl3Ul0ifJrGctPsUyIYIQNZQ7mUoLxCiuwBmJfTNd5Kh
j9mPwtC75P9ZsLI6KlivjxlgIM+5gOVTKGqNHm81tfGpH3MKffFtNeNlwxTi9tq7
R61RGVANpLNBfFFtd7UH
=Ih37
-----END PGP SIGNATURE-----

--SLauP2uySp+9cKYP--

--===============0537028329137905572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0537028329137905572==--
