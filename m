From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] dt: binding: sound cs42l52 driver
Date: Wed, 13 Nov 2013 16:43:28 +0000
Message-ID: <20131113164328.GW878@sirena.org.uk>
References: <1384357474-28653-1-git-send-email-brian.austin@cirrus.com>
 <1384357474-28653-2-git-send-email-brian.austin@cirrus.com>
 <1485256.GGQxcSNhvH@flatron>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OFtM20PmL5gDcvsL"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1485256.GGQxcSNhvH@flatron>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--OFtM20PmL5gDcvsL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 13, 2013 at 05:33:30PM +0100, Tomasz Figa wrote:
> On Wednesday 13 of November 2013 09:44:34 Brian Austin wrote:

> > +  - reset-gpio : GPIO controller's phandle and the number
> > +		 of the GPIO used to reset the codec.

> As Kumar has already mentioned, all device-specific properties should be
> prefixed with vendor prefix, "cirrus," in this case.

The best practice on this one seems to vary somewhat randomly -
sometimes it's a requirement, sometimes it isn't.

> > +codec: cs42l52@4a {

> coding style: Node name should be generic, i.e. codec@4a.

Is this a constructive thing from a style point of view?  We're not
allowed to actually do anything useful with the value at runtime so
people may as well choose what they like.

--OFtM20PmL5gDcvsL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSg6wtAAoJELSic+t+oim9KiIP/0s+sKtMRvmx8zI9HPfIRhEN
oIw/w+9mA7x44Jfpp2VTwBowZ+TPKdhsUub72nWd00lIHCx81W7RX+Xp/yruAkUZ
y8dN6VaQHBQG3A9zTwYSFo/K9uJ89FCXcBzzB/cYkokkVL8e7NlAfhpAzFi89mdZ
LmR3NjVQ4lrR6ISXT8KEgJaSEcLc1sfQDna2WI6buF5GHRokgrEzra3UZ+LmsGFQ
UKZTJ6WpQ9srvBX+P36dJcGTgQouJK8aeHMPU5UHWkq6t0+MKMXqOg02yW7sCZR/
JngxbNQvnE3gqHVheFwA8/0Rmg5SWX8fwDH10zyzikjMnb5BxXHQAYpMcVvuu6nN
i+ulvqK89TfPNr95Qoem00AcZE2O1qKZQedcN3ELJXNiFSdncnKw/eAE2dB1ZvZc
cwk94wItd+j4ZsiJal9Vo8oNnTGrQyTtCm/yhc6RdZhxBxg/iU2ImHwxgXV5wxdK
Wa2oDxP0pa09W6sfJx4n6kMqgKBkk3FYD9QCSNqUrpxd9PgvAGU9sp6Ar+SYsgC3
KoIhC+icnIE1lOBqQc3L6QSI50Y0pF0kGtOMgLRwveTeMIsGP0ejtLgIzUvkPDo1
VkGq6A7BlwjhZS/+dunSkG6C965gXvOPi5XKMCZuAgPpezKtgUrVNJoyaFxSjnxx
tAb8wJ70uRTBBFD5NnrR
=7Ngf
-----END PGP SIGNATURE-----

--OFtM20PmL5gDcvsL--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
