From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ALSA: hda - Add Coffelake PCI ID
Date: Fri, 16 Jun 2017 13:24:50 +0530
Message-ID: <20170616075449.GB19154@localhost>
References: <1497414116-22733-1-git-send-email-subhransu.s.prusty@intel.com>
 <20170614044548.GG13020@localhost> <s5hpoe7ta2q.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D2C52669F3
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 09:52:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hpoe7ta2q.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, lgirdwood@gmail.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Megha Dey <megha.dey@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 14, 2017 at 07:25:17AM +0200, Takashi Iwai wrote:
> On Wed, 14 Jun 2017 06:45:48 +0200,
> Vinod Koul wrote:
> > > ---
> > >  sound/pci/hda/hda_intel.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > > index 1770f085c2a6..e3c696c46a21 100644
> > > --- a/sound/pci/hda/hda_intel.c
> > > +++ b/sound/pci/hda/hda_intel.c
> > > @@ -371,9 +371,10 @@ enum {
> > >  #define IS_KBL_H(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa2f0)
> > >  #define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
> > >  #define IS_GLK(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x3198)
> > > +#define IS_CFL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa348)
> > >  #define IS_SKL_PLUS(pci) (IS_SKL(pci) || IS_SKL_LP(pci) || IS_BXT(pci)) || \
> > >  			IS_KBL(pci) || IS_KBL_LP(pci) || IS_KBL_H(pci)	|| \
> > > -			IS_GLK(pci)
> > > +			IS_GLK(pci) || IS_CFL(pci)
> > 
> > Takashi, given the pattern here that device are SKL derivatives, this would
> > blow up, can we do something here please.
> > 
> > I am thinking using AXZ_DCAPS foo rather than IS_foo()
> 
> AZX_DCAPS bit is precious.  An easier option is to add a new
> AZX_DRIVER_SKL.  An untested patch is like below.  The shortname
> string is kept for not breaking the compatibility.

This makese sense to me.. Will get it next first thing on monday

> But while writing this, I noticed that Broxton-T seems forgotten.
> Doesn't it need the similar workaround for SKL+ chips?

It should have same stuff as other BXTN ones, I will try to find this part,
and if possible test this

> 
> 
> thanks,
> 
> Takashi
> 
> ---
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index e3c696c46a21..07ea7f48aa01 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -263,6 +263,7 @@ enum {
>  	AZX_DRIVER_ICH,
>  	AZX_DRIVER_PCH,
>  	AZX_DRIVER_SCH,
> +	AZX_DRIVER_SKL,
>  	AZX_DRIVER_HDMI,
>  	AZX_DRIVER_ATI,
>  	AZX_DRIVER_ATIHDMI,
> @@ -364,22 +365,13 @@ enum {
>  					((pci)->device == 0x0d0c) || \
>  					((pci)->device == 0x160c))
>  
> -#define IS_SKL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa170)
> -#define IS_SKL_LP(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x9d70)
> -#define IS_KBL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa171)
> -#define IS_KBL_LP(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x9d71)
> -#define IS_KBL_H(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa2f0)
>  #define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
> -#define IS_GLK(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x3198)
> -#define IS_CFL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa348)
> -#define IS_SKL_PLUS(pci) (IS_SKL(pci) || IS_SKL_LP(pci) || IS_BXT(pci)) || \
> -			IS_KBL(pci) || IS_KBL_LP(pci) || IS_KBL_H(pci)	|| \
> -			IS_GLK(pci) || IS_CFL(pci)
>  
>  static char *driver_short_names[] = {
>  	[AZX_DRIVER_ICH] = "HDA Intel",
>  	[AZX_DRIVER_PCH] = "HDA Intel PCH",
>  	[AZX_DRIVER_SCH] = "HDA Intel MID",
> +	[AZX_DRIVER_SKL] = "HDA Intel PCH", /* kept old name for compatibility */
>  	[AZX_DRIVER_HDMI] = "HDA Intel HDMI",
>  	[AZX_DRIVER_ATI] = "HDA ATI SB",
>  	[AZX_DRIVER_ATIHDMI] = "HDA ATI HDMI",
> @@ -643,13 +635,13 @@ static void hda_intel_init_chip(struct azx *chip, bool full_reset)
>  
>  	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
>  		snd_hdac_set_codec_wakeup(bus, true);
> -	if (IS_SKL_PLUS(pci)) {
> +	if (chip->driver_type == AZX_DRIVER_SKL) {
>  		pci_read_config_dword(pci, INTEL_HDA_CGCTL, &val);
>  		val = val & ~INTEL_HDA_CGCTL_MISCBDCGE;
>  		pci_write_config_dword(pci, INTEL_HDA_CGCTL, val);
>  	}
>  	azx_init_chip(chip, full_reset);
> -	if (IS_SKL_PLUS(pci)) {
> +	if (chip->driver_type == AZX_DRIVER_SKL) {
>  		pci_read_config_dword(pci, INTEL_HDA_CGCTL, &val);
>  		val = val | INTEL_HDA_CGCTL_MISCBDCGE;
>  		pci_write_config_dword(pci, INTEL_HDA_CGCTL, val);
> @@ -1074,9 +1066,11 @@ static int azx_resume(struct device *dev)
>   */
>  static int azx_freeze_noirq(struct device *dev)
>  {
> +	struct snd_card *card = dev_get_drvdata(dev);
> +	struct azx *chip = card->private_data;
>  	struct pci_dev *pci = to_pci_dev(dev);
>  
> -	if (IS_SKL_PLUS(pci))
> +	if (chip->driver_type == AZX_DRIVER_SKL)
>  		pci_set_power_state(pci, PCI_D3hot);
>  
>  	return 0;
> @@ -1084,9 +1078,11 @@ static int azx_freeze_noirq(struct device *dev)
>  
>  static int azx_thaw_noirq(struct device *dev)
>  {
> +	struct snd_card *card = dev_get_drvdata(dev);
> +	struct azx *chip = card->private_data;
>  	struct pci_dev *pci = to_pci_dev(dev);
>  
> -	if (IS_SKL_PLUS(pci))
> +	if (chip->driver_type == AZX_DRIVER_SKL)
>  		pci_set_power_state(pci, PCI_D0);
>  
>  	return 0;
> @@ -1496,7 +1492,7 @@ static int check_position_fix(struct azx *chip, int fix)
>  		dev_dbg(chip->card->dev, "Using LPIB position fix\n");
>  		return POS_FIX_LPIB;
>  	}
> -	if (IS_SKL_PLUS(chip->pci)) {
> +	if (chip->driver_type == AZX_DRIVER_SKL) {
>  		dev_dbg(chip->card->dev, "Using SKL position fix\n");
>  		return POS_FIX_SKL;
>  	}
> @@ -1797,7 +1793,7 @@ static int azx_first_init(struct azx *chip)
>  		return -ENXIO;
>  	}
>  
> -	if (IS_SKL_PLUS(pci))
> +	if (chip->driver_type == AZX_DRIVER_SKL)
>  		snd_hdac_bus_parse_capabilities(bus);
>  
>  	/*
> @@ -2366,31 +2362,31 @@ static const struct pci_device_id azx_ids[] = {
>  	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
>  	/* Sunrise Point */
>  	{ PCI_DEVICE(0x8086, 0xa170),
> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
> +	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
>  	/* Sunrise Point-LP */
>  	{ PCI_DEVICE(0x8086, 0x9d70),
> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
> +	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
>  	/* Kabylake */
>  	{ PCI_DEVICE(0x8086, 0xa171),
> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
> +	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
>  	/* Kabylake-LP */
>  	{ PCI_DEVICE(0x8086, 0x9d71),
> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
> +	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
>  	/* Kabylake-H */
>  	{ PCI_DEVICE(0x8086, 0xa2f0),
> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
> +	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
>  	/* Coffelake */
>  	{ PCI_DEVICE(0x8086, 0xa348),
> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE},
> +	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>  	/* Broxton-P(Apollolake) */
>  	{ PCI_DEVICE(0x8086, 0x5a98),
> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_BROXTON },
> +	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
>  	/* Broxton-T */
>  	{ PCI_DEVICE(0x8086, 0x1a98),
> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_BROXTON },
> +	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
>  	/* Gemini-Lake */
>  	{ PCI_DEVICE(0x8086, 0x3198),
> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_BROXTON },
> +	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
>  	/* Haswell */
>  	{ PCI_DEVICE(0x8086, 0x0a0c),
>  	  .driver_data = AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL },

-- 
~Vinod
