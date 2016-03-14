From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v5 3/9] ASoC: mediatek: Add HDMI dai-links
 in the mt8173-rt5650-rt5676 machine driver
Date: Tue, 15 Mar 2016 00:36:27 +0100
Message-ID: <56E74AFB.6070105@gmail.com>
References: <1456930153-11853-1-git-send-email-p.zabel@pengutronix.de>
 <1456930153-11853-4-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 74E26260504
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 00:36:30 +0100 (CET)
Received: by mail-wm0-f49.google.com with SMTP id n186so129816433wmn.1
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2016 16:36:30 -0700 (PDT)
In-Reply-To: <1456930153-11853-4-git-send-email-p.zabel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>, alsa-devel@alsa-project.org
Cc: Jean-Francois Moine <moinejf@free.fr>, Koro Chen <koro.chen@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Cawa Cheng <cawa.cheng@mediatek.com>, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org



On 02/03/16 15:49, Philipp Zabel wrote:
> From: Koro Chen <koro.chen@mediatek.com>
>
> This creates pcmC0D2p for the HDMI playback in the same card.
>
> Signed-off-by: Koro Chen <koro.chen@mediatek.com>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>   .../bindings/sound/mt8173-rt5650-rt5676.txt        |  5 ++-
>   sound/soc/mediatek/mt8173-rt5650-rt5676.c          | 48 ++++++++++++++++++++++
>   2 files changed, 51 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/mt8173-rt5650-rt5676.txt b/Documentation/devicetree/bindings/sound/mt8173-rt5650-rt5676.txt
> index f205ce9..ac28cdb 100644
> --- a/Documentation/devicetree/bindings/sound/mt8173-rt5650-rt5676.txt
> +++ b/Documentation/devicetree/bindings/sound/mt8173-rt5650-rt5676.txt
> @@ -1,15 +1,16 @@
> -MT8173 with RT5650 RT5676 CODECS
> +MT8173 with RT5650 RT5676 CODECS and HDMI via I2S
>
>   Required properties:
>   - compatible : "mediatek,mt8173-rt5650-rt5676"
>   - mediatek,audio-codec: the phandles of rt5650 and rt5676 codecs
> +			and of the hdmi encoder node
>   - mediatek,platform: the phandle of MT8173 ASoC platform
>
>   Example:
>
>   	sound {
>   		compatible = "mediatek,mt8173-rt5650-rt5676";
> -		mediatek,audio-codec = <&rt5650 &rt5676>;
> +		mediatek,audio-codec = <&rt5650 &rt5676 &hdmi0>;
>   		mediatek,platform = <&afe>;
>   	};
>
> diff --git a/sound/soc/mediatek/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
> index 5c4c58c..def9d95 100644
> --- a/sound/soc/mediatek/mt8173-rt5650-rt5676.c
> +++ b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
> @@ -18,6 +18,7 @@
>   #include <linux/gpio.h>
>   #include <linux/of_gpio.h>
>   #include <sound/soc.h>
> +#include <sound/hdmi-codec.h>
>   #include <sound/jack.h>
>   #include "../codecs/rt5645.h"
>   #include "../codecs/rt5677.h"
> @@ -131,10 +132,31 @@ static struct snd_soc_dai_link_component mt8173_rt5650_rt5676_codecs[] = {
>   	},
>   };
>
> +static struct snd_soc_jack mt8173_hdmi_card_jack;
> +
> +static int mt8173_hdmi_init(struct snd_soc_pcm_runtime *runtime)
> +{
> +	struct snd_soc_card *card = runtime->card;
> +	struct snd_soc_codec *codec = runtime->codec;
> +	int ret;
> +
> +	/* enable jack detection */
> +	ret = snd_soc_card_jack_new(card, "HDMI Jack", SND_JACK_LINEOUT,
> +				    &mt8173_hdmi_card_jack, NULL, 0);
> +	if (ret) {
> +		dev_err(card->dev, "Can't new HDMI Jack %d\n", ret);
> +		return ret;
> +	}
> +
> +	return hdmi_codec_set_jack_detect(codec, &mt8173_hdmi_card_jack);
> +}
> +
>   enum {
>   	DAI_LINK_PLAYBACK,
>   	DAI_LINK_CAPTURE,
> +	DAI_LINK_HDMI,
>   	DAI_LINK_CODEC_I2S,
> +	DAI_LINK_HDMI_I2S,
>   	DAI_LINK_INTERCODEC
>   };
>
> @@ -161,6 +183,16 @@ static struct snd_soc_dai_link mt8173_rt5650_rt5676_dais[] = {
>   		.dynamic = 1,
>   		.dpcm_capture = 1,
>   	},
> +	[DAI_LINK_HDMI] = {
> +		.name = "HDMI",
> +		.stream_name = "HDMI PCM",
> +		.cpu_dai_name = "HDMI",
> +		.codec_name = "snd-soc-dummy",
> +		.codec_dai_name = "snd-soc-dummy-dai",
> +		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
> +		.dynamic = 1,
> +		.dpcm_playback = 1,
> +	},
>
>   	/* Back End DAI links */
>   	[DAI_LINK_CODEC_I2S] = {
> @@ -177,6 +209,14 @@ static struct snd_soc_dai_link mt8173_rt5650_rt5676_dais[] = {
>   		.dpcm_playback = 1,
>   		.dpcm_capture = 1,
>   	},
> +	[DAI_LINK_HDMI_I2S] = {
> +		.name = "HDMI BE",
> +		.cpu_dai_name = "HDMIO",
> +		.no_pcm = 1,
> +		.codec_dai_name = "i2s-hifi",
> +		.dpcm_playback = 1,
> +		.init = mt8173_hdmi_init,
> +	},
>   	/* rt5676 <-> rt5650 intercodec link: Sets rt5676 I2S2 as master */
>   	[DAI_LINK_INTERCODEC] = {
>   		.name = "rt5650_rt5676 intercodec",
> @@ -251,6 +291,14 @@ static int mt8173_rt5650_rt5676_dev_probe(struct platform_device *pdev)
>   	mt8173_rt5650_rt5676_dais[DAI_LINK_INTERCODEC].codec_of_node =
>   		mt8173_rt5650_rt5676_codecs[1].of_node;
>
> +	mt8173_rt5650_rt5676_dais[DAI_LINK_HDMI_I2S].codec_of_node =
> +		of_parse_phandle(pdev->dev.of_node, "mediatek,audio-codec", 2);
> +	if (!mt8173_rt5650_rt5676_dais[DAI_LINK_HDMI_I2S].codec_of_node) {
> +		dev_err(&pdev->dev,
> +			"Property 'audio-codec' missing or invalid\n");
> +		return -EINVAL;

Do we really need to break the old dts binding?
Can't we just drop the return and keep add the audio-codec as optional?

Regards,
Matthias

> +	}
> +
>   	card->dev = &pdev->dev;
>   	platform_set_drvdata(pdev, card);
>
>
