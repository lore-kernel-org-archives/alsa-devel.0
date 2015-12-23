From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Factor out finding the
	location of an algorithm region" to the asoc tree
Date: Wed, 23 Dec 2015 00:23:22 +0000
Message-ID: <E1aBXD8-0000Xq-PS@debutante>
References: <1449590917-21170-7-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AAAE2660C2
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:23:29 +0100 (CET)
In-Reply-To: <1449590917-21170-7-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Factor out finding the location of an algorithm region

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

>From 14197095e14a4ad2afb6c8c1ca8e41852382481d Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 15 Dec 2015 11:29:43 +0000
Subject: [PATCH] ASoC: wm_adsp: Factor out finding the location of an
 algorithm region

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index d1e0826c7db2..27abad9c6e73 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1365,6 +1365,19 @@ static void *wm_adsp_read_algs(struct wm_adsp *dsp, size_t n_algs,
 	return alg;
 }
 
+static struct wm_adsp_alg_region *
+	wm_adsp_find_alg_region(struct wm_adsp *dsp, int type, unsigned int id)
+{
+	struct wm_adsp_alg_region *alg_region;
+
+	list_for_each_entry(alg_region, &dsp->alg_regions, list) {
+		if (id == alg_region->alg && type == alg_region->type)
+			return alg_region;
+	}
+
+	return NULL;
+}
+
 static struct wm_adsp_alg_region *wm_adsp_create_region(struct wm_adsp *dsp,
 							int type, __be32 id,
 							__be32 base)
@@ -1737,22 +1750,16 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 				break;
 			}
 
-			reg = 0;
-			list_for_each_entry(alg_region,
-					    &dsp->alg_regions, list) {
-				if (le32_to_cpu(blk->id) == alg_region->alg &&
-				    type == alg_region->type) {
-					reg = alg_region->base;
-					reg = wm_adsp_region_to_reg(mem,
-								    reg);
-					reg += offset;
-					break;
-				}
-			}
-
-			if (reg == 0)
+			alg_region = wm_adsp_find_alg_region(dsp, type,
+						le32_to_cpu(blk->id));
+			if (alg_region) {
+				reg = alg_region->base;
+				reg = wm_adsp_region_to_reg(mem, reg);
+				reg += offset;
+			} else {
 				adsp_err(dsp, "No %x for algorithm %x\n",
 					 type, le32_to_cpu(blk->id));
+			}
 			break;
 
 		default:
-- 
2.6.2
