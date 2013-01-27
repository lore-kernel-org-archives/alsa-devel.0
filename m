From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [RFC][PATCH 2/2 v2] ASoC: simple-card: add Device Tree support
Date: Sun, 27 Jan 2013 11:59:55 +0800
Message-ID: <20130127035943.GJ4650@opensource.wolfsonmicro.com>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>
 <87sj6t484z.wl%kuninori.morimoto.gx@renesas.com>
 <50E71618.8090302@wwwdotorg.org>
 <20130104193712.GN4627@opensource.wolfsonmicro.com>
 <87y5fvyy18.wl%kuninori.morimoto.gx@renesas.com>
 <87vcazyxr1.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0713883532007064530=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <87vcazyxr1.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--===============0713883532007064530==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="utPK4TBebyzZxMrE"
Content-Disposition: inline


--utPK4TBebyzZxMrE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2013 at 06:40:37PM -0800, Kuninori Morimoto wrote:

Sorry about the delay in getting back to you on this.

> +- simple-audio,cpu,dai,clock-gating		: if needed, see below

A lot of these are listed as "if needed" - this means they should be
listed separately as optional properties rather than in the required
properties section.

> +- simple-audio,codec,controller			: phandle for CODEC DAI

It feels like this should just be simple-audio,codec - the controller is
just redudnant.  Though for idiomatic DT we ought to write something
like

	simple-audio,codec {
		simple-audio,dev =3D &phandle;
		simple-audio,system-clock-frequency =3D 122880000;
	};

rather than have these very long prefixes to the individual property
names.

> +- simple-audio,codec,dai,name			: simple-audio CODEC DAI name
> +- simple-audio,codec,dai,format			: see below
> +- simple-audio,codec,dai,clock-gating		: if needed, see below
> +- simple-audio,codec,dai,bitclock-inversion	: if needed
> +- simple-audio,codec,dai,bitclock-master	: if needed
> +- simple-audio,codec,dai,frame-inversion	: if needed
> +- simple-audio,codec,dai,frame-master		: if needed
> +- simple-audio,codec,dai,system-clock-frequency	: system clock rate if n=
eeded

I'm also thinking that for some of the above properties which really
should be the same for both ends of the link we should just specify
them at the card levle and copy them over.  The format and inversion=20
mainly.

