From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Only use valid names of PCM
	for the kernel DAI & DAI link" to the asoc tree
Date: Thu, 03 Nov 2016 10:55:37 -0600
Message-ID: <E1c2LIf-0001jP-KX@finisterre>
References: <f2e808ea2d0185ee310a5bae58317d253838641b.1478071138.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C7E572667E7
 for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2016 17:55:48 +0100 (CET)
In-Reply-To: <f2e808ea2d0185ee310a5bae58317d253838641b.1478071138.git.mengdong.lin@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Only use valid names of PCM for the kernel DAI & DAI link

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

>From 8f27c4abc2cd7a31adb896a6b4861cdcb921d063 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Thu, 3 Nov 2016 01:02:59 +0800
Subject: [PATCH] ASoC: topology: Only use valid names of PCM for the kernel
 DAI & DAI link

User space may not always set a valid FE DAI driver's name, FE DAI link's
name, stream name or cpu DAI name. In such cases, there are all ZERO in
these name string buffers of a topology PCM object. This patch will only
duplicate valid name strings for kernel FE DAI driver and DAI link when
creating them from topology, and free the name strings when destroying
them.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 03edde57bfea..0f1c8ebf8cda 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -523,6 +523,7 @@ static void remove_dai(struct snd_soc_component *comp,
 	if (dobj->ops && dobj->ops->dai_unload)
 		dobj->ops->dai_unload(comp, dobj);
 
+	kfree(dai_drv->name);
 	list_del(&dobj->list);
 	kfree(dai_drv);
 }
@@ -540,6 +541,10 @@ static void remove_link(struct snd_soc_component *comp,
 	if (dobj->ops && dobj->ops->link_unload)
 		dobj->ops->link_unload(comp, dobj);
 
+	kfree(link->name);
+	kfree(link->stream_name);
+	kfree(link->cpu_dai_name);
+
 	list_del(&dobj->list);
 	snd_soc_remove_dai_link(comp->card, link);
 	kfree(link);
@@ -1638,7 +1643,8 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	if (dai_drv == NULL)
 		return -ENOMEM;
 
-	dai_drv->name = pcm->dai_name;
+	if (strlen(pcm->dai_name))
+		dai_drv->name = kstrdup(pcm->dai_name, GFP_KERNEL);
 	dai_drv->id = pcm->dai_id;
 
 	if (pcm->playback) {
@@ -1681,11 +1687,15 @@ static int soc_tplg_link_create(struct soc_tplg *tplg,
 	if (link == NULL)
 		return -ENOMEM;
 
-	link->name = pcm->pcm_name;
-	link->stream_name = pcm->pcm_name;
+	if (strlen(pcm->pcm_name)) {
+		link->name = kstrdup(pcm->pcm_name, GFP_KERNEL);
+		link->stream_name = kstrdup(pcm->pcm_name, GFP_KERNEL);
+	}
 	link->id = pcm->pcm_id;
 
-	link->cpu_dai_name = pcm->dai_name;
+	if (strlen(pcm->dai_name))
+		link->cpu_dai_name = kstrdup(pcm->dai_name, GFP_KERNEL);
+
 	link->codec_name = "snd-soc-dummy";
 	link->codec_dai_name = "snd-soc-dummy-dai";
 
-- 
2.10.1
