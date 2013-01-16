From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: [PATCH 15/19] ALSA: ymu831: add path configurations
	header
Date: Wed, 16 Jan 2013 17:41:20 +0900
Message-ID: <20130116174120.7f5c3152baf6cf59ea12c61e@linux-mips.org>
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
 sound/soc/codecs/ymu831/ymu831_path_cfg.h | 1024 +++++++++++++++++++++++++++++
 1 file changed, 1024 insertions(+)
 create mode 100644 sound/soc/codecs/ymu831/ymu831_path_cfg.h

diff --git a/sound/soc/codecs/ymu831/ymu831_path_cfg.h b/sound/soc/codecs/ymu831/ymu831_path_cfg.h
new file mode 100644
index 0000000..e533ebc
--- /dev/null
+++ b/sound/soc/codecs/ymu831/ymu831_path_cfg.h
@@ -0,0 +1,1024 @@
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
+#ifndef _YMU831_PATH_CFG_H
+#define _YMU831_PATH_CFG_H
+
+#include "mcdriver.h"
+
+#define PRESET_PATH_N	65
+
+static const struct mcdrv_path_info mc_preset_path_info[PRESET_PATH_N] = {
+	/* playback:off, capture:off */
+	{
+	 .music_out = {0x00aaaaaa, 0x00aaaaaa},
+	 .ext_out = {0x00aaaaaa, 0x00aaaaaa},
+	 .hifi_out = {0x00aaaaaa},
+	 .vbox_mix_in = {0x00aaaaaa, 0x00aaaaaa, 0x00aaaaaa, 0x00aaaaaa},
+	 .ae0 = {0x00aaaaaa, 0x00aaaaaa},
+	 .ae1 = {0x00aaaaaa, 0x00aaaaaa},
+	 .ae2 = {0x00aaaaaa, 0x00aaaaaa},
+	 .ae3 = {0x00aaaaaa, 0x00aaaaaa},
+	 .dac0 = {0x00aaaaaa, 0x00aaaaaa},
+	 .dac1 = {0x00aaaaaa, 0x00aaaaaa},
+	 .voice_out = {0x00aaaaaa},
+	 .vbox_io_in = {0x00aaaaaa},
+	 .vbox_host_in = {0x00aaaaaa},
+	 .host_out = {0x00aaaaaa},
+	 .adif0 = {0x00aaaaaa, 0x00aaaaaa},
+	 .adif1 = {0x00aaaaaa, 0x00aaaaaa},
+	 .adif2 = {0x00aaaaaa, 0x00aaaaaa},
+	 .adc0 = {0x002aaaaa, 0x002aaaaa},
+	 .adc1 = {0x002aaaaa},
+	 .sp = {0x002aaaaa, 0x002aaaaa},
+	 .hp = {0x002aaaaa, 0x002aaaaa},
+	 .rc = {0x002aaaaa},
+	 .lout1 = {0x002aaaaa, 0x002aaaaa},
+	 .lout2 = {0x002aaaaa, 0x002aaaaa},
+	 .bias = {0x002aaaaa, 0x002aaaaa, 0x002aaaaa, 0x002aaaaa},
+	 },
+	/* playback:audio, capture:off (analog output) */
+	{
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .dac0 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:audio, capture:off (BT output) */
+	{
+	 .ext_out = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 },
+	/* playback:audio, capture:off (analog+BT output) */
+	{
+	 .ext_out = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .dac0 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:off, capture:audio (analog input) */
+	{
+	 .music_out = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ae1 = {MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_ON},
+	 .adif1 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adc0 = {(MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_L_ON),
+		  (MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_R_ON)},
+	 },
+	/* playback:off, capture:audio (BT input) */
+	{
+	 .music_out = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 },
+	/* playback:audio, capture:audio (analog input, analog output) */
+	{
+	 .music_out = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_ON},
+	 .dac0 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .adif1 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adc0 = {(MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_L_ON),
+		  (MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_R_ON)},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:audio, capture:audio (BT input, analog output) */
+	{
+	 .music_out = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .dac0 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:audio, capture:audio (analog input, BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ext_out = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_ON},
+	 .adif1 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adc0 = {(MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_L_ON),
+		  (MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_R_ON)},
+	 },
+	/* playback:audio, capture:audio (BT input, BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ext_out = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 },
+	/* playback:audio, capture:audio (analog input, analog+BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ext_out = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_ON},
+	 .dac0 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .adif1 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adc0 = {(MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_L_ON),
+		  (MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_R_ON)},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:audio, capture:audio (BT input, analog+BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ext_out = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .dac0 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:incall, capture:incall (analog input, analog output) */
+	{
+	 .ext_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON,
+			 MCDRV_D1SRC_ADIF2_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .ae1 = {MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_ON},
+	 .dac0 = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .dac1 = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif1 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adif2 = {(MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON),
+		   (MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON)},
+	 .adc0 = {MCDRV_ASRC_MIC_ALL_ON, MCDRV_ASRC_MIC_ALL_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:incall, capture:incall (BT input, BT output) */
+	{
+	 .ext_out = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, 0, MCDRV_D1SRC_VBOXOUT_ON, 0},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .voice_out = {MCDRV_D2SRC_VBOXIOOUT_ON},
+	 .vbox_io_in = {MCDRV_D2SRC_VOICEIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 },
+	/* playback:incall, capture:incall (BT input, analog+BT output) */
+	{
+	 .ext_out = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, 0, MCDRV_D1SRC_ADIF2_ON, 0},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .dac0 = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .dac1 = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .voice_out = {MCDRV_D2SRC_VBOXIOOUT_ON},
+	 .vbox_io_in = {MCDRV_D2SRC_VOICEIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif2 = {(MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON),
+		   (MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON)},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:audio+incall, capture:incall (analog input analog output) */
+	{
+	 .ext_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON,
+			 MCDRV_D1SRC_ADIF2_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_ON},
+	 .dac0 = {(MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON),
+		  (MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON)},
+	 .dac1 = {(MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON),
+		  (MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON)},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif1 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adif2 = {(MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON),
+		   (MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON)},
+	 .adc0 = {MCDRV_ASRC_MIC_ALL_ON, MCDRV_ASRC_MIC_ALL_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:audio+incall, capture:incall (BT input BT output) */
+	{
+	 .ext_out = {(MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON),
+		     (MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON)},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, 0, MCDRV_D1SRC_VBOXOUT_ON, 0},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .voice_out = {MCDRV_D2SRC_VBOXIOOUT_ON},
+	 .vbox_io_in = {MCDRV_D2SRC_VOICEIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 },
+	/* playback:audio+incall, capture:incall (BT input analog+BT output) */
+	{
+	 .ext_out = {(MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON),
+		     (MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON)},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, 0, MCDRV_D1SRC_ADIF2_ON, 0},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .dac0 = {(MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON),
+		  (MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON)},
+	 .dac1 = {(MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON),
+		  (MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON)},
+	 .voice_out = {MCDRV_D2SRC_VBOXIOOUT_ON},
+	 .vbox_io_in = {MCDRV_D2SRC_VOICEIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif2 = {(MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON),
+		   (MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON)},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:incall, capture:audio+incall
+	   (analog input, analog output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .ext_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON,
+			 MCDRV_D1SRC_ADIF2_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .ae1 = {MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_ON},
+	 .dac0 = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .dac1 = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif1 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adif2 = {(MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON),
+		   (MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON)},
+	 .adc0 = {MCDRV_ASRC_MIC_ALL_ON, MCDRV_ASRC_MIC_ALL_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:incall, capture:audio+incall (BT input, BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .ext_out = {(MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_MUSICIN_ON),
+		     (MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_MUSICIN_ON)},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, 0, MCDRV_D1SRC_VBOXOUT_ON, 0},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .voice_out = {MCDRV_D2SRC_VBOXIOOUT_ON},
+	 .vbox_io_in = {MCDRV_D2SRC_VOICEIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 },
+	/* playback:incall, capture:audio+incall (BT input, analog+BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .ext_out = {(MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_MUSICIN_ON),
+		     (MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_MUSICIN_ON)},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, 0, MCDRV_D1SRC_ADIF2_ON, 0},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .dac0 = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .dac1 = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .voice_out = {MCDRV_D2SRC_VBOXIOOUT_ON},
+	 .vbox_io_in = {MCDRV_D2SRC_VOICEIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif2 = {(MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON),
+		   (MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON)},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:audio+incall, capture:audio+incall
+	   (analog input, analog output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .ext_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON,
+			 MCDRV_D1SRC_ADIF2_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_ON},
+	 .dac0 = {(MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON),
+		  (MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON)},
+	 .dac1 = {(MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON),
+		  (MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON)},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif1 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adif2 = {(MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON),
+		   (MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON)},
+	 .adc0 = {MCDRV_ASRC_MIC_ALL_ON, MCDRV_ASRC_MIC_ALL_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:audio+incall, capture:audio+incall (BT input, BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .ext_out = {MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON,
+		     MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, 0, MCDRV_D1SRC_VBOXOUT_ON, 0},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .voice_out = {MCDRV_D2SRC_VBOXIOOUT_ON},
+	 .vbox_io_in = {MCDRV_D2SRC_VOICEIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 },
+	/* playback:audio+incall, capture:audio+incall
+	   (BT input, analog+BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .ext_out = {MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON,
+		     MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, 0, MCDRV_D1SRC_ADIF2_ON, 0},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .dac0 = {MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON,
+		  MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON,
+		  MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON},
+	 .voice_out = {MCDRV_D2SRC_VBOXIOOUT_ON},
+	 .vbox_io_in = {MCDRV_D2SRC_VOICEIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif2 = {MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON,
+		   MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* incommunication (analog input, analog output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON,
+			 MCDRV_D1SRC_ADIF2_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_ON},
+	 .dac0 = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .dac1 = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif1 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adif2 = {MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON,
+		   MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON},
+	 .adc0 = {MCDRV_ASRC_MIC_ALL_ON, MCDRV_ASRC_MIC_ALL_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* incommunication (BT input, BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .ext_out = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, 0,
+			 MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 },
+	/* incommunication (BT input, analog+BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .ext_out = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, 0,
+			 MCDRV_D1SRC_ADIF2_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .dac0 = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .dac1 = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif2 = {MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON,
+		   MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:audio (HiFi), capture:off */
+	{
+	 .dac0 = {MCDRV_D1SRC_HIFIIN_ON, MCDRV_D1SRC_HIFIIN_ON},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 },
+	/* playback:off, capture:audio (HiFi) */
+	{
+	 .hifi_out = {MCDRV_D1SRC_ADIF0_ON},
+	 .adif0 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adc0 = {MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_L_ON,
+		  MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_R_ON},
+	 },
+	/* playback:audio (HiFi), capture:audio (HiFi) */
+	{
+	 .hifi_out = {MCDRV_D1SRC_ADIF0_ON},
+	 .dac0 = {MCDRV_D1SRC_HIFIIN_ON, MCDRV_D1SRC_HIFIIN_ON},
+	 .adif0 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adc0 = {MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_L_ON,
+		  MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_R_ON},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 },
+	/* playback:off, capture:audioex (analog input) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON,},
+	 .ae1 = {MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif1 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adc0 = {MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_L_ON,
+		  MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_R_ON},
+	 },
+	/* playback:off, capture:audioex (BT input) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON,},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 },
+	/* playback:audio, capture:audioex (analog input, analog output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON,},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_ON},
+	 .dac0 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif1 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adc0 = {MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_L_ON,
+		  MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_R_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:audio, capture:audioex (BT input, analog output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON,},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .dac0 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:audio, capture:audioex (analog input, BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .ext_out = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON,},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif1 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adc0 = {MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_L_ON,
+		  MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_R_ON},
+	 },
+	/* playback:audio, capture:audioex (BT input, BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .ext_out = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON,},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 },
+	/* playback:audio, capture:audioex (analog input, analog+BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .ext_out = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON,},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_ON},
+	 .dac0 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif1 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adc0 = {MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_L_ON,
+		  MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_R_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:audio, capture:audioex (BT input, analog+BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .ext_out = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON,},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .dac0 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:off, capture:audiovr (analog input) */
+	{
+	 .music_out = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ae1 = {MCDRV_D1SRC_ADIF0_ON, MCDRV_D1SRC_ADIF0_ON},
+	 .adif0 = {MCDRV_D2SRC_ADC1_ON, MCDRV_D2SRC_ADC1_ON},
+	 .adc1 = {MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_M_ON},
+	 },
+	/* playback:off, capture:audiovr (BT input) */
+	{
+	 .music_out = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 },
+	/* playback:audio, capture:audiovr (analog input, analog output) */
+	{
+	 .music_out = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_ADIF0_ON, MCDRV_D1SRC_ADIF0_ON},
+	 .dac0 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .adif0 = {MCDRV_D2SRC_ADC1_ON, MCDRV_D2SRC_ADC1_ON},
+	 .adc1 = {MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_M_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:audio, capture:audiovr (BT input, analog output) */
+	{
+	 .music_out = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .dac0 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:audio, capture:audiovr (analog input, BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ext_out = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_ADIF0_ON, MCDRV_D1SRC_ADIF0_ON},
+	 .adif0 = {MCDRV_D2SRC_ADC1_ON, MCDRV_D2SRC_ADC1_ON},
+	 .adc1 = {MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_M_ON},
+	 },
+	/* playback:audio, capture:audiovr (BT input, BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ext_out = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 },
+	/* playback:audio, capture:audiovr (analog input, analog+BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ext_out = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_ADIF0_ON, MCDRV_D1SRC_ADIF0_ON},
+	 .dac0 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .adif0 = {MCDRV_D2SRC_ADC1_ON, MCDRV_D2SRC_ADC1_ON},
+	 .adc1 = {MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_M_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:audio, capture:audiovr (BT input, analog+BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ext_out = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .dac0 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:karaoke, capture:off (analog input) */
+	{
+	 .vbox_mix_in = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON,
+			 MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_ON},
+	 .ae0 = {(MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_VBOXREFOUT_ON),
+		 (MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_VBOXREFOUT_ON)},
+	 .dac0 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif1 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adc0 = {(MCDRV_ASRC_MIC_ALL_ON & ~MCDRV_ASRC_MIC3_ON),
+		  (MCDRV_ASRC_MIC_ALL_ON & ~MCDRV_ASRC_MIC3_ON)},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:karaoke, capture:off (BT input) */
+	{
+	 .vbox_mix_in = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON,
+			 MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .ae0 = {(MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_VBOXREFOUT_ON),
+		 (MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_VBOXREFOUT_ON)},
+	 .dac0 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:karaoke, capture:audio (analog input) */
+	{
+	 .music_out = {(MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_VBOXREFOUT_ON),
+		       (MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_VBOXREFOUT_ON)},
+	 .vbox_mix_in = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON,
+			 MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_ON},
+	 .ae0 = {(MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_VBOXREFOUT_ON),
+		 (MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_VBOXREFOUT_ON)},
+	 .dac0 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif1 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adc0 = {MCDRV_ASRC_MIC_ALL_ON, MCDRV_ASRC_MIC_ALL_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:karaoke, capture:audio (BT input) */
+	{
+	 .music_out = {(MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_VBOXREFOUT_ON),
+		       (MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_VBOXREFOUT_ON)},
+	 .vbox_mix_in = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON,
+			 MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .ae0 = {MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_VBOXREFOUT_ON,
+		 MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .dac0 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:incall2, capture:incall (analog input, analog output) */
+	{
+	 .ext_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON,
+			 MCDRV_D1SRC_ADIF2_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .ae1 = {MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_ON},
+	 .dac0 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .dac1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif1 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adif2 = {MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON,
+		   MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON},
+	 .adc0 = {MCDRV_ASRC_MIC_ALL_ON, MCDRV_ASRC_MIC_ALL_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:incall2, capture:incall (BT input, BT output) */
+	{
+	 .ext_out = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, 0, MCDRV_D1SRC_VBOXOUT_ON, 0},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .voice_out = {MCDRV_D2SRC_VBOXIOOUT_ON},
+	 .vbox_io_in = {MCDRV_D2SRC_VOICEIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 },
+	/* playback:incall2, capture:incall (BT input, analog+BT output) */
+	{
+	 .ext_out = {MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, 0, MCDRV_D1SRC_ADIF2_ON, 0},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .dac0 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .dac1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .voice_out = {MCDRV_D2SRC_VBOXIOOUT_ON},
+	 .vbox_io_in = {MCDRV_D2SRC_VOICEIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif2 = {MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON,
+		   MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:audio+incall2, capture:incall
+	   (analog input analog output) */
+	{
+	 .ext_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON,
+			 MCDRV_D1SRC_ADIF2_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_ON},
+	 .dac0 = {MCDRV_D1SRC_EXTIN_ON | MCDRV_D1SRC_AE0_ON,
+		  MCDRV_D1SRC_EXTIN_ON | MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_EXTIN_ON | MCDRV_D1SRC_AE0_ON,
+		  MCDRV_D1SRC_EXTIN_ON | MCDRV_D1SRC_AE0_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif1 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adif2 = {MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON,
+		   MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON},
+	 .adc0 = {MCDRV_ASRC_MIC_ALL_ON, MCDRV_ASRC_MIC_ALL_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:audio+incall2, capture:incall (BT input BT output) */
+	{
+	 .ext_out = {MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON,
+		     MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, 0, MCDRV_D1SRC_VBOXOUT_ON, 0},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .voice_out = {MCDRV_D2SRC_VBOXIOOUT_ON},
+	 .vbox_io_in = {MCDRV_D2SRC_VOICEIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 },
+	/* playback:audio+incall2, capture:incall
+	   (BT input analog+BT output) */
+	{
+	 .ext_out = {MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON,
+		     MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, 0, MCDRV_D1SRC_ADIF2_ON, 0},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .dac0 = {MCDRV_D1SRC_EXTIN_ON | MCDRV_D1SRC_AE0_ON,
+		  MCDRV_D1SRC_EXTIN_ON | MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_EXTIN_ON | MCDRV_D1SRC_AE0_ON,
+		  MCDRV_D1SRC_EXTIN_ON | MCDRV_D1SRC_AE0_ON},
+	 .voice_out = {MCDRV_D2SRC_VBOXIOOUT_ON},
+	 .vbox_io_in = {MCDRV_D2SRC_VOICEIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif2 = {MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON,
+		   MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:incall2, capture:audio+incall
+	   (analog input, analog output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .ext_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON,
+			 MCDRV_D1SRC_ADIF2_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .ae1 = {MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_ON},
+	 .dac0 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .dac1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif1 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adif2 = {MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON,
+		   MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON},
+	 .adc0 = {MCDRV_ASRC_MIC_ALL_ON, MCDRV_ASRC_MIC_ALL_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:incall2, capture:audio+incall (BT input, BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .ext_out = {MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_MUSICIN_ON,
+		     MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_MUSICIN_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, 0, MCDRV_D1SRC_VBOXOUT_ON, 0},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .voice_out = {MCDRV_D2SRC_VBOXIOOUT_ON},
+	 .vbox_io_in = {MCDRV_D2SRC_VOICEIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 },
+	/* playback:incall2, capture:audio+incall
+	   (BT input, analog+BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .ext_out = {MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_MUSICIN_ON,
+		     MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_MUSICIN_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, 0, MCDRV_D1SRC_ADIF2_ON, 0},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .dac0 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .dac1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .voice_out = {MCDRV_D2SRC_VBOXIOOUT_ON},
+	 .vbox_io_in = {MCDRV_D2SRC_VOICEIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif2 = {MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON,
+		   MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:audio+incall2, capture:audio+incall
+	   (analog input, analog output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .ext_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON,
+			 MCDRV_D1SRC_ADIF2_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_ON},
+	 .dac0 = {MCDRV_D1SRC_EXTIN_ON | MCDRV_D1SRC_AE0_ON,
+		  MCDRV_D1SRC_EXTIN_ON | MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_EXTIN_ON | MCDRV_D1SRC_AE0_ON,
+		  MCDRV_D1SRC_EXTIN_ON | MCDRV_D1SRC_AE0_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif1 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adif2 = {MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON,
+		   MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON},
+	 .adc0 = {MCDRV_ASRC_MIC_ALL_ON, MCDRV_ASRC_MIC_ALL_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* playback:audio+incall2, capture:audio+incall
+	   (BT input, BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .ext_out = {MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON,
+		     MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, 0, MCDRV_D1SRC_VBOXOUT_ON, 0},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .voice_out = {MCDRV_D2SRC_VBOXIOOUT_ON},
+	 .vbox_io_in = {MCDRV_D2SRC_VOICEIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 },
+	/* playback:audio+incall2, capture:audio+incall
+	   (BT input, analog+BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .ext_out = {MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON,
+		     MCDRV_D1SRC_VBOXOUT_ON | MCDRV_D1SRC_AE0_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, 0, MCDRV_D1SRC_ADIF2_ON, 0},
+	 .ae0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .dac0 = {MCDRV_D1SRC_EXTIN_ON | MCDRV_D1SRC_AE0_ON,
+		  MCDRV_D1SRC_EXTIN_ON | MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_EXTIN_ON | MCDRV_D1SRC_AE0_ON,
+		  MCDRV_D1SRC_EXTIN_ON | MCDRV_D1SRC_AE0_ON},
+	 .voice_out = {MCDRV_D2SRC_VBOXIOOUT_ON},
+	 .vbox_io_in = {MCDRV_D2SRC_VOICEIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif2 = {MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON,
+		   MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* incommunication2 (analog input, analog output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_ON,
+			 MCDRV_D1SRC_ADIF2_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_ON},
+	 .dac0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .dac1 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif1 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adif2 = {MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON,
+		   MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON},
+	 .adc0 = {MCDRV_ASRC_MIC_ALL_ON, MCDRV_ASRC_MIC_ALL_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+	/* incommunication2 (BT input, BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .ext_out = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, 0,
+			 MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 },
+	/* incommunication2 (BT input, analog+BT output) */
+	{
+	 .music_out = {MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_ON},
+	 .ext_out = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .vbox_mix_in = {MCDRV_D1SRC_AE1_ON, 0,
+			 MCDRV_D1SRC_ADIF2_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .ae1 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .dac0 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .dac1 = {MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_ON},
+	 .host_out = {MCDRV_D2SRC_VBOXHOSTOUT_ON},
+	 .adif2 = {MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON,
+		   MCDRV_D2SRC_DAC0REF_ON | MCDRV_D2SRC_DAC1REF_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+};
+
+static const struct mcdrv_path_info analog_input_path[] = {
+	{
+	 .ext_out = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .ae0 = {MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_ON},
+	 .dac0 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .adif1 = {MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_R_ON},
+	 .adc0 = {(MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_L_ON),
+		  (MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_R_ON)},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 },
+};
+
+static const int analog_path_mapping[PRESET_PATH_N];
+
+static const struct mcdrv_path_info bt_input_path[] = {
+	{
+	 .ext_out = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .ae0 = {MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_ON},
+	 .dac0 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 }
+};
+
+static const int bt_path_mapping[PRESET_PATH_N];
+
+static const struct mcdrv_path_info dtmf_path[] = {
+	{
+	 .ext_out = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac0 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .dac1 = {MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_ON},
+	 .sp = {MCDRV_ASRC_DAC1_L_ON,},
+	 .hp = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .rc = {MCDRV_ASRC_DAC0_L_ON},
+	 .lout1 = {MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_R_ON},
+	 .lout2 = {MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_R_ON},
+	 }
+};
+
+static const int dtmf_path_mapping[PRESET_PATH_N];
+
+#endif /* _YMU831_PATH_CFG_H */
-- 
1.7.9.5
