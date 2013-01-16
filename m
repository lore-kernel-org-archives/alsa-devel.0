From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: [PATCH 14/19] ALSA: ymu831: add codec control
	definitions
Date: Wed, 16 Jan 2013 17:40:18 +0900
Message-ID: <20130116174018.4e27ab42152cae303e31a0a8@linux-mips.org>
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
 sound/soc/codecs/ymu831/ymu831_ctl.h |  944 ++++++++++++++++++++++++++++++++++
 1 file changed, 944 insertions(+)
 create mode 100644 sound/soc/codecs/ymu831/ymu831_ctl.h

diff --git a/sound/soc/codecs/ymu831/ymu831_ctl.h b/sound/soc/codecs/ymu831/ymu831_ctl.h
new file mode 100644
index 0000000..edc0f21
--- /dev/null
+++ b/sound/soc/codecs/ymu831/ymu831_ctl.h
@@ -0,0 +1,944 @@
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
+ * - split from ymu831.c
+ * - change in the Linux coding style
+ */
+#ifndef _YMU831_CTL_H
+#define _YMU831_CTL_H
+
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+static const DECLARE_TLV_DB_SCALE(mc_asoc_tlv_digital, -9600, 1800, 1);
+
+static unsigned int mc_asoc_tlv_ain[] = {
+	TLV_DB_RANGE_HEAD(4),
+	0x00, 0x02, TLV_DB_SCALE_ITEM(-9600, 0, 1),
+	0x03, 0x36, TLV_DB_SCALE_ITEM(-3000, 100, 0),
+	0x37, 0x3B, TLV_DB_SCALE_ITEM(2150, 50, 0),
+	0x3C, 0x3F, TLV_DB_SCALE_ITEM(2400, 200, 0),
+};
+
+static unsigned int mc_asoc_tlv_aout[] = {
+	TLV_DB_RANGE_HEAD(4),
+	0x00, 0x2E, TLV_DB_SCALE_ITEM(-9600, 0, 1),
+	0x2F, 0x43, TLV_DB_SCALE_ITEM(-3600, 100, 0),
+	0x44, 0x57, TLV_DB_SCALE_ITEM(-1550, 50, 0),
+	0x58, 0x6F, TLV_DB_SCALE_ITEM(-575, 25, 0),
+};
+
+static unsigned int mc_asoc_tlv_sp[] = {
+	TLV_DB_RANGE_HEAD(4),
+	0x00, 0x2E, TLV_DB_SCALE_ITEM(-9600, 0, 1),
+	0x2F, 0x43, TLV_DB_SCALE_ITEM(-3600, 100, 0),
+	0x44, 0x57, TLV_DB_SCALE_ITEM(-1550, 50, 0),
+	0x58, 0x6f, TLV_DB_SCALE_ITEM(-575, 25, 0),
+};
+
+static unsigned int mc_asoc_tlv_lout[] = {
+	TLV_DB_RANGE_HEAD(4),
+	0x00, 0x2E, TLV_DB_SCALE_ITEM(-9600, 0, 1),
+	0x2F, 0x43, TLV_DB_SCALE_ITEM(-3600, 100, 0),
+	0x44, 0x57, TLV_DB_SCALE_ITEM(-1550, 50, 0),
+	0x58, 0x77, TLV_DB_SCALE_ITEM(-575, 25, 0),
+};
+
+static unsigned int mc_asoc_tlv_hp[] = {
+	TLV_DB_RANGE_HEAD(4),
+	0x00, 0x2F, TLV_DB_SCALE_ITEM(-9600, 0, 1),
+	0x30, 0x43, TLV_DB_SCALE_ITEM(-3500, 100, 0),
+	0x44, 0x57, TLV_DB_SCALE_ITEM(-1550, 50, 0),
+	0x58, 0x7f, TLV_DB_SCALE_ITEM(-575, 25, 0),
+};
+
+static const DECLARE_TLV_DB_SCALE(mc_asoc_tlv_ext, -7500, 100, 1);
+
+/* SP Gain */
+static unsigned int mc_asoc_tlv_sp_gain[] = {
+	TLV_DB_RANGE_HEAD(1),
+	0x00, 0x04, TLV_DB_SCALE_ITEM(1200, 100, 0)
+};
+
+/* Audio Mode */
+static const char * const audio_mode_play_param_text[] = {
+	"off", "audio", "incall", "audio+incall", "incommunication", "karaoke",
+	"incall2", "audio+incall2", "incommunication2"
+};
+
+static const struct soc_enum audio_mode_play_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_AUDIO_MODE_PLAY, 0,
+		ARRAY_SIZE(audio_mode_play_param_text) - 2,
+		audio_mode_play_param_text);
+
+static const char * const audio_mode_cap_param_text[] = {
+	"off", "audio", "incall", "audio+incall", "incommunication", "audioex",
+	"audiovr"
+};
+
+static const struct soc_enum audio_mode_cap_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_AUDIO_MODE_CAP, 0,
+		ARRAY_SIZE(audio_mode_cap_param_text),
+		audio_mode_cap_param_text);
+
+/* Output Path */
+static const char * const output_path_param_text[] = {
+	"SP", "RC", "HP", "HS", "LO1", "LO2", "BT",
+	"SP+RC", "SP+HP", "SP+LO1", "SP+LO2", "SP+BT",
+	"LO1+RC", "LO1+HP", "LO1+BT", "LO2+RC", "LO2+HP", "LO2+BT",
+	"LO1+LO2", "LO2+LO1"
+};
+
+static const struct soc_enum output_path_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_OUTPUT_PATH, 0,
+		ARRAY_SIZE(output_path_param_text),
+		output_path_param_text);
+
+/* Input Path */
+static const char * const input_path_param_text[] = {
+	"MainMIC", "SubMIC", "2MIC", "Headset", "Bluetooth",
+	"VoiceCall", "VoiceUplink", "VoiceDownlink", "Linein1"
+};
+
+static const struct soc_enum input_path_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_INPUT_PATH, 0,
+		ARRAY_SIZE(input_path_param_text),
+		input_path_param_text);
+
+/* Incall Mic */
+static const char * const incall_mic_param_text[] = {
+	"MainMIC", "SubMIC", "2MIC"
+};
+
+static const struct soc_enum incall_mic_sp_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_INCALL_MIC_SP, 0,
+		ARRAY_SIZE(incall_mic_param_text),
+		incall_mic_param_text);
+
+static const struct soc_enum incall_mic_rc_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_INCALL_MIC_RC, 0,
+		ARRAY_SIZE(incall_mic_param_text), incall_mic_param_text);
+
+static const struct soc_enum incall_mic_hp_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_INCALL_MIC_HP, 0,
+		ARRAY_SIZE(incall_mic_param_text), incall_mic_param_text);
+
+static const struct soc_enum incall_mic_lo1_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_INCALL_MIC_LO1, 0,
+		ARRAY_SIZE(incall_mic_param_text), incall_mic_param_text);
+
+static const struct soc_enum incall_mic_lo2_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_INCALL_MIC_LO2, 0,
+		ARRAY_SIZE(incall_mic_param_text), incall_mic_param_text);
+
+/* Playback Path */
+static const char * const playback_path_sw_param_text[] = {
+	"OFF", "ON"
+};
+
+static const struct soc_enum mainmic_playback_path_sw_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_MAINMIC_PLAYBACK_PATH, 0,
+		ARRAY_SIZE(playback_path_sw_param_text),
+		playback_path_sw_param_text);
+
+static const struct soc_enum submic_playback_path_sw_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_SUBMIC_PLAYBACK_PATH, 0,
+		ARRAY_SIZE(playback_path_sw_param_text),
+		playback_path_sw_param_text);
+
+static const struct soc_enum msmic_playback_path_sw_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_2MIC_PLAYBACK_PATH, 0,
+		ARRAY_SIZE(playback_path_sw_param_text),
+		playback_path_sw_param_text);
+
+static const struct soc_enum hsmic_playback_path_sw_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_HSMIC_PLAYBACK_PATH, 0,
+		ARRAY_SIZE(playback_path_sw_param_text),
+		playback_path_sw_param_text);
+
+static const struct soc_enum btmic_playback_path_sw_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_BTMIC_PLAYBACK_PATH, 0,
+		ARRAY_SIZE(playback_path_sw_param_text),
+		playback_path_sw_param_text);
+
+static const struct soc_enum lin1_playback_path_sw_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_LIN1_PLAYBACK_PATH, 0,
+		ARRAY_SIZE(playback_path_sw_param_text),
+		playback_path_sw_param_text);
+
+/* DTMF Control */
+static const char * const dtmf_control_param_text[] = {
+	"OFF", "ON"
+};
+
+static const struct soc_enum dtmf_control_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_DTMF_CONTROL, 0,
+		ARRAY_SIZE(dtmf_control_param_text),
+		dtmf_control_param_text);
+
+/* DTMF Output */
+static const char * const dtmf_output_param_text[] = {
+	"SP", "NORMAL"
+};
+
+static const struct soc_enum dtmf_output_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_DTMF_OUTPUT, 0,
+		ARRAY_SIZE(dtmf_output_param_text),
+		dtmf_output_param_text);
+
+/* Switch Clock */
+static const char * const switch_clock_param_text[] = {
+	"CLKA", "CLKB"
+};
+
+static const struct soc_enum switch_clock_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_SWITCH_CLOCK, 0,
+		ARRAY_SIZE(switch_clock_param_text),
+		switch_clock_param_text);
+
+/* Ext MasterSlave */
+static const char * const ext_masterslave_param_text[] = {
+	"Slave", "Master"
+};
+
+static const struct soc_enum ext_masterslave_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_EXT_MASTERSLAVE, 0,
+		ARRAY_SIZE(ext_masterslave_param_text),
+		ext_masterslave_param_text);
+
+/* Ext Rate */
+static const char * const ext_rate_param_text[] = {
+	"48kHz", "44.1kHz", "32kHz", "", "24kHz", "22.05kHz", "16kHz", "",
+	"12kHz", "11.025kHz", "8kHz"
+};
+
+static const struct soc_enum ext_rate_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_EXT_RATE, 0,
+		ARRAY_SIZE(ext_rate_param_text),
+		ext_rate_param_text);
+
+/* Ext Bitclock Rate */
+static const char * const ext_bck_rate_param_text[] = {
+	"64fs", "48fs", "32fs", "", "512fs", "256fs", "192fs", "128fs",
+	"96fs", "24fs", "16fs", "8fs", "", "", "", "Slave"
+};
+
+static const struct soc_enum ext_bck_rate_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_EXT_BITCLOCK_RATE, 0,
+		ARRAY_SIZE(ext_bck_rate_param_text),
+		ext_bck_rate_param_text);
+
+/* Ext Interface */
+static const char * const ext_interface_param_text[] = {
+	"DA", "PCM"
+};
+
+static const struct soc_enum ext_interface_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_EXT_INTERFACE, 0,
+		ARRAY_SIZE(ext_interface_param_text),
+		ext_interface_param_text);
+
+/* Ext Bitclock Invert */
+static const char * const ext_bck_invert_param_text[] = {
+	"Normal", "Invert"
+};
+
+static const struct soc_enum ext_bck_invert_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_EXT_BITCLOCK_INVERT, 0,
+		ARRAY_SIZE(ext_bck_invert_param_text),
+		ext_bck_invert_param_text);
+
+/* Ext DA Bit Width */
+static const char * const ext_bit_width_param_text[] = {
+	"16bit", "20bit", "24bit"
+};
+
+static const struct soc_enum ext_input_bit_width_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_EXT_INPUT_DA_BIT_WIDTH, 0,
+		ARRAY_SIZE(ext_bit_width_param_text),
+		ext_bit_width_param_text);
+
+static const struct soc_enum ext_output_bit_width_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_EXT_OUTPUT_DA_BIT_WIDTH, 0,
+		ARRAY_SIZE(ext_bit_width_param_text),
+		ext_bit_width_param_text);
+
+/* Ext DA Format */
+static const char * const ext_da_format_param_text[] = {
+	"HeadAlign", "I2S", "TailAlign"
+};
+
+static const struct soc_enum ext_input_da_format_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_EXT_INPUT_DA_FORMAT, 0,
+		ARRAY_SIZE(ext_da_format_param_text),
+		ext_da_format_param_text);
+
+static const struct soc_enum ext_output_da_format_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_EXT_OUTPUT_DA_FORMAT, 0,
+		ARRAY_SIZE(ext_da_format_param_text),
+		ext_da_format_param_text);
+
+/* Ext Pcm MonoStereo */
+static const char * const ext_pcm_mono_param_text[] = {
+	"Stereo", "Mono"
+};
+
+static const struct soc_enum ext_input_pcm_mono_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_EXT_INPUT_PCM_MONOSTEREO, 0,
+		ARRAY_SIZE(ext_pcm_mono_param_text), ext_pcm_mono_param_text);
+
+static const struct soc_enum ext_output_pcm_mono_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_EXT_OUTPUT_PCM_MONOSTEREO, 0,
+		ARRAY_SIZE(ext_pcm_mono_param_text), ext_pcm_mono_param_text);
+
+/* Ext Pcm Bit Order */
+static const char * const ext_pcm_bit_order_param_text[] = {
+	"MSB", "LSB"
+};
+
+static const struct soc_enum ext_input_pcm_bit_order_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_EXT_INPUT_PCM_BIT_ORDER, 0,
+		ARRAY_SIZE(ext_pcm_bit_order_param_text),
+		ext_pcm_bit_order_param_text);
+static const struct soc_enum ext_output_pcm_bit_order_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_EXT_OUTPUT_PCM_BIT_ORDER, 0,
+		ARRAY_SIZE(ext_pcm_bit_order_param_text),
+		ext_pcm_bit_order_param_text);
+
+/* Ext Pcm Format */
+static const char * const ext_pcm_format_param_text[] = {
+	"Linear", "Alaw", "Mulaw"
+};
+
+static const struct soc_enum ext_input_pcm_format_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_EXT_INPUT_PCM_FORMAT, 0,
+		ARRAY_SIZE(ext_pcm_format_param_text),
+		ext_pcm_format_param_text);
+
+static const struct soc_enum ext_output_pcm_format_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_EXT_OUTPUT_PCM_FORMAT, 0,
+		ARRAY_SIZE(ext_pcm_format_param_text),
+		ext_pcm_format_param_text);
+
+/* Ext PCM Bit Width */
+static const char * const ext_pcm_bit_width_param_text[] = {
+	"8bit", "16bit", "24bit"
+};
+
+static const struct soc_enum ext_input_pcm_bit_width_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_EXT_INPUT_PCM_BIT_WIDTH, 0,
+		ARRAY_SIZE(ext_pcm_bit_width_param_text),
+		ext_pcm_bit_width_param_text);
+
+static const struct soc_enum ext_output_pcm_bit_width_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_EXT_OUTPUT_PCM_BIT_WIDTH, 0,
+		ARRAY_SIZE(ext_pcm_bit_width_param_text),
+		ext_pcm_bit_width_param_text);
+
+/* Voice MasterSlave */
+static const char * const voice_masterslave_param_text[] = {
+	"Slave", "Master"
+};
+
+static const struct soc_enum voice_masterslave_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_VOICE_MASTERSLAVE, 0,
+		ARRAY_SIZE(voice_masterslave_param_text),
+		voice_masterslave_param_text);
+
+/* Voice Rate */
+static const char * const voice_rate_param_text[] = {
+	"48kHz", "44.1kHz", "32kHz", "", "24kHz", "22.05kHz", "16kHz", "",
+	"12kHz", "11.025kHz", "8kHz", "", "192kHz", "96kHz"
+};
+
+static const struct soc_enum voice_rate_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_VOICE_RATE, 0,
+		ARRAY_SIZE(voice_rate_param_text), voice_rate_param_text);
+
+/* Voice Bitclock Rate */
+static const char * const voice_bck_rate_param_text[] = {
+	"64fs", "48fs", "32fs", "", "512fs", "256fs", "192fs", "128fs",
+	"96fs", "24fs", "16fs", "8fs", "", "", "", "Slave"
+};
+
+static const struct soc_enum voice_bck_rate_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_VOICE_BITCLOCK_RATE, 0,
+		ARRAY_SIZE(voice_bck_rate_param_text),
+		voice_bck_rate_param_text);
+
+/* Voice Interface */
+static const char * const voice_interface_param_text[] = {
+	"DA", "PCM"
+};
+
+static const struct soc_enum voice_interface_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_VOICE_INTERFACE, 0,
+		ARRAY_SIZE(voice_interface_param_text),
+		voice_interface_param_text);
+
+/* Voice Bitclock Invert */
+static const char * const voice_bck_invert_param_text[] = {
+	"Normal", "Invert"
+};
+
+static const struct soc_enum voice_bck_invert_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_VOICE_BITCLOCK_INVERT, 0,
+		ARRAY_SIZE(voice_bck_invert_param_text),
+		voice_bck_invert_param_text);
+
+/* Voice DA Bit Width */
+static const char * const voice_input_bit_width_param_text[] = {
+	"16bit", "20bit", "24bit"
+};
+
+static const struct soc_enum voice_input_bit_width_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_VOICE_INPUT_DA_BIT_WIDTH, 0,
+		ARRAY_SIZE(voice_input_bit_width_param_text),
+		voice_input_bit_width_param_text);
+
+static const char * const voice_output_bit_width_param_text[] = {
+	"16bit", "20bit", "24bit", "32bit"
+};
+
+static const struct soc_enum voice_output_bit_width_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_VOICE_OUTPUT_DA_BIT_WIDTH, 0,
+		ARRAY_SIZE(voice_output_bit_width_param_text),
+		voice_output_bit_width_param_text);
+
+/* Voice DA Format */
+static const char * const voice_da_format_param_text[] = {
+	"HeadAlign", "I2S", "TailAlign"
+};
+
+static const struct soc_enum voice_input_da_format_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_VOICE_INPUT_DA_FORMAT, 0,
+		ARRAY_SIZE(voice_da_format_param_text),
+		voice_da_format_param_text);
+
+static const struct soc_enum voice_output_da_format_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_VOICE_OUTPUT_DA_FORMAT, 0,
+		ARRAY_SIZE(voice_da_format_param_text),
+		voice_da_format_param_text);
+
+/* Voice Pcm MonoStereo */
+static const char * const voice_pcm_mono_param_text[] = {
+	"Stereo", "Mono"
+};
+
+static const struct soc_enum voice_input_pcm_mono_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_VOICE_INPUT_PCM_MONOSTEREO, 0,
+		ARRAY_SIZE(voice_pcm_mono_param_text),
+		voice_pcm_mono_param_text);
+
+static const struct soc_enum voice_output_pcm_mono_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_VOICE_OUTPUT_PCM_MONOSTEREO, 0,
+		ARRAY_SIZE(voice_pcm_mono_param_text),
+		voice_pcm_mono_param_text);
+
+/* Voice Pcm Bit Order */
+static const char * const voice_pcm_bit_order_param_text[] = {
+	"MSB", "LSB"
+};
+
+static const struct soc_enum voice_input_pcm_bit_order_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_VOICE_INPUT_PCM_BIT_ORDER, 0,
+		ARRAY_SIZE(voice_pcm_bit_order_param_text),
+		voice_pcm_bit_order_param_text);
+
+static const struct soc_enum voice_output_pcm_bit_order_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_VOICE_OUTPUT_PCM_BIT_ORDER, 0,
+		ARRAY_SIZE(voice_pcm_bit_order_param_text),
+		voice_pcm_bit_order_param_text);
+
+/* Voice Pcm Format */
+static const char * const voice_pcm_format_param_text[] = {
+	"Linear", "Alaw", "Mulaw"
+};
+
+static const struct soc_enum voice_input_pcm_format_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_VOICE_INPUT_PCM_FORMAT, 0,
+		ARRAY_SIZE(voice_pcm_format_param_text),
+		voice_pcm_format_param_text);
+
+static const struct soc_enum voice_output_pcm_format_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_VOICE_OUTPUT_PCM_FORMAT, 0,
+		ARRAY_SIZE(voice_pcm_format_param_text),
+		voice_pcm_format_param_text);
+
+/* Voice PCM Bit Width */
+static const char * const voice_pcm_bit_width_param_text[] = {
+	"8bit", "16bit", "24bit"
+};
+
+static const struct soc_enum voice_input_pcm_bit_width_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_VOICE_INPUT_PCM_BIT_WIDTH, 0,
+		ARRAY_SIZE(voice_pcm_bit_width_param_text),
+		voice_pcm_bit_width_param_text);
+
+static const struct soc_enum voice_output_pcm_bit_width_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_VOICE_OUTPUT_PCM_BIT_WIDTH, 0,
+		ARRAY_SIZE(voice_pcm_bit_width_param_text),
+		voice_pcm_bit_width_param_text);
+
+/* Music Physical Port */
+static const char * const phy_port_param_text[] = {
+	"DIO0", "DIO1", "DIO2", "NONE", "SLIM0", "SLIM1", "SLIM2"
+};
+
+static const struct soc_enum music_phy_port_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_MUSIC_PHYSICAL_PORT, 0,
+		ARRAY_SIZE(phy_port_param_text),
+		phy_port_param_text);
+
+/* Ext Physical Port */
+static const struct soc_enum ext_phy_port_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_EXT_PHYSICAL_PORT, 0,
+		ARRAY_SIZE(phy_port_param_text),
+		phy_port_param_text);
+
+/* Voice Physical Port */
+static const struct soc_enum voice_phy_port_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_VOICE_PHYSICAL_PORT, 0,
+		ARRAY_SIZE(phy_port_param_text),
+		phy_port_param_text);
+
+/* Hifi Physical Port */
+static const struct soc_enum hifi_phy_port_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_HIFI_PHYSICAL_PORT, 0,
+		ARRAY_SIZE(phy_port_param_text),
+		phy_port_param_text);
+
+/* Adif0 Swap */
+static const char * const swap_param_text[] = {
+	"Normal", "Swap", "Mute", "Center", "Mix", "MonoMix", "BothL", "BothR"
+};
+
+static const struct soc_enum adif0_swap_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_ADIF0_SWAP, 0,
+		ARRAY_SIZE(swap_param_text),
+		swap_param_text);
+
+/* Adif1 Swap */
+static const struct soc_enum adif1_swap_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_ADIF1_SWAP, 0,
+		ARRAY_SIZE(swap_param_text),
+		swap_param_text);
+
+/* Adif2 Swap */
+static const struct soc_enum adif2_swap_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_ADIF2_SWAP, 0,
+		ARRAY_SIZE(swap_param_text),
+		swap_param_text);
+
+/* Dac0 Swap */
+static const struct soc_enum dac0_swap_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_DAC0_SWAP, 0,
+		ARRAY_SIZE(swap_param_text),
+		swap_param_text);
+
+/* Dac1 Swap */
+static const struct soc_enum dac1_swap_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_DAC1_SWAP, 0,
+		ARRAY_SIZE(swap_param_text),
+		swap_param_text);
+
+/* Music Out0 Swap */
+static const struct soc_enum music_out0_swap_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_MUSIC_OUT0_SWAP, 0,
+		ARRAY_SIZE(swap_param_text),
+		swap_param_text);
+
+/* Music In0 Swap */
+static const char * const swap2_param_text[] = {
+	"Normal", "Both1", "Both0", "Swap"
+};
+
+static const struct soc_enum music_in0_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_MUSIC_IN0_SWAP, 0,
+		ARRAY_SIZE(swap2_param_text),
+		swap2_param_text);
+
+/* Music In1 Swap */
+static const struct soc_enum music_in1_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_MUSIC_IN1_SWAP, 0,
+		ARRAY_SIZE(swap2_param_text),
+		swap2_param_text);
+
+/* Music In2 Swap */
+static const struct soc_enum music_in2_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_MUSIC_IN2_SWAP, 0,
+		ARRAY_SIZE(swap2_param_text),
+		swap2_param_text);
+
+/* Ext In Swap */
+static const struct soc_enum ext_in_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_EXT_IN_SWAP, 0,
+		ARRAY_SIZE(swap2_param_text),
+		swap2_param_text);
+
+/* Voice In Swap */
+static const struct soc_enum voice_in_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_VOICE_IN_SWAP, 0,
+		ARRAY_SIZE(swap2_param_text),
+		swap2_param_text);
+
+/* Music Out1 Swap */
+static const struct soc_enum music_out1_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_MUSIC_OUT1_SWAP, 0,
+		ARRAY_SIZE(swap2_param_text),
+		swap2_param_text);
+
+/* Music Out2 Swap */
+static const struct soc_enum music_out2_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_MUSIC_OUT2_SWAP, 0,
+		ARRAY_SIZE(swap2_param_text),
+		swap2_param_text);
+
+/* Ext Out Swap */
+static const struct soc_enum ext_out_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_EXT_OUT_SWAP, 0,
+		ARRAY_SIZE(swap2_param_text),
+		swap2_param_text);
+
+/* Voice Out Swap */
+static const struct soc_enum voice_out_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_VOICE_OUT_SWAP, 0,
+		ARRAY_SIZE(swap2_param_text),
+		swap2_param_text);
+
+/* Adif Source */
+static const char * const adif_src_param_text[] = {
+	"ymu831_path_cfg.h", "ADC0L", "ADC0R", "ADC1",
+	"PDM0L", "PDM0R", "PDM1L", "PDM1R", "DAC0REF", "DAC1REF"
+};
+
+static const struct soc_enum adif_src[] = {
+	SOC_ENUM_DOUBLE(MC_ASOC_ADIF0_SOURCE, 0, 8, 8, adif_src_param_text),
+	SOC_ENUM_DOUBLE(MC_ASOC_ADIF1_SOURCE, 0, 8, 8, adif_src_param_text),
+	SOC_ENUM_DOUBLE(MC_ASOC_ADIF2_SOURCE, 0, 8, 10, adif_src_param_text)
+};
+
+/* Parameter Setting */
+static const char * const parameter_setting_param_text[] = {
+	"DUMMY"
+};
+
+static const struct soc_enum parameter_setting_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_PARAMETER_SETTING, 0,
+		ARRAY_SIZE(parameter_setting_param_text),
+		parameter_setting_param_text);
+
+static const char * const mic_param_text[] = {
+	"NONE", "MIC1", "MIC2", "MIC3", "MIC4", "PDM0", "PDM1"
+};
+
+/* Main Mic */
+static const struct soc_enum main_mic_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_MAIN_MIC, 0, ARRAY_SIZE(mic_param_text),
+		mic_param_text);
+
+/* Sub Mic */
+static const struct soc_enum sub_mic_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_SUB_MIC, 0, ARRAY_SIZE(mic_param_text),
+		mic_param_text);
+
+/* Headset Mic */
+static const struct soc_enum hs_mic_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_HS_MIC, 0, ARRAY_SIZE(mic_param_text),
+		mic_param_text);
+
+#ifdef MC_ASOC_TEST
+/* MICx_BIAS */
+static const char * const mic_bias_param_text[] = {
+	"OFF", "ALWAYS_ON", "SYNC_MIC"
+};
+
+static const struct soc_enum mic1_bias_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_MIC1_BIAS, 0, ARRAY_SIZE(mic_bias_param_text),
+		mic_bias_param_text);
+
+static const struct soc_enum mic2_bias_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_MIC2_BIAS, 0, ARRAY_SIZE(mic_bias_param_text),
+		mic_bias_param_text);
+
+static const struct soc_enum mic3_bias_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_MIC3_BIAS, 0, ARRAY_SIZE(mic_bias_param_text),
+		mic_bias_param_text);
+
+static const struct soc_enum mic4_bias_param_enum =
+SOC_ENUM_SINGLE(MC_ASOC_MIC4_BIAS, 0, ARRAY_SIZE(mic_bias_param_text),
+		mic_bias_param_text);
+#endif /* MC_ASOC_TEST */
+
+static const struct snd_kcontrol_new mc_asoc_snd_controls[] = {
+	SOC_DOUBLE_TLV("Music Input Volume",
+		       MC_ASOC_DVOL_MUSICIN, 0, 8, 114, 0, mc_asoc_tlv_digital),
+	SOC_DOUBLE("Music Input Switch",
+		   MC_ASOC_DVOL_MUSICIN, 7, 15, 1, 0),
+
+	SOC_DOUBLE_TLV("Ext Input Volume",
+		       MC_ASOC_DVOL_EXTIN, 0, 8, 114, 0, mc_asoc_tlv_digital),
+	SOC_DOUBLE("Ext Input Switch",
+		   MC_ASOC_DVOL_EXTIN, 7, 15, 1, 0),
+
+	SOC_DOUBLE_TLV("Voice Input Volume",
+		       MC_ASOC_DVOL_VOICEIN, 0, 8, 114, 0, mc_asoc_tlv_digital),
+	SOC_DOUBLE("Voice Input Switch",
+		   MC_ASOC_DVOL_VOICEIN, 7, 15, 1, 0),
+
+	SOC_DOUBLE_TLV("Ref Input Volume",
+		       MC_ASOC_DVOL_REFIN, 0, 8, 114, 0, mc_asoc_tlv_digital),
+	SOC_DOUBLE("Ref Input Switch",
+		   MC_ASOC_DVOL_REFIN, 7, 15, 1, 0),
+
+	SOC_DOUBLE_TLV("Adif0 Input Volume",
+		       MC_ASOC_DVOL_ADIF0IN, 0, 8, 114, 0, mc_asoc_tlv_digital),
+	SOC_DOUBLE("Adif0 Input Switch",
+		   MC_ASOC_DVOL_ADIF0IN, 7, 15, 1, 0),
+	SOC_DOUBLE_TLV("Adif1 Input Volume",
+		       MC_ASOC_DVOL_ADIF1IN, 0, 8, 114, 0, mc_asoc_tlv_digital),
+	SOC_DOUBLE("Adif1 Input Switch",
+		   MC_ASOC_DVOL_ADIF1IN, 7, 15, 1, 0),
+	SOC_DOUBLE_TLV("Adif2 Input Volume",
+		       MC_ASOC_DVOL_ADIF2IN, 0, 8, 114, 0, mc_asoc_tlv_digital),
+	SOC_DOUBLE("Adif2 Input Switch",
+		   MC_ASOC_DVOL_ADIF2IN, 7, 15, 1, 0),
+
+	SOC_DOUBLE_TLV("Music Output Volume",
+		       MC_ASOC_DVOL_MUSICOUT, 0, 8, 114, 0,
+		       mc_asoc_tlv_digital),
+	SOC_DOUBLE("Music Output Switch",
+		   MC_ASOC_DVOL_MUSICOUT, 7, 15, 1, 0),
+	SOC_DOUBLE_TLV("Ext Output Volume",
+		       MC_ASOC_DVOL_EXTOUT, 0, 8, 114, 0, mc_asoc_tlv_digital),
+	SOC_DOUBLE("Ext Output Switch",
+		   MC_ASOC_DVOL_EXTOUT, 7, 15, 1, 0),
+
+	SOC_DOUBLE_TLV("Voice Output Volume",
+		       MC_ASOC_DVOL_VOICEOUT, 0, 8, 114, 0,
+		       mc_asoc_tlv_digital),
+	SOC_DOUBLE("Voice Output Switch",
+		   MC_ASOC_DVOL_VOICEOUT, 7, 15, 1, 0),
+
+	SOC_DOUBLE_TLV("Ref Output Volume",
+		       MC_ASOC_DVOL_REFOUT, 0, 8, 114, 0, mc_asoc_tlv_digital),
+	SOC_DOUBLE("Ref Output Switch",
+		   MC_ASOC_DVOL_REFOUT, 7, 15, 1, 0),
+
+	SOC_DOUBLE_TLV("Dac0 Output Volume",
+		       MC_ASOC_DVOL_DAC0OUT, 0, 8, 114, 0, mc_asoc_tlv_digital),
+	SOC_DOUBLE("Dac0 Output Switch",
+		   MC_ASOC_DVOL_DAC0OUT, 7, 15, 1, 0),
+
+	SOC_DOUBLE_TLV("Dac1 Output Volume",
+		       MC_ASOC_DVOL_DAC1OUT, 0, 8, 114, 0, mc_asoc_tlv_digital),
+	SOC_DOUBLE("Dac1 Output Switch",
+		   MC_ASOC_DVOL_DAC1OUT, 7, 15, 1, 0),
+
+	SOC_DOUBLE_TLV("Dpath Da Volume",
+		       MC_ASOC_DVOL_DPATHDA, 0, 8, 114, 0, mc_asoc_tlv_digital),
+	SOC_DOUBLE("Dpath Da Switch",
+		   MC_ASOC_DVOL_DPATHDA, 7, 15, 1, 0),
+
+	SOC_DOUBLE_TLV("Dpath Ad Volume",
+		       MC_ASOC_DVOL_DPATHAD, 0, 8, 114, 0, mc_asoc_tlv_digital),
+	SOC_DOUBLE("Dpath Ad Switch",
+		   MC_ASOC_DVOL_DPATHAD, 7, 15, 1, 0),
+
+	SOC_DOUBLE_TLV("LineIn1 Volume",
+		       MC_ASOC_AVOL_LINEIN1, 0, 8, 63, 0, mc_asoc_tlv_ain),
+	SOC_DOUBLE("LineIn1 Switch",
+		   MC_ASOC_AVOL_LINEIN1, 7, 15, 1, 0),
+
+	SOC_SINGLE_TLV("Mic1 Volume",
+		       MC_ASOC_AVOL_MIC1, 0, 63, 0, mc_asoc_tlv_ain),
+	SOC_SINGLE("Mic1 Switch",
+		   MC_ASOC_AVOL_MIC1, 7, 1, 0),
+
+	SOC_SINGLE_TLV("Mic2 Volume",
+		       MC_ASOC_AVOL_MIC2, 0, 63, 0, mc_asoc_tlv_ain),
+	SOC_SINGLE("Mic2 Switch",
+		   MC_ASOC_AVOL_MIC2, 7, 1, 0),
+
+	SOC_SINGLE_TLV("Mic3 Volume",
+		       MC_ASOC_AVOL_MIC3, 0, 63, 0, mc_asoc_tlv_ain),
+	SOC_SINGLE("Mic3 Switch",
+		   MC_ASOC_AVOL_MIC3, 7, 1, 0),
+
+	SOC_SINGLE_TLV("Mic4 Volume",
+		       MC_ASOC_AVOL_MIC4, 0, 63, 0, mc_asoc_tlv_ain),
+	SOC_SINGLE("Mic4 Switch",
+		   MC_ASOC_AVOL_MIC4, 7, 1, 0),
+
+	SOC_DOUBLE_TLV("Headphone Volume",
+		       MC_ASOC_AVOL_HP, 0, 8, 127, 0, mc_asoc_tlv_hp),
+	SOC_DOUBLE("Headphone Switch",
+		   MC_ASOC_AVOL_HP, 7, 15, 1, 0),
+
+	SOC_DOUBLE_TLV("Speaker Volume",
+		       MC_ASOC_AVOL_SP, 0, 8, 127, 0, mc_asoc_tlv_sp),
+	SOC_DOUBLE("Speaker Switch",
+		   MC_ASOC_AVOL_SP, 7, 15, 1, 0),
+
+	SOC_SINGLE_TLV("Receiver Volume",
+		       MC_ASOC_AVOL_RC, 0, 111, 0, mc_asoc_tlv_aout),
+	SOC_SINGLE("Receiver Switch",
+		   MC_ASOC_AVOL_RC, 7, 1, 0),
+
+	SOC_DOUBLE_TLV("LineOut1 Volume",
+		       MC_ASOC_AVOL_LINEOUT1, 0, 8, 119, 0, mc_asoc_tlv_lout),
+	SOC_DOUBLE("LineOut1 Switch",
+		   MC_ASOC_AVOL_LINEOUT1, 7, 15, 1, 0),
+
+	SOC_DOUBLE_TLV("LineOut2 Volume",
+		       MC_ASOC_AVOL_LINEOUT2, 0, 8, 119, 0, mc_asoc_tlv_lout),
+	SOC_DOUBLE("LineOut2 Switch",
+		   MC_ASOC_AVOL_LINEOUT2, 7, 15, 1, 0),
+
+	SOC_SINGLE_TLV("SP Gain",
+		       MC_ASOC_AVOL_SP_GAIN, 0, 4, 0, mc_asoc_tlv_sp_gain),
+
+	SOC_DOUBLE_TLV("Master Playback Volume",
+		       MC_ASOC_DVOL_MASTER, 0, 8, 75, 0, mc_asoc_tlv_ext),
+	SOC_DOUBLE("Master Playback Switch",
+		   MC_ASOC_DVOL_MASTER, 7, 15, 1, 0),
+
+	SOC_DOUBLE_TLV("Voice Playback Volume",
+		       MC_ASOC_DVOL_VOICE, 0, 8, 75, 0, mc_asoc_tlv_ext),
+	SOC_DOUBLE("Voice Playback Switch",
+		   MC_ASOC_DVOL_VOICE, 7, 15, 1, 0),
+
+	SOC_DOUBLE_TLV("AnalogIn Playback Analog Volume",
+		       MC_ASOC_DVOL_APLAY_A, 0, 8, 63, 0, mc_asoc_tlv_ain),
+	SOC_DOUBLE("AnalogIn Playback Analog Switch",
+		   MC_ASOC_DVOL_APLAY_A, 7, 15, 1, 0),
+
+	SOC_DOUBLE_TLV("AnalogIn Playback Digital Volume",
+		       MC_ASOC_DVOL_APLAY_D, 0, 8, 114, 0, mc_asoc_tlv_digital),
+	SOC_DOUBLE("AnalogIn Playback Digital Switch",
+		   MC_ASOC_DVOL_APLAY_D, 7, 15, 1, 0),
+
+	SOC_SINGLE("Voice Recording Switch",
+		   MC_ASOC_VOICE_RECORDING, 0, 1, 0),
+
+	SOC_ENUM("Audio Mode Playback", audio_mode_play_param_enum),
+	SOC_ENUM("Audio Mode Capture", audio_mode_cap_param_enum),
+	SOC_ENUM("Output Path", output_path_param_enum),
+	SOC_ENUM("Input Path", input_path_param_enum),
+	SOC_ENUM("Incall Mic Speaker", incall_mic_sp_param_enum),
+	SOC_ENUM("Incall Mic Receiver", incall_mic_rc_param_enum),
+	SOC_ENUM("Incall Mic Headphone", incall_mic_hp_param_enum),
+	SOC_ENUM("Incall Mic LineOut1", incall_mic_lo1_param_enum),
+	SOC_ENUM("Incall Mic LineOut2", incall_mic_lo2_param_enum),
+	SOC_ENUM("MainMIC Playback Path",
+		 mainmic_playback_path_sw_param_enum),
+	SOC_ENUM("SubMIC Playback Path", submic_playback_path_sw_param_enum),
+	SOC_ENUM("2MIC Playback Path", msmic_playback_path_sw_param_enum),
+	SOC_ENUM("HeadsetMIC Playback Path",
+		 hsmic_playback_path_sw_param_enum),
+	SOC_ENUM("BluetoothMIC Playback Path",
+		 btmic_playback_path_sw_param_enum),
+	SOC_ENUM("LIN 1 Playback Path", lin1_playback_path_sw_param_enum),
+	SOC_ENUM("DTMF Control", dtmf_control_param_enum),
+	SOC_ENUM("DTMF Output", dtmf_output_param_enum),
+	SOC_ENUM("Switch Clock", switch_clock_param_enum),
+	SOC_ENUM("Ext MasterSlave", ext_masterslave_param_enum),
+	SOC_ENUM("Ext Rate", ext_rate_param_enum),
+	SOC_ENUM("Ext Bitclock Rate", ext_bck_rate_param_enum),
+	SOC_ENUM("Ext Interface", ext_interface_param_enum),
+	SOC_ENUM("Ext Bitclock Invert", ext_bck_invert_param_enum),
+	SOC_ENUM("Ext Input DA Bit Width", ext_input_bit_width_param_enum),
+	SOC_ENUM("Ext Output DA Bit Width",
+		 ext_output_bit_width_param_enum),
+	SOC_ENUM("Ext Input DA Format", ext_input_da_format_param_enum),
+	SOC_ENUM("Ext Output DA Format", ext_output_da_format_param_enum),
+	SOC_ENUM("Ext Input Pcm MonoStereo", ext_input_pcm_mono_param_enum),
+	SOC_ENUM("Ext Output Pcm MonoStereo", ext_output_pcm_mono_param_enum),
+	SOC_ENUM("Ext Input Pcm Bit Order", ext_input_pcm_bit_order_param_enum),
+	SOC_ENUM("Ext Output Pcm Bit Order",
+		 ext_output_pcm_bit_order_param_enum),
+	SOC_ENUM("Ext Input Pcm Format", ext_input_pcm_format_param_enum),
+	SOC_ENUM("Ext Output Pcm Format", ext_output_pcm_format_param_enum),
+	SOC_ENUM("Ext Input PCM Bit Width", ext_input_pcm_bit_width_param_enum),
+	SOC_ENUM("Ext Output PCM Bit Width",
+		 ext_output_pcm_bit_width_param_enum),
+	SOC_ENUM("Voice MasterSlave", voice_masterslave_param_enum),
+	SOC_ENUM("Voice Rate", voice_rate_param_enum),
+	SOC_ENUM("Voice Bitclock Rate", voice_bck_rate_param_enum),
+	SOC_ENUM("Voice Interface", voice_interface_param_enum),
+	SOC_ENUM("Voice Bitclock Invert", voice_bck_invert_param_enum),
+	SOC_ENUM("Voice Input DA Bit Width",
+		 voice_input_bit_width_param_enum),
+	SOC_ENUM("Voice Output DA Bit Width",
+		 voice_output_bit_width_param_enum),
+	SOC_ENUM("Voice Input DA Format", voice_input_da_format_param_enum),
+	SOC_ENUM("Voice Output DA Format", voice_output_da_format_param_enum),
+	SOC_ENUM("Voice Input Pcm MonoStereo", voice_input_pcm_mono_param_enum),
+	SOC_ENUM("Voice Output Pcm MonoStereo",
+		 voice_output_pcm_mono_param_enum),
+	SOC_ENUM("Voice Input Pcm Bit Order",
+		 voice_input_pcm_bit_order_param_enum),
+	SOC_ENUM("Voice Output Pcm Bit Order",
+		 voice_output_pcm_bit_order_param_enum),
+	SOC_ENUM("Voice Input Pcm Format", voice_input_pcm_format_param_enum),
+	SOC_ENUM("Voice Output Pcm Format", voice_output_pcm_format_param_enum),
+	SOC_ENUM("Voice Input PCM Bit Width",
+		 voice_input_pcm_bit_width_param_enum),
+	SOC_ENUM("Voice Output PCM Bit Width",
+		 voice_output_pcm_bit_width_param_enum),
+	SOC_ENUM("Music Physical Port", music_phy_port_param_enum),
+	SOC_ENUM("Ext Physical Port", ext_phy_port_param_enum),
+	SOC_ENUM("Voice Physical Port", voice_phy_port_param_enum),
+	SOC_ENUM("Hifi Physical Port", hifi_phy_port_param_enum),
+	SOC_ENUM("Adif0 Swap", adif0_swap_param_enum),
+	SOC_ENUM("Adif1 Swap", adif1_swap_param_enum),
+	SOC_ENUM("Adif2 Swap", adif2_swap_param_enum),
+	SOC_ENUM("Dac0 Swap", dac0_swap_param_enum),
+	SOC_ENUM("Dac1 Swap", dac1_swap_param_enum),
+	SOC_ENUM("Music Out0 Swap", music_out0_swap_param_enum),
+	SOC_ENUM("Music In0 Swap", music_in0_param_enum),
+	SOC_ENUM("Music In1 Swap", music_in1_param_enum),
+	SOC_ENUM("Music In2 Swap", music_in2_param_enum),
+	SOC_ENUM("Ext In Swap", ext_in_param_enum),
+	SOC_ENUM("Voice In Swap", voice_in_param_enum),
+	SOC_ENUM("Music Out1 Swap", music_out1_param_enum),
+	SOC_ENUM("Music Out2 Swap", music_out2_param_enum),
+	SOC_ENUM("Ext Out Swap", ext_out_param_enum),
+	SOC_ENUM("Voice Out Swap", voice_out_param_enum),
+
+	SOC_ENUM("ADIF0 Source", adif_src[0]),
+	SOC_ENUM("ADIF1 Source", adif_src[1]),
+	SOC_ENUM("ADIF2 Source", adif_src[2]),
+	SOC_ENUM("Parameter Setting", parameter_setting_param_enum),
+	SOC_ENUM("Main Mic", main_mic_param_enum),
+	SOC_ENUM("Sub Mic", sub_mic_param_enum),
+	SOC_ENUM("Headset Mic", hs_mic_param_enum),
+#ifdef MC_ASOC_TEST
+	SOC_ENUM("MIC1 BIAS", mic1_bias_param_enum),
+	SOC_ENUM("MIC2 BIAS", mic2_bias_param_enum),
+	SOC_ENUM("MIC3 BIAS", mic3_bias_param_enum),
+	SOC_ENUM("MIC4 BIAS", mic4_bias_param_enum),
+#endif /* MC_ASOC_TEST */
+};
+
+#endif /* _YMU831_CTL_H */
-- 
1.7.9.5
