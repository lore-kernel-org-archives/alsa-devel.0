From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: [PATCH] ALS4000 update (mixer etc.)
Date: Sun, 10 Nov 2002 14:40:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021110134035.GA3027@andi.hausnetz>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

- make snd_kcontrol_new_t arrays in sb_mixer.c arrays of *pointers*
  to snd_kcontrol_new_t in order to have way more flexibility in
  implementing "close but not quite" matches in SB-like mixer interfaces
  (assembling new clone card SB mixers from *preexisting* controls)
- added 3D sound controls and many more controls to ALS4000, also some
  fixes to other cards (SB16 etc.)
- tried to fix ALS4000 open/close clicking and popping but failed (documented
  failure)
- added hint about official ALS4000 chip specs
- some cleanup

Greetings,

Andreas Mohr

Index: alsa-kernel/include/sb.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/sb.h,v
retrieving revision 1.7
diff -u -r1.7 sb.h
--- alsa-kernel/include/sb.h	23 Oct 2002 19:07:44 -0000	1.7
+++ alsa-kernel/include/sb.h	10 Nov 2002 13:48:44 -0000
@@ -225,7 +225,6 @@
 #define SB_DT019X_MIC_DEV	0x6a
 #define SB_DT019X_SPKR_DEV	0x6a
 #define SB_DT019X_LINE_DEV	0x6e
-#define SB_DT019X_OUTPUT_SW1	0x3c
 #define SB_DT019X_OUTPUT_SW2	0x4c
 #define SB_DT019X_CAPTURE_SW	0x6c
 
@@ -234,6 +233,14 @@
 #define SB_DT019X_CAP_LINE	0x06
 #define SB_DT019X_CAP_SYNTH	0x07
 #define SB_DT019X_CAP_MAIN	0x07
+
+#define SB_ALS4000_MONO_IO_CTRL	0x4b
+#define SB_ALS4000_MIC_IN_GAIN	0x4d
+#define SB_ALS4000_FMDAC	0x4f
+#define SB_ALS4000_3D_SND_FX	0x50
+#define SB_ALS4000_3D_TIME_DELAY	0x51
+#define SB_ALS4000_3D_AUTO_MUTE	0x52
+#define SB_ALS4000_QSOUND	0xdb
 
 /* IRQ setting bitmap */
 #define SB_IRQSETUP_IRQ9	0x01
Index: alsa-kernel/isa/sb/sb_mixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/sb/sb_mixer.c,v
retrieving revision 1.9
diff -u -r1.9 sb_mixer.c
--- alsa-kernel/isa/sb/sb_mixer.c	15 Aug 2002 12:13:07 -0000	1.9
+++ alsa-kernel/isa/sb/sb_mixer.c	10 Nov 2002 13:48:45 -0000
@@ -428,13 +428,22 @@
 	return change;
 }
 
-#define SB20_CONTROLS (sizeof(snd_sb20_controls)/sizeof(snd_kcontrol_new_t))
+#define SB20_CONTROLS (sizeof(snd_sb20_controls)/sizeof(snd_kcontrol_new_t *))
 
-static snd_kcontrol_new_t snd_sb20_controls[] = {
-SB_SINGLE("Master Playback Volume", SB_DSP20_MASTER_DEV, 1, 7),
-SB_SINGLE("PCM Playback Volume", SB_DSP20_PCM_DEV, 1, 3),
-SB_SINGLE("Synth Playback Volume", SB_DSP20_FM_DEV, 1, 7),
-SB_SINGLE("CD Playback Volume", SB_DSP20_CD_DEV, 1, 7)
+static snd_kcontrol_new_t snd_sb20_ctl_master_play_vol =
+	SB_SINGLE("Master Playback Volume", SB_DSP20_MASTER_DEV, 1, 7);
+static snd_kcontrol_new_t snd_sb20_ctl_pcm_play_vol =
+	SB_SINGLE("PCM Playback Volume", SB_DSP20_PCM_DEV, 1, 3);
+static snd_kcontrol_new_t snd_sb20_ctl_synth_play_vol =
+	SB_SINGLE("Synth Playback Volume", SB_DSP20_FM_DEV, 1, 7);
+static snd_kcontrol_new_t snd_sb20_ctl_cd_play_vol =
+	SB_SINGLE("CD Playback Volume", SB_DSP20_CD_DEV, 1, 7);
+
+static snd_kcontrol_new_t *snd_sb20_controls[] = {
+	&snd_sb20_ctl_master_play_vol,
+	&snd_sb20_ctl_pcm_play_vol,
+	&snd_sb20_ctl_synth_play_vol,
+	&snd_sb20_ctl_cd_play_vol
 };
 
 #define SB20_INIT_VALUES (sizeof(snd_sb20_init_values)/sizeof(unsigned char)/2)
@@ -444,25 +453,46 @@
 	{ SB_DSP20_FM_DEV, 0 },
 };
 
