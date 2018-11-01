From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 4/7] ASoC: Intel: boards: fix Skylake typo
Date: Wed, 31 Oct 2018 20:07:15 -0500
Message-ID: <20181101010718.2878-5-pierre-louis.bossart@linux.intel.com>
References: <20181101010718.2878-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A23E2678A5
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2018 02:07:26 +0100 (CET)
In-Reply-To: <20181101010718.2878-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

s/skylaye/skylake

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
2.17.1
