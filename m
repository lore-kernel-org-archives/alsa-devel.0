From: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Subject: Re: [PATCH 1/2] audio: sgtl5000: Add MicBias resistor
	support in DT
Date: Tue, 14 Oct 2014 08:36:31 +0200
Message-ID: <CAL8zT=guWGDTOvpVA2q=B=w0MDQKRww1xMpnyJN_2UJO4AyT=Q@mail.gmail.com>
References: <1413268341-3743-1-git-send-email-jean-michel.hautbois@vodalys.com>
 <1413268341-3743-2-git-send-email-jean-michel.hautbois@vodalys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
 [209.85.218.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 94A752604A2
 for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2014 08:36:49 +0200 (CEST)
Received: by mail-oi0-f48.google.com with SMTP id g201so15452241oib.35
 for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2014 23:36:47 -0700 (PDT)
In-Reply-To: <1413268341-3743-2-git-send-email-jean-michel.hautbois@vodalys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2014-10-14 8:32 GMT+02:00 Jean-Michel Hautbois
<jean-michel.hautbois@vodalys.com>:
> Some systems may require a different resistor than the default one (4K).
> This adds a property in sgtl5000 codec.
> It keeps the default of 4K when nothing is specified so it does not break
> existing code.
>
> Signed-off-by: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
> ---
>  .../devicetree/bindings/sound/sgtl5000.txt         |  8 ++++
>  sound/soc/codecs/sgtl5000.c                        | 55 ++++++++++++++++++++--
>  2 files changed, 59 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
> index 955df60..d6ec927 100644
> --- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
> +++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
> @@ -7,10 +7,18 @@ Required properties:
>
>  - clocks : the clock provider of SYS_MCLK
>
> +- micbias-resistor-k-ohms : the bias resistor to be used in kOmhs
> +       The resistor can take values of 2k, 4k or 8k.
> +       If set to 0 it will be off.
> +       If this node is not mentioned or if the value is unknown, then
> +       micbias resistor is set to 4K.
> +
> +
>  Example:
>
>  codec: sgtl5000@0a {
>         compatible = "fsl,sgtl5000";
>         reg = <0x0a>;
>         clocks = <&clks 150>;
> +       sgtl5000-micbias-resistor = <1>;
>  };
> diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> index 6bb77d7..f0b40a6 100644
> --- a/sound/soc/codecs/sgtl5000.c
> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -16,6 +16,7 @@
>  #include <linux/pm.h>
>  #include <linux/i2c.h>
>  #include <linux/clk.h>
> +#include <linux/log2.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/driver.h>
>  #include <linux/regulator/machine.h>
> @@ -121,6 +122,13 @@ struct ldo_regulator {
>         bool enabled;
>  };
>
> +enum sgtl5000_micbias_resistor {
> +       SGTL5000_MICBIAS_OFF = 0,
> +       SGTL5000_MICBIAS_2K = 2,
> +       SGTL5000_MICBIAS_4K = 4,
> +       SGTL5000_MICBIAS_8K = 8,
> +};
> +
>  /* sgtl5000 private structure in codec */
>  struct sgtl5000_priv {
>         int sysclk;     /* sysclk rate */
> @@ -131,6 +139,7 @@ struct sgtl5000_priv {
>         struct regmap *regmap;
>         struct clk *mclk;
>         int revision;
> +       u8 micbias_resistor;
>  };
>
>  /*
> @@ -145,12 +154,14 @@ struct sgtl5000_priv {
>  static int mic_bias_event(struct snd_soc_dapm_widget *w,
>         struct snd_kcontrol *kcontrol, int event)
>  {
> +       struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(w->codec);
> +
>         switch (event) {
>         case SND_SOC_DAPM_POST_PMU:
> -               /* change mic bias resistor to 4Kohm */
> +               /* change mic bias resistor */
>                 snd_soc_update_bits(w->codec, SGTL5000_CHIP_MIC_CTRL,
> -                               SGTL5000_BIAS_R_MASK,
> -                               SGTL5000_BIAS_R_4k << SGTL5000_BIAS_R_SHIFT);
> +                       SGTL5000_BIAS_R_MASK,
> +                       sgtl5000->micbias_resistor << SGTL5000_BIAS_R_SHIFT);
>                 break;
>
>         case SND_SOC_DAPM_PRE_PMD:
> @@ -1326,7 +1337,9 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
>                         SGTL5000_HP_ZCD_EN |
>                         SGTL5000_ADC_ZCD_EN);
>
> -       snd_soc_write(codec, SGTL5000_CHIP_MIC_CTRL, 2);
> +       snd_soc_update_bits(codec, SGTL5000_CHIP_MIC_CTRL,
> +                       SGTL5000_BIAS_R_MASK,
> +                       sgtl5000->micbias_resistor << SGTL5000_BIAS_R_SHIFT);
>
>         /*
>          * disable DAP
> @@ -1418,6 +1431,8 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
>         struct sgtl5000_priv *sgtl5000;
>         int ret, reg, rev;
>         unsigned int mclk;
> +       struct device_node *np = client->dev.of_node;
> +       u32 value;
>
>         sgtl5000 = devm_kzalloc(&client->dev, sizeof(struct sgtl5000_priv),
>                                                                 GFP_KERNEL);
> @@ -1470,6 +1485,38 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
>         dev_info(&client->dev, "sgtl5000 revision 0x%x\n", rev);
>         sgtl5000->revision = rev;
>
> +       if (np) {
> +               if (!of_property_read_u32(np,
> +                       "micbias-resistor-k-ohms", &value)) {
> +                       switch (value) {
> +                       case SGTL5000_MICBIAS_OFF:
> +                               sgtl5000->micbias_resistor = 0;
> +                               break;
> +                       case SGTL5000_MICBIAS_2K:
> +                               sgtl5000->micbias_resistor = 1;
> +                               break;
> +                       case SGTL5000_MICBIAS_2K:
> +                               sgtl5000->micbias_resistor = 2;
> +                               break;
> +                       case SGTL5000_MICBIAS_2K:
> +                               sgtl5000->micbias_resistor = 3;
> +                               break;
> +                       default:
> +                               sgtl5000->micbias_resistor = 2;
> +                               dev_err(&client->dev,
> +                                       "Unsuitable MicBias resistor\n");

And I auto-reply, this is a too fast send (again) as this is a bad
copy/paste obviously...
Sorry for the noise :(.

JM