-#define SBPRO_CONTROLS (sizeof(snd_sbpro_controls)/sizeof(snd_kcontrol_new_t))
+#define SBPRO_CONTROLS (sizeof(snd_sbpro_controls)/sizeof(snd_kcontrol_new_t *))
 
-static snd_kcontrol_new_t snd_sbpro_controls[] = {
-SB_DOUBLE("Master Playback Volume", SB_DSP_MASTER_DEV, SB_DSP_MASTER_DEV, 5, 1, 7),
-SB_DOUBLE("PCM Playback Volume", SB_DSP_PCM_DEV, SB_DSP_PCM_DEV, 5, 1, 7),
-SB_SINGLE("PCM Playback Filter", SB_DSP_PLAYBACK_FILT, 5, 1),
-SB_DOUBLE("Synth Playback Volume", SB_DSP_FM_DEV, SB_DSP_FM_DEV, 5, 1, 7),
-SB_DOUBLE("CD Playback Volume", SB_DSP_CD_DEV, SB_DSP_CD_DEV, 5, 1, 7),
-SB_DOUBLE("Line Playback Volume", SB_DSP_LINE_DEV, SB_DSP_LINE_DEV, 5, 1, 7),
-SB_SINGLE("Mic Playback Volume", SB_DSP_MIC_DEV, 1, 3),
-{
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "Capture Source",
-	.info = snd_sb8mixer_info_mux,
-	.get = snd_sb8mixer_get_mux,
-	.put = snd_sb8mixer_put_mux,
-},
-SB_SINGLE("Capture Filter", SB_DSP_CAPTURE_FILT, 5, 1),
-SB_SINGLE("Capture Low-Pass Filter", SB_DSP_CAPTURE_FILT, 3, 1)
+static snd_kcontrol_new_t snd_sbpro_ctl_master_play_vol =
+	SB_DOUBLE("Master Playback Volume", SB_DSP_MASTER_DEV, SB_DSP_MASTER_DEV, 5, 1, 7);
+static snd_kcontrol_new_t snd_sbpro_ctl_pcm_play_vol =
+	SB_DOUBLE("PCM Playback Volume", SB_DSP_PCM_DEV, SB_DSP_PCM_DEV, 5, 1, 7);
+static snd_kcontrol_new_t snd_sbpro_ctl_pcm_play_filter =
+	SB_SINGLE("PCM Playback Filter", SB_DSP_PLAYBACK_FILT, 5, 1);
+static snd_kcontrol_new_t snd_sbpro_ctl_synth_play_vol =
+	SB_DOUBLE("Synth Playback Volume", SB_DSP_FM_DEV, SB_DSP_FM_DEV, 5, 1, 7);
+static snd_kcontrol_new_t snd_sbpro_ctl_cd_play_vol =
+	SB_DOUBLE("CD Playback Volume", SB_DSP_CD_DEV, SB_DSP_CD_DEV, 5, 1, 7);
+static snd_kcontrol_new_t snd_sbpro_ctl_line_play_vol =
+	SB_DOUBLE("Line Playback Volume", SB_DSP_LINE_DEV, SB_DSP_LINE_DEV, 5, 1, 7);
+static snd_kcontrol_new_t snd_sbpro_ctl_mic_play_vol =
+	SB_SINGLE("Mic Playback Volume", SB_DSP_MIC_DEV, 1, 3);
+static snd_kcontrol_new_t snd_sbpro_ctl_capture_source =
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Capture Source",
+		.info = snd_sb8mixer_info_mux,
+		.get = snd_sb8mixer_get_mux,
+		.put = snd_sb8mixer_put_mux,
+	};
+static snd_kcontrol_new_t snd_sbpro_ctl_capture_filter =
+	SB_SINGLE("Capture Filter", SB_DSP_CAPTURE_FILT, 5, 1);
+static snd_kcontrol_new_t snd_sbpro_ctl_capture_low_filter =
+	SB_SINGLE("Capture Low-Pass Filter", SB_DSP_CAPTURE_FILT, 3, 1);
+
+static snd_kcontrol_new_t *snd_sbpro_controls[] = {
+	&snd_sbpro_ctl_master_play_vol,
+	&snd_sbpro_ctl_pcm_play_vol,
+	&snd_sbpro_ctl_pcm_play_filter,
+	&snd_sbpro_ctl_synth_play_vol,
+	&snd_sbpro_ctl_cd_play_vol,
+	&snd_sbpro_ctl_line_play_vol,
+	&snd_sbpro_ctl_mic_play_vol,
+	&snd_sbpro_ctl_capture_source,
+	&snd_sbpro_ctl_capture_filter,
+	&snd_sbpro_ctl_capture_low_filter
 };
 
 #define SBPRO_INIT_VALUES (sizeof(snd_sbpro_init_values)/sizeof(unsigned char)/2)
