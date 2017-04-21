From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix a couple user after
	free bugs" to the asoc tree
Date: Fri, 21 Apr 2017 18:28:27 +0100
Message-ID: <E1d1cM7-0001u9-Ty@debutante>
References: <20170414191120.GA30875@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6684A267284
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 19:28:47 +0200 (CEST)
In-Reply-To: <20170414191120.GA30875@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Dharageswari R <dharageswari.r@intel.com>, Vinod Koul <vinod.koul@intel.com>, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, G Kranthi <gudishax.kranthikumar@intel.com>, Mark Brown <broonie@kernel.org>, Hardik T Shah <hardik.t.shah@intel.com>, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix a couple user after free bugs

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

>From 550b349af0f0e33fedb252aca8dc144299aca308 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 14 Apr 2017 22:11:20 +0300
Subject: [PATCH] ASoC: Intel: Skylake: Fix a couple user after free bugs

We need to use the _safe() version of list_for_each_entry() here because
of the kfree(modules).

Fixes: b8c722ddd548 ("ASoC: Intel: Skylake: Add support for deferred DSP module bind")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c      | 4 ++--
 sound/soc/intel/skylake/skl-topology.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 600faad19bd4..d43d1976dd3b 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1323,10 +1323,10 @@ int skl_platform_unregister(struct device *dev)
 {
 	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
 	struct skl *skl = ebus_to_skl(ebus);
-	struct skl_module_deferred_bind *modules;
+	struct skl_module_deferred_bind *modules, *tmp;
 
 	if (!list_empty(&skl->bind_list)) {
-		list_for_each_entry(modules, &skl->bind_list, node) {
+		list_for_each_entry_safe(modules, tmp, &skl->bind_list, node) {
 			list_del(&modules->node);
 			kfree(modules);
 		}
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 7f285176a074..0e459d3eb17a 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1091,7 +1091,7 @@ static int skl_tplg_mixer_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 	struct skl_module_cfg *src_module = NULL, *dst_module;
 	struct skl_sst *ctx = skl->skl_sst;
 	struct skl_pipe *s_pipe = mconfig->pipe;
-	struct skl_module_deferred_bind *modules;
+	struct skl_module_deferred_bind *modules, *tmp;
 
 	if (s_pipe->state == SKL_PIPE_INVALID)
 		return -EINVAL;
@@ -1105,7 +1105,7 @@ static int skl_tplg_mixer_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 
 		src_module = w_module->w->priv;
 
-		list_for_each_entry(modules, &skl->bind_list, node) {
+		list_for_each_entry_safe(modules, tmp, &skl->bind_list, node) {
 			/*
 			 * When the destination module is deleted, Unbind the
 			 * modules from deferred bind list.
-- 
2.11.0
