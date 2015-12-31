From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: Extend FLL function
Date: Thu, 31 Dec 2015 01:14:57 -0800
Message-ID: <CAOMFOmX_fu94AYJpP5x4=r9GXb5CztxhMNNv7rHENO8fWbgjeg@mail.gmail.com>
References: <1451548510-4989-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f178.google.com (mail-ig0-f178.google.com
 [209.85.213.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 06D66265AE8
 for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2015 10:14:59 +0100 (CET)
Received: by mail-ig0-f178.google.com with SMTP id ph11so193930576igc.1
 for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2015 01:14:58 -0800 (PST)
In-Reply-To: <1451548510-4989-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Ben Zhang <benzh@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, YHCHuang@nuvoton.com, Mark Brown <broonie@kernel.org>, CTLIN0@nuvoton.com, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi

On Wed, Dec 30, 2015 at 11:55 PM, John Hsu <KCHSU0@nuvoton.com> wrote:
> Extend FFL clock source from MCLK/BCLK/FS;
> And modify some FLL parameter setting.
>
> Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
> ---
>  sound/soc/codecs/nau8825.c | 100 +++++++++++++++++++++++++++++++++------------
>  sound/soc/codecs/nau8825.h |  14 ++++++-
>  2 files changed, 86 insertions(+), 28 deletions(-)
>
> diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
> index 7fc7b4e..16da8ef 100644
> --- a/sound/soc/codecs/nau8825.c
> +++ b/sound/soc/codecs/nau8825.c
> @@ -926,7 +926,8 @@ static void nau8825_fll_apply(struct nau8825 *nau8825,
>                 struct nau8825_fll *fll_param)
>  {
>         regmap_update_bits(nau8825->regmap, NAU8825_REG_CLK_DIVIDER,
> -               NAU8825_CLK_MCLK_SRC_MASK, fll_param->mclk_src);
> +               NAU8825_CLK_SRC_MASK | NAU8825_CLK_MCLK_SRC_MASK,
> +               NAU8825_CLK_SRC_MCLK | fll_param->mclk_src);
>         regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL1,
>                         NAU8825_FLL_RATIO_MASK, fll_param->ratio);
>         /* FLL 16-bit fractional input */
> @@ -939,10 +940,20 @@ static void nau8825_fll_apply(struct nau8825 *nau8825,
>                         NAU8825_FLL_REF_DIV_MASK, fll_param->clk_ref_div);
>         /* select divided VCO input */
>         regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL5,
> -                       NAU8825_FLL_FILTER_SW_MASK, 0x0000);
> -       /* FLL sigma delta modulator enable */
> +               NAU8825_FLL_PDB_DAC_EN | NAU8825_FLL_LOOP_FTR_EN |
> +               NAU8825_FLL_FILTER_SW_MASK,
> +               NAU8825_FLL_PDB_DAC_EN | NAU8825_FLL_LOOP_FTR_EN |
> +               NAU8825_FLL_FILTER_SW_REF);
> +       /* Disable free-running mode */
>         regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL6,
> -                       NAU8825_SDM_EN_MASK, NAU8825_SDM_EN);
> +                               NAU8825_DCO_EN, 0);
> +       /* FLL sigma delta modulator enable */
> +       if (fll_param->fll_frac)
> +               regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL6,
> +                               NAU8825_SDM_EN_MASK, NAU8825_SDM_EN);
> +       else
> +               regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL6,
> +                               NAU8825_SDM_EN_MASK, 0);
>  }
>
>  /* freq_out must be 256*Fs in order to achieve the best performance */
> @@ -970,6 +981,37 @@ static int nau8825_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
>         return 0;
>  }
>
> +static int nau8825_mclk_prepare(struct nau8825 *nau8825, unsigned int freq)
> +{
> +       int ret = 0;
> +
> +       /* We selected MCLK source but the clock itself managed externally */
> +       if (!nau8825->mclk)
> +               goto done;

A nitpick.

This "goto" style is used for recovering resources or something that
should be restored in case of error. But in your case "done:" does not
recover anything. It is cleaner remove "goto" and replace with "return
0" or "return err".

> +
> +       if (!nau8825->mclk_freq) {
> +               ret = clk_prepare_enable(nau8825->mclk);
> +               if (ret) {
> +                       dev_err(nau8825->dev, "Unable to prepare codec mclk\n");
> +                       goto done;
> +               }
> +       }
> +
> +       if (nau8825->mclk_freq != freq) {
> +               nau8825->mclk_freq = freq;
> +
> +               freq = clk_round_rate(nau8825->mclk, freq);
> +               ret = clk_set_rate(nau8825->mclk, freq);
> +               if (ret) {
> +                       dev_err(nau8825->dev, "Unable to set mclk rate\n");
> +                       goto done;
> +               }
> +       }
> +
> +done:
> +       return ret;
> +}
> +
>  static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
>         unsigned int freq)
>  {
> @@ -981,29 +1023,9 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
>                 regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
>                         NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_MCLK);
>                 regmap_update_bits(regmap, NAU8825_REG_FLL6, NAU8825_DCO_EN, 0);
> -
> -               /* We selected MCLK source but the clock itself managed externally */
> -               if (!nau8825->mclk)
> -                       break;
> -
> -               if (!nau8825->mclk_freq) {
> -                       ret = clk_prepare_enable(nau8825->mclk);
> -                       if (ret) {
> -                               dev_err(nau8825->dev, "Unable to prepare codec mclk\n");
> -                               return ret;
> -                       }
> -               }
> -
> -               if (nau8825->mclk_freq != freq) {
> -                       nau8825->mclk_freq = freq;
> -
> -                       freq = clk_round_rate(nau8825->mclk, freq);
> -                       ret = clk_set_rate(nau8825->mclk, freq);
> -                       if (ret) {
> -                               dev_err(nau8825->dev, "Unable to set mclk rate\n");
> -                               return ret;
> -                       }
> -               }
> +               ret = nau8825_mclk_prepare(nau8825, freq);
> +               if (ret)
> +                       return ret;
>
>                 break;
>         case NAU8825_CLK_INTERNAL:
> @@ -1018,6 +1040,30 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
>                 }
>
>                 break;
> +       case NAU8825_CLK_FLL_MCLK:
> +               regmap_update_bits(regmap, NAU8825_REG_FLL3,
> +                       NAU8825_FLL_CLK_SRC_MASK, NAU8825_FLL_CLK_SRC_MCLK);
> +               ret = nau8825_mclk_prepare(nau8825, freq);
> +               if (ret)
> +                       return ret;
> +
> +               break;
> +       case NAU8825_CLK_FLL_BLK:
> +               regmap_update_bits(regmap, NAU8825_REG_FLL3,
> +                       NAU8825_FLL_CLK_SRC_MASK, NAU8825_FLL_CLK_SRC_BLK);
> +               ret = nau8825_mclk_prepare(nau8825, freq);