@@ -473,29 +503,70 @@
 	{ SB_DSP_FM_DEV, 0 },
 };
 
-#define SB16_CONTROLS (sizeof(snd_sb16_controls)/sizeof(snd_kcontrol_new_t))
+#define SB16_CONTROLS (sizeof(snd_sb16_controls)/sizeof(snd_kcontrol_new_t *))
 
-static snd_kcontrol_new_t snd_sb16_controls[] = {
-SB_DOUBLE("Master Playback Volume", SB_DSP4_MASTER_DEV, (SB_DSP4_MASTER_DEV + 1), 3, 3, 31),
-SB_SINGLE("3D Enhancement Switch", SB_DSP4_3DSE, 0, 1),
-SB_DOUBLE("Tone Control - Bass", SB_DSP4_BASS_DEV, (SB_DSP4_BASS_DEV + 1), 4, 4, 15),
-SB_DOUBLE("Tone Control - Treble", SB_DSP4_TREBLE_DEV, (SB_DSP4_TREBLE_DEV + 1), 4, 4, 15),
-SB_DOUBLE("PCM Playback Volume", SB_DSP4_PCM_DEV, (SB_DSP4_PCM_DEV + 1), 3, 3, 31),
-SB16_INPUT_SW("Synth Capture Route", SB_DSP4_INPUT_LEFT, SB_DSP4_INPUT_RIGHT, 6, 5),
-SB_DOUBLE("Synth Playback Volume", SB_DSP4_SYNTH_DEV, (SB_DSP4_SYNTH_DEV + 1), 3, 3, 31),
-SB16_INPUT_SW("CD Capture Route", SB_DSP4_INPUT_LEFT, SB_DSP4_INPUT_RIGHT, 2, 1),
-SB_DOUBLE("CD Playback Switch", SB_DSP4_OUTPUT_SW, SB_DSP4_OUTPUT_SW, 2, 1, 1),
-SB_DOUBLE("CD Playback Volume", SB_DSP4_CD_DEV, (SB_DSP4_CD_DEV + 1), 3, 3, 31),
-SB16_INPUT_SW("Line Capture Route", SB_DSP4_INPUT_LEFT, SB_DSP4_INPUT_RIGHT, 4, 3),
-SB_DOUBLE("Line Playback Switch", SB_DSP4_OUTPUT_SW, SB_DSP4_OUTPUT_SW, 4, 3, 1),
-SB_DOUBLE("Line Playback Volume", SB_DSP4_LINE_DEV, (SB_DSP4_LINE_DEV + 1), 3, 3, 31),
-SB_DOUBLE("Mic Capture Switch", SB_DSP4_INPUT_LEFT, SB_DSP4_INPUT_RIGHT, 0, 0, 1),
-SB_SINGLE("Mic Playback Switch", SB_DSP4_OUTPUT_SW, 0, 1),
-SB_SINGLE("Mic Playback Volume", SB_DSP4_MIC_DEV, 3, 31),
-SB_SINGLE("PC Speaker Volume", SB_DSP4_SPEAKER_DEV, 6, 3),
-SB_DOUBLE("Capture Volume", SB_DSP4_IGAIN_DEV, (SB_DSP4_IGAIN_DEV + 1), 6, 6, 3),
-SB_DOUBLE("Playback Volume", SB_DSP4_OGAIN_DEV, (SB_DSP4_OGAIN_DEV + 1), 6, 6, 3),
-SB_SINGLE("Auto Mic Gain", SB_DSP4_MIC_AGC, 0, 1)
+static snd_kcontrol_new_t snd_sb16_ctl_master_play_vol =
+	SB_DOUBLE("Master Playback Volume", SB_DSP4_MASTER_DEV, (SB_DSP4_MASTER_DEV + 1), 3, 3, 31);
+static snd_kcontrol_new_t snd_sb16_ctl_3d_enhance_switch =
+	SB_SINGLE("3D Enhancement Switch", SB_DSP4_3DSE, 0, 1);
+static snd_kcontrol_new_t snd_sb16_ctl_tone_bass =
+	SB_DOUBLE("Tone Control - Bass", SB_DSP4_BASS_DEV, (SB_DSP4_BASS_DEV + 1), 4, 4, 15);
+static snd_kcontrol_new_t snd_sb16_ctl_tone_treble =
+	SB_DOUBLE("Tone Control - Treble", SB_DSP4_TREBLE_DEV, (SB_DSP4_TREBLE_DEV + 1), 4, 4, 15);
+static snd_kcontrol_new_t snd_sb16_ctl_pcm_play_vol =
+	SB_DOUBLE("PCM Playback Volume", SB_DSP4_PCM_DEV, (SB_DSP4_PCM_DEV + 1), 3, 3, 31);
+static snd_kcontrol_new_t snd_sb16_ctl_synth_capture_route =
+	SB16_INPUT_SW("Synth Capture Route", SB_DSP4_INPUT_LEFT, SB_DSP4_INPUT_RIGHT, 6, 5);
+static snd_kcontrol_new_t snd_sb16_ctl_synth_play_vol =
+	SB_DOUBLE("Synth Playback Volume", SB_DSP4_SYNTH_DEV, (SB_DSP4_SYNTH_DEV + 1), 3, 3, 31);
+static snd_kcontrol_new_t snd_sb16_ctl_cd_capture_route =
+	SB16_INPUT_SW("CD Capture Route", SB_DSP4_INPUT_LEFT, SB_DSP4_INPUT_RIGHT, 2, 1);
+static snd_kcontrol_new_t snd_sb16_ctl_cd_play_switch =
+	SB_DOUBLE("CD Playback Switch", SB_DSP4_OUTPUT_SW, SB_DSP4_OUTPUT_SW, 2, 1, 1);
+static snd_kcontrol_new_t snd_sb16_ctl_cd_play_vol =
+	SB_DOUBLE("CD Playback Volume", SB_DSP4_CD_DEV, (SB_DSP4_CD_DEV + 1), 3, 3, 31);
+static snd_kcontrol_new_t snd_sb16_ctl_line_capture_route =
+	SB16_INPUT_SW("Line Capture Route", SB_DSP4_INPUT_LEFT, SB_DSP4_INPUT_RIGHT, 4, 3);
+static snd_kcontrol_new_t snd_sb16_ctl_line_play_switch =
+	SB_DOUBLE("Line Playback Switch", SB_DSP4_OUTPUT_SW, SB_DSP4_OUTPUT_SW, 4, 3, 1);
+static snd_kcontrol_new_t snd_sb16_ctl_line_play_vol =
+	SB_DOUBLE("Line Playback Volume", SB_DSP4_LINE_DEV, (SB_DSP4_LINE_DEV + 1), 3, 3, 31);
+static snd_kcontrol_new_t snd_sb16_ctl_mic_capture_route =
+	SB16_INPUT_SW("Mic Capture Route", SB_DSP4_INPUT_LEFT, SB_DSP4_INPUT_RIGHT, 0, 0);
+static snd_kcontrol_new_t snd_sb16_ctl_mic_play_switch =
+	SB_SINGLE("Mic Playback Switch", SB_DSP4_OUTPUT_SW, 0, 1);
+static snd_kcontrol_new_t snd_sb16_ctl_mic_play_vol =
+	SB_SINGLE("Mic Playback Volume", SB_DSP4_MIC_DEV, 3, 31);
+static snd_kcontrol_new_t snd_sb16_ctl_pc_speaker_vol =
+	SB_SINGLE("PC Speaker Volume", SB_DSP4_SPEAKER_DEV, 6, 3);
+static snd_kcontrol_new_t snd_sb16_ctl_capture_vol =
+	SB_DOUBLE("Capture Volume", SB_DSP4_IGAIN_DEV, (SB_DSP4_IGAIN_DEV + 1), 6, 6, 3);
+static snd_kcontrol_new_t snd_sb16_ctl_play_vol =
+	SB_DOUBLE("Playback Volume", SB_DSP4_OGAIN_DEV, (SB_DSP4_OGAIN_DEV + 1), 6, 6, 3);
+static snd_kcontrol_new_t snd_sb16_ctl_auto_mic_gain =
+	SB_SINGLE("Mic Auto Gain", SB_DSP4_MIC_AGC, 0, 1);
+
+static snd_kcontrol_new_t *snd_sb16_controls[] = {
+	&snd_sb16_ctl_master_play_vol,
+	&snd_sb16_ctl_3d_enhance_switch,
+	&snd_sb16_ctl_tone_bass,
+	&snd_sb16_ctl_tone_treble,
+	&snd_sb16_ctl_pcm_play_vol,
+	&snd_sb16_ctl_synth_capture_route,
+	&snd_sb16_ctl_synth_play_vol,
+	&snd_sb16_ctl_cd_capture_route,
+	&snd_sb16_ctl_cd_play_switch,
+	&snd_sb16_ctl_cd_play_vol,
+	&snd_sb16_ctl_line_capture_route,
+	&snd_sb16_ctl_line_play_switch,
+	&snd_sb16_ctl_line_play_vol,
+	&snd_sb16_ctl_mic_capture_route,
+	&snd_sb16_ctl_mic_play_switch,
+	&snd_sb16_ctl_mic_play_vol,
+	&snd_sb16_ctl_pc_speaker_vol,
+	&snd_sb16_ctl_capture_vol,
+	&snd_sb16_ctl_play_vol,
+	&snd_sb16_ctl_auto_mic_gain
 };
 
 #define SB16_INIT_VALUES (sizeof(snd_sb16_init_values)/sizeof(unsigned char)/2)
@@ -513,28 +584,50 @@
 	{ SB_DSP4_SPEAKER_DEV, 0 },
 };
 
