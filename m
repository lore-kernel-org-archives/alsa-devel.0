From: oeai <oeai@ya.ru>
Subject: Re: EMU-1212m "no Audiodock - no firmware" patch
Date: Sat, 29 Dec 2012 06:52:59 +0400
Message-ID: <50DE5B0B.4040300@ya.ru>
References: <50AD5347.5040003@ya.ru> <s5h8v9tr1zu.wl%tiwai@suse.de>
Reply-To: oeai@ya.ru
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040709000304050609040607"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward2h.mail.yandex.net (forward2h.mail.yandex.net
 [84.201.187.147])
 by alsa0.perex.cz (Postfix) with ESMTP id 23C632615D5
 for <alsa-devel@alsa-project.org>; Sat, 29 Dec 2012 03:53:02 +0100 (CET)
In-Reply-To: <s5h8v9tr1zu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <james.dutton@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040709000304050609040607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

here's the file with patch

aLoha!
Sorry, being so long, i was doing some other things.

i've downloaded the sound.git and somehow just compiled right what i 
needed and changed the code.

i've changed the snd_emu10k1_emu1010_init function so it is now loading 
regs from other function load_patches
     because of that a lot of space has changed, but it is simplier to 
just set to default right now
     and the error in the init function was that it was not calling the 
load_firmware function in the end
     that's the real problem
     and a lot of changes that in the load_patches are just to leave 
audiodock outside if it is not presented
     tried the resume function - it's not working for emu1212 need to 
reload alsa
     i thought of calling dev_create or dev_free but not sure how to use 
it free_emu is hanging up on wake_up
     yeah i've done the exclamation !EMU_HANA_OPTION_DOCK_OFFLINE in 
firmware_thread and added "else if" to avoid occasional error
     well it is Loading!!!
     and looks like no loops occuring.

in the bottom there's a emufx.c patch
Disabled most of unuseful sliders for emu_model cards



-- 
OEAI


--------------040709000304050609040607
Content-Type: text/plain; charset=UTF-8;
 name="emu10k1.patchy"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="emu10k1.patchy"


----------------------- sound/pci/emu10k1/emu10k1_main.c -----------------------
index a7c296a..2b2647a 100644
@@ -161,6 +161,7 @@ static int snd_emu10k1_init(struct snd_emu10k1 *emu, int enable_ir, int resume)
     int ch;
     u32 tmp;
 
+    snd_printk(KERN_INFO "Creative Audio : Starting loader \n");
     /* disable audio and lock cache */
     outl(HCFG_LOCKSOUNDCACHE | HCFG_LOCKTANKCACHE_MASK |
         HCFG_MUTEBUTTONENABLE, emu->port + HCFG);
@@ -217,7 +218,7 @@ static int snd_emu10k1_init(struct snd_emu10k1 *emu, int enable_ir, int resume)
     }
     if (emu->card_capabilities->ca0108_chip) { /* audigy2 Value */
         /* Hacks for Alice3 to work independent of haP16V driver */
-        snd_printk(KERN_INFO "Audigy2 value: Special config.\n");
+        snd_printk(KERN_INFO "Creative Audio : Special config.  ca0108 chip ready \n");
         /* Setup SRCMulti_I2S SamplingRate */
         tmp = snd_emu10k1_ptr_read(emu, A_SPDIF_SAMPLERATE, 0);
         tmp &= 0xfffff1ff;
@@ -244,6 +245,7 @@ static int snd_emu10k1_init(struct snd_emu10k1 *emu, int enable_ir, int resume)
     if (emu->card_capabilities->spi_dac) { /* Audigy 2 ZS Notebook with DAC Wolfson WM8768/WM8568 */
         int size, n;
 
+        snd_printk(KERN_INFO "Creative Audio : Special config. spi_dac chip ready \n");
         size = ARRAY_SIZE(spi_dac_init);
         for (n = 0; n < size; n++)
             snd_emu10k1_spi_write(emu, spi_dac_init[n]);
@@ -264,6 +266,7 @@ static int snd_emu10k1_init(struct snd_emu10k1 *emu, int enable_ir, int resume)
     if (emu->card_capabilities->i2c_adc) { /* Audigy 2 ZS Notebook with ADC Wolfson WM8775 */
         int size, n;
 
+        snd_printk(KERN_INFO "Creative Audio : Special config. i2c_adc chip ready \n");
         snd_emu10k1_ptr20_write(emu, P17V_I2S_SRC_SEL, 0, 0x2020205f);
         tmp = inl(emu->port + A_IOCFG);
         outl(tmp | 0x4, emu->port + A_IOCFG);  /* Set bit 2 for mic input */
@@ -289,6 +292,7 @@ static int snd_emu10k1_init(struct snd_emu10k1 *emu, int enable_ir, int resume)
     }
 
     if (emu->card_capabilities->emu_model) {
+        snd_printk(KERN_INFO "Creative Audio : Special config. Creative E-MU SoundCard found \n");
         outl(HCFG_AUTOMUTE_ASYNC |
             HCFG_EMU32_SLAVE |
             HCFG_AUDIOENABLE, emu->port + HCFG);
@@ -720,7 +724,7 @@ static int emu1010_firmware_thread(void *data)
 #endif
         snd_emu1010_fpga_read(emu, EMU_HANA_IRQ_STATUS, &tmp); /* IRQ Status */
         snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg); /* OPTIONS: Which cards are attached to the EMU */
-        if (reg & EMU_HANA_OPTION_DOCK_OFFLINE) {
+        if (reg & !EMU_HANA_OPTION_DOCK_OFFLINE) { /* ! if it is really connected -> it must be online*/
             /* Audio Dock attached */
             /* Return to Audio Dock programming mode */
             snd_printk(KERN_INFO "emu1010: Loading Audio Dock Firmware\n");
@@ -751,6 +755,12 @@ static int emu1010_firmware_thread(void *data)
             /* Unmute all. Default is muted after a firmware load */
             snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE);
         }
+        else if ((reg & 0x3f) == 0x15)
+        {
+            snd_printk(KERN_INFO "emu1212m: trying to load config emu_hana_fpga_config"); /*This is what James Courtier-Dutton was talking about i guess*/
+            snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG,0x02); /*Init FPGA firmware if no audiodock is loaded*/
+        }
+
     }
     snd_printk(KERN_INFO "emu1010: firmware thread stopping\n");
     return 0;
