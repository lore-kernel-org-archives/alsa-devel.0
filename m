From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/2] ASoC: codecs: add TA5720 digital amplifier DT
 bindings
Date: Tue, 26 Apr 2016 16:37:07 +0100
Message-ID: <20160426153707.GZ3217@sirena.org.uk>
References: <1461615456-19510-1-git-send-email-dannenberg@ti.com>
 <1461615456-19510-2-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rbGP8ORDiOE26keR"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1461615456-19510-2-git-send-email-dannenberg-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--rbGP8ORDiOE26keR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2016 at 03:17:35PM -0500, Andreas Dannenberg wrote:

> +Optional properties:
> +
> +- dvdd-supply : phandle to a 3.3-V supply for the digital circuitry
> +- pvdd-supply : phandle to a supply used for the Class-D amp and the ana=
log

This suggests that the device doesn't need power... =20

--rbGP8ORDiOE26keR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJXH4siAAoJECTWi3JdVIfQlu4H+IKanNZm3Mm2sHgUyG6Qv2gA
lycOsGIQ65BRQSqvHmOFqYtFGsyzAqD0raepZutl1ssX68eGf7OlojgNuMsRrVEs
BxLY80x3B4na3bwJFpCqz/1KvCAC7+1HWP1BSo7eeKCL/3DcRbBTG2Lxv16SbkVy
XqJkLO+aRBUBfOALMPxVU7E/iNZzJo/aiAAnaa3ZqF1hN7lFRJMfB2W2Vmynagxl
ZXQICkCt0Urtm99RnspgvA6fpNeDPhuoVpiKrEGqYHlSrlbb/1xlGkTLtejQr1RX
haNq8m+DZmP4uY9NJMeyIRXmv/MkU7iRXXM/0zeBQsSlkUK8UFE9neKBx1Yh+A==
=+AsG
-----END PGP SIGNATURE-----

--rbGP8ORDiOE26keR--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
