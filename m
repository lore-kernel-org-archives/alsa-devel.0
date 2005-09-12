From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH] Reduce interrupt latency in sound/pci/via82xx.c
Date: Mon, 12 Sep 2005 14:18:04 +0200
Message-ID: <200509121418.05184.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9HXJDJnQNGoAbtc"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_9HXJDJnQNGoAbtc
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Takashi

Please apply, if you agree.

   Thanks,
   Karsten


--Boundary-00=_9HXJDJnQNGoAbtc
Content-Type: text/x-diff;
  charset="us-ascii";
  name="via82xx_fast_pointer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="via82xx_fast_pointer.patch"

From: Karsten Wiese <annabellesgarden@yahoo.de>


Reduce interrupt latency in sound/pci/via82xx.c


The change only affects the via823x kind of chips.
Here the  via8233_pcm_pointer_hw() function
(named snd_via8233_pcm_pointer() before)
needs to loop until a non zero position is red from the chip.

Measurements have shown that more than 200 loops are typically needed on
an Athlon64. 
As io-reads cost many cycles, those loops sum up huge.
via8233_pcm_pointer_hw() runs either in interrupt or with interrupts
disabled. So it introduces significant interrupt latency.

The patch introduces a calculated position value hwptr_done,
that is updated by the interrupt routine when a period is completed.
This works much faster at the cost of less precise positions.
Position precision is period_size, which is ok for nearly all applications.

The actual method chosen depends on the period_size used and its
relation to the module parameter hw_position[]:
	if (period_size >= hw_position[device_index]))
		Use chip based precise position calculation
	else
		Use fast coarse position calculation


Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>


--- alsa/alsa-kernel/pci/via82xx.c	9 Sep 2005 13:21:46 -0000	1.167
+++ alsa/alsa-kernel/pci/via82xx.c	12 Sep 2005 11:30:05 -0000
@@ -83,6 +83,7 @@
 static int ac97_clock[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 48000};
 static char *ac97_quirk[SNDRV_CARDS];
 static int dxs_support[SNDRV_CARDS];
+static int hw_position[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 8192};
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for VIA 82xx bridge.");
@@ -102,6 +103,8 @@
 MODULE_PARM_DESC(ac97_quirk, "AC'97 workaround for strange hardware.");
 module_param_array(dxs_support, int, NULL, 0444);
 MODULE_PARM_DESC(dxs_support, "Support for DXS channels (0 = auto, 1 = enable, 2 = disable, 3 = 48k only, 4 = no VRA, 5 = enable any sample rate)");
+module_param_array(hw_position, int, NULL, 0444);
+MODULE_PARM_DESC(hw_position, "If actual frames per period is bigger or equal, position is red from hardware. Else position resolution is period size.");
 
 
 /* revision numbers for via686 */
@@ -328,6 +331,7 @@
 	unsigned int fragsize;
 	unsigned int bufsize;
 	unsigned int bufsize2;
+	int hwptr_done;		/* processed frame position in the buffer */
 };
 
 
@@ -596,6 +600,7 @@
 	outb(0x00, VIADEV_REG(viadev, OFFSET_TYPE)); /* for via686 */
 	// outl(0, VIADEV_REG(viadev, OFFSET_CURR_PTR));
 	viadev->lastpos = 0;
+	viadev->hwptr_done = 0;
 }
 
 
@@ -621,13 +626,26 @@
 	spin_lock(&chip->reg_lock);
 	for (i = 0; i < chip->num_devs; i++) {
 		viadev_t *viadev = &chip->devs[i];
+		snd_pcm_substream_t *substream;
 		unsigned char c_status = inb(VIADEV_REG(viadev, OFFSET_STATUS));
 		c_status &= (VIA_REG_STAT_EOL|VIA_REG_STAT_FLAG|VIA_REG_STAT_STOPPED);
 		if (! c_status)
 			continue;
-		if (viadev->substream && viadev->running) {
+		substream = viadev->substream;
+		if (substream && viadev->running) {
 			spin_unlock(&chip->reg_lock);
-			snd_pcm_period_elapsed(viadev->substream);
+
+			/*
+			 * Update period bound position.
+			 * Its used by via8233 when hw_pointer[dev] > period_size.
+			 * To check for this condition would take as much cycles as to just do it.
+			 */
+			if (c_status & VIA_REG_STAT_EOL)
+				viadev->hwptr_done = 0;
+			else
+				viadev->hwptr_done += substream->runtime->period_size;
+
+			snd_pcm_period_elapsed(substream);
 			spin_lock(&chip->reg_lock);
 		}
 		outb(c_status, VIADEV_REG(viadev, OFFSET_STATUS)); /* ack */
@@ -764,12 +782,12 @@
 }
 
 /*
- * get the current pointer on via823x
+ * get the current pointer on via823x from chip
+ * exact, but slow due to excessive looping 
  */
-static snd_pcm_uframes_t snd_via8233_pcm_pointer(snd_pcm_substream_t *substream)
+static snd_pcm_uframes_t via8233_pcm_pointer_hw(snd_pcm_substream_t *substream, viadev_t *viadev)
 {
 	via82xx_t *chip = snd_pcm_substream_chip(substream);
-	viadev_t *viadev = (viadev_t *)substream->runtime->private_data;
 	unsigned int idx, count, res;
 	int timeout = 5000;
 	
@@ -800,6 +818,26 @@
 	return bytes_to_frames(substream->runtime, res);
 }
 
+/*
+ * get the current pointer on via82xx from elapsed periods.
+ * resolution limited to period_size. fast. 
+ */
+static snd_pcm_uframes_t via82xx_pcm_pointer(snd_pcm_substream_t *substream, viadev_t *viadev)
+{
+	return viadev->hwptr_done;
+}
+
+/*
+ * get the current pointer on via823x
+ */
+static snd_pcm_uframes_t snd_via8233_pcm_pointer(snd_pcm_substream_t *substream)
+{
+	viadev_t *viadev = (viadev_t *)substream->runtime->private_data;
+	if (likely(hw_position[substream->pcm->device] > substream->runtime->period_size))
+			return via82xx_pcm_pointer(substream, viadev);
+		else
+			return via8233_pcm_pointer_hw(substream, viadev);
+}
 
 /*
  * hw_params callback:

--Boundary-00=_9HXJDJnQNGoAbtc--

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
