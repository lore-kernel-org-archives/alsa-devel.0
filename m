From: pavel.hofman@ivitera.com
Subject: [PATCH 6/7] Support for multiple external clock types
Date: Wed, 16 Sep 2009 22:25:40 +0200
Message-ID: <1253132741-15688-6-git-send-email-pavel.hofman@ivitera.com>
References: <1253132741-15688-1-git-send-email-pavel.hofman@ivitera.com>
	<1253132741-15688-2-git-send-email-pavel.hofman@ivitera.com>
	<1253132741-15688-3-git-send-email-pavel.hofman@ivitera.com>
	<1253132741-15688-4-git-send-email-pavel.hofman@ivitera.com>
	<1253132741-15688-5-git-send-email-pavel.hofman@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1253132741-15688-5-git-send-email-pavel.hofman@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Pavel Hofman <pavel.hofman@ivitera.com>

* Support for customization of the external clock names
* Adding hooks to playback_pro_open and capture_pro_open, allowing e.g.
  limiting available stream rates to a single value when the external
  clock rate is detected

Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>

diff --git a/pci/ice1712/ice1712.h b/pci/ice1712/ice1712.h
index b31a59d..4615bca 100644
--- a/pci/ice1712/ice1712.h
+++ b/pci/ice1712/ice1712.h
@@ -379,8 +379,11 @@ struct snd_ice1712 {
 	unsigned int (*get_rate)(struct snd_ice1712 *ice);
 	void (*set_rate)(struct snd_ice1712 *ice, unsigned int rate);
 	unsigned char (*set_mclk)(struct snd_ice1712 *ice, unsigned int rate);
-	void (*set_spdif_clock)(struct snd_ice1712 *ice);
-
+	int (*set_spdif_clock)(struct snd_ice1712 *ice, int type);
+	int (*get_spdif_master_type)(struct snd_ice1712 *ice);
+	char **ext_clock_names;
+	int ext_clock_count;
+	void (*pro_open)(struct snd_ice1712 *, struct snd_pcm_substream *);
 #ifdef CONFIG_PM
 	int (*pm_suspend)(struct snd_ice1712 *);
 	int (*pm_resume)(struct snd_ice1712 *);
diff --git a/pci/ice1712/ice1724.c b/pci/ice1712/ice1724.c
index 514e153..3f11195 100644
--- a/pci/ice1712/ice1724.c
+++ b/pci/ice1712/ice1724.c
@@ -104,6 +104,8 @@ static int PRO_RATE_LOCKED;
 static int PRO_RATE_RESET = 1;
 static unsigned int PRO_RATE_DEFAULT = 44100;
 
+static char *ext_clock_names[1] = { "IEC958 In" };
+
 /*
  *  Basic I/O
  */
@@ -1042,6 +1044,8 @@ static int snd_vt1724_playback_pro_open(struct snd_pcm_substream *substream)
 				   VT1724_BUFFER_ALIGN);
 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
 				   VT1724_BUFFER_ALIGN);
+	if (ice->pro_open)
+		ice->pro_open(ice, substream);
 	return 0;
 }
 
@@ -1060,6 +1064,8 @@ static int snd_vt1724_capture_pro_open(struct snd_pcm_substream *substream)
 				   VT1724_BUFFER_ALIGN);
 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
 				   VT1724_BUFFER_ALIGN);
+	if (ice->pro_open)
+		ice->pro_open(ice, substream);
 	return 0;
 }
 
@@ -1813,15 +1819,21 @@ static int snd_vt1724_pro_internal_clock_info(struct snd_kcontrol *kcontrol,
 					      struct snd_ctl_elem_info *uinfo)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
-
+	int hw_rates_count = ice->hw_rates->count;
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
-	uinfo->value.enumerated.items = ice->hw_rates->count + 1;
+
+	uinfo->value.enumerated.items = hw_rates_count + ice->ext_clock_count;
+	/* upper limit - keep at top */
 	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
 		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	if (uinfo->value.enumerated.item == uinfo->value.enumerated.items - 1)
-		strcpy(uinfo->value.enumerated.name, "IEC958 Input");
+	if (uinfo->value.enumerated.item >= hw_rates_count)
+		/* ext_clock items */
+		strcpy(uinfo->value.enumerated.name,
+				ice->ext_clock_names[
+				uinfo->value.enumerated.item - hw_rates_count]);
 	else
+		/* int clock items */
 		sprintf(uinfo->value.enumerated.name, "%d",
 			ice->hw_rates->list[uinfo->value.enumerated.item]);
 	return 0;