@@ -787,95 +797,15 @@ static int emu1010_firmware_thread(void *data)
  *        16 x 16-bit playback - snd_emu10k1_fx8010_playback_ops
  *         16 x 32-bit capture - snd_emu10k1_capture_efx_ops
  */
-static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
+
+ /*Load patches for emu card after checking of its availability in emu1010_init*/
+static int snd_emu10k1_emu1010_load_patches(struct snd_emu10k1 *emu)
+
 {
     unsigned int i;
-    u32 tmp, tmp2, reg;
-    int err;
+    u32 tmp, reg;
 
-    snd_printk(KERN_INFO "emu1010: Special config.\n");
-    /* AC97 2.1, Any 16Meg of 4Gig address, Auto-Mute, EMU32 Slave,
-     * Lock Sound Memory Cache, Lock Tank Memory Cache,
-     * Mute all codecs.
-     */
-    outl(0x0005a00c, emu->port + HCFG);
-    /* AC97 2.1, Any 16Meg of 4Gig address, Auto-Mute, EMU32 Slave,
-     * Lock Tank Memory Cache,
-     * Mute all codecs.
-     */
-    outl(0x0005a004, emu->port + HCFG);
-    /* AC97 2.1, Any 16Meg of 4Gig address, Auto-Mute, EMU32 Slave,
-     * Mute all codecs.
-     */
-    outl(0x0005a000, emu->port + HCFG);
-    /* AC97 2.1, Any 16Meg of 4Gig address, Auto-Mute, EMU32 Slave,
-     * Mute all codecs.
-     */
-    outl(0x0005a000, emu->port + HCFG);
 
-    /* Disable 48Volt power to Audio Dock */
-    snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_PWR, 0);
-
-    /* ID, should read & 0x7f = 0x55. (Bit 7 is the IRQ bit) */
-    snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg);
-    snd_printdd("reg1 = 0x%x\n", reg);
-    if ((reg & 0x3f) == 0x15) {
-        /* FPGA netlist already present so clear it */
-        /* Return to programming mode */
-
-        snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG, 0x02);
-    }
-    snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg);
-    snd_printdd("reg2 = 0x%x\n", reg);
-    if ((reg & 0x3f) == 0x15) {
-        /* FPGA failed to return to programming mode */
-        snd_printk(KERN_INFO "emu1010: FPGA failed to return to programming mode\n");
-        return -ENODEV;
-    }
-    snd_printk(KERN_INFO "emu1010: EMU_HANA_ID = 0x%x\n", reg);
-
-    if (!emu->firmware) {
-        const char *filename;
-        switch (emu->card_capabilities->emu_model) {
-        case EMU_MODEL_EMU1010:
-            filename = HANA_FILENAME;
-            break;
-        case EMU_MODEL_EMU1010B:
-            filename = EMU1010B_FILENAME;
-            break;
-        case EMU_MODEL_EMU1616:
-            filename = EMU1010_NOTEBOOK_FILENAME;
-            break;
-        case EMU_MODEL_EMU0404:
-            filename = EMU0404_FILENAME;
-            break;
-        default:
-            return -ENODEV;
-        }
-
-        err = request_firmware(&emu->firmware, filename, &emu->pci->dev);
-        if (err != 0) {
-            snd_printk(KERN_ERR "emu1010: firmware: %s not found. Err = %d\n", filename, err);
-            return err;
-        }
-        snd_printk(KERN_INFO "emu1010: firmware file = %s, size = 0x%zx\n",
-               filename, emu->firmware->size);
-    }
-
-    /* ID, should read & 0x7f = 0x55 when FPGA programmed. */
-    snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg);
-    if ((reg & 0x3f) != 0x15) {
-        /* FPGA failed to be programmed */
-        snd_printk(KERN_INFO "emu1010: Loading Hana Firmware file failed, reg = 0x%x\n", reg);
-        return -ENODEV;
-    }
-
-    snd_printk(KERN_INFO "emu1010: Hana Firmware loaded\n");
-    snd_emu1010_fpga_read(emu, EMU_HANA_MAJOR_REV, &tmp);
-    snd_emu1010_fpga_read(emu, EMU_HANA_MINOR_REV, &tmp2);
-    snd_printk(KERN_INFO "emu1010: Hana version: %u.%u\n", tmp, tmp2);
-    /* Enable 48Volt power to Audio Dock */
-    snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_PWR, EMU_HANA_DOCK_PWR_ON);
 
     snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg);
     snd_printk(KERN_INFO "emu1010: Card options = 0x%x\n", reg);
