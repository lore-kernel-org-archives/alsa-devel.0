From: Ctirad Fertr <c.fertr@volny.cz>
Subject: e-mu 1212m and 1820(m) patch
Date: Fri, 11 May 2007 23:54:15 +0200
Message-ID: <200705112354.15848.c.fertr@volny.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HYORGYV2Cfp4pxE"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.vol.cz (smtp1.vol.cz [195.250.128.78])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D2AF244DB
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 23:54:23 +0200 (CEST)
Received: from [10.16.3.4] (dsl-tn-6-43.static.adsl.vol.cz [83.148.7.43])
	by smtp1.vol.cz (Postfix) with ESMTP id 71294407DC
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 23:54:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_HYORGYV2Cfp4pxE
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

here is a little patch which enables ADAT and S/PDIF functionality. It adds 
possibility to sync  with either S/PDIF or ADAT clock as well.  44.1/48kHz 
only, though it  works pretty well for me. 

Regards,

Ctirad

--Boundary-00=_HYORGYV2Cfp4pxE
Content-Type: text/x-diff;
  charset="us-ascii";
  name="adat-ext_sync.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="adat-ext_sync.diff"

diff -ruN a/pci/emu10k1/emumixer.c b/pci/emu10k1/emumixer.c
--- a/pci/emu10k1/emumixer.c	2007-05-11 19:47:09.000000000 +0200
+++ b/pci/emu10k1/emumixer.c	2007-05-11 19:22:49.000000000 +0200
@@ -500,17 +500,19 @@
 static int snd_emu1010_internal_clock_info(struct snd_kcontrol *kcontrol,
 					  struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[2] = {
-		"44100", "48000"
+	static char *texts[4] = {
+		"44100", "48000", "SPDIF", "ADAT"
 	};
-
+		
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item > 1)
-                uinfo->value.enumerated.item = 1;
+	uinfo->value.enumerated.items = 4;
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
 	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
 	return 0;
+	
+	
 }
 
 static int snd_emu1010_internal_clock_get(struct snd_kcontrol *kcontrol,
@@ -568,6 +570,44 @@
 			/* Unmute all */
 			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE );
 			break;
+			
+		case 2: /* Take clock from S/PDIF IN */
+			/* Mute all */
+			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_MUTE );
+			/* Default fallback clock 48kHz */
+			snd_emu1010_fpga_write(emu, EMU_HANA_DEFCLOCK, EMU_HANA_DEFCLOCK_48K );
+			/* Word Clock source, sync to S/PDIF input */
+			snd_emu1010_fpga_write(emu, EMU_HANA_WCLOCK,
+				EMU_HANA_WCLOCK_HANA_SPDIF_IN | EMU_HANA_WCLOCK_1X );
+			/* Set LEDs on Audio Dock */
+			snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_LEDS_2,
+				EMU_HANA_DOCK_LEDS_2_EXT | EMU_HANA_DOCK_LEDS_2_LOCK );
+			/* FIXME: We should set EMU_HANA_DOCK_LEDS_2_LOCK only when clock signal is present and valid */	
+			/* Allow DLL to settle */
+			msleep(10);
+			/* Unmute all */
+			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE );
+			break;
+		
+		case 3: 			
+			/* Take clock from ADAT IN */
+			/* Mute all */
+			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_MUTE );
+			/* Default fallback clock 48kHz */
+			snd_emu1010_fpga_write(emu, EMU_HANA_DEFCLOCK, EMU_HANA_DEFCLOCK_48K );
+			/* Word Clock source, sync to ADAT input */
+			snd_emu1010_fpga_write(emu, EMU_HANA_WCLOCK,
+				EMU_HANA_WCLOCK_HANA_ADAT_IN | EMU_HANA_WCLOCK_1X );
+			/* Set LEDs on Audio Dock */
+			snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_LEDS_2, EMU_HANA_DOCK_LEDS_2_EXT | EMU_HANA_DOCK_LEDS_2_LOCK );
+			/* FIXME: We should set EMU_HANA_DOCK_LEDS_2_LOCK only when clock signal is present and valid */	
+			/* Allow DLL to settle */
+			msleep(10);
+			/*   Unmute all */
+			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE );
+			 
+			
+			break;		
 		}
 	}
         return change;
diff -ruN a/pci/emu10k1/emu10k1_main.c b/pci/emu10k1/emu10k1_main.c
--- a/pci/emu10k1/emu10k1_main.c	2007-05-11 19:47:09.000000000 +0200
+++ b/pci/emu10k1/emu10k1_main.c	2007-05-10 21:25:57.000000000 +0200
@@ -765,8 +765,8 @@
 	snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg );
 	snd_printk(KERN_INFO "emu1010: Card options=0x%x\n",reg);
 	snd_emu1010_fpga_read(emu, EMU_HANA_OPTICAL_TYPE, &tmp ); 
-	/* ADAT input. */
-	snd_emu1010_fpga_write(emu, EMU_HANA_OPTICAL_TYPE, 0x01 );
+	/* Optical -> ADAT I/O  */
+	snd_emu1010_fpga_write(emu, EMU_HANA_OPTICAL_TYPE, EMU_HANA_OPTICAL_IN_ADAT | EMU_HANA_OPTICAL_OUT_ADAT );
 	snd_emu1010_fpga_read(emu, EMU_HANA_ADC_PADS, &tmp );
 	/* Set no attenuation on Audio Dock pads. */
 	snd_emu1010_fpga_write(emu, EMU_HANA_ADC_PADS, 0x00 );
@@ -1048,7 +1048,7 @@
 	emu->emu1010.output_source[23] = 28;
 
 	/* TEMP: Select SPDIF in/out */
-	snd_emu1010_fpga_write(emu, EMU_HANA_OPTICAL_TYPE, 0x0); /* Output spdif */
+	//snd_emu1010_fpga_write(emu, EMU_HANA_OPTICAL_TYPE, 0x0); /* Output spdif */
 
 	/* TEMP: Select 48kHz SPDIF out */
 	snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, 0x0); /* Mute all */

--Boundary-00=_HYORGYV2Cfp4pxE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_HYORGYV2Cfp4pxE--
