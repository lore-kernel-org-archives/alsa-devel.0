From: oeai <oeai@ya.ru>
Subject: EMU-1212m "no Audiodock - no firmware" patch
Date: Thu, 22 Nov 2012 02:18:47 +0400
Message-ID: <50AD5347.5040003@ya.ru>
Reply-To: oeai@ya.ru
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080108040107010500040503"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward3.mail.yandex.net (forward3.mail.yandex.net [77.88.46.8])
 by alsa0.perex.cz (Postfix) with ESMTP id CA575265D91
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 23:18:50 +0100 (CET)
Received: from smtp3.mail.yandex.net (smtp3.mail.yandex.net [77.88.46.103])
 by forward3.mail.yandex.net (Yandex) with ESMTP id 2D805B42391
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 02:18:50 +0400 (MSK)
Received: from smtp3.mail.yandex.net (localhost [127.0.0.1])
 by smtp3.mail.yandex.net (Yandex) with ESMTP id 148701BA0172
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 02:18:50 +0400 (MSK)
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

This is a multi-part message in MIME format.
--------------080108040107010500040503
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit

Aloha!

i've been posting about my problem earlier, but i decided to DIY

the problem was that when going up from suspend the firmware for 
additional card (that i don't have) was trying to load,
  -but there's no card
- sorry, i'm gonna check few more thousand times
that caused my cpu to load insanely

so in the patch i've changed few more strings for debugging

but actually the one (but not the only) bug
is here

*** 728,739 ****

!        if (reg & EMU_HANA_OPTION_DOCK_OFFLINE) {

--- 729,740 ----

!         if (reg & !EMU_HANA_OPTION_DOCK_OFFLINE) {

the thing is in the  "!"EMU_HANA_OPTION_DOCK_OFFLINE -> then the firmware should be loaded.

and to debug some errors if something i've put the one more else state so if no audiodock - it could continue to load config

*** 777,784 ****
   			/* Unmute all. Default is muted after a firmware load */
   			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE);
   		}
   	}
! 	snd_printk(KERN_INFO "emu1010: firmware thread stopping\n");
   	return 0;
   }
   
--- 778,790 ----
   			/* Unmute all. Default is muted after a firmware load */
   			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE);
   		}
+ 		else if ((reg & 0x3f) == 0x15)
+ 		{
+ 			snd_printk(KERN_INFO "emu1212m: trying to load config emu_hana_fpga_config");
+ 			snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG,0x02);
+ 		}
   	}
! 	snd_printk(KERN_INFO "emu1010: emu dock firmware thread stopping\n");
   	return 0;
   }
   
***************

then i've commented the power_down for audiodock - it should be in other place, but as i'm 1212m user - it works for me - you know.


*** 841,847 ****
   	outl(0x0005a000, emu->port + HCFG);
   
   	/* Disable 48Volt power to Audio Dock */
! 	snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_PWR, 0);
   
   	/* ID, should read & 0x7f = 0x55. (Bit 7 is the IRQ bit) */
   	snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg);
--- 847,853 ----
   	outl(0x0005a000, emu->port + HCFG);
   
   	/* Disable 48Volt power to Audio Dock */
! 	/*snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_PWR, 0);*/
   
   	/* ID, should read & 0x7f = 0x55. (Bit 7 is the IRQ bit) */
   	snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg);
***************

and here i've changed that the emu_model was firstly enabled and then ecard - since i don't know what's the ecard i thought that it is a second module of my emu card.


