From: Benny Sjostrand <gorm@cucumelo.org>
Subject: experimental [PATCH] cs46xx, yet another try to fix the Santa Cruz
 rear ouput
Date: Sat, 02 Nov 2002 02:09:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DC325E7.7030708@cucumelo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060407040702050707080702"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060407040702050707080702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

 Hi!

This is yet another fustrating try to make the rear output working again 
on the Santa Cruz board.
This biggest change with this patch is that the CODEC's are setup before 
starting and
downloading code to the DSP.
I've been experimenting a little bit accesing the cs4630 FIFO's via the 
backdoor and it seems
like to not success when DSP is running, so starting DSP after enabling 
GPIO7 and GPIO8 on
the secondary CODEC I hope that stuff works.

NOTE: this patch is very experimental and only relevant for Santa Cruz 
users for the moment.

/Benny

--------------060407040702050707080702
Content-Type: text/plain;
 name="cs46xx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs46xx.patch"

diff --exclude=CVS -Naur alsa-kernel/include/cs46xx.h ../cvs/alsa-kernel/include/cs46xx.h
--- alsa-kernel/include/cs46xx.h	Sat Nov  2 00:00:15 2002
+++ ../cvs/alsa-kernel/include/cs46xx.h	Sat Nov  2 00:59:50 2002
@@ -1766,6 +1766,7 @@
 int snd_cs46xx_pcm_iec958(cs46xx_t *chip, int device, snd_pcm_t **rpcm);
 int snd_cs46xx_mixer(cs46xx_t *chip);
 int snd_cs46xx_midi(cs46xx_t *chip, int device, snd_rawmidi_t **rmidi);
+int snd_cs46xx_start_dsp(cs46xx_t *chip);
 void snd_cs46xx_gameport(cs46xx_t *chip);
 
 #ifdef CONFIG_PM
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/cs46xx.c ../cvs/alsa-kernel/pci/cs46xx/cs46xx.c
--- alsa-kernel/pci/cs46xx/cs46xx.c	Sat Nov  2 00:00:21 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx.c	Sat Nov  2 00:59:34 2002
@@ -110,14 +110,14 @@
 		snd_card_free(card);
 		return err;
 	}
