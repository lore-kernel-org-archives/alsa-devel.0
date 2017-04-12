From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: Document STM32 I2S bindings
Date: Wed, 12 Apr 2017 16:38:31 +0100
Message-ID: <20170412153831.r2urwvfseipfsrsi@sirena.org.uk>
References: <1491493236-2574-1-git-send-email-olivier.moysan@st.com>
 <1491493236-2574-2-git-send-email-olivier.moysan@st.com>
 <20170410194832.iivnkyejtywbe2c7@rob-hp-laptop>
 <20170411143250.3r7ys3rjshtxgaee@sirena.org.uk>
 <73caede5-ea6f-8b2b-2270-227f7ef31823@st.com>
 <20170411211040.htrcedus3c57fbed@sirena.org.uk>
 <86a179ad-7961-18f7-8050-25e0e584c77d@st.com>
 <20170412113251.nfyk5sw6c5pnpmwr@sirena.org.uk>
 <d886a9c7-ca46-f37a-0e82-6ed8d7a4e052@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="okqjiama34qumvis"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d886a9c7-ca46-f37a-0e82-6ed8d7a4e052-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olivier MOYSAN <olivier.moysan-qxv4g6HH51o@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "tiwai-IBi9RG/b67k@public.gmane.org" <tiwai-IBi9RG/b67k@public.gmane.org>, "mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Arnaud POULIQUEN <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Benjamin GAIGNARD <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--okqjiama34qumvis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2017 at 12:58:16PM +0000, Olivier MOYSAN wrote:
> On 04/12/2017 01:32 PM, Mark Brown wrote:

> > It is totally normal to just not use one direction in a given system, we
> > don't normally need to do anything special to handle things.  I'm a bit
> > confused as to what's different here and needs configuring?

> The IP does not provide an audio channel configured either as rx or tx.
> I agree, that in such case, the cpu driver does not generally need
> to worry about direction and there is nothing special required to handle =
it.

No, that's not what I'm saying - such hardware would be extremely
unusual.

> Here the IP provides 2 channels, 1 tx and 1 rx,  which may be active or=
=20
> not. The driver has to know which channel is used, and if both channels
> have to be managed. The affected registers depend on selected channel.=20

This sounds like essentially every audio controller out there.  The
overwhelming majority of controllers do exactly as you describe and have
both directions in the same IP, this really doesn't seem at all unusual.
Off the top of my head I can only think of one SoC family which combines
multiple IPs to do bidirectional audio (though I didn't check).

It really feels like there is something different here and I'm just
missing it.

> Moreover specific processing has to be performed if both channels are use=
d.

Given that this case has to be supported anyway I'd be more inclined to
ask the question the other way around TBH.

--okqjiama34qumvis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljuSfYACgkQJNaLcl1U
h9BIYQf8DbaZhiVW3Tp/9AENsa/ntqfUnXdyokr8O9CNPL5ifBeRhJ9/kMNYX8D+
GWP9kO93yXpwthXlXqNWtNErv1BlZrw78dzyPNR+QhNw052QcSIgG+k5/7iKjT6T
bLw9AfIriDcE4kPNKzN4w0YpFqwJjhAMcsaIjnBYob/Su9uYfLnqEXniJqo4ebDZ
tsx8GAaeJ2TFbgxnW5RBrpstCENYdc8oNaPmRaK423bcbRXFWmA6IXwN8Il0EetH
TWvGE/c3pftOZF7M6Vj7Xtni/2aH62Ra8DE0jnhYtJ9VXRoos02FoipHsAe92rJN
rYNEPDNl3nzJPm3r6a1O2FnVtJPQVA==
=yXLf
-----END PGP SIGNATURE-----

--okqjiama34qumvis--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
