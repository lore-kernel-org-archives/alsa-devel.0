From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] make the pxa2xx-ac97 module more robust against PXA27x bugs
Date: Mon, 12 Dec 2005 10:31:25 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512121026380.26663@localhost.localdomain>
References: <Pine.LNX.4.64.0512091537350.26663@localhost.localdomain>
 <s5h64puzhf6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5h64puzhf6.wl%tiwai@suse.de>
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

The SDONE and CDONE interrupt on the PXA27x might become unusable in
some conditions.  Let's use an hybrid approach (interrupt with timeout)
to have the best possible behavior in all conditions.

Also let's not care about CAR_CAIP anymore.  This is useless.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

Index: alsa-kernel/arm/pxa2xx-ac97.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/arm/pxa2xx-ac97.c,v
retrieving revision 1.9
diff -u -r1.9 pxa2xx-ac97.c
--- alsa-kernel/arm/pxa2xx-ac97.c	17 Nov 2005 17:19:25 -0000
+++ alsa-kernel/arm/pxa2xx-ac97.c	12 Dec 2005 15:20:23 -0000
@@ -37,39 +37,47 @@
 static DECLARE_WAIT_QUEUE_HEAD(gsr_wq);
 static volatile long gsr_bits;
 
+/*
+ * Beware PXA27x bugs:
+ *
+ *   o Slot 12 read from modem space will hang controller.
+ *   o CDONE, SDONE interrupt fails after any slot 12 IO.
+ *
+ * We therefore have an hybrid approach for waiting on SDONE (interrupt or
+ * 1 jiffy timeout if interrupt never comes).
+ */ 
+
 static unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 {
 	unsigned short val = -1;
 	volatile u32 *reg_addr;
 
 	down(&car_mutex);
-	if (CAR & CAR_CAIP) {
-		printk(KERN_CRIT"%s: CAR_CAIP already set\n", __FUNCTION__);
-		goto out;
-	}
 
 	/* set up primary or secondary codec space */
 	reg_addr = (ac97->num & 1) ? &SAC_REG_BASE : &PAC_REG_BASE;
 	reg_addr += (reg >> 1);
 
 	/* start read access across the ac97 link */
+	GSR = GSR_CDONE | GSR_SDONE;
 	gsr_bits = 0;
 	val = *reg_addr;
 	if (reg == AC97_GPIO_STATUS)
 		goto out;
-	wait_event_timeout(gsr_wq, gsr_bits & GSR_SDONE, 1);
-	if (!gsr_bits & GSR_SDONE) {
+	if (wait_event_timeout(gsr_wq, (GSR | gsr_bits) & GSR_SDONE, 1) <= 0 &&
+	    !((GSR | gsr_bits) & GSR_SDONE)) {
 		printk(KERN_ERR "%s: read error (ac97_reg=%d GSR=%#lx)\n",
-				__FUNCTION__, reg, gsr_bits);
+				__FUNCTION__, reg, GSR | gsr_bits);
 		val = -1;
 		goto out;
 	}
 
 	/* valid data now */
+	GSR = GSR_CDONE | GSR_SDONE;
 	gsr_bits = 0;
 	val = *reg_addr;			
 	/* but we've just started another cycle... */
-	wait_event_timeout(gsr_wq, gsr_bits & GSR_SDONE, 1);
+	wait_event_timeout(gsr_wq, (GSR | gsr_bits) & GSR_SDONE, 1);
 
 out:	up(&car_mutex);
 	return val;
@@ -81,22 +89,19 @@
 
 	down(&car_mutex);
 
-	if (CAR & CAR_CAIP) {
-		printk(KERN_CRIT "%s: CAR_CAIP already set\n", __FUNCTION__);
-		goto out;
-	}
-
 	/* set up primary or secondary codec space */
 	reg_addr = (ac97->num & 1) ? &SAC_REG_BASE : &PAC_REG_BASE;
 	reg_addr += (reg >> 1);
+
+	GSR = GSR_CDONE | GSR_SDONE;
 	gsr_bits = 0;
 	*reg_addr = val;
-	wait_event_timeout(gsr_wq, gsr_bits & GSR_CDONE, 1);
-	if (!gsr_bits & GSR_SDONE)
+	if (wait_event_timeout(gsr_wq, (GSR | gsr_bits) & GSR_CDONE, 1) <= 0 &&
+	    !((GSR | gsr_bits) & GSR_CDONE))
 		printk(KERN_ERR "%s: write error (ac97_reg=%d GSR=%#lx)\n",
-				__FUNCTION__, reg, gsr_bits);
+				__FUNCTION__, reg, GSR | gsr_bits);
 
-out:	up(&car_mutex);
+	up(&car_mutex);
 }
 
 static void pxa2xx_ac97_reset(struct snd_ac97 *ac97)


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