@@ -896,16 +826,12 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
     /* Set no attenuation on Audio Dock pads. */
     snd_emu1010_fpga_write(emu, EMU_HANA_ADC_PADS, 0x00);
     emu->emu1010.adc_pads = 0x00;
-    snd_emu1010_fpga_read(emu, EMU_HANA_DOCK_MISC, &tmp);
-    /* Unmute Audio dock DACs, Headphone source DAC-4. */
-    snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_MISC, 0x30);
-    snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_LEDS_2, 0x12);
+
     snd_emu1010_fpga_read(emu, EMU_HANA_DAC_PADS, &tmp);
     /* DAC PADs. */
     snd_emu1010_fpga_write(emu, EMU_HANA_DAC_PADS, 0x0f);
     emu->emu1010.dac_pads = 0x0f;
-    snd_emu1010_fpga_read(emu, EMU_HANA_DOCK_MISC, &tmp);
-    snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_MISC, 0x30);
+
     snd_emu1010_fpga_read(emu, EMU_HANA_SPDIF_MODE, &tmp);
     /* SPDIF Format. Set Consumer mode, 24bit, copy enable */
     snd_emu1010_fpga_write(emu, EMU_HANA_SPDIF_MODE, 0x10);
@@ -925,8 +851,24 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
     /* Word Clock source, Internal 48kHz x1 */
     snd_emu1010_fpga_write(emu, EMU_HANA_WCLOCK, EMU_HANA_WCLOCK_INT_48K);
     /* snd_emu1010_fpga_write(emu, EMU_HANA_WCLOCK, EMU_HANA_WCLOCK_INT_48K | EMU_HANA_WCLOCK_4X); */
+   
+    /* AudioDock Init */
+    snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg); /* OPTIONS: Which cards are attached to the EMU */
+    if (reg & !EMU_HANA_OPTION_DOCK_OFFLINE)
+    {
+       
+    /* Enable 48Volt power to Audio Dock */
+    snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_PWR, EMU_HANA_DOCK_PWR_ON);
+    snd_emu1010_fpga_read(emu, EMU_HANA_DOCK_MISC, &tmp);
+    /* Unmute Audio dock DACs, Headphone source DAC-4. */
+    snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_MISC, 0x30);
+    snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_LEDS_2, 0x12);
+    /* Disable 48Volt power to Audio Dock */
+    snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_PWR, 0);
+   
     /* Audio Dock LEDs. */
     snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_LEDS_2, 0x12);
+    }
 
 #if 0
     /* For 96kHz */
@@ -960,14 +902,19 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
 #endif
 #if 1
     /* For 48kHz */
