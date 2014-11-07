From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/2] ASoC: core: add multi-codec support in DT
Date: Fri, 7 Nov 2014 14:01:44 +0000
Message-ID: <20141107140144.GP8509@sirena.org.uk>
References: <cover.1415096705.git.moinejf@free.fr>
 <6b04d690576a0036b401d00784299ee576051c0d.1415096705.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M/v0iXgzSsdULkoO"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6b04d690576a0036b401d00784299ee576051c0d.1415096705.git.moinejf-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--M/v0iXgzSsdULkoO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 03, 2014 at 06:42:22PM +0100, Jean-Francois Moine wrote:
> SoC audio cards may have many CODECs per audio link.
> This patch exports a core function to handle such links
> when they are described in the DT.

It would be a lot easier to review this change if the changelog said
what the description this was intended to parse looks like...

> +int snd_soc_of_get_dai_link_codecs(struct device_node *of_node,
> +				   const char *list_name,
> +				   struct snd_soc_dai_link *dai_link)

This is a newly exported function, please add kerneldoc for it.

> +{
> +	struct of_phandle_args args;
> +	struct snd_soc_dai_link_component *component;
> +	int index, ret;
> +
> +	for (index = 0, component = dai_link->codecs;
> +	     index < dai_link->num_codecs;
> +	     index++, component++) {
> +		ret = of_parse_phandle_with_args(of_node, list_name,
> +						 "#sound-dai-cells",
> +						  index, &args);
> +		if (ret)
> +			goto err;
> +		component->of_node = args.np;
> +		ret = snd_soc_get_dai_name(&args, &component->dai_name);
> +		if (ret < 0)
> +			goto err;
> +	}

We're relying on the caller to fill in the number of CODECs and not
checking that there aren't extra things in the list in the DT that we're
ignoring.  I'd expect us to either get the number of CODECs as part of
this function or check that there isn't anything extra in the list.

I'd also expect some sort of error message on parse failures to help
people writing DTs.

--M/v0iXgzSsdULkoO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXNDDAAoJECTWi3JdVIfQJc8H/0oQIR8eiPTFqOtaOP6Yu/tB
etczqnmgawu5snijpNS4ujdUxqXtexy4ZBMxYA/aIXcefnSStC4CZPB5sMuYXJAT
Fd3xYy9M29CYQIkpYOXXuBZHqJlli197k+ZDLs4ncmlY1oZve5BiLZMbpUqfUYyu
pQiadiB0/FbMkuq0pjhetfShS6JWB2mMrCqloyLYjDMlSjm5tkHZCbvajGs+HM7a
WDWCJGYy4tbv702TCBZY4EEF7JBAHArKgFnrHn2mW3xwiyHZewlJnurr/SZ11T6f
dOjJyTmN27fBiDQ1IoNnLjGHkde4oAt4yvGOsTAKp6QcxrqT1VTfjAH2xcJjhUY=
=ZXod
-----END PGP SIGNATURE-----

--M/v0iXgzSsdULkoO--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