> +
> +simple-audio,xxx,dai,format
> +	"i2s"
> +	"right_j"
> +	"left_j"
> +	"dsp_a"
> +	"dsp_b"
> +	"ac97"
> +	"pdm"
> +	"msb"
> +	"lsb"
> +
> +simple-audio,xxx,dai,clock-gating
> +	"continuous"
> +	"gated"
> +
> +Example:
> +
> +fsi_ak4642 {
> +	compatible =3D "simple-audio";
> +
> +	simple-audio,card-name =3D "FSI2A-AK4648";
> +	simple-audio,platform,controller =3D <&sh_fsi2>;
> +
> +	simple-audio,cpu,dai,name =3D "fsia-dai";
> +	simple-audio,cpu,dai,format =3D "left_j";
> +
> +	simple-audio,codec,controller =3D <&ak4648>;
> +	simple-audio,codec,dai,name =3D "ak4642-hifi";
> +	simple-audio,codec,dai,format =3D "left_j";
> +	simple-audio,codec,dai,bitclock-master;
> +	simple-audio,codec,dai,frame-master;
> +	simple-audio,codec,dai,system-clock-frequency =3D <11289600>;
> +};
> +
> +&i2c0 {
> +	ak4648: ak4648@0x12 {
> +		compatible =3D "asahi-kasei,ak4648";
> +		reg =3D <0x12>;
> +	};
> +};
> +
> +sh_fsi2: sh_fsi2@0xec230000 {
> +	compatible =3D "renesas,sh_fsi2";
> +	reg =3D <0xec230000 0x400>;
> +	interrupt-parent =3D <&gic>;
> +	interrupts =3D <0 146 0x4>;
> +};
> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-c=
ard.c
> index 6cf8355..72dd8ae 100644
> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -9,6 +9,7 @@
>   * published by the Free Software Foundation.
>   */
> =20
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <sound/simple_card.h>
> @@ -52,11 +53,99 @@ static int asoc_simple_card_dai_init(struct snd_soc_p=
cm_runtime *rtd)
>  	return 0;
>  }
> =20
> +static struct device_node*
> +__asoc_simple_card_parse_of(struct device_node *np,
> +			    const char *node_name1,
> +			    const char *node_name2,
> +			    const char **interface,
> +			    struct asoc_simple_dai *dai)
> +{
> +	struct device_node *node;
> +	char prop[128];
> +
> +	/* node or name is required */
> +	snprintf(prop, sizeof(prop),
> +		 "simple-audio,%s,controller", node_name1);
> +	node =3D of_parse_phandle(np, prop, 0);
> +	if (node)
> +		of_node_put(node);
> +
> +	/* get "simple-audio,xxx,yyy,name =3D xxx" */
> +	snprintf(prop, sizeof(prop),
> +		 "simple-audio,%s%s,name", node_name1, node_name2);
> +	of_property_read_string(np, prop, interface);
> +
> +	if (dai) {
> +		/* get "simple-audio,xxx,yyy,formart =3D xxx" */
> +		snprintf(prop, sizeof(prop),
> +			 "simple-audio,%s%s,", node_name1, node_name2);
> +		dai->fmt =3D snd_soc_of_parse_daifmt(np, prop);
> +
> +		/* get "simple-audio,xxx,yyy,system-clock-frequency =3D <xxx>" */
> +		snprintf(prop, sizeof(prop),
> +			 "simple-audio,%s%s,system-clock-frequency",
> +			 node_name1, node_name2);
> +		of_property_read_u32(np, prop, &dai->sysclk);
> +	}
> +
> +	return node;
> +}
> +
> +static void asoc_simple_card_parse_of(struct device_node *np,
> +				      struct asoc_simple_card_info *info,
> +				      struct device *dev,
> +				      struct device_node **of_cpu,
> +				      struct device_node **of_codec,
> +				      struct device_node **of_platform)
> +{
> +	of_property_read_string(np, "simple-audio,card-name", &info->card);
> +	info->name =3D info->card;
> +
> +	*of_cpu =3D __asoc_simple_card_parse_of(
> +		np, "cpu", ",dai", &info->cpu_dai.name, &info->cpu_dai);
> +	*of_codec =3D __asoc_simple_card_parse_of(
> +		np, "codec", ",dai", &info->codec_dai.name, &info->codec_dai);
> +	*of_platform =3D __asoc_simple_card_parse_of(
> +		np, "platform", "", &info->platform, NULL);
> +
> +	dev_dbg(dev, "card-name  : %s\n", info->card);
> +	dev_dbg(dev, "cpu info   : %s / %x / %d / %p\n",
> +		info->cpu_dai.name,
> +		info->cpu_dai.fmt,
> +		info->cpu_dai.sysclk,
> +		*of_cpu);
> +	dev_dbg(dev, "codec_info : %s / %x / %d / %p\n",
> +		info->codec_dai.name,
> +		info->codec_dai.fmt,
> +		info->codec_dai.sysclk,
> +		*of_codec);
> +	dev_dbg(dev, "platform_info : %s / %p\n",
> +		info->platform,
> +		*of_platform);
> +}
> +
>  static int asoc_simple_card_probe(struct platform_device *pdev)
>  {
> -	struct asoc_simple_card_info *cinfo =3D pdev->dev.platform_data;
> +	struct asoc_simple_card_info *cinfo;
> +	struct device_node *np =3D pdev->dev.of_node;
> +	struct device_node *of_cpu, *of_codec, *of_platform;
>  	struct device *dev =3D &pdev->dev;
> =20
> +	cinfo		=3D NULL;
> +	of_cpu		=3D NULL;
> +	of_codec	=3D NULL;
> +	of_platform	=3D NULL;
> +	if (np && of_device_is_available(np)) {
> +		cinfo =3D devm_kzalloc(dev, sizeof(*cinfo), GFP_KERNEL);
> +		if (cinfo)
> +			asoc_simple_card_parse_of(np, cinfo, dev,
> +						  &of_cpu,
> +						  &of_codec,
> +						  &of_platform);
> +	} else {
> +		cinfo =3D pdev->dev.platform_data;
> +	}
> +
>  	if (!cinfo) {
>  		dev_err(dev, "no info for asoc-simple-card\n");
>  		return -EINVAL;
> @@ -64,10 +153,10 @@ static int asoc_simple_card_probe(struct platform_de=
vice *pdev)
> =20
>  	if (!cinfo->name	||
>  	    !cinfo->card	||
> -	    !cinfo->codec	||
> -	    !cinfo->platform	||
> -	    !cinfo->cpu_dai.name ||
> -	    !cinfo->codec_dai.name) {
> +	    !cinfo->codec_dai.name	||
> +	    !(cinfo->codec		|| of_codec)	||
> +	    !(cinfo->platform		|| of_platform)	||
> +	    !(cinfo->cpu_dai.name	|| of_cpu)) {
>  		dev_err(dev, "insufficient asoc_simple_card_info settings\n");
>  		return -EINVAL;
>  	}
> @@ -81,6 +170,9 @@ static int asoc_simple_card_probe(struct platform_devi=
ce *pdev)
>  	cinfo->snd_link.platform_name	=3D cinfo->platform;
>  	cinfo->snd_link.codec_name	=3D cinfo->codec;
>  	cinfo->snd_link.codec_dai_name	=3D cinfo->codec_dai.name;
> +	cinfo->snd_link.cpu_of_node	=3D of_cpu;
> +	cinfo->snd_link.codec_of_node	=3D of_codec;
> +	cinfo->snd_link.platform_of_node =3D of_platform;
>  	cinfo->snd_link.init		=3D asoc_simple_card_dai_init;
> =20
>  	/*
> @@ -102,9 +194,15 @@ static int asoc_simple_card_remove(struct platform_d=
evice *pdev)
>  	return snd_soc_unregister_card(&cinfo->snd_card);
>  }
> =20
> +static const struct of_device_id asoc_simple_of_match[] =3D {
> +	{ .compatible =3D "simple-audio", },
> +	{},
> +};
> +
>  static struct platform_driver asoc_simple_card =3D {
>  	.driver =3D {
>  		.name	=3D "asoc-simple-card",
> +		.of_match_table =3D asoc_simple_of_match,
>  	},
>  	.probe		=3D asoc_simple_card_probe,
>  	.remove		=3D asoc_simple_card_remove,
> --=20
> 1.7.9.5
>=20

--utPK4TBebyzZxMrE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRBKYgAAoJELSic+t+oim9+BAP/3z7N66NbRVsiChfJiNNTMhY
IJavg2RH0OOxeJX+h0Tqo3KzjQt7rUxoEUtKm02+vI5mnnQQ1/lgeTwlTLUDJgkt
GutuW4vIKuzpYr3zhjN3Q7eQEb9RHUG5YdPcDakTrYyefYhsY662E4EYn53xuQZQ
xyWjqXR6u56H2a3Je1jAjoCPq/FuNvxV0qwtNWV+38UipfayUpS4HEMDqLTM08Sp
uYThMNsaveNDyel2y4ZHf5MxIlRal1ck8DxYMbyLFoFiYo/EB9JGZfh47vgkkxYr
LIqwvCZK12NLfhYrK1HW9jdyhLFHZrD6W/iQLmLVOpbVQ4dWko9zUlXrhLSD+k5d
6UUXbV48YkLFpia4T9RemS4qM8PD6MqJBFe0vXZg+3kFO4DwGfQ75RheKkyIqUzl
U1pjvOHTfTE6TcLrElOivLCDz0zqKjbGTRt+RphrrbrX20qp+6WPDZP3s/Ig7OTo
JLKyMCu8n+xvJI4Xst2Rm7K+LT4UKaXb1ruC48lTKaG86AFl+EGDltkOBw4CS6a9
P4nGOZRqx5njBkcHrmUhJ4SyysXPBryxmYl6LFjM3EHokjbA1r8JC5+CdD7pkm8p
5SYzZ8+LakKmgR5Fa7ObPEEPvOg/xrQNys+lCWIrRKpQmFcNDewO/yUIJzlg0gf+
OZATEeHdGZkVrxoWj7d9
=esMG
-----END PGP SIGNATURE-----

--utPK4TBebyzZxMrE--

--===============0713883532007064530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============0713883532007064530==--
