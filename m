From: syrjala@sci.fi
Subject: [PATCH] es1968: Fix hw volume
Date: Sun, 03 Sep 2006 05:08:14 +0300
Message-ID: <20060903020813.927109140@proteus.korsu.shacknet.nu>
Content-Type: multipart/mixed; boundary="===============1619446385=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Ville Syrjala <syrjala@sci.fi>
List-Id: alsa-devel@alsa-project.org

--===============1619446385==
Content-Disposition: inline; filename=es1968_fix_hw_volume.patch

Fix maestro2 hardware volume control. Tested on a Dell Inspiron 7000.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 sound/pci/es1968.c |   40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

Index: linux-2.6.18-rc5-vs/sound/pci/es1968.c
===================================================================
--- linux-2.6.18-rc5-vs.orig/sound/pci/es1968.c
+++ linux-2.6.18-rc5-vs/sound/pci/es1968.c
@@ -1905,7 +1905,7 @@ static void es1968_update_hw_volume(unsi
 	/* Figure out which volume control button was pushed,
 	   based on differences from the default register
 	   values. */
-	x = inb(chip->io_port + 0x1c);
+	x = inb(chip->io_port + 0x1c) & 0xee;
 	/* Reset the volume control registers. */
 	outb(0x88, chip->io_port + 0x1c);
 	outb(0x88, chip->io_port + 0x1d);
@@ -1921,7 +1921,8 @@ static void es1968_update_hw_volume(unsi
 	/* FIXME: we can't call snd_ac97_* functions since here is in tasklet. */
 	spin_lock_irqsave(&chip->ac97_lock, flags);
 	val = chip->ac97->regs[AC97_MASTER];
-	if (x & 1) {
+	switch (x) {
+	case 0x88:
 		/* mute */
 		val ^= 0x8000;
 		chip->ac97->regs[AC97_MASTER] = val;
@@ -1929,26 +1930,31 @@ static void es1968_update_hw_volume(unsi
 		outb(AC97_MASTER, chip->io_port + ESM_AC97_INDEX);
 		snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
 			       &chip->master_switch->id);
-	} else {
-		val &= 0x7fff;
-		if (((x>>1) & 7) > 4) {
-			/* volume up */
-			if ((val & 0xff) > 0)
-				val--;
-			if ((val & 0xff00) > 0)
-				val -= 0x0100;
-		} else {
-			/* volume down */
-			if ((val & 0xff) < 0x1f)
-				val++;
-			if ((val & 0xff00) < 0x1f00)
-				val += 0x0100;
-		}
+		break;
+	case 0xaa:
+		/* volume up */
+		if ((val & 0x7f) > 0)
+			val--;
+		if ((val & 0x7f00) > 0)
+			val -= 0x0100;
 		chip->ac97->regs[AC97_MASTER] = val;
 		outw(val, chip->io_port + ESM_AC97_DATA);
 		outb(AC97_MASTER, chip->io_port + ESM_AC97_INDEX);
 		snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
 			       &chip->master_volume->id);
+		break;
+	case 0x66:
+		/* volume down */
+		if ((val & 0x7f) < 0x1f)
+			val++;
+		if ((val & 0x7f00) < 0x1f00)
+			val += 0x0100;
+		chip->ac97->regs[AC97_MASTER] = val;
+		outw(val, chip->io_port + ESM_AC97_DATA);
+		outb(AC97_MASTER, chip->io_port + ESM_AC97_INDEX);
+		snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &chip->master_volume->id);
+		break;
 	}
 	spin_unlock_irqrestore(&chip->ac97_lock, flags);
 }

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/


--===============1619446385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1619446385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1619446385==--
