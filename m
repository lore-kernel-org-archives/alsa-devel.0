From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/6] ALSA: x86: Rearrange defines
Date: Tue,  7 Feb 2017 14:11:17 +0100
Message-ID: <20170207131122.6345-2-tiwai@suse.de>
References: <20170207131122.6345-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 35162266FD3
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 14:11:24 +0100 (CET)
In-Reply-To: <20170207131122.6345-1-tiwai@suse.de>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

We have two header files and everything is mixed up chaotically.
Move the chip-specific definitions like the hardware registers to
intel_hdmi_lpe_audio.h, and the rest, the implementation specific
stuff into intel_hdmi_audio.h.

In addition, put some more comments to the register fields, and fix
the incorrect name prefix for AUD_HDMI_STATUS bits, too.

The whole changes are merely a code shuffling, and there is no
functional change.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c     |  5 ++-
 sound/x86/intel_hdmi_audio.h     | 64 +++++++++++++++++----------
 sound/x86/intel_hdmi_lpe_audio.h | 95 +++++++++++++++++-----------------------
 3 files changed, 83 insertions(+), 81 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index dd7944c5ebc2..eb7044d2f314 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -252,7 +252,8 @@ static void had_ack_irqs(struct snd_intelhad *ctx)
 /* Reset buffer pointers */
 static void had_reset_audio(struct snd_intelhad *intelhaddata)
 {
-	had_write_register(intelhaddata, AUD_HDMI_STATUS, 1);
+	had_write_register(intelhaddata, AUD_HDMI_STATUS,
+			   AUD_HDMI_STATUSG_MASK_FUNCRST);
 	had_write_register(intelhaddata, AUD_HDMI_STATUS, 0);
 }
 
@@ -989,7 +990,7 @@ static void wait_clear_underrun_bit(struct snd_intelhad *intelhaddata)
 	for (i = 0; i < MAX_CNT; i++) {
 		/* clear bit30, 31 AUD_HDMI_STATUS */
 		had_read_register(intelhaddata, AUD_HDMI_STATUS, &val);
-		if (!(val & AUD_CONFIG_MASK_UNDERRUN))
+		if (!(val & AUD_HDMI_STATUS_MASK_UNDERRUN))
 			return;
 		had_write_register(intelhaddata, AUD_HDMI_STATUS, val);
 	}
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 7e2546b853ca..fe8d99cb839f 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -35,32 +35,50 @@
 #define PCM_INDEX		0
 #define MAX_PB_STREAMS		1
 #define MAX_CAP_STREAMS		0
-
-#define HDMI_INFO_FRAME_WORD1	0x000a0184
-#define DP_INFO_FRAME_WORD1	0x00441b84
-#define FIFO_THRESHOLD		0xFE
-#define DMA_FIFO_THRESHOLD	0x7
 #define BYTES_PER_WORD		0x4
+#define INTEL_HAD		"HdmiLpeAudio"
+
+/*
+ *	CEA speaker placement:
+ *
+ *	FL  FLC   FC   FRC   FR
+ *
+ *						LFE
+ *
+ *	RL  RLC   RC   RRC   RR
+ *
+ *	The Left/Right Surround channel _notions_ LS/RS in SMPTE 320M
+ *	corresponds to CEA RL/RR; The SMPTE channel _assignment_ C/LFE is
+ *	swapped to CEA LFE/FC.
+ */
+enum cea_speaker_placement {
+	FL  = (1 <<  0),        /* Front Left           */
+	FC  = (1 <<  1),        /* Front Center         */
+	FR  = (1 <<  2),        /* Front Right          */
+	FLC = (1 <<  3),        /* Front Left Center    */
+	FRC = (1 <<  4),        /* Front Right Center   */
+	RL  = (1 <<  5),        /* Rear Left            */
+	RC  = (1 <<  6),        /* Rear Center          */
+	RR  = (1 <<  7),        /* Rear Right           */
+	RLC = (1 <<  8),        /* Rear Left Center     */
+	RRC = (1 <<  9),        /* Rear Right Center    */
+	LFE = (1 << 10),        /* Low Frequency Effect */
+};
 
