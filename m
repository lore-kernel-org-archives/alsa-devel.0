From: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Subject: cs46xx patch for XFire 4channel output not in cvs?
Date: Sat, 10 May 2003 20:16:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EBD41E5.6040102@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080900080404020009020308"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080900080404020009020308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

as I looked into the current cvs, I noticed that the patch enabling 
4channel output for the Terratec DMX XFire didn't make it into the 
source tree.
I attached once again Benny's patch from 5th or 6th of april, with one 
minor change:
I changed the value 0x5d2d to 0x592d as Benny asked me to when I tested 
the patch.

The attached patch applies without problems to cvs snapshot from 6th of may.

thanks,
  fe



--------------080900080404020009020308
Content-Type: text/plain;
 name="cs46xx_lib.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs46xx_lib.patch"

--- alsa-kernel/pci/cs46xx/cs46xx_lib.c	Sat Apr  5 21:09:20 2003
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c	Sat Apr  5 21:22:58 2003
@@ -2543,13 +2543,21 @@
 	chip->eapd_switch = snd_ctl_find_id(chip->card, &id);
     
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
+	if (chip->nr_ac97_codecs == 1 && 
+	   snd_cs46xx_codec_read(chip,AC97_VENDOR_ID2,
+				 CS46XX_PRIMARY_CODEC_INDEX) == 0x592d) {
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
     

--------------080900080404020009020308--



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
