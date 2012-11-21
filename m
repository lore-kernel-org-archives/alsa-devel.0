From: Karl Grill <kgrill@chello.at>
Subject: [PATCH - hdsp.c 1/1] HDSP fixes for RPM
Date: Wed, 21 Nov 2012 22:33:52 +0100
Message-ID: <1353533632.2957.10.camel@chello084112006029.chello.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep11.mx.upcmail.net (fep11.mx.upcmail.net [62.179.121.31])
 by alsa0.perex.cz (Postfix) with ESMTP id E65F0261732
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 21:56:26 +0100 (CET)
Received: from edge01.upcmail.net ([192.168.13.236]) by viefep11-int.chello.at
 (InterMail vM.8.01.05.05 201-2260-151-110-20120111) with ESMTP
 id <20121121205626.FSJQ2060.viefep11-int.chello.at@edge01.upcmail.net>
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 21:56:26 +0100
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



- changed iobox recognition and firmware loading to mimick XP driver 
- added loop to check_for_iobox() to fix timing issues

Signed-off-by: Karl Grill <kgrill@chello.at>

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 0d6930c..4229b0d 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -155,10 +155,11 @@ MODULE_FIRMWARE("digiface_firmware_rev11.bin");
 #define HDSP_BIGENDIAN_MODE     0x200
 #define HDSP_RD_MULTIPLE        0x400
 #define HDSP_9652_ENABLE_MIXER  0x800
+#define HDSP_DUNNO		0x1000
 #define HDSP_TDO                0x10000000
 
-#define HDSP_S_PROGRAM     	(HDSP_PROGRAM|HDSP_CONFIG_MODE_0)
-#define HDSP_S_LOAD		(HDSP_PROGRAM|HDSP_CONFIG_MODE_1)
+#define HDSP_S_PROGRAM     	(HDSP_DUNNO|HDSP_PROGRAM|HDSP_CONFIG_MODE_0)
+#define HDSP_S_LOAD		(HDSP_DUNNO|HDSP_PROGRAM|HDSP_CONFIG_MODE_1)
 
 /* Control Register bits */
 
@@ -676,13 +677,20 @@ static unsigned int hdsp_read(struct hdsp *hdsp, int reg)
 
 static int hdsp_check_for_iobox (struct hdsp *hdsp)
 {
+	int i;
+
 	if (hdsp->io_type == H9652 || hdsp->io_type == H9632) return 0;
-	if (hdsp_read (hdsp, HDSP_statusRegister) & HDSP_ConfigError) {
-		snd_printk("Hammerfall-DSP: no IO box connected!\n");
-		hdsp->state &= ~HDSP_FirmwareLoaded;
-		return -EIO;
+	for(i=0; i<10000; i++) {
+		if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_ConfigError)==0) {
+			if(i)
+				snd_printk("Hammerfall-DSP: IO box found after %d ms\n", i);
+			return 0;
+		}
+		msleep(1);
 	}
