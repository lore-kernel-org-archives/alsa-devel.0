From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ASoC: samsung: constify snd_soc_ops structures
Date: Sat, 18 Mar 2017 20:31:39 +0530
Message-ID: <1489849299-11340-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A3C48266AF1
 for <alsa-devel@alsa-project.org>; Sat, 18 Mar 2017 16:02:07 +0100 (CET)
Received: by mail-pf0-f193.google.com with SMTP id n11so496526pfg.2
 for <alsa-devel@alsa-project.org>; Sat, 18 Mar 2017 08:02:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: julia.lawall@lip6.fr, krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_soc_ops structures as const as they are only stored
in the ops field of a snd_soc_dai_link structure. This field is
of type const, so snd_soc_ops structures having this property
can be made const too.

Cross compiled the files arndale_rt5631.o, h1940_uda1380.o, jive_wm8750.o,
littlemill.o, neo1973_wm8753.o and rx1950_uda1380.o for arm architecture.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/samsung/arndale_rt5631.c  | 2 +-
 sound/soc/samsung/h1940_uda1380.c   | 2 +-
 sound/soc/samsung/jive_wm8750.c     | 2 +-
 sound/soc/samsung/littlemill.c      | 2 +-
 sound/soc/samsung/neo1973_wm8753.c  | 2 +-
 sound/soc/samsung/rx1950_uda1380.c  | 2 +-
 sound/soc/samsung/s3c24xx_simtec.c  | 2 +-
 sound/soc/samsung/s3c24xx_uda134x.c | 2 +-
 sound/soc/samsung/smartq_wm8987.c   | 2 +-
 sound/soc/samsung/smdk_spdif.c      | 2 +-
 sound/soc/samsung/smdk_wm8580.c     | 2 +-
 sound/soc/samsung/smdk_wm8994.c     | 2 +-
 sound/soc/samsung/smdk_wm8994pcm.c  | 2 +-
 sound/soc/samsung/tm2_wm5110.c      | 2 +-
 sound/soc/samsung/tobermory.c       | 2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/sound/soc/samsung/arndale_rt5631.c b/sound/soc/samsung/arndale_rt5631.c
