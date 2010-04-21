From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/3] snd-meastro3: Document hardware volume
	control a bit
Date: Wed, 21 Apr 2010 08:15:27 -0400
Message-ID: <1271852128-4638-2-git-send-email-hdegoede@redhat.com>
References: <1271852128-4638-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1271852128-4638-1-git-send-email-hdegoede@redhat.com>
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
Cc: Hans de Goede <hdegoede@redhat.com>
List-Id: alsa-devel@alsa-project.org

While working on a fix for the volume being muted on the allegro in my
Compaq EVO N600C after suspend, I've learned a few things about the hardware
volume control worth documenting. The actual fix for the suspend / resume
issue is in the next patch in this set.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/pci/maestro3.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index 491a2fc..c6593cf 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -1597,6 +1597,10 @@ static void snd_m3_update_ptr(struct snd_m3 *chip, struct m3_dma *s)
 	}
 }
 
+/* The m3's hardware volume works by incrementing / decrementing 2 counters
+   (without wrap around) in response to volume button presses and then
+   generating an interrupt. The pair of counters is stored in bits 1-3 and 5-7
+   of a byte wide register. The meaning of bits 0 and 4 is unknown. */
 static void snd_m3_update_hw_volume(unsigned long private_data)
 {
 	struct snd_m3 *chip = (struct snd_m3 *) private_data;
@@ -1608,7 +1612,15 @@ static void snd_m3_update_hw_volume(unsigned long private_data)
 	   values. */
 	x = inb(chip->iobase + SHADOW_MIX_REG_VOICE) & 0xee;
 
-	/* Reset the volume control registers. */
+	/* Reset the volume counters to 4. Tests on the allegro integrated
+	   into a Compaq N600C laptop, have revealed that:
+	   1) Writing any value will result in the 2 counters being reset to
+	      4 so writing 0x88 is not strictly necessary
+	   2) Writing to any of the 4 involved registers will reset all 4
+	      of them (and reading them always returns the same value for all
+	      of them)
+	   It could be that a maestro deviates from this, so leave the code
+	   as is. */
 	outb(0x88, chip->iobase + SHADOW_MIX_REG_VOICE);
 	outb(0x88, chip->iobase + HW_VOL_COUNTER_VOICE);
 	outb(0x88, chip->iobase + SHADOW_MIX_REG_MASTER);
@@ -1623,7 +1635,9 @@ static void snd_m3_update_hw_volume(unsigned long private_data)
 	val = chip->ac97->regs[AC97_MASTER_VOL];
 	switch (x) {
 	case 0x88:
-		/* mute */
+		/* The counters have not changed, yet we've received a HV
+		   interrupt. According to tests run by various people this
+		   happens when pressing the mute button. */
 		val ^= 0x8000;
 		chip->ac97->regs[AC97_MASTER_VOL] = val;
 		outw(val, chip->iobase + CODEC_DATA);
@@ -1632,7 +1646,7 @@ static void snd_m3_update_hw_volume(unsigned long private_data)
 			       &chip->master_switch->id);
 		break;
 	case 0xaa:
-		/* volume up */
+		/* counters increased by 1 -> volume up */
 		if ((val & 0x7f) > 0)
 			val--;
 		if ((val & 0x7f00) > 0)
@@ -1644,7 +1658,7 @@ static void snd_m3_update_hw_volume(unsigned long private_data)
 			       &chip->master_volume->id);
 		break;
 	case 0x66:
-		/* volume down */
+		/* counters decreased by 1 -> volume down */
 		if ((val & 0x7f) < 0x1f)
 			val++;
 		if ((val & 0x7f00) < 0x1f00)
-- 
1.7.0.1