*** 2079,2088 ****
   {
   	if (emu->card_capabilities->ca_cardbus_chip)
   		snd_emu10k1_cardbus_init(emu);
! 	if (emu->card_capabilities->ecard)
! 		snd_emu10k1_ecard_init(emu);
! 	else if (emu->card_capabilities->emu_model)
   		snd_emu10k1_emu1010_init(emu);
   	else
   		snd_emu10k1_ptr_write(emu, AC97SLOT, 0, AC97SLOT_CNTR|AC97SLOT_LFE);
   	snd_emu10k1_init(emu, emu->enable_ir, 1);
--- 2098,2111 ----
   {
   	if (emu->card_capabilities->ca_cardbus_chip)
   		snd_emu10k1_cardbus_init(emu);
! 	
! 	if (emu->card_capabilities->emu_model)
! 	{
   		snd_emu10k1_emu1010_init(emu);
+ 		
+ 	}
+ 	else if (emu->card_capabilities->ecard)
+ 		snd_emu10k1_ecard_init(emu);
   	else
   		snd_emu10k1_ptr_write(emu, AC97SLOT, 0, AC97SLOT_CNTR|AC97SLOT_LFE);
   	snd_emu10k1_init(emu, emu->enable_ir, 1);


Now i still have the problem of waking up
i cannot request_firmware() properly on resume and it is trying to load nothing and other changes in patch - that was trying to debug the situation so i can at least alsa-reload at anytime.
also i'd like to ask if i can use the ctxfi modules - CA0110-IBG
i got xfi card (it is second of 5) that actually uses as i believe the same logic - maybe a lil modified, but not so much imho.


-- 
RA
OEAI


--------------080108040107010500040503
Content-Type: text/x-patch;
 name="emu10k1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="emu10k1.patch"

*** emu10k1_main.c	2012-11-22 01:23:24.000000000 +0400
--- emu10k1_main.c.long	2012-11-21 23:27:00.000000000 +0400
***************
*** 167,173 ****
  	unsigned int silent_page;
  	int ch;
  	u32 tmp;
! 
  	/* disable audio and lock cache */
  	outl(HCFG_LOCKSOUNDCACHE | HCFG_LOCKTANKCACHE_MASK |
  		HCFG_MUTEBUTTONENABLE, emu->port + HCFG);
--- 167,173 ----
  	unsigned int silent_page;
  	int ch;
  	u32 tmp;
! 	snd_printk(KERN_INFO "EMU Loader : Starting emu init \n");
  	/* disable audio and lock cache */
  	outl(HCFG_LOCKSOUNDCACHE | HCFG_LOCKTANKCACHE_MASK |
  		HCFG_MUTEBUTTONENABLE, emu->port + HCFG);
***************
*** 224,230 ****
  	}
  	if (emu->card_capabilities->ca0108_chip) { /* audigy2 Value */
  		/* Hacks for Alice3 to work independent of haP16V driver */
! 		snd_printk(KERN_INFO "Audigy2 value: Special config.\n");
  		/* Setup SRCMulti_I2S SamplingRate */
  		tmp = snd_emu10k1_ptr_read(emu, A_SPDIF_SAMPLERATE, 0);
  		tmp &= 0xfffff1ff;
--- 224,230 ----
  	}
  	if (emu->card_capabilities->ca0108_chip) { /* audigy2 Value */
  		/* Hacks for Alice3 to work independent of haP16V driver */
! 		snd_printk(KERN_INFO "EMU Loader : Special config. ca0108 chip ready\n");
  		/* Setup SRCMulti_I2S SamplingRate */
  		tmp = snd_emu10k1_ptr_read(emu, A_SPDIF_SAMPLERATE, 0);
  		tmp &= 0xfffff1ff;
***************
*** 250,256 ****
  	}
  	if (emu->card_capabilities->spi_dac) { /* Audigy 2 ZS Notebook with DAC Wolfson WM8768/WM8568 */
  		int size, n;
! 
  		size = ARRAY_SIZE(spi_dac_init);
  		for (n = 0; n < size; n++)
  			snd_emu10k1_spi_write(emu, spi_dac_init[n]);
--- 250,256 ----
  	}
  	if (emu->card_capabilities->spi_dac) { /* Audigy 2 ZS Notebook with DAC Wolfson WM8768/WM8568 */
  		int size, n;
! 		snd_printk(KERN_INFO "EMU Loader : Special config. spi_dac chip ready\n");
  		size = ARRAY_SIZE(spi_dac_init);
  		for (n = 0; n < size; n++)
  			snd_emu10k1_spi_write(emu, spi_dac_init[n]);
***************
*** 270,276 ****
  	}
  	if (emu->card_capabilities->i2c_adc) { /* Audigy 2 ZS Notebook with ADC Wolfson WM8775 */
  		int size, n;
! 
  		snd_emu10k1_ptr20_write(emu, P17V_I2S_SRC_SEL, 0, 0x2020205f);
  		tmp = inl(emu->port + A_IOCFG);
  		outl(tmp | 0x4, emu->port + A_IOCFG);  /* Set bit 2 for mic input */
--- 270,276 ----
  	}
  	if (emu->card_capabilities->i2c_adc) { /* Audigy 2 ZS Notebook with ADC Wolfson WM8775 */
  		int size, n;
! 	snd_printk(KERN_INFO "EMU Loader : Special config. i2c_adc chip ready\n");
  		snd_emu10k1_ptr20_write(emu, P17V_I2S_SRC_SEL, 0, 0x2020205f);
  		tmp = inl(emu->port + A_IOCFG);
  		outl(tmp | 0x4, emu->port + A_IOCFG);  /* Set bit 2 for mic input */
***************
*** 296,301 ****
--- 296,302 ----
  	}
  
  	if (emu->card_capabilities->emu_model) {
+ 		snd_printk(KERN_INFO "EMU Loader : Special config. found emu model !!!\n");
  		outl(HCFG_AUTOMUTE_ASYNC |
  			HCFG_EMU32_SLAVE |
  			HCFG_AUDIOENABLE, emu->port + HCFG);
***************
*** 728,739 ****
  
  	for (;;) {
  		/* Delay to allow Audio Dock to settle */
! 		msleep_interruptible(1000);
  		if (kthread_should_stop())
  			break;
  		snd_emu1010_fpga_read(emu, EMU_HANA_IRQ_STATUS, &tmp); /* IRQ Status */
  		snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg); /* OPTIONS: Which cards are attached to the EMU */
! 		if (reg & EMU_HANA_OPTION_DOCK_OFFLINE) {
  			/* Audio Dock attached */
  			/* Return to Audio Dock programming mode */
  			snd_printk(KERN_INFO "emu1010: Loading Audio Dock Firmware\n");
--- 729,740 ----
  
  	for (;;) {
  		/* Delay to allow Audio Dock to settle */
! 		msleep_interruptible(1111);
  		if (kthread_should_stop())
  			break;
  		snd_emu1010_fpga_read(emu, EMU_HANA_IRQ_STATUS, &tmp); /* IRQ Status */
  		snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg); /* OPTIONS: Which cards are attached to the EMU */
! 		if (reg & !EMU_HANA_OPTION_DOCK_OFFLINE) {
  			/* Audio Dock attached */
  			/* Return to Audio Dock programming mode */
  			snd_printk(KERN_INFO "emu1010: Loading Audio Dock Firmware\n");
***************
*** 777,784 ****
  			/* Unmute all. Default is muted after a firmware load */
  			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE);
  		}
  	}
! 	snd_printk(KERN_INFO "emu1010: firmware thread stopping\n");
  	return 0;
  }
  