-    snd_emu1010_fpga_link_dst_src_write(emu,
-        EMU_DST_ALICE2_EMU32_0, EMU_SRC_DOCK_MIC_A1);
-    snd_emu1010_fpga_link_dst_src_write(emu,
-        EMU_DST_ALICE2_EMU32_1, EMU_SRC_DOCK_MIC_B1);
+
     snd_emu1010_fpga_link_dst_src_write(emu,
         EMU_DST_ALICE2_EMU32_2, EMU_SRC_HAMOA_ADC_LEFT2);
     snd_emu1010_fpga_link_dst_src_write(emu,
         EMU_DST_ALICE2_EMU32_3, EMU_SRC_HAMOA_ADC_LEFT2);
+       
+        //AudioDOck? - Nah, i don't have it...
+    if (reg & !EMU_HANA_OPTION_DOCK_OFFLINE)
+    {   
+    snd_emu1010_fpga_link_dst_src_write(emu,
+        EMU_DST_ALICE2_EMU32_0, EMU_SRC_DOCK_MIC_A1);
+    snd_emu1010_fpga_link_dst_src_write(emu,
+        EMU_DST_ALICE2_EMU32_1, EMU_SRC_DOCK_MIC_B1);   
     snd_emu1010_fpga_link_dst_src_write(emu,
         EMU_DST_ALICE2_EMU32_4, EMU_SRC_DOCK_ADC1_LEFT1);
     snd_emu1010_fpga_link_dst_src_write(emu,
@@ -980,16 +927,11 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
      * Defaults only, users will set their own values anyways, let's
      * just copy/paste.
      */
-
     snd_emu1010_fpga_link_dst_src_write(emu,
         EMU_DST_ALICE2_EMU32_8, EMU_SRC_DOCK_MIC_A1);
     snd_emu1010_fpga_link_dst_src_write(emu,
         EMU_DST_ALICE2_EMU32_9, EMU_SRC_DOCK_MIC_B1);
     snd_emu1010_fpga_link_dst_src_write(emu,
-        EMU_DST_ALICE2_EMU32_A, EMU_SRC_HAMOA_ADC_LEFT2);
-    snd_emu1010_fpga_link_dst_src_write(emu,
-        EMU_DST_ALICE2_EMU32_B, EMU_SRC_HAMOA_ADC_LEFT2);
-    snd_emu1010_fpga_link_dst_src_write(emu,
         EMU_DST_ALICE2_EMU32_C, EMU_SRC_DOCK_ADC1_LEFT1);
     snd_emu1010_fpga_link_dst_src_write(emu,
         EMU_DST_ALICE2_EMU32_D, EMU_SRC_DOCK_ADC1_RIGHT1);
@@ -997,6 +939,13 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
         EMU_DST_ALICE2_EMU32_E, EMU_SRC_DOCK_ADC2_LEFT1);
     snd_emu1010_fpga_link_dst_src_write(emu,
         EMU_DST_ALICE2_EMU32_F, EMU_SRC_DOCK_ADC2_RIGHT1);
+    }
+   
+    snd_emu1010_fpga_link_dst_src_write(emu,
+        EMU_DST_ALICE2_EMU32_A, EMU_SRC_HAMOA_ADC_LEFT2);
+    snd_emu1010_fpga_link_dst_src_write(emu,
+        EMU_DST_ALICE2_EMU32_B, EMU_SRC_HAMOA_ADC_LEFT2);
+   
 #endif
 #if 0
     /* Original */
@@ -1016,10 +965,14 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
         EMU_DST_ALICE2_EMU32_A, EMU_SRC_HANA_ADAT + 6);
     snd_emu1010_fpga_link_dst_src_write(emu,
         EMU_DST_ALICE2_EMU32_B, EMU_SRC_HANA_ADAT + 7);
+                //AudioDOck? - Nah, i don't have it...
+    if (reg & !EMU_HANA_OPTION_DOCK_OFFLINE)
+    {   
     snd_emu1010_fpga_link_dst_src_write(emu,
         EMU_DST_ALICE2_EMU32_C, EMU_SRC_DOCK_MIC_A1);
     snd_emu1010_fpga_link_dst_src_write(emu,
         EMU_DST_ALICE2_EMU32_D, EMU_SRC_DOCK_MIC_B1);
+    }
     snd_emu1010_fpga_link_dst_src_write(emu,
         EMU_DST_ALICE2_EMU32_E, EMU_SRC_HAMOA_ADC_LEFT2);
     snd_emu1010_fpga_link_dst_src_write(emu,
@@ -1041,6 +994,9 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
         /* Hana ADAT Out <- Silence */
         snd_emu1010_fpga_link_dst_src_write(emu, EMU_DST_HANA_ADAT + i, EMU_SRC_SILENCE);
     }
