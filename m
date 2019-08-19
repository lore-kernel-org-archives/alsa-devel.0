From: Hui Peng <benquike@gmail.com>
Subject: Re: [PATCH] Fix an OOB bug in uac_mixer_unit_bmControls
Date: Mon, 19 Aug 2019 18:01:34 -0400
Message-ID: <CAKpmkkWuZW-eyQxp+Xe3qovf6aiJ0++bpcf7R92Vj=h1ijjBtg@mail.gmail.com>
References: <20190819220005.10178-1-benquike@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32A9BF8011F
 for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2019 00:01:47 +0200 (CEST)
Received: by mail-oi1-x244.google.com with SMTP id k22so2534733oiw.11
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2019 15:01:47 -0700 (PDT)
In-Reply-To: <20190819220005.10178-1-benquike@gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: security@kernel.org
Cc: linux-kernel@vger.kernel.org, Mathias Payer <mathias.payer@nebelwelt.net>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sorry, this is the wrong patch. I will send it again.

On Mon, Aug 19, 2019 at 6:00 PM Hui Peng <benquike@gmail.com> wrote:

> `uac_mixer_unit_get_channels` calls `uac_mixer_unit_bmControls`
> to get pointer to bmControls field. The current implementation of
> `uac_mixer_unit_get_channels` does properly check the size of
> uac_mixer_unit_descriptor descriptor and may allow OOB access
> in `uac_mixer_unit_bmControls`.
>
> Reported-by: Hui Peng <benquike@gmail.com>
> Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
>  sound/usb/mixer.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index b5927c3d5bc0..00e6274a63c3 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -738,28 +738,39 @@ static int get_cluster_channels_v3(struct
> mixer_build *state, unsigned int clust
>  static int uac_mixer_unit_get_channels(struct mixer_build *state,
>                                        struct uac_mixer_unit_descriptor
> *desc)
>  {
> -       int mu_channels;
> +       int mu_channels = 0;
>         void *c;
>
> -       if (desc->bLength < sizeof(*desc))
> -               return -EINVAL;
>         if (!desc->bNrInPins)
>                 return -EINVAL;
> -       if (desc->bLength < sizeof(*desc) + desc->bNrInPins)
> -               return -EINVAL;
>
>         switch (state->mixer->protocol) {
>         case UAC_VERSION_1:
> +               // limit derived from uac_mixer_unit_bmControls
> +               if (desc->bLength < sizeof(*desc) + desc->bNrInPins + 4)
> +                       return 0;
> +
> +               mu_channels = uac_mixer_unit_bNrChannels(desc);
> +               break;
> +
>         case UAC_VERSION_2:
> -       default:
> -               if (desc->bLength < sizeof(*desc) + desc->bNrInPins + 1)
> +               // limit derived from uac_mixer_unit_bmControls
> +               if (desc->bLength < sizeof(*desc) + desc->bNrInPins + 6)
>                         return 0; /* no bmControls -> skip */
> +
>                 mu_channels = uac_mixer_unit_bNrChannels(desc);
>                 break;
>         case UAC_VERSION_3:
> +               // limit derived from uac_mixer_unit_bmControls
> +               if (desc->bLength < sizeof(*desc) + desc->bNrInPins + 2)
> +                       return 0; /* no bmControls -> skip */
> +
>                 mu_channels = get_cluster_channels_v3(state,
>                                 uac3_mixer_unit_wClusterDescrID(desc));
>                 break;
> +
> +       default:
> +               break;
>         }
>
>         if (!mu_channels)
> --
> 2.22.1
>
>
