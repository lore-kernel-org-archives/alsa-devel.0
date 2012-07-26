From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 00/21] Some fixes and DT enablement for
	ux500 audio
Date: Thu, 26 Jul 2012 12:28:48 +0100
Message-ID: <20120726112848.GX3099@opensource.wolfsonmicro.com>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7370305463613065712=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EA05D265E5E
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 13:28:47 +0200 (CEST)
In-Reply-To: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, sameo@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, linus.walleij@stericsson.com
List-Id: alsa-devel@alsa-project.org


--===============7370305463613065712==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XaepPZQT0uxAV0NY"
Content-Disposition: inline


--XaepPZQT0uxAV0NY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2012 at 11:28:33AM +0100, Lee Jones wrote:
> This patch-set sees some code reinforcement surrounding the recently
> accepted MOP500 MSP, PCM, AB8500 CODEC and ux500 Audio Machine Driver.
> It contains some extra error checking pertaining to the ux500 specific
> drivers themselves, along with bugfixes for issues in core SoC Audio=20
> code happened upon along the way. There are also a couple of minor=20
> clean-ups relating to ux500 platform code, which are hitching a ride=20
> for ease of status tracking.

Please restructure this so that the actual error fixes (which should go
into 3.6) are before the random cleanups (which should go into 3.7)
rather than mixing them together.  It'd also be helpful if you could
split out changes to the different subsystems separately when there's no
overlap (which mostly looks to be the case here).

--XaepPZQT0uxAV0NY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQESnqAAoJEBus8iNuMP3diYUP/R8khjxQT3MOyj5e+UZ9aUGG
XioB8XOsOZQmuR5P8QqpsLbpf6Yf/cjhqxPZE4M0DgwSrkq3xhMJZDESMcVCNlPy
O2Kf2sqVelO5owFib5LfaFDjDrOFGrzInLbA4gsbOuu6L/r4hTCm+iZeycsJTj2S
ZF1XLL4eAjbAsdy9Ce3tllxrvoRHJLbPR4IHRToVDuLaRK8+AKia2AMrvlDefU8y
hnUzZcnZC1r6MGwth2UZ76bq6mNblY+KtSxXyW2hIR3uFV0x2OpxXusBFc0AWZIC
gai8vPCHVa2Y3Sk0d6XxV/iAzVltm4ffLMRmXHennxsfzkVyXWcHXG8/JTT55FQ6
DN9Z9k6VR7m1Tvn/Z0X10R6IHfOaqCASB2SaIS7yf2EG3XEbK6zOrrZUxoXJkC52
woWZM93vH+gD1SY+EmlXw2Igd/kvkdQrbSZnqw2wOLnKCEWxmyrM60aau6IuVS3H
uGzNWZXprI3cNgizfwvVCVHH+xe6nBuUVi08GwrmaKY2f7nAowdF+cN3cb31OfGZ
ytLUPZsafugOF1Rh4GQ5JpbK3Ii2OE041wSXE7iv0TpRNEY4rrKn4mL4OYJ5wTbk
UzFnr8KonJQANFIAKODFyCnp0cTQkJa6sGlf9TGipEiJqWKT1vByiZcxTOQKMM17
vNCMStlSEvDyIDeRtNIs
=yLX2
-----END PGP SIGNATURE-----

--XaepPZQT0uxAV0NY--

--===============7370305463613065712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7370305463613065712==--