-#define DT019X_CONTROLS (sizeof(snd_dt019x_controls)/sizeof(snd_kcontrol_new_t))
+#define DT019X_CONTROLS (sizeof(snd_dt019x_controls)/sizeof(snd_kcontrol_new_t *))
 
-static snd_kcontrol_new_t snd_dt019x_controls[] = {
-SB_DOUBLE("Master Playback Volume", SB_DT019X_MASTER_DEV, SB_DT019X_MASTER_DEV, 4,0, 15),
-SB_DOUBLE("PCM Playback Volume", SB_DT019X_PCM_DEV, SB_DT019X_PCM_DEV, 4,0, 15),
-SB_DOUBLE("Synth Playback Volume", SB_DT019X_SYNTH_DEV, SB_DT019X_SYNTH_DEV, 4,0, 15),
-SB_DOUBLE("CD Playback Volume", SB_DT019X_CD_DEV, SB_DT019X_CD_DEV, 4,0, 15),
-SB_SINGLE("Mic Playback Volume", SB_DT019X_MIC_DEV, 4, 7),
-SB_SINGLE("PC Speaker Volume", SB_DT019X_SPKR_DEV, 0,  7),
-SB_DOUBLE("Line Playback Volume", SB_DT019X_LINE_DEV, SB_DT019X_LINE_DEV, 4,0, 15),
-SB_SINGLE("Mic Playback Switch", SB_DT019X_OUTPUT_SW1, 0, 1),
-SB_DOUBLE("CD Playback Switch", SB_DT019X_OUTPUT_SW1, SB_DT019X_OUTPUT_SW1, 2,1, 1),
-SB_DOUBLE("Line Playback Switch", SB_DT019X_OUTPUT_SW1, SB_DT019X_OUTPUT_SW1, 4,3, 1),
-SB_DOUBLE("PCM Playback Switch", SB_DT019X_OUTPUT_SW2, SB_DT019X_OUTPUT_SW2, 2,1, 1),
-SB_DOUBLE("Synth Playback Switch", SB_DT019X_OUTPUT_SW2, SB_DT019X_OUTPUT_SW2, 4,3, 1),
-{
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "Capture Source",
-	.info = snd_dt019x_input_sw_info,
-	.get = snd_dt019x_input_sw_get,
-	.put = snd_dt019x_input_sw_put,
-},
+
+static snd_kcontrol_new_t snd_dt019x_ctl_master_play_vol =
+	SB_DOUBLE("Master Playback Volume", SB_DT019X_MASTER_DEV, SB_DT019X_MASTER_DEV, 4,0, 15);
+static snd_kcontrol_new_t snd_dt019x_ctl_pcm_play_vol =
+	SB_DOUBLE("PCM Playback Volume", SB_DT019X_PCM_DEV, SB_DT019X_PCM_DEV, 4,0, 15);
+static snd_kcontrol_new_t snd_dt019x_ctl_synth_play_vol =
+	SB_DOUBLE("Synth Playback Volume", SB_DT019X_SYNTH_DEV, SB_DT019X_SYNTH_DEV, 4,0, 15);
+static snd_kcontrol_new_t snd_dt019x_ctl_cd_play_vol =
+	SB_DOUBLE("CD Playback Volume", SB_DT019X_CD_DEV, SB_DT019X_CD_DEV, 4,0, 15);
+static snd_kcontrol_new_t snd_dt019x_ctl_mic_play_vol =
+	SB_SINGLE("Mic Playback Volume", SB_DT019X_MIC_DEV, 4, 7);
+static snd_kcontrol_new_t snd_dt019x_ctl_pc_speaker_vol =
+	SB_SINGLE("PC Speaker Volume", SB_DT019X_SPKR_DEV, 0,  7);
+static snd_kcontrol_new_t snd_dt019x_ctl_line_play_vol =
+	SB_DOUBLE("Line Playback Volume", SB_DT019X_LINE_DEV, SB_DT019X_LINE_DEV, 4,0, 15);
+static snd_kcontrol_new_t snd_dt019x_ctl_pcm_play_switch =
+	SB_DOUBLE("PCM Playback Switch", SB_DT019X_OUTPUT_SW2, SB_DT019X_OUTPUT_SW2, 2,1, 1);
+static snd_kcontrol_new_t snd_dt019x_ctl_synth_play_switch =
+	SB_DOUBLE("Synth Playback Switch", SB_DT019X_OUTPUT_SW2, SB_DT019X_OUTPUT_SW2, 4,3, 1);
+static snd_kcontrol_new_t snd_dt019x_ctl_capture_source =
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Capture Source",
+		.info = snd_dt019x_input_sw_info,
+		.get = snd_dt019x_input_sw_get,
+		.put = snd_dt019x_input_sw_put,
+	};
+
+static snd_kcontrol_new_t *snd_dt019x_controls[] = {
+	&snd_dt019x_ctl_master_play_vol,
+	&snd_dt019x_ctl_pcm_play_vol,
+	&snd_dt019x_ctl_synth_play_vol,
+	&snd_dt019x_ctl_cd_play_vol,
+	&snd_dt019x_ctl_mic_play_vol,
+	&snd_dt019x_ctl_pc_speaker_vol,
+	&snd_dt019x_ctl_line_play_vol,
+	&snd_sb16_ctl_mic_play_switch,
+	&snd_sb16_ctl_cd_play_switch,
+	&snd_sb16_ctl_line_play_switch,
+	&snd_dt019x_ctl_pcm_play_switch,
+	&snd_dt019x_ctl_synth_play_switch,
+	&snd_dt019x_ctl_capture_source
 };
 
 #define DT019X_INIT_VALUES (sizeof(snd_dt019x_init_values)/sizeof(unsigned char)/2)