index ee1fda9..6f40587 100644
--- a/sound/soc/samsung/arndale_rt5631.c
+++ b/sound/soc/samsung/arndale_rt5631.c
@@ -53,7 +53,7 @@ static int arndale_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops arndale_ops = {
+static const struct snd_soc_ops arndale_ops = {
 	.hw_params = arndale_hw_params,
 };
 
diff --git a/sound/soc/samsung/h1940_uda1380.c b/sound/soc/samsung/h1940_uda1380.c
index 5f5825f..3c8d58a 100644
--- a/sound/soc/samsung/h1940_uda1380.c
+++ b/sound/soc/samsung/h1940_uda1380.c
@@ -120,7 +120,7 @@ static int h1940_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops h1940_ops = {
+static const struct snd_soc_ops h1940_ops = {
 	.startup	= h1940_startup,
 	.hw_params	= h1940_hw_params,
 };
diff --git a/sound/soc/samsung/jive_wm8750.c b/sound/soc/samsung/jive_wm8750.c
index 7fcb51f..529b10d 100644
--- a/sound/soc/samsung/jive_wm8750.c
+++ b/sound/soc/samsung/jive_wm8750.c
@@ -79,7 +79,7 @@ static int jive_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops jive_ops = {
+static const struct snd_soc_ops jive_ops = {
 	.hw_params	= jive_hw_params,
 };
 
diff --git a/sound/soc/samsung/littlemill.c b/sound/soc/samsung/littlemill.c
index 7cb204e..d057eae 100644
--- a/sound/soc/samsung/littlemill.c
+++ b/sound/soc/samsung/littlemill.c
@@ -135,7 +135,7 @@ static int littlemill_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops littlemill_ops = {
+static const struct snd_soc_ops littlemill_ops = {
 	.hw_params = littlemill_hw_params,
 };
 
diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
index 65602b9..8e097f2 100644
--- a/sound/soc/samsung/neo1973_wm8753.c
+++ b/sound/soc/samsung/neo1973_wm8753.c
@@ -114,7 +114,7 @@ static int neo1973_hifi_hw_free(struct snd_pcm_substream *substream)
 /*
  * Neo1973 WM8753 HiFi DAI opserations.
  */
-static struct snd_soc_ops neo1973_hifi_ops = {
+static const struct snd_soc_ops neo1973_hifi_ops = {
 	.hw_params = neo1973_hifi_hw_params,
 	.hw_free = neo1973_hifi_hw_free,
 };
diff --git a/sound/soc/samsung/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
index fa096ab..324e16a 100644
--- a/sound/soc/samsung/rx1950_uda1380.c
+++ b/sound/soc/samsung/rx1950_uda1380.c
@@ -73,7 +73,7 @@ static struct snd_soc_jack_gpio hp_jack_gpios[] = {
 	},
 };
 
-static struct snd_soc_ops rx1950_ops = {
+static const struct snd_soc_ops rx1950_ops = {
 	.startup	= rx1950_startup,
 	.hw_params	= rx1950_hw_params,
 };
diff --git a/sound/soc/samsung/s3c24xx_simtec.c b/sound/soc/samsung/s3c24xx_simtec.c
index dcc008d..6de63f3 100644
--- a/sound/soc/samsung/s3c24xx_simtec.c
+++ b/sound/soc/samsung/s3c24xx_simtec.c
@@ -211,7 +211,7 @@ static int simtec_call_startup(struct s3c24xx_audio_simtec_pdata *pd)
 	return 0;
 }
 
-static struct snd_soc_ops simtec_snd_ops = {
+static const struct snd_soc_ops simtec_snd_ops = {
 	.hw_params	= simtec_hw_params,
 };
 
diff --git a/sound/soc/samsung/s3c24xx_uda134x.c b/sound/soc/samsung/s3c24xx_uda134x.c
index 81a7894..a6a4bc7 100644
--- a/sound/soc/samsung/s3c24xx_uda134x.c
+++ b/sound/soc/samsung/s3c24xx_uda134x.c
@@ -199,7 +199,7 @@ static int s3c24xx_uda134x_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops s3c24xx_uda134x_ops = {
+static const struct snd_soc_ops s3c24xx_uda134x_ops = {
 	.startup = s3c24xx_uda134x_startup,
 	.shutdown = s3c24xx_uda134x_shutdown,
 	.hw_params = s3c24xx_uda134x_hw_params,
diff --git a/sound/soc/samsung/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
index 425ee2b..72408ae 100644
--- a/sound/soc/samsung/smartq_wm8987.c
+++ b/sound/soc/samsung/smartq_wm8987.c
@@ -77,7 +77,7 @@ static int smartq_hifi_hw_params(struct snd_pcm_substream *substream,
 /*
  * SmartQ WM8987 HiFi DAI operations.
  */
-static struct snd_soc_ops smartq_hifi_ops = {
+static const struct snd_soc_ops smartq_hifi_ops = {
 	.hw_params = smartq_hifi_hw_params,
 };
 
diff --git a/sound/soc/samsung/smdk_spdif.c b/sound/soc/samsung/smdk_spdif.c
index a2f2363..7fc7cc6 100644
--- a/sound/soc/samsung/smdk_spdif.c
+++ b/sound/soc/samsung/smdk_spdif.c
@@ -144,7 +144,7 @@ static int smdk_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static struct snd_soc_ops smdk_spdif_ops = {
+static const struct snd_soc_ops smdk_spdif_ops = {
 	.hw_params = smdk_hw_params,
 };
 
diff --git a/sound/soc/samsung/smdk_wm8580.c b/sound/soc/samsung/smdk_wm8580.c
index 6e4dfa7..5c3980b 100644
--- a/sound/soc/samsung/smdk_wm8580.c
+++ b/sound/soc/samsung/smdk_wm8580.c
@@ -93,7 +93,7 @@ static int smdk_hw_params(struct snd_pcm_substream *substream,
 /*
  * SMDK WM8580 DAI operations.
  */
-static struct snd_soc_ops smdk_ops = {
+static const struct snd_soc_ops smdk_ops = {
 	.hw_params = smdk_hw_params,
 };
 
diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index ff57b19..307122f 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -80,7 +80,7 @@ static int smdk_hw_params(struct snd_pcm_substream *substream,
 /*
  * SMDK WM8994 DAI operations.
  */
-static struct snd_soc_ops smdk_ops = {
+static const struct snd_soc_ops smdk_ops = {
 	.hw_params = smdk_hw_params,
 };
 
diff --git a/sound/soc/samsung/smdk_wm8994pcm.c b/sound/soc/samsung/smdk_wm8994pcm.c
index 2e62149..7bbb822 100644
--- a/sound/soc/samsung/smdk_wm8994pcm.c
+++ b/sound/soc/samsung/smdk_wm8994pcm.c
@@ -91,7 +91,7 @@ static int smdk_wm8994_pcm_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops smdk_wm8994_pcm_ops = {
+static const struct snd_soc_ops smdk_wm8994_pcm_ops = {
 	.hw_params = smdk_wm8994_pcm_hw_params,
 };
 
diff --git a/sound/soc/samsung/tm2_wm5110.c b/sound/soc/samsung/tm2_wm5110.c
index 24cc9d6..25e5be9 100644
--- a/sound/soc/samsung/tm2_wm5110.c
+++ b/sound/soc/samsung/tm2_wm5110.c
@@ -131,7 +131,7 @@ static int tm2_aif1_hw_params(struct snd_pcm_substream *substream,
 	return tm2_start_sysclk(rtd->card);
 }
 
-static struct snd_soc_ops tm2_aif1_ops = {
+static const struct snd_soc_ops tm2_aif1_ops = {
 	.hw_params = tm2_aif1_hw_params,
 };
 
diff --git a/sound/soc/samsung/tobermory.c b/sound/soc/samsung/tobermory.c
index 3310eda..097663d 100644
--- a/sound/soc/samsung/tobermory.c
+++ b/sound/soc/samsung/tobermory.c
@@ -110,7 +110,7 @@ static int tobermory_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops tobermory_ops = {
+static const struct snd_soc_ops tobermory_ops = {
 	.hw_params = tobermory_hw_params,
 };
 
-- 
2.7.4
