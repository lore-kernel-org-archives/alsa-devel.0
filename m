From: Paul Davis <pbd@op.net>
Subject: patches for RME Hammerfall DSP
Date: Sat, 13 Jul 2002 13:07:08 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207131707.g6DH78J00791@op.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA02455
	for <alsa-devel@alsa-project.org>; Sat, 13 Jul 2002 19:06:20 +0200
Received: from unknown (HELO op.net) ([209.92.99.155]) (envelope-sender <pbd@op.net>)
          by newmx1.fast.net (qmail-ldap-1.03) with SMTP
          for <alsa-devel@alsa-project.org>; 13 Jul 2002 17:06:07 -0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This set of patches:

     * fixes a problem with initialization when firmware was
         already loaded (we ended up with random channel counts)
     * adds the snd_line_outs_monitor option
          - if enabled, all input and playback streams are
	    routed with unity gain to the line outs
     * adds the snd_force_firmware option
          - if enabled, I/O box firmware is reloaded whether
	    its already loaded or not

There are also a couple of minor corrections.

The driver/hardware still suffers from a problem that requires 1 warm
reboot (or PCMCIA card eject/reinsert) after a cold boot to get output
working. I am continuing to work on a solution to the problem.

--p

Index: digiface_firmware.dat
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/rme9652/digiface_firmware.dat,v
retrieving revision 1.3
diff -u -u -r1.3 digiface_firmware.dat
--- digiface_firmware.dat	24 May 2002 16:29:20 -0000	1.3
+++ digiface_firmware.dat	13 Jul 2002 16:54:22 -0000
@@ -1,5 +1,5 @@
 /* stored in little-endian */
-static u32 digiface_firmware[97652] __devinitdata = {
+static u32 digiface_firmware[24413] __devinitdata = {
 0xffffffff, 0x66aa9955, 0x8001000c, 0xe0000000, 0x8006800c, 0xb0000000,
 0x8004800c, 0xb4fc0100, 0x8003000c, 0x00000000, 0x8001000c, 0x90000000,
 0x8004000c, 0x00000000, 0x8001000c, 0x80000000, 0x0002000c, 0x581a000a,
Index: hdsp.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/rme9652/hdsp.c,v
retrieving revision 1.7
diff -u -u -r1.7 hdsp.c
--- hdsp.c	19 Jun 2002 14:21:52 -0000	1.7
+++ hdsp.c	13 Jul 2002 16:54:29 -0000
@@ -42,6 +42,8 @@
 static char *snd_id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int snd_enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable this card */
 static int snd_precise_ptr[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = 0 }; /* Enable precise pointer */
+static int snd_line_outs_monitor[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = 0}; /* Send all inputs/playback to line outs */
+static int snd_force_firmware[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = 0}; /* Force firmware reload */
 
 MODULE_PARM(snd_index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(snd_index, "Index value for RME Hammerfall DSP interface.");
@@ -55,8 +57,14 @@
 MODULE_PARM(snd_precise_ptr, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(snd_precise_ptr, "Enable precise pointer (doesn't work reliably).");
 MODULE_PARM_SYNTAX(snd_precise_ptr, SNDRV_ENABLED "," SNDRV_BOOLEAN_FALSE_DESC);
+MODULE_PARM(snd_line_outs_monitor,"1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(snd_line_outs_monitor, "Send all input and playback streams to line outs by default.");
+MODULE_PARM_SYNTAX(snd_line_outs_monitor, SNDRV_ENABLED "," SNDRV_BOOLEAN_FALSE_DESC);
+MODULE_PARM(snd_force_firmware,"1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(snd_force_firmware, "Force a reload of the I/O box firmware");
+MODULE_PARM_SYNTAX(snd_force_firmware, SNDRV_ENABLED "," SNDRV_BOOLEAN_FALSE_DESC);
 MODULE_AUTHOR("Paul Davis <pbd@op.net>");
-MODULE_DESCRIPTION("RME Hammerfall DDSP");
+MODULE_DESCRIPTION("RME Hammerfall DSP");
 MODULE_LICENSE("GPL");
 MODULE_CLASSES("{sound}");
 MODULE_DEVICES("{{RME,Hammerfall-DSP},");
@@ -2190,6 +2198,25 @@
 	for (i = 0; i < 2048; i++)
 		hdsp_write_gain (hdsp, i, MINUS_INFINITY_GAIN);
 
+	if (snd_line_outs_monitor[hdsp->dev]) {
+		
+		snd_printk ("sending all inputs and playback streams to line outs.\n");
+
+		/* route all inputs to the line outs for easy monitoring. send
+		   odd numbered channels to right, even to left.
+		*/
+		
+		for (i = 0; i < HDSP_MAX_CHANNELS; i++) {
+			if (i & 1) { 
+				hdsp_write_gain (hdsp, INPUT_TO_OUTPUT_KEY (i, 26), UNITY_GAIN);
+				hdsp_write_gain (hdsp, PLAYBACK_TO_OUTPUT_KEY (i, 26), UNITY_GAIN);
+			} else {
+				hdsp_write_gain (hdsp, INPUT_TO_OUTPUT_KEY (i, 27), UNITY_GAIN);
+				hdsp_write_gain (hdsp, PLAYBACK_TO_OUTPUT_KEY (i, 27), UNITY_GAIN);
+			}
+		}
+	}
+
 	hdsp->passthru = 0;
 
 	/* set a default rate so that the channel map is set up.
@@ -2812,7 +2839,6 @@
 static int __devinit snd_hdsp_initialize_firmware (hdsp_t *hdsp)
 {
 	int i;
-	int status_reg;
 	u32 *firmware_ptr;
 
 	if (hdsp_check_for_iobox (hdsp)) {
@@ -2830,52 +2856,33 @@
 		hdsp_write (hdsp, HDSP_outputEnable + (4 * i), 1);
 	}
 
-	status_reg = hdsp_read (hdsp, HDSP_statusRegister);
+	if (snd_force_firmware[hdsp->dev] || (hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
 
-	if ((status_reg & HDSP_DllError) == 0) {
-
-		/* i/o box is connected, firmware already loaded */
-
-		if (hdsp_read (hdsp, HDSP_status2Register) & HDSP_version1) {
-			hdsp->type = Multiface;
-			hdsp->card_name = "RME Hammerfall DSP (Multiface)";
-			hdsp->ss_channels = MULTIFACE_SS_CHANNELS;
-			hdsp->ds_channels = MULTIFACE_DS_CHANNELS;
-		} else {
-			hdsp->type = Digiface;
-			hdsp->card_name = "RME Hammerfall DSP (Digiface)";
-			hdsp->ss_channels = DIGIFACE_SS_CHANNELS;
-			hdsp->ds_channels = DIGIFACE_DS_CHANNELS;
-		}
-
-	} else {
+		snd_printk ("loading firmware\n");
 
-		/* firmware not loaded, but i/o box is connected */
-		
 		hdsp_write (hdsp, HDSP_jtagReg, HDSP_PROGRAM);
 		hdsp_write (hdsp, HDSP_fifoData, 0);
-		hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT);
+		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT) < 0) {
+			snd_printk ("timeout waiting for firmware setup\n");
+			return -EIO;
+		}
 
 		hdsp_write (hdsp, HDSP_jtagReg, HDSP_S_LOAD);
 		hdsp_write (hdsp, HDSP_fifoData, 0);
 
-		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT) < 0) {
-			printk ("looks like a multiface\n");
+		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT)) {
 			hdsp->type = Multiface;
-			hdsp->card_name = "RME Hammerfall DSP (Multiface)";
 			hdsp_write (hdsp, HDSP_jtagReg, HDSP_VERSION_BIT);
 			hdsp_write (hdsp, HDSP_jtagReg, HDSP_S_LOAD);
 			hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT);
 		} else {
-			printk ("looks like a digiface\n");
 			hdsp->type = Digiface;
-			hdsp->card_name = "RME Hammerfall DSP (Digiface)";
 		} 
 
 		hdsp_write (hdsp, HDSP_jtagReg, HDSP_S_PROGRAM);
 		hdsp_write (hdsp, HDSP_fifoData, 0);
 		
