From: jeeja.kp@intel.com
Subject: [PATCH 08/10] ASoC: Intel: Skylake: Remove get dsp_ops
	in cleanup routine
Date: Tue,  7 Mar 2017 23:44:04 +0530
Message-ID: <1488910446-26415-9-git-send-email-jeeja.kp@intel.com>
References: <1488910446-26415-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id F2E5D267046
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 19:02:34 +0100 (CET)
In-Reply-To: <1488910446-26415-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, G Kranthi <gudishax.kranthikumar@intel.com>, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: G Kranthi <gudishax.kranthikumar@intel.com>

dsp ops is already set in init, so use the this in cleanup routine
instead of again retrieving it.

Signed-off-by: G Kranthi <gudishax.kranthikumar@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 8 ++------
 sound/soc/intel/skylake/skl-sst-ipc.h  | 2 ++
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 29523dd..ba1ec97 100644
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
index 9660ace..87ae03e 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -105,6 +105,8 @@ struct skl_sst {
 	void (*update_d0i3c)(struct device *dev, bool enable);
 
 	struct skl_d0i3_data d0i3;
+
+	struct skl_dsp_ops *dsp_ops;
 };
 
 struct skl_ipc_init_instance_msg {
-- 
2.5.0
