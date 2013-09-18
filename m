From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 05/11] ASoC: davinci-mcasp: Remove
 interrupt property from DT bindings doc
Date: Wed, 18 Sep 2013 15:46:35 +0100
Message-ID: <20130918144635.GT21013@sirena.org.uk>
References: <cover.1379409268.git.jsarha@ti.com>
 <1b47734e397bfac8846dcfc194fd1ab63f320d1a.1379409268.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m+1hRa/9CwYN9i9M"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1b47734e397bfac8846dcfc194fd1ab63f320d1a.1379409268.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jsarha-l0cyMroinI0@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--m+1hRa/9CwYN9i9M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2013 at 12:26:04PM +0300, jsarha-l0cyMroinI0@public.gmane.org wrote:
> From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
>=20
> Davinci McASP driver does use interrupts for anything ATM.

How about moving these to optional instead of removing them completely
(or just leaving them alone)?  That way if the driver does want to start
using them people will have hooked them up already so no updates will be
required.

--m+1hRa/9CwYN9i9M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSObzIAAoJELSic+t+oim9aAUQAIyhKTdSnuLHkBBe48JPhUMj
d5XCKQf/cvxwx9u/OEHL78JF2Q0EnFh1Y4I6adwHgugLPRRlCFI0mSp9KhqGmZLX
z1zrM303wdX+7iDZxWjjq44OvkCFPjypaJ8CF6J8NsElwzGis3WTnDTwFpy+OtFB
ISzsWBHvuwZIA9j7mdtc9NNUw2xPn49IwY6WlySScBssMjdkuGBWFDmZ/5uxMnCa
vR8LxZrW3PB6AK4iE78tdTpxnSe839XfAxVa0nVLLvRisI9dWXC1mAZ+U8fnruqF
pP/cDD8EBhmfMNqFeCXpLXuFTWRgDE90+So3JoRR0Zv+xue0HpjHcADJO8ndR7mS
rzaHXI/+MJsBg63OHUn+qH8ko6tnDv6VC/cqApq6KkuY0u9XMCHKY9O/nLhEVg/0
ZTjPaMFTJ6N5ZpkOCbjwl5vI50aGOigNZ/ZJw6SYPj0o+/SFhVVqmmEL1WwkLVlC
zXO6OvhrO5tT5ftzdjD6vBFTgrVQ0KV2+Kd2YnHze2CTBuk/yxhUqeQRogLZilOc
kgrdT+If7u0DbdUZDmTtjGQQqR0tTQM/RgkRGWIMqE7+ttD9QbU/aBR4BvZ5Rp/N
tXf8gh6WWWyWtVGgZ8Wd9Sq6BnTHRLpcpwwieu1R/vPJeRoOyPu17bNSHyQxTLoS
T/JBjCJlejYCfmXuwsN1
=Nlus
-----END PGP SIGNATURE-----

--m+1hRa/9CwYN9i9M--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
