From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Flush pending D0i3
	request on suspend" to the asoc tree
Date: Wed, 09 Nov 2016 15:25:25 +0000
Message-ID: <E1c4Ukf-0003gv-CY@finisterre>
References: <1474868137-29712-10-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BD8B8267097
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2016 16:25:40 +0100 (CET)
In-Reply-To: <1474868137-29712-10-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jayachandran B <jayachandran.b@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Flush pending D0i3 request on suspend

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

>From 8b4a133c6145a34618c770117b65b33f1aa993aa Mon Sep 17 00:00:00 2001
From: Jayachandran B <jayachandran.b@intel.com>
Date: Thu, 3 Nov 2016 17:07:21 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Flush pending D0i3 request on suspend

While going to suspend, if we have any pending D0i3 work scheduled,
flush that and force the DSP to goto D0i3 mode before going to suspend.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 27 +++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl.c          | 10 ++++++++++
 sound/soc/intel/skylake/skl.h          |  1 +
 3 files changed, 38 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 87fc647fa04c..4ae021aabc3a 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -294,6 +294,33 @@ int skl_free_dsp(struct skl *skl)
 	return 0;
 }
 
+/*
+ * In the case of "suspend_active" i.e, the Audio IP being active
+ * during system suspend, immediately excecute any pending D0i3 work
+ * before suspending. This is needed for the IP to work in low power
+ * mode during system suspend. In the case of normal suspend, cancel
+ * any pending D0i3 work.
+ */
+int skl_suspend_late_dsp(struct skl *skl)
+{
+	struct skl_sst *ctx = skl->skl_sst;
+	struct delayed_work *dwork;
+
+	if (!ctx)
+		return 0;
+
+	dwork = &ctx->d0i3.work;
+
+	if (dwork->work.func) {
+		if (skl->supend_active)
+			flush_delayed_work(dwork);
+		else
+			cancel_delayed_work_sync(dwork);
+	}
+
+	return 0;
+}
+
 int skl_suspend_dsp(struct skl *skl)
 {
 	struct skl_sst *ctx = skl->skl_sst;
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index ed59783e9846..61a484888cfa 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -228,6 +228,15 @@ static int skl_acquire_irq(struct hdac_ext_bus *ebus, int do_disconnect)
 	return 0;
 }
 
+static int skl_suspend_late(struct device *dev)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
+	struct skl *skl = ebus_to_skl(ebus);
+
+	return skl_suspend_late_dsp(skl);
+}
+
 #ifdef CONFIG_PM
 static int _skl_suspend(struct hdac_ext_bus *ebus)
 {
@@ -390,6 +399,7 @@ static int skl_runtime_resume(struct device *dev)
 static const struct dev_pm_ops skl_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(skl_suspend, skl_resume)
 	SET_RUNTIME_PM_OPS(skl_runtime_suspend, skl_runtime_resume, NULL)
+	.suspend_late = skl_suspend_late,
 };
 
 /*
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 88ba54ba5f72..4986e3929dd3 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -124,6 +124,7 @@ int skl_get_dmic_geo(struct skl *skl);
 int skl_nhlt_update_topology_bin(struct skl *skl);
 int skl_init_dsp(struct skl *skl);
 int skl_free_dsp(struct skl *skl);
+int skl_suspend_late_dsp(struct skl *skl);
 int skl_suspend_dsp(struct skl *skl);
 int skl_resume_dsp(struct skl *skl);
 void skl_cleanup_resources(struct skl *skl);
-- 
2.10.2
