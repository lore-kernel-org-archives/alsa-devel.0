From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/2] ASoC: simple-card: add multi-CODECs in DT
Date: Fri, 7 Nov 2014 12:30:35 +0000
Message-ID: <20141107123035.GO8509@sirena.org.uk>
References: <cover.1415096705.git.moinejf@free.fr>
 <53ef077d2174f8eb5b861d6cebe7c9e732f06d52.1415096705.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="prA7fRZJHz3WLy0C"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53ef077d2174f8eb5b861d6cebe7c9e732f06d52.1415096705.git.moinejf-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--prA7fRZJHz3WLy0C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2014 at 11:21:46AM +0100, Jean-Francois Moine wrote:

This looks like it combines some refactoring to split out some of the
DAI node parsing code with some new code.  It's quite hard to read
what's going on here, separating the code motion and the new code would
make life a lot easier, I've stared at it for a bit and I'm still not
100% sure it's doing everything it's supposed to be.

> -Example 2 - many DAI links:
> +Example 2 - many DAI links and multi-CODECs:

This would be a lot easier to read if the change didn't completely
rewrite the example but just added the thing it wants to add an example
of; the example may be drawn from a real system but that's not the
point.

>  	} else {
> -		clk = of_clk_get(args.np, 0);
> +		clk = of_clk_get((struct device_node *) dai_np, 0);

Adding this cast looks suspicous - why?  As far as I can tell the
original code didn't need one.

--prA7fRZJHz3WLy0C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXLtrAAoJECTWi3JdVIfQhEIH/2T4LeTlBVD8EDgJ240x41T/
bRAAWYQ5Hb9/qA9dbRoXxFZmIp+dTtNk5EYarcZgdqnO+9/Y2MtBN8QEaeHWPULS
aq6uCaYt+jIj+iBh9eQVHSoi7bDHKcZH7uQevuYxmC+C126Kxted0VuCj3TQ2qSj
XJWuwVtGsDtG5IY6NCM5UNBXqnwFVYRPMC7/q7QHB5s+CKDFD0EcGOKFlhAGBdJh
em6aeWdXky9IYAFct7muYud+Hupx7KLtWFKek2ZzWBGIA3q8rK1lMad5uE6moM5d
/XyzxrTrgCiYhVVwHUg95lZ2vqJIoS3MF2lBoN6/5W1F1TgtPs+SnBOUBh15q70=
=6+eE
-----END PGP SIGNATURE-----

--prA7fRZJHz3WLy0C--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
