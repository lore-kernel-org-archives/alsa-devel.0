From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Set TLV_DB_SCALE_MUTE bit for
 cx5051 vmaster
Date: Sat, 16 Aug 2014 10:34:26 +0800
Message-ID: <CAN8ccibXnfcqthFGv9e1ivv-rx+NdQ56sOCTL4P5f30S-GkJSA@mail.gmail.com>
References: <1408009543-4789-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f48.google.com (mail-qg0-f48.google.com
 [209.85.192.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D25B2656F3
 for <alsa-devel@alsa-project.org>; Sat, 16 Aug 2014 04:34:27 +0200 (CEST)
Received: by mail-qg0-f48.google.com with SMTP id i50so2768309qgf.7
 for <alsa-devel@alsa-project.org>; Fri, 15 Aug 2014 19:34:26 -0700 (PDT)
In-Reply-To: <1408009543-4789-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Conexnat HD-audio driver has a workaround for cx5051 (aka CX20561)
> chip to add fake mute controls to each amp (commit 3868137e).  This
> implies the minimum-as-mute TLV bit in TLV for each corresponding
> control.  Meanwhile we build the virtual master from these, but the
> TLV bit is missing, even though the slaves have it.
>
> This patch simply adds the missing TLV_DB_SCALE_MUTE bit for vmaster,
> as already done in patch_sigmatel.c.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/patch_conexant.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/sound/pci/hda/patch_conexant.c
b/sound/pci/hda/patch_conexant.c
> index 7627a69ca6d7..6f2fa838b635 100644
> --- a/sound/pci/hda/patch_conexant.c
> +++ b/sound/pci/hda/patch_conexant.c
> @@ -26,6 +26,7 @@
>  #include <linux/module.h>
>  #include <sound/core.h>
>  #include <sound/jack.h>
> +#include <sound/tlv.h>
>
>  #include "hda_codec.h"
>  #include "hda_local.h"
> @@ -859,6 +860,11 @@ static int patch_conexant_auto(struct hda_codec
*codec)
>         if (err < 0)
>                 goto error;
>
> +       if (codec->vendor_id == 0x14f15051) {
> +               /* minimum value is actually mute */
> +               spec->gen.vmaster_tlv[3] |= TLV_DB_SCALE_MUTE;
> +       }
> +
>         codec->patch_ops = cx_auto_patch_ops;
>
>         /* Some laptops with Conexant chips show stalls in S3 resume,
> --

Does this mean that when there is no hardware mute switch, the driver
create a fake one using mindB of volume as mute ?

But this mean that the volume control and mute are not independent anymore,
just like those pulseaudio volume controls,  volume always change to zero
after mute and unmute
