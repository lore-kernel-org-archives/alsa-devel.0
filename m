From: "Xu, Andiry" <Andiry.Xu@amd.com>
Subject: Re: [PATCH] ALSA: HDA: Use AZX_DRIVER_ATI for AMD/ATI
	platforms
Date: Wed, 25 May 2011 15:19:57 +0800
Message-ID: <2DEEA3AB13739D45A22ADDB5086AEA0B0163B0DC@sshaexmb1.amd.com>
References: <1306303159.1508.3.camel@brienza-desktop><s5hvcwz2syq.wl%tiwai@suse.de>
	<s5hr57n2qtl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) by alsa0.perex.cz (Postfix) with ESMTP id C1D25103866
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 09:20:10 +0200 (CEST)
Content-Class: urn:content-classes:message
In-Reply-To: <s5hr57n2qtl.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, May 25, 2011 3:16 PM
> To: Xu, Andiry
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [PATCH] ALSA: HDA: Use AZX_DRIVER_ATI for AMD/ATI
> platforms
> 
> At Wed, 25 May 2011 08:29:49 +0200,
> Takashi Iwai wrote:
> >
> > At Wed, 25 May 2011 13:59:19 +0800,
> > Andiry Xu wrote:
> > >
> > > This commit makes AMD/ATI platforms use AZX_DRIVER_ATI for SB HD
> Audio
> > > and AZX_DRIVER_ATIHDMI for HDMI Audio, so some quirks can be
> applied to
> > > AMD/ATI platforms without checking the pci vendor ID.
> > >
> > > This also spearate SB and HDMI audio, since some quirks should
only
> > > apply to SB audio.
> >
> > To make clear, which quirks should be applied to Hudson and HDMI,
> > and which quirks shouldn't be applied?  Judging from your change,
> >
> > - Hudson: No TCSEL, CNTR2 snoop
> > - HDMI: No TCSEL
> >
> > What about 64bit DMA?  Do they both support?
> > Also, I guess both should use LPIB instead of position-buffer?
> >
> > I'm considering put these information as bit flags into driver_data,
> > so that it won't fake name as if it's an ATI HDMI board.
> 
> I meant the patch like below.  Could you check it?
> 
> 
> thanks,
> 

Hmm. I'll check the patch below and double check HDA/HDMI differences as
well. Thanks.

Thanks,
Andiry 