-	return 0;
+	snd_printk("Hammerfall-DSP: no IO box connected!\n");
+	hdsp->state &= ~HDSP_FirmwareLoaded;
+	return -EIO;
 }
 
 static int hdsp_wait_for_iobox(struct hdsp *hdsp, unsigned int loops,
@@ -722,6 +730,7 @@ static int snd_hdsp_load_firmware_from_cache(struct hdsp *hdsp) {
 
 		if (hdsp_fifo_wait (hdsp, 0, HDSP_LONG_WAIT)) {
 			snd_printk ("Hammerfall-DSP: timeout waiting for download preparation\n");
+			hdsp_write (hdsp, HDSP_control2Reg, 0x800);
 			return -EIO;
 		}
 
@@ -731,25 +740,25 @@ static int snd_hdsp_load_firmware_from_cache(struct hdsp *hdsp) {
 			hdsp_write(hdsp, HDSP_fifoData, hdsp->firmware_cache[i]);
 			if (hdsp_fifo_wait (hdsp, 127, HDSP_LONG_WAIT)) {
 				snd_printk ("Hammerfall-DSP: timeout during firmware loading\n");
+				hdsp_write (hdsp, HDSP_control2Reg, 0x800);
 				return -EIO;
 			}
 		}
 
-		ssleep(3);
-
-		if (hdsp_fifo_wait (hdsp, 0, HDSP_LONG_WAIT)) {
-			snd_printk ("Hammerfall-DSP: timeout at end of firmware loading\n");
-		    	return -EIO;
-		}
+		hdsp_fifo_wait (hdsp, 3, HDSP_LONG_WAIT);
+		hdsp_write (hdsp, HDSP_control2Reg, 0x800);
 
+		ssleep(3);
 #ifdef SNDRV_BIG_ENDIAN
 		hdsp->control2_register = HDSP_BIGENDIAN_MODE;
 #else
 		hdsp->control2_register = 0;
 #endif
+
 		hdsp_write (hdsp, HDSP_control2Reg, hdsp->control2_register);
 		snd_printk ("Hammerfall-DSP: finished firmware loading\n");
 
+
 	}
 	if (hdsp->state & HDSP_InitializationComplete) {
 		snd_printk(KERN_INFO "Hammerfall-DSP: firmware loaded from cache, restoring defaults\n");
@@ -767,24 +776,46 @@ static int hdsp_get_iobox_version (struct hdsp *hdsp)
 {
 	if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
 
-		hdsp_write (hdsp, HDSP_control2Reg, HDSP_PROGRAM);
+		hdsp_write (hdsp, HDSP_control2Reg, 0x10a0);
 		hdsp_write (hdsp, HDSP_fifoData, 0);
-		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT) < 0)
-			return -EIO;
-
-		hdsp_write (hdsp, HDSP_control2Reg, HDSP_S_LOAD);
+		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT) < 0) {
+			hdsp_write(hdsp, HDSP_control2Reg, 0x900);
+			hdsp_write(hdsp, HDSP_control2Reg, 0x10a0);
+		}
+		hdsp_write(hdsp, HDSP_control2Reg, 0x820);
 		hdsp_write (hdsp, HDSP_fifoData, 0);
-
-		if (hdsp_fifo_wait(hdsp, 0, HDSP_SHORT_WAIT)) {
-			hdsp_write(hdsp, HDSP_control2Reg, HDSP_VERSION_BIT);
-			hdsp_write(hdsp, HDSP_control2Reg, HDSP_S_LOAD);
-			if (hdsp_fifo_wait(hdsp, 0, HDSP_SHORT_WAIT))
-				hdsp->io_type = RPM;
-			else
-				hdsp->io_type = Multiface;
-		} else {
-			hdsp->io_type = Digiface;
+		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT) < 0) {
+			hdsp->io_type=Multiface;
+		snd_printk("Hammerfall-DSP: Multiface found\n");
+			return 0;
+		}
+		hdsp_write(hdsp, HDSP_control2Reg, 0x10a0);
+		hdsp_write (hdsp, HDSP_fifoData, 0);
+		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT) == 0) {
+			hdsp->io_type=Digiface;
+		snd_printk("Hammerfall-DSP: Digiface found\n");
+			return 0;
+		}
+		hdsp_write(hdsp, HDSP_control2Reg, 0x900);
+		hdsp_write(hdsp, HDSP_control2Reg, 0x10a0);
+		hdsp_write (hdsp, HDSP_fifoData, 0);
+		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT) == 0) {
+			hdsp->io_type=Multiface;
+		snd_printk("Hammerfall-DSP: Multiface found\n");
+			return 0;
+		}
+		hdsp_write(hdsp, HDSP_control2Reg, 0x900);
+		hdsp_write(hdsp, HDSP_control2Reg, 0x10a0);
+		hdsp_write (hdsp, HDSP_fifoData, 0);
+		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT) < 0) {
+			hdsp->io_type=Multiface;
+		snd_printk("Hammerfall-DSP: Multiface found\n");
+			return 0;
 		}
+		hdsp->io_type=RPM;
+		snd_printk("Hammerfall-DSP: RPM found\n");
+                return 0;
+			
 	} else {
 		/* firmware was already loaded, get iobox type */
 		if (hdsp_read(hdsp, HDSP_status2Register) & HDSP_version2)
-- 
1.7.2.5
