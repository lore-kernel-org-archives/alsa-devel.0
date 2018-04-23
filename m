From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH] patch_ca0132.c: Handle SBZ and R3Di sound cards
Date: Sun, 22 Apr 2018 21:11:06 -0400
Message-ID: <1524445866-3586-1-git-send-email-conmanx360@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f54.google.com (mail-it0-f54.google.com
 [209.85.214.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 304CD267284
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 03:12:07 +0200 (CEST)
Received: by mail-it0-f54.google.com with SMTP id h143-v6so8881555ita.4
 for <alsa-devel@alsa-project.org>; Sun, 22 Apr 2018 18:12:07 -0700 (PDT)
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
Cc: Connor McAdams <conmanx360@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch adds support for the Sound Blaster Z and the Recon3Di.

With the current version, both cards only had one output supported, and
none of the inputs were working. This patch adds support for all
outputs and inputs, digital and analog. It also adds support for the
onboard DSP effects for both input and output.

This patch changes the control names for both cards to accommodate
surround sound controls. The main effect switches, "PlayEnhancement" for
output, and "CrystalVoice" for input, have been changed to "Enable
OutFX" for output, and "Enable InFX" for input to make them more clear.
Also, all DSP related effects have the prefix "FX:" attached to them, to
make it more clear that "Enable *dir*FX" enables or disables them.
Controls have also been added to change the effect levels of the
individual effects, through a volume slider.

This patch also adds support for alternative firmware for both cards,
under the names "ctefx-sbz.bin" for the Sound Blaster Z, and
"ctefx-r3di.bin" for the Recon3Di. These firmwares are not necessary
however, and there is a switch to use the original ctefx.bin file if
neither alternative firmwares are detected.

This patch also adds the ability to set the DSP volume, which is set
with a decibel value sent in floating point.

The only issue I'm aware of at this point is an "Unexpected TLV callback
for slave Front Playback Volume", which relates to the vmaster control.
For some reason, the TLV data doesn't match the rest of the controls,
even though they seem to share the same tlv function.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 3313 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 3064 insertions(+), 249 deletions(-)
 mode change 100644 => 100755 sound/pci/hda/patch_ca0132.c

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
old mode 100644
new mode 100755
index 768ea86..ddbb658
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -22,13 +22,14 @@
  */
 
 #include <linux/init.h>
+#include <linux/types.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
 #include <linux/firmware.h>
-#include <linux/kernel.h>
-#include <sound/core.h>
+#include <linux/io.h>
+#include <linux/pci.h>
 #include "hda_codec.h"
 #include "hda_local.h"
 #include "hda_auto_parser.h"
@@ -39,10 +40,11 @@
 /* Enable this to see controls for tuning purpose. */
 /*#define ENABLE_TUNING_CONTROLS*/
 
-#define FLOAT_ZERO	0x00000000
-#define FLOAT_ONE	0x3f800000
-#define FLOAT_TWO	0x40000000
-#define FLOAT_MINUS_5	0xc0a00000
+#define FLOAT_0	0x00000000
+#define FLOAT_1	0x3F800000
+#define FLOAT_2	0x40000000
+#define FLOAT_3	0x40400000
+#define FLOAT_8	0x41000000
 
 #define UNSOL_TAG_DSP	0x16
 
@@ -64,29 +66,44 @@
 #define MEM_CONNID_MICIN2     5
 #define MEM_CONNID_MICOUT1    12
 #define MEM_CONNID_MICOUT2    14
-#define MEM_CONNID_WUH        10
-#define MEM_CONNID_DSP        16
+#define MEM_CONNID_WUH	      10
+#define MEM_CONNID_DSP	      16
 #define MEM_CONNID_DMIC       100
 
 #define SCP_SET    0
 #define SCP_GET    1
 
-#define EFX_FILE   "ctefx.bin"
+#define EFX_FILE      "ctefx.bin"
+#define SBZ_EFX_FILE  "ctefx-sbz.bin"
+#define R3DI_EFX_FILE "ctefx-r3di.bin"
 
 #ifdef CONFIG_SND_HDA_CODEC_CA0132_DSP
 MODULE_FIRMWARE(EFX_FILE);
+MODULE_FIRMWARE(SBZ_EFX_FILE);
+MODULE_FIRMWARE(R3DI_EFX_FILE);
 #endif
 
 static char *dirstr[2] = { "Playback", "Capture" };
 
+#define SBZ_NUM_OF_OUTPUTS 3
 enum {
 	SPEAKER_OUT,
-	HEADPHONE_OUT
+	HEADPHONE_OUT,
+	SURROUND_OUT
 };
 
 enum {
 	DIGITAL_MIC,
-	LINE_MIC_IN
+	LINE_MIC_IN,
+};
+
+/* Strings for Input Source Enum Control */
+static char *in_src_str[3] = {"Rear Mic", "Line", "Front Mic" };
+#define IN_SRC_NUM_OF_INPUTS 3
+enum {
+	REAR_MIC,
+	REAR_LINE_IN,
+	FRONT_MIC,
 };
 
 enum {
@@ -101,7 +118,7 @@ enum {
 #define VNODES_COUNT  (VNODE_END_NID - VNODE_START_NID)
 
 #define EFFECT_START_NID    0x90
-#define OUT_EFFECT_START_NID    EFFECT_START_NID
+#define OUT_EFFECT_START_NID	EFFECT_START_NID
 	SURROUND = OUT_EFFECT_START_NID,
 	CRYSTALIZER,
 	DIALOG_PLUS,
@@ -122,19 +139,45 @@ enum {
 	VOICEFX = IN_EFFECT_END_NID,
 	PLAY_ENHANCEMENT,
 	CRYSTAL_VOICE,
-	EFFECT_END_NID
+	EFFECT_END_NID,
+	OUTPUT_SOURCE_ENUM,
+	INPUT_SOURCE_ENUM,
+	XBASS_XOVER,
+	EQ_PRESET_ENUM,
+	SMART_VOLUME_ENUM,
+	MIC_BOOST_ENUM
 #define EFFECTS_COUNT  (EFFECT_END_NID - EFFECT_START_NID)
 };
 
+/* Strings for Smart Volume Setting enum */
+#define NUM_OF_SVM_SETTINGS 3
+static char *out_svm_set_enum_str[3] = {"Normal", "Loud", "Night" };
+
 /* Effects values size*/
 #define EFFECT_VALS_MAX_COUNT 12
 
+/*
+ * Maximum amount of commands used for the ca0132_alt_out_select
+ * SCP command struct.
+ */
+#define ALT_OUT_SET_MAX_COMMANDS 9
+
+/* Amount of effect level sliders */
+#define EFFECT_LEVEL_SLIDERS 5
+
+/*
+ * Default values for the effect slider controls, they are in order of their
+ * effect NID's. Surround, Crystalizer, Dialog Plus, Smart Volume, and then
+ * X-bass.
+ */
+static unsigned int effect_slider_defaults[] = {67, 65, 50, 74, 50};
+
 /* Latency introduced by DSP blocks in milliseconds. */
-#define DSP_CAPTURE_INIT_LATENCY        0
-#define DSP_CRYSTAL_VOICE_LATENCY       124
-#define DSP_PLAYBACK_INIT_LATENCY       13
-#define DSP_PLAY_ENHANCEMENT_LATENCY    30
-#define DSP_SPEAKER_OUT_LATENCY         7
+#define DSP_CAPTURE_INIT_LATENCY	0
+#define DSP_CRYSTAL_VOICE_LATENCY	124
+#define DSP_PLAYBACK_INIT_LATENCY	13
+#define DSP_PLAY_ENHANCEMENT_LATENCY	30
+#define DSP_SPEAKER_OUT_LATENCY		7
 
 struct ct_effect {
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
@@ -472,63 +515,213 @@ static struct ct_voicefx_preset ca0132_voicefx_presets[] = {
 	}
 };
 
+/* ca0132 EQ presets, taken from Windows Sound Blaster Z Driver */
+
+#define EQ_PRESET_MAX_PARAM_COUNT 11
+
+struct ct_eq {
+	char *name;
+	hda_nid_t nid;
+	int mid;
+	int reqs[EQ_PRESET_MAX_PARAM_COUNT]; /*effect module request*/
+};
+
+struct ct_eq_preset {
+	char *name; /*preset name*/
+	unsigned int vals[EQ_PRESET_MAX_PARAM_COUNT];
+};
+
+static struct ct_eq ca0132_alt_eq_enum = {
+	.name = "FX: Equalizer Preset Switch",
+	.nid = EQ_PRESET_ENUM,
+	.mid = 0x96,
+	.reqs = {10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}
+};
+
+
+static struct ct_eq_preset ca0132_alt_eq_presets[] = {
+	{ .name = "Flat",
+	 .vals = { 0x00000000, 0x00000000, 0x00000000,
+		   0x00000000, 0x00000000, 0x00000000,
+		   0x00000000, 0x00000000, 0x00000000,
+		   0x00000000, 0x00000000	     }
+	},
+	{ .name = "Acoustic",
+	 .vals = { 0x00000000, 0x00000000, 0x3F8CCCCD,
+		   0x40000000, 0x00000000, 0x00000000,
+		   0x00000000, 0x00000000, 0x40000000,
+		   0x40000000, 0x40000000	     }
+	},
+	{ .name = "Classical",
+	 .vals = { 0x00000000, 0x00000000, 0x40C00000,
+		   0x40C00000, 0x40466666, 0x00000000,
+		   0x00000000, 0x00000000, 0x00000000,
+		   0x40466666, 0x40466666	     }
+	},
+	{ .name = "Country",
+	 .vals = { 0x00000000, 0xBF99999A, 0x00000000,
+		   0x3FA66666, 0x3FA66666, 0x3F8CCCCD,
+		   0x00000000, 0x00000000, 0x40000000,
+		   0x40466666, 0x40800000	     }
+	},
+	{ .name = "Dance",
+	 .vals = { 0x00000000, 0xBF99999A, 0x40000000,
+		   0x40466666, 0x40866666, 0xBF99999A,
+		   0xBF99999A, 0x00000000, 0x00000000,
+		   0x40800000, 0x40800000	     }
+	},
+	{ .name = "Jazz",
+	 .vals = { 0x00000000, 0x00000000, 0x00000000,
+		   0x3F8CCCCD, 0x40800000, 0x40800000,
+		   0x40800000, 0x00000000, 0x3F8CCCCD,
+		   0x40466666, 0x40466666	     }
+	},
+	{ .name = "New Age",
+	 .vals = { 0x00000000, 0x00000000, 0x40000000,
+		   0x40000000, 0x00000000, 0x00000000,
+		   0x00000000, 0x3F8CCCCD, 0x40000000,
+		   0x40000000, 0x40000000	     }
+	},
+	{ .name = "Pop",
+	 .vals = { 0x00000000, 0xBFCCCCCD, 0x00000000,
+		   0x40000000, 0x40000000, 0x00000000,
+		   0xBF99999A, 0xBF99999A, 0x00000000,
+		   0x40466666, 0x40C00000	     }
+	},
+	{ .name = "Rock",
+	 .vals = { 0x00000000, 0xBF99999A, 0xBF99999A,
+		   0x3F8CCCCD, 0x40000000, 0xBF99999A,
+		   0xBF99999A, 0x00000000, 0x00000000,
+		   0x40800000, 0x40800000	     }
+	},
+	{ .name = "Vocal",
+	 .vals = { 0x00000000, 0xC0000000, 0xBF99999A,
+		   0xBF99999A, 0x00000000, 0x40466666,
+		   0x40800000, 0x40466666, 0x00000000,
+		   0x00000000, 0x3F8CCCCD	     }
+	}
+};
+
+/* DSP commands for the alternative ca0132 codec's output modes */
+
+struct ca0132_alt_out_set {
+	char *name; /*preset name*/
+	unsigned char commands;
+	unsigned int mids[ALT_OUT_SET_MAX_COMMANDS];
+	unsigned int reqs[ALT_OUT_SET_MAX_COMMANDS];
+	unsigned int vals[ALT_OUT_SET_MAX_COMMANDS];
+};
+
+static struct ca0132_alt_out_set alt_out_presets[] = {
+	{ .name = "Line Out",
+	  .commands = 7,
+	  .mids = { 0x96, 0x96, 0x96, 0x8F,
+		    0x96, 0x96, 0x96 },
+	  .reqs = { 0x19, 0x17, 0x18, 0x01,
+		    0x1F, 0x15, 0x3A },
+	  .vals = { 0x3F000000, 0x42A00000, 0x00000000,
+		    0x00000000, 0x00000000, 0x00000000,
+		    0x00000000 }
+	},
+	{ .name = "Headphone",
+	  .commands = 7,
+	  .mids = { 0x96, 0x96, 0x96, 0x8F,
+		    0x96, 0x96, 0x96 },
+	  .reqs = { 0x19, 0x17, 0x18, 0x01,
+		    0x1F, 0x15, 0x3A },
+	  .vals = { 0x3F000000, 0x42A00000, 0x00000000,
+		    0x00000000, 0x00000000, 0x00000000,
+		    0x00000000 }
+	},
+	{ .name = "Surround",
+	  .commands = 8,
+	  .mids = { 0x96, 0x8F, 0x96, 0x96,
+		    0x96, 0x96, 0x96, 0x96 },
+	  .reqs = { 0x18, 0x01, 0x1F, 0x15,
+		    0x3A, 0x1A, 0x1B, 0x1C },
+	  .vals = { 0x00000000, 0x00000000, 0x00000000,
+		    0x00000000, 0x00000000, 0x00000000,
+		    0x00000000, 0x00000000 }
+	}
+};
+
+#define DSP_VOL_OUT 0
+#define DSP_VOL_IN  1
+
+struct ct_dsp_volume_ctl {
+	hda_nid_t vnid;
+	int mid; /*effect module ID*/
+	unsigned int reqs[3]; /*effect module request*/
+};
+
+static struct ct_dsp_volume_ctl ca0132_alt_vol_ctls[] = {
+	{ .vnid = VNID_SPK,
+	  .mid = 0x32,
+	  .reqs = {3, 4, 2}
+	},
+	{ .vnid = VNID_MIC,
+	  .mid = 0x37,
+	  .reqs = {1, 2, 3}
+	}
+};
+
 enum hda_cmd_vendor_io {
 	/* for DspIO node */
 	VENDOR_DSPIO_SCP_WRITE_DATA_LOW      = 0x000,
 	VENDOR_DSPIO_SCP_WRITE_DATA_HIGH     = 0x100,
 
-	VENDOR_DSPIO_STATUS                  = 0xF01,
+	VENDOR_DSPIO_STATUS		     = 0xF01,
 	VENDOR_DSPIO_SCP_POST_READ_DATA      = 0x702,
-	VENDOR_DSPIO_SCP_READ_DATA           = 0xF02,
-	VENDOR_DSPIO_DSP_INIT                = 0x703,
+	VENDOR_DSPIO_SCP_READ_DATA	     = 0xF02,
+	VENDOR_DSPIO_DSP_INIT		     = 0x703,
 	VENDOR_DSPIO_SCP_POST_COUNT_QUERY    = 0x704,
-	VENDOR_DSPIO_SCP_READ_COUNT          = 0xF04,
+	VENDOR_DSPIO_SCP_READ_COUNT	     = 0xF04,
 
 	/* for ChipIO node */
-	VENDOR_CHIPIO_ADDRESS_LOW            = 0x000,
-	VENDOR_CHIPIO_ADDRESS_HIGH           = 0x100,
-	VENDOR_CHIPIO_STREAM_FORMAT          = 0x200,
-	VENDOR_CHIPIO_DATA_LOW               = 0x300,
-	VENDOR_CHIPIO_DATA_HIGH              = 0x400,
+	VENDOR_CHIPIO_ADDRESS_LOW	     = 0x000,
+	VENDOR_CHIPIO_ADDRESS_HIGH	     = 0x100,
+	VENDOR_CHIPIO_STREAM_FORMAT	     = 0x200,
+	VENDOR_CHIPIO_DATA_LOW		     = 0x300,
+	VENDOR_CHIPIO_DATA_HIGH		     = 0x400,
 
-	VENDOR_CHIPIO_GET_PARAMETER          = 0xF00,
-	VENDOR_CHIPIO_STATUS                 = 0xF01,
-	VENDOR_CHIPIO_HIC_POST_READ          = 0x702,
-	VENDOR_CHIPIO_HIC_READ_DATA          = 0xF03,
+	VENDOR_CHIPIO_GET_PARAMETER	     = 0xF00,
+	VENDOR_CHIPIO_STATUS		     = 0xF01,
+	VENDOR_CHIPIO_HIC_POST_READ	     = 0x702,
+	VENDOR_CHIPIO_HIC_READ_DATA	     = 0xF03,
 
-	VENDOR_CHIPIO_8051_DATA_WRITE        = 0x707,
-	VENDOR_CHIPIO_8051_DATA_READ         = 0xF07,
+	VENDOR_CHIPIO_8051_DATA_WRITE	     = 0x707,
+	VENDOR_CHIPIO_8051_DATA_READ	     = 0xF07,
 
 	VENDOR_CHIPIO_CT_EXTENSIONS_ENABLE   = 0x70A,
 	VENDOR_CHIPIO_CT_EXTENSIONS_GET      = 0xF0A,
 
-	VENDOR_CHIPIO_PLL_PMU_WRITE          = 0x70C,
-	VENDOR_CHIPIO_PLL_PMU_READ           = 0xF0C,
-	VENDOR_CHIPIO_8051_ADDRESS_LOW       = 0x70D,
+	VENDOR_CHIPIO_PLL_PMU_WRITE	     = 0x70C,
+	VENDOR_CHIPIO_PLL_PMU_READ	     = 0xF0C,
+	VENDOR_CHIPIO_8051_ADDRESS_LOW	     = 0x70D,
 	VENDOR_CHIPIO_8051_ADDRESS_HIGH      = 0x70E,
-	VENDOR_CHIPIO_FLAG_SET               = 0x70F,
-	VENDOR_CHIPIO_FLAGS_GET              = 0xF0F,
-	VENDOR_CHIPIO_PARAM_SET              = 0x710,
-	VENDOR_CHIPIO_PARAM_GET              = 0xF10,
+	VENDOR_CHIPIO_FLAG_SET		     = 0x70F,
+	VENDOR_CHIPIO_FLAGS_GET		     = 0xF0F,
+	VENDOR_CHIPIO_PARAM_SET		     = 0x710,
+	VENDOR_CHIPIO_PARAM_GET		     = 0xF10,
 
 	VENDOR_CHIPIO_PORT_ALLOC_CONFIG_SET  = 0x711,
-	VENDOR_CHIPIO_PORT_ALLOC_SET         = 0x712,
-	VENDOR_CHIPIO_PORT_ALLOC_GET         = 0xF12,
-	VENDOR_CHIPIO_PORT_FREE_SET          = 0x713,
+	VENDOR_CHIPIO_PORT_ALLOC_SET	     = 0x712,
+	VENDOR_CHIPIO_PORT_ALLOC_GET	     = 0xF12,
+	VENDOR_CHIPIO_PORT_FREE_SET	     = 0x713,
 
-	VENDOR_CHIPIO_PARAM_EX_ID_GET        = 0xF17,
-	VENDOR_CHIPIO_PARAM_EX_ID_SET        = 0x717,
+	VENDOR_CHIPIO_PARAM_EX_ID_GET	     = 0xF17,
+	VENDOR_CHIPIO_PARAM_EX_ID_SET	     = 0x717,
 	VENDOR_CHIPIO_PARAM_EX_VALUE_GET     = 0xF18,
 	VENDOR_CHIPIO_PARAM_EX_VALUE_SET     = 0x718,
 
-	VENDOR_CHIPIO_DMIC_CTL_SET           = 0x788,
-	VENDOR_CHIPIO_DMIC_CTL_GET           = 0xF88,
-	VENDOR_CHIPIO_DMIC_PIN_SET           = 0x789,
-	VENDOR_CHIPIO_DMIC_PIN_GET           = 0xF89,
-	VENDOR_CHIPIO_DMIC_MCLK_SET          = 0x78A,
-	VENDOR_CHIPIO_DMIC_MCLK_GET          = 0xF8A,
+	VENDOR_CHIPIO_DMIC_CTL_SET	     = 0x788,
+	VENDOR_CHIPIO_DMIC_CTL_GET	     = 0xF88,
+	VENDOR_CHIPIO_DMIC_PIN_SET	     = 0x789,
+	VENDOR_CHIPIO_DMIC_PIN_GET	     = 0xF89,
+	VENDOR_CHIPIO_DMIC_MCLK_SET	     = 0x78A,
+	VENDOR_CHIPIO_DMIC_MCLK_GET	     = 0xF8A,
 
-	VENDOR_CHIPIO_EAPD_SEL_SET           = 0x78D
+	VENDOR_CHIPIO_EAPD_SEL_SET	     = 0x78D
 };
 
 /*
@@ -536,41 +729,41 @@ enum hda_cmd_vendor_io {
  */
 enum control_flag_id {
 	/* Connection manager stream setup is bypassed/enabled */
-	CONTROL_FLAG_C_MGR                  = 0,
+	CONTROL_FLAG_C_MGR		    = 0,
 	/* DSP DMA is bypassed/enabled */
-	CONTROL_FLAG_DMA                    = 1,
+	CONTROL_FLAG_DMA		    = 1,
 	/* 8051 'idle' mode is disabled/enabled */
-	CONTROL_FLAG_IDLE_ENABLE            = 2,
+	CONTROL_FLAG_IDLE_ENABLE	    = 2,
 	/* Tracker for the SPDIF-in path is bypassed/enabled */
-	CONTROL_FLAG_TRACKER                = 3,
+	CONTROL_FLAG_TRACKER		    = 3,
 	/* DigitalOut to Spdif2Out connection is disabled/enabled */
-	CONTROL_FLAG_SPDIF2OUT              = 4,
+	CONTROL_FLAG_SPDIF2OUT		    = 4,
 	/* Digital Microphone is disabled/enabled */
-	CONTROL_FLAG_DMIC                   = 5,
+	CONTROL_FLAG_DMIC		    = 5,
 	/* ADC_B rate is 48 kHz/96 kHz */
-	CONTROL_FLAG_ADC_B_96KHZ            = 6,
+	CONTROL_FLAG_ADC_B_96KHZ	    = 6,
 	/* ADC_C rate is 48 kHz/96 kHz */
-	CONTROL_FLAG_ADC_C_96KHZ            = 7,
+	CONTROL_FLAG_ADC_C_96KHZ	    = 7,
 	/* DAC rate is 48 kHz/96 kHz (affects all DACs) */
-	CONTROL_FLAG_DAC_96KHZ              = 8,
+	CONTROL_FLAG_DAC_96KHZ		    = 8,
 	/* DSP rate is 48 kHz/96 kHz */
-	CONTROL_FLAG_DSP_96KHZ              = 9,
+	CONTROL_FLAG_DSP_96KHZ		    = 9,
 	/* SRC clock is 98 MHz/196 MHz (196 MHz forces rate to 96 KHz) */
-	CONTROL_FLAG_SRC_CLOCK_196MHZ       = 10,
+	CONTROL_FLAG_SRC_CLOCK_196MHZ	    = 10,
 	/* SRC rate is 48 kHz/96 kHz (48 kHz disabled when clock is 196 MHz) */
-	CONTROL_FLAG_SRC_RATE_96KHZ         = 11,
+	CONTROL_FLAG_SRC_RATE_96KHZ	    = 11,
 	/* Decode Loop (DSP->SRC->DSP) is disabled/enabled */
-	CONTROL_FLAG_DECODE_LOOP            = 12,
+	CONTROL_FLAG_DECODE_LOOP	    = 12,
 	/* De-emphasis filter on DAC-1 disabled/enabled */
-	CONTROL_FLAG_DAC1_DEEMPHASIS        = 13,
+	CONTROL_FLAG_DAC1_DEEMPHASIS	    = 13,
 	/* De-emphasis filter on DAC-2 disabled/enabled */
-	CONTROL_FLAG_DAC2_DEEMPHASIS        = 14,
+	CONTROL_FLAG_DAC2_DEEMPHASIS	    = 14,
 	/* De-emphasis filter on DAC-3 disabled/enabled */
-	CONTROL_FLAG_DAC3_DEEMPHASIS        = 15,
+	CONTROL_FLAG_DAC3_DEEMPHASIS	    = 15,
 	/* High-pass filter on ADC_B disabled/enabled */
-	CONTROL_FLAG_ADC_B_HIGH_PASS        = 16,
+	CONTROL_FLAG_ADC_B_HIGH_PASS	    = 16,
 	/* High-pass filter on ADC_C disabled/enabled */
-	CONTROL_FLAG_ADC_C_HIGH_PASS        = 17,
+	CONTROL_FLAG_ADC_C_HIGH_PASS	    = 17,
 	/* Common mode on Port_A disabled/enabled */
 	CONTROL_FLAG_PORT_A_COMMON_MODE     = 18,
 	/* Common mode on Port_D disabled/enabled */
@@ -580,7 +773,7 @@ enum control_flag_id {
 	/* Impedance for ramp generator on Port_D, 16 Ohm/10K Ohm */
 	CONTROL_FLAG_PORT_D_10KOHM_LOAD     = 21,
 	/* ASI rate is 48kHz/96kHz */
-	CONTROL_FLAG_ASI_96KHZ              = 22,
+	CONTROL_FLAG_ASI_96KHZ		    = 22,
 	/* DAC power settings able to control attached ports no/yes */
 	CONTROL_FLAG_DACS_CONTROL_PORTS     = 23,
 	/* Clock Stop OK reporting is disabled/enabled */
@@ -594,9 +787,9 @@ enum control_flag_id {
  */
 enum control_param_id {
 	/* 0: None, 1: Mic1In*/
-	CONTROL_PARAM_VIP_SOURCE               = 1,
+	CONTROL_PARAM_VIP_SOURCE	       = 1,
 	/* 0: force HDA, 1: allow DSP if HDA Spdif1Out stream is idle */
-	CONTROL_PARAM_SPDIF1_SOURCE            = 2,
+	CONTROL_PARAM_SPDIF1_SOURCE	       = 2,
 	/* Port A output stage gain setting to use when 16 Ohm output
 	 * impedance is selected*/
 	CONTROL_PARAM_PORTA_160OHM_GAIN        = 8,
@@ -607,27 +800,27 @@ enum control_param_id {
 	/* Stream Control */
 
 	/* Select stream with the given ID */
-	CONTROL_PARAM_STREAM_ID                = 24,
+	CONTROL_PARAM_STREAM_ID		       = 24,
 	/* Source connection point for the selected stream */
 	CONTROL_PARAM_STREAM_SOURCE_CONN_POINT = 25,
 	/* Destination connection point for the selected stream */
 	CONTROL_PARAM_STREAM_DEST_CONN_POINT   = 26,
 	/* Number of audio channels in the selected stream */
-	CONTROL_PARAM_STREAMS_CHANNELS         = 27,
+	CONTROL_PARAM_STREAMS_CHANNELS	       = 27,
 	/*Enable control for the selected stream */
-	CONTROL_PARAM_STREAM_CONTROL           = 28,
+	CONTROL_PARAM_STREAM_CONTROL	       = 28,
 
 	/* Connection Point Control */
 
 	/* Select connection point with the given ID */
-	CONTROL_PARAM_CONN_POINT_ID            = 29,
+	CONTROL_PARAM_CONN_POINT_ID	       = 29,
 	/* Connection point sample rate */
 	CONTROL_PARAM_CONN_POINT_SAMPLE_RATE   = 30,
 
 	/* Node Control */
 
 	/* Select HDA node with the given ID */
-	CONTROL_PARAM_NODE_ID                  = 31
+	CONTROL_PARAM_NODE_ID		       = 31
 };
 
 /*
@@ -635,9 +828,9 @@ enum control_param_id {
  */
 enum hda_vendor_status_dspio {
 	/* Success */
-	VENDOR_STATUS_DSPIO_OK                       = 0x00,
+	VENDOR_STATUS_DSPIO_OK			     = 0x00,
 	/* Busy, unable to accept new command, the host must retry */
-	VENDOR_STATUS_DSPIO_BUSY                     = 0x01,
+	VENDOR_STATUS_DSPIO_BUSY		     = 0x01,
 	/* SCP command queue is full */
 	VENDOR_STATUS_DSPIO_SCP_COMMAND_QUEUE_FULL   = 0x02,
 	/* SCP response queue is empty */
@@ -658,24 +851,24 @@ enum hda_vendor_status_chipio {
  *  CA0132 sample rate
  */
 enum ca0132_sample_rate {
-	SR_6_000        = 0x00,
-	SR_8_000        = 0x01,
-	SR_9_600        = 0x02,
-	SR_11_025       = 0x03,
-	SR_16_000       = 0x04,
-	SR_22_050       = 0x05,
-	SR_24_000       = 0x06,
-	SR_32_000       = 0x07,
-	SR_44_100       = 0x08,
-	SR_48_000       = 0x09,
-	SR_88_200       = 0x0A,
-	SR_96_000       = 0x0B,
-	SR_144_000      = 0x0C,
-	SR_176_400      = 0x0D,
-	SR_192_000      = 0x0E,
-	SR_384_000      = 0x0F,
-
-	SR_COUNT        = 0x10,
+	SR_6_000	= 0x00,
+	SR_8_000	= 0x01,
+	SR_9_600	= 0x02,
+	SR_11_025	= 0x03,
+	SR_16_000	= 0x04,
+	SR_22_050	= 0x05,
+	SR_24_000	= 0x06,
+	SR_32_000	= 0x07,
+	SR_44_100	= 0x08,
+	SR_48_000	= 0x09,
+	SR_88_200	= 0x0A,
+	SR_96_000	= 0x0B,
+	SR_144_000	= 0x0C,
+	SR_176_400	= 0x0D,
+	SR_192_000	= 0x0E,
+	SR_384_000	= 0x0F,
+
+	SR_COUNT	= 0x10,
 
 	SR_RATE_UNKNOWN = 0x1F
 };
@@ -684,7 +877,7 @@ enum dsp_download_state {
 	DSP_DOWNLOAD_FAILED = -1,
 	DSP_DOWNLOAD_INIT   = 0,
 	DSP_DOWNLOADING     = 1,
-	DSP_DOWNLOADED      = 2
+	DSP_DOWNLOADED	    = 2
 };
 
 /* retrieve parameters from hda format */
@@ -703,6 +896,7 @@ struct ca0132_spec {
 	const struct hda_verb *base_init_verbs;
 	const struct hda_verb *base_exit_verbs;
 	const struct hda_verb *chip_init_verbs;
+	const struct hda_verb *sbz_init_verbs;
 	struct hda_verb *spec_init_verbs;
 	struct auto_pin_cfg autocfg;
 
@@ -719,6 +913,7 @@ struct ca0132_spec {
 	hda_nid_t shared_mic_nid;
 	hda_nid_t shared_out_nid;
 	hda_nid_t unsol_tag_hp;
+	hda_nid_t unsol_tag_front_hp; /* alt_ca0132 specific */
 	hda_nid_t unsol_tag_amic1;
 
 	/* chip access */
@@ -734,6 +929,19 @@ struct ca0132_spec {
 	unsigned int scp_resp_header;
 	unsigned int scp_resp_data[4];
 	unsigned int scp_resp_count;
+	bool dsp_download_wakeup;
+	/*
+	 * true if alt-firmware is detected, if no alt-firmware is detected
+	 * the default ctefx.bin file will be used.
+	 */
+	bool alt_firmware_present;
+	bool sbz_failure_entered;
+
+	/*
+	 * Sound Blaster Z PCI region 2 iomem, used for input and output
+	 * switching, and other stuff I don't fully understand.
+	 */
+	void __iomem *mem_base;
 
 	/* mixer and effects related */
 	unsigned char dmic_ctl;
@@ -746,6 +954,16 @@ struct ca0132_spec {
 	long effects_switch[EFFECTS_COUNT];
 	long voicefx_val;
 	long cur_mic_boost;
+	/* Values related to the extra ca0132_alt controls */
+	unsigned char in_enum_val;
+	unsigned char out_enum_val;
+	unsigned char mic_boost_enum_val;
+	unsigned char smart_volume_setting;
+	long fx_ctl_val[EFFECT_LEVEL_SLIDERS];
+	long xbass_xover_freq;
+	long eq_preset_val;
+	unsigned int tlv[4];
+	struct hda_vmaster_mute_hook vmaster_mute;
 
 	struct hda_codec *codec;
 	struct delayed_work unsol_hp_work;
@@ -762,6 +980,8 @@ struct ca0132_spec {
 enum {
 	QUIRK_NONE,
 	QUIRK_ALIENWARE,
+	QUIRK_SBZ,
+	QUIRK_R3DI,
 };
 
 static const struct hda_pintbl alienware_pincfgs[] = {
@@ -778,10 +998,42 @@ static const struct hda_pintbl alienware_pincfgs[] = {
 	{}
 };
 
+/* Sound Blaster Z pin configs taken from Windows Driver */
+static const struct hda_pintbl sbz_pincfgs[] = {
+	{ 0x0b, 0x01017010 }, /* Port G -- Lineout FRONT L/R */
+	{ 0x0c, 0x014510f0 }, /* SPDIF Out 1 */
+	{ 0x0d, 0x014510f0 }, /* Digital Out */
+	{ 0x0e, 0x01c510f0 }, /* SPDIF In */
+	{ 0x0f, 0x0221701f }, /* Port A -- BackPanel HP */
+	{ 0x10, 0x01017012 }, /* Port D -- Center/LFE or FP Hp */
+	{ 0x11, 0x01017014 }, /* Port B -- LineMicIn2 / Rear L/R */
+	{ 0x12, 0x01a170f0 }, /* Port C -- LineIn1 */
+	{ 0x13, 0x908700f0 }, /* What U Hear In*/
+	{ 0x18, 0x50d000f0 }, /* N/A */
+	{}
+};
+
+/* Recon3D integrated pin configs taken from Windows Driver */
+static const struct hda_pintbl r3di_pincfgs[] = {
+	{ 0x0b, 0x01014110 }, /* Port G -- Lineout FRONT L/R */
+	{ 0x0c, 0x014510f0 }, /* SPDIF Out 1 */
+	{ 0x0d, 0x014510f0 }, /* Digital Out */
+	{ 0x0e, 0x41c520f0 }, /* SPDIF In */
+	{ 0x0f, 0x0221401f }, /* Port A -- BackPanel HP */
+	{ 0x10, 0x01016011 }, /* Port D -- Center/LFE or FP Hp */
+	{ 0x11, 0x01011014 }, /* Port B -- LineMicIn2 / Rear L/R */
+	{ 0x12, 0x02a090f0 }, /* Port C -- LineIn1 */
+	{ 0x13, 0x908700f0 }, /* What U Hear In*/
+	{ 0x18, 0x500000f0 }, /* N/A */
+	{}
+};
+
 static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1028, 0x0685, "Alienware 15 2015", QUIRK_ALIENWARE),
 	SND_PCI_QUIRK(0x1028, 0x0688, "Alienware 17 2015", QUIRK_ALIENWARE),
 	SND_PCI_QUIRK(0x1028, 0x0708, "Alienware 15 R2 2016", QUIRK_ALIENWARE),
+	SND_PCI_QUIRK(0x1102, 0x0010, "Sound Blaster Z", QUIRK_SBZ),
+	SND_PCI_QUIRK(0x1458, 0xA036, "Recon3Di", QUIRK_R3DI),
 	{}
 };
 
@@ -965,6 +1217,29 @@ static int chipio_write(struct hda_codec *codec,
 }
 
 /*
+ * Write given value to the given address through the chip I/O widget.
+ * not protected by the Mutex
+ */
+static int chipio_write_no_mutex(struct hda_codec *codec,
+		unsigned int chip_addx, const unsigned int data)
+{
+	int err;
+
+
+	/* write the address, and if successful proceed to write data */
+	err = chipio_write_address(codec, chip_addx);
+	if (err < 0)
+		goto exit;
+
+	err = chipio_write_data(codec, data);
+	if (err < 0)
+		goto exit;
+
+exit:
+	return err;
+}
+
+/*
  * Write multiple values to the given address through the chip I/O widget.
  * protected by the Mutex
  */
@@ -1039,6 +1314,9 @@ static void chipio_set_control_param(struct hda_codec *codec,
 	struct ca0132_spec *spec = codec->spec;
 	int val;
 
+	codec_dbg(codec, "chipio_param ID: %d val: 0x%02x",
+			param_id, param_val);
+
 	if ((param_id < 32) && (param_val < 8)) {
 		val = (param_val << 5) | (param_id);
 		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
@@ -1058,6 +1336,86 @@ static void chipio_set_control_param(struct hda_codec *codec,
 }
 
 /*
+ * Set chip parameters through the chip I/O widget. NO MUTEX.
+ */
+static void chipio_set_control_param_no_mutex(struct hda_codec *codec,
+		enum control_param_id param_id, int param_val)
+{
+	int val;
+
+	codec_dbg(codec, "chipio_param ID: %d val: 0x%02x",
+			param_id, param_val);
+
+	if ((param_id < 32) && (param_val < 8)) {
+		val = (param_val << 5) | (param_id);
+		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+				    VENDOR_CHIPIO_PARAM_SET, val);
+	} else {
+		if (chipio_send(codec, VENDOR_CHIPIO_STATUS, 0) == 0) {
+			snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+					    VENDOR_CHIPIO_PARAM_EX_ID_SET,
+					    param_id);
+			snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+					    VENDOR_CHIPIO_PARAM_EX_VALUE_SET,
+					    param_val);
+		}
+	}
+}
+/*
+ * Connect stream to a source point, and then connect
+ * that source point to a destination point.
+ */
+static void chipio_set_stream_source_dest(struct hda_codec *codec,
+				int streamid, int source_point, int dest_point)
+{
+
+	chipio_set_control_param_no_mutex(codec,
+			CONTROL_PARAM_STREAM_ID, streamid);
+	chipio_set_control_param_no_mutex(codec,
+			CONTROL_PARAM_STREAM_SOURCE_CONN_POINT, source_point);
+	chipio_set_control_param_no_mutex(codec,
+			CONTROL_PARAM_STREAM_DEST_CONN_POINT, dest_point);
+}
+
+/*
+ * Set number of channels in the selected stream.
+ */
+static void chipio_set_stream_channels(struct hda_codec *codec,
+				int streamid, unsigned int channels)
+{
+	chipio_set_control_param_no_mutex(codec, CONTROL_PARAM_STREAM_ID,
+			streamid);
+	chipio_set_control_param_no_mutex(codec, CONTROL_PARAM_STREAMS_CHANNELS,
+			channels);
+}
+
+/*
+ * Enable/Disable audio stream.
+ */
+static void chipio_set_stream_control(struct hda_codec *codec,
+				int streamid, int enable)
+{
+	codec_dbg(codec, "Stream: 0x%02x Val: %d", streamid, enable);
+	chipio_set_control_param_no_mutex(codec,
+			CONTROL_PARAM_STREAM_ID, streamid);
+	chipio_set_control_param_no_mutex(codec,
+			CONTROL_PARAM_STREAM_CONTROL, enable);
+}
+
+
+/*
+ * Set sampling rate of the connection point. NO MUTEX.
+ */
+static void chipio_set_conn_rate_no_mutex(struct hda_codec *codec,
+				int connid, enum ca0132_sample_rate rate)
+{
+	chipio_set_control_param_no_mutex(codec,
+			CONTROL_PARAM_CONN_POINT_ID, connid);
+	chipio_set_control_param_no_mutex(codec,
+			CONTROL_PARAM_CONN_POINT_SAMPLE_RATE, rate);
+}
+
+/*
  * Set sampling rate of the connection point.
  */
 static void chipio_set_conn_rate(struct hda_codec *codec,
@@ -1420,8 +1778,8 @@ static int dspio_send_scp_message(struct hda_codec *codec,
  * Returns zero or a negative error code.
  */
 static int dspio_scp(struct hda_codec *codec,
-		int mod_id, int req, int dir, void *data, unsigned int len,
-		void *reply, unsigned int *reply_len)
+		int mod_id, int src_id, int req, int dir, void *data,
+		unsigned int len, void *reply, unsigned int *reply_len)
 {
 	int status = 0;
 	struct scp_msg scp_send, scp_reply;
@@ -1445,13 +1803,16 @@ static int dspio_scp(struct hda_codec *codec,
 		return -EINVAL;
 	}
 
-	scp_send.hdr = make_scp_header(mod_id, 0x20, (dir == SCP_GET), req,
+	scp_send.hdr = make_scp_header(mod_id, src_id, (dir == SCP_GET), req,
 				       0, 0, 0, len/sizeof(unsigned int));
 	if (data != NULL && len > 0) {
 		len = min((unsigned int)(sizeof(scp_send.data)), len);
 		memcpy(scp_send.data, data, len);
 	}
 
+	codec_dbg(codec, "scp_cmd mod: %02x req: %02x src: %02x\n",
+			mod_id, req, src_id);
+
 	ret_bytes = 0;
 	send_size = sizeof(unsigned int) + len;
 	status = dspio_send_scp_message(codec, (unsigned char *)&scp_send,
@@ -1502,15 +1863,24 @@ static int dspio_scp(struct hda_codec *codec,
  * Set DSP parameters
  */
 static int dspio_set_param(struct hda_codec *codec, int mod_id,
-			int req, void *data, unsigned int len)
+			int src_id, int req, void *data, unsigned int len)
 {
-	return dspio_scp(codec, mod_id, req, SCP_SET, data, len, NULL, NULL);
+	return dspio_scp(codec, mod_id, src_id, req, SCP_SET, data, len,
+			NULL, NULL);
 }
 
 static int dspio_set_uint_param(struct hda_codec *codec, int mod_id,
 			int req, unsigned int data)
 {
-	return dspio_set_param(codec, mod_id, req, &data, sizeof(unsigned int));
+	return dspio_set_param(codec, mod_id, 0x20, req, &data,
+			sizeof(unsigned int));
+}
+
+static int dspio_set_uint_param_no_source(struct hda_codec *codec, int mod_id,
+			int req, unsigned int data)
+{
+	return dspio_set_param(codec, mod_id, 0x00, req, &data,
+			sizeof(unsigned int));
 }
 
 /*
@@ -1522,8 +1892,9 @@ static int dspio_alloc_dma_chan(struct hda_codec *codec, unsigned int *dma_chan)
 	unsigned int size = sizeof(dma_chan);
 
 	codec_dbg(codec, "     dspio_alloc_dma_chan() -- begin\n");
-	status = dspio_scp(codec, MASTERCONTROL, MASTERCONTROL_ALLOC_DMA_CHAN,
-			SCP_GET, NULL, 0, dma_chan, &size);
+	status = dspio_scp(codec, MASTERCONTROL, 0x20,
+			MASTERCONTROL_ALLOC_DMA_CHAN, SCP_GET, NULL, 0,
+			dma_chan, &size);
 
 	if (status < 0) {
 		codec_dbg(codec, "dspio_alloc_dma_chan: SCP Failed\n");
@@ -1552,8 +1923,9 @@ static int dspio_free_dma_chan(struct hda_codec *codec, unsigned int dma_chan)
 	codec_dbg(codec, "     dspio_free_dma_chan() -- begin\n");
 	codec_dbg(codec, "dspio_free_dma_chan: chan=%d\n", dma_chan);
 
-	status = dspio_scp(codec, MASTERCONTROL, MASTERCONTROL_ALLOC_DMA_CHAN,
-			   SCP_SET, &dma_chan, sizeof(dma_chan), NULL, &dummy);
+	status = dspio_scp(codec, MASTERCONTROL, 0x20,
+			MASTERCONTROL_ALLOC_DMA_CHAN, SCP_SET, &dma_chan,
+			sizeof(dma_chan), NULL, &dummy);
 
 	if (status < 0) {
 		codec_dbg(codec, "dspio_free_dma_chan: SCP Failed\n");
@@ -1800,7 +2172,7 @@ static int dsp_dma_setup(struct hda_codec *codec,
 		return -ENXIO;
 	}
 
-	codec_dbg(codec, "   dsp_dma_setup()    start reg pgm\n");
+	codec_dbg(codec, "   dsp_dma_setup()	start reg pgm\n");
 
 	addr_field = dsp_addx << DSPDMAC_DMACFG_DBADR_LOBIT;
 	incr_field   = 0;
@@ -1820,7 +2192,7 @@ static int dsp_dma_setup(struct hda_codec *codec,
 		codec_dbg(codec, "write DMACFG Reg fail\n");
 		return status;
 	}
-	codec_dbg(codec, "   dsp_dma_setup()    Write DMACFG\n");
+	codec_dbg(codec, "   dsp_dma_setup()	Write DMACFG\n");
 
 	adr_ofs = (count - 1) << (DSPDMAC_DSPADROFS_BOFS_LOBIT +
 							(code ? 0 : 1));
@@ -1831,7 +2203,7 @@ static int dsp_dma_setup(struct hda_codec *codec,
 		codec_dbg(codec, "write DSPADROFS Reg fail\n");
 		return status;
 	}
-	codec_dbg(codec, "   dsp_dma_setup()    Write DSPADROFS\n");
+	codec_dbg(codec, "   dsp_dma_setup()	Write DSPADROFS\n");
 
 	base_cnt = (count - 1) << DSPDMAC_XFRCNT_BCNT_LOBIT;
 
@@ -1845,7 +2217,7 @@ static int dsp_dma_setup(struct hda_codec *codec,
 		codec_dbg(codec, "write XFRCNT Reg fail\n");
 		return status;
 	}
-	codec_dbg(codec, "   dsp_dma_setup()    Write XFRCNT\n");
+	codec_dbg(codec, "   dsp_dma_setup()	Write XFRCNT\n");
 
 	codec_dbg(codec,
 		   "ChipA=0x%x, cnt=0x%x, DMACFG=0x%x, "
@@ -1876,7 +2248,7 @@ static int dsp_dma_start(struct hda_codec *codec,
 			codec_dbg(codec, "read CHNLSTART reg fail\n");
 			return status;
 		}
-		codec_dbg(codec, "-- dsp_dma_start()    Read CHNLSTART\n");
+		codec_dbg(codec, "-- dsp_dma_start()	Read CHNLSTART\n");
 
 		reg &= ~(DSPDMAC_CHNLSTART_EN_MASK |
 				DSPDMAC_CHNLSTART_DIS_MASK);
@@ -2075,8 +2447,8 @@ struct dma_engine {
 
 
 enum dma_state {
-	DMA_STATE_STOP  = 0,
-	DMA_STATE_RUN   = 1
+	DMA_STATE_STOP	= 0,
+	DMA_STATE_RUN	= 1
 };
 
 static int dma_convert_to_hda_format(struct hda_codec *codec,
@@ -2575,14 +2947,16 @@ static int dspxfr_image(struct hda_codec *codec,
  */
 static void dspload_post_setup(struct hda_codec *codec)
 {
+	struct ca0132_spec *spec = codec->spec;
 	codec_dbg(codec, "---- dspload_post_setup ------\n");
+	if (spec->quirk == QUIRK_NONE) {
+		/*set DSP speaker to 2.0 configuration*/
+		chipio_write(codec, XRAM_XRAM_INST_OFFSET(0x18), 0x08080080);
+		chipio_write(codec, XRAM_XRAM_INST_OFFSET(0x19), 0x3f800000);
 
-	/*set DSP speaker to 2.0 configuration*/
-	chipio_write(codec, XRAM_XRAM_INST_OFFSET(0x18), 0x08080080);
-	chipio_write(codec, XRAM_XRAM_INST_OFFSET(0x19), 0x3f800000);
-
-	/*update write pointer*/
-	chipio_write(codec, XRAM_XRAM_INST_OFFSET(0x29), 0x00000002);
+		/*update write pointer*/
+		chipio_write(codec, XRAM_XRAM_INST_OFFSET(0x29), 0x00000002);
+	}
 }
 
 /**
@@ -2675,6 +3049,7 @@ static bool dspload_is_loaded(struct hda_codec *codec)
 
 static bool dspload_wait_loaded(struct hda_codec *codec)
 {
+	struct ca0132_spec *spec = codec->spec;
 	unsigned long timeout = jiffies + msecs_to_jiffies(2000);
 
 	do {
@@ -2684,12 +3059,199 @@ static bool dspload_wait_loaded(struct hda_codec *codec)
 		}
 		msleep(20);
 	} while (time_before(jiffies, timeout));
-
+	if (spec->dsp_download_wakeup == 1) {
+		codec_dbg(codec, "Waking up from sleep, reload the DSP.");
+		return false;
+	}
 	codec_err(codec, "ca0132 failed to download DSP\n");
 	return false;
 }
 
 /*
+ * Setup GPIO for the other variants of Core3D.
+ */
+
+/*
+ * Sets up the GPIO pins so that they are discoverable. If this isn't done,
+ * the card shows as having no GPIO pins.
+ */
+static void ca0132_gpio_init(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	switch (spec->quirk) {
+	case QUIRK_SBZ:
+		snd_hda_codec_write(codec, 0x01, 0, 0x793, 0x00);
+		snd_hda_codec_write(codec, 0x01, 0, 0x794, 0x53);
+		snd_hda_codec_write(codec, 0x01, 0, 0x790, 0x23);
+		break;
+	case QUIRK_R3DI:
+		snd_hda_codec_write(codec, 0x01, 0, 0x793, 0x00);
+		snd_hda_codec_write(codec, 0x01, 0, 0x794, 0x5B);
+		break;
+	}
+
+}
+
+/* Sets the GPIO for audio output. */
+static void ca0132_gpio_setup(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	switch (spec->quirk) {
+	case QUIRK_SBZ:
+		snd_hda_codec_write(codec, 0x01, 0,
+				AC_VERB_SET_GPIO_DIRECTION, 0x07);
+		snd_hda_codec_write(codec, 0x01, 0,
+				AC_VERB_SET_GPIO_MASK, 0x07);
+		snd_hda_codec_write(codec, 0x01, 0,
+				AC_VERB_SET_GPIO_DATA, 0x04);
+		snd_hda_codec_write(codec, 0x01, 0,
+				AC_VERB_SET_GPIO_DATA, 0x06);
+		break;
+	case QUIRK_R3DI:
+		snd_hda_codec_write(codec, 0x01, 0,
+				AC_VERB_SET_GPIO_DIRECTION, 0x1E);
+		snd_hda_codec_write(codec, 0x01, 0,
+				AC_VERB_SET_GPIO_MASK, 0x1F);
+		snd_hda_codec_write(codec, 0x01, 0,
+				AC_VERB_SET_GPIO_DATA, 0x0C);
+		break;
+	}
+}
+
+/* On shutdown, sends commands in sets of three */
+static void sbz_gpio_shutdown_commands(struct hda_codec *codec, int dir,
+							int mask, int data)
+{
+	if (dir >= 0)
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DIRECTION,
+				dir);
+	if (mask >= 0)
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_MASK,
+				mask);
+
+	if (data >= 0)
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA,
+				data);
+}
+
+/*
+ * GPIO control functions for the Recon3D integrated.
+ */
+
+enum r3di_gpio_bit {
+	/* Bit 1 - Switch between front/rear mic. 0 = rear, 1 = front */
+	R3DI_MIC_SELECT_BIT = 1,
+	/* Bit 2 - Switch between headphone/line out. 0 = Headphone, 1 = Line */
+	R3DI_OUT_SELECT_BIT = 2,
+	/* I dunno what this actually does, but it stays on until the dsp
+	 * is downloaded.
+	 */
+	R3DI_GPIO_DSP_DOWNLOADING = 3,
+	/* Same as above, no clue what it does, but it comes on after the dsp
+	 * is downloaded.
+	 */
+	R3DI_GPIO_DSP_DOWNLOADED = 4
+};
+
+enum r3di_mic_select {
+	/* Set GPIO bit 1 to 0 for rear mic */
+	R3DI_REAR_MIC = 0,
+	/* Set GPIO bit 1 to 1 for front microphone*/
+	R3DI_FRONT_MIC = 1
+};
+
+enum r3di_out_select {
+	/* Set GPIO bit 2 to 0 for headphone */
+	R3DI_HEADPHONE_OUT = 0,
+	/* Set GPIO bit 2 to 1 for speaker */
+	R3DI_LINE_OUT = 1
+};
+
+enum r3di_dsp_status {
+	/* Set GPIO bit 3 to 1 until DSP is downloaded */
+	R3DI_DSP_DOWNLOADING = 0,
+	/* Set GPIO bit 4 to 1 once DSP is downloaded */
+	R3DI_DSP_DOWNLOADED = 1
+};
+
+static void r3di_gpio_mic_set(struct hda_codec *codec,
+		enum r3di_mic_select cur_mic)
+{
+	unsigned int cur_gpio;
+
+	/* Get the current GPIO Data setup */
+	cur_gpio = snd_hda_codec_read(codec, 0x01, 0,
+			AC_VERB_GET_GPIO_DATA, 0);
+
+	switch (cur_mic) {
+	case R3DI_REAR_MIC:
+		cur_gpio &= ~(1 << R3DI_MIC_SELECT_BIT);
+		break;
+	case R3DI_FRONT_MIC:
+		cur_gpio |= (1 << R3DI_MIC_SELECT_BIT);
+		break;
+	}
+	snd_hda_codec_write(codec, codec->core.afg, 0,
+			AC_VERB_SET_GPIO_DATA, cur_gpio);
+
+}
+
+static void r3di_gpio_out_set(struct hda_codec *codec,
+		enum r3di_out_select cur_out)
+{
+	unsigned int cur_gpio;
+
+	/* Get the current GPIO Data setup */
+	cur_gpio = snd_hda_codec_read(codec, 0x01, 0,
+			AC_VERB_GET_GPIO_DATA, 0);
+
+	switch (cur_out) {
+	case R3DI_HEADPHONE_OUT:
+		cur_gpio &= ~(1 << R3DI_OUT_SELECT_BIT);
+		break;
+	case R3DI_LINE_OUT:
+		cur_gpio |= (1 << R3DI_OUT_SELECT_BIT);
+		break;
+	}
+	snd_hda_codec_write(codec, codec->core.afg, 0,
+			    AC_VERB_SET_GPIO_DATA, cur_gpio);
+
+}
+
+static void r3di_gpio_dsp_status_set(struct hda_codec *codec,
+		enum r3di_dsp_status dsp_status)
+{
+	unsigned int cur_gpio;
+
+	/* Get the current GPIO Data setup */
+	cur_gpio = snd_hda_codec_read(codec, 0x01, 0,
+			AC_VERB_GET_GPIO_DATA, 0);
+
+	switch (dsp_status) {
+	case R3DI_DSP_DOWNLOADING:
+		cur_gpio |= (1 << R3DI_GPIO_DSP_DOWNLOADING);
+		snd_hda_codec_write(codec, codec->core.afg, 0,
+			      AC_VERB_SET_GPIO_DATA, cur_gpio);
+		break;
+	case R3DI_DSP_DOWNLOADED:
+		/* Set DOWNLOADING bit to 0. */
+		cur_gpio &= ~(1 << R3DI_GPIO_DSP_DOWNLOADING);
+
+		snd_hda_codec_write(codec, codec->core.afg, 0,
+			      AC_VERB_SET_GPIO_DATA, cur_gpio);
+
+		cur_gpio |= (1 << R3DI_GPIO_DSP_DOWNLOADED);
+		break;
+	}
+
+	snd_hda_codec_write(codec, codec->core.afg, 0,
+			    AC_VERB_SET_GPIO_DATA, cur_gpio);
+
+}
+
+/*
  * PCM callbacks
  */
 static int ca0132_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
@@ -2701,7 +3263,6 @@ static int ca0132_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 	struct ca0132_spec *spec = codec->spec;
 
 	snd_hda_codec_setup_stream(codec, spec->dacs[0], stream_tag, 0, format);
-
 	return 0;
 }
 
@@ -2713,7 +3274,6 @@ static int ca0132_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
 
 	if (spec->dsp_state == DSP_DOWNLOADING)
 		return 0;
-
 	/*If Playback effects are on, allow stream some time to flush
 	 *effects tail*/
 	if (spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID])
@@ -2866,8 +3426,90 @@ static unsigned int ca0132_capture_pcm_delay(struct hda_pcm_stream *info,
 	CA0132_CODEC_VOL_MONO(xname, nid, 3, dir)
 #define CA0132_CODEC_MUTE(xname, nid, dir) \
 	CA0132_CODEC_MUTE_MONO(xname, nid, 3, dir)
+/*
+ * Lookup table with decibel values for the DSP. When volume is changed in
+ * Windows, the DSP is also sent the dB value in floating point. In Windows,
+ * these values have decimal points, probably because the Windows driver
+ * actually uses floating point. We can't here, so I made a lookup table of
+ * values -99 to 9. -99 is the start for the vmaster out control, and for the
+ * microphone, the value begins at -90. So on microphone lookups, start at
+ * 9.
+ */
+
+static unsigned int float_vol_db_lookup[] = {
+0xC2B40000, 0xC2B20000, 0xC2B00000, 0xC2AE0000, 0xC2AC0000, 0xC2AA0000,
+0xC2A80000, 0xC2A60000, 0xC2A40000, 0xC2A20000, 0xC2A00000, 0xC29E0000,
+0xC29C0000, 0xC29A0000, 0xC2980000, 0xC2960000, 0xC2940000, 0xC2920000,
+0xC2900000, 0xC28E0000, 0xC28C0000, 0xC28A0000, 0xC2880000, 0xC2860000,
+0xC2840000, 0xC2820000, 0xC2800000, 0xC27C0000, 0xC2780000, 0xC2740000,
+0xC2700000, 0xC26C0000, 0xC2680000, 0xC2640000, 0xC2600000, 0xC25C0000,
+0xC2580000, 0xC2540000, 0xC2500000, 0xC24C0000, 0xC2480000, 0xC2440000,
+0xC2400000, 0xC23C0000, 0xC2380000, 0xC2340000, 0xC2300000, 0xC22C0000,
+0xC2280000, 0xC2240000, 0xC2200000, 0xC21C0000, 0xC2180000, 0xC2140000,
+0xC2100000, 0xC20C0000, 0xC2080000, 0xC2040000, 0xC2000000, 0xC1F80000,
+0xC1F00000, 0xC1E80000, 0xC1E00000, 0xC1D80000, 0xC1D00000, 0xC1C80000,
+0xC1C00000, 0xC1B80000, 0xC1B00000, 0xC1A80000, 0xC1A00000, 0xC1980000,
+0xC1900000, 0xC1880000, 0xC1800000, 0xC1700000, 0xC1600000, 0xC1500000,
+0xC1400000, 0xC1300000, 0xC1200000, 0xC1100000, 0xC1000000, 0xC0E00000,
+0xC0C00000, 0xC0A00000, 0xC0800000, 0xC0400000, 0xC0000000, 0xBF800000,
+0x00000000, 0x3F800000, 0x40000000, 0x40400000, 0x40800000, 0x40A00000,
+0x40C00000, 0x40E00000, 0x41000000, 0x41100000
+};
+
+
+/*
+ * This table counts from float 0 to 1 in increments of .01, which is
+ * useful for a few different sliders.
+ */
+
+static unsigned int float_zero_to_one_lookup[] = {
+0x00000000, 0x3C23D70A, 0x3CA3D70A, 0x3CF5C28F, 0x3D23D70A, 0x3D4CCCCD,
+0x3D75C28F, 0x3D8F5C29, 0x3DA3D70A, 0x3DB851EC, 0x3DCCCCCD, 0x3DE147AE,
+0x3DF5C28F, 0x3E051EB8, 0x3E0F5C29, 0x3E19999A, 0x3E23D70A, 0x3E2E147B,
+0x3E3851EC, 0x3E428F5C, 0x3E4CCCCD, 0x3E570A3D, 0x3E6147AE, 0x3E6B851F,
+0x3E75C28F, 0x3E800000, 0x3E851EB8, 0x3E8A3D71, 0x3E8F5C29, 0x3E947AE1,
+0x3E99999A, 0x3E9EB852, 0x3EA3D70A, 0x3EA8F5C3, 0x3EAE147B, 0x3EB33333,
+0x3EB851EC, 0x3EBD70A4, 0x3EC28F5C, 0x3EC7AE14, 0x3ECCCCCD, 0x3ED1EB85,
+0x3ED70A3D, 0x3EDC28F6, 0x3EE147AE, 0x3EE66666, 0x3EEB851F, 0x3EF0A3D7,
+0x3EF5C28F, 0x3EFAE148, 0x3F000000, 0x3F028F5C, 0x3F051EB8, 0x3F07AE14,
+0x3F0A3D71, 0x3F0CCCCD, 0x3F0F5C29, 0x3F11EB85, 0x3F147AE1, 0x3F170A3D,
+0x3F19999A, 0x3F1C28F6, 0x3F1EB852, 0x3F2147AE, 0x3F23D70A, 0x3F266666,
+0x3F28F5C3, 0x3F2B851F, 0x3F2E147B, 0x3F30A3D7, 0x3F333333, 0x3F35C28F,
+0x3F3851EC, 0x3F3AE148, 0x3F3D70A4, 0x3F400000, 0x3F428F5C, 0x3F451EB8,
+0x3F47AE14, 0x3F4A3D71, 0x3F4CCCCD, 0x3F4F5C29, 0x3F51EB85, 0x3F547AE1,
+0x3F570A3D, 0x3F59999A, 0x3F5C28F6, 0x3F5EB852, 0x3F6147AE, 0x3F63D70A,
+0x3F666666, 0x3F68F5C3, 0x3F6B851F, 0x3F6E147B, 0x3F70A3D7, 0x3F733333,
+0x3F75C28F, 0x3F7851EC, 0x3F7AE148, 0x3F7D70A4, 0x3F800000
+};
+
+/*
+ * This table counts from float 10 to 1000, which is the range of the x-bass
+ * crossover slider in Windows.
+ */
+
+static unsigned int float_xbass_xover_lookup[] = {
+0x41200000, 0x41A00000, 0x41F00000, 0x42200000, 0x42480000, 0x42700000,
+0x428C0000, 0x42A00000, 0x42B40000, 0x42C80000, 0x42DC0000, 0x42F00000,
+0x43020000, 0x430C0000, 0x43160000, 0x43200000, 0x432A0000, 0x43340000,
+0x433E0000, 0x43480000, 0x43520000, 0x435C0000, 0x43660000, 0x43700000,
+0x437A0000, 0x43820000, 0x43870000, 0x438C0000, 0x43910000, 0x43960000,
+0x439B0000, 0x43A00000, 0x43A50000, 0x43AA0000, 0x43AF0000, 0x43B40000,
+0x43B90000, 0x43BE0000, 0x43C30000, 0x43C80000, 0x43CD0000, 0x43D20000,
+0x43D70000, 0x43DC0000, 0x43E10000, 0x43E60000, 0x43EB0000, 0x43F00000,
+0x43F50000, 0x43FA0000, 0x43FF0000, 0x44020000, 0x44048000, 0x44070000,
+0x44098000, 0x440C0000, 0x440E8000, 0x44110000, 0x44138000, 0x44160000,
+0x44188000, 0x441B0000, 0x441D8000, 0x44200000, 0x44228000, 0x44250000,
+0x44278000, 0x442A0000, 0x442C8000, 0x442F0000, 0x44318000, 0x44340000,
+0x44368000, 0x44390000, 0x443B8000, 0x443E0000, 0x44408000, 0x44430000,
+0x44458000, 0x44480000, 0x444A8000, 0x444D0000, 0x444F8000, 0x44520000,
+0x44548000, 0x44570000, 0x44598000, 0x445C0000, 0x445E8000, 0x44610000,
+0x44638000, 0x44660000, 0x44688000, 0x446B0000, 0x446D8000, 0x44700000,
+0x44728000, 0x44750000, 0x44778000, 0x447A0000
+};
+
 
 /* The following are for tuning of products */
+
 #ifdef ENABLE_TUNING_CONTROLS
 
 static unsigned int voice_focus_vals_lookup[] = {
@@ -2900,26 +3542,6 @@ static unsigned int voice_focus_vals_lookup[] = {
 0x43300000, 0x43310000, 0x43320000, 0x43330000, 0x43340000
 };
 
-static unsigned int mic_svm_vals_lookup[] = {
-0x00000000, 0x3C23D70A, 0x3CA3D70A, 0x3CF5C28F, 0x3D23D70A, 0x3D4CCCCD,
-0x3D75C28F, 0x3D8F5C29, 0x3DA3D70A, 0x3DB851EC, 0x3DCCCCCD, 0x3DE147AE,
-0x3DF5C28F, 0x3E051EB8, 0x3E0F5C29, 0x3E19999A, 0x3E23D70A, 0x3E2E147B,
-0x3E3851EC, 0x3E428F5C, 0x3E4CCCCD, 0x3E570A3D, 0x3E6147AE, 0x3E6B851F,
-0x3E75C28F, 0x3E800000, 0x3E851EB8, 0x3E8A3D71, 0x3E8F5C29, 0x3E947AE1,
-0x3E99999A, 0x3E9EB852, 0x3EA3D70A, 0x3EA8F5C3, 0x3EAE147B, 0x3EB33333,
-0x3EB851EC, 0x3EBD70A4, 0x3EC28F5C, 0x3EC7AE14, 0x3ECCCCCD, 0x3ED1EB85,
-0x3ED70A3D, 0x3EDC28F6, 0x3EE147AE, 0x3EE66666, 0x3EEB851F, 0x3EF0A3D7,
-0x3EF5C28F, 0x3EFAE148, 0x3F000000, 0x3F028F5C, 0x3F051EB8, 0x3F07AE14,
-0x3F0A3D71, 0x3F0CCCCD, 0x3F0F5C29, 0x3F11EB85, 0x3F147AE1, 0x3F170A3D,
-0x3F19999A, 0x3F1C28F6, 0x3F1EB852, 0x3F2147AE, 0x3F23D70A, 0x3F266666,
-0x3F28F5C3, 0x3F2B851F, 0x3F2E147B, 0x3F30A3D7, 0x3F333333, 0x3F35C28F,
-0x3F3851EC, 0x3F3AE148, 0x3F3D70A4, 0x3F400000, 0x3F428F5C, 0x3F451EB8,
-0x3F47AE14, 0x3F4A3D71, 0x3F4CCCCD, 0x3F4F5C29, 0x3F51EB85, 0x3F547AE1,
-0x3F570A3D, 0x3F59999A, 0x3F5C28F6, 0x3F5EB852, 0x3F6147AE, 0x3F63D70A,
-0x3F666666, 0x3F68F5C3, 0x3F6B851F, 0x3F6E147B, 0x3F70A3D7, 0x3F733333,
-0x3F75C28F, 0x3F7851EC, 0x3F7AE148, 0x3F7D70A4, 0x3F800000
-};
-
 static unsigned int equalizer_vals_lookup[] = {
 0xC1C00000, 0xC1B80000, 0xC1B00000, 0xC1A80000, 0xC1A00000, 0xC1980000,
 0xC1900000, 0xC1880000, 0xC1800000, 0xC1700000, 0xC1600000, 0xC1500000,
@@ -2942,7 +3564,7 @@ static int tuning_ctl_set(struct hda_codec *codec, hda_nid_t nid,
 			break;
 
 	snd_hda_power_up(codec);
-	dspio_set_param(codec, ca0132_tuning_ctls[i].mid,
+	dspio_set_param(codec, ca0132_tuning_ctls[i].mid, 0x20,
 			ca0132_tuning_ctls[i].req,
 			&(lookup[idx]), sizeof(unsigned int));
 	snd_hda_power_down(codec);
@@ -3028,7 +3650,7 @@ static int mic_svm_ctl_put(struct snd_kcontrol *kcontrol,
 	spec->cur_ctl_vals[idx] = *valp;
 
 	idx = *valp;
-	tuning_ctl_set(codec, nid, mic_svm_vals_lookup, idx);
+	tuning_ctl_set(codec, nid, float_zero_to_one_lookup, idx);
 
 	return 0;
 }
@@ -3068,9 +3690,11 @@ static int equalizer_ctl_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
+/*FIXME Figure out why the program will not compile with these. */
+/*
 static const DECLARE_TLV_DB_SCALE(voice_focus_db_scale, 2000, 100, 0);
 static const DECLARE_TLV_DB_SCALE(eq_db_scale, -2400, 100, 0);
-
+*/
 static int add_tuning_control(struct hda_codec *codec,
 				hda_nid_t pnid, hda_nid_t nid,
 				const char *name, int dir)
@@ -3089,7 +3713,7 @@ static int add_tuning_control(struct hda_codec *codec,
 		knew.info = voice_focus_ctl_info;
 		knew.get = tuning_ctl_get;
 		knew.put = voice_focus_ctl_put;
-		knew.tlv.p = voice_focus_db_scale;
+//		knew.tlv.p = voice_focus_db_scale;
 		break;
 	case MIC_SVM:
 		knew.info = mic_svm_ctl_info;
@@ -3100,7 +3724,7 @@ static int add_tuning_control(struct hda_codec *codec,
 		knew.info = equalizer_ctl_info;
 		knew.get = tuning_ctl_get;
 		knew.put = equalizer_ctl_put;
-		knew.tlv.p = eq_db_scale;
+//		knew.tlv.p = eq_db_scale;
 		break;
 	default:
 		return 0;
@@ -3111,6 +3735,7 @@ static int add_tuning_control(struct hda_codec *codec,
 	return snd_hda_ctl_add(codec, nid, snd_ctl_new1(&knew, codec));
 }
 
+
 static int add_tuning_ctls(struct hda_codec *codec)
 {
 	int i;
@@ -3134,7 +3759,7 @@ static void ca0132_init_tuning_defaults(struct hda_codec *codec)
 	struct ca0132_spec *spec = codec->spec;
 	int i;
 
-	/* Wedge Angle defaults to 30.  10 below is 30 - 20.  20 is min. */
+	/* Wedge Angle defaults to 30.	10 below is 30 - 20.  20 is min. */
 	spec->cur_ctl_vals[WEDGE_ANGLE - TUNING_CTL_START_NID] = 10;
 	/* SVM level defaults to 0.74. */
 	spec->cur_ctl_vals[SVM_LEVEL - TUNING_CTL_START_NID] = 74;
@@ -3146,11 +3771,446 @@ static void ca0132_init_tuning_defaults(struct hda_codec *codec)
 #endif /*ENABLE_TUNING_CONTROLS*/
 
 /*
+ * Below I've added controls to mess with the effect levels, I've only enabled
+ * them on the Sound Blaster Z, but they would probably also work on the
+ * Chromebook. I figured they were probably tuned specifically for it, and left
+ * out for a reason.
+ */
+
+/* Sets DSP effect level from the sliders above the controls */
+static int ca0132_alt_slider_ctl_set(struct hda_codec *codec, hda_nid_t nid,
+			  unsigned int *lookup, int idx)
+{
+	int i = 0;
+	unsigned int y;
+	/* For X_BASS, req 2 is actually crossover freq instead of
+	 * effect level.
+	 */
+	if (nid == X_BASS)
+		y = 2;
+	else
+		y = 1;
+
+	snd_hda_power_up(codec);
+	if (nid == XBASS_XOVER) {
+		for (i = 0; i < OUT_EFFECTS_COUNT; i++)
+			if (ca0132_effects[i].nid == X_BASS)
+				break;
+
+		dspio_set_param(codec, ca0132_effects[i].mid, 0x20,
+				ca0132_effects[i].reqs[1],
+				&(lookup[idx - 1]), sizeof(unsigned int));
+	} else {
+		/* Find the actual effect structure */
+		for (i = 0; i < OUT_EFFECTS_COUNT; i++)
+			if (nid == ca0132_effects[i].nid)
+				break;
+
+		dspio_set_param(codec, ca0132_effects[i].mid, 0x20,
+				ca0132_effects[i].reqs[y],
+				&(lookup[idx]), sizeof(unsigned int));
+	}
+
+	snd_hda_power_down(codec);
+
+	return 0;
+}
+
+static int ca0132_alt_xbass_xover_slider_ctl_get(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+	long *valp = ucontrol->value.integer.value;
+
+	*valp = spec->xbass_xover_freq;
+	return 0;
+}
+
+static int ca0132_alt_slider_ctl_get(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	hda_nid_t nid = get_amp_nid(kcontrol);
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+	long *valp = ucontrol->value.integer.value;
+	int idx = nid - OUT_EFFECT_START_NID;
+
+	*valp = spec->fx_ctl_val[idx];
+	return 0;
+}
+
+/*
+ * The X-bass crossover starts at 10hz, so the min is 1. The
+ * frequency is set in multiples of 10.
+ */
+static int ca0132_alt_xbass_xover_slider_info(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 1;
+	uinfo->value.integer.max = 100;
+	uinfo->value.integer.step = 1;
+
+	return 0;
+}
+
+static int ca0132_alt_effect_slider_info(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_info *uinfo)
+{
+	int chs = get_amp_channels(kcontrol);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = chs == 3 ? 2 : 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 100;
+	uinfo->value.integer.step = 1;
+
+	return 0;
+}
+
+static int ca0132_alt_xbass_xover_slider_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+	hda_nid_t nid = get_amp_nid(kcontrol);
+	long *valp = ucontrol->value.integer.value;
+	int idx;
+
+	/* any change? */
+	if (spec->xbass_xover_freq == *valp)
+		return 0;
+
+	spec->xbass_xover_freq = *valp;
+
+	idx = *valp;
+	ca0132_alt_slider_ctl_set(codec, nid, float_xbass_xover_lookup, idx);
+
+	return 0;
+}
+
+static int ca0132_alt_effect_slider_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+	hda_nid_t nid = get_amp_nid(kcontrol);
+	long *valp = ucontrol->value.integer.value;
+	int idx;
+
+	idx = nid - EFFECT_START_NID;
+	/* any change? */
+	if (spec->fx_ctl_val[idx] == *valp)
+		return 0;
+
+	spec->fx_ctl_val[idx] = *valp;
+
+	idx = *valp;
+	ca0132_alt_slider_ctl_set(codec, nid, float_zero_to_one_lookup, idx);
+
+	return 0;
+}
+
+static int ca0132_alt_add_effect_slider(struct hda_codec *codec, hda_nid_t nid,
+					const char *pfx, int dir)
+{
+	char *fx = "FX:";
+	char namestr[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	int type = dir ? HDA_INPUT : HDA_OUTPUT;
+	struct snd_kcontrol_new knew =
+		HDA_CODEC_VOLUME_MONO(namestr, nid, 1, 0, type);
+
+	sprintf(namestr, "%s %s %s Volume", fx, pfx, dirstr[dir]);
+
+	knew.tlv.c = 0;
+	knew.tlv.p = 0;
+
+	switch (nid) {
+	case XBASS_XOVER:
+		knew.info = ca0132_alt_xbass_xover_slider_info;
+		knew.get = ca0132_alt_xbass_xover_slider_ctl_get;
+		knew.put = ca0132_alt_xbass_xover_slider_put;
+		break;
+	default:
+		knew.info = ca0132_alt_effect_slider_info;
+		knew.get = ca0132_alt_slider_ctl_get;
+		knew.put = ca0132_alt_effect_slider_put;
+		knew.private_value =
+			HDA_COMPOSE_AMP_VAL(nid, 1, 0, type);
+		break;
+	}
+
+	return snd_hda_ctl_add(codec, nid, snd_ctl_new1(&knew, codec));
+}
+
+/*
+ * Sets the internal DSP decibel level. Currently only the SBZ sets internal
+ * capture volume level, and all other alternative codecs set the playback
+ * volume level.
+ */
+static void ca0132_alt_dsp_volume_put(struct hda_codec *codec, hda_nid_t nid)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int dsp_dir;
+	unsigned int lookup_val;
+
+	if (spec->quirk == QUIRK_R3DI && nid == VNID_MIC)
+		return;
+
+	if (nid == VNID_SPK)
+		dsp_dir = DSP_VOL_OUT;
+	else
+		dsp_dir = DSP_VOL_IN;
+
+	lookup_val = spec->vnode_lvol[nid - VNODE_START_NID];
+
+	dspio_set_uint_param(codec,
+		ca0132_alt_vol_ctls[dsp_dir].mid,
+		ca0132_alt_vol_ctls[dsp_dir].reqs[0],
+		float_vol_db_lookup[lookup_val]);
+
+	lookup_val = spec->vnode_rvol[nid - VNODE_START_NID];
+
+	dspio_set_uint_param(codec,
+		ca0132_alt_vol_ctls[dsp_dir].mid,
+		ca0132_alt_vol_ctls[dsp_dir].reqs[1],
+		float_vol_db_lookup[lookup_val]);
+
+	dspio_set_uint_param(codec,
+		ca0132_alt_vol_ctls[dsp_dir].mid,
+		ca0132_alt_vol_ctls[dsp_dir].reqs[2], FLOAT_0);
+}
+
+/*
+ * Select the active output.
+ * If autodetect is enabled, output will be selected based on jack detection.
+ * If a jack is detected in the headphone connector, then headphone will be
+ * selected. Otherwise, it defaults to line-out.
+ * If autodetect is disabled, output will be set based on the output select
+ * enum control. It can either be surround, line out, or headphone.
+ */
+
+static int ca0132_alt_select_out(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int pin_ctl;
+	int jack_present;
+	int auto_jack;
+	unsigned int i;
+	unsigned int tmp;
+	int err;
+	/* Default Headphone is rear headphone */
+	hda_nid_t headphone_nid = spec->out_pins[1];
+
+	codec_dbg(codec, "ca0132_alt_select_out\n");
+
+	snd_hda_power_up_pm(codec);
+
+	auto_jack = spec->vnode_lswitch[VNID_HP_ASEL - VNODE_START_NID];
+
+	/*
+	 * If headphone rear or front is plugged in, set to headphone.
+	 * If neither is plugged in, set to rear line out. Only if
+	 * hp/speaker auto detect is enabled.
+	 */
+	if (auto_jack) {
+		jack_present = snd_hda_jack_detect(codec, spec->unsol_tag_hp) ||
+			   snd_hda_jack_detect(codec, spec->unsol_tag_front_hp);
+
+		if (jack_present)
+			spec->cur_out_type = HEADPHONE_OUT;
+		else
+			spec->cur_out_type = SPEAKER_OUT;
+	} else
+		spec->cur_out_type = spec->out_enum_val;
+
+	/* Begin DSP output switch */
+	tmp = FLOAT_1;
+	err = dspio_set_uint_param(codec, 0x96, 0x3A, tmp);
+	if (err < 0)
+		goto exit;
+
+	switch (spec->cur_out_type) {
+	case SPEAKER_OUT:
+		codec_dbg(codec, "ca0132_alt_select_out speaker\n");
+		/*speaker out config*/
+		switch (spec->quirk) {
+		case QUIRK_SBZ:
+			/*
+			 * I'm pretty positive these are some sort of GPIO,
+			 * where the 4th hex digit is the number of the GPIO,
+			 * and the second is on or off. These are used for
+			 * switching outputs, and most importantly, front
+			 * microphone
+			 */
+			writew(0x0007, spec->mem_base + 0x320);
+			writew(0x0104, spec->mem_base + 0x320);
+			writew(0x0101, spec->mem_base + 0x320);
+			chipio_set_control_param(codec, 0x0D, 0x18);
+			break;
+		case QUIRK_R3DI:
+			chipio_set_control_param(codec, 0x0D, 0x24);
+			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
+			break;
+		}
+
+		/* disable headphone node */
+		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[1], 0,
+					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		snd_hda_set_pin_ctl(codec, spec->out_pins[1],
+				    pin_ctl & ~PIN_HP);
+		/* enable line-out node */
+		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[0], 0,
+					     AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		snd_hda_set_pin_ctl(codec, spec->out_pins[0],
+				    pin_ctl | PIN_OUT);
+		/* Enable EAPD */
+		snd_hda_codec_write(codec, spec->out_pins[0], 0,
+			AC_VERB_SET_EAPD_BTLENABLE, 0x01);
+
+		/* If PlayEnhancement is enabled, set different source */
+		if (spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID])
+			dspio_set_uint_param(codec, 0x80, 0x04, FLOAT_1);
+		else
+			dspio_set_uint_param(codec, 0x80, 0x04, FLOAT_8);
+
+		/* run through the output dsp commands for line-out */
+		for (i = 0; i < alt_out_presets[spec->cur_out_type].commands;
+				i++) {
+			err = dspio_set_uint_param(codec,
+			alt_out_presets[spec->cur_out_type].mids[i],
+			alt_out_presets[spec->cur_out_type].reqs[i],
+			alt_out_presets[spec->cur_out_type].vals[i]);
+
+			if (err < 0)
+				goto exit;
+		}
+		break;
+	case HEADPHONE_OUT:
+		codec_dbg(codec, "ca0132_alt_select_out hp\n");
+		/* Headphone out config*/
+		switch (spec->quirk) {
+		case QUIRK_SBZ:
+			writew(0x0107, spec->mem_base + 0x320);
+			writew(0x0104, spec->mem_base + 0x320);
+			writew(0x0001, spec->mem_base + 0x320);
+			chipio_set_control_param(codec, 0x0D, 0x12);
+			break;
+		case QUIRK_R3DI:
+			chipio_set_control_param(codec, 0x0D, 0x21);
+			r3di_gpio_out_set(codec, R3DI_HEADPHONE_OUT);
+			break;
+		}
+
+		snd_hda_codec_write(codec, spec->out_pins[0], 0,
+			AC_VERB_SET_EAPD_BTLENABLE, 0x00);
+
+		/* disable speaker*/
+		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[0], 0,
+					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		snd_hda_set_pin_ctl(codec, spec->out_pins[0],
+				pin_ctl & ~PIN_HP);
+
+		/* enable headphone, either front or rear */
+
+		if (snd_hda_jack_detect(codec, spec->unsol_tag_front_hp))
+			headphone_nid = spec->out_pins[2];
+		else if (snd_hda_jack_detect(codec, spec->unsol_tag_hp))
+			headphone_nid = spec->out_pins[1];
+
+		pin_ctl = snd_hda_codec_read(codec, headphone_nid, 0,
+					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		snd_hda_set_pin_ctl(codec, headphone_nid,
+				    pin_ctl | PIN_HP);
+
+		if (spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID])
+			dspio_set_uint_param(codec, 0x80, 0x04, FLOAT_1);
+		else
+			dspio_set_uint_param(codec, 0x80, 0x04, FLOAT_0);
+
+		for (i = 0; i < alt_out_presets[spec->cur_out_type].commands;
+				i++) {
+			err = dspio_set_uint_param(codec,
+			alt_out_presets[spec->cur_out_type].mids[i],
+			alt_out_presets[spec->cur_out_type].reqs[i],
+			alt_out_presets[spec->cur_out_type].vals[i]);
+
+			if (err < 0)
+				goto exit;
+		}
+		break;
+	case SURROUND_OUT:
+		codec_dbg(codec, "ca0132_alt_select_out Surround\n");
+		/* Surround out config*/
+		switch (spec->quirk) {
+		case QUIRK_SBZ:
+			writew(0x0007, spec->mem_base + 0x320);
+			writew(0x0104, spec->mem_base + 0x320);
+			writew(0x0101, spec->mem_base + 0x320);
+			chipio_set_control_param(codec, 0x0D, 0x18);
+			break;
+		case QUIRK_R3DI:
+			chipio_set_control_param(codec, 0x0D, 0x24);
+			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
+			break;
+		}
+		/* enable line out node */
+		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[0], 0,
+					     AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		snd_hda_set_pin_ctl(codec, spec->out_pins[0],
+						pin_ctl | PIN_OUT);
+		/* Disable headphone out */
+		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[1], 0,
+					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		snd_hda_set_pin_ctl(codec, spec->out_pins[1],
+				    pin_ctl & ~PIN_HP);
+		/* Enable EAPD on line out */
+		snd_hda_codec_write(codec, spec->out_pins[0], 0,
+			AC_VERB_SET_EAPD_BTLENABLE, 0x01);
+		/* enable center/lfe out node */
+		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[2], 0,
+					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		snd_hda_set_pin_ctl(codec, spec->out_pins[2],
+				    pin_ctl | PIN_OUT);
+		/* Now set rear surround node as out. */
+		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[3], 0,
+					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		snd_hda_set_pin_ctl(codec, spec->out_pins[3],
+				    pin_ctl | PIN_OUT);
+
+		if (spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID])
+			dspio_set_uint_param(codec, 0x80, 0x04, FLOAT_1);
+		else
+			dspio_set_uint_param(codec, 0x80, 0x04, FLOAT_8);
+
+		for (i = 0; i < alt_out_presets[spec->cur_out_type].commands;
+				i++) {
+			err = dspio_set_uint_param(codec,
+			alt_out_presets[spec->cur_out_type].mids[i],
+			alt_out_presets[spec->cur_out_type].reqs[i],
+			alt_out_presets[spec->cur_out_type].vals[i]);
+
+			if (err < 0)
+				goto exit;
+		}
+		break;
+	}
+
+exit:
+	snd_hda_power_down_pm(codec);
+
+	return err < 0 ? err : 0;
+}
+
+/*
  * Select the active output.
  * If autodetect is enabled, output will be selected based on jack detection.
  * If jack inserted, headphone will be selected, else built-in speakers
  * If autodetect is disabled, output will be selected based on selection.
  */
+
 static int ca0132_select_out(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
@@ -3180,12 +4240,12 @@ static int ca0132_select_out(struct hda_codec *codec)
 	if (spec->cur_out_type == SPEAKER_OUT) {
 		codec_dbg(codec, "ca0132_select_out speaker\n");
 		/*speaker out config*/
-		tmp = FLOAT_ONE;
+		tmp = FLOAT_1;
 		err = dspio_set_uint_param(codec, 0x80, 0x04, tmp);
 		if (err < 0)
 			goto exit;
 		/*enable speaker EQ*/
-		tmp = FLOAT_ONE;
+		tmp = FLOAT_1;
 		err = dspio_set_uint_param(codec, 0x8f, 0x00, tmp);
 		if (err < 0)
 			goto exit;
@@ -3213,12 +4273,12 @@ static int ca0132_select_out(struct hda_codec *codec)
 	} else {
 		codec_dbg(codec, "ca0132_select_out hp\n");
 		/*headphone out config*/
-		tmp = FLOAT_ZERO;
+		tmp = FLOAT_0;
 		err = dspio_set_uint_param(codec, 0x80, 0x04, tmp);
 		if (err < 0)
 			goto exit;
 		/*disable speaker EQ*/
-		tmp = FLOAT_ZERO;
+		tmp = FLOAT_0;
 		err = dspio_set_uint_param(codec, 0x8f, 0x00, tmp);
 		if (err < 0)
 			goto exit;
@@ -3256,8 +4316,18 @@ static void ca0132_unsol_hp_delayed(struct work_struct *work)
 	struct ca0132_spec *spec = container_of(
 		to_delayed_work(work), struct ca0132_spec, unsol_hp_work);
 	struct hda_jack_tbl *jack;
+	switch (spec->quirk) {
+	case QUIRK_SBZ:
+		ca0132_alt_select_out(spec->codec);
+		break;
+	case QUIRK_R3DI:
+		ca0132_alt_select_out(spec->codec);
+		break;
+	case QUIRK_NONE:
+		ca0132_select_out(spec->codec);
+		break;
+	}
 
-	ca0132_select_out(spec->codec);
 	jack = snd_hda_jack_tbl_get(spec->codec, spec->unsol_tag_hp);
 	if (jack) {
 		jack->block_report = 0;
@@ -3266,8 +4336,77 @@ static void ca0132_unsol_hp_delayed(struct work_struct *work)
 }
 
 static void ca0132_set_dmic(struct hda_codec *codec, int enable);
+static void resume_mic1(struct hda_codec *codec, unsigned int oldval);
+static int stop_mic1(struct hda_codec *codec);
 static int ca0132_mic_boost_set(struct hda_codec *codec, long val);
 static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val);
+static int ca0132_cvoice_switch_set(struct hda_codec *codec);
+static int ca0132_alt_mic_boost_set(struct hda_codec *codec, long val);
+
+static int ca0132_alt_set_vipsource(struct hda_codec *codec, int val)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int tmp;
+
+	if (spec->dsp_state != DSP_DOWNLOADED)
+		return 0;
+
+	codec_dbg(codec, "ca0132_alt_set_vipsource");
+
+	chipio_set_stream_control(codec, 0x03, 0);
+	chipio_set_stream_control(codec, 0x04, 0);
+
+	/* if CrystalVoice is off, vipsource should be 0 */
+	if (!spec->effects_switch[CRYSTAL_VOICE - EFFECT_START_NID] ||
+	    (val == 0) || spec->in_enum_val == REAR_LINE_IN) {
+		codec_dbg(codec, "ca0132_alt_set_vipsource off.");
+		chipio_set_control_param(codec, CONTROL_PARAM_VIP_SOURCE, 0);
+
+		tmp = FLOAT_0;
+		dspio_set_uint_param(codec, 0x80, 0x05, tmp);
+
+		chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
+		chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_96_000);
+		if (spec->quirk == QUIRK_R3DI)
+			chipio_set_conn_rate(codec, 0x0F, SR_96_000);
+
+
+		if (spec->in_enum_val == REAR_LINE_IN)
+			tmp = FLOAT_0;
+		else {
+			if (spec->quirk == QUIRK_SBZ)
+				tmp = FLOAT_3;
+			else
+				tmp = FLOAT_1;
+		}
+
+		dspio_set_uint_param(codec, 0x80, 0x00, tmp);
+
+	} else {
+		codec_dbg(codec, "ca0132_alt_set_vipsource on.");
+		chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_16_000);
+		chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_16_000);
+		if (spec->quirk == QUIRK_R3DI)
+			chipio_set_conn_rate(codec, 0x0F, SR_16_000);
+
+		if (spec->effects_switch[VOICE_FOCUS - EFFECT_START_NID])
+			tmp = FLOAT_2;
+		else
+			tmp = FLOAT_1;
+		dspio_set_uint_param(codec, 0x80, 0x00, tmp);
+
+		tmp = FLOAT_1;
+		dspio_set_uint_param(codec, 0x80, 0x05, tmp);
+
+		msleep(20);
+		chipio_set_control_param(codec, CONTROL_PARAM_VIP_SOURCE, val);
+	}
+
+	chipio_set_stream_control(codec, 0x03, 1);
+	chipio_set_stream_control(codec, 0x04, 1);
+
+	return 1;
+}
 
 /*
  * Select the active VIP source
@@ -3283,25 +4422,27 @@ static int ca0132_set_vipsource(struct hda_codec *codec, int val)
 	/* if CrystalVoice if off, vipsource should be 0 */
 	if (!spec->effects_switch[CRYSTAL_VOICE - EFFECT_START_NID] ||
 	    (val == 0)) {
+		codec_dbg(codec, "ca0132_set_vipsource off.");
 		chipio_set_control_param(codec, CONTROL_PARAM_VIP_SOURCE, 0);
 		chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
 		chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_96_000);
 		if (spec->cur_mic_type == DIGITAL_MIC)
-			tmp = FLOAT_TWO;
+			tmp = FLOAT_2;
 		else
-			tmp = FLOAT_ONE;
+			tmp = FLOAT_1;
 		dspio_set_uint_param(codec, 0x80, 0x00, tmp);
-		tmp = FLOAT_ZERO;
+		tmp = FLOAT_0;
 		dspio_set_uint_param(codec, 0x80, 0x05, tmp);
 	} else {
+		codec_dbg(codec, "ca0132_set_vipsource on.");
 		chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_16_000);
 		chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_16_000);
 		if (spec->cur_mic_type == DIGITAL_MIC)
-			tmp = FLOAT_TWO;
+			tmp = FLOAT_2;
 		else
-			tmp = FLOAT_ONE;
+			tmp = FLOAT_1;
 		dspio_set_uint_param(codec, 0x80, 0x00, tmp);
-		tmp = FLOAT_ONE;
+		tmp = FLOAT_1;
 		dspio_set_uint_param(codec, 0x80, 0x05, tmp);
 		msleep(20);
 		chipio_set_control_param(codec, CONTROL_PARAM_VIP_SOURCE, val);
@@ -3363,6 +4504,129 @@ static int ca0132_select_mic(struct hda_codec *codec)
 }
 
 /*
+ * Select the active input.
+ * Mic detection isn't used, because it's kind of pointless on the SBZ.
+ * The front mic has no jack-detection, so the only way to switch to it
+ * is to do it manually in alsamixer.
+ */
+
+static int ca0132_alt_select_in(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int tmp;
+
+	codec_dbg(codec, "ca0132_alt_select_in\n");
+
+	snd_hda_power_up_pm(codec);
+
+	chipio_set_stream_control(codec, 0x03, 0);
+	chipio_set_stream_control(codec, 0x04, 0);
+
+	spec->cur_mic_type = spec->in_enum_val;
+
+	switch (spec->cur_mic_type) {
+	case REAR_MIC:
+		switch (spec->quirk) {
+		case QUIRK_SBZ:
+			writew(0x0000, spec->mem_base + 0x320);
+			tmp = FLOAT_3;
+			break;
+		case QUIRK_R3DI:
+			r3di_gpio_mic_set(codec, R3DI_REAR_MIC);
+			tmp = FLOAT_1;
+			break;
+		default:
+			tmp = FLOAT_1;
+			break;
+		}
+
+		chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
+		chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_96_000);
+
+		if (spec->quirk == QUIRK_R3DI)
+			chipio_set_conn_rate(codec, 0x0F, SR_96_000);
+
+		dspio_set_uint_param(codec, 0x80, 0x00, tmp);
+
+		chipio_set_stream_control(codec, 0x03, 1);
+		chipio_set_stream_control(codec, 0x04, 1);
+
+		if (spec->quirk == QUIRK_SBZ) {
+			chipio_write(codec, 0x18B098, 0x0000000C);
+			chipio_write(codec, 0x18B09C, 0x0000000C);
+		}
+
+		ca0132_alt_mic_boost_set(codec, spec->mic_boost_enum_val);
+		break;
+	case REAR_LINE_IN:
+		ca0132_alt_mic_boost_set(codec, 0);
+		switch (spec->quirk) {
+		case QUIRK_SBZ:
+			writew(0x0000, spec->mem_base + 0x320);
+			break;
+		case QUIRK_R3DI:
+			r3di_gpio_mic_set(codec, R3DI_REAR_MIC);
+			break;
+		}
+
+		chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
+		chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_96_000);
+
+		if (spec->quirk == QUIRK_R3DI)
+			chipio_set_conn_rate(codec, 0x0F, SR_96_000);
+
+		tmp = FLOAT_0;
+		dspio_set_uint_param(codec, 0x80, 0x00, tmp);
+
+		if (spec->quirk == QUIRK_SBZ) {
+			chipio_write(codec, 0x18B098, 0x00000000);
+			chipio_write(codec, 0x18B09C, 0x00000000);
+		}
+
+		chipio_set_stream_control(codec, 0x03, 1);
+		chipio_set_stream_control(codec, 0x04, 1);
+		break;
+	case FRONT_MIC:
+		switch (spec->quirk) {
+		case QUIRK_SBZ:
+			writew(0x0100, spec->mem_base + 0x320);
+			writew(0x0005, spec->mem_base + 0x320);
+			tmp = FLOAT_3;
+			break;
+		case QUIRK_R3DI:
+			r3di_gpio_mic_set(codec, R3DI_FRONT_MIC);
+			tmp = FLOAT_1;
+			break;
+		default:
+			tmp = FLOAT_1;
+			break;
+		}
+
+		chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
+		chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_96_000);
+		if (spec->quirk == QUIRK_R3DI)
+			chipio_set_conn_rate(codec, 0x0F, SR_96_000);
+
+		dspio_set_uint_param(codec, 0x80, 0x00, tmp);
+
+		chipio_set_stream_control(codec, 0x03, 1);
+		chipio_set_stream_control(codec, 0x04, 1);
+
+		if (spec->quirk == QUIRK_SBZ) {
+			chipio_write(codec, 0x18B098, 0x0000000C);
+			chipio_write(codec, 0x18B09C, 0x000000CC);
+		}
+		ca0132_alt_mic_boost_set(codec, spec->mic_boost_enum_val);
+		break;
+	}
+	ca0132_cvoice_switch_set(codec);
+
+	snd_hda_power_down_pm(codec);
+	return 0;
+
+}
+
+/*
  * Check if VNODE settings take effect immediately.
  */
 static bool ca0132_is_vnode_effective(struct hda_codec *codec,
@@ -3391,7 +4655,7 @@ static bool ca0132_is_vnode_effective(struct hda_codec *codec,
 
 /*
 * The following functions are control change helpers.
-* They return 0 if no changed.  Return 1 if changed.
+* They return 0 if no changed.	Return 1 if changed.
 */
 static int ca0132_voicefx_set(struct hda_codec *codec, int enable)
 {
@@ -3401,9 +4665,9 @@ static int ca0132_voicefx_set(struct hda_codec *codec, int enable)
 	/* based on CrystalVoice state to enable VoiceFX. */
 	if (enable) {
 		tmp = spec->effects_switch[CRYSTAL_VOICE - EFFECT_START_NID] ?
-			FLOAT_ONE : FLOAT_ZERO;
+			FLOAT_1 : FLOAT_0;
 	} else {
-		tmp = FLOAT_ZERO;
+		tmp = FLOAT_0;
 	}
 
 	dspio_set_uint_param(codec, ca0132_voicefx.mid,
@@ -3418,7 +4682,7 @@ static int ca0132_voicefx_set(struct hda_codec *codec, int enable)
 static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val)
 {
 	struct ca0132_spec *spec = codec->spec;
-	unsigned int on;
+	unsigned int on, tmp;
 	int num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT;
 	int err = 0;
 	int idx = nid - EFFECT_START_NID;
@@ -3435,19 +4699,63 @@ static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val)
 
 	/* for in effect, qualify with CrystalVoice */
 	if ((nid >= IN_EFFECT_START_NID) && (nid < IN_EFFECT_END_NID)) {
-		/* if CrystalVoice if off, turn off in effects. */
+		/* if CrystalVoice is off, turn off in effects. */
 		if (!spec->effects_switch[CRYSTAL_VOICE - EFFECT_START_NID])
 			val = 0;
 
+
 		/* Voice Focus applies to 2-ch Mic, Digital Mic */
-		if ((nid == VOICE_FOCUS) && (spec->cur_mic_type != DIGITAL_MIC))
+		if ((nid == VOICE_FOCUS) && (spec->cur_mic_type != DIGITAL_MIC)
+				     &&	(spec->quirk != QUIRK_SBZ))
 			val = 0;
+
+		/* If Voice Focus on SBZ, set to two channel. */
+		if ((nid == VOICE_FOCUS) && (spec->quirk == QUIRK_SBZ)
+				&& (spec->cur_mic_type != REAR_LINE_IN)) {
+			if (spec->effects_switch[CRYSTAL_VOICE -
+						 EFFECT_START_NID]) {
+
+				if (spec->effects_switch[VOICE_FOCUS -
+							 EFFECT_START_NID])
+					tmp = FLOAT_2;
+				else
+					tmp = FLOAT_1;
+
+				dspio_set_uint_param(codec, 0x80, 0x00, tmp);
+			}
+		}
+
+		/*
+		 * For SBZ noise reduction, there's an extra command
+		 * to module ID 0x47. No clue why.
+		 */
+		if ((nid == NOISE_REDUCTION) && (spec->quirk == QUIRK_SBZ)
+				&& (spec->cur_mic_type != REAR_LINE_IN)) {
+			if (spec->effects_switch[CRYSTAL_VOICE -
+						 EFFECT_START_NID]) {
+				if (spec->effects_switch[NOISE_REDUCTION -
+							 EFFECT_START_NID])
+					tmp = FLOAT_1;
+				else
+					tmp = FLOAT_0;
+			} else
+				tmp = FLOAT_0;
+
+			dspio_set_uint_param(codec, 0x47, 0x00, tmp);
+		}
+
+		/* If rear line in disable effects. */
+		if (spec->quirk != QUIRK_NONE &&
+				spec->in_enum_val == REAR_LINE_IN) {
+			val = 0;
+		}
+
 	}
 
 	codec_dbg(codec, "ca0132_effect_set: nid=0x%x, val=%ld\n",
 		    nid, val);
 
-	on = (val == 0) ? FLOAT_ZERO : FLOAT_ONE;
+	on = (val == 0) ? FLOAT_0 : FLOAT_1;
 	err = dspio_set_uint_param(codec, ca0132_effects[idx].mid,
 				   ca0132_effects[idx].reqs[0], on);
 
@@ -3469,6 +4777,9 @@ static int ca0132_pe_switch_set(struct hda_codec *codec)
 	codec_dbg(codec, "ca0132_pe_switch_set: val=%ld\n",
 		    spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID]);
 
+	if (spec->quirk != QUIRK_NONE)
+		ca0132_alt_select_out(codec);
+
 	i = OUT_EFFECT_START_NID - EFFECT_START_NID;
 	nid = OUT_EFFECT_START_NID;
 	/* PE affects all out effects */
@@ -3515,6 +4826,11 @@ static int ca0132_cvoice_switch_set(struct hda_codec *codec)
 	codec_dbg(codec, "ca0132_cvoice_switch_set: val=%ld\n",
 		    spec->effects_switch[CRYSTAL_VOICE - EFFECT_START_NID]);
 
+	if (spec->quirk != QUIRK_NONE) {
+		if (spec->in_enum_val == REAR_LINE_IN)
+			codec_dbg(codec, "Line-in, no CrystalVoice.");
+	}
+
 	i = IN_EFFECT_START_NID - EFFECT_START_NID;
 	nid = IN_EFFECT_START_NID;
 	/* CrystalVoice affects all in effects */
@@ -3526,7 +4842,10 @@ static int ca0132_cvoice_switch_set(struct hda_codec *codec)
 
 	/* set correct vipsource */
 	oldval = stop_mic1(codec);
-	ret |= ca0132_set_vipsource(codec, 1);
+	if (spec->quirk != QUIRK_NONE)
+		ret |= ca0132_alt_set_vipsource(codec, 1);
+	else
+		ret |= ca0132_set_vipsource(codec, 1);
 	resume_mic1(codec, oldval);
 	return ret;
 }
@@ -3546,6 +4865,16 @@ static int ca0132_mic_boost_set(struct hda_codec *codec, long val)
 	return ret;
 }
 
+static int ca0132_alt_mic_boost_set(struct hda_codec *codec, long val)
+{
+	struct ca0132_spec *spec = codec->spec;
+	int ret = 0;
+
+	ret = snd_hda_codec_amp_update(codec, spec->input_pins[0], 0,
+				HDA_INPUT, 0, HDA_AMP_VOLMASK, val);
+	return ret;
+}
+
 static int ca0132_vnode_switch_set(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
@@ -3560,9 +4889,21 @@ static int ca0132_vnode_switch_set(struct snd_kcontrol *kcontrol,
 	if (nid == VNID_HP_SEL) {
 		auto_jack =
 			spec->vnode_lswitch[VNID_HP_ASEL - VNODE_START_NID];
-		if (!auto_jack)
-			ca0132_select_out(codec);
-		return 1;
+		if (!auto_jack) {
+			switch (spec->quirk) {
+			case QUIRK_SBZ:
+				ca0132_alt_select_out(codec);
+				break;
+			case QUIRK_R3DI:
+				ca0132_alt_select_out(codec);
+				break;
+			case QUIRK_NONE:
+				ca0132_select_out(codec);
+				break;
+			}
+
+			return 1;
+		}
 	}
 
 	if (nid == VNID_AMIC1_SEL) {
@@ -3574,7 +4915,18 @@ static int ca0132_vnode_switch_set(struct snd_kcontrol *kcontrol,
 	}
 
 	if (nid == VNID_HP_ASEL) {
-		ca0132_select_out(codec);
+
+		switch (spec->quirk) {
+		case QUIRK_SBZ:
+			ca0132_alt_select_out(codec);
+			break;
+		case QUIRK_R3DI:
+			ca0132_alt_select_out(codec);
+			break;
+		case QUIRK_NONE:
+			ca0132_select_out(codec);
+			break;
+		}
 		return 1;
 	}
 
@@ -3603,10 +4955,236 @@ static int ca0132_vnode_switch_set(struct snd_kcontrol *kcontrol,
 }
 /* End of control change helpers. */
 
+/*
+ * Mic Boost Enum for alternative ca0132 codecs. I didn't like that the original
+ * only has off or full 30 dB, and didn't like making a volume slider that has
+ * traditional 0-100 in alsamixer that goes in big steps. I like enum better.
+ */
+
+#define MIC_BOOST_NUM_OF_STEPS 4
+#define MIC_BOOST_ENUM_MAX_STRLEN 10
+
+static int ca0132_alt_mic_boost_info(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	char *sfx = "dB";
+	char namestr[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = MIC_BOOST_NUM_OF_STEPS;
+	if (uinfo->value.enumerated.item >= MIC_BOOST_NUM_OF_STEPS)
+		uinfo->value.enumerated.item = MIC_BOOST_NUM_OF_STEPS - 1;
+	sprintf(namestr, "%d %s", (uinfo->value.enumerated.item * 10), sfx);
+	strcpy(uinfo->value.enumerated.name, namestr);
+	return 0;
+}
+
+static int ca0132_alt_mic_boost_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+
+	ucontrol->value.enumerated.item[0] = spec->mic_boost_enum_val;
+	return 0;
+}
+
+static int ca0132_alt_mic_boost_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+	int sel = ucontrol->value.enumerated.item[0];
+	unsigned int items = MIC_BOOST_NUM_OF_STEPS;
+
+	if (sel >= items)
+		return 0;
+
+	codec_dbg(codec, "ca0132_alt_mic_boost: boost=%d\n",
+		    sel);
+
+	spec->mic_boost_enum_val = sel;
+
+	ca0132_alt_mic_boost_set(codec, spec->mic_boost_enum_val);
+
+	return 1;
+}
+
+
+/*
+ * Input Select Control for alternative ca0132 codecs. This exists because
+ * front microphone has no auto-detect, and we need a way to set the rear
+ * as line-in
+ */
+
+static int ca0132_alt_input_source_info(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = IN_SRC_NUM_OF_INPUTS;
+	if (uinfo->value.enumerated.item >= IN_SRC_NUM_OF_INPUTS)
+		uinfo->value.enumerated.item = IN_SRC_NUM_OF_INPUTS - 1;
+	strcpy(uinfo->value.enumerated.name,
+	       in_src_str[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int ca0132_alt_input_source_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+
+	ucontrol->value.enumerated.item[0] = spec->in_enum_val;
+	return 0;
+}
+
+static int ca0132_alt_input_source_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+	int sel = ucontrol->value.enumerated.item[0];
+	unsigned int items = IN_SRC_NUM_OF_INPUTS;
+
+	if (sel >= items)
+		return 0;
+
+	codec_dbg(codec, "ca0132_alt_input_select: sel=%d, preset=%s\n",
+		    sel, in_src_str[sel]);
+
+	spec->in_enum_val = sel;
+
+	ca0132_alt_select_in(codec);
+
+	return 1;
+}
+
+/* Sound Blaster Z Output Select Control */
+
+static int ca0132_alt_output_select_get_info(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = SBZ_NUM_OF_OUTPUTS;
+	if (uinfo->value.enumerated.item >= SBZ_NUM_OF_OUTPUTS)
+		uinfo->value.enumerated.item = SBZ_NUM_OF_OUTPUTS - 1;
+	strcpy(uinfo->value.enumerated.name,
+	       alt_out_presets[uinfo->value.enumerated.item].name);
+	return 0;
+}
+
+static int ca0132_alt_output_select_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+
+	ucontrol->value.enumerated.item[0] = spec->out_enum_val;
+	return 0;
+}
+
+static int ca0132_alt_output_select_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+	int sel = ucontrol->value.enumerated.item[0];
+	unsigned int items = SBZ_NUM_OF_OUTPUTS;
+	unsigned int auto_jack;
+
+	if (sel >= items)
+		return 0;
+
+	codec_dbg(codec, "ca0132_alt_output_select: sel=%d, preset=%s\n",
+		    sel, alt_out_presets[sel].name);
+
+	spec->out_enum_val = sel;
+
+	auto_jack = spec->vnode_lswitch[VNID_HP_ASEL - VNODE_START_NID];
+
+	if (!auto_jack)
+		ca0132_alt_select_out(codec);
+
+	return 1;
+}
+
+/*
+ * Smart Volume output setting control. Three different settings, Normal,
+ * which takes the value from the smart volume slider. The two others, loud
+ * and night, disregard the slider value and have uneditable values.
+ */
+
+static int ca0132_alt_svm_setting_info(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = NUM_OF_SVM_SETTINGS;
+	if (uinfo->value.enumerated.item >= NUM_OF_SVM_SETTINGS)
+		uinfo->value.enumerated.item = NUM_OF_SVM_SETTINGS - 1;
+	strcpy(uinfo->value.enumerated.name,
+	       out_svm_set_enum_str[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int ca0132_alt_svm_setting_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+
+	ucontrol->value.enumerated.item[0] = spec->smart_volume_setting;
+	return 0;
+}
+
+static int ca0132_alt_svm_setting_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+	int sel = ucontrol->value.enumerated.item[0];
+	unsigned int items = NUM_OF_SVM_SETTINGS;
+	unsigned int idx = SMART_VOLUME - EFFECT_START_NID;
+	unsigned int tmp;
+
+	if (sel >= items)
+		return 0;
+
+	codec_dbg(codec, "ca0132_alt_svm_setting: sel=%d, preset=%s\n",
+		    sel, out_svm_set_enum_str[sel]);
+
+	spec->smart_volume_setting = sel;
+
+	switch (sel) {
+	case 0:
+		tmp = FLOAT_0;
+		break;
+	case 1:
+		tmp = FLOAT_1;
+		break;
+	case 2:
+		tmp = FLOAT_2;
+		break;
+	default:
+		tmp = FLOAT_0;
+		break;
+	}
+	/* Req 2 is the Smart Volume Setting req. */
+	dspio_set_uint_param(codec, ca0132_effects[idx].mid,
+			  ca0132_effects[idx].reqs[2], tmp);
+
+	return 1;
+}
+
 static int ca0132_voicefx_info(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_info *uinfo)
 {
-	unsigned int items = ARRAY_SIZE(ca0132_voicefx_presets);
+	unsigned int items = sizeof(ca0132_voicefx_presets)
+				/ sizeof(struct ct_voicefx_preset);
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
@@ -3635,8 +5213,10 @@ static int ca0132_voicefx_put(struct snd_kcontrol *kcontrol,
 	struct ca0132_spec *spec = codec->spec;
 	int i, err = 0;
 	int sel = ucontrol->value.enumerated.item[0];
+	unsigned int items = sizeof(ca0132_voicefx_presets)
+				/ sizeof(struct ct_voicefx_preset);
 
-	if (sel >= ARRAY_SIZE(ca0132_voicefx_presets))
+	if (sel >= items)
 		return 0;
 
 	codec_dbg(codec, "ca0132_voicefx_put: sel=%d, preset=%s\n",
@@ -3663,6 +5243,68 @@ static int ca0132_voicefx_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
+/* Sound Blaster Z EQ preset controls */
+
+static int ca0132_alt_eq_preset_info(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	unsigned int items = sizeof(ca0132_alt_eq_presets)
+				/ sizeof(struct ct_eq_preset);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = items;
+	if (uinfo->value.enumerated.item >= items)
+		uinfo->value.enumerated.item = items - 1;
+	strcpy(uinfo->value.enumerated.name,
+	       ca0132_alt_eq_presets[uinfo->value.enumerated.item].name);
+	return 0;
+}
+
+static int ca0132_alt_eq_preset_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+
+	ucontrol->value.enumerated.item[0] = spec->eq_preset_val;
+	return 0;
+}
+
+static int ca0132_alt_eq_preset_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+	int i, err = 0;
+	int sel = ucontrol->value.enumerated.item[0];
+	unsigned int items = sizeof(ca0132_alt_eq_presets)
+				/ sizeof(struct ct_eq_preset);
+
+	if (sel >= items)
+		return 0;
+
+	codec_dbg(codec, "ca0132_alt_eq_preset_put: sel=%d, preset=%s\n",
+		    sel, ca0132_alt_eq_presets[sel].name);
+
+	/*
+	 * Idx 0 is default.
+	 * Default needs to qualify with CrystalVoice state.
+	 */
+	for (i = 0; i < EQ_PRESET_MAX_PARAM_COUNT; i++) {
+		err = dspio_set_uint_param(codec, ca0132_alt_eq_enum.mid,
+				ca0132_alt_eq_enum.reqs[i],
+				ca0132_alt_eq_presets[sel].vals[i]);
+		if (err < 0)
+			break;
+	}
+
+	if (err >= 0)
+		spec->eq_preset_val = sel;
+
+	return 1;
+}
+
 static int ca0132_switch_get(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
@@ -3714,6 +5356,7 @@ static int ca0132_switch_put(struct snd_kcontrol *kcontrol,
 		    nid, *valp);
 
 	snd_hda_power_up(codec);
+
 	/* vnode */
 	if ((nid >= VNODE_START_NID) && (nid < VNODE_END_NID)) {
 		if (ch & 1) {
@@ -3755,8 +5398,13 @@ static int ca0132_switch_put(struct snd_kcontrol *kcontrol,
 		spec->cur_mic_boost = *valp;
 
 		/* Mic boost does not apply to Digital Mic */
-		if (spec->cur_mic_type != DIGITAL_MIC)
-			changed = ca0132_mic_boost_set(codec, *valp);
+		if (spec->quirk == QUIRK_SBZ || spec->quirk == QUIRK_R3DI) {
+			if (spec->in_enum_val != REAR_LINE_IN)
+				changed = ca0132_mic_boost_set(codec, *valp);
+		} else {
+			if (spec->cur_mic_type != DIGITAL_MIC)
+				changed = ca0132_mic_boost_set(codec, *valp);
+		}
 		goto exit;
 	}
 
@@ -3856,6 +5504,7 @@ static int ca0132_volume_put(struct snd_kcontrol *kcontrol,
 		unsigned long pval;
 
 		snd_hda_power_up(codec);
+		ca0132_alt_dsp_volume_put(codec, nid);
 		mutex_lock(&codec->control_mutex);
 		pval = kcontrol->private_value;
 		kcontrol->private_value = HDA_COMPOSE_AMP_VAL(shared_nid, ch,
@@ -3907,29 +5556,148 @@ static int ca0132_volume_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 	return err;
 }
 
+/*
+ * Added the FX: prefix for the SBZ, because otherwise the surround effect
+ * takes over the actual surround volume switch. Plus, makes it more clear
+ * what the switches mean. Kept it only on the SBZ just in case it would
+ * disturb the Chromebook.
+ */
 static int add_fx_switch(struct hda_codec *codec, hda_nid_t nid,
 			 const char *pfx, int dir)
 {
+	struct ca0132_spec *spec = codec->spec;
+	char *fx = "FX:";
 	char namestr[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	int type = dir ? HDA_INPUT : HDA_OUTPUT;
 	struct snd_kcontrol_new knew =
 		CA0132_CODEC_MUTE_MONO(namestr, nid, 1, type);
-	sprintf(namestr, "%s %s Switch", pfx, dirstr[dir]);
+	if ((spec->quirk != QUIRK_NONE) && (nid <= IN_EFFECT_END_NID))
+		sprintf(namestr, "%s %s %s Switch", fx, pfx, dirstr[dir]);
+	else
+		sprintf(namestr, "%s %s Switch", pfx, dirstr[dir]);
+
 	return snd_hda_ctl_add(codec, nid, snd_ctl_new1(&knew, codec));
 }
 
-static int add_voicefx(struct hda_codec *codec)
+static int add_voicefx(struct hda_codec *codec)
+{
+	struct snd_kcontrol_new knew =
+		HDA_CODEC_MUTE_MONO(ca0132_voicefx.name,
+				    VOICEFX, 1, 0, HDA_INPUT);
+	knew.info = ca0132_voicefx_info;
+	knew.get = ca0132_voicefx_get;
+	knew.put = ca0132_voicefx_put;
+	return snd_hda_ctl_add(codec, VOICEFX, snd_ctl_new1(&knew, codec));
+}
+
+/* Create the Sound Blaster Z EQ Preset control */
+
+static int add_ca0132_alt_eq_presets(struct hda_codec *codec)
+{
+	struct snd_kcontrol_new knew =
+		HDA_CODEC_MUTE_MONO(ca0132_alt_eq_enum.name,
+				    EQ_PRESET_ENUM, 1, 0, HDA_OUTPUT);
+	knew.info = ca0132_alt_eq_preset_info;
+	knew.get = ca0132_alt_eq_preset_get;
+	knew.put = ca0132_alt_eq_preset_put;
+	return snd_hda_ctl_add(codec, EQ_PRESET_ENUM,
+				snd_ctl_new1(&knew, codec));
+}
+
+/*
+ * Create an Input Source enumerated control for the alternate ca0132 codecs
+ * because the front microphone has no auto-detect, and Line-in has to be set
+ * somehow.
+ */
+
+static int ca0132_alt_add_input_enum(struct hda_codec *codec)
+{
+	struct snd_kcontrol_new knew =
+		HDA_CODEC_MUTE_MONO("Input Source",
+				    INPUT_SOURCE_ENUM, 1, 0, HDA_INPUT);
+	knew.info = ca0132_alt_input_source_info;
+	knew.get = ca0132_alt_input_source_get;
+	knew.put = ca0132_alt_input_source_put;
+	return snd_hda_ctl_add(codec, INPUT_SOURCE_ENUM,
+				snd_ctl_new1(&knew, codec));
+}
+
+/*
+ * Create an Output Select enumerated control for codecs with surround
+ * out capabilities.
+ */
+
+static int ca0132_alt_add_output_enum(struct hda_codec *codec)
+{
+	struct snd_kcontrol_new knew =
+		HDA_CODEC_MUTE_MONO("Output Select",
+				    OUTPUT_SOURCE_ENUM, 1, 0, HDA_OUTPUT);
+	knew.info = ca0132_alt_output_select_get_info;
+	knew.get = ca0132_alt_output_select_get;
+	knew.put = ca0132_alt_output_select_put;
+	return snd_hda_ctl_add(codec, OUTPUT_SOURCE_ENUM,
+				snd_ctl_new1(&knew, codec));
+}
+
+/*
+ * Add enumerated control for the three different settings of the smart volume
+ * output effect. Normal just uses the slider value, and loud and night are
+ * their own things that ignore that value.
+ */
+
+static int ca0132_alt_add_svm_enum(struct hda_codec *codec)
+{
+	struct snd_kcontrol_new knew =
+		HDA_CODEC_MUTE_MONO("FX: Smart Volume Setting",
+				    SMART_VOLUME_ENUM, 1, 0, HDA_OUTPUT);
+	knew.info = ca0132_alt_svm_setting_info;
+	knew.get = ca0132_alt_svm_setting_get;
+	knew.put = ca0132_alt_svm_setting_put;
+	return snd_hda_ctl_add(codec, SMART_VOLUME_ENUM,
+				snd_ctl_new1(&knew, codec));
+
+}
+
+static int ca0132_alt_add_mic_boost_enum(struct hda_codec *codec)
 {
 	struct snd_kcontrol_new knew =
-		HDA_CODEC_MUTE_MONO(ca0132_voicefx.name,
-				    VOICEFX, 1, 0, HDA_INPUT);
-	knew.info = ca0132_voicefx_info;
-	knew.get = ca0132_voicefx_get;
-	knew.put = ca0132_voicefx_put;
-	return snd_hda_ctl_add(codec, VOICEFX, snd_ctl_new1(&knew, codec));
+		HDA_CODEC_MUTE_MONO("Mic Boost Capture Switch",
+				    MIC_BOOST_ENUM, 1, 0, HDA_INPUT);
+	knew.info = ca0132_alt_mic_boost_info;
+	knew.get = ca0132_alt_mic_boost_get;
+	knew.put = ca0132_alt_mic_boost_put;
+	return snd_hda_ctl_add(codec, MIC_BOOST_ENUM,
+				snd_ctl_new1(&knew, codec));
+
 }
 
 /*
+ * Need to create slave controls for the alternate codecs that have surround
+ * capabilities.
+ */
+static const char * const ca0132_alt_slave_pfxs[] = {
+	"Front", "Surround", "Center", "LFE", NULL,
+};
+
+/*
+ * Also need special channel map, because the default one is incorrect.
+ * I think this has to do with the pin for rear surround being 0x11,
+ * and the center/lfe being 0x10. Usually the pin order is the opposite.
+ */
+const struct snd_pcm_chmap_elem ca0132_alt_chmaps[] = {
+	{ .channels = 2,
+	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR } },
+	{ .channels = 4,
+	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,
+		   SNDRV_CHMAP_RL, SNDRV_CHMAP_RR } },
+	{ .channels = 6,
+	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,
+		   SNDRV_CHMAP_FC, SNDRV_CHMAP_LFE,
+		   SNDRV_CHMAP_RL, SNDRV_CHMAP_RR } },
+	{ }
+};
+
+/*
  * When changing Node IDs for Mixer Controls below, make sure to update
  * Node IDs in ca0132_config() as well.
  */
@@ -3955,10 +5723,38 @@ static struct snd_kcontrol_new ca0132_mixer[] = {
 	{ } /* end */
 };
 
+/*
+ * Separate mixer for alternate codecs,, includes controls for the surround
+ * nodes, and removes unused things, like Analog-Mic2 and Amic auto-detect.
+ * Leaving the HDA_CODEC_VOLUME and MUTE incase you want to remove the DSP
+ * volume settings. They work pretty well for now, only issue is a TLV
+ * mismatch that I can't figure out.
+ */
+static struct snd_kcontrol_new ca0132_alt_mixer[] = {
+//	HDA_CODEC_VOLUME("Front Playback Volume", 0x02, 0, HDA_OUTPUT),
+//	HDA_CODEC_MUTE("Front Playback Switch", 0x02, 0, HDA_OUTPUT),
+	CA0132_CODEC_VOL("Front Playback Volume", VNID_SPK, HDA_OUTPUT),
+	CA0132_CODEC_MUTE("Front Playback Switch", VNID_SPK, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Surround Playback Volume", 0x04, 0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Surround Playback Switch", 0x04, 0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x03, 1, 0, HDA_OUTPUT),
+	HDA_CODEC_MUTE_MONO("Center Playback Switch", 0x03, 1, 0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x03, 2, 0, HDA_OUTPUT),
+	HDA_CODEC_MUTE_MONO("LFE Playback Switch", 0x03, 2, 0, HDA_OUTPUT),
+	CA0132_CODEC_VOL("Capture Volume", VNID_MIC, HDA_INPUT),
+	CA0132_CODEC_MUTE("Capture Switch", VNID_MIC, HDA_INPUT),
+	HDA_CODEC_VOLUME("What U Hear Capture Volume", 0x0a, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("What U Hear Capture Switch", 0x0a, 0, HDA_INPUT),
+	CA0132_CODEC_MUTE_MONO("HP/Speaker Auto Detect Playback Switch",
+			       VNID_HP_ASEL, 1, HDA_OUTPUT),
+	{ } /* end */
+};
+
 static int ca0132_build_controls(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
-	int i, num_fx;
+	struct hda_pcm *pcm;
+	int i, num_fx, num_sliders;
 	int err = 0;
 
 	/* Add Mixer controls */
@@ -3967,8 +5763,22 @@ static int ca0132_build_controls(struct hda_codec *codec)
 		if (err < 0)
 			return err;
 	}
+	/* Setup vmaster with surround slaves for desktop ca0132 devices */
+	if (spec->quirk != QUIRK_NONE) {
+		snd_hda_set_vmaster_tlv(codec, spec->dacs[0], HDA_OUTPUT,
+					spec->tlv);
+		snd_hda_add_vmaster(codec, "Master Playback Volume",
+					spec->tlv, ca0132_alt_slave_pfxs,
+					"Playback Volume");
+		err = __snd_hda_add_vmaster(codec, "Master Playback Switch",
+					    NULL, ca0132_alt_slave_pfxs,
+					    "Playback Switch",
+					    true, &spec->vmaster_mute.sw_kctl);
+
+	}
 
-	/* Add in and out effects controls.
+	/*
+	 * Add in and out effects controls.
 	 * VoiceFX, PE and CrystalVoice are added separately.
 	 */
 	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT;
@@ -3979,21 +5789,63 @@ static int ca0132_build_controls(struct hda_codec *codec)
 		if (err < 0)
 			return err;
 	}
+	/*
+	 * Change the names for the non-chromebook versions to make it clearer
+	 * what these buttons actually do. Left them alone on the chromebook
+	 * just in case. Also, add output select enum.
+	 */
+	if (spec->quirk != QUIRK_NONE) {
+		ca0132_alt_add_svm_enum(codec);
+		ca0132_alt_add_output_enum(codec);
+		add_ca0132_alt_eq_presets(codec);
+		err = add_fx_switch(codec, PLAY_ENHANCEMENT,
+					"Enable OutFX", 0);
+		if (err < 0)
+			return err;
 
-	err = add_fx_switch(codec, PLAY_ENHANCEMENT, "PlayEnhancement", 0);
-	if (err < 0)
-		return err;
+		err = add_fx_switch(codec, CRYSTAL_VOICE,
+					"Enable InFX", 1);
+		if (err < 0)
+			return err;
+	} else {
+		err = add_fx_switch(codec, PLAY_ENHANCEMENT,
+					"PlayEnhancement", 0);
+		if (err < 0)
+			return err;
 
-	err = add_fx_switch(codec, CRYSTAL_VOICE, "CrystalVoice", 1);
-	if (err < 0)
-		return err;
+		err = add_fx_switch(codec, CRYSTAL_VOICE,
+					"CrystalVoice", 1);
+		if (err < 0)
+			return err;
+	}
 
 	add_voicefx(codec);
+	/* Add the input select enum, and all of the effect sliders. */
+	if (spec->quirk != QUIRK_NONE) {
+		ca0132_alt_add_mic_boost_enum(codec);
+		ca0132_alt_add_input_enum(codec);
+
+		num_sliders = OUT_EFFECTS_COUNT - 1;
+		for (i = 0; i < num_sliders; i++) {
+			err = ca0132_alt_add_effect_slider(codec,
+					    ca0132_effects[i].nid,
+					    ca0132_effects[i].name,
+					    ca0132_effects[i].direct);
+			if (err < 0)
+				return err;
+		}
+
+		err = ca0132_alt_add_effect_slider(codec, XBASS_XOVER,
+					"X-Bass Crossover", EFX_DIR_OUT);
 
+		if (err < 0)
+			return err;
+	}
 #ifdef ENABLE_TUNING_CONTROLS
 	add_tuning_ctls(codec);
 #endif
 
+
 	err = snd_hda_jack_add_kctls(codec, &spec->autocfg);
 	if (err < 0)
 		return err;
@@ -4014,6 +5866,27 @@ static int ca0132_build_controls(struct hda_codec *codec)
 		if (err < 0)
 			return err;
 	}
+
+	/*
+	 * if there is a possibility of having 6 channels, set up the proper
+	 * chmap. The SBZ has a funky setup that needs FR,FL,FC,LFE,RR,RL
+	 * instead of the more common FR,FL,RR,RL,FC,LFE. Not sure why.
+	 */
+	list_for_each_entry(pcm, &codec->pcm_list_head, list) {
+		struct hda_pcm_stream *hinfo =
+			&pcm->stream[SNDRV_PCM_STREAM_PLAYBACK];
+		struct snd_pcm_chmap *chmap;
+		const struct snd_pcm_chmap_elem *elem;
+
+		elem = ca0132_alt_chmaps;
+		if (hinfo->channels_max == 6) {
+			err = snd_pcm_add_chmap_ctls(pcm->pcm,
+					SNDRV_PCM_STREAM_PLAYBACK,
+					elem, hinfo->channels_max, 0, &chmap);
+			if (err < 0)
+				codec_dbg(codec, "snd_pcm_add_chmap_ctls failed!");
+		}
+	}
 	return 0;
 }
 
@@ -4065,23 +5938,30 @@ static int ca0132_build_pcms(struct hda_codec *codec)
 	struct ca0132_spec *spec = codec->spec;
 	struct hda_pcm *info;
 
+
 	info = snd_hda_codec_pcm_new(codec, "CA0132 Analog");
 	if (!info)
 		return -ENOMEM;
+	info->own_chmap = true;
+	info->stream[SNDRV_PCM_STREAM_PLAYBACK].chmap = ca0132_alt_chmaps;
 	info->stream[SNDRV_PCM_STREAM_PLAYBACK] = ca0132_pcm_analog_playback;
 	info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = spec->dacs[0];
 	info->stream[SNDRV_PCM_STREAM_PLAYBACK].channels_max =
-		spec->multiout.max_channels;
+						spec->multiout.max_channels;
 	info->stream[SNDRV_PCM_STREAM_CAPTURE] = ca0132_pcm_analog_capture;
 	info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams = 1;
 	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adcs[0];
 
-	info = snd_hda_codec_pcm_new(codec, "CA0132 Analog Mic-In2");
-	if (!info)
-		return -ENOMEM;
-	info->stream[SNDRV_PCM_STREAM_CAPTURE] = ca0132_pcm_analog_capture;
-	info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams = 1;
-	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adcs[1];
+	/* SBZ doesn't use this ADC. */
+	if (spec->quirk == QUIRK_NONE) {
+		info = snd_hda_codec_pcm_new(codec, "CA0132 Analog Mic-In2");
+		if (!info)
+			return -ENOMEM;
+		info->stream[SNDRV_PCM_STREAM_CAPTURE] =
+			ca0132_pcm_analog_capture;
+		info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams = 1;
+		info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adcs[1];
+	}
 
 	info = snd_hda_codec_pcm_new(codec, "CA0132 What U Hear");
 	if (!info)
@@ -4113,6 +5993,7 @@ static int ca0132_build_pcms(struct hda_codec *codec)
 
 static void init_output(struct hda_codec *codec, hda_nid_t pin, hda_nid_t dac)
 {
+
 	if (pin) {
 		snd_hda_set_pin_ctl(codec, pin, PIN_HP);
 		if (get_wcaps(codec, pin) & AC_WCAP_OUT_AMP)
@@ -4171,7 +6052,7 @@ static void ca0132_set_dmic(struct hda_codec *codec, int enable)
 	ca0132_set_vipsource(codec, 0);
 	if (enable) {
 		/* set DMic input as 2-ch */
-		tmp = FLOAT_TWO;
+		tmp = FLOAT_2;
 		dspio_set_uint_param(codec, 0x80, 0x00, tmp);
 
 		val = spec->dmic_ctl;
@@ -4183,7 +6064,7 @@ static void ca0132_set_dmic(struct hda_codec *codec, int enable)
 			chipio_set_control_flag(codec, CONTROL_FLAG_DMIC, 1);
 	} else {
 		/* set AMic input as mono */
-		tmp = FLOAT_ONE;
+		tmp = FLOAT_1;
 		dspio_set_uint_param(codec, 0x80, 0x00, tmp);
 
 		val = spec->dmic_ctl;
@@ -4213,7 +6094,7 @@ static void ca0132_init_dmic(struct hda_codec *codec)
 
 	/* MCLK uses MPIO1, set to enable.
 	 * Bit 2-0: MPIO select
-	 * Bit   3: set to disable
+	 * Bit	 3: set to disable
 	 * Bit 7-4: reserved
 	 */
 	val = 0x01;
@@ -4222,9 +6103,9 @@ static void ca0132_init_dmic(struct hda_codec *codec)
 
 	/* Data1 uses MPIO3. Data2 not use
 	 * Bit 2-0: Data1 MPIO select
-	 * Bit   3: set disable Data1
+	 * Bit	 3: set disable Data1
 	 * Bit 6-4: Data2 MPIO select
-	 * Bit   7: set disable Data2
+	 * Bit	 7: set disable Data2
 	 */
 	val = 0x83;
 	snd_hda_codec_write(codec, spec->input_pins[0], 0,
@@ -4232,10 +6113,10 @@ static void ca0132_init_dmic(struct hda_codec *codec)
 
 	/* Use Ch-0 and Ch-1. Rate is 48K, mode 1. Disable DMic first.
 	 * Bit 3-0: Channel mask
-	 * Bit   4: set for 48KHz, clear for 32KHz
-	 * Bit   5: mode
-	 * Bit   6: set to select Data2, clear for Data1
-	 * Bit   7: set to enable DMic, clear for AMic
+	 * Bit	 4: set for 48KHz, clear for 32KHz
+	 * Bit	 5: mode
+	 * Bit	 6: set to select Data2, clear for Data1
+	 * Bit	 7: set to enable DMic, clear for AMic
 	 */
 	val = 0x23;
 	/* keep a copy of dmic ctl val for enable/disable dmic purpuse */
@@ -4288,6 +6169,219 @@ static void ca0132_refresh_widget_caps(struct hda_codec *codec)
 }
 
 /*
+ * Recon3Di r3di_setup_defaults sub functions.
+ */
+
+static void r3di_dsp_scp_startup(struct hda_codec *codec)
+{
+	unsigned int tmp;
+
+	tmp = 0x00000000;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0A, tmp);
+
+	tmp = 0x00000001;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0B, tmp);
+
+	tmp = 0x00000004;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+
+	tmp = 0x00000005;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+
+	tmp = 0x00000000;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+
+}
+
+static void r3di_dsp_initial_mic_setup(struct hda_codec *codec)
+{
+	unsigned int tmp;
+
+	/* Mic 1 Setup */
+	chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
+	chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_96_000);
+	/* This ConnPointID is unique to Recon3Di. Haven't seen it elsewhere */
+	chipio_set_conn_rate(codec, 0x0F, SR_96_000);
+	tmp = FLOAT_1;
+	dspio_set_uint_param(codec, 0x80, 0x00, tmp);
+
+	/* Mic 2 Setup, even though it isn't connected on SBZ */
+	chipio_set_conn_rate(codec, MEM_CONNID_MICIN2, SR_96_000);
+	chipio_set_conn_rate(codec, MEM_CONNID_MICOUT2, SR_96_000);
+	chipio_set_conn_rate(codec, 0x0F, SR_96_000);
+	tmp = FLOAT_0;
+	dspio_set_uint_param(codec, 0x80, 0x01, tmp);
+}
+
+/*
+ * Initialize Sound Blaster Z analog microphones.
+ */
+static void sbz_init_analog_mics(struct hda_codec *codec)
+{
+	unsigned int tmp;
+
+	/* Mic 1 Setup */
+	chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
+	chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_96_000);
+	tmp = FLOAT_3;
+	dspio_set_uint_param(codec, 0x80, 0x00, tmp);
+
+	/* Mic 2 Setup, even though it isn't connected on SBZ */
+	chipio_set_conn_rate(codec, MEM_CONNID_MICIN2, SR_96_000);
+	chipio_set_conn_rate(codec, MEM_CONNID_MICOUT2, SR_96_000);
+	tmp = FLOAT_0;
+	dspio_set_uint_param(codec, 0x80, 0x01, tmp);
+
+}
+
+/*
+ * Sets the source of stream 0x14 to connpointID 0x48, and the destination
+ * connpointID to 0x91. If this isn't done, the destination is 0x71, and
+ * you get no sound. I'm guessing this has to do with the Sound Blaster Z
+ * having an updated DAC, which changes the destination to that DAC.
+ */
+static void sbz_connect_streams(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	mutex_lock(&spec->chipio_mutex);
+
+	codec_dbg(codec, "Connect Streams entered, mutex locked and loaded.\n");
+
+	chipio_set_stream_channels(codec, 0x0C, 6);
+	chipio_set_stream_control(codec, 0x0C, 1);
+
+	/* This value is 0x43 for 96khz, and 0x83 for 192khz. */
+	chipio_write_no_mutex(codec, 0x18a020, 0x00000043);
+
+	/* Setup stream 0x14 with it's source and destination points */
+	chipio_set_stream_source_dest(codec, 0x14, 0x48, 0x91);
+	chipio_set_conn_rate_no_mutex(codec, 0x48, SR_96_000);
+	chipio_set_conn_rate_no_mutex(codec, 0x91, SR_96_000);
+	chipio_set_stream_channels(codec, 0x14, 2);
+	chipio_set_stream_control(codec, 0x14, 1);
+
+	codec_dbg(codec, "Connect Streams exited, mutex released.\n");
+
+	mutex_unlock(&spec->chipio_mutex);
+
+}
+
+/*
+ * Write data through ChipIO to setup proper stream destinations.
+ * Not sure how it exactly works, but it seems to direct data
+ * to different destinations. Example is f8 to c0, e0 to c0.
+ * All I know is, if you don't set these, you get no sound.
+ */
+static void sbz_chipio_startup_data(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	mutex_lock(&spec->chipio_mutex);
+
+	codec_dbg(codec, "Startup Data entered, mutex locked and loaded.\n");
+
+	/* These control audio output */
+	chipio_write_no_mutex(codec, 0x190060, 0x0001f8c0);
+	chipio_write_no_mutex(codec, 0x190064, 0x0001f9c1);
+	chipio_write_no_mutex(codec, 0x190068, 0x0001fac6);
+	chipio_write_no_mutex(codec, 0x19006c, 0x0001fbc7);
+	/* Signal to update I think */
+	chipio_write_no_mutex(codec, 0x19042c, 0x00000001);
+
+	chipio_set_stream_channels(codec, 0x0C, 6);
+	chipio_set_stream_control(codec, 0x0C, 1);
+	/* No clue what these control */
+	chipio_write_no_mutex(codec, 0x190030, 0x0001e0c0);
+	chipio_write_no_mutex(codec, 0x190034, 0x0001e1c1);
+	chipio_write_no_mutex(codec, 0x190038, 0x0001e4c2);
+	chipio_write_no_mutex(codec, 0x19003c, 0x0001e5c3);
+	chipio_write_no_mutex(codec, 0x190040, 0x0001e2c4);
+	chipio_write_no_mutex(codec, 0x190044, 0x0001e3c5);
+	chipio_write_no_mutex(codec, 0x190048, 0x0001e8c6);
+	chipio_write_no_mutex(codec, 0x19004c, 0x0001e9c7);
+	chipio_write_no_mutex(codec, 0x190050, 0x0001ecc8);
+	chipio_write_no_mutex(codec, 0x190054, 0x0001edc9);
+	chipio_write_no_mutex(codec, 0x190058, 0x0001eaca);
+	chipio_write_no_mutex(codec, 0x19005c, 0x0001ebcb);
+
+	chipio_write_no_mutex(codec, 0x19042c, 0x00000001);
+
+	codec_dbg(codec, "Startup Data exited, mutex released.\n");
+
+	mutex_unlock(&spec->chipio_mutex);
+}
+/*
+ * Sound Blaster Z uses these after DSP is loaded. Weird SCP commands
+ * without a 0x20 source like normal.
+ */
+static void sbz_dsp_scp_startup(struct hda_codec *codec)
+{
+	unsigned int tmp;
+
+	tmp = 0x00000003;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+
+	tmp = 0x00000000;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0A, tmp);
+
+	tmp = 0x00000001;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0B, tmp);
+
+	tmp = 0x00000004;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+
+	tmp = 0x00000005;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+
+	tmp = 0x00000000;
+	dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+
+}
+
+static void sbz_dsp_initial_mic_setup(struct hda_codec *codec)
+{
+	unsigned int tmp;
+
+	chipio_set_stream_control(codec, 0x03, 0);
+	chipio_set_stream_control(codec, 0x04, 0);
+
+	chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
+	chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_96_000);
+
+	tmp = FLOAT_3;
+	dspio_set_uint_param(codec, 0x80, 0x00, tmp);
+
+	chipio_set_stream_control(codec, 0x03, 1);
+	chipio_set_stream_control(codec, 0x04, 1);
+
+	chipio_write(codec, 0x18b098, 0x0000000c);
+	chipio_write(codec, 0x18b09C, 0x0000000c);
+}
+
+/*
+ * This is for the extra volume verbs 0x797 (left) and 0x798 (right). These add
+ * extra precision for decibel values. If you had the dB value in floating point
+ * you would take the value after the decimal point, multiply by 64, and divide
+ * by 2. So for 8.59, it's (59 * 64) / 100. Useful if someone wanted to
+ * implement fixed point or floating point dB volumes. For now, I'll set them
+ * to 0 just incase a value has lingered from a boot into Windows.
+ */
+
+static void ca0132_alt_vol_setup(struct hda_codec *codec)
+{
+
+	snd_hda_codec_write(codec, 0x02, 0, 0x797, 0x00);
+	snd_hda_codec_write(codec, 0x02, 0, 0x798, 0x00);
+	snd_hda_codec_write(codec, 0x03, 0, 0x797, 0x00);
+	snd_hda_codec_write(codec, 0x03, 0, 0x798, 0x00);
+	snd_hda_codec_write(codec, 0x04, 0, 0x797, 0x00);
+	snd_hda_codec_write(codec, 0x04, 0, 0x798, 0x00);
+	snd_hda_codec_write(codec, 0x07, 0, 0x797, 0x00);
+	snd_hda_codec_write(codec, 0x07, 0, 0x798, 0x00);
+}
+
+/*
  * Setup default parameters for DSP
  */
 static void ca0132_setup_defaults(struct hda_codec *codec)
@@ -4311,24 +6405,138 @@ static void ca0132_setup_defaults(struct hda_codec *codec)
 	}
 
 	/*remove DSP headroom*/
-	tmp = FLOAT_ZERO;
+	tmp = FLOAT_0;
 	dspio_set_uint_param(codec, 0x96, 0x3C, tmp);
 
 	/*set speaker EQ bypass attenuation*/
 	dspio_set_uint_param(codec, 0x8f, 0x01, tmp);
 
 	/* set AMic1 and AMic2 as mono mic */
-	tmp = FLOAT_ONE;
+	tmp = FLOAT_1;
 	dspio_set_uint_param(codec, 0x80, 0x00, tmp);
 	dspio_set_uint_param(codec, 0x80, 0x01, tmp);
 
 	/* set AMic1 as CrystalVoice input */
-	tmp = FLOAT_ONE;
+	tmp = FLOAT_1;
 	dspio_set_uint_param(codec, 0x80, 0x05, tmp);
 
 	/* set WUH source */
-	tmp = FLOAT_TWO;
+	tmp = FLOAT_2;
+	dspio_set_uint_param(codec, 0x31, 0x00, tmp);
+
+}
+
+/*
+ * Setup default parameters for Recon3Di DSP.
+ */
+
+static void r3di_setup_defaults(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int tmp;
+	int num_fx;
+	int idx, i;
+
+	if (spec->dsp_state != DSP_DOWNLOADED)
+		return;
+
+	r3di_dsp_scp_startup(codec);
+
+	r3di_dsp_initial_mic_setup(codec);
+
+	/*remove DSP headroom*/
+	tmp = FLOAT_0;
+	dspio_set_uint_param(codec, 0x96, 0x3C, tmp);
+
+	/* set WUH source */
+	tmp = FLOAT_2;
+	dspio_set_uint_param(codec, 0x31, 0x00, tmp);
+
+	/* Set speaker source? */
+	dspio_set_uint_param(codec, 0x32, 0x00, tmp);
+
+	r3di_gpio_dsp_status_set(codec, R3DI_DSP_DOWNLOADED);
+
+	/* Setup effect defaults */
+	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT + 1;
+	for (idx = 0; idx < num_fx; idx++) {
+		for (i = 0; i <= ca0132_effects[idx].params; i++) {
+			dspio_set_uint_param(codec, ca0132_effects[idx].mid,
+					     ca0132_effects[idx].reqs[i],
+					     ca0132_effects[idx].def_vals[i]);
+		}
+	}
+
+}
+
+/*
+ * Setup default parameters for the Sound Blaster Z DSP. A lot more going on
+ * than the Chromebook setup.
+ */
+static void sbz_setup_defaults(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int tmp, stream_format;
+	int num_fx;
+	int idx, i;
+
+	if (spec->dsp_state != DSP_DOWNLOADED)
+		return;
+
+	sbz_dsp_scp_startup(codec);
+	sbz_init_analog_mics(codec);
+	sbz_connect_streams(codec);
+	sbz_chipio_startup_data(codec);
+
+	chipio_set_stream_control(codec, 0x03, 1);
+	chipio_set_stream_control(codec, 0x04, 1);
+
+	/*
+	 * Sets internal input loopback to off, used to have a switch to
+	 * enable input loopback, but turned out to be way too buggy.
+	 */
+	tmp = FLOAT_1;
+	dspio_set_uint_param(codec, 0x37, 0x08, tmp);
+	dspio_set_uint_param(codec, 0x37, 0x10, tmp);
+
+	/*remove DSP headroom*/
+	tmp = FLOAT_0;
+	dspio_set_uint_param(codec, 0x96, 0x3C, tmp);
+
+	/* set WUH source */
+	tmp = FLOAT_2;
 	dspio_set_uint_param(codec, 0x31, 0x00, tmp);
+
+	/* Set speaker source? */
+	dspio_set_uint_param(codec, 0x32, 0x00, tmp);
+
+	sbz_dsp_initial_mic_setup(codec);
+
+
+	/* out, in effects + voicefx */
+	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT + 1;
+	for (idx = 0; idx < num_fx; idx++) {
+		for (i = 0; i <= ca0132_effects[idx].params; i++) {
+			dspio_set_uint_param(codec, ca0132_effects[idx].mid,
+					     ca0132_effects[idx].reqs[i],
+					     ca0132_effects[idx].def_vals[i]);
+		}
+	}
+
+	/*
+	 * Have to make a stream to bind the sound output to, otherwise
+	 * you'll get dead audio. Before I did this, it would bind to an
+	 * audio input, and would never work
+	 */
+	stream_format = snd_hdac_calc_stream_format(48000, 2,
+			SNDRV_PCM_FORMAT_S32_LE, 32, 0);
+
+	snd_hda_codec_setup_stream(codec, spec->dacs[0], spec->dsp_stream_id,
+					0, stream_format);
+
+	snd_hda_codec_cleanup_stream(codec, spec->dacs[0]);
+
+	return;
 }
 
 /*
@@ -4336,12 +6544,33 @@ static void ca0132_setup_defaults(struct hda_codec *codec)
  */
 static void ca0132_init_flags(struct hda_codec *codec)
 {
-	chipio_set_control_flag(codec, CONTROL_FLAG_IDLE_ENABLE, 0);
-	chipio_set_control_flag(codec, CONTROL_FLAG_PORT_A_COMMON_MODE, 0);
-	chipio_set_control_flag(codec, CONTROL_FLAG_PORT_D_COMMON_MODE, 0);
-	chipio_set_control_flag(codec, CONTROL_FLAG_PORT_A_10KOHM_LOAD, 0);
-	chipio_set_control_flag(codec, CONTROL_FLAG_PORT_D_10KOHM_LOAD, 0);
-	chipio_set_control_flag(codec, CONTROL_FLAG_ADC_C_HIGH_PASS, 1);
+	struct ca0132_spec *spec = codec->spec;
+
+	if (spec->quirk == QUIRK_SBZ || spec->quirk == QUIRK_R3DI) {
+		chipio_set_control_flag(codec, CONTROL_FLAG_DSP_96KHZ, 1);
+		chipio_set_control_flag(codec, CONTROL_FLAG_DAC_96KHZ, 1);
+		chipio_set_control_flag(codec, CONTROL_FLAG_ADC_B_96KHZ, 1);
+		chipio_set_control_flag(codec, CONTROL_FLAG_ADC_C_96KHZ, 1);
+		chipio_set_control_flag(codec, CONTROL_FLAG_SRC_RATE_96KHZ, 1);
+		chipio_set_control_flag(codec, CONTROL_FLAG_IDLE_ENABLE, 0);
+		chipio_set_control_flag(codec, CONTROL_FLAG_SPDIF2OUT, 0);
+		chipio_set_control_flag(codec,
+				CONTROL_FLAG_PORT_D_10KOHM_LOAD, 0);
+		chipio_set_control_flag(codec,
+				CONTROL_FLAG_PORT_A_10KOHM_LOAD, 1);
+	} else {
+		chipio_set_control_flag(codec, CONTROL_FLAG_IDLE_ENABLE, 0);
+		chipio_set_control_flag(codec,
+				CONTROL_FLAG_PORT_A_COMMON_MODE, 0);
+		chipio_set_control_flag(codec,
+				CONTROL_FLAG_PORT_D_COMMON_MODE, 0);
+		chipio_set_control_flag(codec,
+				CONTROL_FLAG_PORT_A_10KOHM_LOAD, 0);
+		chipio_set_control_flag(codec,
+				CONTROL_FLAG_PORT_D_10KOHM_LOAD, 0);
+		chipio_set_control_flag(codec,
+				CONTROL_FLAG_ADC_C_HIGH_PASS, 1);
+	}
 }
 
 /*
@@ -4349,6 +6578,17 @@ static void ca0132_init_flags(struct hda_codec *codec)
  */
 static void ca0132_init_params(struct hda_codec *codec)
 {
+	struct ca0132_spec *spec = codec->spec;
+
+	if (spec->quirk == QUIRK_SBZ || spec->quirk == QUIRK_R3DI) {
+		chipio_set_conn_rate(codec, MEM_CONNID_WUH, SR_48_000);
+		chipio_set_conn_rate(codec, 0x0B, SR_48_000);
+		chipio_set_control_param(codec, CONTROL_PARAM_SPDIF1_SOURCE, 0);
+		/* unsure of what param 0 is */
+		chipio_set_control_param(codec, 0, 0);
+		chipio_set_control_param(codec, CONTROL_PARAM_VIP_SOURCE, 0);
+	}
+
 	chipio_set_control_param(codec, CONTROL_PARAM_PORTA_160OHM_GAIN, 6);
 	chipio_set_control_param(codec, CONTROL_PARAM_PORTD_160OHM_GAIN, 6);
 }
@@ -4367,14 +6607,54 @@ static void ca0132_set_dsp_msr(struct hda_codec *codec, bool is96k)
 	chipio_set_conn_rate(codec, MEM_CONNID_WUH, SR_48_000);
 }
 
+/*
+ * This function selects the firmware and begins the download. I have added
+ * the ability to load alternate firmware for different variants. Both the
+ * Recon3Di and the Sound Blaster Z have been tested and confirmed working
+ * with the default firmware as well, but I want to use the firmware from the
+ * Windows driver for peace of mind. This may not be the appropriate thing,
+ * and I would understand it's removal.
+ */
 static bool ca0132_download_dsp_images(struct hda_codec *codec)
 {
 	bool dsp_loaded = false;
+	struct ca0132_spec *spec = codec->spec;
 	const struct dsp_image_seg *dsp_os_image;
 	const struct firmware *fw_entry;
+	switch (spec->quirk) {
+	case QUIRK_SBZ:
+		if (request_firmware(&fw_entry, SBZ_EFX_FILE,
+					codec->card->dev) != 0) {
+			codec_dbg(codec, "SBZ alt firmware not detected. ");
+			spec->alt_firmware_present = false;
+		} else {
+			codec_dbg(codec, "Sound Blaster Z firmware selected.");
+			spec->alt_firmware_present = true;
+		}
+		break;
+	case QUIRK_R3DI:
+		if (request_firmware(&fw_entry, R3DI_EFX_FILE,
+					codec->card->dev) != 0) {
+			codec_dbg(codec, "Recon3Di alt firmware not detected.");
+			spec->alt_firmware_present = false;
+		} else {
+			codec_dbg(codec, "Recon3Di firmware selected.");
+			spec->alt_firmware_present = true;
+		}
+		break;
+	default:
+		spec->alt_firmware_present = false;
+		break;
+	}
+	/* Use default ctefx.bin if no alt firmware is detected */
+	if (spec->alt_firmware_present == false) {
+		codec_dbg(codec, "Default firmware selected.");
+		if (request_firmware(&fw_entry, EFX_FILE,
+					codec->card->dev) != 0)
+			return false;
+	}
 
-	if (request_firmware(&fw_entry, EFX_FILE, codec->card->dev) != 0)
-		return false;
+	codec_dbg(codec, "Inside ca0132_download_dsp_images");
 
 	dsp_os_image = (struct dsp_image_seg *)(fw_entry->data);
 	if (dspload_image(codec, dsp_os_image, 0, 0, true, 0)) {
@@ -4402,13 +6682,17 @@ static void ca0132_download_dsp(struct hda_codec *codec)
 		return; /* don't retry failures */
 
 	chipio_enable_clocks(codec);
-	spec->dsp_state = DSP_DOWNLOADING;
-	if (!ca0132_download_dsp_images(codec))
-		spec->dsp_state = DSP_DOWNLOAD_FAILED;
-	else
-		spec->dsp_state = DSP_DOWNLOADED;
+	if (spec->dsp_state != DSP_DOWNLOADED) {
+		spec->dsp_state = DSP_DOWNLOADING;
 
-	if (spec->dsp_state == DSP_DOWNLOADED)
+		if (!ca0132_download_dsp_images(codec))
+			spec->dsp_state = DSP_DOWNLOAD_FAILED;
+		else
+			spec->dsp_state = DSP_DOWNLOADED;
+	}
+
+	/* Don't do this on SBZ, it's already done earlier. */
+	if (spec->dsp_state == DSP_DOWNLOADED && spec->quirk == QUIRK_NONE)
 		ca0132_set_dsp_msr(codec, true);
 }
 
@@ -4431,7 +6715,8 @@ static void hp_callback(struct hda_codec *codec, struct hda_jack_callback *cb)
 	struct ca0132_spec *spec = codec->spec;
 	struct hda_jack_tbl *tbl;
 
-	/* Delay enabling the HP amp, to let the mic-detection
+	/*
+	 * Delay enabling the HP amp, to let the mic-detection
 	 * state machine run.
 	 */
 	cancel_delayed_work_sync(&spec->unsol_hp_work);
@@ -4454,6 +6739,59 @@ static void ca0132_init_unsol(struct hda_codec *codec)
 					    amic_callback);
 	snd_hda_jack_detect_enable_callback(codec, UNSOL_TAG_DSP,
 					    ca0132_process_dsp_response);
+	/* Front headphone jack detection */
+	if (spec->quirk == QUIRK_SBZ || spec->quirk == QUIRK_R3DI)
+		snd_hda_jack_detect_enable_callback(codec,
+			spec->unsol_tag_front_hp, hp_callback);
+}
+
+/*
+ * Sound Blaster Z exit specific commands.
+ */
+static void sbz_region2_exit(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int i;
+
+	for (i = 0; i < 4; i++)
+		writeb(0x0, spec->mem_base + 0x100);
+
+	for (i = 0; i < 8; i++)
+		writeb(0xb3, spec->mem_base + 0x304);
+
+	writew(0x0000, spec->mem_base + 0x320);
+	writew(0x0001, spec->mem_base + 0x320);
+	writew(0x0104, spec->mem_base + 0x320);
+	writew(0x0005, spec->mem_base + 0x320);
+	writew(0x0007, spec->mem_base + 0x320);
+}
+
+static void sbz_set_pin_ctl_default(struct hda_codec *codec)
+{
+	hda_nid_t pins[5] = {0x0B, 0x0C, 0x0E, 0x12, 0x13};
+	unsigned int i;
+
+	snd_hda_codec_write(codec, 0x11, 0,
+			AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40);
+
+	for (i = 0; i < 5; i++) {
+		snd_hda_codec_write(codec, pins[i], 0,
+				AC_VERB_SET_PIN_WIDGET_CONTROL, 0x00);
+	}
+
+}
+
+static void sbz_clear_unsolicited(struct hda_codec *codec)
+{
+	hda_nid_t pins[7] = {0x0B, 0x0E, 0x0F, 0x10, 0x11, 0x12, 0x13};
+	unsigned int i;
+
+	for (i = 0; i < 7; i++) {
+		snd_hda_codec_write(codec, pins[i], 0,
+				AC_VERB_SET_UNSOLICITED_ENABLE, 0x00);
+	}
+
+	return;
 }
 
 /*
@@ -4476,8 +6814,9 @@ static struct hda_verb ca0132_base_exit_verbs[] = {
 	{}
 };
 
-/* Other verbs tables.  Sends after DSP download. */
-static struct hda_verb ca0132_init_verbs0[] = {
+/* Other verbs tables.	Sends after DSP download. */
+
+static struct hda_verb ca0132_init_verbs[] = {
 	/* chip init verbs */
 	{0x15, 0x70D, 0xF0},
 	{0x15, 0x70E, 0xFE},
@@ -4506,8 +6845,27 @@ static struct hda_verb ca0132_init_verbs0[] = {
 	{0x15, 0x546, 0xC9},
 	{0x15, 0x53B, 0xCE},
 	{0x15, 0x5E8, 0xC9},
-	{0x15, 0x717, 0x0D},
-	{0x15, 0x718, 0x20},
+	{}
+};
+
+/* Extra init verbs for SBZ */
+static struct hda_verb sbz_init_verbs[] = {
+	{0x15, 0x70D, 0x20},
+	{0x15, 0x70E, 0x19},
+	{0x15, 0x707, 0x00},
+	{0x15, 0x539, 0xCE},
+	{0x15, 0x546, 0xC9},
+	{0x15, 0x70D, 0xB7},
+	{0x15, 0x70E, 0x09},
+	{0x15, 0x707, 0x10},
+	{0x15, 0x70D, 0xAF},
+	{0x15, 0x70E, 0x09},
+	{0x15, 0x707, 0x01},
+	{0x15, 0x707, 0x05},
+	{0x15, 0x70D, 0x73},
+	{0x15, 0x70E, 0x09},
+	{0x15, 0x707, 0x14},
+	{0x15, 0x6FF, 0xC4},
 	{}
 };
 
@@ -4521,7 +6879,12 @@ static void ca0132_init_chip(struct hda_codec *codec)
 	mutex_init(&spec->chipio_mutex);
 
 	spec->cur_out_type = SPEAKER_OUT;
-	spec->cur_mic_type = DIGITAL_MIC;
+
+	if (spec->quirk == QUIRK_NONE)
+		spec->cur_mic_type = DIGITAL_MIC;
+	else
+		spec->cur_mic_type = REAR_MIC;
+
 	spec->cur_mic_boost = 0;
 
 	for (i = 0; i < VNODES_COUNT; i++) {
@@ -4539,6 +6902,15 @@ static void ca0132_init_chip(struct hda_codec *codec)
 		on = (unsigned int)ca0132_effects[i].reqs[0];
 		spec->effects_switch[i] = on ? 1 : 0;
 	}
+	/*
+	 * Sets defaults for the effect slider controls, only for alternative
+	 * ca0132 codecs. Also sets x-bass crossover frequency to 80hz.
+	 */
+	if (spec->quirk != QUIRK_NONE) {
+		spec->xbass_xover_freq = 8;
+		for (i = 0; i < EFFECT_LEVEL_SLIDERS; i++)
+			spec->fx_ctl_val[i] = effect_slider_defaults[i];
+	}
 
 	spec->voicefx_val = 0;
 	spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID] = 1;
@@ -4549,6 +6921,56 @@ static void ca0132_init_chip(struct hda_codec *codec)
 #endif
 }
 
+/* Set all the GPIO to off before shutdown to prevent loud pop noise. */
+
+static void r3di_gpio_shutdown(struct hda_codec *codec)
+{
+	snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA, 0x00);
+}
+
+static void sbz_exit_chip(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	chipio_set_stream_control(codec, 0x03, 0);
+	chipio_set_stream_control(codec, 0x04, 0);
+
+	/* Mess with GPIO */
+	sbz_gpio_shutdown_commands(codec, 0x07, 0x07, -1);
+	sbz_gpio_shutdown_commands(codec, 0x07, 0x07, 0x05);
+	sbz_gpio_shutdown_commands(codec, 0x07, 0x07, 0x01);
+
+	chipio_set_stream_control(codec, 0x14, 0);
+	chipio_set_stream_control(codec, 0x0C, 0);
+
+	chipio_set_conn_rate(codec, 0x41, SR_192_000);
+	chipio_set_conn_rate(codec, 0x91, SR_192_000);
+
+	chipio_write(codec, 0x18a020, 0x00000083);
+
+	sbz_gpio_shutdown_commands(codec, 0x07, 0x07, 0x03);
+	sbz_gpio_shutdown_commands(codec, 0x07, 0x07, 0x07);
+	sbz_gpio_shutdown_commands(codec, 0x07, 0x07, 0x06);
+
+	chipio_set_stream_control(codec, 0x0C, 0);
+
+	chipio_set_control_param(codec, 0x0D, 0x24);
+
+	sbz_clear_unsolicited(codec);
+	sbz_set_pin_ctl_default(codec);
+
+	snd_hda_codec_write(codec, spec->out_pins[0], 0,
+		AC_VERB_SET_EAPD_BTLENABLE, 0x00);
+
+	if (dspload_is_loaded(codec))
+		dsp_reset(codec);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+		VENDOR_CHIPIO_CT_EXTENSIONS_ENABLE, 0x00);
+
+	sbz_region2_exit(codec);
+}
+
 static void ca0132_exit_chip(struct hda_codec *codec)
 {
 	/* put any chip cleanup stuffs here. */
@@ -4557,28 +6979,156 @@ static void ca0132_exit_chip(struct hda_codec *codec)
 		dsp_reset(codec);
 }
 
