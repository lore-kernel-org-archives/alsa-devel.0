From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ASoc: tegra: Add platform driver for
	rt5677 audio codec
Date: Mon, 06 Oct 2014 20:44:56 -0700
Message-ID: <543361B8.40204@nvidia.com>
References: <1412113939-11071-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 20505260393
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 05:45:00 +0200 (CEST)
In-Reply-To: <1412113939-11071-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>, broonie@kernel.org, bardliao@realtek.com, oder_chiou@realtek.com, lars@metafoo.de, ldahan@nvidia.com, dgreid@google.com
Cc: alsa-devel@alsa-project.org, Anatol Pomozov <anatol@google.com>
List-Id: alsa-devel@alsa-project.org

On 09/30/2014 02:52 PM, Anatol Pomozov wrote:
> The driver will support Ryu board

> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.txt

> +- nvidia,i2s-controller : The phandle of the Tegra I2S controller that's
> +  connected to the CODEC.
> +- nvidia,audio-codec : The phandle of the RT5677 audio codec. This binding
> +  assumes that AIF1 on the CODEC is connected to Tegra.
> +- nvidia,speaker-codec: The phandle of the SSM4567 amplifier. This binding
> +  assumes that AIF2 on the audio CODEC is connected to this speaker amplifier.

Does the CODEC only output audio on an I2S link, or does it also have
analog outputs? As Mark mentioned, this binding deviates from the other
generic audio bindings for Tegra in that the others all have CODEC
analog outputs connected to speakers/headphones, whereas this binding
requires an extra I2S based component, which doesn't seem very generic.

> +sound {
> +	compatible = "nvidia,tegra-audio-rt5677-ryu",
> +			"nvidia,tegra-audio-rt5677";
> +	nvidia,model = "NVIDIA Tegra Ryu";
> +
> +	nvidia,audio-routing =
> +		// rt5677 codec

Let's use /* */

> diff --git a/sound/soc/tegra/tegra_rt5677.c b/sound/soc/tegra/tegra_rt5677.c

> +static struct snd_soc_pcm_stream tegra_rt5677_spk_params = {
> +	.formats = SNDRV_PCM_FMTBIT_S16_LE,
> +	.channels_min = 2,
> +	.channels_max = 2,
> +};
...
> +static int tegra_rt5677_asoc_hw_params(struct snd_pcm_substream *substream,
> +					struct snd_pcm_hw_params *params)
...
> +	/* both dai interfaces use the same bit clock,
> +	 * set rate for both interfaces the same, otherwise driver might not
> +	 * be able to configure clock divider.
> +	 */
> +	tegra_rt5677_spk_params.rate_min = srate;
> +	tegra_rt5677_spk_params.rate_max = srate;

This feels a bit odd. Shouldn't hw_params simply call some function on
the appropriate DAI to configure it directly for the required sample rate?

> +static struct snd_soc_dai_link tegra_rt5677_dai[] = {
> +{

The array entries should be indented 1 level.

> +static int tegra_rt5677_remove(struct platform_device *pdev)
> +{
> +	struct snd_soc_card *card = platform_get_drvdata(pdev);
> +	struct tegra_rt5677 *machine = snd_soc_card_get_drvdata(card);
> +
> +	snd_soc_jack_free_gpios(&tegra_rt5677_hp_jack, 1,
> +				&tegra_rt5677_hp_jack_gpio);

That needs to be part of the struct snd_soc_card's .remove function, not
the struct platform_driver's .remove function. See the git history of
other Tegra reasons for details of the crash this prevents.
