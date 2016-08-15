From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Atom: add definitions for
	modem/SSP0 interface" to the asoc tree
Date: Mon, 15 Aug 2016 15:16:03 +0100
Message-ID: <E1bZIgN-0007Q0-6K@debutante>
References: <1471037280-17433-6-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AB75026787C
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 16:16:09 +0200 (CEST)
In-Reply-To: <1471037280-17433-6-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Atom: add definitions for modem/SSP0 interface

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3d240d73df4e3a21d9c2cdc378c192760adcba13 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 12 Aug 2016 16:27:48 -0500
Subject: [PATCH] ASoC: Intel: Atom: add definitions for modem/SSP0 interface

The Atom DPCM driver only allowed for the SSP2 interface, add
definitions for modem/SSP0.

These definitions might be used to route audio to a codec
connected to SSP0 (instead of a modem in traditional usages),
but there is a restriction to 2ch I2S. SSP2 is capable of
handling up to 4 slot TDM.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst-atom-controls.c | 17 ++++++++++++++++-
 sound/soc/intel/atom/sst-atom-controls.h |  6 ++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index 98720a93de8a..28eea127ec33 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -1,4 +1,4 @@
-/*
+ /*
  *  sst-atom-controls.c - Intel MID Platform driver DPCM ALSA controls for Mrfld
  *
  *  Copyright (C) 2013-14 Intel Corp
@@ -534,6 +534,7 @@ static const DECLARE_TLV_DB_SCALE(sst_gain_tlv_common, SST_GAIN_MIN_VALUE * 10,
 
 /* Look up table to convert MIXER SW bit regs to SWM inputs */
 static const uint swm_mixer_input_ids[SST_SWM_INPUT_COUNT] = {
+	[SST_IP_MODEM]		= SST_SWM_IN_MODEM,
 	[SST_IP_CODEC0]		= SST_SWM_IN_CODEC0,
 	[SST_IP_CODEC1]		= SST_SWM_IN_CODEC1,
 	[SST_IP_LOOP0]		= SST_SWM_IN_SPROT_LOOP,
@@ -674,6 +675,7 @@ static int sst_swm_mixer_event(struct snd_soc_dapm_widget *w,
 /* SBA mixers - 16 inputs */
 #define SST_SBA_DECLARE_MIX_CONTROLS(kctl_name)							\
 	static const struct snd_kcontrol_new kctl_name[] = {					\
+		SOC_DAPM_SINGLE("modem_in Switch", SND_SOC_NOPM, SST_IP_MODEM, 1, 0),		\
 		SOC_DAPM_SINGLE("codec_in0 Switch", SND_SOC_NOPM, SST_IP_CODEC0, 1, 0),		\
 		SOC_DAPM_SINGLE("codec_in1 Switch", SND_SOC_NOPM, SST_IP_CODEC1, 1, 0),		\
 		SOC_DAPM_SINGLE("sprot_loop_in Switch", SND_SOC_NOPM, SST_IP_LOOP0, 1, 0),	\
@@ -684,6 +686,7 @@ static int sst_swm_mixer_event(struct snd_soc_dapm_widget *w,
 	}
 
 #define SST_SBA_MIXER_GRAPH_MAP(mix_name)			\
+	{ mix_name, "modem_in Switch",	"modem_in" },		\
 	{ mix_name, "codec_in0 Switch",	"codec_in0" },		\
 	{ mix_name, "codec_in1 Switch",	"codec_in1" },		\
 	{ mix_name, "sprot_loop_in Switch",	"sprot_loop_in" },	\
@@ -713,6 +716,7 @@ SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_media_l2_controls);
 SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_voip_controls);
 SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_codec0_controls);
 SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_codec1_controls);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_modem_controls);
 
 /*
  * sst_handle_vb_timer - Start/Stop the DSP scheduler
@@ -1047,8 +1051,10 @@ static int sst_set_media_loop(struct snd_soc_dapm_widget *w,
 }
 
 static const struct snd_soc_dapm_widget sst_dapm_widgets[] = {
+	SST_AIF_IN("modem_in", sst_set_be_modules),
 	SST_AIF_IN("codec_in0", sst_set_be_modules),
 	SST_AIF_IN("codec_in1", sst_set_be_modules),
+	SST_AIF_OUT("modem_out", sst_set_be_modules),
 	SST_AIF_OUT("codec_out0", sst_set_be_modules),
 	SST_AIF_OUT("codec_out1", sst_set_be_modules),
 
@@ -1103,6 +1109,9 @@ static const struct snd_soc_dapm_widget sst_dapm_widgets[] = {
 		      sst_mix_codec0_controls, sst_swm_mixer_event),
 	SST_SWM_MIXER("codec_out1 mix 0", SND_SOC_NOPM, SST_TASK_SBA, SST_SWM_OUT_CODEC1,
 		      sst_mix_codec1_controls, sst_swm_mixer_event),
+	SST_SWM_MIXER("modem_out mix 0", SND_SOC_NOPM, SST_TASK_SBA, SST_SWM_OUT_MODEM,
+		      sst_mix_modem_controls, sst_swm_mixer_event),
+
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
@@ -1148,6 +1157,9 @@ static const struct snd_soc_dapm_route intercon[] = {
 	SST_SBA_MIXER_GRAPH_MAP("codec_out0 mix 0"),
 	{"codec_out1", NULL, "codec_out1 mix 0"},
 	SST_SBA_MIXER_GRAPH_MAP("codec_out1 mix 0"),
+	{"modem_out", NULL, "modem_out mix 0"},
+	SST_SBA_MIXER_GRAPH_MAP("modem_out mix 0"),
+
 
 };
 static const char * const slot_names[] = {
@@ -1217,6 +1229,9 @@ static const struct snd_kcontrol_new sst_gain_controls[] = {
 	SST_GAIN("media_loop2_out", SST_PATH_INDEX_MEDIA_LOOP2_OUT, SST_TASK_SBA, 0, &sst_gains[13]),
 	SST_GAIN("sprot_loop_out", SST_PATH_INDEX_SPROT_LOOP_OUT, SST_TASK_SBA, 0, &sst_gains[14]),
 	SST_VOLUME("media0_in", SST_PATH_INDEX_MEDIA0_IN, SST_TASK_MMX, 0, &sst_gains[15]),
+	SST_GAIN("modem_in", SST_PATH_INDEX_MODEM_IN, SST_TASK_SBA, 0, &sst_gains[16]),
+	SST_GAIN("modem_out", SST_PATH_INDEX_MODEM_OUT, SST_TASK_SBA, 0, &sst_gains[17]),
+
 };
 
 #define SST_GAIN_NUM_CONTROLS 3
diff --git a/sound/soc/intel/atom/sst-atom-controls.h b/sound/soc/intel/atom/sst-atom-controls.h
index e0113112f668..351d81469685 100644
--- a/sound/soc/intel/atom/sst-atom-controls.h
+++ b/sound/soc/intel/atom/sst-atom-controls.h
@@ -35,6 +35,8 @@ enum {
 /* define a bit for each mixer input */
 #define SST_MIX_IP(x)		(x)
 