Based on names for these constants I believe CODEC is going to use
BCLK/FS signal of I2S bus as a clock signal reference.

Do you still need MCLK signal in this case? If no then you should
disable MCLK to save some power.


> +               if (ret)
> +                       return ret;
> +
> +               break;
> +       case NAU8825_CLK_FLL_FS:
> +               regmap_update_bits(regmap, NAU8825_REG_FLL3,
> +                       NAU8825_FLL_CLK_SRC_MASK, NAU8825_FLL_CLK_SRC_FS);
> +               ret = nau8825_mclk_prepare(nau8825, freq);
> +               if (ret)
> +                       return ret;
> +
> +               break;
>         default:
>                 dev_err(nau8825->dev, "Invalid clock id (%d)\n", clk_id);
>                 return -EINVAL;
> diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
> index dff8edb..e8f7ca5 100644
> --- a/sound/soc/codecs/nau8825.h
> +++ b/sound/soc/codecs/nau8825.h
> @@ -112,12 +112,21 @@
>
>  /* FLL3 (0x06) */
>  #define NAU8825_FLL_INTEGER_MASK               (0x3ff << 0)
> +#define NAU8825_FLL_CLK_SRC_SFT                10
> +#define NAU8825_FLL_CLK_SRC_MASK               (0x3 << NAU8825_FLL_CLK_SRC_SFT)
> +#define NAU8825_FLL_CLK_SRC_MCLK               (0 << NAU8825_FLL_CLK_SRC_SFT)
> +#define NAU8825_FLL_CLK_SRC_BLK                (0x2 << NAU8825_FLL_CLK_SRC_SFT)
> +#define NAU8825_FLL_CLK_SRC_FS                 (0x3 << NAU8825_FLL_CLK_SRC_SFT)
>
>  /* FLL4 (0x07) */
>  #define NAU8825_FLL_REF_DIV_MASK               (0x3 << 10)
>
>  /* FLL5 (0x08) */
> -#define NAU8825_FLL_FILTER_SW_MASK             (0x1 << 14)
> +#define NAU8825_FLL_PDB_DAC_EN         (0x1 << 15)
> +#define NAU8825_FLL_LOOP_FTR_EN                (0x1 << 14)
> +#define NAU8825_FLL_FILTER_SW_MASK             (0x1 << 13)
> +#define NAU8825_FLL_FILTER_SW_N2               (0x1 << 13)
> +#define NAU8825_FLL_FILTER_SW_REF              (0x0 << 13)
>
>  /* FLL6 (0x9) */
>  #define NAU8825_DCO_EN_MASK                    (0x1 << 15)
> @@ -306,6 +315,9 @@
>  enum {
>         NAU8825_CLK_MCLK = 0,
>         NAU8825_CLK_INTERNAL,
> +       NAU8825_CLK_FLL_MCLK,
> +       NAU8825_CLK_FLL_BLK,
> +       NAU8825_CLK_FLL_FS,
>  };
>
>  struct nau8825 {
> --
> 1.9.1
>