@@ -546,13 +639,92 @@
         { SB_DT019X_CD_DEV, 0 },
         { SB_DT019X_MIC_DEV, 0 },	/* Includes PC-speaker in high nibble */
         { SB_DT019X_LINE_DEV, 0 },
-        { SB_DT019X_OUTPUT_SW1, 0 },
+        { SB_DSP4_OUTPUT_SW, 0 },
         { SB_DT019X_OUTPUT_SW2, 0 },
         { SB_DT019X_CAPTURE_SW, 0x06 },
 };
 
+/* FIXME: SB_ALS4000_MONO_IO_CTRL needs output select ctrl ! */
+static snd_kcontrol_new_t snd_als4000_ctl_mono_output_switch =
+	SB_SINGLE("Mono Output Switch", SB_ALS4000_MONO_IO_CTRL, 5, 1);
+/* FIXME: mono input switch also available on DT019X ? */
+static snd_kcontrol_new_t snd_als4000_ctl_mono_input_switch =
+	SB_SINGLE("Mono Input Switch", SB_DT019X_OUTPUT_SW2, 0, 1);
+static snd_kcontrol_new_t snd_als4000_ctl_mic_20db_boost =
+	SB_SINGLE("Mic Boost (+20dB)", SB_ALS4000_MIC_IN_GAIN, 0, 0x03);
+static snd_kcontrol_new_t snd_als4000_ctl_mixer_out_to_in =
+	SB_SINGLE("Mixer Out To In", SB_ALS4000_MIC_IN_GAIN, 7, 0x01);
+/* FIXME: 3D needs much more sophisticated controls, many more features ! */
+static snd_kcontrol_new_t snd_als4000_ctl_3d_output_switch =
+	SB_SINGLE("3D Output Switch", SB_ALS4000_3D_SND_FX, 6, 0x01);
+static snd_kcontrol_new_t snd_als4000_ctl_3d_output_ratio =
+	SB_SINGLE("3D Output Ratio", SB_ALS4000_3D_SND_FX, 0, 0x07);
+static snd_kcontrol_new_t snd_als4000_ctl_3d_poweroff_switch =
+	SB_SINGLE("3D PowerOff Switch", SB_ALS4000_3D_TIME_DELAY, 4, 0x01);
+static snd_kcontrol_new_t snd_als4000_ctl_3d_delay =
+	SB_SINGLE("3D Delay", SB_ALS4000_3D_TIME_DELAY, 0, 0x0f);
+#if NOT_AVAILABLE
+static snd_kcontrol_new_t snd_als4000_ctl_fmdac =
+	SB_SINGLE("FMDAC Switch (Option ?)", SB_ALS4000_FMDAC, 0, 0x01);
+static snd_kcontrol_new_t snd_als4000_ctl_qsound =
+	SB_SINGLE("QSound Mode", SB_ALS4000_QSOUND, 1, 0x1f);
+#endif
+
+#define ALS4000_CONTROLS (sizeof(snd_als4000_controls)/sizeof(snd_kcontrol_new_t *))
+
+static snd_kcontrol_new_t *snd_als4000_controls[] = {
+	&snd_sb16_ctl_master_play_vol,
+	&snd_dt019x_ctl_pcm_play_switch,
+	&snd_sb16_ctl_pcm_play_vol,
+	&snd_sb16_ctl_synth_capture_route,
+	&snd_dt019x_ctl_synth_play_switch,
+	&snd_sb16_ctl_synth_play_vol,
+	&snd_sb16_ctl_cd_capture_route,
+	&snd_sb16_ctl_cd_play_switch,
+	&snd_sb16_ctl_cd_play_vol,
+	&snd_sb16_ctl_line_capture_route,
+	&snd_sb16_ctl_line_play_switch,
+	&snd_sb16_ctl_line_play_vol,
+	&snd_sb16_ctl_mic_capture_route,
+	&snd_als4000_ctl_mic_20db_boost,
+	&snd_sb16_ctl_auto_mic_gain,
+	&snd_sb16_ctl_mic_play_switch,
+	&snd_sb16_ctl_mic_play_vol,
+	&snd_sb16_ctl_pc_speaker_vol,
+	&snd_sb16_ctl_capture_vol,
+	&snd_sb16_ctl_play_vol,
+	&snd_als4000_ctl_mono_output_switch,
+	&snd_als4000_ctl_mono_input_switch,
+	&snd_als4000_ctl_mixer_out_to_in,
+	&snd_als4000_ctl_3d_output_switch,
+	&snd_als4000_ctl_3d_output_ratio,
+	&snd_als4000_ctl_3d_delay,
+	&snd_als4000_ctl_3d_poweroff_switch,
+#if NOT_AVAILABLE
+	&snd_als4000_ctl_fmdac,
+	&snd_als4000_ctl_qsound,
+#endif
+};
+
+#define ALS4000_INIT_VALUES (sizeof(snd_als4000_init_values)/sizeof(unsigned char)/2)
+
+static unsigned char snd_als4000_init_values[][2] = {
+	{ SB_DSP4_MASTER_DEV + 0, 0 },
+	{ SB_DSP4_MASTER_DEV + 1, 0 },
+	{ SB_DSP4_PCM_DEV + 0, 0 },
+	{ SB_DSP4_PCM_DEV + 1, 0 },
+	{ SB_DSP4_SYNTH_DEV + 0, 0 },
+	{ SB_DSP4_SYNTH_DEV + 1, 0 },
+	{ SB_DSP4_SPEAKER_DEV, 0 },
+	{ SB_DSP4_OUTPUT_SW, 0 },
+	{ SB_DSP4_INPUT_LEFT, 0 },
+	{ SB_DSP4_INPUT_RIGHT, 0 },
+	{ SB_DT019X_OUTPUT_SW2, 0 },
+	{ SB_ALS4000_MIC_IN_GAIN, 0 },
+};
+
 static int snd_sbmixer_init(sb_t *chip,
-			    snd_kcontrol_new_t *controls,
+			    snd_kcontrol_new_t **controls,
 			    int controls_count,
 			    unsigned char map[][2],
 			    int map_count,
@@ -575,7 +747,7 @@
 	}
 
 	for (idx = 0; idx < controls_count; idx++) {
-		if ((err = snd_ctl_add(card, snd_ctl_new1(&controls[idx], chip))) < 0)
+		if ((err = snd_ctl_add(card, snd_ctl_new1(controls[idx], chip))) < 0)
 			return err;
 	}
 	snd_component_add(card, name);
