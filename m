From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V6] ASoC: pcm179x: Add support for pcm1795 and pcm1796
Date: Mon, 14 Mar 2016 16:24:09 +0000
Message-ID: <20160314162409.GB2566@sirena.org.uk>
References: <1452382685-18009-4-git-send-email-michael@amarulasolutions.com>
 <20160110120045.GW6588@sirena.org.uk>
 <20160110173812.GA16304@panicking>
 <20160205172451.GA30542@panicking>
 <20160222031944.GT18327@sirena.org.uk>
 <20160311225937.GA27257@panicking>
 <20160311230930.GB27257@panicking>
 <20160311232856.GC27257@panicking>
 <20160312055317.GT3898@sirena.org.uk>
 <20160313085346.GA8896@panicking>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160313085346.GA8896@panicking>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jacob Siverskog <jacob-EZCvousvhKUZux3j3Bed6dkegs52MxvZ@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, adamo.a60-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 13, 2016 at 09:53:50AM +0100, Michael Trimarchi wrote:
> On Sat, Mar 12, 2016 at 12:53:17PM +0700, Mark Brown wrote:
> > On Sat, Mar 12, 2016 at 12:29:00AM +0100, Michael Trimarchi wrote:

> > I don't actually know if MODULE_DEVICE_TABLE can reference an object in
> > a different file off the top of my head, though a brief test suggests it
> > has issues.

> Does this approch can work?

I'd suggest testing...

> > It would be more data driven to just register a different DAI structure
> > for the 1795.  Both approaches work, it's just a little nicer to avoid
> > code where possible.

> Yes I know but my idea was exactly to not create special DAI because
> technically they are the same code with diffferent constraints. This even
> give an other example of the usage of the API.

They would still share all the same code, it's just moving the decision
to probe time given that this is a trivial constraint change and the
constraints are listed in the data structure.

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW5uWoAAoJECTWi3JdVIfQ4OkH+wWiHwTfGzCf3XA1X35HMIn5
GPp/KYMo3/8iFu8uiPdVVS1HjMLeJJg9QCFq0FNgHZxY7i3ajlHyc3kMIaFnPW58
pIZQO+JfWxFRr80nu4PP2MRy5h7zAEZeP9i6lu+R4g3vJEDT1IiN4bzZOe2a3+1v
7420ev2+Y3W4jvxPIKZ8KXoka9AaFDTqThq+KPwYf2CnNjgy0pknGxbp2VX2qsXY
hisliXflbY4VEOzUipUGkNSNeGOH0ZdP3KyRxGmGA22hW5yBxrgYb5KNvbZNeRl6
oqoUcIMzXBGpg7H8qv6uJjALpZaJjOcgCFI5pOr1Npoy7t19yeCtZD6DnlF9og4=
=boKN
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
