From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 08/15] ASoC: SOF: Intel: hda: modify stream
	interrupt handler
Date: Wed, 12 Jun 2019 12:23:40 -0500
Message-ID: <20190612172347.22338-9-pierre-louis.bossart@linux.intel.com>
References: <20190612172347.22338-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73BCDF89730
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 19:24:00 +0200 (CEST)
In-Reply-To: <20190612172347.22338-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Modify the stream interrupt handler to always wake up the
IRQ thread if the status register is valid. The IRQ thread
performs the check for stream interrupts and RIRB interrupts
in a loop to handle the case of missed interrupts when an
unsolicited response from the codec is received just before the
stream interrupt handler is completed.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-stream.c | 79 +++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 28 deletions(-)

diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index ff6ab0c45d8e..d44318040948 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -461,57 +461,40 @@ int hda_dsp_stream_hw_free(struct snd_sof_dev *sdev,
 irqreturn_t hda_dsp_stream_interrupt(int irq, void *context)
 {
 	struct hdac_bus *bus = context;
-	struct sof_intel_hda_dev *sof_hda = bus_to_sof_hda(bus);
-	u32 stream_mask;
+	int ret = IRQ_WAKE_THREAD;
 	u32 status;
 
-	if (!pm_runtime_active(bus->dev))
-		return IRQ_NONE;
-
 	spin_lock(&bus->reg_lock);
 
 	status = snd_hdac_chip_readl(bus, INTSTS);
-	stream_mask = GENMASK(sof_hda->stream_max - 1, 0) | AZX_INT_CTRL_EN;
-
-	/* Not stream interrupt or register inaccessible, ignore it.*/
-	if (!(status & stream_mask) || status == 0xffffffff) {
-		spin_unlock(&bus->reg_lock);
-		return IRQ_NONE;
-	}
+	dev_vdbg(bus->dev, "stream irq, INTSTS status: 0x%x\n", status);
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
-	/* clear rirb int */
-	status = snd_hdac_chip_readb(bus, RIRBSTS);
-	if (status & RIRB_INT_MASK) {
-		if (status & RIRB_INT_RESPONSE)
-			snd_hdac_bus_update_rirb(bus);
-		snd_hdac_chip_writeb(bus, RIRBSTS, RIRB_INT_MASK);
-	}
-#endif
+	/* Register inaccessible, ignore it.*/
+	if (status == 0xffffffff)
+		ret = IRQ_NONE;
 
 	spin_unlock(&bus->reg_lock);
 
-	return snd_hdac_chip_readl(bus, INTSTS) ? IRQ_WAKE_THREAD : IRQ_HANDLED;
+	return ret;
 }
 
-irqreturn_t hda_dsp_stream_threaded_handler(int irq, void *context)
+static bool hda_dsp_stream_check(struct hdac_bus *bus, u32 status)
 {
-	struct hdac_bus *bus = context;
 	struct sof_intel_hda_dev *sof_hda = bus_to_sof_hda(bus);
-	u32 status = snd_hdac_chip_readl(bus, INTSTS);
 	struct hdac_stream *s;
+	bool active = false;
 	u32 sd_status;
 
-	/* check streams */
 	list_for_each_entry(s, &bus->stream_list, list) {
-		if (status & (1 << s->index) && s->opened) {
+		if (status & BIT(s->index) && s->opened) {
 			sd_status = snd_hdac_stream_readb(s, SD_STS);
 
 			dev_vdbg(bus->dev, "stream %d status 0x%x\n",
 				 s->index, sd_status);
 
-			snd_hdac_stream_writeb(s, SD_STS, SD_INT_MASK);
+			snd_hdac_stream_writeb(s, SD_STS, sd_status);
 
+			active = true;
 			if (!s->substream ||
 			    !s->running ||
 			    (sd_status & SOF_HDA_CL_DMA_SD_INT_COMPLETE) == 0)
@@ -520,8 +503,48 @@ irqreturn_t hda_dsp_stream_threaded_handler(int irq, void *context)
 			/* Inform ALSA only in case not do that with IPC */
 			if (sof_hda->no_ipc_position)
 				snd_sof_pcm_period_elapsed(s->substream);
+		}
+	}
+
+	return active;
+}
 
+irqreturn_t hda_dsp_stream_threaded_handler(int irq, void *context)
+{
+	struct hdac_bus *bus = context;
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	u32 rirb_status;
+#endif
+	bool active;
+	u32 status;
+	int i;
+
+	/*
+	 * Loop 10 times to handle missed interrupts caused by
+	 * unsolicited responses from the codec
+	 */
+	for (i = 0, active = true; i < 10 && active; i++) {
+		spin_lock_irq(&bus->reg_lock);
+
+		status = snd_hdac_chip_readl(bus, INTSTS);
+
+		/* check streams */
+		active = hda_dsp_stream_check(bus, status);
+
+		/* check and clear RIRB interrupt */
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+		if (status & AZX_INT_CTRL_EN) {
+			rirb_status = snd_hdac_chip_readb(bus, RIRBSTS);
+			if (rirb_status & RIRB_INT_MASK) {
+				active = true;
+				if (rirb_status & RIRB_INT_RESPONSE)
+					snd_hdac_bus_update_rirb(bus);
+				snd_hdac_chip_writeb(bus, RIRBSTS,
+						     RIRB_INT_MASK);
+			}
 		}
+#endif
+		spin_unlock_irq(&bus->reg_lock);
 	}
 
 	return IRQ_HANDLED;
-- 
2.20.1
