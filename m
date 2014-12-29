From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 3/4] ASoC: simple-card: add multi-CODECs in DT
Date: Mon, 29 Dec 2014 16:30:04 +0000
Message-ID: <20141229163004.GY17800@sirena.org.uk>
References: <cover.1416918909.git.moinejf@free.fr>
 <e6673d036e848dd3d3eb19617f3a1a2c6c5c2d5d.1416918909.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hcIbdsWGSbvvNW1J"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e6673d036e848dd3d3eb19617f3a1a2c6c5c2d5d.1416918909.git.moinejf-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--hcIbdsWGSbvvNW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2014 at 01:30:14PM +0100, Jean-Francois Moine wrote:

> This patch allows many CODECs per link to be defined in the device tree.

It's also quite big and fiddly and hard to read, the changes that are
being made aren't blindingly obvious and there's quite a few of them.
As I've said before it's really importat that changes are clear and easy
to read, if the code is complex or surprising then the changelog needs
to be that bit more detailed to make thigs clear.  Things like talking
about why the code is being moved out and how it is being transformed
would be really helpful with this one, it's not enough to know the
overall goal of the patch, I also need to know how the patch is intended
to achieve that.

I think this is mostly OK but a couple of things...

> -Example 2 - many DAI links:
> +Example 2 - many DAI links and multi-CODECs:

I'd be much happier with a new example here rather than modifying the
old one.

> @@ -365,8 +359,18 @@ static int asoc_simple_card_dai_link_of(struct devic=
e_node *node,
>  	 */
>  	if (!cpu_args)
>  		dai_link->cpu_dai_name =3D NULL;
> +	goto out;
> =20
>  dai_link_of_err:

This goto out thing here is messy, it's not our normal coding style and
is error prone - better to just duplicate a small amount of cleanup.

> +	for (i =3D 0, component =3D dai_link->codecs;
> +	     i < dai_link->num_codecs;
> +	     i++, component++) {
> +		if (!component->of_node)
> +			break;

What's this break doing here, why might we be missing a node and why
should we skip all remaining components rather than just this one as a
result - a continue would be less surprising.

--hcIbdsWGSbvvNW1J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUoYGLAAoJECTWi3JdVIfQ8hIH/RyQZE5swo/NYMfEg/wfoAfP
szgMsI68C1+d/GoaVkkF7ncM4AUmQtwZK7cfZUFuIDLZ6KWevAbupIZTSUdCpoda
MQh5VrOQreISrcjt5cVDNdbkFCSALOR7u/aWmC/IIJ76pmMXktinGByYklWplxor
GzrJZBH7vAEo94gG2w2LZrKuD16HaVhYOnmzoj5CsmheY9ZhlVUJyoysI/uO57BM
GVx85aUVyVs3af9HzBHDTv+uFKdJV5cgRa045jjsfUH91Ax1SGVYE/WUuD5rXw7r
JGr743XzB8kZbAH3S3lFADtbT6nqw9d+UY1PdTXXQj/NRL/7hbIpKgbFtmW3JTE=
=kpZo
-----END PGP SIGNATURE-----

--hcIbdsWGSbvvNW1J--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
