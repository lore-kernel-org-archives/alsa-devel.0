From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm0010: Remove .bus field setting
 from wm0010_spi_driver
Date: Fri, 3 Jul 2015 13:47:01 +0100
Message-ID: <20150703124701.GA1472@sirena.org.uk>
References: <1435809778.4609.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3399649984291278835=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 32FEC264F39
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2015 14:47:19 +0200 (CEST)
In-Reply-To: <1435809778.4609.0.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3399649984291278835==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 02, 2015 at 12:02:58PM +0800, Axel Lin wrote:
> The .bus field will be set by spi_register_driver() so we don't need to
> set it in wm0010_spi_driver.

A similar change has already been sent.

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVloRBAAoJECTWi3JdVIfQI2EH/0S8QU24IjGlpfw3OorH5jxE
FwTfd9a+OzIVG7OzLLGpvvElk6qQ0Qyb/toO7ez5GgnwYWT66MOeuYYX5c8qMqWt
D9Lih1TFn4/MiZZoO1G0Wvt1d3y+xBW+ewFj9KPwB3ui81S7HDeWUS0YFRJwM7EN
X1/EaFnNar2RcvvmYt5oHOq0u+WNRC1m7SMrecpToa5VZ9I/GAFA4UqemcbcTMMo
uWUvtN2vXHYAXIlcsmJHk3xtH7XACOfn+Z7YlDNdX06RsREGE/T1M4kdk4VwHR/p
uO9pSlvSPn+ipmDSZS9myHAxW9kvY9G4t3mjX9HwO3GY08B6Nc6anZCmqqoFyC0=
=keZT
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--

--===============3399649984291278835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3399649984291278835==--
