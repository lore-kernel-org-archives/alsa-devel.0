From: "John L. Utz III" <john.utz@dmx.com>
Subject: Re: [PATCH] Try to make our poor little ALS4000 driver
 worthy of its copious public specs (first step)
Date: Tue, 19 Aug 2008 15:08:20 -0700
Message-ID: <op.uf5mf6ih647oa9@jutz-gnto64>
References: <20080819203444.GA28132@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 7983B24364
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Aug 2008 00:08:33 +0200 (CEST)
In-Reply-To: <20080819203444.GA28132@rhlx01.hs-esslingen.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andreas Mohr <andi@lisas.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 19 Aug 2008 13:34:44 -0700, Andreas Mohr <andi@lisas.de> wrote:

> [with not-quite-so-unintentional CCs added]

said cc's now trimmed since they are probably both on alsa-dev.

> Hi,
>
> there you have it: Linux developers are hypocrites ;)
>
> Never omitting any opportunity to complain about missing vendor
> cooperation, but what do they do once people actually do publish ample  
> specs? -
> yeah, you got that right: NOTHING!!

Congratulations on your patch, but i dont think this comment was  
particularly helpful.

Writing audio device drivers is non-trivial, even with the spec.

I (on behalf of my employer) have made minor contributions to ALSA in the  
context of getting our product completed. The *only* reason we have the  
spec is that we committed to buying enuf motherboards that we could  
'incentivize' the motherboard manufacturer to extract the spec from the  
chip vendor.

The spec doc was less than stellar and it took months to get something  
that worked because i had no help from the chip vendor.

I am glad that the ALS4K will now have better support. This is a happy  
circumstance.

But it only happened because somebody with motivation and skills who  
happened to own one could utilize the documentation to get his *own* needs  
met.

In the case of this particular chip, that is the only way that could  
happen, because as a *commercial* product it is over and done, dead and  
buried.

Had the spec been released concurrent with the release of the chip, who  
knows what would have happened?

The ALS4k is not currently manufactured, so there is not a good reason to  
invest development resources in supporting it.

Time is better spent supporting new chips so that new distro releases can  
support new computers so that computer vendors and end users will feel  
less put out by having linux as the default OS for their brand new  
computer!

> Let's try to change that, at least one bit at a time. ;)

Yes, but let's try to do it constructively.

