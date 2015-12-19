From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoc: Intel: Atom: add deep buffer
	definitions for atom platforms" to the asoc tree
Date: Sat, 19 Dec 2015 11:51:30 +0000
Message-ID: <E1aAG2t-0004eU-07@debutante>
References: <1450406156-22246-8-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 820E32606BC
 for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2015 12:51:36 +0100 (CET)
In-Reply-To: <1450406156-22246-8-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoc: Intel: Atom: add deep buffer definitions for atom platforms

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

>From 8788f83929ca1dbfa640ac17aec78b2e36cf493d Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 17 Dec 2015 20:35:44 -0600
Subject: [PATCH] ASoc: Intel: Atom: add deep buffer definitions for atom
 platforms

Add definitions for MERR_DPCM_DEEP_BUFFER AND PIPE_MEDIA3_IN
Add relevant cpu-dai and dai link names

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/x86/include/asm/platform_sst_audio.h    |  1 +
 sound/soc/intel/atom/sst-atom-controls.c     |  1 +
 sound/soc/intel/atom/sst-atom-controls.h     |  1 +
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 12 ++++++++++++
 4 files changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/platform_sst_audio.h b/arch/x86/include/asm/platform_sst_audio.h
index 7249e6d0902d..5973a2f3db3d 100644
--- a/arch/x86/include/asm/platform_sst_audio.h
+++ b/arch/x86/include/asm/platform_sst_audio.h
@@ -55,6 +55,7 @@ enum sst_audio_device_id_mrfld {
 	PIPE_MEDIA0_IN = 0x8F,
 	PIPE_MEDIA1_IN = 0x90,
 	PIPE_MEDIA2_IN = 0x91,
+	PIPE_MEDIA3_IN = 0x9C,
 	PIPE_RSVD = 0xFF,
 };
 
diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index d55388e082e1..1727cc4c7f8a 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -1109,6 +1109,7 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"media0_in", NULL, "Compress Playback"},
 	{"media1_in", NULL, "Headset Playback"},
 	{"media2_in", NULL, "pcm0_out"},
+	{"media3_in", NULL, "Deepbuffer Playback"},
 
 	{"media0_out mix 0", "media0_in Switch", "media0_in"},
 	{"media0_out mix 0", "media1_in Switch", "media1_in"},
diff --git a/sound/soc/intel/atom/sst-atom-controls.h b/sound/soc/intel/atom/sst-atom-controls.h
index 93de8045d4e1..e0113112f668 100644
--- a/sound/soc/intel/atom/sst-atom-controls.h
+++ b/sound/soc/intel/atom/sst-atom-controls.h
@@ -28,6 +28,7 @@
 
 enum {
 	MERR_DPCM_AUDIO = 0,
+	MERR_DPCM_DEEP_BUFFER,
 	MERR_DPCM_COMPR,
 };
 
diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 8e475e823205..60b73b7eed0f 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -98,6 +98,7 @@ static struct sst_dev_stream_map dpcm_strm_map[] = {
 	{MERR_DPCM_AUDIO, 0, SNDRV_PCM_STREAM_PLAYBACK, PIPE_MEDIA1_IN, SST_TASK_ID_MEDIA, 0},
 	{MERR_DPCM_COMPR, 0, SNDRV_PCM_STREAM_PLAYBACK, PIPE_MEDIA0_IN, SST_TASK_ID_MEDIA, 0},
 	{MERR_DPCM_AUDIO, 0, SNDRV_PCM_STREAM_CAPTURE, PIPE_PCM1_OUT, SST_TASK_ID_MEDIA, 0},
+	{MERR_DPCM_DEEP_BUFFER, 0, SNDRV_PCM_STREAM_PLAYBACK, PIPE_MEDIA3_IN, SST_TASK_ID_MEDIA, 0},
 };
 
 static int sst_media_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
@@ -511,6 +512,17 @@ static struct snd_soc_dai_driver sst_platform_dai[] = {
 	},
 },
 {
+	.name = "deepbuffer-cpu-dai",
+	.ops = &sst_media_dai_ops,
+	.playback = {
+		.stream_name = "Deepbuffer Playback",
+		.channels_min = SST_STEREO,
+		.channels_max = SST_STEREO,
+		.rates = SNDRV_PCM_RATE_44100|SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+},
+{
 	.name = "compress-cpu-dai",
 	.compress_new = snd_soc_new_compress,
 	.ops = &sst_compr_dai_ops,
-- 
2.6.2
