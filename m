From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] sb_mixer: convert pointer tables to mixer
	control tables
Date: Sun, 13 Dec 2009 21:13:44 +0100
Message-ID: <20091213211344.7a820cea.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F1EA10381C
	for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2009 21:11:42 +0100 (CET)
Received: from poczta.interia.pl (mi06.poczta.interia.pl [10.217.12.6])
	by smtp240.poczta.interia.pl (INTERIA.PL) with ESMTP id 30C43270396
	for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2009 21:11:38 +0100 (CET)
Received: from krzysio.net (93-181-133-4.as.kn.pl [93.181.133.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 2AAB01324D2
	for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2009 21:11:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Convert table of pointers to mixer controls into tables
of the mixer controls. It saves about 20% of the snd-sb-common
module size reported by lsmod.

The als4000 uses part of sb16's control table.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/sb/sb_mixer.c |  330 ++++++++++++++++------------------------------
 1 files changed, 115 insertions(+), 215 deletions(-)

diff --git a/sound/isa/sb/sb_mixer.c b/sound/isa/sb/sb_mixer.c
index 318ff0c..8cfc41f 100644
--- a/sound/isa/sb/sb_mixer.c
+++ b/sound/isa/sb/sb_mixer.c
@@ -528,20 +528,11 @@ int snd_sbmixer_add_ctl(struct snd_sb *chip, const char *name, int index, int ty
  * SB 2.0 specific mixer elements
  */
 
-static struct sbmix_elem snd_sb20_ctl_master_play_vol =
-	SB_SINGLE("Master Playback Volume", SB_DSP20_MASTER_DEV, 1, 7);
-static struct sbmix_elem snd_sb20_ctl_pcm_play_vol =
-	SB_SINGLE("PCM Playback Volume", SB_DSP20_PCM_DEV, 1, 3);
-static struct sbmix_elem snd_sb20_ctl_synth_play_vol =
-	SB_SINGLE("Synth Playback Volume", SB_DSP20_FM_DEV, 1, 7);
-static struct sbmix_elem snd_sb20_ctl_cd_play_vol =
-	SB_SINGLE("CD Playback Volume", SB_DSP20_CD_DEV, 1, 7);
-
-static struct sbmix_elem *snd_sb20_controls[] = {
-	&snd_sb20_ctl_master_play_vol,
-	&snd_sb20_ctl_pcm_play_vol,
-	&snd_sb20_ctl_synth_play_vol,
-	&snd_sb20_ctl_cd_play_vol
+static struct sbmix_elem snd_sb20_controls[] = {
+	SB_SINGLE("Master Playback Volume", SB_DSP20_MASTER_DEV, 1, 7),
+	SB_SINGLE("PCM Playback Volume", SB_DSP20_PCM_DEV, 1, 3),
+	SB_SINGLE("Synth Playback Volume", SB_DSP20_FM_DEV, 1, 7),
+	SB_SINGLE("CD Playback Volume", SB_DSP20_CD_DEV, 1, 7)
 };
 
 static unsigned char snd_sb20_init_values[][2] = {
@@ -552,41 +543,24 @@ static unsigned char snd_sb20_init_values[][2] = {
 /*
  * SB Pro specific mixer elements
  */
-static struct sbmix_elem snd_sbpro_ctl_master_play_vol =
-	SB_DOUBLE("Master Playback Volume", SB_DSP_MASTER_DEV, SB_DSP_MASTER_DEV, 5, 1, 7);
-static struct sbmix_elem snd_sbpro_ctl_pcm_play_vol =
-	SB_DOUBLE("PCM Playback Volume", SB_DSP_PCM_DEV, SB_DSP_PCM_DEV, 5, 1, 7);
-static struct sbmix_elem snd_sbpro_ctl_pcm_play_filter =
-	SB_SINGLE("PCM Playback Filter", SB_DSP_PLAYBACK_FILT, 5, 1);
-static struct sbmix_elem snd_sbpro_ctl_synth_play_vol =
-	SB_DOUBLE("Synth Playback Volume", SB_DSP_FM_DEV, SB_DSP_FM_DEV, 5, 1, 7);
-static struct sbmix_elem snd_sbpro_ctl_cd_play_vol =
-	SB_DOUBLE("CD Playback Volume", SB_DSP_CD_DEV, SB_DSP_CD_DEV, 5, 1, 7);
-static struct sbmix_elem snd_sbpro_ctl_line_play_vol =
-	SB_DOUBLE("Line Playback Volume", SB_DSP_LINE_DEV, SB_DSP_LINE_DEV, 5, 1, 7);
-static struct sbmix_elem snd_sbpro_ctl_mic_play_vol =
-	SB_SINGLE("Mic Playback Volume", SB_DSP_MIC_DEV, 1, 3);
-static struct sbmix_elem snd_sbpro_ctl_capture_source =
+static struct sbmix_elem snd_sbpro_controls[] = {
+	SB_DOUBLE("Master Playback Volume",
+		  SB_DSP_MASTER_DEV, SB_DSP_MASTER_DEV, 5, 1, 7),
+	SB_DOUBLE("PCM Playback Volume",
+		  SB_DSP_PCM_DEV, SB_DSP_PCM_DEV, 5, 1, 7),
+	SB_SINGLE("PCM Playback Filter", SB_DSP_PLAYBACK_FILT, 5, 1),
+	SB_DOUBLE("Synth Playback Volume",
+		  SB_DSP_FM_DEV, SB_DSP_FM_DEV, 5, 1, 7),
+	SB_DOUBLE("CD Playback Volume", SB_DSP_CD_DEV, SB_DSP_CD_DEV, 5, 1, 7),
+	SB_DOUBLE("Line Playback Volume",
+		  SB_DSP_LINE_DEV, SB_DSP_LINE_DEV, 5, 1, 7),
+	SB_SINGLE("Mic Playback Volume", SB_DSP_MIC_DEV, 1, 3),
 	{
 		.name = "Capture Source",
 		.type = SB_MIX_CAPTURE_PRO
-	};
-static struct sbmix_elem snd_sbpro_ctl_capture_filter =
-	SB_SINGLE("Capture Filter", SB_DSP_CAPTURE_FILT, 5, 1);
-static struct sbmix_elem snd_sbpro_ctl_capture_low_filter =
-	SB_SINGLE("Capture Low-Pass Filter", SB_DSP_CAPTURE_FILT, 3, 1);
-
-static struct sbmix_elem *snd_sbpro_controls[] = {
-	&snd_sbpro_ctl_master_play_vol,
-	&snd_sbpro_ctl_pcm_play_vol,
-	&snd_sbpro_ctl_pcm_play_filter,
-	&snd_sbpro_ctl_synth_play_vol,
-	&snd_sbpro_ctl_cd_play_vol,
-	&snd_sbpro_ctl_line_play_vol,
-	&snd_sbpro_ctl_mic_play_vol,
-	&snd_sbpro_ctl_capture_source,
-	&snd_sbpro_ctl_capture_filter,
-	&snd_sbpro_ctl_capture_low_filter
+	},
+	SB_SINGLE("Capture Filter", SB_DSP_CAPTURE_FILT, 5, 1),
+	SB_SINGLE("Capture Low-Pass Filter", SB_DSP_CAPTURE_FILT, 3, 1)
 };
 
 static unsigned char snd_sbpro_init_values[][2] = {
@@ -598,68 +572,42 @@ static unsigned char snd_sbpro_init_values[][2] = {
 /*
  * SB16 specific mixer elements
  */
-static struct sbmix_elem snd_sb16_ctl_master_play_vol =
-	SB_DOUBLE("Master Playback Volume", SB_DSP4_MASTER_DEV, (SB_DSP4_MASTER_DEV + 1), 3, 3, 31);
-static struct sbmix_elem snd_sb16_ctl_3d_enhance_switch =
-	SB_SINGLE("3D Enhancement Switch", SB_DSP4_3DSE, 0, 1);
-static struct sbmix_elem snd_sb16_ctl_tone_bass =
-	SB_DOUBLE("Tone Control - Bass", SB_DSP4_BASS_DEV, (SB_DSP4_BASS_DEV + 1), 4, 4, 15);
-static struct sbmix_elem snd_sb16_ctl_tone_treble =
-	SB_DOUBLE("Tone Control - Treble", SB_DSP4_TREBLE_DEV, (SB_DSP4_TREBLE_DEV + 1), 4, 4, 15);
-static struct sbmix_elem snd_sb16_ctl_pcm_play_vol =
-	SB_DOUBLE("PCM Playback Volume", SB_DSP4_PCM_DEV, (SB_DSP4_PCM_DEV + 1), 3, 3, 31);
-static struct sbmix_elem snd_sb16_ctl_synth_capture_route =
-	SB16_INPUT_SW("Synth Capture Route", SB_DSP4_INPUT_LEFT, SB_DSP4_INPUT_RIGHT, 6, 5);
-static struct sbmix_elem snd_sb16_ctl_synth_play_vol =
-	SB_DOUBLE("Synth Playback Volume", SB_DSP4_SYNTH_DEV, (SB_DSP4_SYNTH_DEV + 1), 3, 3, 31);
-static struct sbmix_elem snd_sb16_ctl_cd_capture_route =
-	SB16_INPUT_SW("CD Capture Route", SB_DSP4_INPUT_LEFT, SB_DSP4_INPUT_RIGHT, 2, 1);
-static struct sbmix_elem snd_sb16_ctl_cd_play_switch =
-	SB_DOUBLE("CD Playback Switch", SB_DSP4_OUTPUT_SW, SB_DSP4_OUTPUT_SW, 2, 1, 1);
-static struct sbmix_elem snd_sb16_ctl_cd_play_vol =
-	SB_DOUBLE("CD Playback Volume", SB_DSP4_CD_DEV, (SB_DSP4_CD_DEV + 1), 3, 3, 31);
-static struct sbmix_elem snd_sb16_ctl_line_capture_route =
-	SB16_INPUT_SW("Line Capture Route", SB_DSP4_INPUT_LEFT, SB_DSP4_INPUT_RIGHT, 4, 3);
-static struct sbmix_elem snd_sb16_ctl_line_play_switch =
-	SB_DOUBLE("Line Playback Switch", SB_DSP4_OUTPUT_SW, SB_DSP4_OUTPUT_SW, 4, 3, 1);
-static struct sbmix_elem snd_sb16_ctl_line_play_vol =
-	SB_DOUBLE("Line Playback Volume", SB_DSP4_LINE_DEV, (SB_DSP4_LINE_DEV + 1), 3, 3, 31);
-static struct sbmix_elem snd_sb16_ctl_mic_capture_route =
-	SB16_INPUT_SW("Mic Capture Route", SB_DSP4_INPUT_LEFT, SB_DSP4_INPUT_RIGHT, 0, 0);
-static struct sbmix_elem snd_sb16_ctl_mic_play_switch =
-	SB_SINGLE("Mic Playback Switch", SB_DSP4_OUTPUT_SW, 0, 1);
-static struct sbmix_elem snd_sb16_ctl_mic_play_vol =
-	SB_SINGLE("Mic Playback Volume", SB_DSP4_MIC_DEV, 3, 31);
-static struct sbmix_elem snd_sb16_ctl_pc_speaker_vol =
-	SB_SINGLE("Beep Volume", SB_DSP4_SPEAKER_DEV, 6, 3);
-static struct sbmix_elem snd_sb16_ctl_capture_vol =
-	SB_DOUBLE("Capture Volume", SB_DSP4_IGAIN_DEV, (SB_DSP4_IGAIN_DEV + 1), 6, 6, 3);
-static struct sbmix_elem snd_sb16_ctl_play_vol =
-	SB_DOUBLE("Playback Volume", SB_DSP4_OGAIN_DEV, (SB_DSP4_OGAIN_DEV + 1), 6, 6, 3);
-static struct sbmix_elem snd_sb16_ctl_auto_mic_gain =
-	SB_SINGLE("Mic Auto Gain", SB_DSP4_MIC_AGC, 0, 1);
-
-static struct sbmix_elem *snd_sb16_controls[] = {
-	&snd_sb16_ctl_master_play_vol,
-	&snd_sb16_ctl_3d_enhance_switch,
-	&snd_sb16_ctl_tone_bass,
-	&snd_sb16_ctl_tone_treble,
-	&snd_sb16_ctl_pcm_play_vol,
-	&snd_sb16_ctl_synth_capture_route,
-	&snd_sb16_ctl_synth_play_vol,
-	&snd_sb16_ctl_cd_capture_route,
-	&snd_sb16_ctl_cd_play_switch,
-	&snd_sb16_ctl_cd_play_vol,
-	&snd_sb16_ctl_line_capture_route,
-	&snd_sb16_ctl_line_play_switch,
-	&snd_sb16_ctl_line_play_vol,
-	&snd_sb16_ctl_mic_capture_route,
-	&snd_sb16_ctl_mic_play_switch,
-	&snd_sb16_ctl_mic_play_vol,
-	&snd_sb16_ctl_pc_speaker_vol,
-	&snd_sb16_ctl_capture_vol,
-	&snd_sb16_ctl_play_vol,
-	&snd_sb16_ctl_auto_mic_gain
+static struct sbmix_elem snd_sb16_controls[] = {
+	SB_DOUBLE("Master Playback Volume",
+		  SB_DSP4_MASTER_DEV, (SB_DSP4_MASTER_DEV + 1), 3, 3, 31),
+	SB_DOUBLE("PCM Playback Volume",
+		  SB_DSP4_PCM_DEV, (SB_DSP4_PCM_DEV + 1), 3, 3, 31),
+	SB16_INPUT_SW("Synth Capture Route",
+		      SB_DSP4_INPUT_LEFT, SB_DSP4_INPUT_RIGHT, 6, 5),
+	SB_DOUBLE("Synth Playback Volume",
+		  SB_DSP4_SYNTH_DEV, (SB_DSP4_SYNTH_DEV + 1), 3, 3, 31),
+	SB16_INPUT_SW("CD Capture Route",
+		      SB_DSP4_INPUT_LEFT, SB_DSP4_INPUT_RIGHT, 2, 1),
+	SB_DOUBLE("CD Playback Switch",
+		  SB_DSP4_OUTPUT_SW, SB_DSP4_OUTPUT_SW, 2, 1, 1),
+	SB_DOUBLE("CD Playback Volume",
+		  SB_DSP4_CD_DEV, (SB_DSP4_CD_DEV + 1), 3, 3, 31),
+	SB16_INPUT_SW("Mic Capture Route",
+		      SB_DSP4_INPUT_LEFT, SB_DSP4_INPUT_RIGHT, 0, 0),
+	SB_SINGLE("Mic Playback Switch", SB_DSP4_OUTPUT_SW, 0, 1),
+	SB_SINGLE("Mic Playback Volume", SB_DSP4_MIC_DEV, 3, 31),
+	SB_SINGLE("Beep Volume", SB_DSP4_SPEAKER_DEV, 6, 3),
+	SB_DOUBLE("Capture Volume",
+		  SB_DSP4_IGAIN_DEV, (SB_DSP4_IGAIN_DEV + 1), 6, 6, 3),
+	SB_DOUBLE("Playback Volume",
+		  SB_DSP4_OGAIN_DEV, (SB_DSP4_OGAIN_DEV + 1), 6, 6, 3),
+	SB16_INPUT_SW("Line Capture Route",
+		      SB_DSP4_INPUT_LEFT, SB_DSP4_INPUT_RIGHT, 4, 3),
+	SB_DOUBLE("Line Playback Switch",
+		  SB_DSP4_OUTPUT_SW, SB_DSP4_OUTPUT_SW, 4, 3, 1),
+	SB_DOUBLE("Line Playback Volume",
+		  SB_DSP4_LINE_DEV, (SB_DSP4_LINE_DEV + 1), 3, 3, 31),
+	SB_SINGLE("Mic Auto Gain", SB_DSP4_MIC_AGC, 0, 1),
+	SB_SINGLE("3D Enhancement Switch", SB_DSP4_3DSE, 0, 1),
+	SB_DOUBLE("Tone Control - Bass",
+		  SB_DSP4_BASS_DEV, (SB_DSP4_BASS_DEV + 1), 4, 4, 15),
+	SB_DOUBLE("Tone Control - Treble",
+		  SB_DSP4_TREBLE_DEV, (SB_DSP4_TREBLE_DEV + 1), 4, 4, 15)
 };
 
 static unsigned char snd_sb16_init_values[][2] = {
@@ -678,46 +626,34 @@ static unsigned char snd_sb16_init_values[][2] = {
 /*
  * DT019x specific mixer elements
  */
-static struct sbmix_elem snd_dt019x_ctl_master_play_vol =
-	SB_DOUBLE("Master Playback Volume", SB_DT019X_MASTER_DEV, SB_DT019X_MASTER_DEV, 4,0, 15);
-static struct sbmix_elem snd_dt019x_ctl_pcm_play_vol =
-	SB_DOUBLE("PCM Playback Volume", SB_DT019X_PCM_DEV, SB_DT019X_PCM_DEV, 4,0, 15);
-static struct sbmix_elem snd_dt019x_ctl_synth_play_vol =
-	SB_DOUBLE("Synth Playback Volume", SB_DT019X_SYNTH_DEV, SB_DT019X_SYNTH_DEV, 4,0, 15);
-static struct sbmix_elem snd_dt019x_ctl_cd_play_vol =
-	SB_DOUBLE("CD Playback Volume", SB_DT019X_CD_DEV, SB_DT019X_CD_DEV, 4,0, 15);
-static struct sbmix_elem snd_dt019x_ctl_mic_play_vol =
-	SB_SINGLE("Mic Playback Volume", SB_DT019X_MIC_DEV, 4, 7);
-static struct sbmix_elem snd_dt019x_ctl_pc_speaker_vol =
-	SB_SINGLE("Beep Volume", SB_DT019X_SPKR_DEV, 0,  7);
-static struct sbmix_elem snd_dt019x_ctl_line_play_vol =
-	SB_DOUBLE("Line Playback Volume", SB_DT019X_LINE_DEV, SB_DT019X_LINE_DEV, 4,0, 15);
-static struct sbmix_elem snd_dt019x_ctl_pcm_play_switch =
-	SB_DOUBLE("PCM Playback Switch", SB_DT019X_OUTPUT_SW2, SB_DT019X_OUTPUT_SW2, 2,1, 1);
-static struct sbmix_elem snd_dt019x_ctl_synth_play_switch =
-	SB_DOUBLE("Synth Playback Switch", SB_DT019X_OUTPUT_SW2, SB_DT019X_OUTPUT_SW2, 4,3, 1);
-static struct sbmix_elem snd_dt019x_ctl_capture_source =
+static struct sbmix_elem snd_dt019x_controls[] = {
+	/* ALS4000 below has some parts which we might be lacking,
+	 * e.g. snd_als4000_ctl_mono_playback_switch - check it! */
+	SB_DOUBLE("Master Playback Volume",
+		  SB_DT019X_MASTER_DEV, SB_DT019X_MASTER_DEV, 4, 0, 15),
+	SB_DOUBLE("PCM Playback Switch",
+		  SB_DT019X_OUTPUT_SW2, SB_DT019X_OUTPUT_SW2, 2, 1, 1),
+	SB_DOUBLE("PCM Playback Volume",
+		  SB_DT019X_PCM_DEV, SB_DT019X_PCM_DEV, 4, 0, 15),
+	SB_DOUBLE("Synth Playback Switch",
+		  SB_DT019X_OUTPUT_SW2, SB_DT019X_OUTPUT_SW2, 4, 3, 1),
+	SB_DOUBLE("Synth Playback Volume",
+		  SB_DT019X_SYNTH_DEV, SB_DT019X_SYNTH_DEV, 4, 0, 15),
+	SB_DOUBLE("CD Playback Switch",
+		  SB_DSP4_OUTPUT_SW, SB_DSP4_OUTPUT_SW, 2, 1, 1),
+	SB_DOUBLE("CD Playback Volume",
+		  SB_DT019X_CD_DEV, SB_DT019X_CD_DEV, 4, 0, 15),
+	SB_SINGLE("Mic Playback Switch", SB_DSP4_OUTPUT_SW, 0, 1),
+	SB_SINGLE("Mic Playback Volume", SB_DT019X_MIC_DEV, 4, 7),
+	SB_SINGLE("Beep Volume", SB_DT019X_SPKR_DEV, 0,  7),
+	SB_DOUBLE("Line Playback Switch",
+		  SB_DSP4_OUTPUT_SW, SB_DSP4_OUTPUT_SW, 4, 3, 1),
+	SB_DOUBLE("Line Playback Volume",
+		  SB_DT019X_LINE_DEV, SB_DT019X_LINE_DEV, 4, 0, 15),
 	{
 		.name = "Capture Source",
 		.type = SB_MIX_CAPTURE_DT019X
-	};
-
-static struct sbmix_elem *snd_dt019x_controls[] = {
-	/* ALS4000 below has some parts which we might be lacking,
-	 * e.g. snd_als4000_ctl_mono_playback_switch - check it! */
-	&snd_dt019x_ctl_master_play_vol,
-	&snd_dt019x_ctl_pcm_play_vol,
-	&snd_dt019x_ctl_synth_play_vol,
-	&snd_dt019x_ctl_cd_play_vol,
-	&snd_dt019x_ctl_mic_play_vol,
-	&snd_dt019x_ctl_pc_speaker_vol,
-	&snd_dt019x_ctl_line_play_vol,
-	&snd_sb16_ctl_mic_play_switch,
-	&snd_sb16_ctl_cd_play_switch,
-	&snd_sb16_ctl_line_play_switch,
-	&snd_dt019x_ctl_pcm_play_switch,
-	&snd_dt019x_ctl_synth_play_switch,
-	&snd_dt019x_ctl_capture_source
+	}
 };
 
 static unsigned char snd_dt019x_init_values[][2] = {
@@ -735,82 +671,37 @@ static unsigned char snd_dt019x_init_values[][2] = {
 /*
  * ALS4000 specific mixer elements
  */
-static struct sbmix_elem snd_als4000_ctl_master_mono_playback_switch =
-	SB_SINGLE("Master Mono Playback Switch", SB_ALS4000_MONO_IO_CTRL, 5, 1);
-static struct sbmix_elem snd_als4k_ctl_master_mono_capture_route = {
+static struct sbmix_elem snd_als4000_controls[] = {
+	SB_DOUBLE("PCM Playback Switch",
+		  SB_DT019X_OUTPUT_SW2, SB_DT019X_OUTPUT_SW2, 2, 1, 1),
+	SB_DOUBLE("Synth Playback Switch",
+		  SB_DT019X_OUTPUT_SW2, SB_DT019X_OUTPUT_SW2, 4, 3, 1),
+	SB_SINGLE("Mic Boost (+20dB)", SB_ALS4000_MIC_IN_GAIN, 0, 0x03),
+	SB_SINGLE("Master Mono Playback Switch", SB_ALS4000_MONO_IO_CTRL, 5, 1),
+	{
 		.name = "Master Mono Capture Route",
 		.type = SB_MIX_MONO_CAPTURE_ALS4K
-	};
-static struct sbmix_elem snd_als4000_ctl_mono_playback_switch =
-	SB_SINGLE("Mono Playback Switch", SB_DT019X_OUTPUT_SW2, 0, 1);
-static struct sbmix_elem snd_als4000_ctl_mic_20db_boost =
-	SB_SINGLE("Mic Boost (+20dB)", SB_ALS4000_MIC_IN_GAIN, 0, 0x03);
-static struct sbmix_elem snd_als4000_ctl_mixer_analog_loopback =
-	SB_SINGLE("Analog Loopback Switch", SB_ALS4000_MIC_IN_GAIN, 7, 0x01);
-static struct sbmix_elem snd_als4000_ctl_mixer_digital_loopback =
+	},
+	SB_SINGLE("Mono Playback Switch", SB_DT019X_OUTPUT_SW2, 0, 1),
+	SB_SINGLE("Analog Loopback Switch", SB_ALS4000_MIC_IN_GAIN, 7, 0x01),
+	SB_SINGLE("3D Control - Switch", SB_ALS4000_3D_SND_FX, 6, 0x01),
 	SB_SINGLE("Digital Loopback Switch",
-		  SB_ALS4000_CR3_CONFIGURATION, 7, 0x01);
-/* FIXME: functionality of 3D controls might be swapped, I didn't find
- * a description of how to identify what is supposed to be what */
-static struct sbmix_elem snd_als4000_3d_control_switch =
-	SB_SINGLE("3D Control - Switch", SB_ALS4000_3D_SND_FX, 6, 0x01);
-static struct sbmix_elem snd_als4000_3d_control_ratio =
-	SB_SINGLE("3D Control - Level", SB_ALS4000_3D_SND_FX, 0, 0x07);
-static struct sbmix_elem snd_als4000_3d_control_freq =
+		  SB_ALS4000_CR3_CONFIGURATION, 7, 0x01),
+	/* FIXME: functionality of 3D controls might be swapped, I didn't find
+	 * a description of how to identify what is supposed to be what */
+	SB_SINGLE("3D Control - Level", SB_ALS4000_3D_SND_FX, 0, 0x07),
 	/* FIXME: maybe there's actually some standard 3D ctrl name for it?? */
-	SB_SINGLE("3D Control - Freq", SB_ALS4000_3D_SND_FX, 4, 0x03);
-static struct sbmix_elem snd_als4000_3d_control_delay =
+	SB_SINGLE("3D Control - Freq", SB_ALS4000_3D_SND_FX, 4, 0x03),
 	/* FIXME: ALS4000a.pdf mentions BBD (Bucket Brigade Device) time delay,
 	 * but what ALSA 3D attribute is that actually? "Center", "Depth",
 	 * "Wide" or "Space" or even "Level"? Assuming "Wide" for now... */
-	SB_SINGLE("3D Control - Wide", SB_ALS4000_3D_TIME_DELAY, 0, 0x0f);
-static struct sbmix_elem snd_als4000_3d_control_poweroff_switch =
-	SB_SINGLE("3D PowerOff Switch", SB_ALS4000_3D_TIME_DELAY, 4, 0x01);
-static struct sbmix_elem snd_als4000_ctl_3db_freq_control_switch =
+	SB_SINGLE("3D Control - Wide", SB_ALS4000_3D_TIME_DELAY, 0, 0x0f),
+	SB_SINGLE("3D PowerOff Switch", SB_ALS4000_3D_TIME_DELAY, 4, 0x01),
 	SB_SINGLE("Master Playback 8kHz / 20kHz LPF Switch",
-		  SB_ALS4000_FMDAC, 5, 0x01);
+		  SB_ALS4000_FMDAC, 5, 0x01),
 #ifdef NOT_AVAILABLE
-static struct sbmix_elem snd_als4000_ctl_fmdac =
-	SB_SINGLE("FMDAC Switch (Option ?)", SB_ALS4000_FMDAC, 0, 0x01);
-static struct sbmix_elem snd_als4000_ctl_qsound =
-	SB_SINGLE("QSound Mode", SB_ALS4000_QSOUND, 1, 0x1f);
-#endif
-
-static struct sbmix_elem *snd_als4000_controls[] = {
-						/* ALS4000a.PDF regs page */
-	&snd_sb16_ctl_master_play_vol,		/* MX30/31 12 */
-	&snd_dt019x_ctl_pcm_play_switch,	/* MX4C    16 */
-	&snd_sb16_ctl_pcm_play_vol,		/* MX32/33 12 */
-	&snd_sb16_ctl_synth_capture_route,	/* MX3D/3E 14 */
-	&snd_dt019x_ctl_synth_play_switch,	/* MX4C    16 */
-	&snd_sb16_ctl_synth_play_vol,		/* MX34/35 12/13 */
-	&snd_sb16_ctl_cd_capture_route,		/* MX3D/3E 14 */
-	&snd_sb16_ctl_cd_play_switch,		/* MX3C    14 */
-	&snd_sb16_ctl_cd_play_vol,		/* MX36/37 13 */
-	&snd_sb16_ctl_line_capture_route,	/* MX3D/3E 14 */
-	&snd_sb16_ctl_line_play_switch,		/* MX3C    14 */
-	&snd_sb16_ctl_line_play_vol,		/* MX38/39 13 */
-	&snd_sb16_ctl_mic_capture_route,	/* MX3D/3E 14 */
-	&snd_als4000_ctl_mic_20db_boost,	/* MX4D    16 */
-	&snd_sb16_ctl_mic_play_switch,		/* MX3C    14 */
-	&snd_sb16_ctl_mic_play_vol,		/* MX3A    13 */
-	&snd_sb16_ctl_pc_speaker_vol,		/* MX3B    14 */
-	&snd_sb16_ctl_capture_vol,		/* MX3F/40 15 */
-	&snd_sb16_ctl_play_vol,			/* MX41/42 15 */
-	&snd_als4000_ctl_master_mono_playback_switch, /* MX4C 16 */
-	&snd_als4k_ctl_master_mono_capture_route, /* MX4B  16 */
-	&snd_als4000_ctl_mono_playback_switch,	/* MX4C    16 */
-	&snd_als4000_ctl_mixer_analog_loopback, /* MX4D    16 */
-	&snd_als4000_ctl_mixer_digital_loopback, /* CR3    21 */
-	&snd_als4000_3d_control_switch,		 /* MX50   17 */
-	&snd_als4000_3d_control_ratio,		 /* MX50   17 */
-	&snd_als4000_3d_control_freq,		 /* MX50   17 */
-	&snd_als4000_3d_control_delay,		 /* MX51   18 */
-	&snd_als4000_3d_control_poweroff_switch,	/* MX51    18 */
-	&snd_als4000_ctl_3db_freq_control_switch,	/* MX4F    17 */
-#ifdef NOT_AVAILABLE
-	&snd_als4000_ctl_fmdac,
-	&snd_als4000_ctl_qsound,
+	SB_SINGLE("FMDAC Switch (Option ?)", SB_ALS4000_FMDAC, 0, 0x01),
+	SB_SINGLE("QSound Mode", SB_ALS4000_QSOUND, 1, 0x1f),
 #endif
 };
 
@@ -829,11 +720,10 @@ static unsigned char snd_als4000_init_values[][2] = {
 	{ SB_ALS4000_MIC_IN_GAIN, 0 },
 };
 
-
 /*
  */
 static int snd_sbmixer_init(struct snd_sb *chip,
-			    struct sbmix_elem **controls,
+			    struct sbmix_elem *controls,
 			    int controls_count,
 			    unsigned char map[][2],
 			    int map_count,
@@ -856,7 +746,8 @@ static int snd_sbmixer_init(struct snd_sb *chip,
 	}
 
 	for (idx = 0; idx < controls_count; idx++) {
-		if ((err = snd_sbmixer_add_ctl_elem(chip, controls[idx])) < 0)
+		err = snd_sbmixer_add_ctl_elem(chip, &controls[idx]);
+		if (err < 0)
 			return err;
 	}
 	snd_component_add(card, name);
@@ -908,6 +799,15 @@ int snd_sbmixer_new(struct snd_sb *chip)
 			return err;
 		break;
 	case SB_HW_ALS4000:
+		/* use only the first 16 controls from SB16 */
+		err = snd_sbmixer_init(chip,
+					snd_sb16_controls,
+					16,
+					snd_sb16_init_values,
+					ARRAY_SIZE(snd_sb16_init_values),
+					"ALS4000");
+		if (err < 0)
+			return err;
 		if ((err = snd_sbmixer_init(chip,
 					    snd_als4000_controls,
 					    ARRAY_SIZE(snd_als4000_controls),
-- 
1.6.4


----------------------------------------------------------------------
Wybierz samochod roku i wygraj!
Sprawdz >>> http://link.interia.pl/f24e6
