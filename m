From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: How to put 16bit none audio PCM data stream into
 a 32bit none audio S/P-DIF transport stream?
Date: Sun, 13 Apr 2003 13:41:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E994CCE.6020105@cucumelo.org>
References: <s5hn0j1q97r.wl@alsa2.suse.de> <3E934193.6090605@cucumelo.org> <20030408205515.GB6940@ulima.unil.ch> <3E933EF6.5030601@superbug.demon.co.uk> <3E93C4CA.4080604@cucumelo.org> <20030409082815.GA14489@ulima.unil.ch> <s5h65poq65j.wl@alsa2.suse.de> <20030409114312.GE14489@ulima.unil.ch> <s5h4r57rf1m.wl@alsa2.suse.de> <3E9553C2.3000100@superbug.demon.co.uk> <20030410112657.GA2332@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020407090408030901070207"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020407090408030901070207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

>
>
>Yes (well, I have an indicator of Dolby Digital).
>
>  
>
>>So, in linux, when playing a DVD in PASSTHRU mode in xine, does your 
>>decoder think it is AC3 or PCM ?
>>    
>>
>
>PCM...
>
>  
>
>>If the decoder still thinks it is PCM, then the problem is a bug in the 
>>alsa-driver, and not the application or sample rate.
>>    
>>
>
>I think it's something I have tried to explain here ;-)
>
>  
>
Well,  something must be wrong with the cs46xx driver. It's hard to know 
what when it's works fine with my receiver. A explication to that could 
be that my receiver ignores the IEC958 status bits and detects the AC3 
from signatures on the stream.

Gregoire:
Please dont give up yet, could you test the atached patch to current CVS.
Then test out different values on the 
"AES0=0x0,AES1=0x82,AES2=0x0,AES3=0x2" parameters like:
"AES0=0x2,AES1=0x0,AES2=0x82,AES3=0x0",
"AES0=0xFF,AES1=0xFF,AES2=0xFF,AES3=0xFF",
"AES0=0x00,AES1=0x00,AES2=0x00,AES3=0x00"  (and any other
values that cames into your mind ... )


/Benny

--------------020407090408030901070207
Content-Type: text/plain;
 name="cs46xx_spdif.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs46xx_spdif.patch"

diff --exclude=CVS --exclude=Makefile -Nau alsa-kernel/pci/cs46xx/cs46xx_lib.c ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c
--- alsa-kernel/pci/cs46xx/cs46xx_lib.c	Sat Apr  5 21:09:20 2003
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c	Sun Apr 13 12:41:54 2003
@@ -2091,10 +2091,10 @@
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
 
 	down (&chip->spos_mutex);
-	ucontrol->value.iec958.status[0] = _wrap_all_bits((ins->spdif_csuv_default >> 24) & 0xff);
-	ucontrol->value.iec958.status[1] = _wrap_all_bits((ins->spdif_csuv_default >> 16) & 0xff);
-	ucontrol->value.iec958.status[2] = 0;
-	ucontrol->value.iec958.status[3] = _wrap_all_bits((ins->spdif_csuv_default) & 0xff);
+	ucontrol->value.iec958.status[0] =  ins->spdif_csuv_default        & 0xff;
+	ucontrol->value.iec958.status[1] = 0;
+	ucontrol->value.iec958.status[2] = (ins->spdif_csuv_default >> 16) & 0xff;
+	ucontrol->value.iec958.status[3] = (ins->spdif_csuv_default >> 24) & 0xff;
 	up (&chip->spos_mutex);
 
 	return 0;
@@ -2109,9 +2109,9 @@
 	int change;
 
 	down (&chip->spos_mutex);
-	val = _wrap_all_bits(((u32)ucontrol->value.iec958.status[0] << 24)) |
-	      _wrap_all_bits(((u32)ucontrol->value.iec958.status[2] << 16)) |
-	      _wrap_all_bits( (u32)ucontrol->value.iec958.status[3])  |
+	val =  (u32)ucontrol->value.iec958.status[0]        |
+	      ((u32)ucontrol->value.iec958.status[2] << 16) |
+	      ((u32)ucontrol->value.iec958.status[3] << 24) |
 		/* left and right validity bit */
 		(1 << 13) | (1 << 12);
 
@@ -2131,8 +2131,8 @@
 				     snd_ctl_elem_value_t * ucontrol)
 {
 	ucontrol->value.iec958.status[0] = 0xff;
-	ucontrol->value.iec958.status[1] = 0xff;
-	ucontrol->value.iec958.status[2] = 0x00;
+	ucontrol->value.iec958.status[1] = 0x00;
+	ucontrol->value.iec958.status[2] = 0xff;
 	ucontrol->value.iec958.status[3] = 0xff;
 	return 0;
 }
@@ -2144,10 +2144,10 @@
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
 
 	down (&chip->spos_mutex);
