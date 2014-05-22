From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 5/9] ASoC: simple-card: Support setting mclk via a
 fixed factor
Date: Thu, 22 May 2014 18:39:19 +0100
Message-ID: <20140522173919.GM12304@sirena.org.uk>
References: <20140520221359.GF12304@sirena.org.uk>
 <1400772710-23523-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gR+RmupAgnvE6x/D"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400772710-23523-1-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--gR+RmupAgnvE6x/D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2014 at 05:31:49PM +0200, Andrew Lunn wrote:
> Some platforms require that the codecs mclk is a fixed multiplication
> factor of the audio stream rate. Add a optional property to the
> binding to hold this factor and implement a hw_params() function to
> make use of it.
>=20
> Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>

I'm missing the rest of this series - what's the context, are there any
interdependencies?

--gR+RmupAgnvE6x/D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTfjZEAAoJELSic+t+oim9kz4P/1fGDgmPK0PCEJX2tRmhLSrQ
OjQdqmRd4u6jRbizPFpIVCMiJwcSPG2pV1nefmh0eBE0zKkrwAGbmKnRtOg0R7UZ
TtyoqYNrRAgiYYVkATclON6YOwG1bJ4YEPmIFM3XLGB6Ki1I/Yzv6wQIYfaQ7h/I
Knq4CWiWo7aIjbFLZ2EkcSdqzgGLiR3Pf6AHh85W0E+oNfTWxT4mkxScRuyGgoPh
svDUbu1cKU+CVzMzZpDtggCEk5+3yMfUteUc85YapVwnql6PPNTWPRS3LGU0/yZ/
9wg1tkaClJD1ZKNiqqYdDWWG9kwoLYPbj4sXFNbv2OYXQfAr4GvHtl9bRwy2wDv5
0vZ1vEM6+nyYXwNKzVACv/NnakzaXS2qCC1BS7kFT7+DrnWG8CL38BDVlexvfbMv
/aZR/Y1QzE8Sv5r9p1lRu4vVgfPUheY5iul2zXWRRC5Wd01l6BV/KMaUa+dSHb7P
iie/HZcw2uNBrBhYCbXPgk9136z5y0mGoT5X9L5lxUlrADPr/fUL1DIGs7Xjzu9N
SiXyfcVDZQE3sg0wAfnNlRxohojtHoZtOojCzOTCAt2MFcqHO+ylXWBfNmEv1Ynz
IMELBqTUUG3kH02OoQdDI6vSc1XFKNvbW0tHisJNWXFfHd5bgUQxKYh0JXNzfKfo
cPI5j1AsUn6FoC1xwmgF
=FMBD
-----END PGP SIGNATURE-----

--gR+RmupAgnvE6x/D--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