@@ -612,11 +784,17 @@
 		break;
 	case SB_HW_16:
 	case SB_HW_ALS100:
-	case SB_HW_ALS4000:
 		if ((err = snd_sbmixer_init(chip,
 					    snd_sb16_controls, SB16_CONTROLS,
 					    snd_sb16_init_values, SB16_INIT_VALUES,
 					    "CTL1745")) < 0)
+			return err;
+		break;
+	case SB_HW_ALS4000:
+		if ((err = snd_sbmixer_init(chip,
+					    snd_als4000_controls, ALS4000_CONTROLS,
+					    snd_als4000_init_values, ALS4000_INIT_VALUES,
+					    "ALS4000")) < 0)
 			return err;
 		break;
 	case SB_HW_DT019X:
Index: alsa-kernel/pci/als4000.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/als4000.c,v
retrieving revision 1.17
diff -u -r1.17 als4000.c
--- alsa-kernel/pci/als4000.c	21 Oct 2002 18:28:23 -0000	1.17
+++ alsa-kernel/pci/als4000.c	10 Nov 2002 13:48:46 -0000
@@ -2,6 +2,7 @@
  *  card-als4000.c - driver for Avance Logic ALS4000 based soundcards.
  *  Copyright (C) 2000 by Bart Hartgers <bart@etpmod.phys.tue.nl>,
  *			  Jaroslav Kysela <perex@suse.cz>
