From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: How to put 16bit none audio PCM data stream into
 a 32bit none audio S/P-DIF transport stream?
Date: Mon, 14 Apr 2003 01:23:34 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E99F176.6080503@cucumelo.org>
References: <3E93C4CA.4080604@cucumelo.org> <20030409082815.GA14489@ulima.unil.ch> <s5h65poq65j.wl@alsa2.suse.de> <20030409114312.GE14489@ulima.unil.ch> <s5h4r57rf1m.wl@alsa2.suse.de> <3E9553C2.3000100@superbug.demon.co.uk> <20030410112657.GA2332@ulima.unil.ch> <3E994CCE.6020105@cucumelo.org> <20030413170501.GA2323@ulima.unil.ch> <3E99AAAB.1070101@cucumelo.org> <20030413183035.GC2323@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080109030001040702060304"
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
--------------080109030001040702060304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

>
>
>I have done it privately, if someone also want the log, just tell me ;-)
>  
>

Could you repeat the tests with the attached patch applied to current 
CVS. The only changes are some more debug messages.

Just to check, which version of xine ? (I'm using 0.9.18)
"Lord Of the Rings" DTS and Surround 5.1, and "Star Wars II" Surrund 5.1 
works fine forme.

Thanks!

/Benny

--------------080109030001040702060304
Content-Type: text/plain;
 name="cs46xx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs46xx.patch"

diff --exclude=CVS --exclude=Makefile -Nau alsa-kernel/pci/cs46xx/cs46xx_lib.c ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c
--- alsa-kernel/pci/cs46xx/cs46xx_lib.c	Sat Apr  5 21:09:20 2003
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c	Mon Apr 14 01:00:11 2003
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
@@ -2162,9 +2165,9 @@
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
 
@@ -2172,8 +2175,10 @@
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
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c	Mon Apr 14 01:00:47 2003
@@ -265,12 +265,8 @@
 
 	/* set left and right validity bits and
 	   default channel status */
-	ins->spdif_csuv_default = 
-		ins->spdif_csuv_stream =  
-	 /* byte 0 */  (_wrap_all_bits(  (SNDRV_PCM_DEFAULT_CON_SPDIF        & 0xff)) << 24) |
-	 /* byte 1 */  (_wrap_all_bits( ((SNDRV_PCM_DEFAULT_CON_SPDIF >> 16) & 0xff)) << 16) |
-	 /* byte 3 */   _wrap_all_bits(  (SNDRV_PCM_DEFAULT_CON_SPDIF >> 24) & 0xff) |
-	 /* left and right validity bits */ (1 << 13) | (1 << 12);
+	ins->spdif_csuv_default = (SNDRV_PCM_DEFAULT_CON_SPDIF & 0xffff00ff) | 
+	/* left and right validity bits */ (1 << 13) | (1 << 12);
 
 	return ins;
 }
@@ -1655,6 +1651,7 @@
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


--------------080109030001040702060304--



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
