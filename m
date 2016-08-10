From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Populate modules after
	loading" to the asoc tree
Date: Wed, 10 Aug 2016 21:04:04 +0100
Message-ID: <E1bXZjQ-0000Tl-C4@debutante>
References: <1470802250-9232-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AE0A72668D0
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 22:04:20 +0200 (CEST)
In-Reply-To: <1470802250-9232-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Populate modules after loading

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

>From 64cb1d0ad0eada322c2011e15710d2a1c12ce8b6 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 10 Aug 2016 09:40:49 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Populate modules after loading

Once topology and firmware are loaded, we can parse the manifest. Use driver
pipe and widget list to get list of all modules and populate the data.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.8.1
