From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ASoC:simple-card: Add multi-CODEC support
Date: Wed, 10 Sep 2014 13:43:06 +0200
Message-ID: <5410394A.1030508@baylibre.com>
References: <54103671.c36bb40a.2743.ffff969aSMTPIN_ADDED_MISSING@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
 [209.85.212.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 4342E261A50
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 13:43:08 +0200 (CEST)
Received: by mail-wi0-f172.google.com with SMTP id q5so2837900wiv.5
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 04:43:08 -0700 (PDT)
In-Reply-To: <54103671.c36bb40a.2743.ffff969aSMTPIN_ADDED_MISSING@mx.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Jean-Francois,

On 10/09/2014 13:28, Jean-Francois Moine wrote:
> This patch adds multi-CODEC support to the simple-card.
>
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>   .../devicetree/bindings/sound/simple-card.txt      | 28 +++++++--------
>   sound/soc/generic/simple-card.c                    | 41 +++++++++++++++=
++++++-
>   2 files changed, 52 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Do=
cumentation/devicetree/bindings/sound/simple-card.txt
> index c2e9841..c217687 100644
> --- a/Documentation/devicetree/bindings/sound/simple-card.txt
> +++ b/Documentation/devicetree/bindings/sound/simple-card.txt
> @@ -37,6 +37,8 @@ Required dai-link subnodes:
>
>   - cpu					: CPU   sub-node
>   - codec					: CODEC sub-node
> +					  In case of multi-CODECs, there may
> +					  be many of such sub-nodes.
>
>   Optional dai-link subnode properties:
>
> @@ -115,37 +117,31 @@ sh_fsi2: sh_fsi2@ec230000 {
>   	interrupts =3D <0 146 0x4>;
>   };
>
> -Example 2 - many DAI links:
> +Example 2 - many DAI links and multi-CODECs:
>
>   sound {
>   	compatible =3D "simple-audio-card";
>   	simple-audio-card,name =3D "Cubox Audio";
>
> -	simple-audio-card,dai-link@0 {		/* I2S - HDMI */
> +	simple-audio-card,dai-link@0 {		/* S/PDIF - HDMI & S/PDIF */
>   		format =3D "i2s";
>   		cpu {
> -			sound-dai =3D <&audio1 0>;
> -		};
> -		codec {
> -			sound-dai =3D <&tda998x 0>;
> -		};
> -	};
> -
> -	simple-audio-card,dai-link@1 {		/* S/PDIF - HDMI */
> -		cpu {
>   			sound-dai =3D <&audio1 1>;
>   		};
> -		codec {
> -			sound-dai =3D <&tda998x 1>;
> +		codec@0 {
> +			sound-dai =3D <&hdmi 0>;
> +		};
> +		codec@1 {
> +			sound-dai =3D <&spdif_codec>;
>   		};

I don't have strong opinion on that, but in my case, I was considering =

using a simple list instead of several nodes.
I don't like having to add fake address just to ensure uniqueness.

Something like that:

  sound-dais =3D <&spdif_codec 1>, <&hdmi 0>;

That being said, it will require changing the name with a plural form, =

and ensuring we have the same number of parameters for each codec.

That was just my .2 cents.

Regards,
Benoit



>   	};
>
> -	simple-audio-card,dai-link@2 {		/* S/PDIF - S/PDIF */
> +	simple-audio-card,dai-link@1 {		/* I2S - HDMI */
>   		cpu {
> -			sound-dai =3D <&audio1 1>;
> +			sound-dai =3D <&audio1 0>;
>   		};
>   		codec {
> -			sound-dai =3D <&spdif_codec>;
> +			sound-dai =3D <&hdmi 1>;
>   		};
>   	};
>   };
> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-c=
ard.c
> index 4053152..bf0ce08 100644
> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -179,11 +179,12 @@ static int asoc_simple_card_dai_link_of(struct devi=
ce_node *node,
>   	struct device_node *np =3D NULL;
>   	struct device_node *bitclkmaster =3D NULL;
>   	struct device_node *framemaster =3D NULL;
> +	struct snd_soc_dai_link_component *component;
>   	unsigned int daifmt;
>   	char *name;
>   	char prop[128];
>   	char *prefix =3D "";
> -	int ret, cpu_args;
> +	int ret, cpu_args, num_codec_dais;
>
>   	/* For single DAI link & old style of DT node */
>   	if (is_top_level_node)
> @@ -225,7 +226,16 @@ static int asoc_simple_card_dai_link_of(struct devic=
e_node *node,
>   	}
>
>   	of_node_put(np);
> +
> +	/* count the number of codec DAIs */
>   	snprintf(prop, sizeof(prop), "%scodec", prefix);
> +	num_codec_dais =3D 0;
> +	for_each_child_of_node(node, np) {
> +		if (strcmp(np->name, prop) =3D=3D 0)
> +			num_codec_dais++;
> +	}
> +
> +	/* treat the first DAI */
>   	np =3D of_get_child_by_name(node, prop);
>   	if (!np) {
>   		ret =3D -EINVAL;
> @@ -307,6 +317,35 @@ static int asoc_simple_card_dai_link_of(struct devic=
e_node *node,
>   	if (!cpu_args)
>   		dai_link->cpu_dai_name =3D NULL;
>
> +	/* handle multi-codec DAIs */
> +	if (num_codec_dais =3D=3D 1)
> +		goto out;
> +	dai_link->codecs =3D component =3D
> +			   devm_kzalloc(dev,
> +					sizeof *component * num_codec_dais,
> +					GFP_KERNEL);
> +	dai_link->num_codecs =3D num_codec_dais;
> +	component->of_node =3D dai_link->codec_of_node;
> +	dai_link->codec_of_node =3D NULL;
> +	component->dai_name =3D dai_link->codec_dai_name;
> +	dai_link->codec_dai_name =3D NULL;
> +	for (;;) {
> +		np =3D of_get_next_child(node, np);
> +		if (!np)
> +			break;
> +		component++;
> +		component->of_node =3D of_parse_phandle(np, "sound-dai", 0);
> +		if (!component->of_node) {
> +			ret =3D -ENODEV;
> +			dev_err(dev, "Bad sound-dai\n");
> +			goto dai_link_of_err;
> +		}
> +		ret =3D snd_soc_of_get_dai_name(np, &component->dai_name);
> +		if (ret < 0)
> +			goto dai_link_of_err;
> +	}
> +
> +out:
>   dai_link_of_err:
>   	if (np)
>   		of_node_put(np);
>


-- =

Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