+            //AudioDOck? - Nah, i don't have it...
+    if (reg & !EMU_HANA_OPTION_DOCK_OFFLINE)
+    {   
     snd_emu1010_fpga_link_dst_src_write(emu,
         EMU_DST_ALICE_I2S0_LEFT, EMU_SRC_DOCK_ADC1_LEFT1);
     snd_emu1010_fpga_link_dst_src_write(emu,
@@ -1053,6 +1009,7 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
         EMU_DST_ALICE_I2S2_LEFT, EMU_SRC_DOCK_ADC3_LEFT1);
     snd_emu1010_fpga_link_dst_src_write(emu,
         EMU_DST_ALICE_I2S2_RIGHT, EMU_SRC_DOCK_ADC3_RIGHT1);
+    }
     snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, 0x01); /* Unmute all */
 
     snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &tmp);
@@ -1100,6 +1057,9 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
     if (emu->card_capabilities->emu_model == EMU_MODEL_EMU1616) {
         /* 1616(M) cardbus default outputs */
         /* ALICE2 bus 0xa0 */
+                //AudioDOck? - Nah, i don't have it...
+    if (reg & !EMU_HANA_OPTION_DOCK_OFFLINE)
+    {   
         snd_emu1010_fpga_link_dst_src_write(emu,
             EMU_DST_DOCK_DAC1_LEFT1, EMU_SRC_ALICE_EMU32A + 0);
         emu->emu1010.output_source[0] = 17;
@@ -1118,6 +1078,7 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
         snd_emu1010_fpga_link_dst_src_write(emu,
             EMU_DST_DOCK_DAC3_RIGHT1, EMU_SRC_ALICE_EMU32A + 5);
         emu->emu1010.output_source[5] = 22;
+    }
         /* ALICE2 bus 0xa0 */
         snd_emu1010_fpga_link_dst_src_write(emu,
             EMU_DST_MANA_DAC_LEFT, EMU_SRC_ALICE_EMU32A + 0);
@@ -1127,6 +1088,9 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
         emu->emu1010.output_source[17] = 18;
     } else {
         /* ALICE2 bus 0xa0 */
+                //AudioDOck? - Nah, i don't have it...
+    if (reg & !EMU_HANA_OPTION_DOCK_OFFLINE)
+    {   
         snd_emu1010_fpga_link_dst_src_write(emu,
             EMU_DST_DOCK_DAC1_LEFT1, EMU_SRC_ALICE_EMU32A + 0);
         emu->emu1010.output_source[0] = 21;
@@ -1165,6 +1129,7 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
         snd_emu1010_fpga_link_dst_src_write(emu,
             EMU_DST_DOCK_SPDIF_RIGHT1, EMU_SRC_ALICE_EMU32A + 1);
         emu->emu1010.output_source[11] = 22;
+    }
         /* ALICE2 bus 0xa0 */
         snd_emu1010_fpga_link_dst_src_write(emu,
             EMU_DST_HANA_SPDIF_LEFT1, EMU_SRC_ALICE_EMU32A + 0);
@@ -1215,7 +1180,11 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
     snd_emu1010_fpga_write(emu, EMU_HANA_WCLOCK, EMU_HANA_WCLOCK_INT_48K);
     /* snd_emu1010_fpga_write(emu, EMU_HANA_WCLOCK, EMU_HANA_WCLOCK_INT_48K | EMU_HANA_WCLOCK_4X); */
     emu->emu1010.internal_clock = 1; /* 48000 */
+            //AudioDOck? - Nah, i don't have it...
+    if (reg & !EMU_HANA_OPTION_DOCK_OFFLINE)
+    {   
     snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_LEDS_2, 0x12); /* Set LEDs on Audio Dock */
+    }
     snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, 0x1); /* Unmute all */
     /* snd_emu1010_fpga_write(emu, 0x7, 0x0); */ /* Mute all */
     /* snd_emu1010_fpga_write(emu, 0x7, 0x1); */ /* Unmute all */
@@ -1223,6 +1192,120 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
 
     return 0;
 }
