From: "Lu, Han" <han.lu@intel.com>
Subject: Re: [PATCH V2 1/1] audio: Fix playback noise with
 24/32 bit sample size on BXT
Date: Tue, 8 Dec 2015 00:35:32 +0000
Message-ID: <B51200AC81AB024499A3C2C9A1BB90A83D3440EC@SHSMSX101.ccr.corp.intel.com>
References: <1449475153-6974-1-git-send-email-han.lu@intel.com>
 <s5hbna23cpy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E284265A3C
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 01:35:36 +0100 (CET)
In-Reply-To: <s5hbna23cpy.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: "libin.yang@linux.intel.com" <libin.yang@linux.intel.com>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "han.lu@linux.intel.com" <han.lu@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, December 7, 2015 4:06 PM
> To: Lu, Han
> Cc: libin.yang@linux.intel.com; mengdong.lin@linux.intel.com;
> han.lu@linux.intel.com; alsa-devel@alsa-project.org
> Subject: Re: [PATCH V2 1/1] audio: Fix playback noise with 24/32 bit sample
> size on BXT
> 
> On Mon, 07 Dec 2015 08:59:13 +0100,
> han.lu@intel.com wrote:
> >
> > From: "Lu, Han" <han.lu@intel.com>
> >
> > In BXT-P A0, HD-Audio DMA requests is later than expected, and makes
> > an audio stream sensitive to system latencies when
> > 24/32 bits are playing.
> > Adjusting threshold of DMA fifo to force the DMA request sooner to
> > improve latency tolerance at the expense of power.
> >
> > v2: move Intel specific code to hda_intel.c
> >
> > Signed-off-by: Lu, Han <han.lu@intel.com>
> 
> Applied, thanks.
> 
> 
> Takashi
> 

Thanks!

One more thing, I was tried to implement this patch by define a macro
AZX_DCAPS_XXX instead of IS_BROXTON(pci), but it looks like no spare bit
left. (bit 22 and bit 31 are reserved bits, right?) Is there a plan to extend the
caps structure?

BR,
Han

> >
> > diff --git a/include/sound/hda_register.h
> > b/include/sound/hda_register.h index 2ae8812..94dc6a9 100644
> > --- a/include/sound/hda_register.h
> > +++ b/include/sound/hda_register.h
> > @@ -93,6 +93,9 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2,
> SDO3 };
> >  #define AZX_REG_HSW_EM4			0x100c
> >  #define AZX_REG_HSW_EM5			0x1010
> >
> > +/* Skylake/Broxton display HD-A controller Extended Mode registers */
> > +#define AZX_REG_SKL_EM4L		0x1040
> > +
> >  /* PCI space */
> >  #define AZX_PCIREG_TCSEL		0x44
> >
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index 963f824..bff5c8b 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -355,6 +355,8 @@ enum {
> >  					((pci)->device == 0x0d0c) || \
> >  					((pci)->device == 0x160c))
> >
> > +#define IS_BROXTON(pci)	((pci)->device == 0x5a98)
> > +
> >  static char *driver_short_names[] = {
> >  	[AZX_DRIVER_ICH] = "HDA Intel",
> >  	[AZX_DRIVER_PCH] = "HDA Intel PCH",
> > @@ -506,15 +508,36 @@ static void azx_init_pci(struct azx *chip)
> >          }
> >  }
> >
> > +/*
> > + * In BXT-P A0, HD-Audio DMA requests is later than expected,
> > + * and makes an audio stream sensitive to system latencies when
> > + * 24/32 bits are playing.
> > + * Adjusting threshold of DMA fifo to force the DMA request
> > + * sooner to improve latency tolerance at the expense of power.
> > + */
> > +static void bxt_reduce_dma_latency(struct azx *chip) {
> > +	u32 val;
> > +
> > +	val = azx_readl(chip, SKL_EM4L);
> > +	val &= (0x3 << 20);
> > +	azx_writel(chip, SKL_EM4L, val);
> > +}
> > +
> >  static void hda_intel_init_chip(struct azx *chip, bool full_reset)  {
> >  	struct hdac_bus *bus = azx_bus(chip);
> > +	struct pci_dev *pci = chip->pci;
> >
> >  	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
> >  		snd_hdac_set_codec_wakeup(bus, true);
> >  	azx_init_chip(chip, full_reset);
> >  	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
> >  		snd_hdac_set_codec_wakeup(bus, false);
> > +
> > +	/* reduce dma latency to avoid noise */
> > +	if (IS_BROXTON(pci))
> > +		bxt_reduce_dma_latency(chip);
> >  }
> >
> >  /* calculate runtime delay from LPIB */
> > --
> > 2.5.0
> >