> ChangeLog:
> - use specs-derived register name enums instead of open-coded numeric
> values, for better understanding of things
> - fix naming confusion ("gcr" was _NOT_ the GCR register stuff, but
>   instead the io _base_ which has multiplexed _access_ to GCR config
>   space, at _sub_ registers 0x08 and 0x0c)
> - add FIXME comments about a race condition and MPU401 features
>
> Oh, and I chose an abbreviated "ALS4K" prefix since I would have gotten
> finger cramps otherwise.
>
> Patch created on 2.6.27-rc1-git4 (no als4000.c changes up to -rc3,  
> verified),
> pushed through checkpatch.pl, verified on my ALS4000 card.
>
> More work to follow... e.g. would be nice to get audio wakeup things to  
> work,
> since this would probably be the first (if admittedly crappy) sound  
> card/driver
> combo on Linux to support such features, thus a nice broadening of
> Linux capabilities.
>
> Thanks!
>
> Signed-off-by: Andreas Mohr <andi@lisas.de>
>
> --- sound/pci/als4000.c.org	2008-08-18 21:15:37.000000000 +0200
> +++ sound/pci/als4000.c	2008-08-18 22:12:27.000000000 +0200
> @@ -60,6 +60,7 @@
>   *
>   * ToDo:
>   * - Proper shared IRQ handling?
> + * - by default, don't enable legacy game and use PCI game I/O
>   * - power management? (card can do voice wakeup according to  
> datasheet!!)
>   */
> @@ -107,7 +108,7 @@
> struct snd_card_als4000 {
>  	/* most frequent access first */
> -	unsigned long gcr;
> +	unsigned long iobase;
>  	struct pci_dev *pci;
>  	struct snd_sb *chip;
>  #ifdef SUPPORT_JOYSTICK
> @@ -122,24 +123,89 @@
> MODULE_DEVICE_TABLE(pci, snd_als4000_ids);
> -static inline void snd_als4000_gcr_write_addr(unsigned long port, u32  
> reg, u32 val)
> +enum als4k_iobase_t {
> +	/* IOx: B == Byte, W = Word, D = DWord */
> +	ALS4K_IOD_00_AC97_ACCESS = 0x00,
> +	ALS4K_IOW_04_AC97_READ = 0x04,
> +	ALS4K_IOB_06_AC97_STATUS = 0x06,
> +	ALS4K_IOB_07_IRQSTATUS = 0x07,
> +	ALS4K_IOD_08_GCR_DATA = 0x08,
> +	ALS4K_IOB_0C_GCR_INDEX = 0x0c,
> +	ALS4K_IOB_0E_SB_MPU_IRQ = 0x0e,
> +	ALS4K_IOB_10_ADLIB_ADDR0 = 0x10,
> +	ALS4K_IOB_11_ADLIB_ADDR1 = 0x11,
> +	ALS4K_IOB_12_ADLIB_ADDR2 = 0x12,
> +	ALS4K_IOB_13_ADLIB_ADDR3 = 0x13,
> +	ALS4K_IOB_14_MIXER_INDEX = 0x14,
> +	ALS4K_IOB_15_MIXER_DATA = 0x15,
> +	ALS4K_IOB_16_ESP_RST_PORT = 0x16,
> +	ALS4K_IOB_16_CR1E_ACK_PORT = 0x16, /* 2nd function */
> +	ALS4K_IOB_18_OPL_ADDR0 = 0x18,
> +	ALS4K_IOB_19_OPL_ADDR1 = 0x19,
> +	ALS4K_IOB_1A_ESP_RD_DATA = 0x1a,
> +	ALS4K_IOB_1C_ESP_CMD_DATA = 0x1c,
> +	ALS4K_IOB_1C_ESP_WR_STATUS = 0x1c, /* 2nd function */
> +	ALS4K_IOB_1E_ESP_RD_STATUS8 = 0x1e,
> +	ALS4K_IOB_1F_ESP_RD_STATUS16 = 0x1f,
> +	ALS4K_IOB_20_ESP_GAMEPORT_200 = 0x20,
> +	ALS4K_IOB_21_ESP_GAMEPORT_201 = 0x21,
> +	ALS4K_IOB_30_MIDI_DATA = 0x30,
> +	ALS4K_IOB_31_MIDI_STATUS = 0x31,
> +	ALS4K_IOB_31_MIDI_COMMAND = 0x31, /* 2nd function */
> +};
> +
> +enum als4k_gcr_t {
> +	/* all registers 32bit wide */
> +	ALS4K_GCR_8C_MISC_CTRL = 0x8c,
> +	ALS4K_GCR_90_TEST_MODE_REG = 0x90,
> +	ALS4K_GCR_91_DMA0_ADDR = 0x91,
> +	ALS4K_GCR_92_DMA0_MODE_COUNT = 0x92,
> +	ALS4K_GCR_93_DMA1_ADDR = 0x93,
> +	ALS4K_GCR_94_DMA1_MODE_COUNT = 0x94,
> +	ALS4K_GCR_95_DMA3_ADDR = 0x95,
> +	ALS4K_GCR_96_DMA3_MODE_COUNT = 0x96,
> +	ALS4K_GCR_99_DMA_EMULATION_CTRL = 0x99,
> +	ALS4K_GCR_A0_FIFO1_CURRENT_ADDR = 0xa0,
> +	ALS4K_GCR_A1_FIFO1_STATUS_BYTECOUNT = 0xa1,
> +	ALS4K_GCR_A2_FIFO2_PCIADDR = 0xa2,
> +	ALS4K_GCR_A3_FIFO2_COUNT = 0xa3,
> +	ALS4K_GCR_A4_FIFO2_CURRENT_ADDR = 0xa4,
> +	ALS4K_GCR_A5_FIFO1_STATUS_BYTECOUNT = 0xa5,
> +	ALS4K_GCR_A6_PM_CTRL = 0xa6,
> +	ALS4K_GCR_A7_PCI_ACCESS_STORAGE = 0xa7,
> +	ALS4K_GCR_A8_LEGACY_CFG1 = 0xa8,
> +	ALS4K_GCR_A9_LEGACY_CFG2 = 0xa9,
> +	ALS4K_GCR_FF_DUMMY_SCRATCH = 0xff,
> +};
> +
> +enum als4k_gcr_8c_t {
> +	ALS4K_GCR_8C_IRQ_MASK_CTRL_ENABLE = 0x8000,
> +	ALS4K_GCR_8C_CHIP_REV_MASK = 0xf0000
> +};
> +
> +static inline void snd_als4000_gcr_write_addr(unsigned long iobase,
> +						 enum als4k_gcr_t reg,
> +						 u32 val)
>  {
> -	outb(reg, port+0x0c);
> -	outl(val, port+0x08);
> +	outb(reg, iobase + ALS4K_IOB_0C_GCR_INDEX);
> +	outl(val, iobase + ALS4K_IOD_08_GCR_DATA);
>  }
> -static inline void snd_als4000_gcr_write(struct snd_sb *sb, u32 reg,  
> u32 val)
> +static inline void snd_als4000_gcr_write(struct snd_sb *sb,
> +						 enum als4k_gcr_t reg,
> +						 u32 val)
>  {
>  	snd_als4000_gcr_write_addr(sb->alt_port, reg, val);
>  }	
> -static inline u32 snd_als4000_gcr_read_addr(unsigned long port, u32 reg)
> +static inline u32 snd_als4000_gcr_read_addr(unsigned long iobase,
> +						 enum als4k_gcr_t reg)
>  {
> -	outb(reg, port+0x0c);
> -	return inl(port+0x08);
> +	outb(reg, iobase + ALS4K_IOB_0C_GCR_INDEX);
> +	return inl(iobase + ALS4K_IOD_08_GCR_DATA);
>  }
> -static inline u32 snd_als4000_gcr_read(struct snd_sb *sb, u32 reg)
> +static inline u32 snd_als4000_gcr_read(struct snd_sb *sb, enum  
> als4k_gcr_t reg)
>  {
>  	return snd_als4000_gcr_read_addr(sb->alt_port, reg);
>  }
> @@ -156,15 +222,17 @@
>  static inline void snd_als4000_set_capture_dma(struct snd_sb *chip,
>  					       dma_addr_t addr, unsigned size)
>  {
> -	snd_als4000_gcr_write(chip, 0xa2, addr);
> -	snd_als4000_gcr_write(chip, 0xa3, (size-1));
> +	snd_als4000_gcr_write(chip, ALS4K_GCR_A2_FIFO2_PCIADDR, addr);
> +	snd_als4000_gcr_write(chip, ALS4K_GCR_A3_FIFO2_COUNT, (size-1));
>  }
> static inline void snd_als4000_set_playback_dma(struct snd_sb *chip,
> -						dma_addr_t addr, unsigned size)
> +						dma_addr_t addr,
> +						unsigned size)
>  {
> -	snd_als4000_gcr_write(chip, 0x91, addr);
> -	snd_als4000_gcr_write(chip, 0x92, (size-1)|0x180000);
> +	snd_als4000_gcr_write(chip, ALS4K_GCR_91_DMA0_ADDR, addr);
> +	snd_als4000_gcr_write(chip, ALS4K_GCR_92_DMA0_MODE_COUNT,
> +							(size-1)|0x180000);
>  }
> #define ALS4000_FORMAT_SIGNED	(1<<0)
> @@ -305,6 +373,12 @@
>  	struct snd_sb *chip = snd_pcm_substream_chip(substream);
>  	int result = 0;
>  	
> +	/* FIXME race condition in here!!!
> +	   chip->mode non-atomic update gets consistently protected
> +	   by reg_lock always, _except_ for this place!!
> +	   Probably need to take reg_lock as outer (or inner??) lock, too.
> +	   (or serialize both lock operations? probably not, though... - racy?)
> +	*/
>  	spin_lock(&chip->mixer_lock);
>  	switch (cmd) {
>  	case SNDRV_PCM_TRIGGER_START:
> @@ -356,7 +430,8 @@
>  	unsigned int result;
> 	spin_lock(&chip->reg_lock);	
> -	result = snd_als4000_gcr_read(chip, 0xa4) & 0xffff;
> +	result = snd_als4000_gcr_read(chip, ALS4K_GCR_A4_FIFO2_CURRENT_ADDR);
> +	result &= 0xffff;
>  	spin_unlock(&chip->reg_lock);
>  	return bytes_to_frames( substream->runtime, result );
>  }
> @@ -367,7 +442,8 @@
>  	unsigned result;
> 	spin_lock(&chip->reg_lock);	
> -	result = snd_als4000_gcr_read(chip, 0xa0) & 0xffff;
> +	result = snd_als4000_gcr_read(chip, ALS4K_GCR_A0_FIFO1_CURRENT_ADDR);
> +	result &= 0xffff;
>  	spin_unlock(&chip->reg_lock);
>  	return bytes_to_frames( substream->runtime, result );
>  }
> @@ -376,12 +452,13 @@
>   * return IRQ_HANDLED no matter whether we actually had an IRQ flag or  
> not).
>   * ALS4000a.PDF writes that while ACKing IRQ in PCI block will *not* ACK
>   * the IRQ in the SB core, ACKing IRQ in SB block *will* ACK the PCI IRQ
> - * register (alt_port + 0x0e). Probably something could be optimized  
> here to
> - * query/write one register only...
> + * register (alt_port + ALS4K_IOB_0E_SB_MPU_IRQ). Probably something
> + * could be optimized here to query/write one register only...
>   * And even if both registers need to be queried, then there's still the
>   * question of whether it's actually correct to ACK PCI IRQ before  
> reading
>   * SB IRQ like we do now, since ALS4000a.PDF mentions that PCI IRQ will  
> *clear*
>   * SB IRQ status.
> + * (hmm, page 38 mentions it the other way around!)
>   * And do we *really* need the lock here for *reading*  
> SB_DSP4_IRQSTATUS??
>   * */
>  static irqreturn_t snd_als4000_interrupt(int irq, void *dev_id)
> @@ -391,7 +468,7 @@
>  	unsigned sb_status;
> 	/* find out which bit of the ALS4000 produced the interrupt */
> -	gcr_status = inb(chip->alt_port + 0xe);
> +	gcr_status = inb(chip->alt_port + ALS4K_IOB_0E_SB_MPU_IRQ);
> 	if ((gcr_status & 0x80) && (chip->playback_substream)) /* playback */
>  		snd_pcm_period_elapsed(chip->playback_substream);
> @@ -400,7 +477,7 @@
>  	if ((gcr_status & 0x10) && (chip->rmidi)) /* MPU401 interrupt */
>  		snd_mpu401_uart_interrupt(irq, chip->rmidi->private_data);
>  	/* release the gcr */
> -	outb(gcr_status, chip->alt_port + 0xe);
> +	outb(gcr_status, chip->alt_port + ALS4K_IOB_0E_SB_MPU_IRQ);
>  	
>  	spin_lock(&chip->mixer_lock);
>  	sb_status = snd_sbmixer_read(chip, SB_DSP4_IRQSTATUS);
> @@ -543,25 +620,25 @@
> /******************************************************************/
> -static void snd_als4000_set_addr(unsigned long gcr,
> -					unsigned int sb,
> -					unsigned int mpu,
> -					unsigned int opl,
> -					unsigned int game)
> -{
> -	u32 confA = 0;
> -	u32 confB = 0;
> -
> -	if (mpu > 0)
> -		confB |= (mpu | 1) << 16;
> -	if (sb > 0)
> -		confB |= (sb | 1);
> -	if (game > 0)
> -		confA |= (game | 1) << 16;
> -	if (opl > 0)	
> -		confA |= (opl | 1);
> -	snd_als4000_gcr_write_addr(gcr, 0xa8, confA);
> -	snd_als4000_gcr_write_addr(gcr, 0xa9, confB);
> +static void snd_als4000_set_addr(unsigned long iobase,
> +					unsigned int sb_io,
> +					unsigned int mpu_io,
> +					unsigned int opl_io,
> +					unsigned int game_io)
> +{
> +	u32 cfg1 = 0;
> +	u32 cfg2 = 0;
> +
> +	if (mpu_io > 0)
> +		cfg2 |= (mpu_io | 1) << 16;
> +	if (sb_io > 0)
> +		cfg2 |= (sb_io | 1);
> +	if (game_io > 0)
> +		cfg1 |= (game_io | 1) << 16;
> +	if (opl_io > 0)
> +		cfg1 |= (opl_io | 1);
> +	snd_als4000_gcr_write_addr(iobase, ALS4K_GCR_A8_LEGACY_CFG1, cfg1);
> +	snd_als4000_gcr_write_addr(iobase, ALS4K_GCR_A9_LEGACY_CFG2, cfg2);
>  }
> static void snd_als4000_configure(struct snd_sb *chip)
> @@ -579,12 +656,15 @@
>  	spin_unlock_irq(&chip->mixer_lock);
>  	
>  	spin_lock_irq(&chip->reg_lock);
> -	/* magic number. Enables interrupts(?) */
> -	snd_als4000_gcr_write(chip, 0x8c, 0x28000);
> -	for(i = 0x91; i <= 0x96; ++i)
> +	/* enable interrupts */
> +	snd_als4000_gcr_write(chip, ALS4K_GCR_8C_MISC_CTRL,
> +					 ALS4K_GCR_8C_IRQ_MASK_CTRL_ENABLE);
> +
> +	for (i = ALS4K_GCR_91_DMA0_ADDR; i <= ALS4K_GCR_96_DMA3_MODE_COUNT;  
> ++i)
>  		snd_als4000_gcr_write(chip, i, 0);
>  	
> -	snd_als4000_gcr_write(chip, 0x99, snd_als4000_gcr_read(chip, 0x99));
> +	snd_als4000_gcr_write(chip, ALS4K_GCR_99_DMA_EMULATION_CTRL,
> +		snd_als4000_gcr_read(chip, ALS4K_GCR_99_DMA_EMULATION_CTRL));
>  	spin_unlock_irq(&chip->reg_lock);
>  }
> @@ -628,7 +708,7 @@
>  	gameport_set_port_data(gp, r);
> 	/* Enable legacy joystick port */
> -	snd_als4000_set_addr(acard->gcr, 0, 0, 0, 1);
> +	snd_als4000_set_addr(acard->iobase, 0, 0, 0, 1);
> 	gameport_register_port(acard->gameport);
> @@ -643,7 +723,9 @@
>  		gameport_unregister_port(acard->gameport);
>  		acard->gameport = NULL;
> -		snd_als4000_set_addr(acard->gcr, 0, 0, 0, 0); /* disable joystick */
> +		/* disable joystick */
> +		snd_als4000_set_addr(acard->iobase, 0, 0, 0, 0);
> +
>  		release_and_free_resource(r);
>  	}
>  }
> @@ -654,10 +736,10 @@
> static void snd_card_als4000_free( struct snd_card *card )
>  {
> -	struct snd_card_als4000 * acard = (struct snd_card_als4000  
> *)card->private_data;
> +	struct snd_card_als4000 *acard = card->private_data;
> 	/* make sure that interrupts are disabled */
> -	snd_als4000_gcr_write_addr( acard->gcr, 0x8c, 0);
> +	snd_als4000_gcr_write_addr(acard->iobase, ALS4K_GCR_8C_MISC_CTRL, 0);
>  	/* free resources */
>  	snd_als4000_free_gameport(acard);
>  	pci_release_regions(acard->pci);
> @@ -670,7 +752,7 @@
>  	static int dev;
>  	struct snd_card *card;
>  	struct snd_card_als4000 *acard;
> -	unsigned long gcr;
> +	unsigned long iobase;
>  	struct snd_sb *chip;
>  	struct snd_opl3 *opl3;
>  	unsigned short word;
> @@ -699,7 +781,7 @@
>  		pci_disable_device(pci);
>  		return err;
>  	}
> -	gcr = pci_resource_start(pci, 0);
> +	iobase = pci_resource_start(pci, 0);
> 	pci_read_config_word(pci, PCI_COMMAND, &word);
>  	pci_write_config_word(pci, PCI_COMMAND, word | PCI_COMMAND_IO);
> @@ -713,16 +795,16 @@
>  		return -ENOMEM;
>  	}
> -	acard = (struct snd_card_als4000 *)card->private_data;
> +	acard = card->private_data;
>  	acard->pci = pci;
> -	acard->gcr = gcr;
> +	acard->iobase = iobase;
>  	card->private_free = snd_card_als4000_free;
> 	/* disable all legacy ISA stuff */
> -	snd_als4000_set_addr(acard->gcr, 0, 0, 0, 0);
> +	snd_als4000_set_addr(acard->iobase, 0, 0, 0, 0);
> 	if ((err = snd_sbdsp_create(card,
> -				    gcr + 0x10,
> +				    iobase + ALS4K_IOB_10_ADLIB_ADDR0,
>  				    pci->irq,
>  				    snd_als4000_interrupt,
>  				    -1,
> @@ -734,7 +816,7 @@
>  	acard->chip = chip;
> 	chip->pci = pci;
> -	chip->alt_port = gcr;
> +	chip->alt_port = iobase;
>  	snd_card_set_dev(card, &pci->dev);
> 	snd_als4000_configure(chip);
> @@ -745,11 +827,16 @@
>  		card->shortname, chip->alt_port, chip->irq);
> 	if ((err = snd_mpu401_uart_new( card, 0, MPU401_HW_ALS4000,
> -				        gcr+0x30, MPU401_INFO_INTEGRATED,
> +					iobase + ALS4K_IOB_30_MIDI_DATA,
> +					MPU401_INFO_INTEGRATED,
>  					pci->irq, 0, &chip->rmidi)) < 0) {
> -		printk(KERN_ERR "als4000: no MPU-401 device at 0x%lx?\n", gcr+0x30);
> +		printk(KERN_ERR "als4000: no MPU-401 device at 0x%lx?\n",
> +				iobase + ALS4K_IOB_30_MIDI_DATA);
>  		goto out_err;
>  	}
> +	/* FIXME: ALS4000 has interesting MPU401 configuration features
> +	 * at CR 0x1A (pass-thru / UART switching, fast MIDI clock, etc.),
> +	 * however there doesn't seem to be an ALSA API for this... */
> 	if ((err = snd_als4000_pcm(chip, 0)) < 0) {
>  		goto out_err;
> @@ -758,10 +845,13 @@
>  		goto out_err;
>  	}	
> -	if (snd_opl3_create(card, gcr+0x10, gcr+0x12,
> +	if (snd_opl3_create(card,
> +				iobase + ALS4K_IOB_10_ADLIB_ADDR0,
> +				iobase + ALS4K_IOB_12_ADLIB_ADDR2,
>  			    OPL3_HW_AUTO, 1, &opl3) < 0) {
>  		printk(KERN_ERR "als4000: no OPL device at 0x%lx-0x%lx?\n",
> -			   gcr+0x10, gcr+0x12 );
> +			   iobase + ALS4K_IOB_10_ADLIB_ADDR0,
> +			   iobase + ALS4K_IOB_12_ADLIB_ADDR2);
>  	} else {
>  		if ((err = snd_opl3_hwdep_new(opl3, 0, 1, NULL)) < 0) {
>  			goto out_err;
> @@ -831,13 +921,13 @@
> #ifdef SUPPORT_JOYSTICK
>  	if (acard->gameport)
> -		snd_als4000_set_addr(acard->gcr, 0, 0, 0, 1);
> +		snd_als4000_set_addr(acard->iobase, 0, 0, 0, 1);
>  #endif
> 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
>  	return 0;
>  }
> -#endif
> +#endif /* CONFIG_PM */
> static struct pci_driver driver = {