+
+/*moved this function down because patch_loading function must be declared first*/
+
+static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
+{
+   
+    u32 tmp, tmp2, reg;
+    int err;
+   
+    snd_printk(KERN_INFO "E-MU 1x1x : Special config. Found Creative EMU \n");
+    /* AC97 2.1, Any 16Meg of 4Gig address, Auto-Mute, EMU32 Slave,
+     * Lock Sound Memory Cache, Lock Tank Memory Cache,
+     * Mute all codecs.
+     */
+    outl(0x0005a00c, emu->port + HCFG);
+    /* AC97 2.1, Any 16Meg of 4Gig address, Auto-Mute, EMU32 Slave,
+     * Lock Tank Memory Cache,
+     * Mute all codecs.
+     */
+    outl(0x0005a004, emu->port + HCFG);
+    /* AC97 2.1, Any 16Meg of 4Gig address, Auto-Mute, EMU32 Slave,
+     * Mute all codecs.
+     */
+    outl(0x0005a000, emu->port + HCFG);
+    /* AC97 2.1, Any 16Meg of 4Gig address, Auto-Mute, EMU32 Slave,
+     * Mute all codecs.
+     */
+    outl(0x0005a000, emu->port + HCFG);
+
+
+    /* ID, should read & 0x7f = 0x55. (Bit 7 is the IRQ bit) */
+    snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg);
+    snd_printdd("reg1 = 0x%x\n", reg);
+    if ((reg & 0x3f) == 0x15) {
+        /* FPGA netlist already present so clear it */
+        /* Return to programming mode */
+        snd_printk(KERN_INFO "emu1212: hana_fpga_config 0x%x\n", reg);
+        snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG, 0x02);
+    }
+    snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg);
+    snd_printdd("reg2 = 0x%x\n", reg);
+    if (reg == 0x3f)
+    {
+    snd_printdd("reg2 = 0x%x\n", reg);
+    if ((reg & 0x3f) == 0x15) {
+        /* FPGA failed to return to programming mode */
+        snd_printk(KERN_INFO "emu1010: FPGA failed to return to programming mode\n");
+        return -ENODEV;
+    }
+    snd_printk(KERN_INFO "emu1010: EMU_HANA_ID = 0x%x\n", reg);
+
+    if (!emu->firmware) {
+        const char *filename;
+        switch (emu->card_capabilities->emu_model) {
+        case EMU_MODEL_EMU1010:
+            filename = HANA_FILENAME;
+            break;
+        case EMU_MODEL_EMU1010B:
+            filename = EMU1010B_FILENAME;
+            break;
+        case EMU_MODEL_EMU1616:
+            filename = EMU1010_NOTEBOOK_FILENAME;
+            break;
+        case EMU_MODEL_EMU0404:
+            filename = EMU0404_FILENAME;
+            break;
+        default:
+            return -ENODEV;
+        }
+       
+        snd_printk(KERN_INFO "Creative Audio : firmware file %s testing\n", filename);
+       
+        err = request_firmware(&emu->firmware, filename, &emu->pci->dev);
+        if (err != 0) {
+            snd_printk(KERN_ERR "emu1010: firmware: %s not found. Err = %d\n", filename, err);
+            return err;
+        }
+        snd_printk(KERN_INFO "emu1010: firmware file = %s, size = 0x%zx\n",
+               filename, emu->firmware->size);
+              
+    err = snd_emu1010_load_firmware(emu);
+    if (err != 0) {
+        snd_printk(
+            KERN_INFO "emu1010: Loading Firmware file %s failed\n",
+            filename);
+        return err;
+    }
+    }
+
+    /* ID, should read & 0x7f = 0x55 when FPGA programmed. */
+    snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg);
+    if ((reg & 0x3f) != 0x15) {
+        /* FPGA failed to be programmed */
+        snd_printk(KERN_INFO "emu1010: Loading Hana Firmware file failed, reg = 0x%x\n", reg);
+        return -ENODEV;
+    }
+
+    snd_printk(KERN_INFO "emu1010: Hana Firmware loaded\n");
+    snd_emu1010_fpga_read(emu, EMU_HANA_MAJOR_REV, &tmp);
+    snd_emu1010_fpga_read(emu, EMU_HANA_MINOR_REV, &tmp2);
+    snd_printk(KERN_INFO "emu1010: Hana version: %u.%u\n", tmp, tmp2);
+   
+    /*Here it is loading patches after checking and loading firmware*/
+    return snd_emu10k1_emu1010_load_patches(emu);
+   
+    }
+   
+    return 0;
+   
+}
+
+
+
+
 /*
  *  Create the EMU10K1 instance
  */
@@ -1241,6 +1324,9 @@ static int snd_emu10k1_free(struct snd_emu10k1 *emu)
     }
     if (emu->card_capabilities->emu_model == EMU_MODEL_EMU1010) {
         /* Disable 48Volt power to Audio Dock */
+        int reg;
+        snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg); /* Do i have AudioDock online?*/
+        if (reg & !EMU_HANA_OPTION_DOCK_OFFLINE)
         snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_PWR, 0);
     }
     if (emu->emu1010.firmware_thread)
