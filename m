From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ASoC: Intel: Skylake: Fix a couple user after
	free bugs
Date: Fri, 14 Apr 2017 22:11:20 +0300
Message-ID: <20170414191120.GA30875@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 24C7F267212
 for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2017 21:11:39 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Jeeja KP <jeeja.kp@intel.com>
Cc: alsa-devel@alsa-project.org, Dharageswari R <dharageswari.r@intel.com>, Vinod Koul <vinod.koul@intel.com>, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, G Kranthi <gudishax.kranthikumar@intel.com>, Mark Brown <broonie@kernel.org>, Hardik T Shah <hardik.t.shah@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

We need to use the _safe() version of list_for_each_entry() here because
of the kfree(modules).

Fixes: b8c722ddd548 ("ASoC: Intel: Skylake: Add support for deferred DSP module bind")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

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
index 74b3acf3bb07..aea7917e791c 100644
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