@@ -1835,7 +1847,8 @@ static int snd_vt1724_pro_internal_clock_get(struct snd_kcontrol *kcontrol,
 
 	spin_lock_irq(&ice->reg_lock);
 	if (ice->is_spdif_master(ice)) {
-		ucontrol->value.enumerated.item[0] = ice->hw_rates->count;
+		ucontrol->value.enumerated.item[0] = ice->hw_rates->count +
+			ice->get_spdif_master_type(ice);
 	} else {
 		rate = ice->get_rate(ice);
 		ucontrol->value.enumerated.item[0] = 0;
@@ -1850,8 +1863,14 @@ static int snd_vt1724_pro_internal_clock_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int stdclock_get_spdif_master_type(struct snd_ice1712 *ice)
+{
+	/* standard external clock - only single type - SPDIF IN */
+	return 0;
+}
+
 /* setting clock to external - SPDIF */
-static void stdclock_set_spdif_clock(struct snd_ice1712 *ice)
+static int stdclock_set_spdif_clock(struct snd_ice1712 *ice, int type)
 {
 	unsigned char oval;
 	unsigned char i2s_oval;
@@ -1860,27 +1879,30 @@ static void stdclock_set_spdif_clock(struct snd_ice1712 *ice)
 	/* setting 256fs */
 	i2s_oval = inb(ICEMT1724(ice, I2S_FORMAT));
 	outb(i2s_oval & ~VT1724_MT_I2S_MCLK_128X, ICEMT1724(ice, I2S_FORMAT));
+	return 0;
 }
 
+
 static int snd_vt1724_pro_internal_clock_put(struct snd_kcontrol *kcontrol,
 					     struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	unsigned int old_rate, new_rate;
 	unsigned int item = ucontrol->value.enumerated.item[0];
-	unsigned int spdif = ice->hw_rates->count;
+	unsigned int first_ext_clock = ice->hw_rates->count;
 
-	if (item > spdif)
+	if (item >  first_ext_clock + ice->ext_clock_count - 1)
 		return -EINVAL;
 
+	/* if rate = 0 => external clock */
 	spin_lock_irq(&ice->reg_lock);
 	if (ice->is_spdif_master(ice))
 		old_rate = 0;
 	else
 		old_rate = ice->get_rate(ice);
-	if (item == spdif) {
-		/* switching to external clock via SPDIF */
-		ice->set_spdif_clock(ice);
+	if (item >= first_ext_clock) {
+		/* switching to external clock */
+		ice->set_spdif_clock(ice, item - first_ext_clock);
 		new_rate = 0;
 	} else {
 		/* internal on-card clock */
@@ -1892,7 +1914,7 @@ static int snd_vt1724_pro_internal_clock_put(struct snd_kcontrol *kcontrol,
 	}
 	spin_unlock_irq(&ice->reg_lock);
 
-	/* the first reset to the SPDIF master mode? */
+	/* the first switch to the ext. clock mode? */
 	if (old_rate != new_rate && !new_rate) {
 		/* notify akm chips as well */
 		unsigned int i;
@@ -2550,6 +2572,9 @@ static int __devinit snd_vt1724_probe(struct pci_dev *pci,
 		return err;
 	}
 
+	/* field init before calling chip_init */
+	ice->ext_clock_count = 0;
+
 	for (tbl = card_tables; *tbl; tbl++) {
 		for (c = *tbl; c->subvendor; c++) {
 			if (c->subvendor == ice->eeprom.subvendor) {
@@ -2588,6 +2613,13 @@ __found:
 		ice->set_mclk = stdclock_set_mclk;
 	if (!ice->set_spdif_clock)
 		ice->set_spdif_clock = stdclock_set_spdif_clock;
+	if (!ice->get_spdif_master_type)
+		ice->get_spdif_master_type = stdclock_get_spdif_master_type;
+	if (!ice->ext_clock_names)
+		ice->ext_clock_names = ext_clock_names;
+	if (!ice->ext_clock_count)
+		ice->ext_clock_count = ARRAY_SIZE(ext_clock_names);
+
 	if (!ice->hw_rates)
 		set_std_hw_rates(ice);
 
@@ -2747,7 +2779,7 @@ static int snd_vt1724_resume(struct pci_dev *pci)
 
 	if (ice->pm_saved_is_spdif_master) {
 		/* switching to external clock via SPDIF */
-		ice->set_spdif_clock(ice);
+		ice->set_spdif_clock(ice, 0);
 	} else {
 		/* internal on-card clock */
 		snd_vt1724_set_pro_rate(ice, ice->pro_rate_default, 1);
diff --git a/pci/ice1712/juli.c b/pci/ice1712/juli.c
index 4789e8b..4bed963 100644
--- a/pci/ice1712/juli.c
+++ b/pci/ice1712/juli.c
@@ -529,13 +529,14 @@ static inline unsigned char juli_set_mclk(struct snd_ice1712 *ice,
 }
 
 /* setting clock to external - SPDIF */
-static void juli_set_spdif_clock(struct snd_ice1712 *ice)
+static int juli_set_spdif_clock(struct snd_ice1712 *ice, int type)
 {
 	unsigned int old;
 	old = ice->gpio.get_data(ice);
 	/* external clock (= 0), multiply 1x, 48kHz */
 	ice->gpio.set_data(ice, (old & ~GPIO_RATE_MASK) | GPIO_MULTI_1X |
 			GPIO_FREQ_48KHZ);
+	return 0;
 }
 
 /* Called when ak4114 detects change in the input SPDIF stream */
-- 
1.5.6.3