@@ -1393,16 +1479,17 @@ static struct snd_emu_chip_details emu_chip_details[] = {
      .emu10k2_chip = 1,
      .ca0108_chip = 1,
      .ca_cardbus_chip = 1,
-     .spk71 = 1 ,
      .emu_model = EMU_MODEL_EMU1616},
     /* Tested by James@superbug.co.uk 4th Nov 2007. */
     /* This is MAEM8960, 0202 is MAEM 8980 */
     {.vendor = 0x1102, .device = 0x0008, .subsystem = 0x40041102,
-     .driver = "Audigy2", .name = "E-mu 1010b PCI [MAEM8960]",
+     .driver = "Audigy2", .name = "E-MU 1010b or 1212m PCI [MAEM8960]",
      .id = "EMU1010",
      .emu10k2_chip = 1,
      .ca0108_chip = 1,
      .spk71 = 1,
+     .ca_cardbus_chip = 1,
+     .adc_1361t = 1,
      .emu_model = EMU_MODEL_EMU1010B}, /* EMU 1010 new revision */
     /* Tested by Maxim Kachur <mcdebugger@duganet.ru> 17th Oct 2012. */
     /* This is MAEM8986, 0202 is MAEM8980 */
@@ -1893,7 +1980,15 @@ int snd_emu10k1_create(struct snd_card *card,
     emu->fx8010.extout_mask = extout_mask;
     emu->enable_ir = enable_ir;
 
-    if (emu->card_capabilities->ca_cardbus_chip) {
+/*First init the main card then ca_cardbus*/
+
+    if (emu->card_capabilities->emu_model) {
+        err = snd_emu10k1_emu1010_init(emu);
+        if (err < 0) {
+            snd_emu10k1_free(emu);
+            return err;
+        }
+    } else if (emu->card_capabilities->ca_cardbus_chip) {
         err = snd_emu10k1_cardbus_init(emu);
         if (err < 0)
             goto error;
@@ -1902,12 +1997,7 @@ int snd_emu10k1_create(struct snd_card *card,
         err = snd_emu10k1_ecard_init(emu);
         if (err < 0)
             goto error;
-    } else if (emu->card_capabilities->emu_model) {
-        err = snd_emu10k1_emu1010_init(emu);
-        if (err < 0) {
-            snd_emu10k1_free(emu);
-            return err;
-        }
+   
     } else {
         /* 5.1: Enable the additional AC97 Slots. If the emu10k1 version
             does not support this, it shouldn't do any harm */
@@ -2061,12 +2151,18 @@ void snd_emu10k1_suspend_regs(struct snd_emu10k1 *emu)
 
 void snd_emu10k1_resume_init(struct snd_emu10k1 *emu)
 {
+    if (emu->card_capabilities->emu_model)
+    {
+       
+        snd_emu10k1_emu1010_init(emu);
+        snd_emu10k1_resume_regs(emu);
+       
+    }
     if (emu->card_capabilities->ca_cardbus_chip)
         snd_emu10k1_cardbus_init(emu);
     if (emu->card_capabilities->ecard)
         snd_emu10k1_ecard_init(emu);
-    else if (emu->card_capabilities->emu_model)
-        snd_emu10k1_emu1010_init(emu);
+     
     else
         snd_emu10k1_ptr_write(emu, AC97SLOT, 0, AC97SLOT_CNTR|AC97SLOT_LFE);
     snd_emu10k1_init(emu, emu->enable_ir, 1);

====================================================================================================

so here's the emufx patch, i cannot push to the git directly, so it is the just like this patch.

 2426e9f0d705e0741536b07485ae415f4a14e47b (Merge branch 'for-next')
: master
: sound-3.8
:

Disabled most of unuseful sliders for emu_model cards, if there is emu_model no ac97 or spk71 5.1 interfaces is loading

-------------------------- sound/pci/emu10k1/emufx.c --------------------------
index 0275209..5ed7fbb 100644
@@ -1223,6 +1223,7 @@ static int _snd_emu10k1_audigy_init_efx(struct snd_emu10k1 *emu)
      * where gpr contains attenuation from corresponding mixer control
      * (snd_emu10k1_init_stereo_control)
      */
+    if (!emu->card_capabilities->emu_model) {
     A_OP(icode, &ptr, iMAC0, A_GPR(playback), A_C_00000000, A_GPR(gpr), A_FXBUS(FXBUS_PCM_LEFT_FRONT));
     A_OP(icode, &ptr, iMAC0, A_GPR(playback+1), A_C_00000000, A_GPR(gpr+1), A_FXBUS(FXBUS_PCM_RIGHT_FRONT));
     snd_emu10k1_init_stereo_control(&controls[nctl++], "PCM Front Playback Volume", gpr, 100);
@@ -1247,6 +1248,7 @@ static int _snd_emu10k1_audigy_init_efx(struct snd_emu10k1 *emu)
     snd_emu10k1_init_mono_control(&controls[nctl++], "PCM Center Playback Volume", gpr, 100);
     gpr++;
 
+    }
     /* PCM LFE Playback (independent from stereo mix) */
     A_OP(icode, &ptr, iMAC0, A_GPR(playback+5), A_C_00000000, A_GPR(gpr), A_FXBUS(FXBUS_PCM_LFE));
     snd_emu10k1_init_mono_control(&controls[nctl++], "PCM LFE Playback Volume", gpr, 100);
@@ -1300,6 +1302,20 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
         snd_emu10k1_init_stereo_control(&controls[nctl++], "EMU Capture Volume", gpr, 0);
         gpr += 2;
     }
+   
+   
+     /* Optical SPDIF Playback Volume */
+    A_ADD_VOLUME_IN(stereo_mix, gpr, A_EXTIN_OPT_SPDIF_L);
+    A_ADD_VOLUME_IN(stereo_mix+1, gpr+1, A_EXTIN_OPT_SPDIF_R);
+    snd_emu10k1_init_stereo_control(&controls[nctl++], SNDRV_CTL_NAME_IEC958("Optical ",PLAYBACK,VOLUME), gpr, 0);
+    gpr += 2;
+    /* Optical SPDIF Capture Volume */
+    A_ADD_VOLUME_IN(capture, gpr, A_EXTIN_OPT_SPDIF_L);
+    A_ADD_VOLUME_IN(capture+1, gpr+1, A_EXTIN_OPT_SPDIF_R);
+    snd_emu10k1_init_stereo_control(&controls[nctl++], SNDRV_CTL_NAME_IEC958("Optical ",CAPTURE,VOLUME), gpr, 0);
+    gpr += 2;
+
+    if (!emu->card_capabilities->emu_model) {
     /* AC'97 Playback Volume - used only for mic (renamed later) */
     A_ADD_VOLUME_IN(stereo_mix, gpr, A_EXTIN_AC97_L);
     A_ADD_VOLUME_IN(stereo_mix+1, gpr+1, A_EXTIN_AC97_R);
@@ -1329,17 +1345,6 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
                     gpr, 0);
     gpr += 2;
 
-     /* Optical SPDIF Playback Volume */
-    A_ADD_VOLUME_IN(stereo_mix, gpr, A_EXTIN_OPT_SPDIF_L);
-    A_ADD_VOLUME_IN(stereo_mix+1, gpr+1, A_EXTIN_OPT_SPDIF_R);
-    snd_emu10k1_init_stereo_control(&controls[nctl++], SNDRV_CTL_NAME_IEC958("Optical ",PLAYBACK,VOLUME), gpr, 0);
-    gpr += 2;
-    /* Optical SPDIF Capture Volume */
-    A_ADD_VOLUME_IN(capture, gpr, A_EXTIN_OPT_SPDIF_L);
-    A_ADD_VOLUME_IN(capture+1, gpr+1, A_EXTIN_OPT_SPDIF_R);
-    snd_emu10k1_init_stereo_control(&controls[nctl++], SNDRV_CTL_NAME_IEC958("Optical ",CAPTURE,VOLUME), gpr, 0);
-    gpr += 2;
-
     /* Line2 Playback Volume */
     A_ADD_VOLUME_IN(stereo_mix, gpr, A_EXTIN_LINE2_L);
     A_ADD_VOLUME_IN(stereo_mix+1, gpr+1, A_EXTIN_LINE2_R);
@@ -1515,6 +1520,7 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
     snd_emu10k1_init_stereo_onoff_control(controls + nctl++, "Tone Control - Switch", gpr, 0);
     gpr += 2;
 
+    }
     /* Master volume (will be renamed later) */
     A_OP(icode, &ptr, iMAC0, A_GPR(playback+0+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+0+SND_EMU10K1_PLAYBACK_CHANNELS));
     A_OP(icode, &ptr, iMAC0, A_GPR(playback+1+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+1+SND_EMU10K1_PLAYBACK_CHANNELS));

--------------040709000304050609040607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040709000304050609040607--
