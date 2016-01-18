From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] dt/bindings: Add bindings documentation for TI
 ADS117x ADC
Date: Mon, 18 Jan 2016 16:34:21 +0000
Message-ID: <20160118163421.GJ6588@sirena.org.uk>
References: <1453133092-29521-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1453133092-29521-2-git-send-email-florian.vaussard@heig-vd.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S4NLt4ipYM5IQHam"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1453133092-29521-2-git-send-email-florian.vaussard-EWQkb/GNqlFyDzI6CaY1VQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Vaussard <florian.vaussard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Janusz Krzysztofik <jkrzyszt-NCk8gXQAEuFz6jiHbVrK7g@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Vaussard <florian.vaussard-EWQkb/GNqlFyDzI6CaY1VQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--S4NLt4ipYM5IQHam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 18, 2016 at 05:04:51PM +0100, Florian Vaussard wrote:
> Currently the binding is only made of the compatible string.

Please use subject lines matching the style for the subsystem.

> +  - compatible : "ti,ads117x"

Compatible strings shouldn't have wildcards in them, they should specify
a particular device - this way if we start caring about differences
later we don't have problems with old DTs.

--S4NLt4ipYM5IQHam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWnRQMAAoJECTWi3JdVIfQYIEH/0ZZaN8aPZCNjFK92rXVUUMt
lCRpcPNzBoHkSpihA44RGQJ98f5egMa0gtmlLV/BVAxNnZwNOrm+bUaXWHQdGPUh
F3FeezPStjCwDZuVl75eXqMGKM87ySvi0P9d8+MH14MFfx6lvct99G0OPH0da3gr
fWfupvM43/9D8VDRNpXHexV7ChBtLufvK9ezLfNK4LrXKP1DWE7QvVAHdHH1Q3kB
mWgH0yRS3rqxPTUDy85ngWeuWEXMHuo7a1/12k8OMyDvl92qoYXsceCz9n5VcHIs
h3laHmc1+lbFT6o1SIlm+EV63uWLBnqphh4pVrwaTbn8S4wwmLW87BmdPG/Gxho=
=zi2K
-----END PGP SIGNATURE-----

--S4NLt4ipYM5IQHam--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