-		if (hdsp_fifo_wait (hdsp, 0, HDSP_LONG_WAIT) < 0) {
+		if (hdsp_fifo_wait (hdsp, 0, HDSP_LONG_WAIT)) {
 			snd_printk ("timeout waiting for download preparation\n");
 			return -EIO;
 		}
@@ -2883,9 +2890,9 @@
 		hdsp_write (hdsp, HDSP_jtagReg, HDSP_S_LOAD);
 		
 		if (hdsp->type == Digiface) {
-			firmware_ptr = digiface_firmware;
+			firmware_ptr = (u32 *) digiface_firmware;
 		} else {
-			firmware_ptr = multiface_firmware;
+			firmware_ptr = (u32 *) multiface_firmware;
 		}
 		
 		for (i = 0; i < 24413; ++i) {
@@ -2901,8 +2908,30 @@
 			return -EIO;
 		}
 
+	} else {
+
+		/* firmware already loaded, but we need to know what type
+		   of I/O box is connected.
+		*/
+
+		if (hdsp_read(hdsp, HDSP_status2Register) & HDSP_version1) {
+			hdsp->type = Multiface;
+		} else {
+			hdsp->type = Digiface;
+		}
 	}
 
+	if (hdsp->type == Digiface) {
+		snd_printk ("I/O Box is a Digiface\n");
+		hdsp->card_name = "RME Hammerfall DSP (Digiface)";
+		hdsp->ss_channels = DIGIFACE_SS_CHANNELS;
+		hdsp->ds_channels = DIGIFACE_DS_CHANNELS;
+	} else {
+		snd_printk ("I/O Box is a Multiface\n");
+		hdsp->card_name = "RME Hammerfall DSP (Multiface)";
+		hdsp->ss_channels = MULTIFACE_SS_CHANNELS;
+		hdsp->ds_channels = MULTIFACE_DS_CHANNELS;
+	}
 	
 	snd_hdsp_flush_midi_input (hdsp, 0);
 	snd_hdsp_flush_midi_input (hdsp, 1);
Index: multiface_firmware.dat
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/rme9652/multiface_firmware.dat,v
retrieving revision 1.2
diff -u -u -r1.2 multiface_firmware.dat
--- multiface_firmware.dat	24 May 2002 16:29:20 -0000	1.2
+++ multiface_firmware.dat	13 Jul 2002 16:55:05 -0000
@@ -1,5 +1,5 @@
 /* stored in little-endian */
-static u32 multiface_firmware[97652] __devinitdata = {
+static u32 multiface_firmware[24413] __devinitdata = {
 0xffffffff, 0x66aa9955, 0x8001000c, 0xe0000000, 0x8006800c, 0xb0000000,
 0x8004800c, 0xb4fc0100, 0x8003000c, 0x00000000, 0x8001000c, 0x90000000,
 0x8004000c, 0x00000000, 0x8001000c, 0x80000000, 0x0002000c, 0x581a000a,


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
