From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: How to put 16bit none audio PCM data stream into
 a 32bit none audio S/P-DIF transport stream?
Date: Tue, 15 Apr 2003 01:00:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E9B3D9B.2060901@cucumelo.org>
References: <s5h4r57rf1m.wl@alsa2.suse.de> <3E9553C2.3000100@superbug.demon.co.uk> <20030410112657.GA2332@ulima.unil.ch> <3E994CCE.6020105@cucumelo.org> <20030413170501.GA2323@ulima.unil.ch> <3E99AAAB.1070101@cucumelo.org> <20030413183035.GC2323@ulima.unil.ch> <3E99F176.6080503@cucumelo.org> <20030414190615.GA22184@ulima.unil.ch> <3E9B341E.4040200@cucumelo.org> <20030414212708.GB22184@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080809090108000703010304"
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
Cc: alsa-devel@lists.sourceforge.net, James@superbug.demon.co.uk
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080809090108000703010304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

>
>
>It's a value I could find, is that good?
>  
>
It's what I expected ...

>I have tried xine with the same iec958:AES0=0x2,AES1=0x0,AES2=0x82,AES3=0x2
>value:
>  
>
Let me guess, I did not work ? Well, guess what, I got new "this time 
hopefully working" patch,
so if you like to apply it to CVS and test again -;)

Could you also test with:
AES0=0x40,AES1=0x0,AES2=0x41,AES3=0x40 (all bits wrapped)

Then I got a question about the IEC958 protocoll that hopefulle someone 
on this list
knows something about. The Left and Right validity bits, and Left, Right 
user
bits, what are suposed to do ?? are they suposed to be 1 or 0 when outputing
AC3/DTS ???

That could be a posible source of the problem, in this patch they are
all turned off.

/Benny

--------------080809090108000703010304
Content-Type: text/plain;
 name="cs46xx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs46xx.patch"

diff --exclude=CVS --exclude=Makefile -Nau alsa-kernel/pci/cs46xx/cs46xx_lib.c ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c
--- alsa-kernel/pci/cs46xx/cs46xx_lib.c	Sat Apr  5 21:09:20 2003
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c	Tue Apr 15 00:51:31 2003
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
+	      ((u32)ucontrol->value.iec958.status[1] << 16) |
+	      ((u32)ucontrol->value.iec958.status[2] << 24) |
 		/* left and right validity bit */
 		(1 << 13) | (1 << 12);
 
@@ -2119,8 +2119,11 @@
 	change = (unsigned int)ins->spdif_csuv_default != val;
 	ins->spdif_csuv_default = val;
 
-	if ( !(ins->spdif_status_out & DSP_SPDIF_STATUS_PLAYBACK_OPEN) )
+	
+	if ( !(ins->spdif_status_out & DSP_SPDIF_STATUS_PLAYBACK_OPEN) ) {
+		snd_printdd ("setting SP_SPDOUT_CSUV register (%08x)\n",val);
 		cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV,val);
+	}
 
 	up (&chip->spos_mutex);
 
@@ -2131,8 +2134,8 @@
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
@@ -2144,10 +2147,10 @@
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
@@ -2162,18 +2165,20 @@
 	int change;
 
 	down (&chip->spos_mutex);
-	val = _wrap_all_bits(((u32)ucontrol->value.iec958.status[0] << 24)) |
-	      _wrap_all_bits(((u32)ucontrol->value.iec958.status[1] << 16)) |
-	      _wrap_all_bits( (u32)ucontrol->value.iec958.status[3]) |
+	val =  (u32)ucontrol->value.iec958.status[0]        |
+	      ((u32)ucontrol->value.iec958.status[2] << 16) |
+	      ((u32)ucontrol->value.iec958.status[3] << 24);
 		/* left and right validity bit */
-		(1 << 13) | (1 << 12);
+	        /* (1 << 13) | (1 << 12); */
 
 
 	change = ins->spdif_csuv_stream != val;
 	ins->spdif_csuv_stream = val;
 
-	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_PLAYBACK_OPEN )
+	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_PLAYBACK_OPEN ) {
+		snd_printdd ("setting SP_SPDOUT_CSUV register (%08x)\n",val);
 		cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV,val);
+	}
 
 	up (&chip->spos_mutex);
 
@@ -2543,13 +2548,21 @@
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
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c	Tue Apr 15 00:14:36 2003
@@ -265,13 +265,10 @@
 
 	/* set left and right validity bits and
 	   default channel status */
-	ins->spdif_csuv_default = 
-		ins->spdif_csuv_stream =  
-	 /* byte 0 */  (_wrap_all_bits(  (SNDRV_PCM_DEFAULT_CON_SPDIF        & 0xff)) << 24) |
-	 /* byte 1 */  (_wrap_all_bits( ((SNDRV_PCM_DEFAULT_CON_SPDIF >> 16) & 0xff)) << 16) |
-	 /* byte 3 */   _wrap_all_bits(  (SNDRV_PCM_DEFAULT_CON_SPDIF >> 24) & 0xff) |
-	 /* left and right validity bits */ (1 << 13) | (1 << 12);
-
+	ins->spdif_csuv_default = (SNDRV_PCM_DEFAULT_CON_SPDIF & 0xffff00ff) | 
+		/* left and right validity bits */ (1 << 13) | (1 << 12);
+	ins->spdif_csuv_stream =  (SNDRV_PCM_DEFAULT_CON_SPDIF & 0xffff00ff) | 
+		/* left and right validity bits */ (1 << 13) | (1 << 12);
 	return ins;
 }
 
@@ -1655,6 +1652,7 @@
 	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CONTROL, 0x80000000);
 
 	/* right and left validate bit */
+	snd_printdd ("setting SP_SPDOUT_CSUV register to default (%08x)\n",ins->spdif_csuv_default);
 	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, ins->spdif_csuv_default);
 
 	/* monitor state */
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
diff --exclude=CVS --exclude=Makefile -Nau alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c ../cvs/alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c
--- alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c	Sat Apr  5 21:09:20 2003
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c	Mon Apr 14 01:01:30 2003
@@ -1701,6 +1701,7 @@
 
 
 	/* set spdif channel status value for streaming */
+	snd_printdd ("setting SP_SPDOUT_CSUV register to stream (%08x)\n",ins->spdif_csuv_stream);
 	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, ins->spdif_csuv_stream);
 
 	ins->spdif_status_out  |= DSP_SPDIF_STATUS_PLAYBACK_OPEN;
@@ -1717,6 +1718,7 @@
 	ins->spdif_status_out  &= ~DSP_SPDIF_STATUS_PLAYBACK_OPEN;
 
 	/* restore settings */
+	snd_printdd ("setting SP_SPDOUT_CSUV register to default (%08x)\n",ins->spdif_csuv_default);
 	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, ins->spdif_csuv_default);
 	
 	/* deallocate stuff */


--------------080809090108000703010304--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
