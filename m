From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/8] ASoC: Intel: add function to load
	firmware image
Date: Tue, 10 Mar 2015 20:38:37 +0000
Message-ID: <20150310203837.GO28806@sirena.org.uk>
References: <1425955287-29661-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5079558468011768830=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D7CA2605A2
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 21:38:42 +0100 (CET)
In-Reply-To: <1425955287-29661-1-git-send-email-han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: han.lu@intel.com
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5079558468011768830==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WU1McKeqU8MHoLZD"
Content-Disposition: inline


--WU1McKeqU8MHoLZD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2015 at 10:41:20AM +0800, han.lu@intel.com wrote:
> From: "Lu, Han" <han.lu@intel.com>
>=20
> Add a general method to load firmware image, and apply to base firmware
> image loading. With the method, the driver will support loading multiple
> different modules in order to support different features.

This doesn't apply against current code - you should be sending things
against my git tree (or -next is often close enough).

--WU1McKeqU8MHoLZD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/1ZMAAoJECTWi3JdVIfQt3sH/080koXz+p+sNLTE6W4ugeJ2
lDSq5pO1ybdxHrVO6vuTJk33KJTvxZABcfTrdSGpxDgiE0c3f/ou16PjIPGPMzy1
+cHdtxwi1euMLsY37uHlb0I84eiog7LgcsoJn2HfcX27j1tO6ygIgLK0BYeyZP0s
5zYTmG5znq1p6ISscVcMoMjEoqDZQQlA/pyCQCk29l/tfNCF8xMjhqbtRagEBSTj
YfVTw7sTWbRvqb7zp5n8KDU2edoHlkz1LY6Dg6jym8Ef4Q+L8g8j82yyN6vR/Ma/
8HvQSpfUoKXFykLPrDOQfv9llEf374EfgX36GnlqSLgydMRntiMT+BO5dk14xQc=
=AHgx
-----END PGP SIGNATURE-----

--WU1McKeqU8MHoLZD--

--===============5079558468011768830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5079558468011768830==--
