From: Shunqian Zheng <zhengsq@rock-chips.com>
Subject: Re: [PATCH v1 1/4] ASoC: codec: Inno codec driver for RK3036 SoC
Date: Thu, 05 Nov 2015 17:52:02 +0800
Message-ID: <563B26C2.60005@rock-chips.com>
References: <1444698070-4191-1-git-send-email-zhengsq@rock-chips.com> <1444698070-4191-2-git-send-email-zhengsq@rock-chips.com> <20151019190949.GP32054@sirena.org.uk>
Reply-To: zhengsq@rock-chips.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151019190949.GP32054@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, heiko@sntech.de, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, benzh@chromium.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark,
I sended the v2 patches and fixed the follows,

On 2015=E5=B9=B410=E6=9C=8820=E6=97=A5 03:09, Mark Brown wrote:
> On Tue, Oct 13, 2015 at 09:01:06AM +0800, Shunqian Zheng wrote:
>
>> +config SND_SOC_INNO_RK3036
>> +	tristate "Inno codec driver for RK3036 SoC"
>> +	depends on ARCH_ROCKCHIP
>> +
> There doesn't appear to be any build dependency here so can we have a=
n
> || COMPILE_TEST please and also add to SND_SOC_ALL_CODECS.
Delete the dependency and add to SND_SOC_ALL_CODECS.
>
>> +#define DEBUG
> Please remove this for upstream.
Removed.
>
>> +static int rk3036_codec_dai_set_sysclk(struct snd_soc_dai *dai, int=
 clk_id,
>> +				       unsigned int fre, int dir)
>> +{
>> +	/* Nothing to be done here */
>> +	return 0;
>> +}
> Remove empty functions, if they can be empty they can just be omitted=
=2E
Removed.
>
>> +static int rk3036_codec_dai_digital_mute(struct snd_soc_dai *dai, i=
nt mute)
>> +{
>> +	struct snd_soc_codec *codec =3D dai->codec;
>> +	unsigned int val =3D 0;
>> +
>> +	dev_dbg(codec->dev, "rk3036_codec dai mute : %d\n", mute);
>> +	if (mute)
>> +		val |=3D INNO_REG_09_HP_OUTR_MUTE_YES |
>> +		       INNO_REG_09_HP_OUTL_MUTE_YES;
>> +	else
>> +		val |=3D INNO_REG_09_HP_OUTR_MUTE_NO |
>> +		       INNO_REG_09_HP_OUTL_MUTE_NO;
> Does the device actually need muting to avoid audio issues?  If not i=
t
> looks like this is something that might be better made a user visible
> control instead.
Make mute as a control.
>
>> +static void rk3036_codec_power_off(struct snd_soc_codec *codec)
>> +{
>> +	struct inno_reg_val *reg_val;
>> +	int i;
>> +static void rk3036_codec_power_on(struct snd_soc_codec *codec)
>> +{
>> +	struct inno_reg_val *reg_val;
>> +	int i;
> I'd expect to see these be part of the set_bias_level() operation.
Move the part of setting precharge current  to set_bias_level()
>
>> +	dev_dbg(codec->dev, "rk3036_codec power on\n");
>> +	/* set a big current for capacitor discharging. */
>> +	snd_soc_write(codec, INNO_REG_10, INNO_REG_10_MAX_CUR);
>> +	mdelay(10);
>> +	/* start precharge */
>> +	snd_soc_write(codec, INNO_REG_06, INNO_REG_06_DAC_PRECHARGE);
>> +	mdelay(100);
>> +
>> +	for (i =3D 0; i < ARRAY_SIZE(inno_codec_open_path); i++) {
>> +		reg_val =3D &inno_codec_open_path[i];
>> +		snd_soc_write(codec, reg_val->reg, reg_val->val);
>> +		mdelay(5);
>> +	}
> This looks suspicious...  why isn't the power up sequence managed via
> DAPM?
Use DAPM to manage the power up path.
>
>> +static struct regmap *rk3036_codec_get_regmap(struct device *dev)
>> +{
>> +	struct rk3036_codec_priv *priv =3D dev_get_drvdata(dev);
>> +
>> +	dev_dbg(dev, "rk3036_codec get regmap\n");
>> +	return priv->regmap;
>> +}
> There's already dev_get_regmap().
Delete this functions.
>
>> +static int codec_reg_read(void *context, unsigned int reg, unsigned=
 int *val)
>> +{
>> +	struct rk3036_codec_priv *priv =3D context;
>> +	void __iomem *base =3D priv->base;
>> +
>> +	*val =3D readl(base + reg);
>> +	return 0;
>> +}
>> +static struct regmap_bus codec_regmap_bus =3D {
>> +	.reg_read =3D codec_reg_read,
>> +	.reg_write =3D codec_reg_write,
> This looks like it's just regmap_mmio, why not just use that?
Use the devm_regmap_init_mmio().
>
>> +	ret =3D regmap_write(grf, 0x00140, BIT(16 + 10) | BIT(10));
>> +	if (ret !=3D 0) {
> Can we have some defines for this rather than all the magic numbers?
Define some macros for grf select.
>
>> +static void rk3036_codec_platform_shutdown(struct platform_device *=
pdev)
>> +{
>> +	/*TODO:*/
>> +}
> If you use DAPM you shouldn't need to do anything here.
Delete it.

Thank you very much,
Shunqian
