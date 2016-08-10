From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/3] ASoC: Intel: Skylake: Populate modules
	after loading
Date: Wed, 10 Aug 2016 09:40:49 +0530
Message-ID: <1470802250-9232-3-git-send-email-vinod.koul@intel.com>
References: <1470802250-9232-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F117265A8C
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 06:03:17 +0200 (CEST)
In-Reply-To: <1470802250-9232-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Once topology and firmware are loaded, we can parse the manifest. Use driver
pipe and widget list to get list of all modules and populate the data.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 140249269cdb..eb1f00b28df1 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1138,6 +1138,32 @@ static int skl_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	return retval;
 }
 
+static int skl_populate_modules(struct skl *skl)
+{
+	struct skl_pipeline *p;
+	struct skl_pipe_module *m;
+	struct snd_soc_dapm_widget *w;
+	struct skl_module_cfg *mconfig;
+	int ret;
+
+	list_for_each_entry(p, &skl->ppl_list, node) {
+		list_for_each_entry(m, &p->pipe->w_list, node) {
+
+			w = m->w;
+			mconfig = w->priv;
+
+			ret = snd_skl_get_module_info(skl->skl_sst, mconfig);
+			if (ret < 0) {
+				dev_err(skl->skl_sst->dev,
+					"query module info failed:%d\n", ret);
+				goto err;
+			}
+		}
+	}
+err:
+	return ret;
+}
+
 static int skl_platform_soc_probe(struct snd_soc_platform *platform)
 {
 	struct hdac_ext_bus *ebus = dev_get_drvdata(platform->dev);
@@ -1169,6 +1195,7 @@ static int skl_platform_soc_probe(struct snd_soc_platform *platform)
 			dev_err(platform->dev, "Failed to boot first fw: %d\n", ret);
 			return ret;
 		}
+		skl_populate_modules(skl);
 	}
 	pm_runtime_mark_last_busy(platform->dev);
 	pm_runtime_put_autosuspend(platform->dev);
-- 
1.9.1
