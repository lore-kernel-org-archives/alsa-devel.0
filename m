From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/4] ALSA: hdsp - Fix detection for RME
	RPM/Multiface/Digiface ioboxes
Date: Mon, 14 Jan 2013 21:37:17 +0100
Message-ID: <1358195840-8228-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org, Karl Grill <kgrill@chello.at>
List-Id: alsa-devel@alsa-project.org

The current iobox detection code reportedly fails for various users, so
simply do what the Win32 driver does instead.

Patch originally by Karl Grill <kgrill@chello.at> and then modified to
comply with kernel coding guidelines + current HEAD.

Signed-off-by: Karl Grill <kgrill@chello.at>
Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 4fae81f..bcad9ba 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -154,10 +154,11 @@ MODULE_FIRMWARE("digiface_firmware_rev11.bin");
 #define HDSP_BIGENDIAN_MODE     0x200
 #define HDSP_RD_MULTIPLE        0x400
 #define HDSP_9652_ENABLE_MIXER  0x800
+#define HDSP_DUNNO		0x1000
 #define HDSP_TDO                0x10000000
 
-#define HDSP_S_PROGRAM     	(HDSP_PROGRAM|HDSP_CONFIG_MODE_0)
-#define HDSP_S_LOAD		(HDSP_PROGRAM|HDSP_CONFIG_MODE_1)
+#define HDSP_S_PROGRAM		(HDSP_DUNNO|HDSP_PROGRAM|HDSP_CONFIG_MODE_0)
+#define HDSP_S_LOAD		(HDSP_DUNNO|HDSP_PROGRAM|HDSP_CONFIG_MODE_1)
 
 /* Control Register bits */
 