+/* Extra card variant specific commands that don't really fit anywhere else. */
+
+static void sbz_pre_dsp_setup(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	writel(0x00820680, spec->mem_base + 0x01C);
+	writel(0x00820680, spec->mem_base + 0x01C);
+
+	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfc);
+	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfd);
+	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfe);
+	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xff);
+
+	chipio_write(codec, 0x18b0a4, 0x000000c2);
+}
+
+static void r3di_pre_dsp_setup(struct hda_codec *codec)
+{
+	chipio_write(codec, 0x18b0a4, 0x000000c2);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x1E);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x1C);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x5B);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x20);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x19);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x00);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x40);
+}
+
+/*
+ * These are sent before the DSP is downloaded. Not sure
+ * what they do, or if they're necessary. Could possibly
+ * be removed. Figure they're better to leave in.
+ */
+static void sbz_region2_startup(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	writel(0x00000000, spec->mem_base + 0x400);
+	writel(0x00000000, spec->mem_base + 0x408);
+	writel(0x00000000, spec->mem_base + 0x40C);
+	writel(0x00880680, spec->mem_base + 0x01C);
+	writel(0x00000083, spec->mem_base + 0xC0C);
+	writel(0x00000030, spec->mem_base + 0xC00);
+	writel(0x00000000, spec->mem_base + 0xC04);
+	writel(0x00000003, spec->mem_base + 0xC0C);
+	writel(0x00000003, spec->mem_base + 0xC0C);
+	writel(0x00000003, spec->mem_base + 0xC0C);
+	writel(0x00000003, spec->mem_base + 0xC0C);
+	writel(0x000000C1, spec->mem_base + 0xC08);
+	writel(0x000000F1, spec->mem_base + 0xC08);
+	writel(0x00000001, spec->mem_base + 0xC08);
+	writel(0x000000C7, spec->mem_base + 0xC08);
+	writel(0x000000C1, spec->mem_base + 0xC08);
+	writel(0x00000080, spec->mem_base + 0xC04);
+}
+
+/*
+ * Extra init functions for alternative ca0132 codecs. Done
+ * here so they don't clutter up the main ca0132_init function
+ * anymore than they have to.
+ */
+static void ca0132_alt_init(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	ca0132_alt_vol_setup(codec);
+
+	switch (spec->quirk) {
+	case QUIRK_SBZ:
+		codec_dbg(codec, "SBZ alt_init");
+		ca0132_gpio_init(codec);
+		sbz_pre_dsp_setup(codec);
+		snd_hda_sequence_write(codec, spec->chip_init_verbs);
+		snd_hda_sequence_write(codec, spec->sbz_init_verbs);
+		break;
+	case QUIRK_R3DI:
+		codec_dbg(codec, "R3DI alt_init");
+		ca0132_gpio_init(codec);
+		ca0132_gpio_setup(codec);
+		r3di_gpio_dsp_status_set(codec, R3DI_DSP_DOWNLOADING);
+		r3di_pre_dsp_setup(codec);
+		snd_hda_sequence_write(codec, spec->chip_init_verbs);
+		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0, 0x6FF, 0xC4);
+		break;
+	}
+}
+
+static void sbz_check_startup_success(struct hda_codec *codec);
+
 static int ca0132_init(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	int i;
 
+	if (spec->dsp_state == DSP_DOWNLOADED)
+		return 0;
+
 	if (spec->dsp_state != DSP_DOWNLOAD_FAILED)
 		spec->dsp_state = DSP_DOWNLOAD_INIT;
 	spec->curr_chip_addx = INVALID_CHIP_ADDRESS;
 
+	if (spec->quirk == QUIRK_SBZ)
+		sbz_region2_startup(codec);
+
 	snd_hda_power_up_pm(codec);
 
 	ca0132_init_unsol(codec);
-
 	ca0132_init_params(codec);
 	ca0132_init_flags(codec);
 	snd_hda_sequence_write(codec, spec->base_init_verbs);
+	if (spec->quirk != QUIRK_NONE)
+		ca0132_alt_init(codec);
+
 	ca0132_download_dsp(codec);
 	ca0132_refresh_widget_caps(codec);
-	ca0132_setup_defaults(codec);
-	ca0132_init_analog_mic2(codec);
-	ca0132_init_dmic(codec);
+
+	if (spec->quirk == QUIRK_SBZ)
+		writew(0x0107, spec->mem_base + 0x320);
+
+	switch (spec->quirk) {
+	case QUIRK_SBZ:
+		sbz_setup_defaults(codec);
+		/*
+		 * The bug this fixes is hard to reproduce, and I have
+		 * only tested it with alt firmware. It may work for regular
+		 * firmware, but I am not sure. It does not break with regular
+		 * firmware though, so I'll leave it in.
+		 */
+		sbz_check_startup_success(codec);
+		break;
+	case QUIRK_R3DI:
+		r3di_setup_defaults(codec);
+		break;
+	default:
+		ca0132_setup_defaults(codec);
+		ca0132_init_analog_mic2(codec);
+		ca0132_init_dmic(codec);
+		break;
+	}
 
 	for (i = 0; i < spec->num_outputs; i++)
 		init_output(codec, spec->out_pins[i], spec->dacs[0]);
@@ -4590,11 +7140,32 @@ static int ca0132_init(struct hda_codec *codec)
 
 	init_input(codec, cfg->dig_in_pin, spec->dig_in);
 
-	snd_hda_sequence_write(codec, spec->chip_init_verbs);
-	snd_hda_sequence_write(codec, spec->spec_init_verbs);
+	if (spec->quirk == QUIRK_NONE) {
+		snd_hda_sequence_write(codec, spec->chip_init_verbs);
+		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_PARAM_EX_ID_SET, 0x0D);
+		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_PARAM_EX_VALUE_SET, 0x20);
+	}
 
