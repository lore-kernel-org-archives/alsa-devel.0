From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt5640: add master clock handling for rt5640
Date: Wed, 24 Feb 2016 00:08:31 +0100
Message-ID: <2199435.lA9iTvxnKV@phil>
References: <1456190782-18865-1-git-send-email-sugar.zhang@rock-chips.com> <56CC719C.1090901@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56CC719C.1090901@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Sugar Zhang <sugar.zhang@rock-chips.com>, broonie@kernel.org, Mark Rutland <mark.rutland@arm.com>, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Am Dienstag, 23. Februar 2016, 08:50:04 schrieb Pierre-Louis Bossart:
> On 2/22/16 7:26 PM, Sugar Zhang wrote:
> > enable/disable master clock when codec is active or not.
> > 
> > Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> > ---
> > 
> >   Documentation/devicetree/bindings/sound/rt5640.txt |  3 +++
> >   sound/soc/codecs/rt5640.c                          | 31
> >   ++++++++++++++++++++++ sound/soc/codecs/rt5640.h                     
> >       |  2 ++
> >   3 files changed, 36 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/rt5640.txt
> > b/Documentation/devicetree/bindings/sound/rt5640.txt index
> > 9e62f6e..57fe646 100644
> > --- a/Documentation/devicetree/bindings/sound/rt5640.txt
> > +++ b/Documentation/devicetree/bindings/sound/rt5640.txt
> > 
> > @@ -12,6 +12,9 @@ Required properties:
> >   Optional properties:
> > +- clocks: The phandle of the master clock to the CODEC
> > +- clock-names: Should be "mclk"
> 
> This patch assumes that the information on mclk comes from DeviceTree.
> The mclk may also be enabled/disabled in the machine driver with an
> explicit transition to use an internal clock when the codec is not used.
> I hope this patch doesn't preclude such usages or there will be a
> conflict with the patches we are about to upstream for Baytrail/cht
> devices.

As you can see, the clock property itself is optional and the clk_get below 
acts accordingly of also continuing if the clock is not present.
So it won't affect any users doing it otherwise.


Heiko

> > +
> > 
> >   - realtek,in1-differential
> >   - realtek,in2-differential
> >   - realtek,in3-differential
> > 
> > diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
> > index 11d032c..6cd84fb 100644
> > --- a/sound/soc/codecs/rt5640.c
> > +++ b/sound/soc/codecs/rt5640.c
> > @@ -1949,7 +1949,33 @@ static int rt5640_set_dai_pll(struct snd_soc_dai
> > *dai, int pll_id, int source,> 
> >   static int rt5640_set_bias_level(struct snd_soc_codec *codec,
> >   
> >   			enum snd_soc_bias_level level)
> >   
> >   {
> > 
> > +	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
> > +	int ret;
> > +
> > 
> >   	switch (level) {
> > 
> > +	case SND_SOC_BIAS_ON:
> > +		break;
> > +
> > +	case SND_SOC_BIAS_PREPARE:
> > +		/*
> > +		 * SND_SOC_BIAS_PREPARE is called while preparing for a
> > +		 * transition to ON or away from ON. If current bias_level
> > +		 * is SND_SOC_BIAS_ON, then it is preparing for a transition
> > +		 * away from ON. Disable the clock in that case, otherwise
> > +		 * enable it.
> > +		 */
> > +		if (IS_ERR(rt5640->mclk))
> > +			break;
> > +
> > +		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_ON) {
> > +			clk_disable_unprepare(rt5640->mclk);
> > +		} else {
> > +			ret = clk_prepare_enable(rt5640->mclk);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +		break;
> > +
> > 
> >   	case SND_SOC_BIAS_STANDBY:
> >   		if (SND_SOC_BIAS_OFF == snd_soc_codec_get_bias_level(codec)) {
> >   		
> >   			snd_soc_update_bits(codec, RT5640_PWR_ANLG1,
> > 
> > @@ -2088,6 +2114,11 @@ static int rt5640_probe(struct snd_soc_codec
> > *codec)> 
> >   	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
> >   	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
> > 
> > +	/* Check if MCLK provided */
> > +	rt5640->mclk = devm_clk_get(codec->dev, "mclk");
> > +	if (PTR_ERR(rt5640->mclk) == -EPROBE_DEFER)
> > +		return -EPROBE_DEFER;
> > +
> > 
> >   	rt5640->codec = codec;
> >   	
> >   	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
> > 
> > diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
> > index 83a7150..1761c3a9 100644
> > --- a/sound/soc/codecs/rt5640.h
> > +++ b/sound/soc/codecs/rt5640.h
> > @@ -12,6 +12,7 @@
> > 
> >   #ifndef _RT5640_H
> >   #define _RT5640_H
> > 
> > +#include <linux/clk.h>
> > 
> >   #include <sound/rt5640.h>
> >   
> >   /* Info */
> > 
> > @@ -2097,6 +2098,7 @@ struct rt5640_priv {
> > 
> >   	struct snd_soc_codec *codec;
> >   	struct rt5640_platform_data pdata;
> >   	struct regmap *regmap;
> > 
> > +	struct clk *mclk;
> > 
> >   	int sysclk;
> >   	int sysclk_src;
