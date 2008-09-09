From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 20/24] sound/pci: coding style fixes: sonicvibes
Date: Tue, 9 Sep 2008 06:01:07 +0400
Message-ID: <20080909020107.GW6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 56EFE103842
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 04:01:13 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 21so727147eyc.56
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 19:01:12 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



- <asm/io.h> -> <linux/io.h>
- remove trailing whitespaces
- convert comments

Only compile tested.

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 sound/pci/sonicvibes.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index cd408b8..e6ed3a2 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -39,7 +39,7 @@
 #include <sound/opl3.h>
 #include <sound/initval.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("S3 SonicVibes PCI");
@@ -523,7 +523,7 @@ static int snd_sonicvibes_hw_constraint_dac_rate(struct snd_pcm_hw_params *param
 {
 	unsigned int rate, div, r, m, n;
 
-	if (hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE)->min == 
+	if (hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE)->min ==
 	    hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE)->max) {
 		rate = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE)->min;
 		div = 48000 / rate;
@@ -895,7 +895,7 @@ static int snd_sonicvibes_info_mux(struct snd_kcontrol *kcontrol, struct snd_ctl
 static int snd_sonicvibes_get_mux(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct sonicvibes *sonic = snd_kcontrol_chip(kcontrol);
-	
+
 	spin_lock_irq(&sonic->reg_lock);
 	ucontrol->value.enumerated.item[0] = ((snd_sonicvibes_in1(sonic, SV_IREG_LEFT_ADC) & SV_RECSRC_OUT) >> 5) - 1;
 	ucontrol->value.enumerated.item[1] = ((snd_sonicvibes_in1(sonic, SV_IREG_RIGHT_ADC) & SV_RECSRC_OUT) >> 5) - 1;
@@ -908,7 +908,7 @@ static int snd_sonicvibes_put_mux(struct snd_kcontrol *kcontrol, struct snd_ctl_
 	struct sonicvibes *sonic = snd_kcontrol_chip(kcontrol);
 	unsigned short left, right, oval1, oval2;
 	int change;
-	
+
 	if (ucontrol->value.enumerated.item[0] >= 7 ||
 	    ucontrol->value.enumerated.item[1] >= 7)
 		return -EINVAL;
@@ -950,7 +950,7 @@ static int snd_sonicvibes_get_single(struct snd_kcontrol *kcontrol, struct snd_c
 	int shift = (kcontrol->private_value >> 8) & 0xff;
 	int mask = (kcontrol->private_value >> 16) & 0xff;
 	int invert = (kcontrol->private_value >> 24) & 0xff;
-	
+
 	spin_lock_irq(&sonic->reg_lock);
 	ucontrol->value.integer.value[0] = (snd_sonicvibes_in1(sonic, reg)>> shift) & mask;
 	spin_unlock_irq(&sonic->reg_lock);
@@ -968,7 +968,7 @@ static int snd_sonicvibes_put_single(struct snd_kcontrol *kcontrol, struct snd_c
 	int invert = (kcontrol->private_value >> 24) & 0xff;
 	int change;
 	unsigned short val, oval;
-	
+
 	val = (ucontrol->value.integer.value[0] & mask);
 	if (invert)
 		val = mask - val;
@@ -1008,7 +1008,7 @@ static int snd_sonicvibes_get_double(struct snd_kcontrol *kcontrol, struct snd_c
 	int shift_right = (kcontrol->private_value >> 19) & 0x07;
 	int mask = (kcontrol->private_value >> 24) & 0xff;
 	int invert = (kcontrol->private_value >> 22) & 1;
-	
+
 	spin_lock_irq(&sonic->reg_lock);
 	ucontrol->value.integer.value[0] = (snd_sonicvibes_in1(sonic, left_reg) >> shift_left) & mask;
 	ucontrol->value.integer.value[1] = (snd_sonicvibes_in1(sonic, right_reg) >> shift_right) & mask;
@@ -1031,7 +1031,7 @@ static int snd_sonicvibes_put_double(struct snd_kcontrol *kcontrol, struct snd_c
 	int invert = (kcontrol->private_value >> 22) & 1;
 	int change;
 	unsigned short val1, val2, oval1, oval2;
-	
+
 	val1 = ucontrol->value.integer.value[0] & mask;
 	val2 = ucontrol->value.integer.value[1] & mask;
 	if (invert) {
@@ -1110,7 +1110,7 @@ static int __devinit snd_sonicvibes_mixer(struct sonicvibes * sonic)
 
  */
 
-static void snd_sonicvibes_proc_read(struct snd_info_entry *entry, 
+static void snd_sonicvibes_proc_read(struct snd_info_entry *entry,
 				     struct snd_info_buffer *buffer)
 {
 	struct sonicvibes *sonic = entry->private_data;
@@ -1144,7 +1144,7 @@ static void __devinit snd_sonicvibes_proc_init(struct sonicvibes * sonic)
 {
 	struct snd_info_entry *entry;
 
-	if (! snd_card_proc_new(sonic->card, "sonicvibes", &entry))
+	if (!snd_card_proc_new(sonic->card, "sonicvibes", &entry))
 		snd_info_set_text_ops(entry, sonic, snd_sonicvibes_proc_read);
 }
 
@@ -1422,7 +1422,7 @@ static int __devinit snd_sonic_probe(struct pci_dev *pci,
 		dev++;
 		return -ENOENT;
 	}
- 
+
 	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
 	if (card == NULL)
 		return -ENOMEM;
@@ -1482,7 +1482,7 @@ static int __devinit snd_sonic_probe(struct pci_dev *pci,
 		snd_card_free(card);
 		return err;
 	}
-	
+
 	pci_set_drvdata(pci, card);
 	dev++;
 	return 0;
