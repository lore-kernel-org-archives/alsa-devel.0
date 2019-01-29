From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: add SND_SOC_DOBJ_GRAPH type
	for dapm routes" to the asoc tree
Date: Tue, 29 Jan 2019 18:12:23 +0000 (GMT)
Message-ID: <20190129181223.30CFB1127D50@debutante.sirena.org.uk>
References: <20190125200648.12470-6-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 800B12674A3
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 19:12:24 +0100 (CET)
In-Reply-To: <20190125200648.12470-6-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: add SND_SOC_DOBJ_GRAPH type for dapm routes

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

>From 5c30f43f0625a792c30e465f21dbeb1bb4dfc40b Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Fri, 25 Jan 2019 14:06:46 -0600
Subject: [PATCH] ASoC: topology: add SND_SOC_DOBJ_GRAPH type for dapm routes

Add a new dobj type SND_SOC_DOBJ_GRAPH for dapm routes
and add snd_soc_dobj member to struct snd_soc_dapm_route.
This enables device drivers to save driver specific
data pertaining to dapm routes and also be able
to clean up the data when the driver module is unloaded.

Also, reorder the snd_soc_dobj_type types to align with
matching topology header types.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dapm.h     | 2 ++
 include/sound/soc-topology.h | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index bd8163f151cb..46f2ba3ffcb7 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -540,6 +540,8 @@ struct snd_soc_dapm_route {
 	/* Note: currently only supported for links where source is a supply */
 	int (*connected)(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink);
+
+	struct snd_soc_dobj dobj;
 };
 
 /* dapm audio path between two widgets */
diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index fa4b8413d2e2..8c43cfc240fa 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -38,12 +38,13 @@ struct snd_soc_dapm_route;
 enum snd_soc_dobj_type {
 	SND_SOC_DOBJ_NONE		= 0,	/* object is not dynamic */
 	SND_SOC_DOBJ_MIXER,
-	SND_SOC_DOBJ_ENUM,
 	SND_SOC_DOBJ_BYTES,
-	SND_SOC_DOBJ_PCM,
+	SND_SOC_DOBJ_ENUM,
+	SND_SOC_DOBJ_GRAPH,
+	SND_SOC_DOBJ_WIDGET,
 	SND_SOC_DOBJ_DAI_LINK,
+	SND_SOC_DOBJ_PCM,
 	SND_SOC_DOBJ_CODEC_LINK,
-	SND_SOC_DOBJ_WIDGET,
 };
 
 /* dynamic control object */
-- 
2.20.1
