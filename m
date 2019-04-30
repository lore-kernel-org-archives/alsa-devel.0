From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 13/19] ASoC: SOF: Intel: hda-ipc: simplify
	handling of IPC IRQ
Date: Tue, 30 Apr 2019 18:09:28 -0500
Message-ID: <20190430230934.4321-14-pierre-louis.bossart@linux.intel.com>
References: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10504F89729
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2019 01:10:04 +0200 (CEST)
In-Reply-To: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Keyon Jie <yang.jie@linux.intel.com>

When using a shared IRQ between IPC interrupt and stream IOC interrupt,
the interrupt handlers need to check the interrupt source before
scheduling their respective IRQ threads. In the case of IPC handler, it
should check if it is an IPC interrupt before waking up the IPC IRQ
thread.

The IPC IRQ thread, once scheduled, does not need to check the IRQ
source again. So, remove the superfluous check in the thread. Remove the
irq_status field from snd_sof_dev struct also as it is no longer needed.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/cnl.c     |  4 ----
 sound/soc/sof/intel/hda-ipc.c | 13 +++++--------
 sound/soc/sof/sof-priv.h      |  1 -
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index 3afd96d9c925..d128839b2450 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -39,10 +39,6 @@ static irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 	u32 msg_ext;
 	irqreturn_t ret = IRQ_NONE;
 
-	/* here we handle IPC interrupts only */
-	if (!(sdev->irq_status & HDA_DSP_ADSPIS_IPC))
-		return ret;
-
 	hipcida = snd_sof_dsp_read(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCIDA);
 	hipcctl = snd_sof_dsp_read(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCCTL);
 	hipctdr = snd_sof_dsp_read(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCTDR);
diff --git a/sound/soc/sof/intel/hda-ipc.c b/sound/soc/sof/intel/hda-ipc.c
index a938f568dbb1..73ead7070cde 100644
--- a/sound/soc/sof/intel/hda-ipc.c
+++ b/sound/soc/sof/intel/hda-ipc.c
@@ -145,10 +145,6 @@ irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context)
 	u32 msg;
 	u32 msg_ext;
 
-	/* here we handle IPC interrupts only */
-	if (!(sdev->irq_status & HDA_DSP_ADSPIS_IPC))
-		return IRQ_NONE;
-
 	/* read IPC status */
 	hipcie = snd_sof_dsp_read(sdev, HDA_DSP_BAR,
 				  HDA_DSP_REG_HIPCIE);
@@ -234,19 +230,20 @@ irqreturn_t hda_dsp_ipc_irq_handler(int irq, void *context)
 {
 	struct snd_sof_dev *sdev = context;
 	int ret = IRQ_NONE;
+	u32 irq_status;
 
 	spin_lock(&sdev->hw_lock);
 
 	/* store status */
-	sdev->irq_status = snd_sof_dsp_read(sdev, HDA_DSP_BAR,
-					    HDA_DSP_REG_ADSPIS);
+	irq_status = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_REG_ADSPIS);
+	dev_vdbg(sdev->dev, "irq handler: irq_status:0x%x\n", irq_status);
 
 	/* invalid message ? */
-	if (sdev->irq_status == 0xffffffff)
+	if (irq_status == 0xffffffff)
 		goto out;
 
 	/* IPC message ? */
-	if (sdev->irq_status & HDA_DSP_ADSPIS_IPC) {
+	if (irq_status & HDA_DSP_ADSPIS_IPC) {
 		/* disable IPC interrupt */
 		snd_sof_dsp_update_bits_unlocked(sdev, HDA_DSP_BAR,
 						 HDA_DSP_REG_ADSPIC,
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 675bb10c82f5..bbc285018f9a 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -366,7 +366,6 @@ struct snd_sof_dev {
 	struct snd_sof_mailbox host_box;	/* Host initiated IPC */
 	struct snd_sof_mailbox stream_box;	/* Stream position update */
 	struct snd_sof_ipc_msg *msg;
-	u64 irq_status;
 	int ipc_irq;
 	u32 next_comp_id; /* monotonic - reset during S3 */
 
-- 
2.17.1