-	ca0132_select_out(codec);
-	ca0132_select_mic(codec);
+	if (spec->quirk == QUIRK_SBZ)
+		ca0132_gpio_setup(codec);
+
+	snd_hda_sequence_write(codec, spec->spec_init_verbs);
+	switch (spec->quirk) {
+	case QUIRK_SBZ:
+		ca0132_alt_select_out(codec);
+		ca0132_alt_select_in(codec);
+		break;
+	case QUIRK_R3DI:
+		ca0132_alt_select_out(codec);
+		ca0132_alt_select_in(codec);
+		break;
+	case QUIRK_NONE:
+		ca0132_select_out(codec);
+		ca0132_select_mic(codec);
+		break;
+	}
 
 	snd_hda_jack_report_sync(codec);
 
@@ -4603,25 +7174,170 @@ static int ca0132_init(struct hda_codec *codec)
 	return 0;
 }
 
+/*
+ * The Sound Blaster Z was randomly not working on startup despite everything
+ * else seeming to go fine. I do not know what causes this, but I found that
+ * a reboot was enough to fix it, the DSP doesn't need a full shutdown to clear.
+ * This function will attempt to reload the DSP three times after detecting a
+ * failure, and give up after that. This has worked for me once, and took two
+ * reloads to fix the problem. Will have to see how it works for others.
+ */
+
+static void sbz_check_startup_success(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int dsp_data_check[4];
+	unsigned int cur_address = 0x390;
+	unsigned int i;
+	unsigned int failure = 0;
+	unsigned int reload = 3;
+
+	if (spec->sbz_failure_entered)
+		return;
+
+	spec->sbz_failure_entered = true;
+
+	for (i = 0; i < 4; i++) {
+		chipio_read(codec, cur_address, &dsp_data_check[i]);
+		cur_address += 0x4;
+	}
+	for (i = 0; i < 4; i++) {
+		if (dsp_data_check[i] == 0xa1a2a3a4)
+			failure = 1;
+	}
+
+	codec_dbg(codec, "SBZ failure = %d ", failure);
+
+	/*
+	 * While the failure condition is true, and we haven't reached our
+	 * three reload limit, continue trying to reload the driver and
+	 * fix the issue.
+	 */
+	while (failure && (reload != 0)) {
+		codec_dbg(codec, "Reloading... Tries left: %d", reload);
+		sbz_exit_chip(codec);
+		spec->dsp_state = DSP_DOWNLOAD_INIT;
+		codec->patch_ops.init(codec);
+		failure = 0;
+		for (i = 0; i < 4; i++) {
+			chipio_read(codec, cur_address, &dsp_data_check[i]);
+			cur_address += 0x4;
+		}
+		for (i = 0; i < 4; i++) {
+			if (dsp_data_check[i] == 0xa1a2a3a4)
+				failure = 1;
+		}
+		reload--;
+	}
+
+	if (!failure)
+		return;
+
+	codec_info(codec, "Sound Blaster Z DSP Failure. Try a full shutdown.");
+}
+
 static void ca0132_free(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
 
 	cancel_delayed_work_sync(&spec->unsol_hp_work);
 	snd_hda_power_up(codec);
-	snd_hda_sequence_write(codec, spec->base_exit_verbs);
-	ca0132_exit_chip(codec);
+	switch (spec->quirk) {
+	case QUIRK_SBZ:
+		sbz_exit_chip(codec);
+		/* unmap BAR region 2. */
+		iounmap(spec->mem_base);
+		break;
+	case QUIRK_R3DI:
+		r3di_gpio_shutdown(codec);
+		break;
+	default:
+		snd_hda_sequence_write(codec, spec->base_exit_verbs);
+		ca0132_exit_chip(codec);
+		break;
+	}
 	snd_hda_power_down(codec);
 	kfree(spec->spec_init_verbs);
 	kfree(codec->spec);
 }
 