--- 778,790 ----
  			/* Unmute all. Default is muted after a firmware load */
  			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE);
  		}
+ 		else if ((reg & 0x3f) == 0x15)
+ 		{
+ 			snd_printk(KERN_INFO "emu1212m: trying to load config emu_hana_fpga_config");
+ 			snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG,0x02);
+ 		}
  	}
! 	snd_printk(KERN_INFO "emu1010: emu dock firmware thread stopping\n");
  	return 0;
  }
  
***************
*** 841,847 ****
  	outl(0x0005a000, emu->port + HCFG);
  
  	/* Disable 48Volt power to Audio Dock */
! 	snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_PWR, 0);
  
  	/* ID, should read & 0x7f = 0x55. (Bit 7 is the IRQ bit) */
  	snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg);
--- 847,853 ----
  	outl(0x0005a000, emu->port + HCFG);
  
  	/* Disable 48Volt power to Audio Dock */
! 	/*snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_PWR, 0);*/
  
  	/* ID, should read & 0x7f = 0x55. (Bit 7 is the IRQ bit) */
  	snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg);
***************
*** 849,858 ****
  	if ((reg & 0x3f) == 0x15) {
  		/* FPGA netlist already present so clear it */
  		/* Return to programming mode */
! 
  		snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG, 0x02);
  	}
  	snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg);
  	snd_printdd("reg2 = 0x%x\n", reg);
  	if ((reg & 0x3f) == 0x15) {
  		/* FPGA failed to return to programming mode */
--- 855,867 ----
  	if ((reg & 0x3f) == 0x15) {
  		/* FPGA netlist already present so clear it */
  		/* Return to programming mode */
! 		snd_printk(KERN_INFO "emu1212: hana_fpga_config 0x%x\n", reg);
  		snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG, 0x02);
  	}
  	snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg);
+ 	snd_printk(KERN_INFO "emu1212: emu_hana_id read_fpga 0x%x\n", reg);
+ 	if (reg == 0x3f)
+ 	{
  	snd_printdd("reg2 = 0x%x\n", reg);
  	if ((reg & 0x3f) == 0x15) {
  		/* FPGA failed to return to programming mode */
***************
*** 860,865 ****
--- 869,876 ----
  		return -ENODEV;
  	}
  	snd_printk(KERN_INFO "emu1010: EMU_HANA_ID = 0x%x\n", reg);
+ 
+ 	
  	switch (emu->card_capabilities->emu_model) {
  	case EMU_MODEL_EMU1010:
  		filename = HANA_FILENAME;
***************
*** 878,891 ****
  		return -ENODEV;
  		break;
  	}
  	snd_printk(KERN_INFO "emu1010: filename %s testing\n", filename);
  	err = snd_emu1010_load_firmware(emu, filename);
  	if (err != 0) {
  		snd_printk(
  			KERN_INFO "emu1010: Loading Firmware file %s failed\n",
  			filename);
  		return err;
! 	}
  
  	/* ID, should read & 0x7f = 0x55 when FPGA programmed. */
  	snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg);
