From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] `return' with no value in pmac.c and tumbler.c
Date: Thu, 13 May 2004 20:03:41 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040513200341.782014c6.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


Fix for:

/home/Giu/soft/alsa-driver-1.0.4/ppc/pmac.c: In function `snd_pmac_tx_intr':
/home/Giu/soft/alsa-driver-1.0.4/ppc/pmac.c:702: warning: `return' with no value, in function returning non-void
[...]



--- ppc/pmac.c_old	Thu May 13 19:49:12 2004
+++ ppc/pmac.c	Thu May 13 19:49:57 2004
@@ -699,7 +699,7 @@
 static irqreturn_t
 snd_pmac_tx_intr(int irq, void *devid, struct pt_regs *regs)
 {
-	pmac_t *chip = snd_magic_cast(pmac_t, devid, return);
+	pmac_t *chip = snd_magic_cast(pmac_t, devid, return IRQ_NONE);
 	snd_pmac_pcm_update(chip, &chip->playback);
 	return IRQ_HANDLED;
 }
@@ -708,7 +708,7 @@
 static irqreturn_t
 snd_pmac_rx_intr(int irq, void *devid, struct pt_regs *regs)
 {
-	pmac_t *chip = snd_magic_cast(pmac_t, devid, return);
+	pmac_t *chip = snd_magic_cast(pmac_t, devid, return IRQ_NONE);
 	snd_pmac_pcm_update(chip, &chip->capture);
 	return IRQ_HANDLED;
 }
@@ -717,7 +717,7 @@
 static irqreturn_t
 snd_pmac_ctrl_intr(int irq, void *devid, struct pt_regs *regs)
 {
-	pmac_t *chip = snd_magic_cast(pmac_t, devid, return);
+	pmac_t *chip = snd_magic_cast(pmac_t, devid, return IRQ_NONE);
 	int ctrl = in_le32(&chip->awacs->control);
 
 	/*printk("pmac: control interrupt.. 0x%x\n", ctrl);*/
--- alsa-kernel/ppc/tumbler.c_old	Thu May 13 19:52:20 2004
+++ alsa-kernel/ppc/tumbler.c	Thu May 13 19:52:40 2004
@@ -870,7 +870,7 @@
 /* interrupt - headphone plug changed */
 static irqreturn_t headphone_intr(int irq, void *devid, struct pt_regs *regs)
 {
-	pmac_t *chip = snd_magic_cast(pmac_t, devid, return);
+	pmac_t *chip = snd_magic_cast(pmac_t, devid, return IRQ_NONE);
 	if (chip->update_automute && chip->initialized) {
 		chip->update_automute(chip, 1);
 		return IRQ_HANDLED;


--
Giuliano.



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
