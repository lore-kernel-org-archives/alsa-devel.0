From: Benny Sjostrand <gorm@cucumelo.org>
Subject: [PATCH] Turn on GPIO7/8 on the TB Santa Cruz card
Date: Fri, 02 Aug 2002 21:45:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D4AE13E.9010807@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cucumelo.org (as1-4-7.bn.g.bonet.se [194.236.61.89])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA09304
	for <alsa-devel@alsa-project.org>; Fri, 2 Aug 2002 22:35:15 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org, peter599@gotnet.net
List-Id: alsa-devel@alsa-project.org

This is what I believe is left to make the secondary CODEC work on the 
Santa Cruz,
but I got no way to test it.

Peter: can you please test it and tell me about the results

Here is the patch against CVS, basically just the same code from the 
Cirrus work
adapted to ALSA.

diff -Naur ../cvs_ref/alsa-kernel/include/cs46xx.h 
alsa-kernel/include/cs46xx.h
--- ../cvs_ref/alsa-kernel/include/cs46xx.h    Thu Aug  1 14:29:31 2002
+++ alsa-kernel/include/cs46xx.h    Fri Aug  2 21:38:37 2002
@@ -195,6 +195,81 @@
 #define BA1_FRSC                                0x00030038
 #define BA1_OMNI_MEM                            0x000E0000
 