-	ucontrol->value.iec958.status[0] = _wrap_all_bits((ins->spdif_csuv_stream >> 24) & 0xff);
-	ucontrol->value.iec958.status[1] = _wrap_all_bits((ins->spdif_csuv_stream >> 16) & 0xff);
-	ucontrol->value.iec958.status[2] = 0;
-	ucontrol->value.iec958.status[3] = _wrap_all_bits((ins->spdif_csuv_stream) & 0xff);
+	ucontrol->value.iec958.status[0] =  ins->spdif_csuv_stream        & 0xff;
+	ucontrol->value.iec958.status[1] = 0;
+	ucontrol->value.iec958.status[2] = (ins->spdif_csuv_stream >> 16) & 0xff;
+	ucontrol->value.iec958.status[3] = (ins->spdif_csuv_stream >> 24) & 0xff;
 	up (&chip->spos_mutex);
 
 	return 0;
@@ -2162,9 +2162,9 @@
 	int change;
 
 	down (&chip->spos_mutex);
-	val = _wrap_all_bits(((u32)ucontrol->value.iec958.status[0] << 24)) |
-	      _wrap_all_bits(((u32)ucontrol->value.iec958.status[1] << 16)) |
-	      _wrap_all_bits( (u32)ucontrol->value.iec958.status[3]) |
+	val =  (u32)ucontrol->value.iec958.status[0]        |
+	      ((u32)ucontrol->value.iec958.status[2] << 16) |
+	      ((u32)ucontrol->value.iec958.status[3] << 24) |
 		/* left and right validity bit */
 		(1 << 13) | (1 << 12);
 
@@ -2543,13 +2543,21 @@
 	chip->eapd_switch = snd_ctl_find_id(chip->card, &id);
     
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
+	if (chip->nr_ac97_codecs == 1 && 
+	   snd_cs46xx_codec_read(chip,AC97_VENDOR_ID2,
+				 CS46XX_PRIMARY_CODEC_INDEX) == 0x5d2d) {
+		/* set primary cs4294 codec into Extended Audio Mode */
+		snd_printdd("setting EAM bit on cs4294 CODEC\n");
+		snd_cs46xx_codec_write(chip,AC97_CSR_ACMODE,0x200,
+				       CS46XX_PRIMARY_CODEC_INDEX);
+	}
 	/* do soundcard specific mixer setup */
 	if (chip->mixer_init) {
 		snd_printdd ("calling chip->mixer_init(chip);\n");
 		chip->mixer_init(chip);
 	}
 #endif
-
+	
  	/* turn on amplifier */
 	chip->amplifier_ctrl(chip, 1);
     
diff --exclude=CVS --exclude=Makefile -Nau alsa-kernel/pci/cs46xx/dsp_spos.c ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c
--- alsa-kernel/pci/cs46xx/dsp_spos.c	Sat Apr  5 21:09:20 2003
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c	Sun Apr 13 12:33:05 2003
@@ -265,12 +265,8 @@
 
 	/* set left and right validity bits and
 	   default channel status */
-	ins->spdif_csuv_default = 
-		ins->spdif_csuv_stream =  
-	 /* byte 0 */  (_wrap_all_bits(  (SNDRV_PCM_DEFAULT_CON_SPDIF        & 0xff)) << 24) |
-	 /* byte 1 */  (_wrap_all_bits( ((SNDRV_PCM_DEFAULT_CON_SPDIF >> 16) & 0xff)) << 16) |
-	 /* byte 3 */   _wrap_all_bits(  (SNDRV_PCM_DEFAULT_CON_SPDIF >> 24) & 0xff) |
-	 /* left and right validity bits */ (1 << 13) | (1 << 12);
+	ins->spdif_csuv_default = (SNDRV_PCM_DEFAULT_CON_SPDIF & 0xff00ffff) | 
+	/* left and right validity bits */ (1 << 13) | (1 << 12);
 
 	return ins;
 }
diff --exclude=CVS --exclude=Makefile -Nau alsa-kernel/pci/cs46xx/dsp_spos.h ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.h
--- alsa-kernel/pci/cs46xx/dsp_spos.h	Sat Apr  5 21:09:20 2003
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.h	Sun Apr 13 12:43:20 2003
@@ -186,25 +186,6 @@
 #define SP_SPDOUT_CONTROL 0x804D
 #define SP_SPDOUT_CSUV    0x808E
 
-static inline u8 _wrap_all_bits (u8 val) {
-	u8 wrapped;
-	
-	/* wrap all 8 bits */
-	wrapped = 
-		((val & 0x1 ) << 7) |
-		((val & 0x2 ) << 5) |
-		((val & 0x4 ) << 3) |
-		((val & 0x8 ) << 1) |
-		((val & 0x10) >> 1) |
-		((val & 0x20) >> 3) |
-		((val & 0x40) >> 5) |
-		((val & 0x80) >> 7);
-
-	return wrapped;
-
-}
-
-
 static inline void cs46xx_dsp_spos_update_scb (cs46xx_t * chip,dsp_scb_descriptor_t * scb) 
 {
 	/* update nextSCB and subListPtr in SCB */

--------------020407090408030901070207--



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
