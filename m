From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Add generic support for DSP wake,
	sleep and stall
Date: Wed, 29 Oct 2014 15:40:28 +0000
Message-ID: <1414597228-7070-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1414597228-7070-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A85742604E5
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 16:41:05 +0100 (CET)
In-Reply-To: <1414597228-7070-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add generic functions to support DSP sleep, wake and stall.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-dsp-priv.h |  3 +++
 sound/soc/intel/sst-dsp.c      | 23 +++++++++++++++++++++++
 sound/soc/intel/sst-dsp.h      |  4 ++++
 3 files changed, 30 insertions(+)

diff --git a/sound/soc/intel/sst-dsp-priv.h b/sound/soc/intel/sst-dsp-priv.h
index be81b86..b9da030 100644
--- a/sound/soc/intel/sst-dsp-priv.h
+++ b/sound/soc/intel/sst-dsp-priv.h
@@ -36,6 +36,9 @@ struct sst_ops {
 	/* DSP core boot / reset */
 	void (*boot)(struct sst_dsp *);
 	void (*reset)(struct sst_dsp *);
+	int (*wake)(struct sst_dsp *);
+	void (*sleep)(struct sst_dsp *);
+	void (*stall)(struct sst_dsp *);
 
 	/* Shim IO */
 	void (*write)(void __iomem *addr, u32 offset, u32 value);
diff --git a/sound/soc/intel/sst-dsp.c b/sound/soc/intel/sst-dsp.c
index d0fc685..86e4108 100644
--- a/sound/soc/intel/sst-dsp.c
+++ b/sound/soc/intel/sst-dsp.c
@@ -245,6 +245,29 @@ int sst_dsp_boot(struct sst_dsp *sst)
 }
 EXPORT_SYMBOL_GPL(sst_dsp_boot);
 
+int sst_dsp_wake(struct sst_dsp *sst)
+{
+	if (sst->ops->wake)
+		return sst->ops->wake(sst);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sst_dsp_wake);
+
+void sst_dsp_sleep(struct sst_dsp *sst)
+{
+	if (sst->ops->sleep)
+		sst->ops->sleep(sst);
+}
+EXPORT_SYMBOL_GPL(sst_dsp_sleep);
+
+void sst_dsp_stall(struct sst_dsp *sst)
+{
+	if (sst->ops->stall)
+		sst->ops->stall(sst);
+}
+EXPORT_SYMBOL_GPL(sst_dsp_stall);
+
 void sst_dsp_ipc_msg_tx(struct sst_dsp *dsp, u32 msg)
 {
 	sst_dsp_shim_write_unlocked(dsp, SST_IPCX, msg | SST_IPCX_BUSY);
diff --git a/sound/soc/intel/sst-dsp.h b/sound/soc/intel/sst-dsp.h
index 17ee923..7bb4820 100644
--- a/sound/soc/intel/sst-dsp.h
+++ b/sound/soc/intel/sst-dsp.h
@@ -245,6 +245,10 @@ void sst_memcpy_fromio_32(struct sst_dsp *sst,
 /* DSP reset & boot */
 void sst_dsp_reset(struct sst_dsp *sst);
 int sst_dsp_boot(struct sst_dsp *sst);
+int sst_dsp_wake(struct sst_dsp *sst);
+void sst_dsp_sleep(struct sst_dsp *sst);
+void sst_dsp_stall(struct sst_dsp *sst);
+
 /* DMA */
 int sst_dsp_dma_get_channel(struct sst_dsp *dsp, int chan_id);
 void sst_dsp_dma_put_channel(struct sst_dsp *dsp);
-- 
2.1.0
