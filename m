From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Fix NULL pointer dereference in
 snd_soc_dapm_new_dai
Date: Thu, 21 Mar 2019 12:31:56 +0000
Message-ID: <20190321123156.GB5684@sirena.org.uk>
References: <1553163085-16845-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553163085-16845-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 21, 2019 at 03:41:25PM +0530, Pankaj Bharadiya wrote:

>  outfree_kcontrol_news:
>  	devm_kfree(card->dev, (void *)template.kcontrol_news);
> -	snd_soc_dapm_free_kcontrol(card, &private_value,
> -				   rtd->dai_link->num_params, w_param_text);
> +	if (w_param_text)
> +		snd_soc_dapm_free_kcontrol(card, &private_value,
> +				rtd->dai_link->num_params, w_param_text);

This is very non-obvious - it's not at all clear why we'd need the text
to free controls.  If there is an issue here it seems like it'd be
better to make sure that snd_soc_dapm_free_kcontrol() can cope with that
being NULL, that will be clearer and also avoid potential issues with
other callers.

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyThDsACgkQJNaLcl1U
h9B7MAf/aI4rdoOjE8VyQHKfBX2aHB87qkmKc68mZWOkQcDzuxO4u9EdmdgIlqcO
HrcViAczXi+oE1U1tqXJKoW8F+vgEsVTr35axy7sfoeZB5IhjVRDNoJTYT0ypj65
vqjd4Ul3LeXnOraDU0dujGtA/TSiPoXu9IBkxsw6qymeWBvEuFi4GmWvN09jMulE
hQSUZ8wmp9eNfWb8h9xLNagEDmJFjDAhVBF8hz4yWvOu9P1F0ypiWrpPVbUeR50z
ZXpjCs6cMpaQx0wmTO9IyGAjiaxFCSuHswTOit912mhDxfnsW8OrTtILDWeM18+z
KVJzMUh10RKGcPowirNRvHGKBQbA2g==
=J0ZG
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
