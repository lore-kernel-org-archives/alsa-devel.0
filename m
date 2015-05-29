From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/10] ALSA: pci: Drop superfluous ifdef
	CONFIG_PROC_FS
Date: Fri, 29 May 2015 08:06:11 +0200
Message-ID: <1432879571-3359-11-git-send-email-tiwai@suse.de>
References: <1432879571-3359-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BCE72666DA
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 08:06:14 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 43491AD5E
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 06:06:14 +0000 (UTC)
In-Reply-To: <1432879571-3359-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The compiler can optimize the unused code away, so we can drop
ifdefs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ak4531_codec.c      | 6 ------
 sound/pci/atiixp.c            | 4 ----
 sound/pci/atiixp_modem.c      | 4 ----
 sound/pci/cmipci.c            | 5 -----
 sound/pci/ice1712/quartet.c   | 7 +------
 sound/pci/intel8x0.c          | 4 ----
 sound/pci/intel8x0m.c         | 5 -----
 sound/pci/oxygen/oxygen_lib.c | 4 ----
 8 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/sound/pci/ak4531_codec.c b/sound/pci/ak4531_codec.c
index 3bf0dc53360a..2fb1fbba3e5e 100644
--- a/sound/pci/ak4531_codec.c
+++ b/sound/pci/ak4531_codec.c
@@ -35,11 +35,7 @@ MODULE_DESCRIPTION("Universal routines for AK4531 codec");
 MODULE_LICENSE("GPL");
 */
 
-#ifdef CONFIG_PROC_FS
 static void snd_ak4531_proc_init(struct snd_card *card, struct snd_ak4531 *ak4531);
-#else
-#define snd_ak4531_proc_init(card,ak)
-#endif
 
 /*
  *
@@ -466,7 +462,6 @@ void snd_ak4531_resume(struct snd_ak4531 *ak4531)
 }
 #endif
 
-#ifdef CONFIG_PROC_FS
 /*
  * /proc interface
  */
@@ -491,4 +486,3 @@ snd_ak4531_proc_init(struct snd_card *card, struct snd_ak4531 *ak4531)
 	if (! snd_card_proc_new(card, "ak4531", &entry))
 		snd_info_set_text_ops(entry, ak4531, snd_ak4531_proc_read);
 }
-#endif
diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index 42a20c806b39..1028fc8bdff5 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -1530,7 +1530,6 @@ static SIMPLE_DEV_PM_OPS(snd_atiixp_pm, snd_atiixp_suspend, snd_atiixp_resume);
 #endif /* CONFIG_PM_SLEEP */
 
 
-#ifdef CONFIG_PROC_FS
 /*
  * proc interface for register dump
  */
@@ -1552,9 +1551,6 @@ static void snd_atiixp_proc_init(struct atiixp *chip)
 	if (! snd_card_proc_new(chip->card, "atiixp", &entry))
 		snd_info_set_text_ops(entry, chip, snd_atiixp_proc_read);
 }
-#else /* !CONFIG_PROC_FS */
-#define snd_atiixp_proc_init(chip)
-#endif
 
 
 /*
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index 0a38e08164ab..27ed678a46df 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -1156,7 +1156,6 @@ static SIMPLE_DEV_PM_OPS(snd_atiixp_pm, snd_atiixp_suspend, snd_atiixp_resume);
 #define SND_ATIIXP_PM_OPS	NULL
 #endif /* CONFIG_PM_SLEEP */
 
-#ifdef CONFIG_PROC_FS
 /*
  * proc interface for register dump
  */
@@ -1178,9 +1177,6 @@ static void snd_atiixp_proc_init(struct atiixp_modem *chip)
 	if (! snd_card_proc_new(chip->card, "atiixp-modem", &entry))
 		snd_info_set_text_ops(entry, chip, snd_atiixp_proc_read);
 }
-#else
-#define snd_atiixp_proc_init(chip)
-#endif
 
 
 /*
diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 6cf464d9043d..24cdcba06d27 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -2772,7 +2772,6 @@ static int snd_cmipci_mixer_new(struct cmipci *cm, int pcm_spdif_device)
  * proc interface
  */
 
-#ifdef CONFIG_PROC_FS
 static void snd_cmipci_proc_read(struct snd_info_entry *entry, 
 				 struct snd_info_buffer *buffer)
 {
@@ -2798,10 +2797,6 @@ static void snd_cmipci_proc_init(struct cmipci *cm)
 	if (! snd_card_proc_new(cm->card, "cmipci", &entry))
 		snd_info_set_text_ops(entry, cm, snd_cmipci_proc_read);
 }
