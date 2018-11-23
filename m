From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/10] ASoC: soc-core: add
	snd_soc_of_parse_node_prefix()
Date: Fri, 23 Nov 2018 13:53:13 +0000
Message-ID: <20181123135313.GH2089@sirena.org.uk>
References: <871s7endnu.wl-kuninori.morimoto.gx@renesas.com>
 <87zhu2lz26.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3886597822658132010=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 59D732677E8
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 14:53:20 +0100 (CET)
In-Reply-To: <87zhu2lz26.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============3886597822658132010==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EiqC2rRjhiyODL92"
Content-Disposition: inline


--EiqC2rRjhiyODL92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2018 at 12:55:09AM +0000, Kuninori Morimoto wrote:

> +void snd_soc_of_parse_node_prefix(struct device_node *np,
>  				   struct snd_soc_codec_conf *codec_conf,
>  				   struct device_node *of_node,
>  				   const char *propname);
> +#define snd_soc_of_parse_audio_prefix(card, conf, node, name) \
> +	snd_soc_of_parse_node_prefix((card)->dev->of_node,    \
> +				     (conf), (node), (name))

This is basically fine but it'd be better to make this a static inline
rather than a #define - it helps with error messages and type safety.
I'll apply the series since otherwise this looks good, please send a
followup patch fixing this.

> +
>  int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
>  				   const char *propname);
>  unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 6ddcf12..012000d 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -3484,12 +3484,11 @@ int snd_soc_of_parse_tdm_slot(struct device_node =
*np,
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_of_parse_tdm_slot);
> =20
> -void snd_soc_of_parse_audio_prefix(struct snd_soc_card *card,
> -				   struct snd_soc_codec_conf *codec_conf,
> -				   struct device_node *of_node,
> -				   const char *propname)
> +void snd_soc_of_parse_node_prefix(struct device_node *np,
> +				  struct snd_soc_codec_conf *codec_conf,
> +				  struct device_node *of_node,
> +				  const char *propname)
>  {
> -	struct device_node *np =3D card->dev->of_node;
>  	const char *str;
>  	int ret;
> =20
> @@ -3502,7 +3501,7 @@ void snd_soc_of_parse_audio_prefix(struct snd_soc_c=
ard *card,
>  	codec_conf->of_node	=3D of_node;
>  	codec_conf->name_prefix	=3D str;
>  }
> -EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_prefix);
> +EXPORT_SYMBOL_GPL(snd_soc_of_parse_node_prefix);
> =20
>  int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
>  				   const char *propname)
> --=20
> 2.7.4
>=20

--EiqC2rRjhiyODL92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv4BkgACgkQJNaLcl1U
h9AwYQf/eXynb6X4LoH1/rEc4lWGDwyYPKfLnpXnMhlzgDCr35nBOQpVgbikRon/
5+VJnZeK75bxFwSF1CGb6JyBy9KQvaGUNsHhiFtkB5yiIWoB/L0fr3ce42njDmZK
cAivRkx93QXaoo7k6NXAbC2eanva7+d5XlcNnuDj33Z7qa3S2p4YAg7GE5XdoZPE
uZoOUbNBslB6NemLdd9jEU8X/RtKRFwoSq0n1KPVdZHKmFE7CwAjSANnFdl66aXv
xWteebw48kTozOL3J3fAwd9waHpBjGnC1DkW3daOPlsV1+NPW8OCYtfjj7JFAg47
rlGAXUuY7RRr36OlbzTZgObbjUY0MA==
=IeKV
-----END PGP SIGNATURE-----

--EiqC2rRjhiyODL92--

--===============3886597822658132010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3886597822658132010==--
