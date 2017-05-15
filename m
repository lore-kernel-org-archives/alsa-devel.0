From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: vxpocket: Use container_of()
Date: Mon, 15 May 2017 11:29:04 +0200
Message-ID: <20170515092905.20381-2-tiwai@suse.de>
References: <20170515092905.20381-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8483526739D
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 11:29:10 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 3901CAB9F
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 09:29:10 +0000 (UTC)
In-Reply-To: <20170515092905.20381-1-tiwai@suse.de>
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

The vxpocket driver is using the explicit cast from the parent class
pointer, but it'll be broken when the structure field randomization is
applied.  Use container_of() in a modern manner, instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pcmcia/vx/vxp_mixer.c | 10 +++++-----
 sound/pcmcia/vx/vxp_ops.c   | 28 ++++++++++++++--------------
 sound/pcmcia/vx/vxpocket.c  |  4 ++--
 sound/pcmcia/vx/vxpocket.h  |  2 ++
 4 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/sound/pcmcia/vx/vxp_mixer.c b/sound/pcmcia/vx/vxp_mixer.c
index a4a664259f0d..1ca3eef9e305 100644
--- a/sound/pcmcia/vx/vxp_mixer.c
+++ b/sound/pcmcia/vx/vxp_mixer.c
@@ -43,7 +43,7 @@ static int vx_mic_level_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_
 static int vx_mic_level_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct vx_core *_chip = snd_kcontrol_chip(kcontrol);
-	struct snd_vxpocket *chip = (struct snd_vxpocket *)_chip;
+	struct snd_vxpocket *chip = to_vxpocket(_chip);
 	ucontrol->value.integer.value[0] = chip->mic_level;
 	return 0;
 }
@@ -51,7 +51,7 @@ static int vx_mic_level_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_v
 static int vx_mic_level_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct vx_core *_chip = snd_kcontrol_chip(kcontrol);
-	struct snd_vxpocket *chip = (struct snd_vxpocket *)_chip;
+	struct snd_vxpocket *chip = to_vxpocket(_chip);
 	unsigned int val = ucontrol->value.integer.value[0];
 
 	if (val > MIC_LEVEL_MAX)
@@ -88,7 +88,7 @@ static struct snd_kcontrol_new vx_control_mic_level = {
 static int vx_mic_boost_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct vx_core *_chip = snd_kcontrol_chip(kcontrol);
-	struct snd_vxpocket *chip = (struct snd_vxpocket *)_chip;
+	struct snd_vxpocket *chip = to_vxpocket(_chip);
 	ucontrol->value.integer.value[0] = chip->mic_level;
 	return 0;
 }
@@ -96,7 +96,7 @@ static int vx_mic_boost_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_v
 static int vx_mic_boost_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct vx_core *_chip = snd_kcontrol_chip(kcontrol);
