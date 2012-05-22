From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH 1/3] sb_mixer: Correct SB16 mixer control names
Date: Tue, 22 May 2012 21:44:47 +0200
Message-ID: <201205222144.51912.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail-1-out2.atlantis.sk [80.94.52.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 256612454A
	for <alsa-devel@alsa-project.org>;
	Tue, 22 May 2012 21:45:15 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SB16 volume controls affect both playback and recording. Correct the volume controls to match that.
(Beep volume was already correct).

Correct misleading "Capture Volume" and "Playback Volume" names - they're in fact gain controls.

Also change "3D Enhancement Switch" to standard name "3D Control - Switch".

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- a/sound/isa/sb/sb_mixer.c
+++ b/sound/isa/sb/sb_mixer.c
@@ -579,31 +579,31 @@ static struct sbmix_elem snd_sb16_controls[] = {
 		  SB_DSP4_PCM_DEV, (SB_DSP4_PCM_DEV + 1), 3, 3, 31),
 	SB16_INPUT_SW("Synth Capture Route",
 		      SB_DSP4_INPUT_LEFT, SB_DSP4_INPUT_RIGHT, 6, 5),
-	SB_DOUBLE("Synth Playback Volume",
+	SB_DOUBLE("Synth Volume",
 		  SB_DSP4_SYNTH_DEV, (SB_DSP4_SYNTH_DEV + 1), 3, 3, 31),
 	SB16_INPUT_SW("CD Capture Route",
 		      SB_DSP4_INPUT_LEFT, SB_DSP4_INPUT_RIGHT, 2, 1),
 	SB_DOUBLE("CD Playback Switch",
 		  SB_DSP4_OUTPUT_SW, SB_DSP4_OUTPUT_SW, 2, 1, 1),
-	SB_DOUBLE("CD Playback Volume",
+	SB_DOUBLE("CD Volume",
 		  SB_DSP4_CD_DEV, (SB_DSP4_CD_DEV + 1), 3, 3, 31),
 	SB16_INPUT_SW("Mic Capture Route",
 		      SB_DSP4_INPUT_LEFT, SB_DSP4_INPUT_RIGHT, 0, 0),
 	SB_SINGLE("Mic Playback Switch", SB_DSP4_OUTPUT_SW, 0, 1),
-	SB_SINGLE("Mic Playback Volume", SB_DSP4_MIC_DEV, 3, 31),
+	SB_SINGLE("Mic Volume", SB_DSP4_MIC_DEV, 3, 31),
 	SB_SINGLE("Beep Volume", SB_DSP4_SPEAKER_DEV, 6, 3),
-	SB_DOUBLE("Capture Volume",
+	SB_DOUBLE("Gain Capture Volume",
 		  SB_DSP4_IGAIN_DEV, (SB_DSP4_IGAIN_DEV + 1), 6, 6, 3),
-	SB_DOUBLE("Playback Volume",
+	SB_DOUBLE("Gain Playback Volume",
 		  SB_DSP4_OGAIN_DEV, (SB_DSP4_OGAIN_DEV + 1), 6, 6, 3),
 	SB16_INPUT_SW("Line Capture Route",
 		      SB_DSP4_INPUT_LEFT, SB_DSP4_INPUT_RIGHT, 4, 3),
 	SB_DOUBLE("Line Playback Switch",
 		  SB_DSP4_OUTPUT_SW, SB_DSP4_OUTPUT_SW, 4, 3, 1),
-	SB_DOUBLE("Line Playback Volume",
+	SB_DOUBLE("Line Volume",
 		  SB_DSP4_LINE_DEV, (SB_DSP4_LINE_DEV + 1), 3, 3, 31),
 	SB_SINGLE("Mic Auto Gain", SB_DSP4_MIC_AGC, 0, 1),
-	SB_SINGLE("3D Enhancement Switch", SB_DSP4_3DSE, 0, 1),
+	SB_SINGLE("3D Control - Switch", SB_DSP4_3DSE, 0, 1),
 	SB_DOUBLE("Tone Control - Bass",
 		  SB_DSP4_BASS_DEV, (SB_DSP4_BASS_DEV + 1), 4, 4, 15),
 	SB_DOUBLE("Tone Control - Treble",

-- 
Ondrej Zary
