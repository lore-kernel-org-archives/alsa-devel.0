From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 6/8] ASoC: SOF: Intel: hda-ipc: re-enable IPC
	IRQ at end of handler
Date: Mon,  3 Jun 2019 11:20:30 -0500
Message-ID: <20190603162032.7626-7-pierre-louis.bossart@linux.intel.com>
References: <20190603162032.7626-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8DADF8975D
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 18:20:44 +0200 (CEST)
In-Reply-To: <20190603162032.7626-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Align with Skylake driver and enable the IRQ at end of handler,
instead of at beginning.

Also add an error log if we have nothing to do in this handler.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-ipc.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/intel/hda-ipc.c b/sound/soc/sof/intel/hda-ipc.c
index 1f01897fa6e3..04972f27ffe6 100644
--- a/sound/soc/sof/intel/hda-ipc.c
+++ b/sound/soc/sof/intel/hda-ipc.c
@@ -131,7 +131,6 @@ static bool hda_dsp_ipc_is_sof(uint32_t msg)
 irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context)
 {
 	struct snd_sof_dev *sdev = context;
-	irqreturn_t ret = IRQ_NONE;
 	u32 hipci;
 	u32 hipcie;
 	u32 hipct;
@@ -139,6 +138,7 @@ irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context)
 	u32 hipcctl;
 	u32 msg;
 	u32 msg_ext;
+	bool ipc_irq = false;
 
 	/* read IPC status */
 	hipcie = snd_sof_dsp_read(sdev, HDA_DSP_BAR,
@@ -148,10 +148,6 @@ irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context)
 	hipci = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_REG_HIPCI);
 	hipcte = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_REG_HIPCTE);
 
-	/* reenable IPC interrupt */
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, HDA_DSP_REG_ADSPIC,
-				HDA_DSP_ADSPIC_IPC, HDA_DSP_ADSPIC_IPC);
-
 	/* is this a reply message from the DSP */
 	if (hipcie & HDA_DSP_REG_HIPCIE_DONE &&
 	    hipcctl & HDA_DSP_REG_HIPCCTL_DONE) {
@@ -196,7 +192,7 @@ irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context)
 
 		spin_unlock_irq(&sdev->ipc_lock);
 
-		ret = IRQ_HANDLED;
+		ipc_irq = true;
 	}
 
 	/* is this a new message from DSP */
@@ -225,10 +221,22 @@ irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context)
 
 		hda_dsp_ipc_host_done(sdev);
 
-		ret = IRQ_HANDLED;
+		ipc_irq = true;
 	}
 
-	return ret;
+	if (!ipc_irq) {
+		/*
+		 * This interrupt is not shared so no need to return IRQ_NONE.
+		 */
+		dev_err_ratelimited(sdev->dev,
+				    "error: nothing to do in IRQ thread\n");
+	}
+
+	/* re-enable IPC interrupt */
+	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, HDA_DSP_REG_ADSPIC,
+				HDA_DSP_ADSPIC_IPC, HDA_DSP_ADSPIC_IPC);
+
+	return IRQ_HANDLED;
 }
 
 /* is this IRQ for ADSP ? - we only care about IPC here */
-- 
2.20.1
