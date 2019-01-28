From: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH] ASoC: max98090: support 20-bit and 24-bit
	audio format
Date: Mon, 28 Jan 2019 18:20:47 +0800
Message-ID: <CA+Px+wUzd5x4OjT6qh0WWu9L0AASXi=50XTAZdMZ3UKOy9=-GQ@mail.gmail.com>
References: <20190128091507.211202-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by alsa0.perex.cz (Postfix) with ESMTP id E0DBF267456
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 11:20:59 +0100 (CET)
Received: by mail-ot1-f66.google.com with SMTP id s13so14161155otq.4
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 02:20:59 -0800 (PST)
In-Reply-To: <20190128091507.211202-1-tzungbi@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Dylan Reid <dgreid@google.com>, Jimmy Cheng-Yi Chiang <cychiang@google.com>
List-Id: alsa-devel@alsa-project.org

Missing a parenthesis for M98090_FORMAT_S20_LE.  Please ignore this patch.

On Mon, Jan 28, 2019 at 5:15 PM Tzung-Bi Shih <tzungbi@google.com> wrote:

> From datasheet of max98090:
> If RJ = 1,
>   WS = 00, 16 bits
>   WS = 01, 20 bits
>   WS = 10, 24 bits
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
> ---
>  sound/soc/codecs/max98090.c | 16 +++++++++++++++-
>  sound/soc/codecs/max98090.h |  3 +++
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
> index c97f21836c66..0ecc2f1accb5 100644
> --- a/sound/soc/codecs/max98090.c
> +++ b/sound/soc/codecs/max98090.c
> @@ -1942,7 +1942,21 @@ static int max98090_dai_hw_params(struct
> snd_pcm_substream *substream,
>         switch (params_width(params)) {
>         case 16:
>                 snd_soc_component_update_bits(component,
> M98090_REG_INTERFACE_FORMAT,
> -                       M98090_WS_MASK, 0);
> +                       M98090_RJ_MASK, M98090_RJ_MASK);
> +               snd_soc_component_update_bits(component,
> M98090_REG_INTERFACE_FORMAT,
> +                       M98090_WS_MASK, M98090_FORMAT_S16_LE);
> +               break;
> +       case 20:
> +               snd_soc_component_update_bits(component,
> M98090_REG_INTERFACE_FORMAT,
> +                       M98090_RJ_MASK, M98090_RJ_MASK);
> +               snd_soc_component_update_bits(component,
> M98090_REG_INTERFACE_FORMAT,
> +                       M98090_WS_MASK, M98090_FORMAT_S20_LE;
> +               break;
> +       case 24:
> +               snd_soc_component_update_bits(component,
> M98090_REG_INTERFACE_FORMAT,
> +                       M98090_RJ_MASK, M98090_RJ_MASK);
> +               snd_soc_component_update_bits(component,
> M98090_REG_INTERFACE_FORMAT,
> +                       M98090_WS_MASK, M98090_FORMAT_S24_LE);
>                 break;
>         default:
>                 return -EINVAL;
> diff --git a/sound/soc/codecs/max98090.h b/sound/soc/codecs/max98090.h
> index b1572a2d19da..9088f9d64ff2 100644
> --- a/sound/soc/codecs/max98090.h
> +++ b/sound/soc/codecs/max98090.h
> @@ -706,6 +706,9 @@
>  #define M98090_WS_SHIFT                        0
>  #define M98090_WS_WIDTH                        2
>  #define M98090_WS_NUM                  (1<<M98090_WS_WIDTH)
> +#define M98090_FORMAT_S16_LE           (0<<0)
> +#define M98090_FORMAT_S20_LE           (1<<0)
> +#define M98090_FORMAT_S24_LE           (2<<0)
>
>  /*
>   * M98090_REG_TDM_CONTROL
> --
> 2.20.1.495.gaa96b0ce6b-goog
>
>