+static int ca0132_resume(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	hda_nid_t nid;
+	int i;
+	bool dsp_loaded;
+
+	codec_dbg(codec, "ca0132 resume entered. dsp_download_wakeup: %d",
+					spec->dsp_download_wakeup);
+	/*
+	 * Check and make sure the DSP isn't already loaded. For some
+	 * reason, the SBZ triggers suspend after the build_controls
+	 * patch op has been triggered. This should prevent it from
+	 * downloading the dsp twice, there may be a more sensible
+	 * solution that finds what triggers suspend, but for now,
+	 * this works.
+	 */
+	dsp_loaded = dspload_is_loaded(codec);
+
+	if (dsp_loaded) {
+		spec->dsp_download_wakeup = 0;
+		return 0;
+	}
+
+	if (spec->dsp_download_wakeup) {
+		spec->dsp_state = DSP_DOWNLOAD_INIT;
+		spec->dsp_download_wakeup = 0;
+	}
+
+	switch (spec->quirk) {
+	case QUIRK_ALIENWARE:
+		snd_hda_apply_pincfgs(codec, alienware_pincfgs);
+		break;
+	case QUIRK_SBZ:
+		snd_hda_apply_pincfgs(codec, sbz_pincfgs);
+		break;
+	case QUIRK_R3DI:
+		snd_hda_apply_pincfgs(codec, r3di_pincfgs);
+	}
+
+	codec->patch_ops.init(codec);
+
+	/* Update out effects */
+	i = OUT_EFFECT_START_NID - EFFECT_START_NID;
+	nid = OUT_EFFECT_START_NID;
+	for (; nid < OUT_EFFECT_END_NID; nid++, i++)
+		ca0132_effects_set(codec, nid, spec->effects_switch[i]);
+
+	return 0;
+
+}
+
+static int ca0132_suspend(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	codec_dbg(codec, "ca0132 suspend entered.");
+
+	spec->dsp_download_wakeup = 1;
+
+	return 0;
+}
+
+static void ca0132_reboot_notify(struct hda_codec *codec)
+{
+	codec->patch_ops.free(codec);
+}
+
 static const struct hda_codec_ops ca0132_patch_ops = {
 	.build_controls = ca0132_build_controls,
 	.build_pcms = ca0132_build_pcms,
 	.init = ca0132_init,
 	.free = ca0132_free,
 	.unsol_event = snd_hda_jack_unsol_event,
+	.suspend = ca0132_suspend,
+	.resume = ca0132_resume,
+	.reboot_notify = ca0132_reboot_notify,
 };
 
 static void ca0132_config(struct hda_codec *codec)