-#else /* !CONFIG_PROC_FS */
-static inline void snd_cmipci_proc_init(struct cmipci *cm) {}
-#endif
-
 
 static const struct pci_device_id snd_cmipci_ids[] = {
 	{PCI_VDEVICE(CMEDIA, PCI_DEVICE_ID_CMEDIA_CM8338A), 0},
diff --git a/sound/pci/ice1712/quartet.c b/sound/pci/ice1712/quartet.c
index 6f55e02e5c84..7c387b04067e 100644
--- a/sound/pci/ice1712/quartet.c
+++ b/sound/pci/ice1712/quartet.c
@@ -203,7 +203,6 @@ static const char * const ext_clock_names[3] = {"IEC958 In", "Word Clock 1xFS",
 #define AK4620_DEEMVOL_REG	0x03
 #define AK4620_SMUTE		(1<<7)
 
-#ifdef CONFIG_PROC_FS
 /*
  * Conversion from int value to its binary form. Used for debugging.
  * The output buffer must be allocated prior to calling the function.
@@ -228,7 +227,6 @@ static char *get_binary(char *buffer, int value)
 	buffer[pos] = '\0';
 	return buffer;
 }
-#endif /* CONFIG_PROC_FS */
 
 /*
  * Initial setup of the conversion array GPIO <-> rate
@@ -486,7 +484,7 @@ static void set_cpld(struct snd_ice1712 *ice, unsigned int val)
 	reg_write(ice, GPIO_CPLD_CSN, val);
 	spec->cpld = val;
 }
-#ifdef CONFIG_PROC_FS
+
 static void proc_regs_read(struct snd_info_entry *entry,
 		struct snd_info_buffer *buffer)
 {
@@ -507,9 +505,6 @@ static void proc_init(struct snd_ice1712 *ice)
 	if (!snd_card_proc_new(ice->card, "quartet", &entry))
 		snd_info_set_text_ops(entry, ice, proc_regs_read);
 }
-#else /* !CONFIG_PROC_FS */
-static void proc_init(struct snd_ice1712 *ice) {}
-#endif
 
 static int qtet_mute_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index b120925223ae..42bcbac801a3 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -2900,7 +2900,6 @@ static int intel8x0_in_clock_list(struct intel8x0 *chip)
 	return 1;
 }
 
-#ifdef CONFIG_PROC_FS
 static void snd_intel8x0_proc_read(struct snd_info_entry * entry,
 				   struct snd_info_buffer *buffer)
 {
@@ -2942,9 +2941,6 @@ static void snd_intel8x0_proc_init(struct intel8x0 *chip)
 	if (! snd_card_proc_new(chip->card, "intel8x0", &entry))
 		snd_info_set_text_ops(entry, chip, snd_intel8x0_proc_read);
 }
-#else
-#define snd_intel8x0_proc_init(x)
-#endif
 
 static int snd_intel8x0_dev_free(struct snd_device *device)
 {
diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index 7577f31cd504..1bc98c867133 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -1065,7 +1065,6 @@ static SIMPLE_DEV_PM_OPS(intel8x0m_pm, intel8x0m_suspend, intel8x0m_resume);
 #define INTEL8X0M_PM_OPS	NULL
 #endif /* CONFIG_PM_SLEEP */
 
-#ifdef CONFIG_PROC_FS
 static void snd_intel8x0m_proc_read(struct snd_info_entry * entry,
 				   struct snd_info_buffer *buffer)
 {
@@ -1093,10 +1092,6 @@ static void snd_intel8x0m_proc_init(struct intel8x0m *chip)
 	if (! snd_card_proc_new(chip->card, "intel8x0m", &entry))
 		snd_info_set_text_ops(entry, chip, snd_intel8x0m_proc_read);
 }
-#else /* !CONFIG_PROC_FS */
-#define snd_intel8x0m_proc_init(chip)
-#endif /* CONFIG_PROC_FS */
-
 
 static int snd_intel8x0m_dev_free(struct snd_device *device)
 {
diff --git a/sound/pci/oxygen/oxygen_lib.c b/sound/pci/oxygen/oxygen_lib.c
index ffff3b25fd73..b4ef5804212d 100644
--- a/sound/pci/oxygen/oxygen_lib.c
+++ b/sound/pci/oxygen/oxygen_lib.c
@@ -196,7 +196,6 @@ static void oxygen_gpio_changed(struct work_struct *work)
 		chip->model.gpio_changed(chip);
 }
 
-#ifdef CONFIG_PROC_FS
 static void oxygen_proc_read(struct snd_info_entry *entry,
 			     struct snd_info_buffer *buffer)
 {
@@ -250,9 +249,6 @@ static void oxygen_proc_init(struct oxygen *chip)
 	if (!snd_card_proc_new(chip->card, "oxygen", &entry))
 		snd_info_set_text_ops(entry, chip, oxygen_proc_read);
 }
-#else
-#define oxygen_proc_init(chip)
-#endif
 
 static const struct pci_device_id *
 oxygen_search_pci_id(struct oxygen *chip, const struct pci_device_id ids[])
-- 
2.4.2
