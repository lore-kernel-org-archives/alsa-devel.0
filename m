From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 05/11] ASoC: davinci-mcasp: Remove
 interrupt property from DT bindings doc
Date: Wed, 18 Sep 2013 16:07:28 +0100
Message-ID: <20130918150728.GZ21013@sirena.org.uk>
References: <cover.1379409268.git.jsarha@ti.com>
 <1b47734e397bfac8846dcfc194fd1ab63f320d1a.1379409268.git.jsarha@ti.com>
 <20130918144635.GT21013@sirena.org.uk>
 <5239BD42.2060903@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fIj/D6Y6BN1okdX1"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5239BD42.2060903-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: jsarha-l0cyMroinI0@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--fIj/D6Y6BN1okdX1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 18, 2013 at 09:48:34AM -0500, Nishanth Menon wrote:
> On 09/18/2013 09:46 AM, Mark Brown wrote:

> > How about moving these to optional instead of removing them completely
> > (or just leaving them alone)?  That way if the driver does want to start
> > using them people will have hooked them up already so no updates will be
> > required.

> the definitions as they stand now make no sense as the ordering of the
> interrupts are undefined - example is the first index RX or TX? the
> alternative will be PIO McASP driver, which might be nice, but having
> a vague binding with 0 code behind is of no use for anyone right?

So the sensible fix seems to be to specify the order rather than remove
them then...

--fIj/D6Y6BN1okdX1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOcGtAAoJELSic+t+oim9TEEQAJlPqcW1mTBIWz5009R+fD/m
KuzRA2Q2VaJBnNZc/BUE7bi72oGW0DceftBfjkopWQ3YRHunkO31mXW3ZGmLJazn
9Djphs6n3u31ZsWbfzcO25AIPIwvaaH1DMi/S+fXbgpgHcJ/QrsZz+N9nJhsQJru
ywTzduuNMDhjq30LagB4EnENR4F0ZNIqR6rTsThBMlRYtLhBRefRBBp05ityLg1d
zh6rb/nx9f0KW/FTXyPQstVn3QBNoTePqS/1LAfC3+6rCeu8xe1QtLC9VoF4O4bc
ciTgUHNLFy6Ff+3aX9i+Znud0w2O9t+r91eeal+SFlclcNIMlgzorDRj3+ayMfbl
E+CSA7cHAW9WpWOzp5YRmkhF9TgrnQGHTkwWF+Gqvza46YlV4NvYqtbhv7gqNyCZ
tqj7w2jb1lXBprpmNjoS5+c6ippdv4/vVmIBJWoOwsKxVol5wi59CEc/dO+izIWK
Lbxg7JN+QJ35cYjvw6DD+0apqE4ypheDdx4/MzFFUeZsd+fCYvAJBZomettd689l
6yM0afvWPSIP9niS3UH3nK7vNyr+Yevkv37RYkwLlOkzML2/w0sf4nSZ+3Rv8hDD
uVT7MaI+gWM+cIgPREsLFqo9KmqoBh9jMX2H9Zr7pRlkOei7CrY8RUT7Ct+Aaz1P
cbuSkYKPAL/XJ3qAxhTC
=q1OH
-----END PGP SIGNATURE-----

--fIj/D6Y6BN1okdX1--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
