From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ALSA: hda - Add Coffelake PCI ID
Date: Wed, 14 Jun 2017 10:15:48 +0530
Message-ID: <20170614044548.GG13020@localhost>
References: <1497414116-22733-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id DA1E026711B
 for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2017 06:43:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1497414116-22733-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Megha Dey <megha.dey@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 14, 2017 at 09:51:56AM +0530, Subhransu S. Prusty wrote:
> From: Megha Dey <megha.dey@intel.com>
> 
> Coffelake is another Intel part, so need to add PCI ID for it.
> 
> Signed-off-by: Megha Dey <megha.dey@intel.com>
> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>

Acked-By: Vinod Koul <vinod.koul@intel.com>


> ---
>  sound/pci/hda/hda_intel.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 1770f085c2a6..e3c696c46a21 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -371,9 +371,10 @@ enum {
>  #define IS_KBL_H(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa2f0)
>  #define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
>  #define IS_GLK(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x3198)
> +#define IS_CFL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa348)
>  #define IS_SKL_PLUS(pci) (IS_SKL(pci) || IS_SKL_LP(pci) || IS_BXT(pci)) || \
>  			IS_KBL(pci) || IS_KBL_LP(pci) || IS_KBL_H(pci)	|| \
> -			IS_GLK(pci)
> +			IS_GLK(pci) || IS_CFL(pci)

Takashi, given the pattern here that device are SKL derivatives, this would
blow up, can we do something here please.

I am thinking using AXZ_DCAPS foo rather than IS_foo()

>  
>  static char *driver_short_names[] = {
>  	[AZX_DRIVER_ICH] = "HDA Intel",
> @@ -2378,6 +2379,9 @@ static void azx_shutdown(struct pci_dev *pci)
>  	/* Kabylake-H */
>  	{ PCI_DEVICE(0x8086, 0xa2f0),
>  	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
> +	/* Coffelake */
> +	{ PCI_DEVICE(0x8086, 0xa348),
> +	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE},
>  	/* Broxton-P(Apollolake) */
>  	{ PCI_DEVICE(0x8086, 0x5a98),
>  	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_BROXTON },
> -- 
> 1.9.1
> 

-- 
~Vinod