@@ -4635,9 +7351,14 @@ static void ca0132_config(struct hda_codec *codec)
 
 	spec->multiout.dac_nids = spec->dacs;
 	spec->multiout.num_dacs = 3;
-	spec->multiout.max_channels = 2;
 
-	if (spec->quirk == QUIRK_ALIENWARE) {
+	if (spec->quirk == QUIRK_NONE)
+		spec->multiout.max_channels = 2;
+	else
+		spec->multiout.max_channels = 6;
+
+	switch (spec->quirk) {
+	case QUIRK_ALIENWARE:
 		codec_dbg(codec, "ca0132_config: QUIRK_ALIENWARE applied.\n");
 		snd_hda_apply_pincfgs(codec, alienware_pincfgs);
 
@@ -4657,7 +7378,71 @@ static void ca0132_config(struct hda_codec *codec)
 		spec->input_pins[2] = 0x13;
 		spec->shared_mic_nid = 0x7;
 		spec->unsol_tag_amic1 = 0x11;
-	} else {
+		break;
+	case QUIRK_SBZ:
+		codec_dbg(codec, "ca0132_config: QUIRK_SBZ applied.\n");
+		snd_hda_apply_pincfgs(codec, sbz_pincfgs);
+
+		spec->num_outputs = 2;
+		spec->out_pins[0] = 0x0B; /* Line out */
+		spec->out_pins[1] = 0x0F; /* Rear headphone out */
+		spec->out_pins[2] = 0x10; /* Front Headphone / Center/LFE*/
+		spec->out_pins[3] = 0x11; /* Rear surround */
+		spec->shared_out_nid = 0x2;
+		spec->unsol_tag_hp = spec->out_pins[1];
+		spec->unsol_tag_front_hp = spec->out_pins[2];
+
+		spec->adcs[0] = 0x7; /* Rear Mic / Line-in */
+		spec->adcs[1] = 0x8; /* Front Mic, but only if no DSP */
+		spec->adcs[2] = 0xa; /* what u hear */
+
+		spec->num_inputs = 2;
+		spec->input_pins[0] = 0x12; /* Rear Mic / Line-in */
+		spec->input_pins[1] = 0x13; /* What U Hear */
+		spec->shared_mic_nid = 0x7;
+		spec->unsol_tag_amic1 = spec->input_pins[0];
+
+		/* SPDIF I/O */
+		spec->dig_out = 0x05;
+		spec->multiout.dig_out_nid = spec->dig_out;
+		cfg->dig_out_pins[0] = 0x0c;
+		cfg->dig_outs = 1;
+		cfg->dig_out_type[0] = HDA_PCM_TYPE_SPDIF;
+		spec->dig_in = 0x09;
+		cfg->dig_in_pin = 0x0e;
+		cfg->dig_in_type = HDA_PCM_TYPE_SPDIF;
+		break;
+	case QUIRK_R3DI:
+		codec_dbg(codec, "ca0132_config: QUIRK_R3DI applied.\n");
+		snd_hda_apply_pincfgs(codec, r3di_pincfgs);
+
+		spec->num_outputs = 2;
+		spec->out_pins[0] = 0x0B; /* Line out */
+		spec->out_pins[1] = 0x0F; /* Rear headphone out */
+		spec->out_pins[2] = 0x10; /* Front Headphone / Center/LFE*/
+		spec->out_pins[3] = 0x11; /* Rear surround */
+		spec->shared_out_nid = 0x2;
+		spec->unsol_tag_hp = spec->out_pins[1];
+		spec->unsol_tag_front_hp = spec->out_pins[2];
+
+		spec->adcs[0] = 0x07; /* Rear Mic / Line-in */
+		spec->adcs[1] = 0x08; /* Front Mic, but only if no DSP */
+		spec->adcs[2] = 0x0a; /* what u hear */
+
+		spec->num_inputs = 2;
+		spec->input_pins[0] = 0x12; /* Rear Mic / Line-in */
+		spec->input_pins[1] = 0x13; /* What U Hear */
+		spec->shared_mic_nid = 0x7;
+		spec->unsol_tag_amic1 = spec->input_pins[0];
+
+		/* SPDIF I/O */
+		spec->dig_out = 0x05;
+		spec->multiout.dig_out_nid = spec->dig_out;
+		cfg->dig_out_pins[0] = 0x0c;
+		cfg->dig_outs = 1;
+		cfg->dig_out_type[0] = HDA_PCM_TYPE_SPDIF;
+		break;
+	default:
 		spec->num_outputs = 2;
 		spec->out_pins[0] = 0x0b; /* speaker out */
 		spec->out_pins[1] = 0x10; /* headphone out */
@@ -4684,7 +7469,9 @@ static void ca0132_config(struct hda_codec *codec)
 		spec->dig_in = 0x09;
 		cfg->dig_in_pin = 0x0e;
 		cfg->dig_in_type = HDA_PCM_TYPE_SPDIF;
+		break;
 	}
+
 }
 
 static int ca0132_prepare_verbs(struct hda_codec *codec)
