From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 02/11] ASoC: davinci-evm: Add device tree
 binding
Date: Wed, 18 Sep 2013 15:38:25 +0100
Message-ID: <20130918143825.GR21013@sirena.org.uk>
References: <cover.1379409268.git.jsarha@ti.com>
 <b94659fe6bb26dd457c6c6d542db912896f327b0.1379409268.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tTvAEuyWWbMF5UF4"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b94659fe6bb26dd457c6c6d542db912896f327b0.1379409268.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jsarha-l0cyMroinI0@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--tTvAEuyWWbMF5UF4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 17, 2013 at 12:26:01PM +0300, jsarha-l0cyMroinI0@public.gmane.org wrote:

> +  TLV320AIC3X pins:
> +
> +  * LLOUT
> +  * RLOUT
> +  * MONO_LOUT
> +  * HPLOUT
> +  * HPROUT
> +  * HPLCOM
> +  * HPRCOM
> +  * MIC3L
> +  * MIC3R
> +  * LINE1L
> +  * LINE2L
> +  * LINE1R
> +  * LINE2R

These should be in the CODEC DT bindings.  You should also be CCing the
DT maintainers directly, they're a bit overloaded so tend not to read
things that only go to the list :/

Otherwise this looks good.

--tTvAEuyWWbMF5UF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSObrWAAoJELSic+t+oim9/FQQAI05dKjfL7Zc+SaTqRTFtNbD
73dPcYc8vJjxNdxfvk7iO9gl/0UgWfO1UwA/b+gTpN64N07eT0SXUEAdiirPTkVo
MkWb4UwJNV10C1klo+K/QdQXH3Iivz4dFelHYTL1ueQ1OrB5bWZsPkiFihOaPHGf
8dVXy9Zp3NZyb5gXam4b/NnPfd81Da6mlkvo1NFypbIc/p85Es2oPxMbchOPWLUz
7Vl/O3l92boR+n0BZBl6YIoTmS9JrW/cRHSPSZF/hmsUYqU2TAbaB8f0iiD9rTgJ
v/WUlw5MkhXeI/U4SCL/hjlOYp6bMkraaYjAL22t82pTShL0YLWErmn9XF1F4VPm
a8B0IBqv+A1ST5LRN3VAAHIjBmdFsxSqd7JsM+/xhtWlEy0T35fA08XsQykFKrXO
8vuAKJ2MnrBXCqrJB18EoLxFRsSAEjkwUZe/q3zMxk9OqlQvhT3rV/EgJlNw3tMS
tlVkXwn68zeTNPlVSwAAgz8thWD8c16TRCYT6t39h7Mwn5GsMBYjVSLF4sMraRKt
9YEctAyh0FcADpuun5Fz/SFNMUBGHYvNZC1+qdxcVV1pE7tBw0TfG23gFG8grbh1
CjAqjw+A5G6zbIep72ovcvB9k8VEJzC7MwICssw7pBDFLEghykTBrXILwHpRzp3+
pu65MQg0XyS7fF+GVy2H
=6r8N
-----END PGP SIGNATURE-----

--tTvAEuyWWbMF5UF4--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
