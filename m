From: Wang Xingchao <wangxingchao2011@gmail.com>
Subject: Re: [PATCH 1/1] hda_intel: activate COMBO mode for
	Intel client chipsets
Date: Mon, 16 Jul 2012 14:10:07 +0800
Message-ID: <CA+v+29hZjJ4MLaJzmjW-Xi2eHxyhhymhjRZpXghvjxrHdcgzRg@mail.gmail.com>
References: <1339709033-3583-1-git-send-email-seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 376AD24B78
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jul 2012 08:10:28 +0200 (CEST)
Received: by qcse14 with SMTP id e14so3218663qcs.38
	for <alsa-devel@alsa-project.org>; Sun, 15 Jul 2012 23:10:27 -0700 (PDT)
In-Reply-To: <1339709033-3583-1-git-send-email-seth.heasley@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seth Heasley <seth.heasley@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, James Ralston <james.d.ralston@intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Seth,

2012/6/15 Seth Heasley <seth.heasley@intel.com>:
> This patch activates the COMBO position_fix for recent Intel client chipsets.  COMBO mode is the recommended setting for Intel chipsets and eliminates HD audio warnings in dmesg.  This patch has been tested on Lynx Point, Panther Point, and Cougar Pont.

Haswell HDMI audio works now on Sharkbay mobile platform, so i would
like to test whether this patch is useful for Haswell. Would you tell
me how to finish the test to prove it works better?

thanks
--xingchao

>
> Signed-off-by: Seth Heasley <seth.heasley@intel.com>
> ---
>  sound/pci/hda/hda_intel.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 2b6392b..466a88c 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -535,6 +535,7 @@ enum {
>  #define AZX_DCAPS_BUFSIZE      (1 << 21)       /* no buffer size alignment */
>  #define AZX_DCAPS_ALIGN_BUFSIZE        (1 << 22)       /* buffer size alignment */
>  #define AZX_DCAPS_4K_BDLE_BOUNDARY (1 << 23)   /* BDLE in 4k boundary */
> +#define AZX_DCAPS_POSFIX_COMBO  (1 << 24)      /* Use COMBO as default */
>
>  /* quirks for ATI SB / AMD Hudson */
>  #define AZX_DCAPS_PRESET_ATI_SB \
> @@ -2728,6 +2729,10 @@ static int __devinit check_position_fix(struct azx *chip, int fix)
>                 snd_printd(SFX "Using LPIB position fix\n");
>                 return POS_FIX_LPIB;
>         }
> +       if (chip->driver_caps & AZX_DCAPS_POSFIX_COMBO) {
> +               snd_printd(SFX "Using COMBO position fix\n");
> +               return POS_FIX_COMBO;
> +       }
>         return POS_FIX_AUTO;
>  }
>
> @@ -3240,7 +3245,7 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
>         /* CPT */
>         { PCI_DEVICE(0x8086, 0x1c20),
>           .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP |
> -         AZX_DCAPS_BUFSIZE },
> +         AZX_DCAPS_BUFSIZE | AZX_DCAPS_POSFIX_COMBO },
>         /* PBG */
>         { PCI_DEVICE(0x8086, 0x1d20),
>           .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP |
> @@ -3248,11 +3253,11 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
>         /* Panther Point */
>         { PCI_DEVICE(0x8086, 0x1e20),
>           .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP |
> -         AZX_DCAPS_BUFSIZE},
> +         AZX_DCAPS_BUFSIZE | AZX_DCAPS_POSFIX_COMBO },
>         /* Lynx Point */
>         { PCI_DEVICE(0x8086, 0x8c20),
>           .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP |
> -         AZX_DCAPS_BUFSIZE},
> +         AZX_DCAPS_BUFSIZE | AZX_DCAPS_POSFIX_COMBO },
>         /* SCH */
>         { PCI_DEVICE(0x8086, 0x811b),
>           .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_SCH_SNOOP |
> --
> 1.7.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
