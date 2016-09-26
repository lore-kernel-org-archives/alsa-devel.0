From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 09/10] ASoC: Intel: Skylake: Flush pending D0i3
	request on suspend
Date: Mon, 26 Sep 2016 11:05:36 +0530
Message-ID: <1474868137-29712-10-git-send-email-vinod.koul@intel.com>
References: <1474868137-29712-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B246E26672C
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 07:27:30 +0200 (CEST)
In-Reply-To: <1474868137-29712-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jayachandran B <jayachandran.b@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jayachandran B <jayachandran.b@intel.com>

While going to suspend, if we have any pending D0i3 work scheduled,
flush that and force the DSP to goto D0i3 mode before going to suspend.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
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
index b9209af89915..ff08c8ec93a1 100644
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
@@ -392,6 +401,7 @@ static int skl_runtime_resume(struct device *dev)
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
1.9.1
