From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Fix bugs of freeing soc
	topology" to the asoc tree
Date: Tue, 17 Apr 2018 12:28:36 +0100
Message-ID: <E1f8Omq-0000I2-Kk@debutante>
References: <20180314204722.14144-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 230252675CF
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 13:28:39 +0200 (CEST)
In-Reply-To: <20180314204722.14144-1-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yan Wang <yan.wang@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Fix bugs of freeing soc topology

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

>From feb12f0cd8d7b1e8df2e6fce19fc9a026a468cc2 Mon Sep 17 00:00:00 2001
From: Yan Wang <yan.wang@linux.intel.com>
Date: Mon, 26 Mar 2018 16:48:00 +0100
Subject: [PATCH] ASoC: topology: Fix bugs of freeing soc topology

In snd_soc_tplg_component_remove(), it should compare index and
not dobj->index with SND_SOC_TPLG_INDEX_ALL for removing all
topology objects.

Signed-off-by: Yan Wang <yan.wang@linux.intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 942c6e5eb4b7..5598e891b2b3 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2580,7 +2580,7 @@ int snd_soc_tplg_component_remove(struct snd_soc_component *comp, u32 index)
 
 			/* match index */
 			if (dobj->index != index &&
-				dobj->index != SND_SOC_TPLG_INDEX_ALL)
+				index != SND_SOC_TPLG_INDEX_ALL)
 				continue;
 
 			switch (dobj->type) {
-- 
2.17.0
