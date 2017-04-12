From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: Document STM32 I2S bindings
Date: Wed, 12 Apr 2017 12:32:51 +0100
Message-ID: <20170412113251.nfyk5sw6c5pnpmwr@sirena.org.uk>
References: <1491493236-2574-1-git-send-email-olivier.moysan@st.com>
 <1491493236-2574-2-git-send-email-olivier.moysan@st.com>
 <20170410194832.iivnkyejtywbe2c7@rob-hp-laptop>
 <20170411143250.3r7ys3rjshtxgaee@sirena.org.uk>
 <73caede5-ea6f-8b2b-2270-227f7ef31823@st.com>
 <20170411211040.htrcedus3c57fbed@sirena.org.uk>
 <86a179ad-7961-18f7-8050-25e0e584c77d@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6ximvfxq4qysdbn7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <86a179ad-7961-18f7-8050-25e0e584c77d-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olivier MOYSAN <olivier.moysan-qxv4g6HH51o@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "tiwai-IBi9RG/b67k@public.gmane.org" <tiwai-IBi9RG/b67k@public.gmane.org>, "mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Arnaud POULIQUEN <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Benjamin GAIGNARD <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--6ximvfxq4qysdbn7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2017 at 08:30:31AM +0000, Olivier MOYSAN wrote:
> On 04/11/2017 11:10 PM, Mark Brown wrote:

> > That sounds wrong, I'd expect this wiring to be done statically as part
> > of the .dtsi for the SoC (or just grabbed as needed at runtime if
> > things are flexbile enough) rather than being a configuration thing done
> > per board...  I had thought that this was configuration reflecting
> > different ways of taping out the IP with different feature sets, is that
> > not the case?

> This configuration is board dependent. The IP may be used as rx, tx or=20
> fd depending on board. So I think it can make sense to have a DMA=20
> configuration linked to board, and to set IP mode accordingly.

It is totally normal to just not use one direction in a given system, we
don't normally need to do anything special to handle things.  I'm a bit
confused as to what's different here and needs configuring?

--6ximvfxq4qysdbn7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljuEGIACgkQJNaLcl1U
h9BYhAf/V3/RzbH8OBgoke2AwV7ao3JnjAcUJrFULd/Pca1N4JRTwDU7FExysT00
EfRNADMZmjf3MhEAD1BsUJ3oR+ps3HaieMZIIy4c8bVurLAIGNnlt/T/TWck6aDq
JbuGIWDjOrp+9s2vzEMZnEute062A9fsXXYL/gOC18JPRrg0JvlHraKzuF2QSXku
ZhBkJX2TG/v6bLx2/8Qq1Y4W2zwGnOavTgKHkHOrUCyCpHKDjbF4gYr76yPfUej9
K4T6tnnvORnwBZRr3efc0ub2H1jYz1PGrS1zvCPWYo8vnuMJskU177xep0H2tQ3V
3BFOuTt8MVL153MS+mNkWzQemLSCkQ==
=+jfQ
-----END PGP SIGNATURE-----

--6ximvfxq4qysdbn7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