--- 889,905 ----
  		return -ENODEV;
  		break;
  	}
+ 	
  	snd_printk(KERN_INFO "emu1010: filename %s testing\n", filename);
+ 	
  	err = snd_emu1010_load_firmware(emu, filename);
  	if (err != 0) {
  		snd_printk(
  			KERN_INFO "emu1010: Loading Firmware file %s failed\n",
  			filename);
  		return err;
! 	} 
! 	
  
  	/* ID, should read & 0x7f = 0x55 when FPGA programmed. */
  	snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg);
***************
*** 899,905 ****
--- 913,922 ----
  	snd_emu1010_fpga_read(emu, EMU_HANA_MAJOR_REV, &tmp);
  	snd_emu1010_fpga_read(emu, EMU_HANA_MINOR_REV, &tmp2);
  	snd_printk(KERN_INFO "emu1010: Hana version: %u.%u\n", tmp, tmp2);
+ 	}
+ 	
  	/* Enable 48Volt power to Audio Dock */
+ 	
  	snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_PWR, EMU_HANA_DOCK_PWR_ON);
  
  	snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg);
***************
*** 1422,1432 ****
  	/* Tested by James@superbug.co.uk 4th Nov 2007. */
  	/* This is MAEM8960, 0202 is MAEM 8980 */
  	{.vendor = 0x1102, .device = 0x0008, .subsystem = 0x40041102,
! 	 .driver = "Audigy2", .name = "E-mu 1010b PCI [MAEM8960]",
  	 .id = "EMU1010",
  	 .emu10k2_chip = 1,
  	 .ca0108_chip = 1,
  	 .spk71 = 1,
  	 .emu_model = EMU_MODEL_EMU1010B}, /* EMU 1010 new revision */
  	/* Tested by James@superbug.co.uk 8th July 2005. */
  	/* This is MAEM8810, 0202 is MAEM8820 */
--- 1439,1451 ----
  	/* Tested by James@superbug.co.uk 4th Nov 2007. */
  	/* This is MAEM8960, 0202 is MAEM 8980 */
  	{.vendor = 0x1102, .device = 0x0008, .subsystem = 0x40041102,
! 	 .driver = "Audigy2", .name = "E-mu 1212m PCI [MAEM8980]",
  	 .id = "EMU1010",
  	 .emu10k2_chip = 1,
  	 .ca0108_chip = 1,
  	 .spk71 = 1,
+ 	 .ca_cardbus_chip = 1,
+ 	 .i2c_adc = 1,
  	 .emu_model = EMU_MODEL_EMU1010B}, /* EMU 1010 new revision */
  	/* Tested by James@superbug.co.uk 8th July 2005. */
  	/* This is MAEM8810, 0202 is MAEM8820 */
***************
*** 2079,2088 ****
  {
  	if (emu->card_capabilities->ca_cardbus_chip)
  		snd_emu10k1_cardbus_init(emu);
! 	if (emu->card_capabilities->ecard)
! 		snd_emu10k1_ecard_init(emu);
! 	else if (emu->card_capabilities->emu_model)
  		snd_emu10k1_emu1010_init(emu);
  	else
  		snd_emu10k1_ptr_write(emu, AC97SLOT, 0, AC97SLOT_CNTR|AC97SLOT_LFE);
  	snd_emu10k1_init(emu, emu->enable_ir, 1);
--- 2098,2111 ----
  {
  	if (emu->card_capabilities->ca_cardbus_chip)
  		snd_emu10k1_cardbus_init(emu);
! 	
! 	if (emu->card_capabilities->emu_model)
! 	{
  		snd_emu10k1_emu1010_init(emu);
+ 		
+ 	}
+ 	else if (emu->card_capabilities->ecard)
+ 		snd_emu10k1_ecard_init(emu);
  	else
  		snd_emu10k1_ptr_write(emu, AC97SLOT, 0, AC97SLOT_CNTR|AC97SLOT_LFE);
  	snd_emu10k1_init(emu, emu->enable_ir, 1);

--------------080108040107010500040503
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080108040107010500040503--
