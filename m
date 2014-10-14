From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] audio: sgtl5000: Add MicBias voltage support
Date: Tue, 14 Oct 2014 10:03:21 +0200
Message-ID: <20141014080321.GP27755@sirena.org.uk>
References: <1413268992-15248-1-git-send-email-jean-michel.hautbois@vodalys.com>
 <1413268992-15248-3-git-send-email-jean-michel.hautbois@vodalys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mLgg01LDEvurRz8s"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1413268992-15248-3-git-send-email-jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
Cc: fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--mLgg01LDEvurRz8s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 14, 2014 at 08:43:12AM +0200, Jean-Michel Hautbois wrote:
> Some systems may require to specify a bias different than default (1.25V).
> This adds a property in sgtl5000 codec.
> The property is specified in milli-volts so that it is coherent with datasheet.

Applied, thanks.

--mLgg01LDEvurRz8s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUPNjIAAoJECTWi3JdVIfQwGEH/R5skLp6jnXyYFpx3yHTgPwT
eE32hUC6/q0doJaYBEMk0p22iH6F9cavE5pKkfVz+GLhapWTpHRAgHI5TWgMLSkq
pHsQcuYs3c/R3ul9K0AKWyuN/86L5F1CneGhYy3h4Gz9+dD/uJ0y27HslUWio21g
WPAqnA+Zvv1I2VPr4ntRPDq6yQ2Fm8DYrh6oACr8o4xEmFKjGSWU5+rYpmPaALDz
Zh/Sbs3HumNGWy65wWA5/loMrQrZRwx1RVeiJ7ZhINUeibbQf54ufrxYhdkjGHPj
T742csnNBcBlKh4aDU7wmmaiGJkqlpum1vCpPS9GrRAsU57aLvvVKJYd+QfdUXA=
=AMbR
-----END PGP SIGNATURE-----

--mLgg01LDEvurRz8s--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
