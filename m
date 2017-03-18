From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ASoC: mediatek: constify snd_soc_ops structures
Date: Sat, 18 Mar 2017 23:13:14 +0530
Message-ID: <1489858994-11659-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 4788B266AF1
 for <alsa-devel@alsa-project.org>; Sat, 18 Mar 2017 18:43:24 +0100 (CET)
Received: by mail-pf0-f195.google.com with SMTP id o126so12117872pfb.1
 for <alsa-devel@alsa-project.org>; Sat, 18 Mar 2017 10:43:24 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: julia.lawall@lip6.fr, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_soc_ops structures as const as they are only stored
in the ops field of a snd_soc_dai_link structure. This field is
of type const, so snd_soc_ops structures having this property
can be made const too.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/mediatek/mt2701/mt2701-cs42448.c       | 2 +-
 sound/soc/mediatek/mt8173/mt8173-max98090.c      | 2 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c | 2 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c | 2 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650.c        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-cs42448.c b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
index 1e7e8d4..aa5b31b 100644
--- a/sound/soc/mediatek/mt2701/mt2701-cs42448.c
+++ b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
@@ -129,7 +129,7 @@ static int mt2701_cs42448_fe_ops_startup(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_soc_ops mt2701_cs42448_48k_fe_ops = {
+static const struct snd_soc_ops mt2701_cs42448_48k_fe_ops = {
 	.startup = mt2701_cs42448_fe_ops_startup,
 };
 
diff --git a/sound/soc/mediatek/mt8173/mt8173-max98090.c b/sound/soc/mediatek/mt8173/mt8173-max98090.c
index 46c8e6a..e0c2b23 100644
--- a/sound/soc/mediatek/mt8173/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173/mt8173-max98090.c
@@ -67,7 +67,7 @@ static int mt8173_max98090_hw_params(struct snd_pcm_substream *substream,
 				      SND_SOC_CLOCK_IN);
 }
 
-static struct snd_soc_ops mt8173_max98090_ops = {
+static const struct snd_soc_ops mt8173_max98090_ops = {
 	.hw_params = mt8173_max98090_hw_params,
 };
 
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
index 467f704..5e383eb 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
@@ -75,7 +75,7 @@ static int mt8173_rt5650_rt5514_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops mt8173_rt5650_rt5514_ops = {
+static const struct snd_soc_ops mt8173_rt5650_rt5514_ops = {
 	.hw_params = mt8173_rt5650_rt5514_hw_params,
 };
 
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
index 1b8b2a7..fed1f15 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
@@ -79,7 +79,7 @@ static int mt8173_rt5650_rt5676_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops mt8173_rt5650_rt5676_ops = {
+static const struct snd_soc_ops mt8173_rt5650_rt5676_ops = {
 	.hw_params = mt8173_rt5650_rt5676_hw_params,
 };
 
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index ba65f41..a784708 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -105,7 +105,7 @@ static int mt8173_rt5650_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops mt8173_rt5650_ops = {
+static const struct snd_soc_ops mt8173_rt5650_ops = {
 	.hw_params = mt8173_rt5650_hw_params,
 };
 
-- 
2.7.4
