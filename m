From: Code Kipper <codekipper@gmail.com>
Subject: Re: [PATCH] ASoC: sun4i-i2s: Show detailed error when
 DAI configuration callbacks fail
Date: Thu, 14 Dec 2017 09:28:28 +0100
Message-ID: <CAEKpxBnE3fneLb=Q_WCzK5ds8atbktVSzsY13Yw1C5bdSr4jRQ@mail.gmail.com>
References: <20171214072928.6613-1-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f68.google.com (mail-it0-f68.google.com
 [209.85.214.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C79F266D71
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 09:28:30 +0100 (CET)
Received: by mail-it0-f68.google.com with SMTP id p139so9562307itb.1
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 00:28:30 -0800 (PST)
In-Reply-To: <20171214072928.6613-1-wens@csie.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

On 14 December 2017 at 08:29, Chen-Yu Tsai <wens@csie.org> wrote:
> When any of the DAI hardware configuration callbacks (.hw_param,
> .set_fmt, .set_sysclk) fails, there is no explanation about why it
> failed. This is particularly confusing for .hw_param, which covers
> many parameters of the DAI. Telling the users what parameter isn't
> supported, and what the requested value was goes a long way for
> developers trying to combine sun4i-i2s with external codecs.
>
> This patch adds dev_err calls explaining what isn't supported or
> failed, and what the value was. sun4i_i2s_set_clk_rate()'s first
> parameter was changed to a struct snd_soc_dai *dai, so we can
> get the underlying device.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Marcus Cooper <codekipper@gmail.com>

Thanks...I can get rid of shit loads of my debugging now.

> ---
>  sound/soc/sunxi/sun4i-i2s.c | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 13d7ecabe1b6..dca1143c1150 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -269,10 +269,11 @@ static bool sun4i_i2s_oversample_is_valid(unsigned int oversample)
>         return false;
>  }
>
> -static int sun4i_i2s_set_clk_rate(struct sun4i_i2s *i2s,
> +static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
>                                   unsigned int rate,
>                                   unsigned int word_size)
>  {
> +       struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>         unsigned int oversample_rate, clk_rate;
>         int bclk_div, mclk_div;
>         int ret;
> @@ -300,6 +301,7 @@ static int sun4i_i2s_set_clk_rate(struct sun4i_i2s *i2s,
>                 break;
>
>         default:
> +               dev_err(dai->dev, "Unsupported sample rate: %u\n", rate);
>                 return -EINVAL;
>         }
>
> @@ -308,18 +310,25 @@ static int sun4i_i2s_set_clk_rate(struct sun4i_i2s *i2s,
>                 return ret;
>
>         oversample_rate = i2s->mclk_freq / rate;
> -       if (!sun4i_i2s_oversample_is_valid(oversample_rate))
> +       if (!sun4i_i2s_oversample_is_valid(oversample_rate)) {
> +               dev_err(dai->dev, "Unsupported oversample rate: %d\n",
> +                       oversample_rate);
>                 return -EINVAL;
> +       }
>
>         bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
>                                           word_size);
> -       if (bclk_div < 0)
> +       if (bclk_div < 0) {
> +               dev_err(dai->dev, "Unsupported BCLK divider: %d\n", bclk_div);
>                 return -EINVAL;
> +       }
>
>         mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
>                                           clk_rate, rate);
> -       if (mclk_div < 0)
> +       if (mclk_div < 0) {
> +               dev_err(dai->dev, "Unsupported MCLK divider: %d\n", mclk_div);
>                 return -EINVAL;
> +       }
>
>         /* Adjust the clock division values if needed */
>         bclk_div += i2s->variant->bclk_offset;
> @@ -349,8 +358,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>         u32 width;
>
>         channels = params_channels(params);
> -       if (channels != 2)
> +       if (channels != 2) {
> +               dev_err(dai->dev, "Unsupported number of channels: %d\n",
> +                       channels);
>                 return -EINVAL;
> +       }
>
>         if (i2s->variant->has_chcfg) {
>                 regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
> @@ -382,6 +394,8 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>                 width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>                 break;
>         default:
> +               dev_err(dai->dev, "Unsupported physical sample width: %d\n",
> +                       params_physical_width(params));
>                 return -EINVAL;
>         }
>         i2s->playback_dma_data.addr_width = width;
> @@ -393,6 +407,8 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>                 break;
>
>         default:
> +               dev_err(dai->dev, "Unsupported sample width: %d\n",
> +                       params_width(params));
>                 return -EINVAL;
>         }
>
> @@ -401,7 +417,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>         regmap_field_write(i2s->field_fmt_sr,
>                            sr + i2s->variant->fmt_offset);
>
> -       return sun4i_i2s_set_clk_rate(i2s, params_rate(params),
> +       return sun4i_i2s_set_clk_rate(dai, params_rate(params),
>                                       params_width(params));
>  }
>
> @@ -426,6 +442,8 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>                 val = SUN4I_I2S_FMT0_FMT_RIGHT_J;
>                 break;
>         default:
> +               dev_err(dai->dev, "Unsupported format: %d\n",
> +                       fmt & SND_SOC_DAIFMT_FORMAT_MASK);
>                 return -EINVAL;
>         }
>
> @@ -464,6 +482,8 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>         case SND_SOC_DAIFMT_NB_NF:
>                 break;
>         default:
> +               dev_err(dai->dev, "Unsupported clock polarity: %d\n",
> +                       fmt & SND_SOC_DAIFMT_INV_MASK);
>                 return -EINVAL;
>         }
>
> @@ -482,6 +502,8 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>                         val = SUN4I_I2S_CTRL_MODE_SLAVE;
>                         break;
>                 default:
> +                       dev_err(dai->dev, "Unsupported slave setting: %d\n",
> +                               fmt & SND_SOC_DAIFMT_MASTER_MASK);
>                         return -EINVAL;
>                 }
>                 regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> @@ -504,6 +526,8 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>                         val = 0;
>                         break;
>                 default:
> +                       dev_err(dai->dev, "Unsupported slave setting: %d\n",
> +                               fmt & SND_SOC_DAIFMT_MASTER_MASK);
>                         return -EINVAL;
>                 }
>                 regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> --
> 2.15.0
>
