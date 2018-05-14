From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: [RESEND PATCH v4 4/4] ALSA: usb-audio: UAC3: Parse
 Input Terminal number of channels.
Date: Tue, 15 May 2018 00:05:40 +0300
Message-ID: <CAB=otbRxTo1u-WL=WCkhuQe_xTmRcg1AUm4D0D7MTX7Bm1J8Aw@mail.gmail.com>
References: <20180511152537.32267-5-jorge.sanjuan@codethink.co.uk>
 <20180514110342.23683-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
 [209.85.128.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A0D4266EDF
 for <alsa-devel@alsa-project.org>; Mon, 14 May 2018 23:05:41 +0200 (CEST)
Received: by mail-wr0-f193.google.com with SMTP id y15-v6so13738193wrg.11
 for <alsa-devel@alsa-project.org>; Mon, 14 May 2018 14:05:41 -0700 (PDT)
In-Reply-To: <20180514110342.23683-1-jorge.sanjuan@codethink.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 14, 2018 at 2:03 PM, Jorge Sanjuan
<jorge.sanjuan@codethink.co.uk> wrote:
> Obtain the number of channels for the Input Terminal from the
> Logical Cluster Descriptor. This achieves a useful minimal parsing
> of this unit so it can be used in other units in the topology.

Usually 'patch resend' means resend without any changes, and if there
are updates in the patch - it's a new version.

By the way, as I already said in comments to patch 1/4 [1], I verified
this patch successfully.

Reviewed-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Tested-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-May/136044.html

>
> Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
> ---
>  sound/usb/mixer.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index 431f3c319839..99804cd4aed6 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -904,8 +904,12 @@ static int check_input_term(struct mixer_build *state, int id,
>                                 term->id = id;
>                                 term->type = le16_to_cpu(d->wTerminalType);
>
> -                               /* REVISIT: UAC3 IT doesn't have channels/cfg */
> -                               term->channels = 0;
> +                               err = get_cluster_channels_v3(state, le16_to_cpu(d->wClusterDescrID));
> +                               if (err < 0)
> +                                       return err;
> +                               term->channels = err;
> +
> +                               /* REVISIT: UAC3 IT doesn't have channels cfg */
>                                 term->chconfig = 0;
>
>                                 term->name = le16_to_cpu(d->wTerminalDescrStr);
> --
> 2.11.0
>
