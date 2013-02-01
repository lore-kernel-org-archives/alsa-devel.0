From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH RFC 3/4] ALSA: madifx - Expose preliminary
	userspace interface
Date: Fri,  1 Feb 2013 13:48:40 +0100
Message-ID: <1359722921-18769-4-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1359722921-18769-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1359722921-18769-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1359722921-18769-3-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1359722921-18769-3-git-send-email-adi@drcomp.erfurt.thur.de>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Despite its name "HDSPe", the MADI FX is a new card with a similar but
different design requiring new userspace tools.

These tools don't exist, yet, but to facilitate their development,
expose a preliminary userspace API. Note that the stable bits are always
enabled while the volatile parts require CONFIG_SND_MADIFX_BROKEN to be
set.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/include/uapi/sound/madifx.h b/include/uapi/sound/madifx.h
new file mode 100644
index 0000000..3b07322
--- /dev/null
+++ b/include/uapi/sound/madifx.h
@@ -0,0 +1,173 @@
+#ifndef __SOUND_MADIFX_H
+#define __SOUND_MADIFX_H
+/*
+ *   Copyright (C) 2003 Winfried Ritsch (IEM)
+ *   based on hdsp.h from Thomas Charbonnel (thomas@undata.org)
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/* Maximum channels is 64 even on 56Mode you have 64playbacks to matrix */
+#define HDSPM_MAX_CHANNELS      196
+
+enum madifx_io_type {
+	MADIFX
+};
+
+enum madifx_speed {
+	ss = 0,
+	ds = 1,
+	qs = 2
+};
+
+/* -------------------- IOCTL Peak/RMS Meters -------------------- */
+
+#ifdef CONFIG_SND_MADIFX_BROKEN
+struct madifx_level_buffer {
+	uint32_t rms_out_pre[2 * 256];
+	uint32_t peak_out_pre[256];
+
+	uint32_t rms_in[2 * 256];
+	uint32_t peak_in[256];
+
+	uint32_t rms_play[2 * 256];
+	uint32_t peak_play[256];
+
+	uint32_t rms_out[2 * 256];
+	uint32_t peak_out[256];
+
+	uint32_t rms_in_pre[2 * 256];
+	uint32_t peak_in_pre[256];
+
+	uint8_t speed; /* enum {ss, ds, qs} */
+};
+
+#define SNDRV_MADIFX_IOCTL_GET_LEVEL \
+	_IOR('H', 0x42, struct madifx_level_buffer)
+
+#endif /* CONFIG_SND_MADIFX_BROKEN */
+
+/* ------------ CONFIG block IOCTL ---------------------- */
+
+struct madifx_config {
+	uint8_t madi_tx_64[3];
+	uint8_t madi_smux[3];
+	uint8_t wcterm;
+	uint8_t wck48;
+	uint8_t aespro;
+	uint8_t redundancy_mode;
+	uint8_t mirror_madi_out;
+};
+
+#define SNDRV_MADIFX_IOCTL_GET_CONFIG \
+	_IOR('H', 0x41, struct madifx_config)
+
+
+/**
+ * The status data reflects the device's current state
+ * as determined by the card's configuration and
+ * connection status.
+ **/
+
+enum madifx_sync {
+	madifx_sync_no_lock = 0,
+	madifx_sync_lock = 1,
+	madifx_sync_sync = 2
+};
+
+enum madifx_madi_channel_format {
+	madifx_format_ch_64 = 0,
+	madifx_format_ch_56 = 1,
+	madifx_format_ch_32 = 2,
+	madifx_format_ch_28 = 3,
+	madifx_format_ch_16 = 4,
+	madifx_format_ch_14 = 5,
+	madifx_format_ch_nolock = 6
+};
+
+enum madifx_madi_frame_format {
+	madifx_frame_48 = 0,
+	madifx_frame_96 = 1
+};
+
+enum madifx_syncsource {
+	syncsource_madi1 = 0,
+	syncsource_madi2 = 1,
+	syncsource_madi3 = 2,
+	syncsource_aes = 3,
+	syncsource_wc = 4,
+	syncsource_syncin = 5,
+	syncsource_none = 6
+};
+
+enum madifx_clocksource {
+	clock_internal = 0,
+	clock_aes = 1,
+	clock_wc = 2,
+	clock_madi1 = 3,
+	clock_madi2 = 4,
+	clock_madi3 = 5
+};
+
+
+struct madifx_status {
+	uint8_t card_type; /* enum madifx_io_type */
+	uint8_t clock_selection; /* enum madi_clocksource */
+	uint32_t system_sample_rate;
+	uint8_t madi_channelcount[3]; /* enum madifx_madi_channel_format */
+	uint32_t external_sample_rates[6]; /* enum madifx_syncsource */
+	uint8_t sync_check[6]; /* enum madifx_sync, array idx: enum madifx_syncsource */
+};
+
+#define SNDRV_MADIFX_IOCTL_GET_STATUS \
+	_IOR('H', 0x47, struct madifx_status)
+
+
+/* ------------- get Matrix Mixer IOCTL --------------- */
+
+/* We don't know too much about the new mixer, yet. See madifx.c for the bits
+ * we already have.
+ */
+#define HDSPM_MIXER_CHANNELS HDSPM_MAX_CHANNELS
+#define MADIFX_LIST_LENGTH 4096
+#define MADIFX_NUM_OUTPUT_GAINS 198
+#define MADIFX_NUM_LEVEL_PAGES 5
+#define MADIFX_LEVEL_BUFFER_SIZE (MADIFX_NUM_LEVEL_PAGES * 4096)
+
+/* FIXME: maybe move to .c file */
+struct madifx_newmixer {
+	uint32_t listVol[MADIFX_LIST_LENGTH];
+	uint32_t listCh[MADIFX_LIST_LENGTH];
+	uint32_t output_gain[MADIFX_NUM_OUTPUT_GAINS];
+};
+
+struct madifx_mixer_ioctl {
+	struct madifx_newmixer *mixer;
+};
+
+#ifdef CONFIG_SND_MADIFX_BROKEN
+/* use indirect access due to the limit of ioctl bit size */
+#define SNDRV_HDSPM_IOCTL_GET_MIXER _IOR('H', 0x44, struct madifx_mixer_ioctl)
+#endif
+
+/* typedefs for compatibility to user-space */
+typedef struct madifx_peak_rms madifx_peak_rms_t;
+typedef struct madifx_config_info madifx_config_info_t;
+typedef struct madifx_channelfader snd_madifx_channelfader_t;
+typedef struct madifx_newmixer madifx_mixer_t;
+
+
+#endif
-- 
1.7.10.4
