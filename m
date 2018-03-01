From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] sound/pci/ice1712: replace strcpy()
	with strlcpy()
Date: Thu, 1 Mar 2018 16:21:55 +0200
Message-ID: <CAHp75VfLvYJfX=zTy=XUyL3AcvE+h3yTXwjDGdaFQk9mNjF8GA@mail.gmail.com>
References: <20180301114535.bf3ibzcpvohyjweu@gmail.com>
 <CAHp75Vf6kfPE_sRPj_mLMvLQfn9Fe9B_MeXqnGAHGAdzR7HX+Q@mail.gmail.com>
 <20180301141707.cp5dc6zbh6bur4xw@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 by alsa0.perex.cz (Postfix) with ESMTP id CE09D26794C
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 15:21:56 +0100 (CET)
Received: by mail-qk0-f195.google.com with SMTP id s188so7710256qkb.2
 for <alsa-devel@alsa-project.org>; Thu, 01 Mar 2018 06:21:56 -0800 (PST)
In-Reply-To: <20180301141707.cp5dc6zbh6bur4xw@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 1, 2018 at 4:17 PM, Joey Pabalinas <joeypabalinas@gmail.com> wrote:
> Replace unsafe usages of strcpy() to copy the name
> argument into the sid.name buffer with strlcpy()
> to guard against possible buffer overflows.
>
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/sound/pci/ice1712/juli.c b/sound/pci/ice1712/juli.c
> index 0dbaccf61f33270608..21806bab4757241a9e 100644
> --- a/sound/pci/ice1712/juli.c
> +++ b/sound/pci/ice1712/juli.c
> @@ -27,6 +27,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> +#include <linux/string.h>
>  #include <sound/core.h>
>  #include <sound/tlv.h>
>
> @@ -425,10 +426,9 @@ DECLARE_TLV_DB_SCALE(juli_master_db_scale, -6350, 50, 1);
>  static struct snd_kcontrol *ctl_find(struct snd_card *card,
>                                      const char *name)
>  {
> -       struct snd_ctl_elem_id sid;
> -       memset(&sid, 0, sizeof(sid));
> -       /* FIXME: strcpy is bad. */
> -       strcpy(sid.name, name);
> +       struct snd_ctl_elem_id sid = {0};
> +
> +       strlcpy(sid.name, name, sizeof(sid.name));
>         sid.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
>         return snd_ctl_find_id(card, &sid);
>  }
> diff --git a/sound/pci/ice1712/quartet.c b/sound/pci/ice1712/quartet.c
> index d145b5eb7ff86d978d..5bc836241c977feb51 100644
> --- a/sound/pci/ice1712/quartet.c
> +++ b/sound/pci/ice1712/quartet.c
> @@ -26,6 +26,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> +#include <linux/string.h>
>  #include <sound/core.h>
>  #include <sound/tlv.h>
>  #include <sound/info.h>
> @@ -785,10 +786,9 @@ DECLARE_TLV_DB_SCALE(qtet_master_db_scale, -6350, 50, 1);
>  static struct snd_kcontrol *ctl_find(struct snd_card *card,
>                                      const char *name)
>  {
> -       struct snd_ctl_elem_id sid;
> -       memset(&sid, 0, sizeof(sid));
> -       /* FIXME: strcpy is bad. */
> -       strcpy(sid.name, name);
> +       struct snd_ctl_elem_id sid = {0};
> +
> +       strlcpy(sid.name, name, sizeof(sid.name));
>         sid.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
>         return snd_ctl_find_id(card, &sid);
>  }
> --
> 2.16.2



-- 
With Best Regards,
Andy Shevchenko
