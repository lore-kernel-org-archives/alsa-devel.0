From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: fix oops/use-after-free case
	with dai driver" to the asoc tree
Date: Sat,  2 Feb 2019 16:18:03 +0000 (GMT)
Message-ID: <20190202161803.CAF09440083@finisterre.ee.mobilebroadband>
References: <20190201170513.13905-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E18942674A2
 for <alsa-devel@alsa-project.org>; Sat,  2 Feb 2019 17:18:07 +0100 (CET)
In-Reply-To: <20190201170513.13905-4-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: fix oops/use-after-free case with dai driver

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

>From 52abe6cc1866ac3d54612f5d80563e6608c0ddfc Mon Sep 17 00:00:00 2001
From: Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Date: Fri, 1 Feb 2019 11:05:13 -0600
Subject: [PATCH] ASoC: topology: fix oops/use-after-free case with dai driver

rmmod/modprobe tests expose a kernel oops when accessing the dai
driver pointer. This comes from the topology design which operates in
multiple passes. Each object removal happens at a specific iteration,
and the code checks for the iteration (order) number after the memory
containing the order was freed.

Fix this be clearing a reference to the dai driver and check its
validity to avoid dereferences.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c     | 2 +-
 sound/soc/soc-topology.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ea16c2b199ce..50617db05c46 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -956,7 +956,7 @@ static void soc_remove_dai(struct snd_soc_dai *dai, int order)
 {
 	int err;
 
-	if (!dai || !dai->probed ||
+	if (!dai || !dai->probed || !dai->driver ||
 	    dai->driver->remove_order != order)
 		return;
 
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 045ef136903d..fc79ec6927e3 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -502,6 +502,7 @@ static void remove_dai(struct snd_soc_component *comp,
 {
 	struct snd_soc_dai_driver *dai_drv =
 		container_of(dobj, struct snd_soc_dai_driver, dobj);
+	struct snd_soc_dai *dai;
 
 	if (pass != SOC_TPLG_PASS_PCM_DAI)
 		return;
@@ -509,6 +510,10 @@ static void remove_dai(struct snd_soc_component *comp,
 	if (dobj->ops && dobj->ops->dai_unload)
 		dobj->ops->dai_unload(comp, dobj);
 
+	list_for_each_entry(dai, &comp->dai_list, list)
+		if (dai->driver == dai_drv)
+			dai->driver = NULL;
+
 	kfree(dai_drv->name);
 	list_del(&dobj->list);
 	kfree(dai_drv);
-- 
2.20.1
