From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: fix Skylake typo" to the
	asoc tree
Date: Tue,  6 Nov 2018 18:00:48 +0000 (GMT)
Message-ID: <20181106180048.6DC15112266B@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DFB902678F2
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 19:00:48 +0100 (CET)
In-Reply-To: 
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: boards: fix Skylake typo

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 48bf41a2be51ef3f67b60f85bf75cecfb57884ba Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 1 Nov 2018 16:34:51 -0500
Subject: [PATCH] ASoC: Intel: boards: fix Skylake typo

s/skylaye/skylake

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_da7219_max98927.c    | 6 +++---
 sound/soc/intel/boards/kbl_rt5663_max98927.c    | 4 ++--
 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 4 ++--
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c   | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
index 3fa1c3ca6d37..3bc78e3a91ee 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98927.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
@@ -441,7 +441,7 @@ static int kabylake_refcap_startup(struct snd_pcm_substream *substream)
 }
 
 
-static struct snd_soc_ops skylaye_refcap_ops = {
+static struct snd_soc_ops skylake_refcap_ops = {
 	.startup = kabylake_refcap_startup,
 };
 
@@ -525,7 +525,7 @@ static struct snd_soc_dai_link kabylake_dais[] = {
 		.dpcm_capture = 1,
 		.nonatomic = 1,
 		.dynamic = 1,
-		.ops = &skylaye_refcap_ops,
+		.ops = &skylake_refcap_ops,
 	},
 	[KBL_DPCM_AUDIO_DMIC_CP] = {
 		.name = "Kbl Audio DMIC cap",
@@ -736,7 +736,7 @@ static struct snd_soc_dai_link kabylake_max98927_dais[] = {
 		.dpcm_capture = 1,
 		.nonatomic = 1,
 		.dynamic = 1,
-		.ops = &skylaye_refcap_ops,
+		.ops = &skylake_refcap_ops,
 	},
 	[KBL_DPCM_AUDIO_DMIC_CP] = {
 		.name = "Kbl Audio DMIC cap",
diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 99e1320c485f..6ea969c0a5fb 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -586,7 +586,7 @@ static int kabylake_refcap_startup(struct snd_pcm_substream *substream)
 				&constraints_16000);
 }
 
-static struct snd_soc_ops skylaye_refcap_ops = {
+static struct snd_soc_ops skylake_refcap_ops = {
 	.startup = kabylake_refcap_startup,
 };
 
@@ -655,7 +655,7 @@ static struct snd_soc_dai_link kabylake_dais[] = {
 		.dpcm_capture = 1,
 		.nonatomic = 1,
 		.dynamic = 1,
-		.ops = &skylaye_refcap_ops,
+		.ops = &skylake_refcap_ops,
 	},
 	[KBL_DPCM_AUDIO_DMIC_CP] = {
 		.name = "Kbl Audio DMIC cap",
diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index d31482b8c9bb..552958ce736d 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -400,7 +400,7 @@ static int skylake_refcap_startup(struct snd_pcm_substream *substream)
 				&constraints_16000);
 }
 
-static const struct snd_soc_ops skylaye_refcap_ops = {
+static const struct snd_soc_ops skylake_refcap_ops = {
 	.startup = skylake_refcap_startup,
 };
 
@@ -447,7 +447,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.dpcm_capture = 1,
 		.nonatomic = 1,
 		.dynamic = 1,
-		.ops = &skylaye_refcap_ops,
+		.ops = &skylake_refcap_ops,
 	},
 	[SKL_DPCM_AUDIO_DMIC_CP] = {
 		.name = "Skl Audio DMIC cap",
diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index e877bb60beb1..f985b30a1d0e 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -449,7 +449,7 @@ static int skylake_refcap_startup(struct snd_pcm_substream *substream)
 			&constraints_16000);
 }
 
-static const struct snd_soc_ops skylaye_refcap_ops = {
+static const struct snd_soc_ops skylake_refcap_ops = {
 	.startup = skylake_refcap_startup,
 };
 
@@ -496,7 +496,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.dpcm_capture = 1,
 		.nonatomic = 1,
 		.dynamic = 1,
-		.ops = &skylaye_refcap_ops,
+		.ops = &skylake_refcap_ops,
 	},
 	[SKL_DPCM_AUDIO_DMIC_CP] = {
 		.name = "Skl Audio DMIC cap",
-- 
2.19.0.rc2
