From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: Re: [PATCH] ASoC: wm5102: Use put_unaligned_be16
Date: Sun, 28 Dec 2014 16:35:00 +0530
Message-ID: <CAK-LDb+i8ATb5GrA6=dx5Y6EZSct+A6epXwNdEoVN4797Yzmqw@mail.gmail.com>
References: <20141226044457.GA12777@vaishali-Ideapad-Z570>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 232A8260506
 for <alsa-devel@alsa-project.org>; Sun, 28 Dec 2014 12:05:01 +0100 (CET)
Received: by mail-wg0-f49.google.com with SMTP id n12so17104909wgh.36
 for <alsa-devel@alsa-project.org>; Sun, 28 Dec 2014 03:05:00 -0800 (PST)
In-Reply-To: <20141226044457.GA12777@vaishali-Ideapad-Z570>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 26, 2014 at 10:14 AM, Vaishali Thakkar
<vthakkar1994@gmail.com> wrote:
> This patch introduces the use of function put_unaligned_be16.
>
> This is done using Coccinelle and semantic patch used is as follows:
>
> @a@
> typedef u16, __be16, uint16_t;
> {u16,__be16,uint16_t} e16;
> identifier tmp;
> expression ptr;
> expression y,e;
> type T;
> @@
>
> - tmp = cpu_to_be16(y);
>
> <+... when != tmp
> (
> - memcpy(ptr, (T)&tmp, \(2\|sizeof(u16)\|sizeof(__be16)\|sizeof(uint16_t)\|sizeof(e16)\));
> + put_unaligned_be16(y,ptr);
> |
> - memcpy(ptr, (T)&tmp, ...);
> + put_unaligned_be16(y,ptr);
> )
> ...+>
> ? tmp = e
>
> @@ type T; identifier a.tmp; @@
>
> - T tmp;
> ...when != tmp
>
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
> ---
>  sound/soc/codecs/wm5102.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
> index f602349..fec21f9 100644
> --- a/sound/soc/codecs/wm5102.c
> +++ b/sound/soc/codecs/wm5102.c
> @@ -28,6 +28,7 @@
>
>  #include <linux/mfd/arizona/core.h>
>  #include <linux/mfd/arizona/registers.h>
> +#include <asm/unaligned.h>
>
>  #include "arizona.h"
>  #include "wm5102.h"
> @@ -617,11 +618,11 @@ static int wm5102_out_comp_coeff_get(struct snd_kcontrol *kcontrol,
>  {
>         struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
>         struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
> -       uint16_t data;
>
>         mutex_lock(&codec->mutex);
> -       data = cpu_to_be16(arizona->dac_comp_coeff);
> -       memcpy(ucontrol->value.bytes.data, &data, sizeof(data));
> +
> +       put_unaligned_be16(arizona->dac_comp_coeff,
> +                          ucontrol->value.bytes.data);
>         mutex_unlock(&codec->mutex);
>
>         return 0;
> --
> 1.9.1
>

Hello...Can someone please review my patch so that I can have idea
about I am on a right way or not??
I think this is missed by developers.

Thank You.

-- 
Vaishali
