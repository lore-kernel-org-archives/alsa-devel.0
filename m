From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH - [hdspm] 1/3] Add headers for RayDAT and AIO
	support.
Date: Tue, 18 Jan 2011 15:12:17 +0100
Message-ID: <1295359939-14673-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1295359939-14673-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1295359939-14673-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Merged the changes by Florian Faber to the hdspm driver. Code taken from

   http://wiki.linuxproaudio.org/index.php/Driver:hdspe

Whitespace fixes, also added missing commas to the texts_ports_* arrays.
Changed card_clock to unsigned long long in struct hdspm_status.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/include/hdspm.h b/include/hdspm.h
index 81990b2..5b69694 100644
--- a/include/hdspm.h
+++ b/include/hdspm.h
@@ -3,8 +3,8 @@
 /*
  *   Copyright (C) 2003 Winfried Ritsch (IEM)
  *   based on hdsp.h from Thomas Charbonnel (thomas@undata.org)
- *                      
- *    
+ *
+ *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
  *   the Free Software Foundation; either version 2 of the License, or
@@ -23,50 +23,37 @@
 /* Maximum channels is 64 even on 56Mode you have 64playbacks to matrix */
 #define HDSPM_MAX_CHANNELS      64
 
-/* -------------------- IOCTL Peak/RMS Meters -------------------- */
-
-/* peam rms level structure like we get from hardware 
-  
-   maybe in future we can memory map it so I just copy it
-   to user on ioctl call now an dont change anything
-   rms are made out of low and high values
-   where (long) ????_rms = (????_rms_l >> 8) + ((????_rms_h & 0xFFFFFF00)<<24)
-   (i asume so from the code)
-*/
-
-struct hdspm_peak_rms {
+typedef enum {
+	MADI,
+	MADIface,
+	AIO,
+	AES32,
+	RayDAT
+} hdspm_io_type;
 
-	unsigned int level_offset[1024];
 
-	unsigned int input_peak[64];
-	unsigned int playback_peak[64];
-	unsigned int output_peak[64];
-	unsigned int xxx_peak[64];	/* not used */
+/* -------------------- IOCTL Peak/RMS Meters -------------------- */
 
-	unsigned int reserved[256];	/* not used */
+struct hdspm_peak_rms {
+		uint32_t input_peaks[64];
+		uint32_t playback_peaks[64];
+		uint32_t output_peaks[64];
 
-	unsigned int input_rms_l[64];
-	unsigned int playback_rms_l[64];
-	unsigned int output_rms_l[64];
-	unsigned int xxx_rms_l[64];	/* not used */
+		uint64_t input_rms[64];
+		uint64_t playback_rms[64];
+		uint64_t output_rms[64];
 
-	unsigned int input_rms_h[64];
-	unsigned int playback_rms_h[64];
-	unsigned int output_rms_h[64];
-	unsigned int xxx_rms_h[64];	/* not used */
+		enum {ss, ds, qs} speed;
+		int status2;
 };
 
-struct hdspm_peak_rms_ioctl {
-	struct hdspm_peak_rms *peak;
-};
 
-/* use indirect access due to the limit of ioctl bit size */
 #define SNDRV_HDSPM_IOCTL_GET_PEAK_RMS \
-	_IOR('H', 0x40, struct hdspm_peak_rms_ioctl)
+	_IOR('H', 0x42, struct hdspm_peak_rms)
 
 /* ------------ CONFIG block IOCTL ---------------------- */
 
-struct hdspm_config_info {
+struct hdspm_config {
 	unsigned char pref_sync_ref;
 	unsigned char wordclock_sync_check;
 	unsigned char madi_sync_check;
@@ -80,14 +67,118 @@ struct hdspm_config_info {
 	unsigned int analog_out;
 };
 
-#define SNDRV_HDSPM_IOCTL_GET_CONFIG_INFO \
-	_IOR('H', 0x41, struct hdspm_config_info)
 
 
-/* get Soundcard Version */
+#define SNDRV_HDSPM_IOCTL_GET_CONFIG \
+	_IOR('H', 0x41, struct hdspm_config)
+
+
+
+/**
+ * If there's a TCO (TimeCode Option) board installed,
+ * there are further options and status data available.
+ * The hdspm_ltc structure contains the current SMPTE
+ * timecode and some status information and can be
+ * optained via SNDRV_HDSPM_IOCTL_GET_LTC or in the
+ * hdspm_status struct.
+ **/
+
+typedef enum {
+	format_invalid,
+	fps_24,
+	fps_25,
+	fps_2997,
+	fps_30
+} hdspm_ltc_format;
+
+typedef enum {
+	frame_invalid,
+	drop_frame,
+	full_frame
+} hdspm_ltc_frame;
+
+typedef enum {
+	ntsc,
+	pal,
+	no_video
+} hdspm_ltc_input_format;
+
+struct hdspm_ltc {
+	unsigned int ltc;
+
+	hdspm_ltc_format format;
+	hdspm_ltc_frame frame;
+	hdspm_ltc_input_format input_format;
+};
+
+#define SNDRV_HDSPM_IOCTL_GET_LTC _IOR('H', 0x46, struct hdspm_mixer_ioctl)
+
+
+/**
+ * The status data reflects the device's current state
+ * as determined by the card's configuration and
+ * connection status.
+ **/
+
+typedef enum {
+	hdspm_sync_no_lock = 0,
+	hdspm_sync_lock = 1,
+	hdspm_sync_sync = 2
+} hdspm_sync;
+
+typedef enum {hdspm_input_optical = 0, hdspm_input_coax = 1} hdspm_madi_input;
+
+typedef enum {hdspm_format_ch_64 = 0,
+	hdspm_format_ch_56 = 1
+} hdspm_madi_channel_format;
+
+typedef enum {hdspm_frame_48 = 0,
+	hdspm_frame_96 = 1
+} hdspm_madi_frame_format;
+
+typedef enum {syncsource_wc = 0,
+	syncsource_madi = 1,
+	syncsource_tco = 2,
+	syncsource_sync = 3,
+	syncsource_none = 4
+} hdspm_syncsource;
+
+struct hdspm_status {
+	hdspm_io_type card_type;
+	hdspm_syncsource autosync_source;
+
+	unsigned long long card_clock;
+	unsigned int master_period;
+
+	union {
+		struct {
+			hdspm_sync sync_wc;
+			hdspm_sync sync_madi;
+			hdspm_sync sync_tco;
+			hdspm_sync sync_in;
+			hdspm_madi_input madi_input;
+			hdspm_madi_channel_format channel_format;
+			hdspm_madi_frame_format frame_format;
+		} madi;
+	} card_specific;
+};
+
+#define SNDRV_HDSPM_IOCTL_GET_STATUS \
+	_IOR('H', 0x47, struct hdspm_status)
+
+
+/**
+ * Get information about the card and its add-ons.
+ **/
+
+#define HDSPM_ADDON_TCO 1
 
 struct hdspm_version {
+	hdspm_io_type card_type;
+	char cardname[20];
+	unsigned int serial;
 	unsigned short firmware_rev;
+	int addons;
 };
 
 #define SNDRV_HDSPM_IOCTL_GET_VERSION _IOR('H', 0x43, struct hdspm_version)
@@ -103,7 +194,7 @@ struct hdspm_version {
 /* equivalent to hardware definition, maybe for future feature of mmap of
  * them
  */
-/* each of 64 outputs has 64 infader and 64 outfader: 
+/* each of 64 outputs has 64 infader and 64 outfader:
    Ins to Outs mixer[out].in[in], Outstreams to Outs mixer[out].pb[pb] */
 
 #define HDSPM_MIXER_CHANNELS HDSPM_MAX_CHANNELS
@@ -131,4 +222,277 @@ typedef struct hdspm_version hdspm_version_t;
 typedef struct hdspm_channelfader snd_hdspm_channelfader_t;
 typedef struct hdspm_mixer hdspm_mixer_t;
 
-#endif				/* __SOUND_HDSPM_H */
+
+static char *texts_sync_status[] = {
+	"no lock",
+	"lock",
+	"sync"
+};
+
+static char *texts_ports_madi[] = {
+	"MADI.1", "MADI.2", "MADI.3", "MADI.4", "MADI.5", "MADI.6",
+	"MADI.7", "MADI.8", "MADI.9", "MADI.10", "MADI.11", "MADI.12",
+	"MADI.13", "MADI.14", "MADI.15", "MADI.16", "MADI.17", "MADI.18",
+	"MADI.19", "MADI.20", "MADI.21", "MADI.22", "MADI.23", "MADI.24",
+	"MADI.25", "MADI.26", "MADI.27", "MADI.28", "MADI.29", "MADI.30",
+	"MADI.31", "MADI.32", "MADI.33", "MADI.34", "MADI.35", "MADI.36",
+	"MADI.37", "MADI.38", "MADI.39", "MADI.40", "MADI.41", "MADI.42",
+	"MADI.43", "MADI.44", "MADI.45", "MADI.46", "MADI.47", "MADI.48",
+	"MADI.49", "MADI.50", "MADI.51", "MADI.52", "MADI.53", "MADI.54",
+	"MADI.55", "MADI.56", "MADI.57", "MADI.58", "MADI.59", "MADI.60",
+	"MADI.61", "MADI.62", "MADI.63", "MADI.64",
+};
+
+
+static char *texts_ports_raydat_ss[] = {
+	"ADAT1.1", "ADAT1.2", "ADAT1.3", "ADAT1.4", "ADAT1.5", "ADAT1.6",
+	"ADAT1.7", "ADAT1.8", "ADAT2.1", "ADAT2.2", "ADAT2.3", "ADAT2.4",
+	"ADAT2.5", "ADAT2.6", "ADAT2.7", "ADAT2.8", "ADAT3.1", "ADAT3.2",
+	"ADAT3.3", "ADAT3.4", "ADAT3.5", "ADAT3.6", "ADAT3.7", "ADAT3.8",
+	"ADAT4.1", "ADAT4.2", "ADAT4.3", "ADAT4.4", "ADAT4.5", "ADAT4.6",
+	"ADAT4.7", "ADAT4.8",
+	"AES.L", "AES.R",
+	"SPDIF.L", "SPDIF.R"
+};
+
+static char *texts_ports_raydat_ds[] = {
+	"ADAT1.1", "ADAT1.2", "ADAT1.3", "ADAT1.4",
+	"ADAT2.1", "ADAT2.2", "ADAT2.3", "ADAT2.4",
+	"ADAT3.1", "ADAT3.2", "ADAT3.3", "ADAT3.4",
+	"ADAT4.1", "ADAT4.2", "ADAT4.3", "ADAT4.4",
+	"AES.L", "AES.R",
+	"SPDIF.L", "SPDIF.R"
+};
+
+static char *texts_ports_raydat_qs[] = {
+	"ADAT1.1", "ADAT1.2",
+	"ADAT2.1", "ADAT2.2",
+	"ADAT3.1", "ADAT3.2",
+	"ADAT4.1", "ADAT4.2",
+	"AES.L", "AES.R",
+	"SPDIF.L", "SPDIF.R"
+};
+
+
+static char *texts_ports_aio_in_ss[] = {
+	"Analogue.L", "Analogue.R",
+	"AES.L", "AES.R",
+	"SPDIF.L", "SPDIF.R",
+	"ADAT.1", "ADAT.2", "ADAT.3", "ADAT.4", "ADAT.5", "ADAT.6",
+	"ADAT.7", "ADAT.8"
+};
+
+static char *texts_ports_aio_out_ss[] = {
+	"Analogue.L", "Analogue.R",
+	"AES.L", "AES.R",
+	"SPDIF.L", "SPDIF.R",
+	"ADAT.1", "ADAT.2", "ADAT.3", "ADAT.4", "ADAT.5", "ADAT.6",
+	"ADAT.7", "ADAT.8",
+	"Phone.L", "Phone.R"
+};
+
+static char *texts_ports_aio_in_ds[] = {
+	"Analogue.L", "Analogue.R",
+	"AES.L", "AES.R",
+	"SPDIF.L", "SPDIF.R",
+	"ADAT.1", "ADAT.2", "ADAT.3", "ADAT.4"
+};
+
+static char *texts_ports_aio_out_ds[] = {
+	"Analogue.L", "Analogue.R",
+	"AES.L", "AES.R",
+	"SPDIF.L", "SPDIF.R",
+	"ADAT.1", "ADAT.2", "ADAT.3", "ADAT.4",
+	"Phone.L", "Phone.R"
+};
+
+static char *texts_ports_aio_in_qs[] = {
+	"Analogue.L", "Analogue.R",
+	"AES.L", "AES.R",
+	"SPDIF.L", "SPDIF.R",
+	"ADAT.1", "ADAT.2", "ADAT.3", "ADAT.4"
+};
+
+static char *texts_ports_aio_out_qs[] = {
+	"Analogue.L", "Analogue.R",
+	"AES.L", "AES.R",
+	"SPDIF.L", "SPDIF.R",
+	"ADAT.1", "ADAT.2", "ADAT.3", "ADAT.4",
+	"Phone.L", "Phone.R"
+};
+
+
+/* These tables map the ALSA channels 1..N to the channels that we
+   need to use in order to find the relevant channel buffer. RME
+   refers to this kind of mapping as between "the ADAT channel and
+   the DMA channel." We index it using the logical audio channel,
+   and the value is the DMA channel (i.e. channel buffer number)
+   where the data for that channel can be read/written from/to.
+*/
+
+static char channel_map_unity_ss[HDSPM_MAX_CHANNELS] = {
+   0,  1,  2,  3,  4,  5,  6,  7,
+   8,  9, 10, 11, 12, 13, 14, 15,
+  16, 17, 18, 19, 20, 21, 22, 23,
+  24, 25, 26, 27, 28, 29, 30, 31,
+  32, 33, 34, 35, 36, 37, 38, 39,
+  40, 41, 42, 43, 44, 45, 46, 47,
+  48, 49, 50, 51, 52, 53, 54, 55,
+  56, 57, 58, 59, 60, 61, 62, 63
+};
+
+static char channel_map_unity_ds[HDSPM_MAX_CHANNELS] = {
+   0,  2,  4,  6,  8, 10, 12, 14,
+  16, 18, 20, 22, 24, 26, 28, 30,
+  32, 34, 36, 38, 40, 42, 44, 46,
+  48, 50, 52, 54, 56, 58, 60, 62,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,};
+
+static char channel_map_unity_qs[HDSPM_MAX_CHANNELS] = {
+   0,  4,  8, 12, 16, 20, 24, 28,
+  32, 36, 40, 44, 48, 52, 56, 60
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,};
+
+
+static char channel_map_raydat_ss[HDSPM_MAX_CHANNELS] = {
+   4,  5,  6,  7,  8,  9, 10, 11, /* ADAT 1 */
+  12, 13, 14, 15, 16, 17, 18, 19, /* ADAT 2 */
+  20, 21, 22, 23, 24, 25, 26, 27, /* ADAT 3 */
+  28, 29, 30, 31, 32, 33, 34, 35, /* ADAT 4 */
+   0,  1,						  /* AES */
+   2,  3,						  /* SPDIF */
+  -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+};
+
+static char channel_map_raydat_ds[HDSPM_MAX_CHANNELS] = {
+   4, 5, 6, 7,	  /* ADAT 1 */
+   8, 9, 10, 11,  /* ADAT 2 */
+  12, 13, 14, 15, /* ADAT 3 */
+  16, 17, 18, 19, /* ADAT 4 */
+   0,  1,		  /* AES */
+   2,  3,		  /* SPDIF */
+  -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+};
+
+static char channel_map_raydat_qs[HDSPM_MAX_CHANNELS] = {
+   4,  5, /* ADAT 1 */
+   6,  7, /* ADAT 2 */
+   8,  9, /* ADAT 3 */
+  10, 11, /* ADAT 4 */
+   0,  1, /* AES */
+   2,  3, /* SPDIF */
+  -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+};
+
+
+static char channel_map_aio_in_ss[HDSPM_MAX_CHANNELS] = {
+   0,  1, /* line in */
+   8,  9, /* aes in, */
+  10, 11, /* spdif in */
+  12, 13, 14, 15, 16, 17, 18, 19, /* ADAT in */
+  -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+};
+
+static char channel_map_aio_out_ss[HDSPM_MAX_CHANNELS] = {
+   0,  1, /* line out */
+   8,  9, /* aes out */
+  10, 11, /* spdif out */
+  12, 13, 14, 15, 16, 17, 18, 19, /* ADAT out */
+   6,  7, /* phone out */
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+};
+
+static char channel_map_aio_in_ds[HDSPM_MAX_CHANNELS] = {
+   0,  1, /* line in */
+   8,  9, /* aes in */
+  10, 11, /* spdif in */
+  12, 14, 16, 18, /* adat in */
+  -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1
+};
+
+static char channel_map_aio_out_ds[HDSPM_MAX_CHANNELS] = {
+   0,  1, /* line out */
+   8,  9, /* aes out */
+  10, 11, /* spdif out */
+  12, 14, 16, 18, /* adat out */
+   6,  7, /* phone out */
+  -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1
+};
+
+
+static char channel_map_aio_in_qs[HDSPM_MAX_CHANNELS] = {
+   0,  1, /* line in */
+   8,  9, /* aes in */
+  10, 11, /* spdif in */
+  12, 16,  /* adat in */
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1
+};
+
+static char channel_map_aio_out_qs[HDSPM_MAX_CHANNELS] = {
+   0,  1, /* line out */
+   8,  9, /* aes out */
+  10, 11, /* spdif out */
+  12, 16, /* adat out */
+   6,  7, /* phone out */
+  -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1,
+  -1, -1, -1, -1, -1, -1, -1, -1
+};
+
+
+#endif
-- 
1.7.2.3
