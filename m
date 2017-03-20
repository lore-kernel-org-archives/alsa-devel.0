From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add support for Maxim Integrated
 MAX98927 Amplifier
Date: Mon, 20 Mar 2017 14:14:07 +0000
Message-ID: <20170320141407.GS6986@localhost.localdomain>
References: <1489970423-29353-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CE67266E15
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 15:13:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1489970423-29353-1-git-send-email-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryan Lee <ryans.lee@maximintegrated.com>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, tiwai@suse.com, srinivas.kandagatla@linaro.org, romain.perier@collabora.com, bardliao@realtek.com, lars@metafoo.de, axel.lin@ingics.com, Paul.Handrigan@cirrus.com, devicetree@vger.kernel.org, arnd@arndb.de, nh6z@nh6z.net, robh+dt@kernel.org, dgreid@google.com, oder_chiou@realtek.com, KCHSU0@nuvoton.com, linux-kernel@vger.kernel.org, petr@barix.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 20, 2017 at 09:40:23AM +0900, Ryan Lee wrote:
> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
> ---
> Resubmit the intial version of MAX98927 driver. Added all fixes into the initial patch.
<snip>
> +static int max98927_reg_get(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol, unsigned int reg,
> +	unsigned int mask, unsigned int shift)
> +{
> +	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
> +	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
> +	int data;
> +
> +	regmap_read(max98927->regmap, reg, &data);
> +	ucontrol->value.integer.value[0] = (data & mask) >> shift;
> +	return 0;
> +}
> +
> +static int max98927_reg_put(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol, unsigned int reg,
> +	unsigned int mask, unsigned int shift)
> +{
> +	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
> +	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
> +	unsigned int sel = ucontrol->value.integer.value[0];
> +
> +	regmap_update_bits(max98927->regmap, reg, mask, sel << shift);
> +	dev_dbg(codec->dev, "%s: register 0x%02X, value 0x%02X\n",
> +		__func__, reg, sel);
> +	return 0;
> +}

These functions look a lot like they duplicate things the ASoC
core does?

<snip>
> +static int max98927_boost_voltage_get(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	return max98927_reg_get(kcontrol, ucontrol,
> +		MAX98927_R0040_BOOST_CTRL0,
> +		MAX98927_BOOST_CTRL0_VOUT_MASK, 0);
> +}
> +

And can't these just be specified in the normal way with the
register information attached to the control? There doesn't seem
to be any special behaviour being added here. Apologies if I am
missing something here.

Thanks,
Charles
