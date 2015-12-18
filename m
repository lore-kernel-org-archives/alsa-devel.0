From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/4] ALSA: fm801: convert rest outw() /
	inw() to use helpers
Date: Fri, 18 Dec 2015 21:14:11 +0200
Message-ID: <1450466053-52170-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1450466053-52170-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E43382605BB
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 20:14:18 +0100 (CET)
In-Reply-To: <1450466053-52170-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Andy Shevchenko <andy.shevchenko@gmail.com>

The patch introduces two new helpers fm801_iowrite16() and fm801_ioread16() to
write and read the registers by offset. Previously similar was done to access
the hardware registers by their names.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 sound/pci/fm801.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index f57847c..c2afb41 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -212,6 +212,20 @@ struct fm801 {
 #endif
 };
 
+/*
+ * IO accessors
+ */
+
+static inline void fm801_iowrite16(struct fm801 *chip, unsigned short offset, u16 value)
+{
+	outw(value, chip->port + offset);
+}
+
+static inline u16 fm801_ioread16(struct fm801 *chip, unsigned short offset)
+{
+	return inw(chip->port + offset);
+}
+
 static const struct pci_device_id snd_fm801_ids[] = {
 	{ 0x1319, 0x0801, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_MULTIMEDIA_AUDIO << 8, 0xffff00, 0, },   /* FM801 */
 	{ 0x5213, 0x0510, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_MULTIMEDIA_AUDIO << 8, 0xffff00, 0, },   /* Gallant Odyssey Sound 4 */
@@ -256,11 +270,11 @@ static int snd_fm801_update_bits(struct fm801 *chip, unsigned short reg,
 	unsigned short old, new;
 
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	old = inw(chip->port + reg);
+	old = fm801_ioread16(chip, reg);
 	new = (old & ~mask) | value;
 	change = old != new;
 	if (change)
-		outw(new, chip->port + reg);
+		fm801_iowrite16(chip, reg, new);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	return change;
 }
@@ -851,10 +865,11 @@ static int snd_fm801_get_single(struct snd_kcontrol *kcontrol,
 	int shift = (kcontrol->private_value >> 8) & 0xff;
 	int mask = (kcontrol->private_value >> 16) & 0xff;
 	int invert = (kcontrol->private_value >> 24) & 0xff;
+	long *value = ucontrol->value.integer.value;
 
-	ucontrol->value.integer.value[0] = (inw(chip->port + reg) >> shift) & mask;
+	value[0] = (fm801_ioread16(chip, reg) >> shift) & mask;
 	if (invert)
-		ucontrol->value.integer.value[0] = mask - ucontrol->value.integer.value[0];
+		value[0] = mask - value[0];
 	return 0;
 }
 
@@ -907,14 +922,15 @@ static int snd_fm801_get_double(struct snd_kcontrol *kcontrol,
 	int shift_right = (kcontrol->private_value >> 12) & 0x0f;
 	int mask = (kcontrol->private_value >> 16) & 0xff;
 	int invert = (kcontrol->private_value >> 24) & 0xff;
+	long *value = ucontrol->value.integer.value;
 
 	spin_lock_irq(&chip->reg_lock);
-	ucontrol->value.integer.value[0] = (inw(chip->port + reg) >> shift_left) & mask;
-	ucontrol->value.integer.value[1] = (inw(chip->port + reg) >> shift_right) & mask;
+	value[0] = (fm801_ioread16(chip, reg) >> shift_left) & mask;
+	value[1] = (fm801_ioread16(chip, reg) >> shift_right) & mask;
 	spin_unlock_irq(&chip->reg_lock);
 	if (invert) {
-		ucontrol->value.integer.value[0] = mask - ucontrol->value.integer.value[0];
-		ucontrol->value.integer.value[1] = mask - ucontrol->value.integer.value[1];
+		value[0] = mask - value[0];
+		value[1] = mask - value[1];
 	}
 	return 0;
 }
@@ -1372,7 +1388,7 @@ static int snd_fm801_suspend(struct device *dev)
 	snd_ac97_suspend(chip->ac97);
 	snd_ac97_suspend(chip->ac97_sec);
 	for (i = 0; i < ARRAY_SIZE(saved_regs); i++)
-		chip->saved_regs[i] = inw(chip->port + saved_regs[i]);
+		chip->saved_regs[i] = fm801_ioread16(chip, saved_regs[i]);
 	/* FIXME: tea575x suspend */
 	return 0;
 }
@@ -1387,7 +1403,7 @@ static int snd_fm801_resume(struct device *dev)
 	snd_ac97_resume(chip->ac97);
 	snd_ac97_resume(chip->ac97_sec);
 	for (i = 0; i < ARRAY_SIZE(saved_regs); i++)
-		outw(chip->saved_regs[i], chip->port + saved_regs[i]);
+		fm801_iowrite16(chip, saved_regs[i], chip->saved_regs[i]);
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
 	return 0;
-- 
2.6.4