@@ -4693,7 +7480,10 @@ static int ca0132_prepare_verbs(struct hda_codec *codec)
 #define NUM_SPEC_VERBS 4
 	struct ca0132_spec *spec = codec->spec;
 
-	spec->chip_init_verbs = ca0132_init_verbs0;
+	spec->chip_init_verbs = ca0132_init_verbs;
+	if (spec->quirk == QUIRK_SBZ)
+		spec->sbz_init_verbs = sbz_init_verbs;
+
 	spec->spec_init_verbs = kzalloc(sizeof(struct hda_verb) * NUM_SPEC_VERBS, GFP_KERNEL);
 	if (!spec->spec_init_verbs)
 		return -ENOMEM;
@@ -4732,6 +7522,7 @@ static int ca0132_prepare_verbs(struct hda_codec *codec)
 	return 0;
 }
 
+
 static int patch_ca0132(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec;
@@ -4749,6 +7540,7 @@ static int patch_ca0132(struct hda_codec *codec)
 	codec->patch_ops = ca0132_patch_ops;
 	codec->pcm_format_first = 1;
 	codec->no_sticky_stream = 1;
+	spec->dsp_download_wakeup = 0;
 
 	/* Detect codec quirk */
 	quirk = snd_pci_quirk_lookup(codec->bus->pci, ca0132_quirks);
@@ -4757,9 +7549,32 @@ static int patch_ca0132(struct hda_codec *codec)
 	else
 		spec->quirk = QUIRK_NONE;
 
+	/* Setup BAR Region 2 for Sound Blaster Z */
+	if (spec->quirk == QUIRK_SBZ) {
+		spec->mem_base = pci_iomap(codec->bus->pci, 2, 0xC20);
+		if (spec->mem_base == NULL) {
+			codec_dbg(codec, "pci_iomap failed!");
+			codec_dbg(codec, "perhaps this is not an SBZ?");
+			spec->quirk = QUIRK_NONE;
+		}
+	}
+
 	spec->dsp_state = DSP_DOWNLOAD_INIT;
 	spec->num_mixers = 1;
-	spec->mixers[0] = ca0132_mixer;
+
+	switch (spec->quirk) {
+	case QUIRK_SBZ:
+		spec->mixers[0] = ca0132_alt_mixer;
+		snd_hda_codec_set_name(codec, "Sound Blaster Z");
+		break;
+	case QUIRK_R3DI:
+		spec->mixers[0] = ca0132_alt_mixer;
+		snd_hda_codec_set_name(codec, "Recon3Di");
+		break;
+	case QUIRK_NONE:
+		spec->mixers[0] = ca0132_mixer;
+		break;
+	}
 
 	spec->base_init_verbs = ca0132_base_init_verbs;
 	spec->base_exit_verbs = ca0132_base_exit_verbs;
-- 
2.7.4
