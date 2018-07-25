From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/14] ALSA: echoaudio: Proper endian notations
Date: Wed, 25 Jul 2018 23:24:10 +0200
Message-ID: <20180725212414.19795-11-tiwai@suse.de>
References: <20180725212414.19795-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 96E2726779C
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:24:17 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 5F202B082
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:24:16 +0000 (UTC)
In-Reply-To: <20180725212414.19795-1-tiwai@suse.de>
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

Many data fields defined in echoaudio drivers are in little-endian,
hence they should be defined with __le16 or __le32.  This makes it
easier to catch the forgotten conversions.

Spotted by sparse, a warning like:
  sound/pci/echoaudio/echoaudio_dsp.c:990:36: warning: incorrect type in assignment (different base types)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/echoaudio/echoaudio.h     |  2 +-
 sound/pci/echoaudio/echoaudio_3g.c  | 14 ++++----
 sound/pci/echoaudio/echoaudio_dsp.c |  6 ++--
 sound/pci/echoaudio/echoaudio_dsp.h | 50 ++++++++++++++---------------
 sound/pci/echoaudio/echoaudio_gml.c |  8 +++--
 5 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.h b/sound/pci/echoaudio/echoaudio.h
index 44b390a667d5..be4d0489394a 100644
--- a/sound/pci/echoaudio/echoaudio.h
+++ b/sound/pci/echoaudio/echoaudio.h
@@ -294,7 +294,7 @@
 
 
 struct audiopipe {
-	volatile u32 *dma_counter;	/* Commpage register that contains
+	volatile __le32 *dma_counter;	/* Commpage register that contains
 					 * the current dma position
 					 * (lower 32 bits only)
 					 */
diff --git a/sound/pci/echoaudio/echoaudio_3g.c b/sound/pci/echoaudio/echoaudio_3g.c
index 22c786b8a889..cc3c79387194 100644
--- a/sound/pci/echoaudio/echoaudio_3g.c
+++ b/sound/pci/echoaudio/echoaudio_3g.c
@@ -73,19 +73,21 @@ register. write_control_reg sends the new control register value to the DSP. */
 static int write_control_reg(struct echoaudio *chip, u32 ctl, u32 frq,
 			     char force)
 {
+	__le32 ctl_reg, frq_reg;
+
 	if (wait_handshake(chip))
 		return -EIO;
 
 	dev_dbg(chip->card->dev,
 		"WriteControlReg: Setting 0x%x, 0x%x\n", ctl, frq);
 
-	ctl = cpu_to_le32(ctl);
-	frq = cpu_to_le32(frq);
+	ctl_reg = cpu_to_le32(ctl);
+	frq_reg = cpu_to_le32(frq);
 
-	if (ctl != chip->comm_page->control_register ||
-	    frq != chip->comm_page->e3g_frq_register || force) {
-		chip->comm_page->e3g_frq_register = frq;
-		chip->comm_page->control_register = ctl;
+	if (ctl_reg != chip->comm_page->control_register ||
+	    frq_reg != chip->comm_page->e3g_frq_register || force) {
+		chip->comm_page->e3g_frq_register = frq_reg;
+		chip->comm_page->control_register = ctl_reg;
 		clear_handshake(chip);
 		return send_vector(chip, DSP_VC_WRITE_CONTROL_REG);
 	}
diff --git a/sound/pci/echoaudio/echoaudio_dsp.c b/sound/pci/echoaudio/echoaudio_dsp.c
index 15aae2fad8e4..b181752b8481 100644
--- a/sound/pci/echoaudio/echoaudio_dsp.c
+++ b/sound/pci/echoaudio/echoaudio_dsp.c
@@ -679,7 +679,7 @@ static int restore_dsp_rettings(struct echoaudio *chip)
 	/* Gina20/Darla20 only. Should be harmless for other cards. */
 	chip->comm_page->gd_clock_state = GD_CLOCK_UNDEF;
 	chip->comm_page->gd_spdif_status = GD_SPDIF_STATUS_UNDEF;
-	chip->comm_page->handshake = 0xffffffff;
+	chip->comm_page->handshake = cpu_to_le32(0xffffffff);
 
 	/* Restore output busses */
 	for (i = 0; i < num_busses_out(chip); i++) {
@@ -989,7 +989,7 @@ static int init_dsp_comm_page(struct echoaudio *chip)
 	/* Init the comm page */
 	chip->comm_page->comm_size =
 		cpu_to_le32(sizeof(struct comm_page));
-	chip->comm_page->handshake = 0xffffffff;
+	chip->comm_page->handshake = cpu_to_le32(0xffffffff);
 	chip->comm_page->midi_out_free_count =
 		cpu_to_le32(DSP_MIDI_OUT_FIFO_SIZE);
 	chip->comm_page->sample_rate = cpu_to_le32(44100);
@@ -1087,7 +1087,7 @@ static int allocate_pipes(struct echoaudio *chip, struct audiopipe *pipe,
 	/* The counter register is where the DSP writes the 32 bit DMA
 	position for a pipe.  The DSP is constantly updating this value as
 	it moves data. The DMA counter is in units of bytes, not samples. */
-	pipe->dma_counter = &chip->comm_page->position[pipe_index];
+	pipe->dma_counter = (__le32 *)&chip->comm_page->position[pipe_index];
 	*pipe->dma_counter = 0;
 	return pipe_index;
 }
diff --git a/sound/pci/echoaudio/echoaudio_dsp.h b/sound/pci/echoaudio/echoaudio_dsp.h
index cb7d75a0a503..aa9129519795 100644
--- a/sound/pci/echoaudio/echoaudio_dsp.h
+++ b/sound/pci/echoaudio/echoaudio_dsp.h
@@ -627,8 +627,8 @@ sg_entry struct is read by the DSP, so all values must be little-endian. */
 #define MAX_SGLIST_ENTRIES 512
 
 struct sg_entry {
-	u32 addr;
-	u32 size;
+	__le32 addr;
+	__le32 size;
 };
 
 
@@ -643,18 +643,18 @@ struct sg_entry {
  ****************************************************************************/
 
 struct comm_page {		/*				Base	Length*/
-	u32 comm_size;		/* size of this object		0x000	4 */
-	u32 flags;		/* See Appendix A below		0x004	4 */
-	u32 unused;		/* Unused entry			0x008	4 */
-	u32 sample_rate;	/* Card sample rate in Hz	0x00c	4 */
-	u32 handshake;		/* DSP command handshake	0x010	4 */
-	u32 cmd_start;		/* Chs. to start mask		0x014	4 */
-	u32 cmd_stop;		/* Chs. to stop mask		0x018	4 */
-	u32 cmd_reset;		/* Chs. to reset mask		0x01c	4 */
-	u16 audio_format[DSP_MAXPIPES];	/* Chs. audio format	0x020	32*2 */
+	__le32 comm_size;	/* size of this object		0x000	4 */
+	__le32 flags;		/* See Appendix A below		0x004	4 */
+	__le32 unused;		/* Unused entry			0x008	4 */
+	__le32 sample_rate;	/* Card sample rate in Hz	0x00c	4 */
+	__le32 handshake;	/* DSP command handshake	0x010	4 */
+	__le32 cmd_start;	/* Chs. to start mask		0x014	4 */
+	__le32 cmd_stop;	/* Chs. to stop mask		0x018	4 */
+	__le32 cmd_reset;	/* Chs. to reset mask		0x01c	4 */
+	__le16 audio_format[DSP_MAXPIPES];	/* Chs. audio format	0x020	32*2 */
 	struct sg_entry sglist_addr[DSP_MAXPIPES];
 				/* Chs. Physical sglist addrs	0x060	32*8 */
-	u32 position[DSP_MAXPIPES];
+	__le32 position[DSP_MAXPIPES];
 				/* Positions for ea. ch.	0x160	32*4 */
 	s8 vu_meter[DSP_MAXPIPES];
 				/* VU meters			0x1e0	32*1 */
@@ -666,28 +666,28 @@ struct comm_page {		/*				Base	Length*/
 				/* Input gain			0x230	16*1 */
 	s8 monitors[MONITOR_ARRAY_SIZE];
 				/* Monitor map			0x240	0x180 */
-	u32 play_coeff[MAX_PLAY_TAPS];
+	__le32 play_coeff[MAX_PLAY_TAPS];
 			/* Gina/Darla play filters - obsolete	0x3c0	168*4 */
-	u32 rec_coeff[MAX_REC_TAPS];
+	__le32 rec_coeff[MAX_REC_TAPS];
 			/* Gina/Darla record filters - obsolete	0x660	192*4 */
-	u16 midi_input[MIDI_IN_BUFFER_SIZE];
+	__le16 midi_input[MIDI_IN_BUFFER_SIZE];
 			/* MIDI input data transfer buffer	0x960	256*2 */
 	u8 gd_clock_state;	/* Chg Gina/Darla clock state	0xb60	1 */
 	u8 gd_spdif_status;	/* Chg. Gina/Darla S/PDIF state	0xb61	1 */
 	u8 gd_resampler_state;	/* Should always be 3		0xb62	1 */
 	u8 filler2;		/*				0xb63	1 */
-	u32 nominal_level_mask;	/* -10 level enable mask	0xb64	4 */
-	u16 input_clock;	/* Chg. Input clock state	0xb68	2 */
-	u16 output_clock;	/* Chg. Output clock state	0xb6a	2 */
-	u32 status_clocks;	/* Current Input clock state	0xb6c	4 */
-	u32 ext_box_status;	/* External box status		0xb70	4 */
-	u32 cmd_add_buffer;	/* Pipes to add (obsolete)	0xb74	4 */
-	u32 midi_out_free_count;
+	__le32 nominal_level_mask;	/* -10 level enable mask	0xb64	4 */
+	__le16 input_clock;	/* Chg. Input clock state	0xb68	2 */
+	__le16 output_clock;	/* Chg. Output clock state	0xb6a	2 */
+	__le32 status_clocks;	/* Current Input clock state	0xb6c	4 */
+	__le32 ext_box_status;	/* External box status		0xb70	4 */
+	__le32 cmd_add_buffer;	/* Pipes to add (obsolete)	0xb74	4 */
+	__le32 midi_out_free_count;
 			/* # of bytes free in MIDI output FIFO	0xb78	4 */
-	u32 unused2;		/* Cyclic pipes			0xb7c	4 */
-	u32 control_register;
+	__le32 unused2;		/* Cyclic pipes			0xb7c	4 */
+	__le32 control_register;
 			/* Mona, Gina24, Layla24, 3G ctrl reg	0xb80	4 */
-	u32 e3g_frq_register;	/* 3G frequency register	0xb84	4 */
+	__le32 e3g_frq_register;	/* 3G frequency register	0xb84	4 */
 	u8 filler[24];		/* filler			0xb88	24*1 */
 	s8 vmixer[VMIXER_ARRAY_SIZE];
 				/* Vmixer levels		0xba0	64*1 */
diff --git a/sound/pci/echoaudio/echoaudio_gml.c b/sound/pci/echoaudio/echoaudio_gml.c
index 834b39e97db7..eea6fe530ab4 100644
--- a/sound/pci/echoaudio/echoaudio_gml.c
+++ b/sound/pci/echoaudio/echoaudio_gml.c
@@ -63,6 +63,8 @@ the control register.  write_control_reg sends the new control register
 value to the DSP. */
 static int write_control_reg(struct echoaudio *chip, u32 value, char force)
 {
+	__le32 reg_value;
+
 	/* Handle the digital input auto-mute */
 	if (chip->digital_in_automute)
 		value |= GML_DIGITAL_IN_AUTO_MUTE;
@@ -72,11 +74,11 @@ static int write_control_reg(struct echoaudio *chip, u32 value, char force)
 	dev_dbg(chip->card->dev, "write_control_reg: 0x%x\n", value);
 
 	/* Write the control register */
-	value = cpu_to_le32(value);
-	if (value != chip->comm_page->control_register || force) {
+	reg_value = cpu_to_le32(value);
+	if (reg_value != chip->comm_page->control_register || force) {
 		if (wait_handshake(chip))
 			return -EIO;
-		chip->comm_page->control_register = value;
+		chip->comm_page->control_register = reg_value;
 		clear_handshake(chip);
 		return send_vector(chip, DSP_VC_WRITE_CONTROL_REG);
 	}
-- 
2.18.0
