From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 6/7] ASoC: samsung: make snd_soc_ops const
Date: Wed, 16 Aug 2017 22:29:29 +0530
Message-ID: <1502902770-3758-7-git-send-email-bhumirks@gmail.com>
References: <1502902770-3758-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502902770-3758-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, heiko@sntech.de, krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make these const as they are only stored in the ops field of a
snd_soc_dai_link structure, which is const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/samsung/jive_wm8750.c     | 2 +-
 sound/soc/samsung/s3c24xx_simtec.c  | 2 +-
 sound/soc/samsung/s3c24xx_uda134x.c | 2 +-
 sound/soc/samsung/smdk_spdif.c      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

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
index 55538e3..c65c89d 100644
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
 
-- 
1.9.1
