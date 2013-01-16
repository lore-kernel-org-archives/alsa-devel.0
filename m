From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: [PATCH 13/19] ALSA: yum831: add configurations header
Date: Wed, 16 Jan 2013 17:39:21 +0900
Message-ID: <20130116173921.519557ba6220ec774ed2eff8@linux-mips.org>
References: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
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
Cc: alsa-devel@alsa-project.org, yuasa@linux-mips.org
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 sound/soc/codecs/ymu831/ymu831_cfg.h |  539 ++++++++++++++++++++++++++++++++++
 1 file changed, 539 insertions(+)
 create mode 100644 sound/soc/codecs/ymu831/ymu831_cfg.h

diff --git a/sound/soc/codecs/ymu831/ymu831_cfg.h b/sound/soc/codecs/ymu831/ymu831_cfg.h
new file mode 100644
index 0000000..61b8cbd
--- /dev/null
+++ b/sound/soc/codecs/ymu831/ymu831_cfg.h
@@ -0,0 +1,539 @@
+/*
+ * YMU831 ASoC codec driver
+ *
+ * Copyright (c) 2012 Yamaha Corporation
+ *
+ * This software is provided 'as-is', without any express or implied
+ * warranty.	In no event will the authors be held liable for any damages
+ * arising from the use of this software.
+ *
+ * Permission is granted to anyone to use this software for any purpose,
+ * including commercial applications, and to alter it and redistribute it
+ * freely, subject to the following restrictions:
+ *
+ * 1. The origin of this software must not be misrepresented; you must not
+ *	claim that you wrote the original software. If you use this software
+ *	in a product, an acknowledgment in the product documentation would be
+ *	appreciated but is not required.
+ * 2. Altered source versions must be plainly marked as such, and must not be
+ *	misrepresented as being the original software.
+ * 3. This notice may not be removed or altered from any source distribution.
+ */
+/*
+ * changelog:
+ * - change in the Linux coding style
+ * - remove unnecessary comments
+ * - remove unused codes
+ */
+#ifndef _YMU831_CFG_H
+#define _YMU831_CFG_H
+
+#include <linux/input.h>
+#include <linux/types.h>
+
+#include "mcdriver.h"
+#include "ymu831_priv.h"
+
+#define	MAX_YMS_CTRL_PARAM_SIZE	524288UL
+
+#define	CAPTURE_PORT_MUSIC	0
+#define	CAPTURE_PORT_EXT	1
+#define	CAPTURE_PORT		CAPTURE_PORT_MUSIC
+
+#define	MC_ASOC_PHYS_DIO0	MCDRV_PHYSPORT_DIO0
+#define	MC_ASOC_PHYS_DIO1	MCDRV_PHYSPORT_DIO1
+#define	MC_ASOC_PHYS_DIO2	MCDRV_PHYSPORT_DIO2
+#define	MC_ASOC_PHYS_NONE	MCDRV_PHYSPORT_NONE
+#define	MC_ASOC_PHYS_SLIM0	MCDRV_PHYSPORT_SLIM0
+#define	MC_ASOC_PHYS_SLIM1	MCDRV_PHYSPORT_SLIM1
+#define	MC_ASOC_PHYS_SLIM2	MCDRV_PHYSPORT_SLIM2
+#define	MUSIC_PHYSICAL_PORT	MC_ASOC_PHYS_DIO0
+#define	EXT_PHYSICAL_PORT	MC_ASOC_PHYS_DIO2
+#define	VOICE_PHYSICAL_PORT	MC_ASOC_PHYS_DIO1
+#define	HIFI_PHYSICAL_PORT	MC_ASOC_PHYS_DIO0
+
+#define	VOICE_RECORDING_UNMUTE	1
+
+#define	INCALL_MIC_SP		MC_ASOC_INCALL_MIC_MAINMIC
+#define	INCALL_MIC_RC		MC_ASOC_INCALL_MIC_MAINMIC
+#define	INCALL_MIC_HP		MC_ASOC_INCALL_MIC_MAINMIC
+#define	INCALL_MIC_LO1		MC_ASOC_INCALL_MIC_MAINMIC
+#define	INCALL_MIC_LO2		MC_ASOC_INCALL_MIC_MAINMIC
+
+#define	MIC_NONE		0
+#define	MIC_1			1
+#define	MIC_2			2
+#define	MIC_3			3
+#define	MIC_4			4
+#define	MIC_PDM0		5
+#define	MIC_PDM1		6
+
+#define	MAIN_MIC		MIC_1
+#define	SUB_MIC			MIC_2
+#define	HEADSET_MIC		MIC_4
+
+#define	BIAS_OFF		0
+#define	BIAS_ON_ALWAYS		1
+#define	BIAS_SYNC_MIC		2
+#define	MIC1_BIAS		BIAS_SYNC_MIC
+#define	MIC2_BIAS		BIAS_SYNC_MIC
+#define	MIC3_BIAS		BIAS_SYNC_MIC
+#define	MIC4_BIAS		BIAS_SYNC_MIC
+
+#define	IRQ_TYPE		IRQ_TYPE_EDGE_FALLING
+
+#define	AUTO_POWEROFF_OFF	0
+#define	AUTO_POWEROFF_ON	1
+#define	AUTO_POWEROFF		AUTO_POWEROFF_ON
+
+static const struct mc_asoc_setup mc_asoc_cfg_setup = {
+	.info = {
+		 .clk_sel = MCDRV_CKSEL_CMOS_CMOS,
+		 .clk_input = MCDRV_CKINPUT_CLKI0_CLKI1,
+		 .pll_mode_a = 4,
+		 .pll_prev_div_a = 10,
+		 .pll_fb_div_a = 130,
+		 .pll_frac_a = 40124,
+		 .pll_freq_a = 1,
+		 .pll_mode_b = 4,
+		 .hsdet_clk = MCDRV_HSDETCLK_RTC,
+		 .dio0_sdo_hiz = MCDRV_DAHIZ_HIZ,
+		 .dio1_sdo_hiz = MCDRV_DAHIZ_HIZ,
+		 .dio2_sdo_hiz = MCDRV_DAHIZ_HIZ,
+		 .dio0_clk_hiz = MCDRV_DAHIZ_HIZ,
+		 .dio1_clk_hiz = MCDRV_DAHIZ_HIZ,
+		 .dio2_clk_hiz = MCDRV_DAHIZ_HIZ,
+		 .dio0_pcm_hiz = MCDRV_PCMHIZ_LOW,
+		 .dio1_pcm_hiz = MCDRV_PCMHIZ_LOW,
+		 .dio2_pcm_hiz = MCDRV_PCMHIZ_LOW,
+		 .pa0_func = MCDRV_PA_GPIO,
+		 .pa1_func = MCDRV_PA_GPIO,
+		 .pa2_func = MCDRV_PA_GPIO,
+		 .power_mode = MCDRV_POWMODE_FULL,
+		 .mb_sel1 = MCDRV_MBSEL_22,
+		 .mb_sel2 = MCDRV_MBSEL_22,
+		 .mb_sel3 = MCDRV_MBSEL_22,
+		 .mb_sel4 = MCDRV_MBSEL_22,
+		 .mbs_disch = MCDRV_MBSDISCH_1000,
+		 .nonclip = MCDRV_NONCLIP_OFF,
+		 .line_in1_dif = MCDRV_LINE_STEREO,
+		 .line_out1_dif = MCDRV_LINE_STEREO,
+		 .line_out2_dif = MCDRV_LINE_STEREO,
+		 .mic1_single = MCDRV_MIC_DIF,
+		 .mic2_single = MCDRV_MIC_DIF,
+		 .mic3_single = MCDRV_MIC_DIF,
+		 .mic4_single = MCDRV_MIC_DIF,
+		 .zc_line_out1 = MCDRV_ZC_OFF,
+		 .zc_line_out2 = MCDRV_ZC_OFF,
+		 .zc_rc = MCDRV_ZC_ON,
+		 .zc_sp = MCDRV_ZC_ON,
+		 .zc_hp = MCDRV_ZC_OFF,
+		 .svol_line_out1 = MCDRV_SVOL_ON,
+		 .svol_line_out2 = MCDRV_SVOL_ON,
+		 .svol_rc = MCDRV_SVOL_ON,
+		 .svol_sp = MCDRV_SVOL_ON,
+		 .svol_hp = MCDRV_SVOL_ON,
+		 .rc_hiz = MCDRV_RCIMP_FIXLOW,
+		 .sp_hiz = MCDRV_WL_LOFF_ROFF,
+		 .hp_hiz = MCDRV_IMP_LFIXLOW_RFIXLOW,
+		 .line_out1_hiz = MCDRV_IMP_LFIXLOW_RFIXLOW,
+		 .line_out2_hiz = MCDRV_IMP_LFIXLOW_RFIXLOW,
+		 .cp_mod = MCDRV_CPMOD_MID,
+		 .rb_sel = MCDRV_RBSEL_2_2K,
+		 .plug_sel = MCDRV_PLUG_LRGM,
+		 .gnd_det = MCDRV_GNDDET_OFF,
+		 .ppd_rc = MCDRV_PPD_OFF,
+		 .ppd_sp = MCDRV_PPD_OFF,
+		 .ppd_hp = MCDRV_PPD_OFF,
+		 .ppd_line_out1 = MCDRV_PPD_OFF,
+		 .ppd_line_out2 = MCDRV_PPD_OFF,
+		 .options = {
+			     MCDRV_DOA_DRV_HIGH, MCDRV_SCKMSK_OFF,
+			     MCDRV_SPMN_OFF_9, 0x03, 0x30, 0x30,
+			     0x21, 0x03, 0xc0, 0x6a, 0x10, 0xc0, 0x01, 0x0f,
+			     },
+		 .wait_time = {
+			       .wait = {
+					5000, 5000, 5000, 5000,
+					25000, 15000, 2000,
+					/* usec */
+					},
+			       .poll_interval = {
+						 1, 1, 1, 1, 1, 1,
+						 /* msec */
+						 },
+			       .poll_timeout = {
+						1000, 1000, 1000,
+						1000, 1000, 1000,
+						/* times */
+						},
+			       },
+		 },
+	.rslot = {0, 1, 2},
+	.tslot = {0, 1, 2},
+};
+
+static const struct mcdrv_dio_port music_port_def = {
+	.dio_common = {
+		       .master_slave = MCDRV_DIO_MASTER,
+
+		       /* auto_fs : Sampling frequency automatic measurement
+				ON/OFF Setting in slave mode	*/
+		       /* MCDRV_AUTOFS_OFF	(0): OFF	*/
+		       /* MCDRV_AUTOFS_ON	(1): ON		*/
+		       .auto_fs = MCDRV_AUTOFS_ON,
+
+		       /* fs : Sampling Rate Setting		*/
+		       /* MCDRV_FS_48000	(0): 48kHz	*/
+		       /* MCDRV_FS_44100	(1): 44.1kHz	*/
+		       /* MCDRV_FS_32000	(2): 32kHz	*/
+		       /* MCDRV_FS_24000	(4): 24kHz	*/
+		       /* MCDRV_FS_22050	(5): 22.05kHz	*/
+		       /* MCDRV_FS_16000	(6): 16kHz	*/
+		       /* MCDRV_FS_12000	(8): 12kHz	*/
+		       /* MCDRV_FS_11025	(9): 11.025kHz	*/
+		       /* MCDRV_FS_8000		(10): 8kHz	*/
+		       .fs = MCDRV_FS_48000,
+
+		       /* bck_fs : Bit Clock Frequency Setting	*/
+		       /* MCDRV_BCKFS_64	(0): LRCK x 64	*/
+		       /* MCDRV_BCKFS_48	(1): LRCK x 48	*/
+		       /* MCDRV_BCKFS_32	(2): LRCK x 32	*/
+		       /* MCDRV_BCKFS_512	(4): LRCK x 512	*/
+		       /* MCDRV_BCKFS_256	(5): LRCK x 256	*/
+		       /* MCDRV_BCKFS_128	(6): LRCK x 128	*/
+		       /* MCDRV_BCKFS_16	(7): LRCK x 16	*/
+		       .bck_fs = MCDRV_BCKFS_32,
+
+		       /* interface : Interface Selection */
+		       /* MCDRV_DIO_DA		(0): Digital Audio	*/
+		       /* MCDRV_DIO_PCM		(1): PCM		*/
+		       .interface = MCDRV_DIO_DA,
+
+		       /* bck_invert : Bit Clock Inversion Setting	*/
+		       /* MCDRV_BCLK_NORMAL	(0): Normal Operation	*/
+		       /* MCDRV_BCLK_INVERT	(1): Clock Inverted	*/
+		       .bck_invert = MCDRV_BCLK_NORMAL,
+
+		       /* MCDRV_SRC_NOT_THRU	(0)	*/
+		       /* MCDRV_SRC_THRU	(1)	*/
+		       .src_thru = MCDRV_SRC_NOT_THRU,
+
+		       /* pcm_transition_edge : High Impedance transition timing
+				after transmitting the last PCM I/F data   */
+		       /* MCDRV_PCMHIZTIM_FALLING (0): BCLK#* Falling Edge */
+		       /* MCDRV_PCMHIZTIM_RISING  (1): BCLK#* Rising Edge  */
+		       .pcm_hiz_transition = MCDRV_PCMHIZTRANS_FALLING,
+
+		       /* pcm_frame : Frame Mode Setting with PCM interface */
+		       /* MCDRV_PCM_SHORTFRAME	(0): Short Frame	*/
+		       /* MCDRV_PCM_LONGFRAME	(1): Long Frame		*/
+		       .pcm_frame = MCDRV_PCM_SHORTFRAME,
+
+		       /* pcm_high_period : LR clock High time setting
+				with PCM selected and Master selected	*/
+		       /* 0 to 31: High level keeps during the period of time.
+				setting value + 1 is the bit clock.	*/
+		       .pcm_high_period = 0,
+		       },
+	.dir = {
+		/* da_format : Digital Audio Format Information */
+		.da_format = {
+			      /* bit_sel : Bit Width Setting		*/
+			      /* MCDRV_BITSEL_16	(0): 16bit	*/
+			      /* MCDRV_BITSEL_20	(1): 20bit	*/
+			      /* MCDRV_BITSEL_24	(2): 24bit	*/
+			      /* MCDRV_BITSEL_32	(3): 32bit	*/
+			      .bit_sel = MCDRV_BITSEL_16,
+
+			      /* mode : Data Format Setting		*/
+			      /* MCDRV_DAMODE_HEADALIGN (0):
+						Left-justified Format	*/
+			      /* MCDRV_DAMODE_I2S	(1): I2S	*/
+			      /* MCDRV_DAMODE_TAILALIGN	(2):
+						Right-justified Format	*/
+			      .mode = MCDRV_DAMODE_I2S},
+		/* pcm_format : PCM Format Information */
+		.pcm_format = {
+			       /* mono : Mono / Stereo Setting		*/
+			       /* MCDRV_PCM_STEREO	(0): Stereo	*/
+			       /* MCDRV_PCM_MONO	(1): Mono	*/
+			       .mono = MCDRV_PCM_MONO,
+			       /* order : Bit Order Setting		*/
+			       /* MCDRV_PCM_MSB_FIRST	(0): MSB First	*/
+			       /* MCDRV_PCM_LSB_FIRST	(1): LSB First	*/
+			       .order = MCDRV_PCM_MSB_FIRST,
+			       /* law : Data Format Setting		*/
+			       /* MCDRV_PCM_LINEAR	(0): Linear	*/
+			       /* MCDRV_PCM_ALAW	(1): A-Law	*/
+			       /* MCDRV_PCM_MULAW	(2): u-Law	*/
+			       .law = MCDRV_PCM_LINEAR,
+			       /* bit_sel : Bit Width Setting		*/
+			       /* MCDRV_PCM_BITSEL_8	(0): 8 bits	*/
+			       /* MCDRV_PCM_BITSEL_16	(1): 16 bits	*/
+			       /* MCDRV_PCM_BITSEL_24	(2): 24 bits	*/
+			       .bit_sel = MCDRV_PCM_BITSEL_8}
+		},
+	.dit = {
+		.st_mode = MCDRV_STMODE_ZERO,
+		.edge = MCDRV_SDOUT_NORMAL,
+		/* da_format : Digital Audio Format Information */
+		.da_format = {
+			      /* bit_sel : Bit Width Setting		*/
+			      /* MCDRV_BITSEL_16	(0): 16bit	*/
+			      /* MCDRV_BITSEL_20	(1): 20bit	*/
+			      /* MCDRV_BITSEL_24	(2): 24bit	*/
+			      /* MCDRV_BITSEL_32	(3): 32bit	*/
+			      .bit_sel = MCDRV_BITSEL_16,
+
+			      /* mode : Data Format Setting		*/
+			      /* MCDRV_DAMODE_HEADALIGN	(0):
+						Left-justified Format	*/
+			      /* MCDRV_DAMODE_I2S	(1): I2S	*/
+			      /* MCDRV_DAMODE_TAILALIGN	(2):
+						Right-justified Format	*/
+			      .mode = MCDRV_DAMODE_I2S},
+		/* pcm_format : PCM Format Information */
+		.pcm_format = {
+			       /* mono : Mono / Stereo Setting		*/
+			       /* MCDRV_PCM_STEREO	(0): Stereo	*/
+			       /* MCDRV_PCM_MONO	(1): Mono	*/
+			       .mono = MCDRV_PCM_MONO,
+			       /* order : Bit Order Setting		*/
+			       /* MCDRV_PCM_MSB_FIRST	(0): MSB First	*/
+			       /* MCDRV_PCM_LSB_FIRST	(1): LSB First	*/
+			       .order = MCDRV_PCM_MSB_FIRST,
+			       /* law : Data Format Setting		*/
+			       /* MCDRV_PCM_LINEAR	(0): Linear	*/
+			       /* MCDRV_PCM_ALAW	(1): A-Law	*/
+			       /* MCDRV_PCM_MULAW	(2): u-Law	*/
+			       .law = MCDRV_PCM_LINEAR,
+			       /* bit_sel : Bit Width Setting		*/
+			       /* MCDRV_PCM_BITSEL_8	(0): 8 bits	*/
+			       /* MCDRV_PCM_BITSEL_16	(1): 16 bits	*/
+			       /* MCDRV_PCM_BITSEL_24	(2): 24 bits	*/
+			       .bit_sel = MCDRV_PCM_BITSEL_16}
+		}
+};
+
+static const struct mcdrv_dio_port ext_port_def = {
+	.dio_common = {
+		       .master_slave = MCDRV_DIO_SLAVE,
+		       .auto_fs = MCDRV_AUTOFS_ON,
+		       .fs = MCDRV_FS_8000,
+		       .bck_fs = MCDRV_BCKFS_32,
+		       .interface = MCDRV_DIO_PCM,
+		       .bck_invert = MCDRV_BCLK_NORMAL,
+		       .src_thru = MCDRV_SRC_NOT_THRU,
+		       .pcm_hiz_transition = MCDRV_PCMHIZTRANS_FALLING,
+		       .pcm_frame = MCDRV_PCM_SHORTFRAME,
+		       .pcm_high_period = 0,
+		       },
+	.dir = {
+		.da_format = {
+			      .bit_sel = MCDRV_BITSEL_16,
+			      .mode = MCDRV_DAMODE_HEADALIGN},
+		.pcm_format = {
+			       .mono = MCDRV_PCM_MONO,
+			       .order = MCDRV_PCM_LSB_FIRST,
+			       .law = MCDRV_PCM_LINEAR,
+			       .bit_sel = MCDRV_PCM_BITSEL_16}
+		},
+	.dit = {
+		.st_mode = MCDRV_STMODE_ZERO,
+		.edge = MCDRV_SDOUT_NORMAL,
+		.da_format = {
+			      .bit_sel = MCDRV_BITSEL_16,
+			      .mode = MCDRV_DAMODE_HEADALIGN},
+		.pcm_format = {
+			       .mono = MCDRV_PCM_MONO,
+			       .order = MCDRV_PCM_LSB_FIRST,
+			       .law = MCDRV_PCM_LINEAR,
+			       .bit_sel = MCDRV_PCM_BITSEL_16}
+		}
+};
+
+static const struct mcdrv_dio_port voice_port_def = {
+	.dio_common = {
+		       .master_slave = MCDRV_DIO_SLAVE,
+		       .auto_fs = MCDRV_AUTOFS_ON,
+		       .fs = MCDRV_FS_8000,
+		       .bck_fs = MCDRV_BCKFS_32,
+		       .interface = MCDRV_DIO_DA,
+		       .bck_invert = MCDRV_BCLK_NORMAL,
+		       .src_thru = MCDRV_SRC_NOT_THRU,
+		       .pcm_hiz_transition = MCDRV_PCMHIZTRANS_FALLING,
+		       .pcm_frame = MCDRV_PCM_SHORTFRAME,
+		       .pcm_high_period = 0,
+		       },
+	.dir = {
+		.da_format = {
+			      .bit_sel = MCDRV_BITSEL_16,
+			      .mode = MCDRV_DAMODE_I2S},
+		.pcm_format = {
+			       .mono = MCDRV_PCM_MONO,
+			       .order = MCDRV_PCM_LSB_FIRST,
+			       .law = MCDRV_PCM_LINEAR,
+			       .bit_sel = MCDRV_PCM_BITSEL_16},
+		},
+	.dit = {
+		.st_mode = MCDRV_STMODE_ZERO,
+		.edge = MCDRV_SDOUT_NORMAL,
+		.da_format = {
+			      .bit_sel = MCDRV_BITSEL_16,
+			      .mode = MCDRV_DAMODE_I2S},
+		.pcm_format = {
+			       .mono = MCDRV_PCM_MONO,
+			       .order = MCDRV_PCM_LSB_FIRST,
+			       .law = MCDRV_PCM_LINEAR,
+			       .bit_sel = MCDRV_PCM_BITSEL_16}
+		}
+};
+
+static const struct mcdrv_dio_port hifi_port_def = {
+	.dio_common = {
+		       .master_slave = MCDRV_DIO_MASTER,
+		       .auto_fs = MCDRV_AUTOFS_ON,
+		       .fs = MCDRV_FS_48000,
+		       .bck_fs = MCDRV_BCKFS_32,
+		       .interface = MCDRV_DIO_DA,
+		       .bck_invert = MCDRV_BCLK_NORMAL,
+		       .src_thru = MCDRV_SRC_NOT_THRU,
+		       .pcm_hiz_transition = MCDRV_PCMHIZTRANS_FALLING,
+		       .pcm_frame = MCDRV_PCM_SHORTFRAME,
+		       .pcm_high_period = 0,
+		       },
+	.dir = {
+		.da_format = {
+			      .bit_sel = MCDRV_BITSEL_16,
+			      .mode = MCDRV_DAMODE_I2S},
+		.pcm_format = {
+			       .mono = MCDRV_PCM_MONO,
+			       .order = MCDRV_PCM_MSB_FIRST,
+			       .law = MCDRV_PCM_LINEAR,
+			       .bit_sel = MCDRV_PCM_BITSEL_8}
+		},
+	.dit = {
+		.st_mode = MCDRV_STMODE_ZERO,
+		.edge = MCDRV_SDOUT_NORMAL,
+		.da_format = {
+			      .bit_sel = MCDRV_BITSEL_16,
+			      .mode = MCDRV_DAMODE_I2S},
+		.pcm_format = {
+			       .mono = MCDRV_PCM_MONO,
+			       .order = MCDRV_PCM_MSB_FIRST,
+			       .law = MCDRV_PCM_LINEAR,
+			       .bit_sel = MCDRV_PCM_BITSEL_16}
+		}
+};
+
+static const struct mcdrv_hsdet_info hsdet_info_def = {
+	.en_plug_det = MCDRV_PLUGDET_DISABLE,
+	.en_plug_det_db = MCDRV_PLUGDETDB_BOTH_ENABLE,
+	.en_dly_key_off = MCDRV_KEYEN_D_D_D,
+	.en_dly_key_on = MCDRV_KEYEN_D_D_D,
+	.en_mic_det = MCDRV_MICDET_ENABLE,
+	.en_key_off = MCDRV_KEYEN_E_E_E,
+	.en_key_on = MCDRV_KEYEN_E_E_E,
+	.hs_det_dbnc = MCDRV_DETDBNC_219,
+	.key_off_mtim = MCDRV_KEYOFF_MTIM_63,
+	.key_on_mtim = MCDRV_KEYON_MTIM_63,
+	.key0_off_dly_tim = 8,
+	.key1_off_dly_tim = 8,
+	.key2_off_dly_tim = 8,
+	.key0_on_dly_tim = 8,
+	.key1_on_dly_tim = 8,
+	.key2_on_dly_tim = 8,
+	.irq_type = MCDRV_IRQTYPE_REF,
+	.plug_det_db_irq_type = MCDRV_IRQTYPE_REF,
+	.plug_undet_db_irq_type = MCDRV_IRQTYPE_REF,
+	.mic_det_irq_type = MCDRV_IRQTYPE_REF,
+	.plug_det_irq_type = MCDRV_IRQTYPE_REF,
+	.key0_on_irq_type = MCDRV_IRQTYPE_REF,
+	.key1_on_irq_type = MCDRV_IRQTYPE_REF,
+	.key2_on_irq_type = MCDRV_IRQTYPE_REF,
+	.key0_off_irq_type = MCDRV_IRQTYPE_REF,
+	.key1_off_irq_type = MCDRV_IRQTYPE_REF,
+	.key2_off_irq_type = MCDRV_IRQTYPE_REF,
+	.det_in_inv = MCDRV_DET_IN_INV,
+	.hs_det_mode = MCDRV_HSDET_MODE_DETIN_A,
+	.speriod = MCDRV_SPERIOD_3906,
+	.dbnc_num_plug = MCDRV_DBNC_NUM_7,
+	.dbnc_num_mic = MCDRV_DBNC_NUM_7,
+	.dbnc_num_key = MCDRV_DBNC_NUM_7,
+	.sgnl_period = MCDRV_SGNLPERIOD_79,
+	.sgnl_num = MCDRV_SGNLNUM_4,
+	.sgnl_peak = MCDRV_SGNLPEAK_1182,
+};
+
+#define HSUNDETDBNC	MCDRV_DETDBNC_55
+#define HSUNDETDBNCNUM	MCDRV_DBNC_NUM_7
+#define MSDETMB4OFF	5000
+
+static const struct mcdrv_hsdet_info hsdet_info_suspend = {
+	.en_plug_det = MCDRV_PLUGDET_DISABLE,
+	.en_plug_det_db = MCDRV_PLUGDETDB_BOTH_ENABLE,
+	.en_dly_key_off = MCDRV_KEYEN_D_D_D,
+	.en_dly_key_on = MCDRV_KEYEN_D_D_D,
+	.en_mic_det = MCDRV_MICDET_ENABLE,
+	.en_key_off = MCDRV_KEYEN_D_D_E,
+	.en_key_on = MCDRV_KEYEN_D_D_E,
+	.hs_det_dbnc = MCDRV_DETDBNC_219,
+	.key_off_mtim = MCDRV_KEYOFF_MTIM_63,
+	.key_on_mtim = MCDRV_KEYON_MTIM_63,
+	.key0_off_dly_tim = 8,
+	.key1_off_dly_tim = 8,
+	.key2_off_dly_tim = 8,
+	.key0_on_dly_tim = 8,
+	.key1_on_dly_tim = 8,
+	.key2_on_dly_tim = 8,
+	.irq_type = MCDRV_IRQTYPE_REF,
+	.plug_det_db_irq_type = MCDRV_IRQTYPE_REF,
+	.plug_undet_db_irq_type = MCDRV_IRQTYPE_REF,
+	.mic_det_irq_type = MCDRV_IRQTYPE_REF,
+	.plug_det_irq_type = MCDRV_IRQTYPE_REF,
+	.key0_on_irq_type = MCDRV_IRQTYPE_REF,
+	.key1_on_irq_type = MCDRV_IRQTYPE_REF,
+	.key2_on_irq_type = MCDRV_IRQTYPE_REF,
+	.key0_off_irq_type = MCDRV_IRQTYPE_REF,
+	.key1_off_irq_type = MCDRV_IRQTYPE_REF,
+	.key2_off_irq_type = MCDRV_IRQTYPE_REF,
+	.det_in_inv = MCDRV_DET_IN_INV,
+	.hs_det_mode = MCDRV_HSDET_MODE_DETIN_A,
+	.speriod = MCDRV_SPERIOD_3906,
+	.dbnc_num_plug = MCDRV_DBNC_NUM_7,
+	.dbnc_num_mic = MCDRV_DBNC_NUM_7,
+	.dbnc_num_key = MCDRV_DBNC_NUM_7,
+	.sgnl_period = MCDRV_SGNLPERIOD_79,
+	.sgnl_num = MCDRV_SGNLNUM_4,
+	.sgnl_peak = MCDRV_SGNLPEAK_1182,
+};
+
+#define	MC_ASOC_EV_KEY_DELAYKEYON0	KEY_RESERVED
+#define	MC_ASOC_EV_KEY_DELAYKEYON1	KEY_RESERVED
+#define	MC_ASOC_EV_KEY_DELAYKEYON2	KEY_RESERVED
+
+static const unsigned int delay_key_off0[8] = {
+	KEY_RESERVED, KEY_RESERVED, KEY_RESERVED, KEY_RESERVED,
+	KEY_RESERVED, KEY_RESERVED, KEY_RESERVED, KEY_RESERVED
+};
+
+static const unsigned int delay_key_off1[8] = {
+	KEY_RESERVED, KEY_RESERVED, KEY_RESERVED, KEY_RESERVED,
+	KEY_RESERVED, KEY_RESERVED, KEY_RESERVED, KEY_RESERVED
+};
+
+static const unsigned int delay_key_off2[8] = {
+	KEY_RESERVED, KEY_RESERVED, KEY_RESERVED, KEY_RESERVED,
+	KEY_RESERVED, KEY_RESERVED, KEY_RESERVED, KEY_RESERVED
+};
+
+#define MC_ASOC_IMP_TBL_NUM	8
+
+static const s16 hp_vol_imp_table[MC_ASOC_IMP_TBL_NUM];
+
+static const s16 dac0_vol_imp_table[MC_ASOC_IMP_TBL_NUM] = {
+	0, 0, 12, 18, 18, 24, 0, 0
+};
+
+#endif /* _YMU831_CFG_H */
-- 
1.7.9.5