+#define SST_IP_MODEM		SST_MIX_IP(0)
+#define SST_IP_BT		SST_MIX_IP(1)
 #define SST_IP_CODEC0		SST_MIX_IP(2)
 #define SST_IP_CODEC1		SST_MIX_IP(3)
 #define SST_IP_LOOP0		SST_MIX_IP(4)
@@ -63,6 +65,7 @@ enum {
  * Audio DSP Path Ids. Specified by the audio DSP FW
  */
 enum sst_path_index {
+	SST_PATH_INDEX_MODEM_OUT                = (0x00 << SST_PATH_ID_SHIFT),
 	SST_PATH_INDEX_CODEC_OUT0               = (0x02 << SST_PATH_ID_SHIFT),
 	SST_PATH_INDEX_CODEC_OUT1               = (0x03 << SST_PATH_ID_SHIFT),
 
@@ -80,6 +83,7 @@ enum sst_path_index {
 
 
 	/* Start of input paths */
+	SST_PATH_INDEX_MODEM_IN                 = (0x80 << SST_PATH_ID_SHIFT),
 	SST_PATH_INDEX_CODEC_IN0                = (0x82 << SST_PATH_ID_SHIFT),
 	SST_PATH_INDEX_CODEC_IN1                = (0x83 << SST_PATH_ID_SHIFT),
 
@@ -105,6 +109,7 @@ enum sst_path_index {
  * path IDs
  */
 enum sst_swm_inputs {
+	SST_SWM_IN_MODEM	= (SST_PATH_INDEX_MODEM_IN	  | SST_DEFAULT_CELL_NBR),
 	SST_SWM_IN_CODEC0	= (SST_PATH_INDEX_CODEC_IN0	  | SST_DEFAULT_CELL_NBR),
 	SST_SWM_IN_CODEC1	= (SST_PATH_INDEX_CODEC_IN1	  | SST_DEFAULT_CELL_NBR),
 	SST_SWM_IN_SPROT_LOOP	= (SST_PATH_INDEX_SPROT_LOOP_IN	  | SST_DEFAULT_CELL_NBR),
@@ -124,6 +129,7 @@ enum sst_swm_inputs {
  * path IDs
  */
 enum sst_swm_outputs {
+	SST_SWM_OUT_MODEM	= (SST_PATH_INDEX_MODEM_OUT	  | SST_DEFAULT_CELL_NBR),
 	SST_SWM_OUT_CODEC0	= (SST_PATH_INDEX_CODEC_OUT0	  | SST_DEFAULT_CELL_NBR),
 	SST_SWM_OUT_CODEC1	= (SST_PATH_INDEX_CODEC_OUT1	  | SST_DEFAULT_CELL_NBR),
 	SST_SWM_OUT_SPROT_LOOP	= (SST_PATH_INDEX_SPROT_LOOP_OUT  | SST_DEFAULT_CELL_NBR),
-- 
2.8.1
