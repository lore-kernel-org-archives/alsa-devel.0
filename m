From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] Documentation: dt: bindings: sound: Add bindings
 file for CS35L32
Date: Thu, 31 Jul 2014 22:18:28 +0100
Message-ID: <20140731211828.GA17528@sirena.org.uk>
References: <1406664163-10506-1-git-send-email-brian.austin@cirrus.com>
 <1406664163-10506-2-git-send-email-brian.austin@cirrus.com>
 <20140731202149.GX17528@sirena.org.uk>
 <alpine.DEB.2.02.1407311528570.7394@heelrod>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dqE/FoYigEOc8GcK"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1407311528570.7394@heelrod>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--dqE/FoYigEOc8GcK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 31, 2014 at 03:40:51PM -0500, Brian Austin wrote:
> On Thu, 31 Jul 2014, Mark Brown wrote:
> > On Tue, Jul 29, 2014 at 03:02:43PM -0500, Brian Austin wrote:

> > > +  - cirrus,gain-manager : Audio-gain management when LEDs are active.
> > > +  0 = (Default) Automatically reduces audio volume once by 3 dB, only if needed
> > > +  to avoid thermal shutdown or current limiting the boost converter.
> > > +  If the condition persists, the CS35L32 examine s ILED_MNG and responds accordingly.
> > > +  Audio recovers to original volume automatically at the end of the LED event.
> > > +  1 = User controls volume (nonautomatic).

> > This looks like something that should be a runtime control.

> I thought so too but "They" assure me it is not.

They may be unfamiliar with upstream policies and standards!

--dqE/FoYigEOc8GcK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2rKgAAoJELSic+t+oim9X18P/2xvnJ+bJCrE2SdHp35RI2UZ
Cl4QWpDftdA1005jxT9HWQ6oGAGtW45rN6+KIYTIgHMPLlP43Jb4qNh9jcpL2Saz
9D21QeK44tyjgtKog16zDAhBNf93U5n41QBy+dlIz+hsMTZ+dF2SCInY+j1iPHkC
F4cRWl+Ub4lXwT+Meqz3QOldI6Qsb57za+JaFl+Wu7favkfSZ34bNS/weX9Jv13o
AxvWqGFV2LUiNh4SRtq0rWviF9NMxfswuqeArBgL9B/Z5WV6nKg4whPOhgUaLkjf
c6K35Q2r4j8BISCJ1+MRYbNiRir/LDu0YWJC9fTcpCSBaoMBgqG/3SHomAIlKeUV
NA5UsTmUXFmvu3vYyxUMfp58fWui2t/naAbbydEkE2TuiLJZH+QTFLbnC285afcv
/GQeWmlNMEFafM+XKLUWFBljmPlU/dXdmafxAuE/fjCoVS4jWi65la015JwbdPrx
Y6pRrGhyNn5h2cwSmiS37rS124osmtNeCjY+L1gWLpuewc1qWhno7wzbes9yjhDp
Uy89oPIThcodrPWO4XNNjZwcWx0rZjpVWHd8g+ebDTE3einM6nrWYOcqPdvAXh5G
Nmfglm/cLxu1Xc7g1N4jX7TZJSyjLgGTBqu4Kl7rW3ziPSxi/5Lv7GEzx0NLQuRm
Ly/zBglM8pzcgLWnBO9f
=3bdZ
-----END PGP SIGNATURE-----

--dqE/FoYigEOc8GcK--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
