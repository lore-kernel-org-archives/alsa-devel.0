From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] sound/pci/ymfpci/ymfpci_main.c: remove dead code
Date: Sun, 10 Apr 2005 01:12:11 +0200
Message-ID: <20050409231211.GT3632@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id A5817236
	for <alsa-devel@alsa-project.org>; Sun, 10 Apr 2005 01:12:12 +0200 (MEST)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch removes some dead code found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 sound/pci/ymfpci/ymfpci_main.c |   31 ++++++++-----------------------
 1 files changed, 8 insertions(+), 23 deletions(-)

--- linux-2.6.12-rc2-mm2-full/sound/pci/ymfpci/ymfpci_main.c.old	2005-04-09 22:22:16.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/sound/pci/ymfpci/ymfpci_main.c	2005-04-09 22:38:00.000000000 +0200
@@ -1418,44 +1418,40 @@
   .private_value = reg }
 
 static int snd_ymfpci_info_single(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
-	unsigned int mask = 1;
-
 	switch (kcontrol->private_value) {
 	case YDSXGR_SPDIFOUTCTRL: break;
 	case YDSXGR_SPDIFINCTRL: break;
 	default: return -EINVAL;
 	}
-	uinfo->type = mask == 1 ? SNDRV_CTL_ELEM_TYPE_BOOLEAN : SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	uinfo->count = 1;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = mask;
+	uinfo->value.integer.max = 1;
 	return 0;
 }
 
 static int snd_ymfpci_get_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	ymfpci_t *chip = snd_kcontrol_chip(kcontrol);
 	int reg = kcontrol->private_value;
-	unsigned int shift = 0, mask = 1, invert = 0;
+	unsigned int shift = 0, mask = 1;
 	
 	switch (kcontrol->private_value) {
 	case YDSXGR_SPDIFOUTCTRL: break;
 	case YDSXGR_SPDIFINCTRL: break;
 	default: return -EINVAL;
 	}
 	ucontrol->value.integer.value[0] = (snd_ymfpci_readl(chip, reg) >> shift) & mask;
-	if (invert)
-		ucontrol->value.integer.value[0] = mask - ucontrol->value.integer.value[0];
 	return 0;
 }
 
 static int snd_ymfpci_put_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	ymfpci_t *chip = snd_kcontrol_chip(kcontrol);
 	int reg = kcontrol->private_value;
-	unsigned int shift = 0, mask = 1, invert = 0;
+	unsigned int shift = 0, mask = 1;
 	int change;
 	unsigned int val, oval;
 	
 	switch (kcontrol->private_value) {
@@ -1463,10 +1459,8 @@
 	case YDSXGR_SPDIFINCTRL: break;
 	default: return -EINVAL;
 	}
 	val = (ucontrol->value.integer.value[0] & mask);
-	if (invert)
-		val = mask - val;
 	val <<= shift;
 	spin_lock_irq(&chip->reg_lock);
 	oval = snd_ymfpci_readl(chip, reg);
 	val = (oval & ~(mask << shift)) | val;
@@ -1484,24 +1478,23 @@
 
 static int snd_ymfpci_info_double(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
 	unsigned int reg = kcontrol->private_value;
-	unsigned int mask = 16383;
 
 	if (reg < 0x80 || reg >= 0xc0)
 		return -EINVAL;
-	uinfo->type = mask == 1 ? SNDRV_CTL_ELEM_TYPE_BOOLEAN : SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 2;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = mask;
+	uinfo->value.integer.max = 16383;
 	return 0;
 }
 
 static int snd_ymfpci_get_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	ymfpci_t *chip = snd_kcontrol_chip(kcontrol);
 	unsigned int reg = kcontrol->private_value;
-	unsigned int shift_left = 0, shift_right = 16, mask = 16383, invert = 0;
+	unsigned int shift_left = 0, shift_right = 16, mask = 16383;
 	unsigned int val;
 	
 	if (reg < 0x80 || reg >= 0xc0)
 		return -EINVAL;
@@ -1509,31 +1502,23 @@
 	val = snd_ymfpci_readl(chip, reg);
 	spin_unlock_irq(&chip->reg_lock);
 	ucontrol->value.integer.value[0] = (val >> shift_left) & mask;
 	ucontrol->value.integer.value[1] = (val >> shift_right) & mask;
-	if (invert) {
-		ucontrol->value.integer.value[0] = mask - ucontrol->value.integer.value[0];
-		ucontrol->value.integer.value[1] = mask - ucontrol->value.integer.value[1];
-	}
 	return 0;
 }
 
 static int snd_ymfpci_put_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	ymfpci_t *chip = snd_kcontrol_chip(kcontrol);
 	unsigned int reg = kcontrol->private_value;
-	unsigned int shift_left = 0, shift_right = 16, mask = 16383, invert = 0;
+	unsigned int shift_left = 0, shift_right = 16, mask = 16383;
 	int change;
 	unsigned int val1, val2, oval;
 	
 	if (reg < 0x80 || reg >= 0xc0)
 		return -EINVAL;
 	val1 = ucontrol->value.integer.value[0] & mask;
 	val2 = ucontrol->value.integer.value[1] & mask;
-	if (invert) {
-		val1 = mask - val1;
-		val2 = mask - val2;
-	}
 	val1 <<= shift_left;
 	val2 <<= shift_right;
 	spin_lock_irq(&chip->reg_lock);
 	oval = snd_ymfpci_readl(chip, reg);



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