-/* Sampling rate as per IEC60958 Ver 3 */
-#define CH_STATUS_MAP_32KHZ	0x3
-#define CH_STATUS_MAP_44KHZ	0x0
-#define CH_STATUS_MAP_48KHZ	0x2
-#define CH_STATUS_MAP_88KHZ	0x8
-#define CH_STATUS_MAP_96KHZ	0xA
-#define CH_STATUS_MAP_176KHZ	0xC
-#define CH_STATUS_MAP_192KHZ	0xE
+struct cea_channel_speaker_allocation {
+	int ca_index;
+	int speakers[8];
 
-#define MAX_SMPL_WIDTH_20	0x0
-#define MAX_SMPL_WIDTH_24	0x1
-#define SMPL_WIDTH_16BITS	0x1
-#define SMPL_WIDTH_24BITS	0x5
-#define CHANNEL_ALLOCATION	0x1F
-#define VALID_DIP_WORDS		3
-#define LAYOUT0			0
-#define LAYOUT1			1
-#define SWAP_LFE_CENTER		0x00fac4c8
-#define AUD_CONFIG_CH_MASK	0x70
+	/* derived values, just for convenience */
+	int channels;
+	int spk_mask;
+};
+
+struct channel_map_table {
+	unsigned char map;              /* ALSA API channel map position */
+	unsigned char cea_slot;         /* CEA slot value */
+	int spk_mask;                   /* speaker position bit mask */
+};
 
 struct pcm_stream_info {
 	struct snd_pcm_substream *substream;
diff --git a/sound/x86/intel_hdmi_lpe_audio.h b/sound/x86/intel_hdmi_lpe_audio.h
index 48cab1b84c7b..a13a66771f73 100644
--- a/sound/x86/intel_hdmi_lpe_audio.h
+++ b/sound/x86/intel_hdmi_lpe_audio.h
@@ -23,7 +23,6 @@
 #ifndef __INTEL_HDMI_LPE_AUDIO_H
 #define __INTEL_HDMI_LPE_AUDIO_H
 
-#define HAD_MAX_DEVICES		1
 #define HAD_MIN_CHANNEL		2
 #define HAD_MAX_CHANNEL		8
 #define HAD_NUM_OF_RING_BUFS	4
@@ -55,9 +54,7 @@
 #define DIS_SAMPLE_RATE_74_25	74250
 #define DIS_SAMPLE_RATE_148_5	148500
 #define HAD_REG_WIDTH		0x08
-#define HAD_MAX_HW_BUFS		0x04
 #define HAD_MAX_DIP_WORDS		16
-#define INTEL_HAD		"HdmiLpeAudio"
 
 /* DP Link Rates */
 #define DP_2_7_GHZ			270000
@@ -112,72 +109,34 @@ enum hdmi_ctrl_reg_offset {
 	AUD_HDMIW_INFOFR	= 0x68, /* v2 */
 };
 
-/*
- *	CEA speaker placement:
- *
- *	FL  FLC   FC   FRC   FR
- *
- *						LFE
- *
- *	RL  RLC   RC   RRC   RR
- *
- *	The Left/Right Surround channel _notions_ LS/RS in SMPTE 320M
- *	corresponds to CEA RL/RR; The SMPTE channel _assignment_ C/LFE is
- *	swapped to CEA LFE/FC.
- */
-enum cea_speaker_placement {
-	FL  = (1 <<  0),        /* Front Left           */
-	FC  = (1 <<  1),        /* Front Center         */
-	FR  = (1 <<  2),        /* Front Right          */
-	FLC = (1 <<  3),        /* Front Left Center    */
-	FRC = (1 <<  4),        /* Front Right Center   */
-	RL  = (1 <<  5),        /* Rear Left            */
-	RC  = (1 <<  6),        /* Rear Center          */
-	RR  = (1 <<  7),        /* Rear Right           */
-	RLC = (1 <<  8),        /* Rear Left Center     */
-	RRC = (1 <<  9),        /* Rear Right Center    */
-	LFE = (1 << 10),        /* Low Frequency Effect */
-};
-
-struct cea_channel_speaker_allocation {
-	int ca_index;
-	int speakers[8];
-
-	/* derived values, just for convenience */
-	int channels;
-	int spk_mask;
-};
-
-struct channel_map_table {
-	unsigned char map;              /* ALSA API channel map position */
-	unsigned char cea_slot;         /* CEA slot value */
-	int spk_mask;                   /* speaker position bit mask */
-};
-
 /* Audio configuration */
 union aud_cfg {
 	struct {
 		u32 aud_en:1;
-		u32 layout:1;
+		u32 layout:1;		/* LAYOUT[01], see below */
 		u32 fmt:2;
 		u32 num_ch:3;
 		u32 set:1;
 		u32 flat:1;
 		u32 val_bit:1;
 		u32 user_bit:1;
-		u32 underrun:1;
-		u32 packet_mode:1;
-		u32 left_align:1;
-		u32 bogus_sample:1;
-		u32 dp_modei:1;
+		u32 underrun:1;		/* 0: send null packets,
+					 * 1: send silence stream
+					 */
+		u32 packet_mode:1;	/* 0: 32bit container, 1: 16bit */
+		u32 left_align:1;	/* 0: MSB bits 0-23, 1: bits 8-31 */
+		u32 bogus_sample:1;	/* bogus sample for odd channels */
+		u32 dp_modei:1;		/* 0: HDMI, 1: DP */
 		u32 rsvd:16;
 	} regx;
 	u32 regval;
 };
 
-#define AUD_CONFIG_BLOCK_BIT			(1 << 7)
 #define AUD_CONFIG_VALID_BIT			(1 << 9)
 #define AUD_CONFIG_DP_MODE			(1 << 15)
+#define AUD_CONFIG_CH_MASK	0x70
+#define LAYOUT0			0		/* interleaved stereo */
+#define LAYOUT1			1		/* for channels >= 2 */
 
 /* Audio Channel Status 0 Attributes */
 union aud_ch_status_0 {
@@ -190,13 +149,22 @@ union aud_ch_status_0 {
 		u32 ctg_code:8;
 		u32 src_num:4;
 		u32 ch_num:4;
-		u32 samp_freq:4;
+		u32 samp_freq:4;	/* CH_STATUS_MAP_XXX */
 		u32 clk_acc:2;
 		u32 rsvd:2;
 	} regx;
 	u32 regval;
 };
 
+/* samp_freq values - Sampling rate as per IEC60958 Ver 3 */
+#define CH_STATUS_MAP_32KHZ	0x3
+#define CH_STATUS_MAP_44KHZ	0x0
+#define CH_STATUS_MAP_48KHZ	0x2
+#define CH_STATUS_MAP_88KHZ	0x8
+#define CH_STATUS_MAP_96KHZ	0xA
+#define CH_STATUS_MAP_176KHZ	0xC
+#define CH_STATUS_MAP_192KHZ	0xE
+
 /* Audio Channel Status 1 Attributes */
 union aud_ch_status_1 {
 	struct {
@@ -207,6 +175,11 @@ union aud_ch_status_1 {
 	u32 regval;
 };
 
+#define MAX_SMPL_WIDTH_20	0x0
+#define MAX_SMPL_WIDTH_24	0x1
+#define SMPL_WIDTH_16BITS	0x1
+#define SMPL_WIDTH_24BITS	0x5
+
 /* CTS register */
 union aud_hdmi_cts {
 	struct {
@@ -239,6 +212,9 @@ union aud_buf_config {
 	u32 regval;
 };
 
+#define FIFO_THRESHOLD		0xFE
+#define DMA_FIFO_THRESHOLD	0x7
+
 /* Audio Sample Swapping offset */
 union aud_buf_ch_swap {
 	struct {
@@ -255,6 +231,8 @@ union aud_buf_ch_swap {
 	u32 regval;
 };
 
+#define SWAP_LFE_CENTER		0x00fac4c8	/* octal 76543210 */
+
 /* Address for Audio Buffer */
 union aud_buf_addr {
 	struct {
@@ -306,6 +284,9 @@ union aud_info_frame1 {
 	u32 regval;
 };
 
+#define HDMI_INFO_FRAME_WORD1	0x000a0184
+#define DP_INFO_FRAME_WORD1	0x00441b84
+
 /* DIP frame 2 */
 union aud_info_frame2 {
 	struct {
@@ -333,13 +314,15 @@ union aud_info_frame3 {
 	u32 regval;
 };
 
+#define VALID_DIP_WORDS		3
+
 /* AUD_HDMI_STATUS bits */
 #define HDMI_AUDIO_UNDERRUN		(1U << 31)
 #define HDMI_AUDIO_BUFFER_DONE		(1U << 29)
 
 /* AUD_HDMI_STATUS register mask */
-#define AUD_CONFIG_MASK_UNDERRUN	0xC0000000
-#define AUD_CONFIG_MASK_SRDBG		0x00000002
-#define AUD_CONFIG_MASK_FUNCRST		0x00000001
+#define AUD_HDMI_STATUS_MASK_UNDERRUN	0xC0000000
+#define AUD_HDMI_STATUS_MASK_SRDBG	0x00000002
+#define AUD_HDMI_STATUSG_MASK_FUNCRST	0x00000001
 
 #endif
-- 
2.11.0
