From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: Au1550 OSS driver issues
Date: Thu, 06 Oct 2005 17:02:12 +0400
Message-ID: <43452054.2090305@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020903010402080404030206"
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
To: alsa-devel@lists.sourceforge.net, dan@embeddededge.com, ralf@linux-mips.org, ppopov@linux-mips.org
Cc: Konstantin Baidarov <kbaidarov@dev.rtsoft.ru>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020903010402080404030206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

     We have found some issues with Au1550 AC'97 OSS driver in 2.6
(sound/oss/au1550_ac97.c), though it also should concern 2.4 driver
(drivers/sound/au1550_psc.c).
     First, we don't think that using readl() calls instead of au_readl() is
correct -- readl() is subject to byte-swapping etc., so may not work in
big-endian mode anymore and au_readl() is intended for embedded Au1550 devices
for which the byte swapping issue is resolved automagically, and BTW the same
PSC_AC97STAT register is read "both ways" in the driver. That's what the first
patch is about.
     Second, start_dac() grabs a spinlock already held by its caller, 
au1550_write(). This doesn't show up with the standard UP spinlock 
impelmentation but when the different one (mutex based) is in use, a lockup 
happens. The second patch demonstates a possible solution but here's a 
question: why there's no "symmetric" spinlock logic in start_adc(), may be 
here exits another potential issue?

WBR, Sergei


--------------020903010402080404030206
Content-Type: text/plain;
 name="au1550_ac97_readl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="au1550_ac97_readl.patch"

Index: linux/sound/oss/au1550_ac97.c
===================================================================
--- linux.orig/sound/oss/au1550_ac97.c
+++ linux/sound/oss/au1550_ac97.c
@@ -463,7 +463,7 @@ stop_dac(struct au1550_state *s)
 	/* Wait for Transmit Busy to show disabled.
 	*/
 	do {
-		stat = readl((void *)PSC_AC97STAT);
+		stat = au_readl(PSC_AC97STAT);
 		au_sync();
 	} while ((stat & PSC_AC97STAT_TB) != 0);
 
@@ -492,7 +492,7 @@ stop_adc(struct au1550_state *s)
 	/* Wait for Receive Busy to show disabled.
 	*/
 	do {
-		stat = readl((void *)PSC_AC97STAT);
+		stat = au_readl(PSC_AC97STAT);
 		au_sync();
 	} while ((stat & PSC_AC97STAT_RB) != 0);
 
@@ -542,7 +542,7 @@ set_xmit_slots(int num_channels)
 	/* Wait for Device ready.
 	*/
 	do {
-		stat = readl((void *)PSC_AC97STAT);
+		stat = au_readl(PSC_AC97STAT);
 		au_sync();
 	} while ((stat & PSC_AC97STAT_DR) == 0);
 }
@@ -574,7 +574,7 @@ set_recv_slots(int num_channels)
 	/* Wait for Device ready.
 	*/
 	do {
-		stat = readl((void *)PSC_AC97STAT);
+		stat = au_readl(PSC_AC97STAT);
 		au_sync();
 	} while ((stat & PSC_AC97STAT_DR) == 0);
 }
@@ -1989,7 +1989,7 @@ au1550_probe(void)
 	/* Wait for PSC ready.
 	*/
 	do {
-		val = readl((void *)PSC_AC97STAT);
+		val = au_readl(PSC_AC97STAT);
 		au_sync();
 	} while ((val & PSC_AC97STAT_SR) == 0);
 
@@ -2012,7 +2012,7 @@ au1550_probe(void)
 	/* Wait for Device ready.
 	*/
 	do {
-		val = readl((void *)PSC_AC97STAT);
+		val = au_readl(PSC_AC97STAT);
 		au_sync();
 	} while ((val & PSC_AC97STAT_DR) == 0);
 


--------------020903010402080404030206
Content-Type: text/plain;
 name="au1550_ac97-spinlock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="au1550_ac97-spinlock.patch"

Index: linux/sound/oss/au1550_ac97.c
===================================================================
--- linux.orig/sound/oss/au1550_ac97.c
+++ linux/sound/oss/au1550_ac97.c
@@ -74,6 +74,9 @@
 
 #define err(format, arg...) printk(KERN_ERR format "\n" , ## arg)
 
+#define START_DAC_NOSL 1
+#define START_DAC_SL 0
+
 /* Boot options
  * 0 = no VRA, 1 = use VRA if codec supports it
  */
@@ -580,7 +583,7 @@ set_recv_slots(int num_channels)
 }
 
 static void
-start_dac(struct au1550_state *s)
+start_dac(struct au1550_state *s, int no_sl)
 {
 	struct dmabuf  *db = &s->dma_dac;
 	unsigned long   flags;
@@ -588,7 +591,8 @@ start_dac(struct au1550_state *s)
 	if (!db->stopped)
 		return;
 
-	spin_lock_irqsave(&s->lock, flags);
+	if( !no_sl )
+		spin_lock_irqsave(&s->lock, flags);
 
 	set_xmit_slots(db->num_channels);
 	au_writel(PSC_AC97PCR_TC, PSC_AC97PCR);
@@ -600,7 +604,8 @@ start_dac(struct au1550_state *s)
 
 	db->stopped = 0;
 
-	spin_unlock_irqrestore(&s->lock, flags);
+	if( !no_sl )
+		spin_unlock_irqrestore(&s->lock, flags);
 }
 
 static void
@@ -1182,7 +1187,7 @@ au1550_write(struct file *file, const ch
 				db->nextOut -= db->dmasize;
 			db->total_bytes += db->dma_fragsize;
 			if (db->dma_qcount == 0)
-				start_dac(s);
+				start_dac(s,START_DAC_NOSL);
 			db->dma_qcount++;
 		}
 		spin_unlock_irqrestore(&s->lock, flags);
@@ -1578,7 +1583,7 @@ au1550_ioctl(struct inode *inode, struct
 		}
 		if (file->f_mode & FMODE_WRITE) {
 			if (val & PCM_ENABLE_OUTPUT)
-				start_dac(s);
+				start_dac(s,START_DAC_SL);
 			else
 				stop_dac(s);
 		}


--------------020903010402080404030206--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