+ *  Copyright (C) 2002 by Andreas Mohr <hw7oshyuv3001@sneakemail.com>
  *
  *  Framework borrowed from Massimo Piccioni's card-als100.c.
  *
@@ -11,6 +12,9 @@
  *  bought an ALS4000 based soundcard, I was forced to base this driver
  *  on reverse engineering.
  *
+ *  Note: this is no longer true. Pretty verbose chip docu (ALS4000a.PDF)
+ *  can be found on the ALSA web site.
+ *
  *  The ALS4000 seems to be the PCI-cousin of the ALS100. It contains an
  *  ALS100-like SB DSP/mixer, an OPL3 synth, a MPU401 and a gameport 
  *  interface. These subsystems can be mapped into ISA io-port space, 
@@ -23,11 +27,21 @@
  * 
  * The ALS4000 can do real full duplex playback/capture.
  *
- * BUGS
- *   The box suggests there is some support for 3D sound, but I did not
- *   investigate this yet.
- * 
+ * FMDAC:
+ * - 0x4f -> port 0x14
+ * - port 0x15 |= 1
+ *
+ * Enable/disable 3D sound:
+ * - 0x50 -> port 0x14
+ * - change bit 6 (0x40) of port 0x15
+ *
+ * Set QSound:
+ * - 0xdb -> port 0x14
+ * - set port 0x15:
+ *   0x3e (mode 3), 0x3c (mode 2), 0x3a (mode 1), 0x38 (mode 0)
  *
