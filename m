From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/2] ASoC: simple-card: add multi-CODECs in DT
Date: Sat, 8 Nov 2014 09:48:40 +0000
Message-ID: <20141108094840.GF2722@sirena.org.uk>
References: <cover.1415096705.git.moinejf@free.fr>
 <53ef077d2174f8eb5b861d6cebe7c9e732f06d52.1415096705.git.moinejf@free.fr>
 <20141107123035.GO8509@sirena.org.uk>
 <20141107200557.78971e08@armhf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fwqqG+mf3f7vyBCB"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141107200557.78971e08@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2014 at 08:05:57PM +0100, Jean-Francois Moine wrote:
> Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > >  	} else {
> > > -		clk =3D of_clk_get(args.np, 0);
> > > +		clk =3D of_clk_get((struct device_node *) dai_np, 0); =20

> > Adding this cast looks suspicous - why?  As far as I can tell the
> > original code didn't need one.

> Right, 'args.np' was (struct device_node *), but, now, 'dai_np' is
> (const struct device_node *).

> Changing 'dai_np' to (struct device_node *) in the
> asoc_simple_card_sub_parse_of() argument asks for a cast in calling
> this function because the field 'of_node' of the struct
> snd_soc_dai_link_component is (const struct device_node *).

> Do you better like this last cast?

No.  As Lars says having a cast in the first place is almost always a
sign that you're doing something wrong outside of passing things through
some of the generic callback interfaces.

--fwqqG+mf3f7vyBCB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXeb4AAoJECTWi3JdVIfQyroH/i6Dur3XODdDqSsqemJp6+bL
tDVJg+DiBMMyEl3O07VBBY/s7NsdVSn3tR+YesO4DeKEMJGVLTaTtSd9ePuypj6z
K//5pWI9hFL8Fu4GRcJlg6pAf6WTlkf25nbNj8QYKXyP8RMZB8ZfQGer3JBhsaG9
qFY+oNTNUqsoTV6/YoICCUzxgtfvmGoM7waW66/+sX4xRST2f6kxPNEs1vOVuT5z
ISNdVVVhRd+jeSUKSEDL9fkKIbMCiNHahxAg6tYag8jxXIEXvLKg/yfv7zA71m4x
+BgFioyq/mYxwvr0SnJO9QP6xJMhrh+NPduisalNG9U0eZNVwA//MoDTSDIGZHA=
=eQc6
-----END PGP SIGNATURE-----

--fwqqG+mf3f7vyBCB--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
