From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/8] ASoC: AMD: add pm ops
Date: Tue, 5 Jan 2016 18:59:29 +0000
Message-ID: <20160105185929.GN6588@sirena.org.uk>
References: <1450897275-17152-1-git-send-email-alexander.deucher@amd.com>
 <1450897275-17152-7-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1541370309=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1450897275-17152-7-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, rajeevkumar.linux@gmail.com, Alex Deucher <alexander.deucher@amd.com>, perex@perex.cz
List-Id: alsa-devel@alsa-project.org


--===============1541370309==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p1Od3smaOkJqivj4"
Content-Disposition: inline


--p1Od3smaOkJqivj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 23, 2015 at 02:01:14PM -0500, Alex Deucher wrote:

> +	stream = adata->play_stream;
> +	rtd = stream ? stream->runtime : NULL;
> +	if (rtd != NULL) {
> +		/* Resume playback stream from a suspended state */
> +		sdata = rtd->private_data;
> +		config_acp_dma(adata->acp_mmio, sdata);
> +	}

Please don't use the ternery operator like this, it's not bad to write
if statements and they're much more legible.  I was having to think far
too much about the various variables and if we were safely handling all
of them before I realised the next block overwrites them all anyway.
This is really

	stream = adata->play_stream;
	if (stream && stream->rtd)
		config_acp_dma(adata->acp_mmio, stream->rtd->private_data);

or a couple of nested if statements.  Otherwise this patch looks OK.

--p1Od3smaOkJqivj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWjBKQAAoJECTWi3JdVIfQc3gH/0PRpeYD47Qcsn2tyIwlgfhB
mPG8PWAkaKdwT+UMwB0RdsRylZ0XiByf/gySeKURo7Zii5Yqoyo4kG+rOW1DuQ5q
DJiJuYnDuN3GQuskttWPhwKYDhS+wPprObyXYaipCG3SuEqIb1dNjejRlzx7YZbN
XfK/QeqJtugE9zJmwQ5QQBt3ck7Dbjg6/Emg4UwUZ1P3+xZ+Vrm4SEDFyHwTZYgS
gClBV2YYm+WTN2V8a3fwrROwqXTyMXw/qqnyDVSy/Zhm9ZX+bbTbjQ0vtTybKnBE
aBcGlw0pz+M7o9ny9WObrZDBB68tDosJ9YK38ZerEQ1/+0pEzAfpRWlBh9rDUto=
=KG1K
-----END PGP SIGNATURE-----

--p1Od3smaOkJqivj4--

--===============1541370309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============1541370309==--