-	struct snd_vxpocket *chip = (struct snd_vxpocket *)_chip;
+	struct snd_vxpocket *chip = to_vxpocket(_chip);
 	int val = !!ucontrol->value.integer.value[0];
 	mutex_lock(&_chip->mixer_mutex);
 	if (chip->mic_level != val) {
@@ -120,7 +120,7 @@ static struct snd_kcontrol_new vx_control_mic_boost = {
 
 int vxp_add_mic_controls(struct vx_core *_chip)
 {
-	struct snd_vxpocket *chip = (struct snd_vxpocket *)_chip;
+	struct snd_vxpocket *chip = to_vxpocket(_chip);
 	int err;
 
 	/* mute input levels */
diff --git a/sound/pcmcia/vx/vxp_ops.c b/sound/pcmcia/vx/vxp_ops.c
index 5f97791f00d7..217cc76e3102 100644
--- a/sound/pcmcia/vx/vxp_ops.c
+++ b/sound/pcmcia/vx/vxp_ops.c
@@ -50,7 +50,7 @@ static int vxp_reg_offset[VX_REG_MAX] = {
 
 static inline unsigned long vxp_reg_addr(struct vx_core *_chip, int reg)
 {
-	struct snd_vxpocket *chip = (struct snd_vxpocket *)_chip;
+	struct snd_vxpocket *chip = to_vxpocket(_chip);
 	return chip->port + vxp_reg_offset[reg];
 }
 
@@ -110,7 +110,7 @@ static int vx_check_magic(struct vx_core *chip)
 
 static void vxp_reset_dsp(struct vx_core *_chip)
 {
-	struct snd_vxpocket *chip = (struct snd_vxpocket *)_chip;
+	struct snd_vxpocket *chip = to_vxpocket(_chip);
 
 	/* set the reset dsp bit to 1 */
 	vx_outb(chip, CDSP, chip->regCDSP | VXP_CDSP_DSP_RESET_MASK);
@@ -128,7 +128,7 @@ static void vxp_reset_dsp(struct vx_core *_chip)
  */
 static void vxp_reset_codec(struct vx_core *_chip)
 {
-	struct snd_vxpocket *chip = (struct snd_vxpocket *)_chip;
+	struct snd_vxpocket *chip = to_vxpocket(_chip);
 
 	/* Set the reset CODEC bit to 1. */
 	vx_outb(chip, CDSP, chip->regCDSP | VXP_CDSP_CODEC_RESET_MASK);
@@ -147,7 +147,7 @@ static void vxp_reset_codec(struct vx_core *_chip)
  */
 static int vxp_load_xilinx_binary(struct vx_core *_chip, const struct firmware *fw)
 {
-	struct snd_vxpocket *chip = (struct snd_vxpocket *)_chip;
+	struct snd_vxpocket *chip = to_vxpocket(_chip);
 	unsigned int i;
 	int c;
 	int regCSUER, regRUER;
@@ -280,7 +280,7 @@ static int vxp_load_dsp(struct vx_core *vx, int index, const struct firmware *fw
  */
 static int vxp_test_and_ack(struct vx_core *_chip)
 {
-	struct snd_vxpocket *chip = (struct snd_vxpocket *)_chip;
+	struct snd_vxpocket *chip = to_vxpocket(_chip);
 
 	/* not booted yet? */
 	if (! (_chip->chip_status & VX_STAT_XILINX_LOADED))
@@ -307,7 +307,7 @@ static int vxp_test_and_ack(struct vx_core *_chip)
  */
 static void vxp_validate_irq(struct vx_core *_chip, int enable)
 {
-	struct snd_vxpocket *chip = (struct snd_vxpocket *)_chip;
+	struct snd_vxpocket *chip = to_vxpocket(_chip);
 
 	/* Set the interrupt enable bit to 1 in CDSP register */
 	if (enable)
@@ -323,7 +323,7 @@ static void vxp_validate_irq(struct vx_core *_chip, int enable)
  */
 static void vx_setup_pseudo_dma(struct vx_core *_chip, int do_write)
 {
-	struct snd_vxpocket *chip = (struct snd_vxpocket *)_chip;
+	struct snd_vxpocket *chip = to_vxpocket(_chip);
 
 	/* Interrupt mode and HREQ pin enabled for host transmit / receive data transfers */
 	vx_outb(chip, ICR, do_write ? ICR_TREQ : ICR_RREQ);
@@ -343,7 +343,7 @@ static void vx_setup_pseudo_dma(struct vx_core *_chip, int do_write)
  */
 static void vx_release_pseudo_dma(struct vx_core *_chip)
 {
-	struct snd_vxpocket *chip = (struct snd_vxpocket *)_chip;
+	struct snd_vxpocket *chip = to_vxpocket(_chip);
 
 	/* Disable DMA and 16-bit accesses */
 	chip->regDIALOG &= ~(VXP_DLG_DMAWRITE_SEL_MASK|
@@ -403,7 +403,7 @@ static void vxp_dma_write(struct vx_core *chip, struct snd_pcm_runtime *runtime,
 static void vxp_dma_read(struct vx_core *chip, struct snd_pcm_runtime *runtime,
 			 struct vx_pipe *pipe, int count)
 {
-	struct snd_vxpocket *pchip = (struct snd_vxpocket *)chip;
+	struct snd_vxpocket *pchip = to_vxpocket(_chip);
 	long port = vxp_reg_addr(chip, VX_DMA);
 	int offset = pipe->hw_ptr;
 	unsigned short *addr = (unsigned short *)(runtime->dma_area + offset);
@@ -467,7 +467,7 @@ static void vxp_write_codec_reg(struct vx_core *chip, int codec, unsigned int da
  */
 void vx_set_mic_boost(struct vx_core *chip, int boost)
 {
-	struct snd_vxpocket *pchip = (struct snd_vxpocket *)chip;
+	struct snd_vxpocket *pchip = to_vxpocket(_chip);
 
 	if (chip->chip_status & VX_STAT_IS_STALE)
 		return;
@@ -509,7 +509,7 @@ static int vx_compute_mic_level(int level)
  */
 void vx_set_mic_level(struct vx_core *chip, int level)
 {
-	struct snd_vxpocket *pchip = (struct snd_vxpocket *)chip;
+	struct snd_vxpocket *pchip = to_vxpocket(_chip);
 
 	if (chip->chip_status & VX_STAT_IS_STALE)
 		return;
@@ -528,7 +528,7 @@ void vx_set_mic_level(struct vx_core *chip, int level)
  */
 static void vxp_change_audio_source(struct vx_core *_chip, int src)
 {
-	struct snd_vxpocket *chip = (struct snd_vxpocket *)_chip;
+	struct snd_vxpocket *chip = to_vxpocket(_chip);
 
 	switch (src) {
 	case VX_AUDIO_SRC_DIGITAL:
@@ -568,7 +568,7 @@ static void vxp_change_audio_source(struct vx_core *_chip, int src)
  */
 static void vxp_set_clock_source(struct vx_core *_chip, int source)
 {
-	struct snd_vxpocket *chip = (struct snd_vxpocket *)_chip;
+	struct snd_vxpocket *chip = to_vxpocket(_chip);
 
 	if (source == INTERNAL_QUARTZ)
 		chip->regCDSP &= ~VXP_CDSP_CLOCKIN_SEL_MASK;
@@ -583,7 +583,7 @@ static void vxp_set_clock_source(struct vx_core *_chip, int source)
  */
 static void vxp_reset_board(struct vx_core *_chip, int cold_reset)
 {
-	struct snd_vxpocket *chip = (struct snd_vxpocket *)_chip;
+	struct snd_vxpocket *chip = to_vxpocket(_chip);
 
 	chip->regCDSP = 0;
 	chip->regDIALOG = 0;
diff --git a/sound/pcmcia/vx/vxpocket.c b/sound/pcmcia/vx/vxpocket.c
index b16f42deed67..ca0d19e723fd 100644
--- a/sound/pcmcia/vx/vxpocket.c
+++ b/sound/pcmcia/vx/vxpocket.c
@@ -155,7 +155,7 @@ static int snd_vxpocket_new(struct snd_card *card, int ibl,
 	}
 	chip->ibl.size = ibl;
 
-	vxp = (struct snd_vxpocket *)chip;
+	vxp = to_vxpocket(chip);
 
 	vxp->p_dev = link;
 	link->priv = chip;
@@ -187,7 +187,7 @@ static int snd_vxpocket_assign_resources(struct vx_core *chip, int port, int irq
 {
 	int err;
 	struct snd_card *card = chip->card;
-	struct snd_vxpocket *vxp = (struct snd_vxpocket *)chip;
+	struct snd_vxpocket *vxp = to_vxpocket(chip);
 
 	snd_printdd(KERN_DEBUG "vxpocket assign resources: port = 0x%x, irq = %d\n", port, irq);
 	vxp->port = port;
diff --git a/sound/pcmcia/vx/vxpocket.h b/sound/pcmcia/vx/vxpocket.h
index 13d658c1a216..26f4255e132e 100644
--- a/sound/pcmcia/vx/vxpocket.h
+++ b/sound/pcmcia/vx/vxpocket.h
@@ -43,6 +43,8 @@ struct snd_vxpocket {
 	struct pcmcia_device	*p_dev;
 };
 
+#define to_vxpocket(x)	container_of(x, struct snd_vxpocket, core)
+
 extern struct snd_vx_ops snd_vxpocket_ops;
 
 void vx_set_mic_boost(struct vx_core *chip, int boost);
-- 
2.12.2