> 
> ===
> Subject: [PATCH] ALSA: hda - Reorganize controller quriks with bit
> flags
> 
> Introduce bit-flags indicating the necessary controller quirks, and
> set them in pci driver_data field.  This simplifies the checks in the
> driver code and avoids the pci-id lookup in different places.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/hda_intel.c |  188
++++++++++++++++++++++++++-----------
> --------
>  1 files changed, 109 insertions(+), 79 deletions(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 43a0367..6c51f07 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -391,6 +391,7 @@ struct azx {
> 
>  	/* chip type specific */
>  	int driver_type;
> +	unsigned int driver_caps;
>  	int playback_streams;
>  	int playback_index_offset;
>  	int capture_streams;
> @@ -464,6 +465,32 @@ enum {
>  	AZX_NUM_DRIVERS, /* keep this as last entry */
>  };
> 
> +#define AZX_DCAPS_NO_TCSEL	(1 << 8)	/* No Intel TCSEL bit */
> +#define AZX_DCAPS_NO_MSI	(1 << 9)	/* No MSI support */
> +#define AZX_DCAPS_ATI_SNOOP	(1 << 10)	/* ATI snoop enable */
> +#define AZX_DCAPS_NVIDIA_SNOOP	(1 << 11)	/* Nvidia snoop
enable
> */
> +#define AZX_DCAPS_SCH_SNOOP	(1 << 12)	/* SCH/PCH snoop enable
*/
> +#define AZX_DCAPS_RIRB_DELAY	(1 << 13)	/* Long delay in read
loop */
> +#define AZX_DCAPS_RIRB_PRE_DELAY (1 << 14)	/* Put a delay before
> read */
> +#define AZX_DCAPS_CTX_WORKAROUND (1 << 15)	/* X-Fi workaround */
> +#define AZX_DCAPS_POSFIX_LPIB	(1 << 16)	/* Use LPIB as
default
> */
> +#define AZX_DCAPS_POSFIX_VIA	(1 << 17)	/* Use VIACOMBO as
default */
> +#define AZX_DCAPS_NO_64BIT	(1 << 18)	/* No 64bit address */
> +#define AZX_DCAPS_SYNC_WRITE	(1 << 19)	/* sync each cmd write
*/
> +
> +/* quirks for ATI SB / AMD Hudson */
> +#define AZX_DCAPS_PRESET_ATI_SB \
> +	(AZX_DCAPS_ATI_SNOOP | AZX_DCAPS_NO_TCSEL | \
> +	 AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_POSFIX_LPIB)
> +
> +/* quirks for ATI/AMD HDMI */
> +#define AZX_DCAPS_PRESET_ATI_HDMI \
> +	(AZX_DCAPS_NO_TCSEL | AZX_DCAPS_SYNC_WRITE |
> AZX_DCAPS_POSFIX_LPIB)
> +
> +/* quirks for Nvidia */
> +#define AZX_DCAPS_PRESET_NVIDIA \
> +	(AZX_DCAPS_NVIDIA_SNOOP | AZX_DCAPS_RIRB_DELAY |
AZX_DCAPS_NO_MSI)
> +
>  static char *driver_short_names[] __devinitdata = {
>  	[AZX_DRIVER_ICH] = "HDA Intel",
>  	[AZX_DRIVER_PCH] = "HDA Intel PCH",
> @@ -566,7 +593,7 @@ static void azx_init_cmd_io(struct azx *chip)
>  	/* reset the rirb hw write pointer */
>  	azx_writew(chip, RIRBWP, ICH6_RIRBWP_RST);
>  	/* set N=1, get RIRB response interrupt for new entry */
> -	if (chip->driver_type == AZX_DRIVER_CTX)
> +	if (chip->driver_caps & AZX_DCAPS_CTX_WORKAROUND)
>  		azx_writew(chip, RINTCNT, 0xc0);
>  	else
>  		azx_writew(chip, RINTCNT, 1);
> @@ -1056,19 +1083,19 @@ static void azx_init_pci(struct azx *chip)
>  	 * codecs.
>  	 * The PCI register TCSEL is defined in the Intel manuals.
>  	 */
> -	if (chip->driver_type != AZX_DRIVER_ATI &&
> -	    chip->driver_type != AZX_DRIVER_ATIHDMI)
> +	if (chip->driver_caps & AZX_DCAPS_NO_TCSEL)
>  		update_pci_byte(chip->pci, ICH6_PCIREG_TCSEL, 0x07, 0);
> 
> -	switch (chip->driver_type) {
> -	case AZX_DRIVER_ATI:
> -		/* For ATI SB450 azalia HD audio, we need to enable
snoop
> */
> +	/* For ATI SB450/600/700/800/900 and AMD Hudson azalia HD audio,
> +	 * we need to enable snoop.
> +	 */
> +	if (chip->driver_caps & AZX_DCAPS_ATI_SNOOP)
>  		update_pci_byte(chip->pci,
>  				ATI_SB450_HDAUDIO_MISC_CNTR2_ADDR,
>  				0x07, ATI_SB450_HDAUDIO_ENABLE_SNOOP);
> -		break;
> -	case AZX_DRIVER_NVIDIA:
> -		/* For NVIDIA HDA, enable snoop */
> +
> +	/* For NVIDIA HDA, enable snoop */
> +	if (chip->driver_caps & AZX_DCAPS_NVIDIA_SNOOP) {
>  		update_pci_byte(chip->pci,
>  				NVIDIA_HDA_TRANSREG_ADDR,
>  				0x0f, NVIDIA_HDA_ENABLE_COHBITS);
> @@ -1078,9 +1105,10 @@ static void azx_init_pci(struct azx *chip)
>  		update_pci_byte(chip->pci,
>  				NVIDIA_HDA_OSTRM_COH,
>  				0x01, NVIDIA_HDA_ENABLE_COHBIT);
> -		break;
> -	case AZX_DRIVER_SCH:
> -	case AZX_DRIVER_PCH:
> +	}
> +
> +	/* Enable SCH/PCH snoop if needed */
> +	if (chip->driver_caps & AZX_DCAPS_SCH_SNOOP) {
>  		pci_read_config_word(chip->pci, INTEL_SCH_HDA_DEVC,
&snoop);
>  		if (snoop & INTEL_SCH_HDA_DEVC_NOSNOOP) {
>  			pci_write_config_word(chip->pci,
INTEL_SCH_HDA_DEVC,
> @@ -1091,14 +1119,6 @@ static void azx_init_pci(struct azx *chip)
>  				(snoop & INTEL_SCH_HDA_DEVC_NOSNOOP)
>  				? "Failed" : "OK");
>  		}
> -		break;
> -	default:
> -		/* AMD Hudson needs the similar snoop, as it seems... */
> -		if (chip->pci->vendor == PCI_VENDOR_ID_AMD)
> -			update_pci_byte(chip->pci,
> -				ATI_SB450_HDAUDIO_MISC_CNTR2_ADDR,
> -				0x07, ATI_SB450_HDAUDIO_ENABLE_SNOOP);
> -		break;
>          }
>  }
> 
> @@ -1152,7 +1172,7 @@ static irqreturn_t azx_interrupt(int irq, void
> *dev_id)
>  	status = azx_readb(chip, RIRBSTS);
>  	if (status & RIRB_INT_MASK) {
>  		if (status & RIRB_INT_RESPONSE) {
> -			if (chip->driver_type == AZX_DRIVER_CTX)
> +			if (chip->driver_caps &
AZX_DCAPS_RIRB_PRE_DELAY)
>  				udelay(80);
>  			azx_update_rirb(chip);
>  		}
> @@ -1421,7 +1441,7 @@ static int __devinit azx_codec_create(struct azx
> *chip, const char *model)
>  	if (err < 0)
>  		return err;
> 
> -	if (chip->driver_type == AZX_DRIVER_NVIDIA)
> +	if (chip->driver_caps & AZX_DCAPS_RIRB_DELAY)
>  		chip->bus->needs_damn_long_delay = 1;
> 
>  	codecs = 0;
> @@ -1720,7 +1740,7 @@ static int azx_pcm_prepare(struct
> snd_pcm_substream *substream)
> 
>  	stream_tag = azx_dev->stream_tag;
>  	/* CA-IBG chips need the playback stream starting from 1 */
> -	if (chip->driver_type == AZX_DRIVER_CTX &&
> +	if ((chip->driver_caps & AZX_DCAPS_CTX_WORKAROUND) &&
>  	    stream_tag > chip->capture_streams)
>  		stream_tag -= chip->capture_streams;
>  	return snd_hda_codec_prepare(apcm->codec, hinfo, stream_tag,
> @@ -2365,20 +2385,10 @@ static int __devinit check_position_fix(struct
> azx *chip, int fix)
>  	}
> 
>  	/* Check VIA/ATI HD Audio Controller exist */
> -	switch (chip->driver_type) {
> -	case AZX_DRIVER_VIA:
> -		/* Use link position directly, avoid any transfer
problem.
> */
> +	if (chip->driver_caps & AZX_DCAPS_POSFIX_VIA)
>  		return POS_FIX_VIACOMBO;
> -	case AZX_DRIVER_ATI:
> -		/* ATI chipsets don't work well with position-buffer */
> +	if (chip->driver_caps & AZX_DCAPS_POSFIX_LPIB)
>  		return POS_FIX_LPIB;
> -	case AZX_DRIVER_GENERIC:
> -		/* AMD chipsets also don't work with position-buffer */
> -		if (chip->pci->vendor == PCI_VENDOR_ID_AMD)
> -			return POS_FIX_LPIB;
> -		break;
> -	}
> -
>  	return POS_FIX_AUTO;
>  }
> 
> @@ -2460,8 +2470,8 @@ static void __devinit check_msi(struct azx
*chip)
>  	}
> 
>  	/* NVidia chipsets seem to cause troubles with MSI */
> -	if (chip->driver_type == AZX_DRIVER_NVIDIA) {
> -		printk(KERN_INFO "hda_intel: Disable MSI for Nvidia
> chipset\n");
> +	if (chip->driver_caps & AZX_DCAPS_NO_MSI) {
> +		printk(KERN_INFO "hda_intel: Disable MSI\n");
>  		chip->msi = 0;
>  	}
>  }
> @@ -2471,7 +2481,7 @@ static void __devinit check_msi(struct azx
*chip)
>   * constructor
>   */
>  static int __devinit azx_create(struct snd_card *card, struct pci_dev
> *pci,
> -				int dev, int driver_type,
> +				int dev, unsigned int driver_caps,
>  				struct azx **rchip)
>  {
>  	struct azx *chip;
> @@ -2499,7 +2509,8 @@ static int __devinit azx_create(struct snd_card
> *card, struct pci_dev *pci,
>  	chip->card = card;
>  	chip->pci = pci;
>  	chip->irq = -1;
> -	chip->driver_type = driver_type;
> +	chip->driver_caps = driver_caps;
> +	chip->driver_type = driver_caps & 0xff;
>  	check_msi(chip);
>  	chip->dev_index = dev;
>  	INIT_WORK(&chip->irq_pending_work, azx_irq_pending_work);
> @@ -2563,8 +2574,7 @@ static int __devinit azx_create(struct snd_card
> *card, struct pci_dev *pci,
>  	snd_printdd(SFX "chipset global capabilities = 0x%x\n", gcap);
> 
>  	/* disable SB600 64bit support for safety */
> -	if ((chip->driver_type == AZX_DRIVER_ATI) ||
> -	    (chip->driver_type == AZX_DRIVER_ATIHDMI)) {
> +	if (chip->pci->vendor == PCI_VENDOR_ID_ATI) {
>  		struct pci_dev *p_smbus;
>  		p_smbus = pci_get_device(PCI_VENDOR_ID_ATI,
>  					 PCI_DEVICE_ID_ATI_SBX00_SMBUS,
> @@ -2574,18 +2584,10 @@ static int __devinit azx_create(struct
snd_card
> *card, struct pci_dev *pci,
>  				gcap &= ~ICH6_GCAP_64OK;
>  			pci_dev_put(p_smbus);
>  		}
> -	} else {
> -		/* FIXME: not sure whether this is really needed, but
> -		 * Hudson isn't stable enough for allowing everything...
> -		 * let's check later again.
> -		 */
> -		if (chip->pci->vendor == PCI_VENDOR_ID_AMD)
> -			gcap &= ~ICH6_GCAP_64OK;
>  	}
> 
> -	/* disable 64bit DMA address for Teradici */
> -	/* it does not work with device 6549:1200 subsys e4a2:040b */
> -	if (chip->driver_type == AZX_DRIVER_TERA)
> +	/* disable 64bit DMA address on some devices */
> +	if (chip->driver_caps & AZX_DCAPS_NO_64BIT)
>  		gcap &= ~ICH6_GCAP_64OK;
> 
>  	/* allow 64bit DMA address if supported by H/W */
> @@ -2788,38 +2790,62 @@ static void __devexit azx_remove(struct
pci_dev
> *pci)
>  /* PCI IDs */
>  static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
>  	/* CPT */
> -	{ PCI_DEVICE(0x8086, 0x1c20), .driver_data = AZX_DRIVER_PCH },
> +	{ PCI_DEVICE(0x8086, 0x1c20),
> +	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP },
>  	/* PBG */
> -	{ PCI_DEVICE(0x8086, 0x1d20), .driver_data = AZX_DRIVER_PCH },
> +	{ PCI_DEVICE(0x8086, 0x1d20),
> +	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP },
>  	/* Panther Point */
> -	{ PCI_DEVICE(0x8086, 0x1e20), .driver_data = AZX_DRIVER_PCH },
> +	{ PCI_DEVICE(0x8086, 0x1e20),
> +	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP },
>  	/* SCH */
> -	{ PCI_DEVICE(0x8086, 0x811b), .driver_data = AZX_DRIVER_SCH },
> +	{ PCI_DEVICE(0x8086, 0x811b),
> +	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_SCH_SNOOP },
>  	/* Generic Intel */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_ANY_ID),
>  	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
>  	  .class_mask = 0xffffff,
>  	  .driver_data = AZX_DRIVER_ICH },
> -	/* ATI SB 450/600 */
> -	{ PCI_DEVICE(0x1002, 0x437b), .driver_data = AZX_DRIVER_ATI },
> -	{ PCI_DEVICE(0x1002, 0x4383), .driver_data = AZX_DRIVER_ATI },
> +	/* ATI SB 450/600/700/800/900 */
> +	{ PCI_DEVICE(0x1002, 0x437b),
> +	  .driver_data = AZX_DRIVER_ATI | AZX_DCAPS_PRESET_ATI_SB },
> +	{ PCI_DEVICE(0x1002, 0x4383),
> +	  .driver_data = AZX_DRIVER_ATI | AZX_DCAPS_PRESET_ATI_SB },
> +	/* AMD Hudson */
> +	{ PCI_DEVICE(0x1022, 0x780d),
> +	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
>  	/* ATI HDMI */
> -	{ PCI_DEVICE(0x1002, 0x793b), .driver_data = AZX_DRIVER_ATIHDMI
},
> -	{ PCI_DEVICE(0x1002, 0x7919), .driver_data = AZX_DRIVER_ATIHDMI
},
> -	{ PCI_DEVICE(0x1002, 0x960f), .driver_data = AZX_DRIVER_ATIHDMI
},
> -	{ PCI_DEVICE(0x1002, 0x970f), .driver_data = AZX_DRIVER_ATIHDMI
},
> -	{ PCI_DEVICE(0x1002, 0xaa00), .driver_data = AZX_DRIVER_ATIHDMI
},
> -	{ PCI_DEVICE(0x1002, 0xaa08), .driver_data = AZX_DRIVER_ATIHDMI
},
> -	{ PCI_DEVICE(0x1002, 0xaa10), .driver_data = AZX_DRIVER_ATIHDMI
},
> -	{ PCI_DEVICE(0x1002, 0xaa18), .driver_data = AZX_DRIVER_ATIHDMI
},
> -	{ PCI_DEVICE(0x1002, 0xaa20), .driver_data = AZX_DRIVER_ATIHDMI
},
> -	{ PCI_DEVICE(0x1002, 0xaa28), .driver_data = AZX_DRIVER_ATIHDMI
},
> -	{ PCI_DEVICE(0x1002, 0xaa30), .driver_data = AZX_DRIVER_ATIHDMI
},
> -	{ PCI_DEVICE(0x1002, 0xaa38), .driver_data = AZX_DRIVER_ATIHDMI
},
> -	{ PCI_DEVICE(0x1002, 0xaa40), .driver_data = AZX_DRIVER_ATIHDMI
},
> -	{ PCI_DEVICE(0x1002, 0xaa48), .driver_data = AZX_DRIVER_ATIHDMI
},
> +	{ PCI_DEVICE(0x1002, 0x793b),
> +	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI
},
> +	{ PCI_DEVICE(0x1002, 0x7919),
> +	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI
},
> +	{ PCI_DEVICE(0x1002, 0x960f),
> +	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI
},
> +	{ PCI_DEVICE(0x1002, 0x970f),
> +	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI
},
> +	{ PCI_DEVICE(0x1002, 0xaa00),
> +	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI
},
> +	{ PCI_DEVICE(0x1002, 0xaa08),
> +	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI
},
> +	{ PCI_DEVICE(0x1002, 0xaa10),
> +	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI
},
> +	{ PCI_DEVICE(0x1002, 0xaa18),
> +	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI
},
> +	{ PCI_DEVICE(0x1002, 0xaa20),
> +	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI
},
> +	{ PCI_DEVICE(0x1002, 0xaa28),
> +	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI
},
> +	{ PCI_DEVICE(0x1002, 0xaa30),
> +	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI
},
> +	{ PCI_DEVICE(0x1002, 0xaa38),
> +	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI
},
> +	{ PCI_DEVICE(0x1002, 0xaa40),
> +	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI
},
> +	{ PCI_DEVICE(0x1002, 0xaa48),
> +	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI
},
>  	/* VIA VT8251/VT8237A */
> -	{ PCI_DEVICE(0x1106, 0x3288), .driver_data = AZX_DRIVER_VIA },
> +	{ PCI_DEVICE(0x1106, 0x3288),
> +	  .driver_data = AZX_DRIVER_VIA | AZX_DCAPS_POSFIX_VIA },
>  	/* SIS966 */
>  	{ PCI_DEVICE(0x1039, 0x7502), .driver_data = AZX_DRIVER_SIS },
>  	/* ULI M5461 */
> @@ -2828,9 +2854,10 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID),
>  	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
>  	  .class_mask = 0xffffff,
> -	  .driver_data = AZX_DRIVER_NVIDIA },
> +	  .driver_data = AZX_DRIVER_NVIDIA | AZX_DCAPS_PRESET_NVIDIA },
>  	/* Teradici */
> -	{ PCI_DEVICE(0x6549, 0x1200), .driver_data = AZX_DRIVER_TERA },
> +	{ PCI_DEVICE(0x6549, 0x1200),
> +	  .driver_data = AZX_DRIVER_TERA | AZX_DCAPS_NO_64BIT },
>  	/* Creative X-Fi (CA0110-IBG) */
>  #if !defined(CONFIG_SND_CTXFI) && !defined(CONFIG_SND_CTXFI_MODULE)
>  	/* the following entry conflicts with snd-ctxfi driver,
> @@ -2840,10 +2867,13 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_CREATIVE, PCI_ANY_ID),
>  	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
>  	  .class_mask = 0xffffff,
> -	  .driver_data = AZX_DRIVER_CTX },
> +	  .driver_data = AZX_DRIVER_CTX | AZX_DCAPS_CTX_WORKAROUND |
> +	  AZX_DCAPS_RIRB_PRE_DELAY },
>  #else
>  	/* this entry seems still valid -- i.e. without emu20kx chip */
> -	{ PCI_DEVICE(0x1102, 0x0009), .driver_data = AZX_DRIVER_CTX },
> +	{ PCI_DEVICE(0x1102, 0x0009),
> +	  .driver_data = AZX_DRIVER_CTX | AZX_DCAPS_CTX_WORKAROUND |
> +	  AZX_DCAPS_RIRB_PRE_DELAY },
>  #endif
>  	/* Vortex86MX */
>  	{ PCI_DEVICE(0x17f3, 0x3010), .driver_data = AZX_DRIVER_GENERIC
},
> @@ -2853,11 +2883,11 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_ANY_ID),
>  	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
>  	  .class_mask = 0xffffff,
> -	  .driver_data = AZX_DRIVER_GENERIC },
> +	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_HDMI
},
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_ANY_ID),
>  	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
>  	  .class_mask = 0xffffff,
> -	  .driver_data = AZX_DRIVER_GENERIC },
> +	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_HDMI
},
>  	{ 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, azx_ids);
> --
> 1.7.4.2
> 
