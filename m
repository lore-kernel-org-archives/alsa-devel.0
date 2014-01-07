From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/11] ASoC: ux500: Dramatically reduce the size of the
 DAI driver data struct
Date: Tue, 7 Jan 2014 15:39:39 +0000
Message-ID: <20140107153939.GT31886@sirena.org.uk>
References: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
 <1387468508-12286-12-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MJkHxHECS1u22Flh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387468508-12286-12-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--MJkHxHECS1u22Flh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 19, 2013 at 03:55:08PM +0000, Lee Jones wrote:
> We no longer have a means to differentiate between MSP devices at probe
> time, mainly because we don't really have to. So rather than have an over-
> sized static data structure in place, where the only difference between
> devices is the ID and name (which are unused), we'll just create one
> succinct, statically assigned and shared one instead.

Applied, thanks.

--MJkHxHECS1u22Flh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzB+4AAoJELSic+t+oim9kJgP/3sTy3+7R9m4wXGzN6ojrDVz
M5AZSEIORZyDIXfQivKmoW87es1NXKynFB7KiWU1jC3QsJcD6cFhHc4D5wW/eaOU
b+jAM7cWVV9/1KxmM5mj2I3POtc0bMZM7GItusH5E2RkgVswSz8KjeEFFBgdTwDy
KkqToUrWQBU8ZBLl5Ru+/l+9Rh0n/yBo70Nn9Vf71RnQ8ue4xa2PVFCuaocKSII6
s1DmkhoVUV1acF1k20QfMcOtTg1ydHQXV1WMVeTqX/pnWQ+JEhF3Upn6TBM1njz4
peZk+hFKiWRa/D6JqDsxYLXT5/499wWXA8IXhvg+4pEU2T40ZA4rL6uk2RRqo4X8
om558v9OIMWEkdO/HoPr7qHcAnm7zFC4Q3mDUU5J9Rf/7PamuHYQoxU8HGGL4fAn
TZI3+kg+vvh4AoCi48HVD9YhNQXgdKF0KkSDiwYENeMJA8AbltBZJIRcn410a5HK
kbPKppQrahRU5H2tZs5xTGS3zXAOwh+SwSlYR2JWNX3VphojYTluQOdhzXkTFSP+
Z9m5mUYnJMsRow1RF5G7gWjEEkkLryKPnRSWpbu3yaqg8E3hmvcNCe67A6fooyse
CTkkegLlckI67Tsu38x+vsd6Lp6oZ1S+TNgDNDaaxAGXiznDRu6x1I2RZrx+LepE
G9iXELrb5Z+ckUoWRZ+U
=1eVg
-----END PGP SIGNATURE-----

--MJkHxHECS1u22Flh--
