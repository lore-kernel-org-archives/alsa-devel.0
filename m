From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 1/7] ALSA: CA0132: Add new definitions ready
	for DSP routines
Date: Fri, 7 Dec 2012 21:35:57 -0800
Message-ID: <1354944963-4654-2-git-send-email-ian_minett@creativelabs.com>
References: <1354944963-4654-1-git-send-email-ian_minett@creativelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1354944963-4654-1-git-send-email-ian_minett@creativelabs.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

From: Ian Minett <ian_minett@creativelabs.com>


Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 2fd3121..5e45a27 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -35,6 +35,18 @@
 
 #include "ca0132_regs.h"
 
+/* Enable this to see controls for tuning purpose. */
+/*#define ENABLE_TUNING_CONTROLS*/
+
+#define FLOAT_ZERO	0x00000000
+#define FLOAT_ONE	0x3f800000
+#define FLOAT_TWO	0x40000000
+#define FLOAT_MINUS_5	0xc0a00000
+
+#define UNSOL_TAG_HP	0x10
+#define UNSOL_TAG_AMIC1	0x12
+#define UNSOL_TAG_DSP	0x16
+
 #define DSP_DMA_WRITE_BUFLEN_INIT (1UL<<18)
 #define DSP_DMA_WRITE_BUFLEN_OVLY (1UL<<15)
 
@@ -43,7 +55,8 @@
 #define DMA_OVERLAY_FRAME_SIZE_NWORDS		2
 
 #define MASTERCONTROL				0x80
-#define MASTERCONTROL_ALLOC_DMA_CHAN		9
+#define MASTERCONTROL_ALLOC_DMA_CHAN		10
+#define MASTERCONTROL_QUERY_SPEAKER_EQ_ADDRESS	60
 
 #define WIDGET_CHIP_CTRL      0x15
 #define WIDGET_DSP_CTRL       0x16
@@ -63,6 +76,390 @@
 
 MODULE_FIRMWARE(EFX_FILE);
 
