From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add dai load ops for
	dais from topology" to the asoc tree
Date: Fri, 13 Oct 2017 20:25:49 +0100
Message-ID: <E1e35af-0006OL-0N@debutante>
References: <20171009055032.12158-3-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B87E526770C
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 21:26:03 +0200 (CEST)
In-Reply-To: <20171009055032.12158-3-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add dai load ops for dais from topology

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

>From 606e21fd6f43b9be8c7d9df8bc415f1637fbeb04 Mon Sep 17 00:00:00 2001
From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Date: Mon, 9 Oct 2017 11:20:31 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add dai load ops for dais from topology

Since FE dais can come from topology, add dai_load ops
for the dais from topology.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c      | 8 ++++++++
 sound/soc/intel/skylake/skl-topology.c | 1 +
 sound/soc/intel/skylake/skl-topology.h | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 9ca69b1fc128..4380e40c6af0 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -977,6 +977,14 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 },
 };
 
+int skl_dai_load(struct snd_soc_component *cmp,
+		 struct snd_soc_dai_driver *pcm_dai)
+{
+	pcm_dai->ops = &skl_pcm_dai_ops;
+
+	return 0;
+}
+
 static int skl_platform_open(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 22f768ca3c73..ff4f53cdc0a1 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3331,6 +3331,7 @@ static struct snd_soc_tplg_ops skl_tplg_ops  = {
 	.io_ops = skl_tplg_kcontrol_ops,
 	.io_ops_count = ARRAY_SIZE(skl_tplg_kcontrol_ops),
 	.manifest = skl_manifest_load,
+	.dai_load = skl_dai_load,
 };
 
 /*
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index e11cc1fc0e43..d116599bfdd7 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -501,4 +501,7 @@ int skl_pcm_host_dma_prepare(struct device *dev,
 			struct skl_pipe_params *params);
 int skl_pcm_link_dma_prepare(struct device *dev,
 			struct skl_pipe_params *params);
+
+int skl_dai_load(struct snd_soc_component *cmp,
+		 struct snd_soc_dai_driver *pcm_dai);
 #endif
-- 
2.14.1
