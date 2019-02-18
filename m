From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: free created components in
	tplg load error" to the asoc tree
Date: Mon, 18 Feb 2019 18:52:27 +0000 (GMT)
Message-ID: <20190218185227.90BF71128008@debutante.sirena.org.uk>
References: <20190217132347.12593-1-yung-chuan.liao@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 13F0C265555
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 19:52:31 +0100 (CET)
In-Reply-To: <20190217132347.12593-1-yung-chuan.liao@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard liao <yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: free created components in tplg load error

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

>From 304017d31df36fb61eb2ed3ebf65fb6870b3c731 Mon Sep 17 00:00:00 2001
From: Bard liao <yung-chuan.liao@linux.intel.com>
Date: Sun, 17 Feb 2019 21:23:47 +0800
Subject: [PATCH] ASoC: topology: free created components in tplg load error

Topology resources are no longer needed if any element failed to load.

Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index fc79ec6927e3..731b963b6995 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2487,6 +2487,7 @@ int snd_soc_tplg_component_load(struct snd_soc_component *comp,
 	struct snd_soc_tplg_ops *ops, const struct firmware *fw, u32 id)
 {
 	struct soc_tplg tplg;
+	int ret;
 
 	/* setup parsing context */
 	memset(&tplg, 0, sizeof(tplg));
@@ -2500,7 +2501,12 @@ int snd_soc_tplg_component_load(struct snd_soc_component *comp,
 	tplg.bytes_ext_ops = ops->bytes_ext_ops;
 	tplg.bytes_ext_ops_count = ops->bytes_ext_ops_count;
 
-	return soc_tplg_load(&tplg);
+	ret = soc_tplg_load(&tplg);
+	/* free the created components if fail to load topology */
+	if (ret)
+		snd_soc_tplg_component_remove(comp, SND_SOC_TPLG_INDEX_ALL);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_tplg_component_load);
 
-- 
2.20.1