+ * Set KSound:
+ * - value -> some port 0x0c0d
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -256,11 +270,18 @@
 		count >>=1;
 	count--;
 	
+	/* FIXME: from second playback on, there's a lot more clicks and pops
+	 * involved here than on first playback. Fiddling with
+	 * tons of different settings didn't help (DMA, speaker on/off,
+	 * reordering, ...). Something seems to get enabled on playback
+	 * that I haven't found out how to disable again, which then causes
+	 * the switching pops to reach the speakers the next time here. */
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	snd_als4000_set_rate(chip, runtime->rate);
 	snd_als4000_set_playback_dma(chip, runtime->dma_addr, size);
 	
-	snd_sbdsp_command(chip, SB_DSP_SPEAKER_ON);
+	/* SPEAKER_ON not needed, since dma_on seems to also enable speaker */
+	/* snd_sbdsp_command(chip, SB_DSP_SPEAKER_ON); */
 	snd_sbdsp_command(chip, playback_cmd(chip).dsp_cmd);
 	snd_sbdsp_command(chip, playback_cmd(chip).format);
 	snd_sbdsp_command(chip, count);
@@ -359,9 +380,9 @@
 	spin_unlock_irqrestore(&chip->mixer_lock, flags);
 	
 	if (sb_status & SB_IRQTYPE_8BIT) 
-		inb(SBP(chip, DATA_AVAIL));
+		snd_sb_ack_8bit(chip);
 	if (sb_status & SB_IRQTYPE_16BIT) 
-		inb(SBP(chip, DATA_AVAIL_16));
+		snd_sb_ack_16bit(chip);
 	if (sb_status & SB_IRQTYPE_MPUIN)
 		inb(chip->mpu_port);
 	if (sb_status & 0x20)
@@ -547,14 +568,14 @@
 	spin_unlock_irqrestore(&chip->reg_lock,flags);
 }
 
-static void snd_card_als4k_free( snd_card_t *card )
+static void snd_card_als4000_free( snd_card_t *card )
 {
 	snd_card_als4000_t * acard = (snd_card_als4000_t *)card->private_data;
 	/* make sure that interrupts are disabled */
 	snd_als4000_gcr_write_addr( acard->gcr, 0x8c, 0);
 }
 
-static int __devinit snd_card_als4k_probe(struct pci_dev *pci,
+static int __devinit snd_card_als4000_probe(struct pci_dev *pci,
 					  const struct pci_device_id *pci_id)
 {
 	static int dev;
@@ -608,7 +629,7 @@
 
 	acard = (snd_card_als4000_t *)card->private_data;
 	acard->gcr = gcr;
-	card->private_free = snd_card_als4k_free;
+	card->private_free = snd_card_als4000_free;
 
 	if ((err = snd_sbdsp_create(card,
 				    gcr + 0x10,
@@ -672,7 +693,7 @@
 	return 0;
 }
 
-static void __devexit snd_card_als4k_remove(struct pci_dev *pci)
+static void __devexit snd_card_als4000_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
@@ -681,11 +702,11 @@
 static struct pci_driver driver = {
 	.name = "ALS4000",
 	.id_table = snd_als4000_ids,
-	.probe = snd_card_als4k_probe,
-	.remove = __devexit_p(snd_card_als4k_remove),
+	.probe = snd_card_als4000_probe,
+	.remove = __devexit_p(snd_card_als4000_remove),
 };
 
-static int __init alsa_card_als4k_init(void)
+static int __init alsa_card_als4000_init(void)
 {
 	int err;
 	
@@ -698,13 +719,13 @@
 	return 0;
 }
 
-static void __exit alsa_card_als4k_exit(void)
+static void __exit alsa_card_als4000_exit(void)
 {
 	pci_unregister_driver(&driver);
 }
 
-module_init(alsa_card_als4k_init)
-module_exit(alsa_card_als4k_exit)
+module_init(alsa_card_als4000_init)
+module_exit(alsa_card_als4000_exit)
 
 #ifndef MODULE
 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