@@ -671,13 +672,23 @@ static unsigned int hdsp_read(struct hdsp *hdsp, int reg)
 
 static int hdsp_check_for_iobox (struct hdsp *hdsp)
 {
+	int i;
+
 	if (hdsp->io_type == H9652 || hdsp->io_type == H9632) return 0;
-	if (hdsp_read (hdsp, HDSP_statusRegister) & HDSP_ConfigError) {
-		snd_printk("Hammerfall-DSP: no IO box connected!\n");
-		hdsp->state &= ~HDSP_FirmwareLoaded;
-		return -EIO;
+	for (i = 0; i < 500; i++) {
+		if (0 == (hdsp_read(hdsp, HDSP_statusRegister) &
+					HDSP_ConfigError)) {
+			if (i) {
+				snd_printk("Hammerfall-DSP: IO box found after %d ms\n",
+						i);
+			}
+			return 0;
+		}
+		msleep(20);
 	}
-	return 0;
+	snd_printk("Hammerfall-DSP: no IO box connected!\n");
+	hdsp->state &= ~HDSP_FirmwareLoaded;
+	return -EIO;
 }
 
 static int hdsp_wait_for_iobox(struct hdsp *hdsp, unsigned int loops,
@@ -728,6 +739,7 @@ static int snd_hdsp_load_firmware_from_cache(struct hdsp *hdsp) {
 
 		if (hdsp_fifo_wait (hdsp, 0, HDSP_LONG_WAIT)) {
 			snd_printk ("Hammerfall-DSP: timeout waiting for download preparation\n");
+			hdsp_write(hdsp, HDSP_control2Reg, 0x800);
 			return -EIO;
 		}
 
@@ -737,17 +749,15 @@ static int snd_hdsp_load_firmware_from_cache(struct hdsp *hdsp) {
 			hdsp_write(hdsp, HDSP_fifoData, cache[i]);
 			if (hdsp_fifo_wait (hdsp, 127, HDSP_LONG_WAIT)) {
 				snd_printk ("Hammerfall-DSP: timeout during firmware loading\n");
+				hdsp_write(hdsp, HDSP_control2Reg, 0x800);
 				return -EIO;
 			}
 		}
 
-		ssleep(3);
-
-		if (hdsp_fifo_wait (hdsp, 0, HDSP_LONG_WAIT)) {
-			snd_printk ("Hammerfall-DSP: timeout at end of firmware loading\n");
-		    	return -EIO;
-		}
+		hdsp_fifo_wait(hdsp, 3, HDSP_LONG_WAIT);
+		hdsp_write(hdsp, HDSP_control2Reg, 0x800);
 
+		ssleep(3);
 #ifdef SNDRV_BIG_ENDIAN
 		hdsp->control2_register = HDSP_BIGENDIAN_MODE;
 #else
@@ -773,24 +783,51 @@ static int hdsp_get_iobox_version (struct hdsp *hdsp)
 {
 	if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
 
-		hdsp_write (hdsp, HDSP_control2Reg, HDSP_PROGRAM);
-		hdsp_write (hdsp, HDSP_fifoData, 0);
-		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT) < 0)
-			return -EIO;
+		hdsp_write(hdsp, HDSP_control2Reg, 0x10a0);
+		hdsp_write(hdsp, HDSP_fifoData, 0);
 
-		hdsp_write (hdsp, HDSP_control2Reg, HDSP_S_LOAD);
+		if (hdsp_fifo_wait(hdsp, 0, HDSP_SHORT_WAIT) < 0) {
+			hdsp_write(hdsp, HDSP_control2Reg, 0x900);
+			hdsp_write(hdsp, HDSP_control2Reg, 0x10a0);
+		}
+
+		hdsp_write(hdsp, HDSP_control2Reg, 0x820);
 		hdsp_write (hdsp, HDSP_fifoData, 0);
+		if (hdsp_fifo_wait(hdsp, 0, HDSP_SHORT_WAIT) < 0) {
+			hdsp->io_type = Multiface;
+			snd_printk("Hammerfall-DSP: Multiface found\n");
+			return 0;
+		}
 
-		if (hdsp_fifo_wait(hdsp, 0, HDSP_SHORT_WAIT)) {
-			hdsp_write(hdsp, HDSP_control2Reg, HDSP_VERSION_BIT);
-			hdsp_write(hdsp, HDSP_control2Reg, HDSP_S_LOAD);
-			if (hdsp_fifo_wait(hdsp, 0, HDSP_SHORT_WAIT))
-				hdsp->io_type = RPM;
-			else
-				hdsp->io_type = Multiface;
-		} else {
+		hdsp_write(hdsp, HDSP_control2Reg, 0x10a0);
+		hdsp_write(hdsp, HDSP_fifoData, 0);
+		if (hdsp_fifo_wait(hdsp, 0, HDSP_SHORT_WAIT) == 0) {
 			hdsp->io_type = Digiface;
+			snd_printk("Hammerfall-DSP: Digiface found\n");
+			return 0;
 		}
+
+		hdsp_write(hdsp, HDSP_control2Reg, 0x900);
+		hdsp_write(hdsp, HDSP_control2Reg, 0x10a0);
+		hdsp_write(hdsp, HDSP_fifoData, 0);
+		if (hdsp_fifo_wait(hdsp, 0, HDSP_SHORT_WAIT) == 0) {
+			hdsp->io_type = Multiface;
+			snd_printk("Hammerfall-DSP: Multiface found\n");
+			return 0;
+		}
+
+		hdsp_write(hdsp, HDSP_control2Reg, 0x900);
+		hdsp_write(hdsp, HDSP_control2Reg, 0x10a0);
+		hdsp_write(hdsp, HDSP_fifoData, 0);
+		if (hdsp_fifo_wait(hdsp, 0, HDSP_SHORT_WAIT) < 0) {
+			hdsp->io_type = Multiface;
+			snd_printk("Hammerfall-DSP: Multiface found\n");
+			return 0;
+		}
+
+		hdsp->io_type = RPM;
+		snd_printk("Hammerfall-DSP: RPM found\n");
+		return 0;
 	} else {
 		/* firmware was already loaded, get iobox type */
 		if (hdsp_read(hdsp, HDSP_status2Register) & HDSP_version2)
-- 
1.7.10.4
