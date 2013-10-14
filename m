From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: simple-card: add Device Tree
	support
Date: Mon, 14 Oct 2013 18:16:14 +0100
Message-ID: <20131014171614.GJ2443@sirena.org.uk>
References: <87eh97sqw7.wl%kuninori.morimoto.gx@renesas.com>
 <87txharb3o.wl%kuninori.morimoto.gx@renesas.com>
 <8738oiog00.wl%kuninori.morimoto.gx@renesas.com>
 <20131003104248.GI27287@sirena.org.uk>
 <87fvsh2966.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4809209985794347339=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C1EEA261631
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2013 19:16:40 +0200 (CEST)
In-Reply-To: <87fvsh2966.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Takashi Iwai <tiwai@suse.de>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>
List-Id: alsa-devel@alsa-project.org


--===============4809209985794347339==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ohWw6IXhY39HKnGA"
Content-Disposition: inline


--ohWw6IXhY39HKnGA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2013 at 05:04:41PM -0700, Kuninori Morimoto wrote:
> Support for loading the simple-card module via DeviceTree.
> It requests CPU/CODEC information,
> and .of_xlate_dai_name support on each component driver.
>=20
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

CCing in the DT maintainers directly.

> ---
> v1 -> v2
>=20
>  - add common clock support, system-clock-frequency can over-write it
>  - add some comment on code
>=20
> v2 -> v3
>=20
>  - add devicetree ML address
>=20
>  .../devicetree/bindings/sound/simple-card.txt      |   85 ++++++++++++
>  sound/soc/generic/simple-card.c                    |  146 ++++++++++++++=
+++++-
>  2 files changed, 226 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/simple-card.t=
xt
>=20
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Do=
cumentation/devicetree/bindings/sound/simple-card.txt
> new file mode 100644
> index 0000000..75bbc5a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/simple-card.txt
> @@ -0,0 +1,85 @@
> +Simple-Card:
> +
> +Required properties:
> +
> +- compatible				: "simple-audio"
> +- simple-audio,card-name		: simple-audio card name
> +- simple-audio,cpu			: CPU sub-node, see below
> +- simple-audio,codec			: CODEC sub-node, see below
> +
> +Optional properties:
> +
> +- simple-audio,format			: CPU/CODEC common format, see below
> +
> +Required cpu/codec subnode properties:
> +
> +- sound-dai				: phandle and port for CPU/CODEC
> +- #sound-dai-cells			: sound-dai phandle's node
> +
> +Optional subnode properties:
> +
> +- format				: specific format if needed, see below
> +- frame-master				: frame master
> +- bitclock-master			: bitclock master
> +- bitclock-inversion			: clock inversion
> +- frame-inversion			: frame inversion
> +- clocks				: phandle for system clock rate
> +- system-clock-frequency		: system clock rate
> +					  it will overwrite clocks's rate
> +
> +simple-audio,format
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
> +Example:
> +
> +clock {
> +	osc: oscillator {
> +		#clock-cells =3D <0>;
> +		compatible =3D "fixed-clock";
> +		clock-frequency =3D <11289600>;
> +	};
> +};
> +
> +sound {
> +	compatible =3D "simple-audio";
> +
> +	simple-audio,card-name =3D "FSI2A-AK4648";
> +	simple-audio,format =3D "left_j";
> +
> +	simple-audio,cpu {
> +		sound-dai =3D <&sh_fsi2 0>;
> +	};
> +
> +	simple-audio,codec {
> +		sound-dai =3D <&ak4648>;
> +		bitclock-master;
> +		frame-master;
> +		clocks =3D <&osc>;
> +		/* it can use this instead of clocks
> +		 * system-clock-frequency =3D <11289600>; */
> +	};
> +};
> +
> +&i2c0 {
> +	ak4648: ak4648@0x12 {
> +		#sound-dai-cells =3D <0>;
> +		compatible =3D "asahi-kasei,ak4648";
> +		reg =3D <0x12>;
> +	};
> +};
> +
> +sh_fsi2: sh_fsi2@0xec230000 {
> +	#sound-dai-cells =3D <1>;
> +	compatible =3D "renesas,sh_fsi2";
> +	reg =3D <0xec230000 0x400>;
> +	interrupt-parent =3D <&gic>;
> +	interrupts =3D <0 146 0x4>;
> +};
> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-c=
ard.c
> index 8c49147..62befbd 100644
> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -9,6 +9,8 @@
>   * published by the Free Software Foundation.
>   */
> =20
> +#include <linux/clk.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <sound/simple_card.h>
> @@ -52,11 +54,135 @@ static int asoc_simple_card_dai_init(struct snd_soc_=
pcm_runtime *rtd)
>  	return 0;
>  }
> =20
> +static int
> +__asoc_simple_card_parse_of(struct device_node *np,
> +			    struct asoc_simple_dai *dai,
> +			    struct device_node **node)
> +{
> +	struct clk *clk;
> +	int ret;
> +
> +	/*
> +	 * get node via "sound-dai =3D <&phandle port>"
> +	 * it will be used as xxx_of_node on soc_bind_dai_link()
> +	 */
> +	*node =3D of_parse_phandle(np, "sound-dai", 0);
> +	if (!*node)
> +		return -ENODEV;
> +
> +	of_node_put(*node);
> +
> +	/* get dai->name */
> +	ret =3D snd_soc_of_get_dai_name(np, &dai->name);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * bitclock-inversion, frame-inversion
> +	 * bitclock-master,    frame-master
> +	 * and specific "format" if it has
> +	 */
> +	dai->fmt =3D snd_soc_of_parse_daifmt(np, NULL);
> +
> +	/* dai->sysclk via "clolks =3D <xxx>" */
> +	clk =3D of_clk_get(np, 0);
> +	if (IS_ERR(clk))
> +		dai->sysclk =3D 0;
> +	else
> +		dai->sysclk =3D clk_get_rate(clk);
> +
> +	/*
> +	 * overwrite dai->sysclk if it has
> +	 * "system-clock-frequency =3D <xxx>"
> +	 */
> +	of_property_read_u32(np,
> +			     "system-clock-frequency",
> +			     &dai->sysclk);
> +
> +	return 0;
> +}
> +
> +static int asoc_simple_card_parse_of(struct device_node *node,
> +				     struct asoc_simple_card_info *info,
> +				     struct device *dev,
> +				     struct device_node **of_cpu,
> +				     struct device_node **of_codec,
> +				     struct device_node **of_platform)
> +{
> +	struct device_node *np;
> +	int ret =3D 0;
> +
> +	/* get card name */
> +	of_property_read_string(node, "simple-audio,card-name", &info->card);
> +	info->name =3D info->card;
> +
> +	/* get CPU/CODEC common format via simple-audio,format */
> +	info->daifmt =3D snd_soc_of_parse_daifmt(node, "simple-audio,") &
> +		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
> +
> +	/* CPU/CODEC sub-node */
> +	for_each_child_of_node(node, np) {
> +		if (0 =3D=3D strcmp("simple-audio,cpu", np->name))
> +			ret =3D __asoc_simple_card_parse_of(np,
> +							  &info->cpu_dai,
> +							  of_cpu);
> +		if (0 =3D=3D strcmp("simple-audio,codec", np->name))
> +			ret =3D __asoc_simple_card_parse_of(np,
> +							  &info->codec_dai,
> +							  of_codec);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/* simple-card assumes platform =3D=3D cpu */
> +	*of_platform =3D *of_cpu;
> +
> +	dev_dbg(dev, "card-name : %s\n", info->card);
> +	dev_dbg(dev, "platform : %04x / %p\n",
> +		info->daifmt,
> +		*of_platform);
> +	dev_dbg(dev, "cpu : %s / %04x / %d / %p\n",
> +		info->cpu_dai.name,
> +		info->cpu_dai.fmt,
> +		info->cpu_dai.sysclk,
> +		*of_cpu);
> +	dev_dbg(dev, "codec : %s / %04x / %d / %p\n",
> +		info->codec_dai.name,
> +		info->codec_dai.fmt,
> +		info->codec_dai.sysclk,
> +		*of_codec);
> +
> +	return 0;
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
> +		if (cinfo) {
> +			int ret;
> +			ret =3D asoc_simple_card_parse_of(np, cinfo, dev,
> +							&of_cpu,
> +							&of_codec,
> +							&of_platform);
> +			if (ret < 0) {
> +				dev_err(dev, "parse error %d\n", ret);
> +				return ret;
> +			}
> +		}
> +	} else {
> +		cinfo =3D pdev->dev.platform_data;
> +	}
> +
>  	if (!cinfo) {
>  		dev_err(dev, "no info for asoc-simple-card\n");
>  		return -EINVAL;
> @@ -64,10 +190,10 @@ static int asoc_simple_card_probe(struct platform_de=
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
> @@ -81,6 +207,9 @@ static int asoc_simple_card_probe(struct platform_devi=
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
> @@ -102,10 +231,17 @@ static int asoc_simple_card_remove(struct platform_=
device *pdev)
>  	return snd_soc_unregister_card(&cinfo->snd_card);
>  }
> =20
> +static const struct of_device_id asoc_simple_of_match[] =3D {
> +	{ .compatible =3D "simple-audio", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, asoc_simple_of_match);
> +
>  static struct platform_driver asoc_simple_card =3D {
>  	.driver =3D {
>  		.name	=3D "asoc-simple-card",
>  		.owner =3D THIS_MODULE,
> +		.of_match_table =3D asoc_simple_of_match,
>  	},
>  	.probe		=3D asoc_simple_card_probe,
>  	.remove		=3D asoc_simple_card_remove,
> --=20
> 1.7.9.5
>=20
>=20

--ohWw6IXhY39HKnGA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXCbaAAoJELSic+t+oim9vwIP/0DnsBeqV3p4Vchs4XX9193D
r5GqJZLoU4zTmw61ImVMLgKMLCHKJRBU/ZM0ngfEUpc/rVktfldEEyQCkTTQYveY
QJi8Ex4CXG7gj8XNL+T9hnDs+WbByL9vw8zgIMhHCpWMHGuq/Wbimv+2FiVfy2ig
9jRqxyUYiseuRIz2zH+xtgOZ0clBe6pwW4zlSpxAVJ1oK+T4M3r38wT4eTFN2Urv
2XOeMwnWAX1tjH7a3flIaFtArw3wW0Ro/vKWu5BaT6ZaycZl68DHJWLvqhNeS7TF
IYCWsQhAgNdHoGLdHFd2ghEzBPj7OAkTnHsQ2BM7+SBoMSU1I3ae2Vq9X/p6RYXA
FSQsi8wB1xgChHoe0vbpgt+VWERgqD3bdCLhgqM/4agSDf1DKlHBi0gEFG5fXwGO
cYp1p+HgAYW7sKIC/BEBOCVGpGy2AH0IpxCgmpW+hXJTV4xGBe5CGjc02RMdSYhf
d3Ytm60Yp2t0ctMA3PYuF1YAjzGOlIrFYTOTJLcpyS1XmddfOIxr6aP+4lOc6w8t
7nGThDtcGTJWJl4KB6gnyNLocJy12rGO5rAlmme4hb4KC/08qD/M5TWA2hTsDXSr
XgViMEjbcpibzeu27bh+9QNlGVoSlX7/6HSAoSzuaO9hUPldcG51XX9A5FDLuJnn
s0Itzfu2j0DLAt3uUVdS
=I38R
-----END PGP SIGNATURE-----

--ohWw6IXhY39HKnGA--

--===============4809209985794347339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4809209985794347339==--
