From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Rename functions & variables
	for physical DAIs" to the asoc tree
Date: Fri, 04 Nov 2016 11:38:14 -0600
Message-ID: <E1c2iRS-0007BQ-FR@finisterre>
References: <a118d55b819c5b0eda822e7348edcd2ec2b948df.1476162939.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AD2512674C4
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 18:38:33 +0100 (CET)
In-Reply-To: <a118d55b819c5b0eda822e7348edcd2ec2b948df.1476162939.git.mengdong.lin@linux.intel.com>
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

   ASoC: topology: Rename functions & variables for physical DAIs

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

>From 9aa3f03473ce1187062bb0c68aeacf7b3ac52831 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Thu, 3 Nov 2016 01:05:15 +0800
Subject: [PATCH] ASoC: topology: Rename functions & variables for physical
 DAIs

Code refactoring. These functions and variables are for configuring
physical DAIs, not only backend DAIs since users may not need DPCM.
So remove 'be' from the function names, and rename variables 'be'
to 'd' or 'dai'.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 57 ++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index a839dc857e0d..f44f12eb1798 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2081,16 +2081,16 @@ static int soc_tplg_link_elems_load(struct soc_tplg *tplg,
 	return 0;
 }
 
-/* *
- * soc_tplg_be_dai_config - Find and configure an existing BE DAI.
+/**
+ * soc_tplg_dai_config - Find and configure an existing physical DAI.
  * @tplg: topology context
- * @be: topology BE DAI configs.
+ * @d: physical DAI configs.
  *
- * The BE dai should already be registered by the platform driver. The
- * platform driver should specify the BE DAI name and ID for matching.
+ * The physical dai should already be registered by the platform driver.
+ * The platform driver should specify the DAI name and ID for matching.
  */
-static int soc_tplg_be_dai_config(struct soc_tplg *tplg,
-				  struct snd_soc_tplg_dai *be)
+static int soc_tplg_dai_config(struct soc_tplg *tplg,
+			       struct snd_soc_tplg_dai *d)
 {
 	struct snd_soc_dai_link_component dai_component = {0};
 	struct snd_soc_dai *dai;
@@ -2099,17 +2099,17 @@ static int soc_tplg_be_dai_config(struct soc_tplg *tplg,
 	struct snd_soc_tplg_stream_caps *caps;
 	int ret;
 
-	dai_component.dai_name = be->dai_name;
+	dai_component.dai_name = d->dai_name;
 	dai = snd_soc_find_dai(&dai_component);
 	if (!dai) {
-		dev_err(tplg->dev, "ASoC: BE DAI %s not registered\n",
-			be->dai_name);
+		dev_err(tplg->dev, "ASoC: physical DAI %s not registered\n",
+			d->dai_name);
 		return -EINVAL;
 	}
 
-	if (be->dai_id != dai->id) {
-		dev_err(tplg->dev, "ASoC: BE DAI %s id mismatch\n",
-			be->dai_name);
+	if (d->dai_id != dai->id) {
+		dev_err(tplg->dev, "ASoC: physical DAI %s id mismatch\n",
+			d->dai_name);
 		return -EINVAL;
 	}
 
@@ -2117,20 +2117,20 @@ static int soc_tplg_be_dai_config(struct soc_tplg *tplg,
 	if (!dai_drv)
 		return -EINVAL;
 
-	if (be->playback) {
+	if (d->playback) {
 		stream = &dai_drv->playback;
-		caps = &be->caps[SND_SOC_TPLG_STREAM_PLAYBACK];
+		caps = &d->caps[SND_SOC_TPLG_STREAM_PLAYBACK];
 		set_stream_info(stream, caps);
 	}
 
-	if (be->capture) {
+	if (d->capture) {
 		stream = &dai_drv->capture;
-		caps = &be->caps[SND_SOC_TPLG_STREAM_CAPTURE];
+		caps = &d->caps[SND_SOC_TPLG_STREAM_CAPTURE];
 		set_stream_info(stream, caps);
 	}
 
-	if (be->flag_mask)
-		set_dai_flags(dai_drv, be->flag_mask, be->flags);
+	if (d->flag_mask)
+		set_dai_flags(dai_drv, d->flag_mask, d->flags);
 
 	/* pass control to component driver for optional further init */
 	ret = soc_tplg_dai_load(tplg, dai_drv);
@@ -2142,10 +2142,11 @@ static int soc_tplg_be_dai_config(struct soc_tplg *tplg,
 	return 0;
 }
 
-static int soc_tplg_be_dai_elems_load(struct soc_tplg *tplg,
-				      struct snd_soc_tplg_hdr *hdr)
+/* load physical DAI elements */
+static int soc_tplg_dai_elems_load(struct soc_tplg *tplg,
+				   struct snd_soc_tplg_hdr *hdr)
 {
-	struct snd_soc_tplg_dai *be;
+	struct snd_soc_tplg_dai *dai;
 	int count = hdr->count;
 	int i;
 
@@ -2154,14 +2155,14 @@ static int soc_tplg_be_dai_elems_load(struct soc_tplg *tplg,
 
 	/* config the existing BE DAIs */
 	for (i = 0; i < count; i++) {
-		be = (struct snd_soc_tplg_dai *)tplg->pos;
-		if (be->size != sizeof(*be)) {
-			dev_err(tplg->dev, "ASoC: invalid BE DAI size\n");
+		dai = (struct snd_soc_tplg_dai *)tplg->pos;
+		if (dai->size != sizeof(*dai)) {
+			dev_err(tplg->dev, "ASoC: invalid physical DAI size\n");
 			return -EINVAL;
 		}
 
-		soc_tplg_be_dai_config(tplg, be);
-		tplg->pos += (sizeof(*be) + be->priv.size);
+		soc_tplg_dai_config(tplg, dai);
+		tplg->pos += (sizeof(*dai) + dai->priv.size);
 	}
 
 	dev_dbg(tplg->dev, "ASoC: Configure %d BE DAIs\n", count);
@@ -2329,7 +2330,7 @@ static int soc_tplg_load_header(struct soc_tplg *tplg,
 	case SND_SOC_TPLG_TYPE_PCM:
 		return soc_tplg_pcm_elems_load(tplg, hdr);
 	case SND_SOC_TPLG_TYPE_DAI:
-		return soc_tplg_be_dai_elems_load(tplg, hdr);
+		return soc_tplg_dai_elems_load(tplg, hdr);
 	case SND_SOC_TPLG_TYPE_DAI_LINK:
 	case SND_SOC_TPLG_TYPE_BACKEND_LINK:
 		/* physical link configurations */
-- 
2.10.1