+static char *dirstr[2] = { "Playback", "Capture" };
+
+enum {
+	SPEAKER_OUT,
+	HEADPHONE_OUT
+};
+
+enum {
+	DIGITAL_MIC,
+	LINE_MIC_IN
+};
+
+enum {
+#define VNODE_START_NID    0x80
+	VNID_SPK = VNODE_START_NID,			/* Speaker vnid */
+	VNID_MIC,
+	VNID_HP_SEL,
+	VNID_AMIC1_SEL,
+	VNID_HP_ASEL,
+	VNID_AMIC1_ASEL,
+	VNODE_END_NID,
+#define VNODES_COUNT  (VNODE_END_NID - VNODE_START_NID)
+
+#define EFFECT_START_NID    0x90
+#define OUT_EFFECT_START_NID    EFFECT_START_NID
+	SURROUND = OUT_EFFECT_START_NID,
+	CRYSTALIZER,
+	DIALOG_PLUS,
+	SMART_VOLUME,
+	X_BASS,
+	EQUALIZER,
+	OUT_EFFECT_END_NID,
+#define OUT_EFFECTS_COUNT  (OUT_EFFECT_END_NID - OUT_EFFECT_START_NID)
+
+#define IN_EFFECT_START_NID  OUT_EFFECT_END_NID
+	ECHO_CANCELLATION = IN_EFFECT_START_NID,
+	VOICE_FOCUS,
+	MIC_SVM,
+	NOISE_REDUCTION,
+	IN_EFFECT_END_NID,
+#define IN_EFFECTS_COUNT  (IN_EFFECT_END_NID - IN_EFFECT_START_NID)
+
+	VOICEFX = IN_EFFECT_END_NID,
+	PLAY_ENHANCEMENT,
+	CRYSTAL_VOICE,
+	EFFECT_END_NID
+#define EFFECTS_COUNT  (EFFECT_END_NID - EFFECT_START_NID)
+};
+
+/* Effects values size*/
+#define EFFECT_VALS_MAX_COUNT 12
+
+struct ct_effect {
+	char name[44];
+	hda_nid_t nid;
+	int mid; /*effect module ID*/
+	int reqs[EFFECT_VALS_MAX_COUNT]; /*effect module request*/
+	int direct; /* 0:output; 1:input*/
+	int params; /* number of default non-on/off params */
+	/*effect default values, 1st is on/off. */
+	unsigned int def_vals[EFFECT_VALS_MAX_COUNT];
+};
+
+static struct ct_effect ca0132_effects[EFFECTS_COUNT] = {
+	{ "Surround",
+		SURROUND,
+		0x96,
+		{0, 1},
+		0,
+		1,
+		{0x3F800000, 0x3F2B851F}
+	},
+	{ "Crystalizer",
+		CRYSTALIZER,
+		0x96,
+		{7, 8},
+		0,
+		1,
+		{0x3F800000, 0x3F266666}
+	},
+	{ "Dialog Plus",
+		DIALOG_PLUS,
+		0x96,
+		{2, 3},
+		0,
+		1,
+		{0x00000000, 0x3F000000}
+	},
+	{ "Smart Volume",
+		SMART_VOLUME,
+		0x96,
+		{4, 5, 6},
+		0,
+		2,
+		{0x3F800000, 0x3F3D70A4, 0x00000000}
+	},
+	{ "X-Bass",
+		X_BASS,
+		0x96,
+		{24, 23, 25},
+		0,
+		2,
+		{0x3F800000, 0x42A00000, 0x3F000000}
+	},
+	{ "Equalizer",
+		EQUALIZER,
+		0x96,
+		{9, 10, 11, 12, 13, 14,
+			15, 16, 17, 18, 19, 20},
+		0,
+		11,
+		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+		 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+		 0x00000000, 0x00000000}
+	},
+	{ "Echo Cancellation",
+		ECHO_CANCELLATION,
+		0x95,
+		{0, 1, 2, 3},
+		1,
+		3,
+		{0x00000000, 0x3F3A9692, 0x00000000, 0x00000000}
+	},
+	{ "Voice Focus",
+		VOICE_FOCUS,
+		0x95,
+		{6, 7, 8, 9},
+		1,
+		3,
+		{0x3F800000, 0x3D7DF3B6, 0x41F00000, 0x41F00000}
+	},
+	{ "Mic SVM",
+		MIC_SVM,
+		0x95,
+		{44, 45},
+		1,
+		1,
+		{0x00000000, 0x3F3D70A4}
+	},
+	{ "Noise Reduction",
+		NOISE_REDUCTION,
+		0x95,
+		{4, 5},
+		1,
+		1,
+		{0x3F800000, 0x3F000000}
+	},
+	{ "VoiceFX",
+		VOICEFX,
+		0x95,
+		{10, 11, 12, 13, 14, 15, 16, 17, 18},
+		1,
+		8,
+		{0x00000000, 0x43C80000, 0x44AF0000, 0x44FA0000, 0x3F800000,
+		 0x3F800000, 0x3F800000, 0x00000000, 0x00000000}
+	}
+};
+
+/* Tuning controls */
+#ifdef ENABLE_TUNING_CONTROLS
+
+enum {
+#define TUNING_CTL_START_NID  0xC0
+	WEDGE_ANGLE = TUNING_CTL_START_NID,
+	SVM_LEVEL,
+	EQUALIZER_BAND_0,
+	EQUALIZER_BAND_1,
+	EQUALIZER_BAND_2,
+	EQUALIZER_BAND_3,
+	EQUALIZER_BAND_4,
+	EQUALIZER_BAND_5,
+	EQUALIZER_BAND_6,
+	EQUALIZER_BAND_7,
+	EQUALIZER_BAND_8,
+	EQUALIZER_BAND_9,
+	TUNING_CTL_END_NID
+#define TUNING_CTLS_COUNT  (TUNING_CTL_END_NID - TUNING_CTL_START_NID)
+};
+
+struct ct_tuning_ctl {
+	char name[44];
+	hda_nid_t parent_nid;
+	hda_nid_t nid;
+	int mid; /*effect module ID*/
+	int req; /*effect module request*/
+	int direct; /* 0:output; 1:input*/
+	unsigned int def_val;/*effect default values*/
+};
+
+static struct ct_tuning_ctl ca0132_tuning_ctls[] = {
+	{ "Wedge Angle",
+		VOICE_FOCUS,
+		WEDGE_ANGLE,
+		0x95,
+		8,
+		1,
+		0x41F00000
+	},
+	{ "SVM Level",
+		MIC_SVM,
+		SVM_LEVEL,
+		0x95,
+		45,
+		1,
+		0x3F3D70A4
+	},
+	{ "EQ Band0",
+		EQUALIZER,
+		EQUALIZER_BAND_0,
+		0x96,
+		11,
+		0,
+		0x00000000
+	},
+	{ "EQ Band1",
+		EQUALIZER,
+		EQUALIZER_BAND_1,
+		0x96,
+		12,
+		0,
+		0x00000000
+	},
+	{ "EQ Band2",
+		EQUALIZER,
+		EQUALIZER_BAND_2,
+		0x96,
+		13,
+		0,
+		0x00000000
+	},
+	{ "EQ Band3",
+		EQUALIZER,
+		EQUALIZER_BAND_3,
+		0x96,
+		14,
+		0,
+		0x00000000
+	},
+	{ "EQ Band4",
+		EQUALIZER,
+		EQUALIZER_BAND_4,
+		0x96,
+		15,
+		0,
+		0x00000000
+	},
+	{ "EQ Band5",
+		EQUALIZER,
+		EQUALIZER_BAND_5,
+		0x96,
+		16,
+		0,
+		0x00000000
+	},
+	{ "EQ Band6",
+		EQUALIZER,
+		EQUALIZER_BAND_6,
+		0x96,
+		17,
+		0,
+		0x00000000
+	},
+	{ "EQ Band7",
+		EQUALIZER,
+		EQUALIZER_BAND_7,
+		0x96,
+		18,
+		0,
+		0x00000000
+	},
+	{ "EQ Band8",
+		EQUALIZER,
+		EQUALIZER_BAND_8,
+		0x96,
+		19,
+		0,
+		0x00000000
+	},
+	{ "EQ Band9",
+		EQUALIZER,
+		EQUALIZER_BAND_9,
+		0x96,
+		20,
+		0,
+		0x00000000
+	}
+};
+#endif
+
+/* Voice FX Presets */
+#define VOICEFX_MAX_PARAM_COUNT 9
+
+struct ct_voicefx {
+	char *name;
+	hda_nid_t nid;
+	int mid;
+	int reqs[VOICEFX_MAX_PARAM_COUNT]; /*effect module request*/
+};
+
+struct ct_voicefx_preset {
+	char *name; /*preset name*/
+	unsigned int vals[VOICEFX_MAX_PARAM_COUNT];
+};
+
+struct ct_voicefx ca0132_voicefx = {
+	"VoiceFX Capture Switch",
+	VOICEFX,
+	0x95,
+	{10, 11, 12, 13, 14, 15, 16, 17, 18}
+};
+
+struct ct_voicefx_preset ca0132_voicefx_presets[] = {
+	{ "Neutral",
+		{ 0x00000000, 0x43C80000, 0x44AF0000,
+		  0x44FA0000, 0x3F800000, 0x3F800000,
+		  0x3F800000, 0x00000000, 0x00000000 }
+	},
+	{ "Female2Male",
+		{ 0x3F800000, 0x43C80000, 0x44AF0000,
+		  0x44FA0000, 0x3F19999A, 0x3F866666,
+		  0x3F800000, 0x00000000, 0x00000000 }
+	},
+	{ "Male2Female",
+		{ 0x3F800000, 0x43C80000, 0x44AF0000,
+		  0x450AC000, 0x4017AE14, 0x3F6B851F,
+		  0x3F800000, 0x00000000, 0x00000000 }
+	},
+	{ "ScrappyKid",
+		{ 0x3F800000, 0x43C80000, 0x44AF0000,
+		  0x44FA0000, 0x40400000, 0x3F28F5C3,
+		  0x3F800000, 0x00000000, 0x00000000 }
+	},
+	{ "Elderly",
+		{ 0x3F800000, 0x44324000, 0x44BB8000,
+		  0x44E10000, 0x3FB33333, 0x3FB9999A,
+		  0x3F800000, 0x3E3A2E43, 0x00000000 }
+	},
+	{ "Orc",
+		{ 0x3F800000, 0x43EA0000, 0x44A52000,
+		  0x45098000, 0x3F266666, 0x3FC00000,
+		  0x3F800000, 0x00000000, 0x00000000 }
+	},
+	{ "Elf",
+		{ 0x3F800000, 0x43C70000, 0x44AE6000,
+		  0x45193000, 0x3F8E147B, 0x3F75C28F,
+		  0x3F800000, 0x00000000, 0x00000000 }
+	},
+	{ "Dwarf",
+		{ 0x3F800000, 0x43930000, 0x44BEE000,
+		  0x45007000, 0x3F451EB8, 0x3F7851EC,
+		  0x3F800000, 0x00000000, 0x00000000 }
+	},
+	{ "AlienBrute",
+		{ 0x3F800000, 0x43BFC5AC, 0x44B28FDF,
+		  0x451F6000, 0x3F266666, 0x3FA7D945,
+		  0x3F800000, 0x3CF5C28F, 0x00000000 }
+	},
+	{ "Robot",
+		{ 0x3F800000, 0x43C80000, 0x44AF0000,
+		  0x44FA0000, 0x3FB2718B, 0x3F800000,
+		  0xBC07010E, 0x00000000, 0x00000000 }
+	},
+	{ "Marine",
+		{ 0x3F800000, 0x43C20000, 0x44906000,
+		  0x44E70000, 0x3F4CCCCD, 0x3F8A3D71,
+		  0x3F0A3D71, 0x00000000, 0x00000000 }
+	},
+	{ "Emo",
+		{ 0x3F800000, 0x43C80000, 0x44AF0000,
+		  0x44FA0000, 0x3F800000, 0x3F800000,
+		  0x3E4CCCCD, 0x00000000, 0x00000000 }
+	},
+	{ "DeepVoice",
+		{ 0x3F800000, 0x43A9C5AC, 0x44AA4FDF,
+		  0x44FFC000, 0x3EDBB56F, 0x3F99C4CA,
+		  0x3F800000, 0x00000000, 0x00000000 }
+	},
+	{ "Munchkin",
+		{ 0x3F800000, 0x43C80000, 0x44AF0000,
+		  0x44FA0000, 0x3F800000, 0x3F1A043C,
+		  0x3F800000, 0x00000000, 0x00000000 }
+	}
+};
+
 enum hda_cmd_vendor_io {
 	/* for DspIO node */
 	VENDOR_DSPIO_SCP_WRITE_DATA_LOW      = 0x000,
@@ -184,8 +581,16 @@ enum control_flag_id {
  * Control parameter IDs
  */
 enum control_param_id {
+	/* 0: None, 1: Mic1In*/
+	CONTROL_PARAM_VIP_SOURCE               = 1,
 	/* 0: force HDA, 1: allow DSP if HDA Spdif1Out stream is idle */
 	CONTROL_PARAM_SPDIF1_SOURCE            = 2,
+	/* Port A output stage gain setting to use when 16 Ohm output
+	 * impedance is selected*/
+	CONTROL_PARAM_PORTA_160OHM_GAIN        = 8,
+	/* Port D output stage gain setting to use when 16 Ohm output
+	 * impedance is selected*/
+	CONTROL_PARAM_PORTD_160OHM_GAIN        = 10,
 
 	/* Stream Control */
 
@@ -304,8 +709,6 @@ static void init_input(struct hda_codec *codec, hda_nid_t pin, hda_nid_t adc)
 				    AMP_IN_UNMUTE(0));
 }
 
-static char *dirstr[2] = { "Playback", "Capture" };
-
 static int _add_switch(struct hda_codec *codec, hda_nid_t nid, const char *pfx,
 		       int chan, int dir)
 {
@@ -2190,6 +2593,38 @@ static bool dspload_wait_loaded(struct hda_codec *codec)
 	return false;
 }
 
+
+/*
+ * Mixer controls helpers.
+ */
+#define CA0132_CODEC_VOL_MONO(xname, nid, channel, dir) \
+	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	  .name = xname, \
+	  .subdevice = HDA_SUBDEV_AMP_FLAG, \
+	  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | \
+			SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+			SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK, \
+	  .info = ca0132_volume_info, \
+	  .get = ca0132_volume_get, \
+	  .put = ca0132_volume_put, \
+	  .tlv = { .c = ca0132_volume_tlv }, \
+	  .private_value = HDA_COMPOSE_AMP_VAL(nid, channel, 0, dir) }
+
+#define CA0132_CODEC_MUTE_MONO(xname, nid, channel, dir) \
+	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	  .name = xname, \
+	  .subdevice = HDA_SUBDEV_AMP_FLAG, \
+	  .info = snd_hda_mixer_amp_switch_info, \
+	  .get = ca0132_switch_get, \
+	  .put = ca0132_switch_put, \
+	  .private_value = HDA_COMPOSE_AMP_VAL(nid, channel, 0, dir) }
+
+/* stereo */
+#define CA0132_CODEC_VOL(xname, nid, dir) \
+	CA0132_CODEC_VOL_MONO(xname, nid, 3, dir)
+#define CA0132_CODEC_MUTE(xname, nid, dir) \
+	CA0132_CODEC_MUTE_MONO(xname, nid, 3, dir)
+
 /*
  * PCM callbacks
  */
-- 
1.7.4.1