+
+
+
+/*
+ * The following define the offsets of the AC97 shadow registers, which 
appear
+ * as a virtual extension to the base address register zero memory range.
+ */
+#define AC97_REG_OFFSET_MASK                    0x0000007EL
+#define AC97_CODEC_NUMBER_MASK                  0x00003000L
+
+#define BA0_AC97_RESET                          0x00001000L
+#define BA0_AC97_MASTER_VOLUME                  0x00001002L
+#define BA0_AC97_HEADPHONE_VOLUME               0x00001004L
+#define BA0_AC97_MASTER_VOLUME_MONO             0x00001006L
+#define BA0_AC97_MASTER_TONE                    0x00001008L
+#define BA0_AC97_PC_BEEP_VOLUME                 0x0000100AL
+#define BA0_AC97_PHONE_VOLUME                   0x0000100CL
+#define BA0_AC97_MIC_VOLUME                     0x0000100EL
+#define BA0_AC97_LINE_IN_VOLUME                 0x00001010L
+#define BA0_AC97_CD_VOLUME                      0x00001012L
+#define BA0_AC97_VIDEO_VOLUME                   0x00001014L
+#define BA0_AC97_AUX_VOLUME                     0x00001016L
+#define BA0_AC97_PCM_OUT_VOLUME                 0x00001018L
+#define BA0_AC97_RECORD_SELECT                  0x0000101AL
+#define BA0_AC97_RECORD_GAIN                    0x0000101CL
+#define BA0_AC97_RECORD_GAIN_MIC                0x0000101EL
+#define BA0_AC97_GENERAL_PURPOSE                0x00001020L
+#define BA0_AC97_3D_CONTROL                     0x00001022L
+#define BA0_AC97_MODEM_RATE                     0x00001024L
+#define BA0_AC97_POWERDOWN                      0x00001026L
+#define BA0_AC97_EXT_AUDIO_ID                   0x00001028L
+#define BA0_AC97_EXT_AUDIO_POWER                0x0000102AL
+#define BA0_AC97_PCM_FRONT_DAC_RATE             0x0000102CL
+#define BA0_AC97_PCM_SURR_DAC_RATE              0x0000102EL
+#define BA0_AC97_PCM_LFE_DAC_RATE               0x00001030L
+#define BA0_AC97_PCM_LR_ADC_RATE                0x00001032L
+#define BA0_AC97_MIC_ADC_RATE                   0x00001034L
+#define BA0_AC97_6CH_VOL_C_LFE                  0x00001036L
+#define BA0_AC97_6CH_VOL_SURROUND               0x00001038L
+#define BA0_AC97_RESERVED_3A                    0x0000103AL
+#define BA0_AC97_EXT_MODEM_ID                   0x0000103CL
+#define BA0_AC97_EXT_MODEM_POWER                0x0000103EL
+#define BA0_AC97_LINE1_CODEC_RATE               0x00001040L
+#define BA0_AC97_LINE2_CODEC_RATE               0x00001042L
+#define BA0_AC97_HANDSET_CODEC_RATE             0x00001044L
+#define BA0_AC97_LINE1_CODEC_LEVEL              0x00001046L
+#define BA0_AC97_LINE2_CODEC_LEVEL              0x00001048L
+#define BA0_AC97_HANDSET_CODEC_LEVEL            0x0000104AL
+#define BA0_AC97_GPIO_PIN_CONFIG                0x0000104CL
+#define BA0_AC97_GPIO_PIN_TYPE                  0x0000104EL
+#define BA0_AC97_GPIO_PIN_STICKY                0x00001050L
+#define BA0_AC97_GPIO_PIN_WAKEUP                0x00001052L
+#define BA0_AC97_GPIO_PIN_STATUS                0x00001054L
+#define BA0_AC97_MISC_MODEM_AFE_STAT            0x00001056L
+#define BA0_AC97_RESERVED_58                    0x00001058L
+#define BA0_AC97_CRYSTAL_REV_N_FAB_ID           0x0000105AL
+#define BA0_AC97_TEST_AND_MISC_CTRL             0x0000105CL
+#define BA0_AC97_AC_MODE                        0x0000105EL
+#define BA0_AC97_MISC_CRYSTAL_CONTROL           0x00001060L
+#define BA0_AC97_LINE1_HYPRID_CTRL              0x00001062L
+#define BA0_AC97_VENDOR_RESERVED_64             0x00001064L
+#define BA0_AC97_VENDOR_RESERVED_66             0x00001066L
+#define BA0_AC97_SPDIF_CONTROL                  0x00001068L
+#define BA0_AC97_VENDOR_RESERVED_6A             0x0000106AL
+#define BA0_AC97_VENDOR_RESERVED_6C             0x0000106CL
+#define BA0_AC97_VENDOR_RESERVED_6E             0x0000106EL
+#define BA0_AC97_VENDOR_RESERVED_70             0x00001070L
+#define BA0_AC97_VENDOR_RESERVED_72             0x00001072L
+#define BA0_AC97_VENDOR_RESERVED_74             0x00001074L
+#define BA0_AC97_CAL_ADDRESS                    0x00001076L
+#define BA0_AC97_CAL_DATA                       0x00001078L
+#define BA0_AC97_VENDOR_RESERVED_7A             0x0000107AL
+#define BA0_AC97_VENDOR_ID1                     0x0000107CL
+#define BA0_AC97_VENDOR_ID2                     0x0000107EL
+
 /*
  *  The following defines are for the flags in the host interrupt status
  *  register.
diff -Naur ../cvs_ref/alsa-kernel/pci/cs46xx/Makefile 
alsa-kernel/pci/cs46xx/Makefile
--- ../cvs_ref/alsa-kernel/pci/cs46xx/Makefile    Thu Aug  1 11:26:32 2002
+++ alsa-kernel/pci/cs46xx/Makefile    Fri Aug  2 00:10:52 2002
@@ -4,9 +4,9 @@
 #
 
 snd-cs46xx-objs := cs46xx.o cs46xx_lib.o
-ifeq ($(CONFIG_SND_CS46XX_NEW_DSP),y)
+#ifeq ($(CONFIG_SND_CS46XX_NEW_DSP),y)
   snd-cs46xx-objs += dsp_spos.o dsp_spos_scb_lib.o
-endif
+#endif
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_CS46XX) += snd-cs46xx.o
diff -Naur ../cvs_ref/alsa-kernel/pci/cs46xx/cs46xx_lib.c 
alsa-kernel/pci/cs46xx/cs46xx_lib.c
--- ../cvs_ref/alsa-kernel/pci/cs46xx/cs46xx_lib.c    Thu Aug  1 
14:30:52 2002
+++ alsa-kernel/pci/cs46xx/cs46xx_lib.c    Fri Aug  2 21:29:08 2002
@@ -8,11 +8,11 @@
  *    --
  *
  *  TODO:
- *    We need a DSP code to support multichannel outputs and S/PDIF.
- *    Unfortunately, it seems that Cirrus Logic, Inc. is not willing
- *    to provide us sufficient information about the DSP processor,
- *    so we can't update the driver.
+ *    SPDIF input.
+ *    Secondary CODEC on some soundcards
  *
+ *  NOTE: with CONFIG_SND_CS46XX_NEW_DSP unset uses old DSP image 
(which is default
+ *   configuration), no SPDIF, no secondary codec, no multi channel 
PCM. But known to work.
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -334,7 +334,6 @@
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 
-// #include "imgs/cwcemb80.h"
 #include "imgs/cwc4630.h"
 #include "imgs/cwcasync.h"
 #include "imgs/cwcsnoop.h"
@@ -880,8 +879,6 @@
     switch (cmd) {
     case SNDRV_PCM_TRIGGER_START:
     case SNDRV_PCM_TRIGGER_RESUME:
-        if (substream->runtime->periods != CS46XX_FRAGS)
-            snd_cs46xx_playback_transfer(substream, 0);
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
         if (cpcm->pcm_channel->unlinked)
             cs46xx_dsp_pcm_link(chip,cpcm->pcm_channel);
@@ -892,6 +889,8 @@
         snd_cs46xx_poke(chip, BA1_PCTL, chip->play_ctl | tmp);
         }
 #endif
+        if (substream->runtime->periods != CS46XX_FRAGS)
+           snd_cs46xx_playback_transfer(substream, 0);
         break;
     case SNDRV_PCM_TRIGGER_STOP:
     case SNDRV_PCM_TRIGGER_SUSPEND:
@@ -2447,6 +2446,106 @@
 {   
 }
 
+
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
+static int voyetra_setup_eapd_slot(cs46xx_t *chip)
+{
+    int i;
+    u32 idx;
+    u16 modem_power,pin_config,logic_type,valid_slots,status;
+
+    snd_printd ("cs46xx: cs46xx_setup_eapd_slot()+\n");
+    /*
+    * Clear PRA.  The Bonzo chip will be used for GPIO not for modem
+    * stuff.
+    */
+    if(chip->nr_ac97_codecs != 2)
+    {
+      snd_printk (KERN_ERR "cs46xx: cs46xx_setup_eapd_slot() - no 
secondary codec configured\n");
+      return -EINVAL;
+    }
+
+    modem_power = snd_cs46xx_codec_read (chip,
+                                         BA0_AC97_EXT_MODEM_POWER,
+                                         CS46XX_SECONDARY_CODEC_INDEX);
+    modem_power &=0xFEFF;
+
+    snd_cs46xx_codec_write(chip,
+                           BA0_AC97_EXT_MODEM_POWER, modem_power,
+                           CS46XX_SECONDARY_CODEC_INDEX);
+
+    /*
+     * Set GPIO pin's 7 and 8 so that they are configured for output.
+     */
+    pin_config = snd_cs46xx_codec_read (chip,
+                                        BA0_AC97_GPIO_PIN_CONFIG,
+                                        CS46XX_SECONDARY_CODEC_INDEX);
+    pin_config &=0x27F;
+
+    snd_cs46xx_codec_write(chip,
+                           BA0_AC97_GPIO_PIN_CONFIG, pin_config,
+                           CS46XX_SECONDARY_CODEC_INDEX);
+   
+    /*
+     * Set GPIO pin's 7 and 8 so that they are compatible with CMOS logic.
+     */
+
+    logic_type = snd_cs46xx_codec_read(chip, BA0_AC97_GPIO_PIN_TYPE,
+                                       CS46XX_SECONDARY_CODEC_INDEX);
+    logic_type &=0x27F;
+    snd_cs46xx_codec_write (chip, BA0_AC97_GPIO_PIN_TYPE, logic_type,
+                            CS46XX_SECONDARY_CODEC_INDEX);
+
+    valid_slots = snd_cs46xx_peekBA0(chip, BA0_ACOSV);
+    valid_slots |= 0x200;
+    snd_cs46xx_pokeBA0(chip, BA0_ACOSV, valid_slots);
+
+    /*
+     * Fill slots 12 with the correct value for the GPIO pins.
+     */
+    for(idx = 0x90; idx <= 0x9F; idx++) {
+
+      /*
+       * Initialize the fifo so that bits 7 and 8 are on.
+       *
+       * Remember that the GPIO pins in bonzo are shifted by 4 bits to
+       * the left.  0x1800 corresponds to bits 7 and 8.
+       */
+      snd_cs46xx_pokeBA0(chip, BA0_SERBWP, 0x1800);
+     
+      /*
+       * Make sure the previous FIFO write operation has completed.
+       */
+      for(i = 0; i < 5; i++){
+        status = snd_cs46xx_peekBA0(chip, BA0_SERBST);
+
+        if( !(status & SERBST_WBSY) ) {
+          break;
+        }
+        mdelay(100);
+      }
+
+      if(status & SERBST_WBSY) {
+        snd_printk( KERN_ERR "cs46xx: cs46xx_setup_eapd_slot() " \
+                             "Failure to write the GPIO pins for slot 
12.\n");
+         return -EINVAL;
+      }
+     
+      /*
+       * Write the serial port FIFO index.
+       */
+      snd_cs46xx_pokeBA0(chip, BA0_SERBAD, idx);
+     
+      /*
+       * Tell the serial port to load the new value into the FIFO location.
+       */
+      snd_cs46xx_pokeBA0(chip, BA0_SERBCM, SERBCM_WRC);
+    }
+
+    return 0;
+}
+#endif
+
 /*
  *    Crystal EAPD mode
  */
@@ -2477,6 +2576,12 @@
             snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
                        &chip->eapd_switch->id);
     }
+
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
+    if (chip->amplifier && !old) {
+      voyetra_setup_eapd_slot(chip);
+    }
+#endif
 }
 
 
diff -Naur ../cvs_ref/alsa-kernel/pci/cs46xx/dsp_spos.c 
alsa-kernel/pci/cs46xx/dsp_spos.c
--- ../cvs_ref/alsa-kernel/pci/cs46xx/dsp_spos.c    Thu Aug  1 14:30:53 2002
+++ alsa-kernel/pci/cs46xx/dsp_spos.c    Fri Aug  2 00:09:15 2002
@@ -766,18 +766,6 @@
     snd_iprintf(buffer,"\n");
 }
 
-#if 0
-static void snd_ac97_proc_regs_read_main(ac97_t *ac97, 
snd_info_buffer_t * buffer, int subidx)
-{
-    int reg, val;
-
-    for (reg = 0; reg < 0x80; reg += 2) {
-        val = snd_ac97_read(ac97, reg);
-        snd_iprintf(buffer, "%i:%02x = %04x\n", subidx, reg, val);
-    }
-}
-#endif
-
 int cs46xx_dsp_proc_init (snd_card_t * card, cs46xx_t *chip)
 {
     snd_info_entry_t *entry;





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
