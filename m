From: Dan Williams <dan.j.williams@gmail.com>
Subject: Re: [PATCH V2] [SCSI] async: Fixup arguments of async_synchronize_full_domain
 in alsa-soc
Date: Mon, 16 Jul 2012 15:56:57 -0700
Message-ID: <CAA9_cmcWaj_KWLz1m0sxCJNihVuGMQsbP53=1cPiEBBWiei7bg@mail.gmail.com>
References: <1342477026-8376-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1342477026-8376-1-git-send-email-marex@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Arjan van de Ven <arjan@linux.intel.com>, James Bottomley <JBottomley@parallels.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 16, 2012 at 3:17 PM, Marek Vasut <marex@denx.de> wrote:
[..]
>  sound/soc/soc-dapm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> V2: CC proper people, hopefully proper mailing list
>     Adjust the patch subject with proper tags
>
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index eded657..e491eb0 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -1572,7 +1572,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
>         struct snd_soc_dapm_context *d;
>         LIST_HEAD(up_list);
>         LIST_HEAD(down_list);
> -       LIST_HEAD(async_domain);
> +       ASYNC_DOMAIN_EXCLUSIVE(async_domain);
>         enum snd_soc_bias_level bias;
>

Thanks.  This was folded into the resend that was submitted week [1]

Regards,
Dan

[1]: http://marc.info/?l=linux-scsi&m=134188683322951&w=2
