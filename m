From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 2/7] ASoC: cirrus: make snd_soc_ops const
Date: Wed, 16 Aug 2017 22:29:25 +0530
Message-ID: <1502902770-3758-3-git-send-email-bhumirks@gmail.com>
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
 sound/soc/cirrus/edb93xx.c     | 2 +-
 sound/soc/cirrus/snappercl15.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/cirrus/edb93xx.c b/sound/soc/cirrus/edb93xx.c
index 85962657..c53bd6f 100644
--- a/sound/soc/cirrus/edb93xx.c
+++ b/sound/soc/cirrus/edb93xx.c
@@ -56,7 +56,7 @@ static int edb93xx_hw_params(struct snd_pcm_substream *substream,
 				      SND_SOC_CLOCK_OUT);
 }
 
-static struct snd_soc_ops edb93xx_ops = {
+static const struct snd_soc_ops edb93xx_ops = {
 	.hw_params	= edb93xx_hw_params,
 };
 
diff --git a/sound/soc/cirrus/snappercl15.c b/sound/soc/cirrus/snappercl15.c
index 98089df..2334ec1 100644
--- a/sound/soc/cirrus/snappercl15.c
+++ b/sound/soc/cirrus/snappercl15.c
@@ -45,7 +45,7 @@ static int snappercl15_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops snappercl15_ops = {
+static const struct snd_soc_ops snappercl15_ops = {
 	.hw_params	= snappercl15_hw_params,
 };
 
-- 
1.9.1
