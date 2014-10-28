From: Geoffrey McRae <geoff@spacevs.com>
Subject: Re: [PATCH 1/2] ALSA: hda - Fix probing and stuttering
 on CMI8888 HD-audio controller
Date: Wed, 29 Oct 2014 07:21:24 +1100
Message-ID: <20141029072124.2cc32661@sarah.home.spacevs.com>
References: <1407328755-1021-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.spacevs.com (mail1.spacevs.com [202.174.111.252])
 by alsa0.perex.cz (Postfix) with ESMTP id EF4CE266679
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 21:21:29 +0100 (CET)
Received: from localhost (mail1.spacevs.com [127.0.0.1])
 by mail1.spacevs.com (Postfix) with ESMTP id A7C1D281F8
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 07:21:26 +1100 (EST)
Received: from mail1.spacevs.com ([127.0.0.1])
 by localhost (mail1.spacevs.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o-HS_RRVD-qj for <alsa-devel@alsa-project.org>;
 Wed, 29 Oct 2014 07:21:26 +1100 (EST)
Received: from sarah.home.spacevs.com (122-149-209-199.static.dsl.dodo.com.au
 [122.149.209.199])
 by mail1.spacevs.com (Postfix) with ESMTPSA id 28DB070056
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 07:21:26 +1100 (EST)
In-Reply-To: <1407328755-1021-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I can confirm that disable of MSI is required as even Windows 7
64bit does not enable this for Intel HDA. Out of curiosity I altered
the driver to use MSI-X with the same results, interrupts are never
received even though the PCI caps state that MSI is supported.

Playback is very poor and stutters if I do not allow snoop by
commenting out "case AZX_DRIVER_CMEDIA:" in azx_check_snoop_available.

I can also confirm that AZX_DCAPS_POSFIX_LPIB is required on my
hardware also.

http://www.alsa-project.org/db/?f=512e0135e82a644bb9d2fe8f6b5e2be1cb10c53b

Things of note:

ASUS Sabertooth 990FX r1 with bugged IOMMU
Linux does not load correctly without IOMMU enabled, so disabling to
test is not an option.

On Wed,  6 Aug 2014 14:39:14 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> ASUS Phoebus with CMI8888 HD-audio chip (PCI id 13f6:5011) doesn't
> work with HD-audio driver as is because of some weird nature.  For
> making DMA properly working, we need to disable MSI.  The position
> report buffer doesn't work, thus we need to force reading LPIB
> instead.  And yet, the codec CORB/RIRB communication gives errors
> unless we disable the snooping (caching).
> 
> In this patch, all these workarounds are added as a quirk for the
> device.  The HD-audio *codec* chip needs yet another workaround, but
> it'll be provided in the succeeding patch.
> 
> Reported-and-tested-by: Vincent Lejeune <vljn@ovi.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/hda_intel.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 5db1948699d8..aa302fb03fc5 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -265,6 +265,7 @@ enum {
>  	AZX_DRIVER_TERA,
>  	AZX_DRIVER_CTX,
>  	AZX_DRIVER_CTHDA,
> +	AZX_DRIVER_CMEDIA,
>  	AZX_DRIVER_GENERIC,
>  	AZX_NUM_DRIVERS, /* keep this as last entry */
>  };
> @@ -330,6 +331,7 @@ static char *driver_short_names[] = {
>  	[AZX_DRIVER_TERA] = "HDA Teradici", 
>  	[AZX_DRIVER_CTX] = "HDA Creative", 
>  	[AZX_DRIVER_CTHDA] = "HDA Creative",
> +	[AZX_DRIVER_CMEDIA] = "HDA C-Media",
>  	[AZX_DRIVER_GENERIC] = "HD-Audio Generic",
>  };
>  
> @@ -1373,6 +1375,7 @@ static void azx_check_snoop_available(struct
> azx *chip) snoop = false;
>  		break;
>  	case AZX_DRIVER_CTHDA:
> +	case AZX_DRIVER_CMEDIA:
>  		snoop = false;
>  		break;
>  	}
> @@ -2154,6 +2157,10 @@ static const struct pci_device_id azx_ids[] = {
>  	  .driver_data = AZX_DRIVER_CTX | AZX_DCAPS_CTX_WORKAROUND |
>  	  AZX_DCAPS_RIRB_PRE_DELAY | AZX_DCAPS_POSFIX_LPIB },
>  #endif
> +	/* CM8888 */
> +	{ PCI_DEVICE(0x13f6, 0x5011),
> +	  .driver_data = AZX_DRIVER_CMEDIA |
> +	  AZX_DCAPS_NO_MSI | AZX_DCAPS_POSFIX_LPIB },
>  	/* Vortex86MX */
>  	{ PCI_DEVICE(0x17f3, 0x3010), .driver_data =
> AZX_DRIVER_GENERIC }, /* VMware HDAudio */
