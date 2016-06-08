From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: cs53l30: Correct clock inversion
	check
Date: Wed, 8 Jun 2016 16:09:38 -0700
Message-ID: <CAGoOwPTbnYx-H2w8rzd8hHmQ9Z5asfUVa7vJyS4LK_3y3t6DUA@mail.gmail.com>
References: <1465426980-10924-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f67.google.com (mail-vk0-f67.google.com
 [209.85.213.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 175C626574C
 for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2016 01:09:40 +0200 (CEST)
Received: by mail-vk0-f67.google.com with SMTP id a126so3761620vkb.1
 for <alsa-devel@alsa-project.org>; Wed, 08 Jun 2016 16:09:40 -0700 (PDT)
In-Reply-To: <1465426980-10924-1-git-send-email-nicoleotsuka@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Brian Austin <brian.austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 8, 2016 at 4:03 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> SND_SOC_DAIFMT_IB_NF = 0x3 (11b) | SND_SOC_DAIFMT_IB_IF = 0x4 (100b)
> creates a mask 0x7 (111b) which also includes SND_SOC_DAIFMT_IB_NF

Oops, here should be NB_IF for (10b). Will send v2. Please ignore this one.

> = 0x2 (10b).
>
> So this patch uses the traditional way to check the clock inversion.
>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  sound/soc/codecs/cs53l30.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
> index ac90dd7..62daa0c 100644
> --- a/sound/soc/codecs/cs53l30.c
> +++ b/sound/soc/codecs/cs53l30.c
> @@ -598,8 +598,14 @@ static int cs53l30_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>         }
>
>         /* Check to see if the SCLK is inverted */
> -       if (fmt & (SND_SOC_DAIFMT_IB_NF | SND_SOC_DAIFMT_IB_IF))
> +       switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +       case SND_SOC_DAIFMT_IB_NF:
> +       case SND_SOC_DAIFMT_IB_IF:
>                 aspcfg ^= CS53L30_ASP_SCLK_INV;
> +               break;
> +       default:
> +               break;
> +       }
>
>         regmap_update_bits(priv->regmap, CS53L30_ASPCFG_CTL,
>                            CS53L30_ASP_MS | CS53L30_ASP_SCLK_INV, aspcfg);
> --
> 2.1.4
>
