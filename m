From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: Re: Applied "ASoC: pcm3060: Add DT property for single-ended output"
 to the asoc tree
Date: Wed, 14 Nov 2018 08:15:11 +0100
Message-ID: <56469208-7e28-6804-0a70-998b588a3c6a@birdec.tech>
References: <20181114003707.4047B440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114003707.4047B440078@finisterre.ee.mobilebroadband>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello Mark,

Thank you for applying this patch series.

I think you forgot one patch in the series: patch [1] is a documentation for
patch [2]. It has a different naming scheme, because that's how the document [3]
recommends. That's why it was not obvious that they relate to each other.

Document [3] also says:

> The Documentation/ portion of the patch should come in the series before
> the code implementing the binding.

Therefore, could you to apply patch [1] to the same branch as [2]?

Best Regards,
Kirill

[1] [PATCH v2 1/3] dt-bindings: sound: Add documentation for pcm3060 property
    out-single-ended
[2] [PATCH v2 2/3] ASoC: pcm3060: Add DT property for single-ended output
[3] Documentation/devicetree/bindings/submitting-patches.txt

On 11/14/18 01:37, Mark Brown wrote:
> The patch
> 
>    ASoC: pcm3060: Add DT property for single-ended output
> 
> has been applied to the asoc tree at
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.  
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 
> From b1c0000bde8fb287f4fd3493ca4167efee344c3e Mon Sep 17 00:00:00 2001
> From: Kirill Marinushkin <kmarinushkin@birdec.tech>
> Date: Mon, 12 Nov 2018 08:08:33 +0100
> Subject: [PATCH] ASoC: pcm3060: Add DT property for single-ended output
> 
> DAC output may be differential (default) or single-ended.
> 
> Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/codecs/pcm3060.c | 14 ++++++++++++++
>  sound/soc/codecs/pcm3060.h |  1 +
>  2 files changed, 15 insertions(+)
> 
> diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
> index 771b46e1974b..1dd851a7b43b 100644
> --- a/sound/soc/codecs/pcm3060.c
> +++ b/sound/soc/codecs/pcm3060.c
> @@ -270,9 +270,23 @@ EXPORT_SYMBOL(pcm3060_regmap);
>  
>  /* device */
>  
> +static void pcm3060_parse_dt(const struct device_node *np,
> +			     struct pcm3060_priv *priv)
> +{
> +	priv->out_se = of_property_read_bool(np, "ti,out-single-ended");
> +}
> +
>  int pcm3060_probe(struct device *dev)
>  {
>  	int rc;
> +	struct pcm3060_priv *priv = dev_get_drvdata(dev);
> +
> +	if (dev->of_node)
> +		pcm3060_parse_dt(dev->of_node, priv);
> +
> +	if (priv->out_se)
> +		regmap_update_bits(priv->regmap, PCM3060_REG64,
> +				   PCM3060_REG_SE, PCM3060_REG_SE);
>  
>  	rc = devm_snd_soc_register_component(dev, &pcm3060_soc_comp_driver,
>  					     pcm3060_dai,
> diff --git a/sound/soc/codecs/pcm3060.h b/sound/soc/codecs/pcm3060.h
> index fd89a68aa8a7..c895cf40ee10 100644
> --- a/sound/soc/codecs/pcm3060.h
> +++ b/sound/soc/codecs/pcm3060.h
> @@ -25,6 +25,7 @@ struct pcm3060_priv_dai {
>  struct pcm3060_priv {
>  	struct regmap *regmap;
>  	struct pcm3060_priv_dai dai[PCM3060_DAI_IDS_NUM];
> +	u8 out_se: 1;
>  };
>  
>  int pcm3060_probe(struct device *dev);
> 
