From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: vx222: Use container_of()
Date: Mon, 15 May 2017 11:29:03 +0200
Message-ID: <20170515092905.20381-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 86B49266587
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 11:29:09 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 2D8BCAAB2
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 09:29:09 +0000 (UTC)
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

The vx222 driver is using the explicit cast from the parent class
pointer, but it'll be broken when the structure field randomization is
applied.  Use container_of() in a modern manner, instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/vx222/vx222.c     |  4 ++--
 sound/pci/vx222/vx222.h     |  2 ++
 sound/pci/vx222/vx222_ops.c | 26 +++++++++++++-------------
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/sound/pci/vx222/vx222.c b/sound/pci/vx222/vx222.c
index ecbaf473fc1e..55861849d7df 100644
--- a/sound/pci/vx222/vx222.c
+++ b/sound/pci/vx222/vx222.c
@@ -116,7 +116,7 @@ static struct snd_vx_hardware vx222_mic_hw = {
  */
 static int snd_vx222_free(struct vx_core *chip)
 {
-	struct snd_vx222 *vx = (struct snd_vx222 *)chip;
+	struct snd_vx222 *vx = to_vx222(chip);
 
 	if (chip->irq >= 0)
 		free_irq(chip->irq, (void*)chip);
@@ -158,7 +158,7 @@ static int snd_vx222_create(struct snd_card *card, struct pci_dev *pci,
 		pci_disable_device(pci);
 		return -ENOMEM;
 	}
-	vx = (struct snd_vx222 *)chip;
+	vx = to_vx222(chip);
 	vx->pci = pci;
 
 	if ((err = pci_request_regions(pci, CARD_NAME)) < 0) {
diff --git a/sound/pci/vx222/vx222.h b/sound/pci/vx222/vx222.h
index 2f0d78f609a6..cae355c8ed28 100644
--- a/sound/pci/vx222/vx222.h
+++ b/sound/pci/vx222/vx222.h
@@ -39,6 +39,8 @@ struct snd_vx222 {
 	int mic_level;		/* mic level for vx222 mic */
 };
 
+#define to_vx222(x)	container_of(x, struct snd_vx222, core)
+
 /* we use a lookup table with 148 values, see vx_mixer.c */
 #define VX2_AKM_LEVEL_MAX	0x93
 
diff --git a/sound/pci/vx222/vx222_ops.c b/sound/pci/vx222/vx222_ops.c
index 7df1663ea510..d4298af6d3ee 100644
--- a/sound/pci/vx222/vx222_ops.c
+++ b/sound/pci/vx222/vx222_ops.c
@@ -86,7 +86,7 @@ static int vx2_reg_index[VX_REG_MAX] = {
 
 static inline unsigned long vx2_reg_addr(struct vx_core *_chip, int reg)
 {
-	struct snd_vx222 *chip = (struct snd_vx222 *)_chip;
+	struct snd_vx222 *chip = to_vx222(_chip);
 	return chip->port[vx2_reg_index[reg]] + vx2_reg_offset[reg];
 }
 
@@ -159,7 +159,7 @@ static void vx2_outl(struct vx_core *chip, int offset, unsigned int val)
 
 static void vx2_reset_dsp(struct vx_core *_chip)
 {
-	struct snd_vx222 *chip = (struct snd_vx222 *)_chip;
+	struct snd_vx222 *chip = to_vx222(_chip);
 
 	/* set the reset dsp bit to 0 */
 	vx_outl(chip, CDSP, chip->regCDSP & ~VX_CDSP_DSP_RESET_MASK);
@@ -174,7 +174,7 @@ static void vx2_reset_dsp(struct vx_core *_chip)
 
 static int vx2_test_xilinx(struct vx_core *_chip)
 {
-	struct snd_vx222 *chip = (struct snd_vx222 *)_chip;
+	struct snd_vx222 *chip = to_vx222(_chip);
 	unsigned int data;
 
 	dev_dbg(_chip->card->dev, "testing xilinx...\n");
@@ -479,7 +479,7 @@ static int vx2_test_and_ack(struct vx_core *chip)
  */
 static void vx2_validate_irq(struct vx_core *_chip, int enable)
 {
-	struct snd_vx222 *chip = (struct snd_vx222 *)_chip;
+	struct snd_vx222 *chip = to_vx222(_chip);
 
 	/* Set the interrupt enable bit to 1 in CDSP register */
 	if (enable) {
@@ -730,7 +730,7 @@ static void vx2_old_write_codec_bit(struct vx_core *chip, int codec, unsigned in
  */
 static void vx2_reset_codec(struct vx_core *_chip)
 {
-	struct snd_vx222 *chip = (struct snd_vx222 *)_chip;
+	struct snd_vx222 *chip = to_vx222(_chip);
 
 	/* Set the reset CODEC bit to 0. */
 	vx_outl(chip, CDSP, chip->regCDSP &~ VX_CDSP_CODEC_RESET_MASK);
@@ -772,7 +772,7 @@ static void vx2_reset_codec(struct vx_core *_chip)
  */
 static void vx2_change_audio_source(struct vx_core *_chip, int src)
 {
-	struct snd_vx222 *chip = (struct snd_vx222 *)_chip;
+	struct snd_vx222 *chip = to_vx222(_chip);
 
 	switch (src) {
 	case VX_AUDIO_SRC_DIGITAL:
@@ -791,7 +791,7 @@ static void vx2_change_audio_source(struct vx_core *_chip, int src)
  */
 static void vx2_set_clock_source(struct vx_core *_chip, int source)
 {
-	struct snd_vx222 *chip = (struct snd_vx222 *)_chip;
+	struct snd_vx222 *chip = to_vx222(_chip);
 
 	if (source == INTERNAL_QUARTZ)
 		chip->regCFG &= ~VX_CFG_CLOCKIN_SEL_MASK;
@@ -805,7 +805,7 @@ static void vx2_set_clock_source(struct vx_core *_chip, int source)
  */
 static void vx2_reset_board(struct vx_core *_chip, int cold_reset)
 {
-	struct snd_vx222 *chip = (struct snd_vx222 *)_chip;
+	struct snd_vx222 *chip = to_vx222(_chip);
 
 	/* initialize the register values */
 	chip->regCDSP = VX_CDSP_CODEC_RESET_MASK | VX_CDSP_DSP_RESET_MASK ;
@@ -878,7 +878,7 @@ static int vx_input_level_info(struct snd_kcontrol *kcontrol, struct snd_ctl_ele
 static int vx_input_level_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct vx_core *_chip = snd_kcontrol_chip(kcontrol);
-	struct snd_vx222 *chip = (struct snd_vx222 *)_chip;
+	struct snd_vx222 *chip = to_vx222(_chip);
 	mutex_lock(&_chip->mixer_mutex);
 	ucontrol->value.integer.value[0] = chip->input_level[0];
 	ucontrol->value.integer.value[1] = chip->input_level[1];
@@ -889,7 +889,7 @@ static int vx_input_level_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem
 static int vx_input_level_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct vx_core *_chip = snd_kcontrol_chip(kcontrol);
-	struct snd_vx222 *chip = (struct snd_vx222 *)_chip;
+	struct snd_vx222 *chip = to_vx222(_chip);
 	if (ucontrol->value.integer.value[0] < 0 ||
 	    ucontrol->value.integer.value[0] > MIC_LEVEL_MAX)
 		return -EINVAL;
@@ -922,7 +922,7 @@ static int vx_mic_level_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_
 static int vx_mic_level_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct vx_core *_chip = snd_kcontrol_chip(kcontrol);
-	struct snd_vx222 *chip = (struct snd_vx222 *)_chip;
+	struct snd_vx222 *chip = to_vx222(_chip);
 	ucontrol->value.integer.value[0] = chip->mic_level;
 	return 0;
 }
@@ -930,7 +930,7 @@ static int vx_mic_level_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_v
 static int vx_mic_level_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct vx_core *_chip = snd_kcontrol_chip(kcontrol);
-	struct snd_vx222 *chip = (struct snd_vx222 *)_chip;
+	struct snd_vx222 *chip = to_vx222(_chip);
 	if (ucontrol->value.integer.value[0] < 0 ||
 	    ucontrol->value.integer.value[0] > MIC_LEVEL_MAX)
 		return -EINVAL;
@@ -973,7 +973,7 @@ static const struct snd_kcontrol_new vx_control_mic_level = {
 
 static int vx2_add_mic_controls(struct vx_core *_chip)
 {
-	struct snd_vx222 *chip = (struct snd_vx222 *)_chip;
+	struct snd_vx222 *chip = to_vx222(_chip);
 	int err;
 
 	if (_chip->type != VX_TYPE_MIC)
-- 
2.12.2
