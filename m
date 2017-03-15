From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Remove get dsp_ops in
	cleanup routine" to the asoc tree
Date: Wed, 15 Mar 2017 18:13:24 +0000
Message-ID: <E1coDQK-0002EH-Pg@debutante>
References: <1489423292-19997-9-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C9E326705E
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 19:13:33 +0100 (CET)
In-Reply-To: <1489423292-19997-9-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: G Kranthi <gudishax.kranthikumar@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Remove get dsp_ops in cleanup routine

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

>From 7bd86a30599de479bd863e18472207337485d339 Mon Sep 17 00:00:00 2001
From: G Kranthi <gudishax.kranthikumar@intel.com>
Date: Mon, 13 Mar 2017 22:11:30 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Remove get dsp_ops in cleanup routine

dsp ops is already set in init, so use this in cleanup routine
instead of again retrieving it. Also constify struct skl_dsp_ops.

Signed-off-by: G Kranthi <gudishax.kranthikumar@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 8 ++------
 sound/soc/intel/skylake/skl-sst-ipc.h  | 2 ++
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 29523ddcfab0..ba1ec973ded7 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -274,6 +274,7 @@ int skl_init_dsp(struct skl *skl)
 	if (ret < 0)
 		return ret;
 
+	skl->skl_sst->dsp_ops = ops;
 	dev_dbg(bus->dev, "dsp registration status=%d\n", ret);
 
 	return ret;
@@ -284,16 +285,11 @@ int skl_free_dsp(struct skl *skl)
 	struct hdac_ext_bus *ebus = &skl->ebus;
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	struct skl_sst *ctx = skl->skl_sst;
-	const struct skl_dsp_ops *ops;
 
 	/* disable  ppcap interrupt */
 	snd_hdac_ext_bus_ppcap_int_enable(&skl->ebus, false);
 
-	ops = skl_get_dsp_ops(skl->pci->device);
-	if (!ops)
-		return -EIO;
-
-	ops->cleanup(bus->dev, ctx);
+	ctx->dsp_ops->cleanup(bus->dev, ctx);
 
 	if (ctx->dsp->addr.lpe)
 		iounmap(ctx->dsp->addr.lpe);
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index 9660ace379ab..7d21f055328d 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -105,6 +105,8 @@ struct skl_sst {
 	void (*update_d0i3c)(struct device *dev, bool enable);
 
 	struct skl_d0i3_data d0i3;
+
+	const struct skl_dsp_ops *dsp_ops;
 };
 
 struct skl_ipc_init_instance_msg {
-- 
2.11.0
