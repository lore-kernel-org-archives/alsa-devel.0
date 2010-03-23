From: Bernhard Urban <lewurm@gmail.com>
Subject: [PATCH] ALSA: aureon - Patch for suspend/resume for
	Terratec Aureon cards.
Date: Tue, 23 Mar 2010 04:12:38 +0100
Message-ID: <1269313958-25984-1-git-send-email-lewurm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f220.google.com (mail-fx0-f220.google.com
	[209.85.220.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 421621037F8
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2010 04:12:03 +0100 (CET)
Received: by fxm20 with SMTP id 20so7790730fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2010 20:12:01 -0700 (PDT)
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
Cc: Bernhard Urban <lewurm@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add proper suspend/resume code for Terratec Aureon cards.
Based on ice1724 suspend/resume work of Igor Chernyshev.
Fixes bug https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4944
Tested on linux-2.6.32.9

Signed-off-by: Bernhard Urban <lewurm@gmail.com>
---
 sound/pci/ice1712/aureon.c |   90 +++++++++++++++++++++++++++++++------------
 1 files changed, 65 insertions(+), 25 deletions(-)

diff --git a/sound/pci/ice1712/aureon.c b/sound/pci/ice1712/aureon.c
index 110d16e..1772e1a 100644
--- a/sound/pci/ice1712/aureon.c
+++ b/sound/pci/ice1712/aureon.c
@@ -1971,11 +1971,10 @@ static int __devinit aureon_add_controls(struct snd_ice1712 *ice)
 	return 0;
 }
 
-
 /*
- * initialize the chip
+ * reset the chip
  */
-static int __devinit aureon_init(struct snd_ice1712 *ice)
+static int aureon_reset(struct snd_ice1712 *ice)
 {
 	static const unsigned short wm_inits_aureon[] = {
 		/* These come first to reduce init pop noise */
@@ -2062,30 +2061,10 @@ static int __devinit aureon_init(struct snd_ice1712 *ice)
 		0x0605, /* slave, 24bit, MSB on second OSCLK, SDOUT for right channel when OLRCK is high */
 		(unsigned short)-1
 	};
-	struct aureon_spec *spec;
 	unsigned int tmp;
 	const unsigned short *p;
-	int err, i;
-
-	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
-	if (!spec)
-		return -ENOMEM;
-	ice->spec = spec;
-
-	if (ice->eeprom.subvendor == VT1724_SUBDEVICE_AUREON51_SKY) {
-		ice->num_total_dacs = 6;
-		ice->num_total_adcs = 2;
-	} else {
-		/* aureon 7.1 and prodigy 7.1 */
-		ice->num_total_dacs = 8;
-		ice->num_total_adcs = 2;
-	}
-
-	/* to remeber the register values of CS8415 */
-	ice->akm = kzalloc(sizeof(struct snd_akm4xxx), GFP_KERNEL);
-	if (!ice->akm)
-		return -ENOMEM;
-	ice->akm_codecs = 1;
+	int err;
+	struct aureon_spec *spec = ice->spec;
 
 	err = aureon_ac97_init(ice);
 	if (err != 0)
@@ -2133,6 +2112,62 @@ static int __devinit aureon_init(struct snd_ice1712 *ice)
 	/* initialize PCA9554 pin directions & set default input */
 	aureon_pca9554_write(ice, PCA9554_DIR, 0x00);
 	aureon_pca9554_write(ice, PCA9554_OUT, 0x00);   /* internal AUX */
+	return 0;
+}
+
+/*
+ * suspend/resume
+ */
+#ifdef CONFIG_PM
+static int aureon_resume(struct snd_ice1712 *ice)
+{
+	struct aureon_spec *spec = ice->spec;
+	int err, i;
+
+	err = aureon_reset(ice);
+	if (err != 0)
+		return err;
+
+	/* workaround for poking volume with alsamixer after resume:
+	 * just set stored volume again */
+	for (i = 0; i < ice->num_total_dacs; i++) {
+		wm_set_vol(ice, i, spec->vol[i], spec->master[i % 2]);
+	}
+	return 0;
+}
+#endif
+
+/*
+ * initialize the chip
+ */
+static int __devinit aureon_init(struct snd_ice1712 *ice)
+{
+	struct aureon_spec *spec;
+	int i, err;
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+	ice->spec = spec;
+
+	if (ice->eeprom.subvendor == VT1724_SUBDEVICE_AUREON51_SKY) {
+		ice->num_total_dacs = 6;
+		ice->num_total_adcs = 2;
+	} else {
+		/* aureon 7.1 and prodigy 7.1 */
+		ice->num_total_dacs = 8;
+		ice->num_total_adcs = 2;
+	}
+
+	/* to remeber the register values of CS8415 */
+	ice->akm = kzalloc(sizeof(struct snd_akm4xxx), GFP_KERNEL);
+	if (!ice->akm)
+		return -ENOMEM;
+	ice->akm_codecs = 1;
+
+	err = aureon_reset(ice);
+	if (err != 0)
+		return err;
 
 	spec->master[0] = WM_VOL_MUTE;
 	spec->master[1] = WM_VOL_MUTE;
@@ -2141,6 +2176,11 @@ static int __devinit aureon_init(struct snd_ice1712 *ice)
 		wm_set_vol(ice, i, spec->vol[i], spec->master[i % 2]);
 	}
 
+#ifdef CONFIG_PM
+	ice->pm_resume = aureon_resume;
+	ice->pm_suspend_enabled = 1;
+#endif
+
 	return 0;
 }
 
-- 
1.7.0.1
