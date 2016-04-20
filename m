From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Export snd_soc_find_dai()" to the asoc
	tree
Date: Wed, 20 Apr 2016 17:19:44 +0100
Message-ID: <E1asuqu-0006ws-19@debutante>
References: <5e7147f76b2c54d2d23eb1f6a1146a3716bd5172.1461042239.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 29D64266558
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 18:19:54 +0200 (CEST)
In-Reply-To: <5e7147f76b2c54d2d23eb1f6a1146a3716bd5172.1461042239.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Export snd_soc_find_dai()

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

>From 305e9020f09d28560373c0112682e6fd11e909f6 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Tue, 19 Apr 2016 13:12:25 +0800
Subject: [PATCH] ASoC: Export snd_soc_find_dai()

This API can be used by topology to find an existing BE dai by name
and further configure it.

Topology will also check DAI ID to avoid wrong match.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 3 +++
 sound/soc/soc-core.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 02b4a215fd75..7687e2d4b0e4 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1683,6 +1683,9 @@ void snd_soc_remove_dai_link(struct snd_soc_card *card,
 int snd_soc_register_dai(struct snd_soc_component *component,
 	struct snd_soc_dai_driver *dai_drv);
 
+struct snd_soc_dai *snd_soc_find_dai(
+	const struct snd_soc_dai_link_component *dlc);
+
 #include <sound/soc-dai.h>
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d2e62b159610..07663def2db6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -930,7 +930,7 @@ static struct snd_soc_component *soc_find_component(
 	return NULL;
 }
 
-static struct snd_soc_dai *snd_soc_find_dai(
+struct snd_soc_dai *snd_soc_find_dai(
 	const struct snd_soc_dai_link_component *dlc)
 {
 	struct snd_soc_component *component;
@@ -959,6 +959,7 @@ static struct snd_soc_dai *snd_soc_find_dai(
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(snd_soc_find_dai);
 
 static bool soc_is_dai_link_bound(struct snd_soc_card *card,
 		struct snd_soc_dai_link *dai_link)
-- 
2.8.0.rc3