-    if ((err = snd_cs46xx_pcm_rear(chip,1, NULL)) < 0) {
-        snd_card_free(card);
-        return err;
-    }
-    if ((err = snd_cs46xx_pcm_iec958(chip,2,NULL)) < 0) {
-        snd_card_free(card);
-        return err;
-    }
+	if ((err = snd_cs46xx_pcm_rear(chip,1, NULL)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+	if ((err = snd_cs46xx_pcm_iec958(chip,2,NULL)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
 	if ((err = snd_cs46xx_mixer(chip)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -126,6 +126,12 @@
 		snd_card_free(card);
 		return err;
 	}
+	if ((err = snd_cs46xx_start_dsp(chip)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
+
 	snd_cs46xx_gameport(chip);
 
 	strcpy(card->driver, "CS46xx");
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/cs46xx_lib.c ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c
--- alsa-kernel/pci/cs46xx/cs46xx_lib.c	Sat Nov  2 00:00:23 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c	Sat Nov  2 01:59:20 2002
@@ -445,13 +445,37 @@
 	snd_cs46xx_poke(chip, BA1_FRMT, 0xadf);
 }
 
+static int cs46xx_long_wait_for_fifo(cs46xx_t * chip) 
+{
+	u32 i, status;
+	/*
+	 * Make sure the previous FIFO write operation has completed.
+	 */
+	for(i = 0; i < 5; i++){
+		status = snd_cs46xx_peekBA0(chip, BA0_SERBST);
+    
+		if( !(status & SERBST_WBSY) )
+			break;
+
+		mdelay(200);
+	}
+  
+	if(status & SERBST_WBSY) {
+		snd_printk( KERN_ERR "cs46xx: failure waiting for FIFO command to complete\n");
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int cs46xx_wait_for_fifo(cs46xx_t * chip) 
 {
 	u32 i, status;
 	/*
 	 * Make sure the previous FIFO write operation has completed.
 	 */
-	for(i = 0; i < 20; i++){
+	for(i = 0; i < 50; i++){
 		status = snd_cs46xx_peekBA0(chip, BA0_SERBST);
     
 		if( !(status & SERBST_WBSY) )
@@ -2785,10 +2809,8 @@
 /*
  *  initialize chip
  */
-
 static int snd_cs46xx_chip_init(cs46xx_t *chip, int busywait)
 {
-	unsigned int tmp;
 	int timeout;
 
 	/* 
@@ -2897,6 +2919,7 @@
 	snd_cs46xx_pokeBA0(chip, BA0_SERC2, SERC2_SI1F_AC97 | SERC1_SO1EN);
 	snd_cs46xx_pokeBA0(chip, BA0_SERMC1, SERMC1_PTC_AC97 | SERMC1_MSPE);
 
+
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	snd_cs46xx_pokeBA0(chip, BA0_SERC7, SERC7_ASDI2EN);
 	snd_cs46xx_pokeBA0(chip, BA0_SERC3, 0);
@@ -2907,6 +2930,7 @@
 
 	mdelay(5);
 
+
 	/*
 	 * Wait for the codec ready signal from the AC97 codec.
 	 */
@@ -2959,6 +2983,7 @@
 	snd_cs46xx_pokeBA0(chip, BA0_ACCTL2, ACCTL_VFRM | ACCTL_ESYN | ACCTL_RSTN);
 #endif
 
+
 	/*
 	 *  Wait until we've sampled input slots 3 and 4 as valid, meaning that
 	 *  the codec is pumping ADC data across the AC-link.
@@ -2987,7 +3012,10 @@
 	 *  Now, assert valid frame and the slot 3 and 4 valid bits.  This will
 	 *  commense the transfer of digital audio data to the AC97 codec.
 	 */
-	snd_cs46xx_pokeBA0(chip, BA0_ACOSV, ACOSV_SLV3 | ACOSV_SLV4 | ACOSV_SLV7 | ACOSV_SLV8);
+
+	snd_cs46xx_pokeBA0(chip, BA0_ACOSV, ACOSV_SLV3 | ACOSV_SLV4 | 
+			   ACOSV_SLV7 | ACOSV_SLV8);
+
 
 	/*
 	 *  Power down the DAC and ADC.  We will power them up (if) when we need
@@ -3002,13 +3030,21 @@
 	/* tmp = snd_cs46xx_peekBA0(chip, BA0_CLKCR1) & ~CLKCR1_SWCE; */
 	/* snd_cs46xx_pokeBA0(chip, BA0_CLKCR1, tmp); */
 
+	return 0;
+}
+
+/*
+ *  start and load DSP 
+ */
+int __devinit snd_cs46xx_start_dsp(cs46xx_t *chip)
+{	
+	unsigned int tmp;
 	/*
-         *  Reset the processor.
-         */
+	 *  Reset the processor.
+	 */
 	snd_cs46xx_reset(chip);
-
 	/*
-         *  Download the image to the processor.
+	 *  Download the image to the processor.
 	 */
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 #if 0
@@ -3040,7 +3076,6 @@
 
 	if (cs46xx_dsp_scb_and_task_init(chip) < 0)
 		return -EIO;
-	snd_printdd("[get here]\n");
 #else
 	/* old image */
 	if (snd_cs46xx_download_image(chip) < 0) {
@@ -3074,7 +3109,7 @@
 	 *  Enable interrupts on the part.
 	 */
 	snd_cs46xx_pokeBA0(chip, BA0_HICR, HICR_IEV | HICR_CHGM);
-
+        
 	tmp = snd_cs46xx_peek(chip, BA1_PFIE);
 	tmp &= ~0x0000f03f;
 	snd_cs46xx_poke(chip, BA1_PFIE, tmp);	/* playback interrupt enable */
@@ -3175,21 +3210,16 @@
 	valid_slots |= 0x200;
 	snd_cs46xx_pokeBA0(chip, BA0_ACOSV, valid_slots);
 
-	valid_slots = snd_cs46xx_peekBA0(chip, BA0_ACOSV2);
-	valid_slots |= 0x200;
-	snd_cs46xx_pokeBA0(chip, BA0_ACOSV2, valid_slots);
+	if ( cs46xx_wait_for_fifo(chip) ) {
+	  snd_printdd("FIFO is busy\n");
+	  
+	  return -EINVAL;
+	}
 
 	/*
 	 * Fill slots 12 with the correct value for the GPIO pins. 
 	 */
 	for(idx = 0x90; idx <= 0x9F; idx++) {
-
-		if ( cs46xx_wait_for_fifo(chip) ) {
-			snd_printdd("failed waiting for FIFO at addr (%02X)\n",idx);
-
-			return -EINVAL;
-		}
-
 		/*
 		 * Initialize the fifo so that bits 7 and 8 are on.
 		 *
@@ -3197,6 +3227,15 @@
 		 * the left.  0x1800 corresponds to bits 7 and 8.
 		 */
 		snd_cs46xx_pokeBA0(chip, BA0_SERBWP, 0x1800);
+
+		/*
+		 * Wait for command to complete
+		 */
+		if ( cs46xx_long_wait_for_fifo(chip) ) {
+			snd_printdd("failed waiting for FIFO at addr (%02X)\n",idx);
+
+			return -EINVAL;
+		}
             
 		/*
 		 * Write the serial port FIFO index.
@@ -3207,10 +3246,6 @@
 		 * Tell the serial port to load the new value into the FIFO location.
 		 */
 		snd_cs46xx_pokeBA0(chip, BA0_SERBCM, SERBCM_WRC);
-
-		/*
-		 * Wait for command to complete
-		 */
 	}
 
 	/* wait for last command to complete */

--------------060407040702050707080702--



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
