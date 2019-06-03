From: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH] ASoC: core: move DAI pre-links initiation
	to snd_soc_instantiate_card
Date: Mon, 3 Jun 2019 10:40:36 +0800
Message-ID: <CA+Px+wXJsar1X=1EdDvMDvPv4DzDG+BmOgSopAqU48Y3Qa=acg@mail.gmail.com>
References: <20190530073229.121032-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 21FD5F896CE
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 04:40:49 +0200 (CEST)
Received: by mail-ot1-x341.google.com with SMTP id t24so916685otl.12
 for <alsa-devel@alsa-project.org>; Sun, 02 Jun 2019 19:40:49 -0700 (PDT)
In-Reply-To: <20190530073229.121032-1-tzungbi@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Dylan Reid <dgreid@google.com>, Jimmy Cheng-Yi Chiang <cychiang@google.com>
List-Id: alsa-devel@alsa-project.org

Please ignore this patch.

On Thu, May 30, 2019 at 3:32 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 2d3520fca613..82ff384753c7 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2072,6 +2072,15 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
>         mutex_lock(&client_mutex);
>         mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_INIT);
>
> +       for_each_card_prelinks(card, i, dai_link) {
> +               ret = soc_init_dai_link(card, dai_link);
> +               if (ret) {
> +                       dev_err(card->dev, "ASoC: failed to init link %s: %d\n",
> +                               dai_link->name, ret);
> +                       goto probe_end;
> +               }
> +       }
> +
>         card->dapm.bias_level = SND_SOC_BIAS_OFF;
>         card->dapm.dev = card->dev;
>         card->dapm.card = card;
> @@ -2241,7 +2250,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
>         snd_soc_dapm_sync(&card->dapm);
>
>  probe_end:
> -       if (ret < 0)
> +       if (ret < 0 && ret != -EPROBE_DEFER)
>                 soc_cleanup_card_resources(card);
Should not call soc_cleanup_card_resources() if soc_init_dai_link()
returns fail.  Some context has not initialized yet in the case.

>
>         mutex_unlock(&card->mutex);
