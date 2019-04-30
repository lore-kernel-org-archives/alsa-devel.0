From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 15/19] ASoC: SOF: Intel: hda-stream: handle
	real stream interrupts only
Date: Tue, 30 Apr 2019 18:09:30 -0500
Message-ID: <20190430230934.4321-16-pierre-louis.bossart@linux.intel.com>
References: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68122F8972A
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2019 01:10:06 +0200 (CEST)
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

The stream and IPC share the same interrupt. The stream interrupt
handler mistakenly uses the ipc interrupt and return IRQ_HANDLED,
causing the ipc interrupt to be missed.

Make sure the stream interrupt handler only deals with stream-related
interrupts.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-stream.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index 39f4212bde4b..c92006f89499 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -433,6 +433,8 @@ int hda_dsp_stream_hw_params(struct snd_sof_dev *sdev,
 irqreturn_t hda_dsp_stream_interrupt(int irq, void *context)
 {
 	struct hdac_bus *bus = context;
+	struct sof_intel_hda_dev *sof_hda = bus_to_sof_hda(bus);
+	u32 stream_mask;
 	u32 status;
 
 	if (!pm_runtime_active(bus->dev))
@@ -441,7 +443,10 @@ irqreturn_t hda_dsp_stream_interrupt(int irq, void *context)
 	spin_lock(&bus->reg_lock);
 
 	status = snd_hdac_chip_readl(bus, INTSTS);
-	if (status == 0 || status == 0xffffffff) {
+	stream_mask = GENMASK(sof_hda->stream_max - 1, 0) | AZX_INT_CTRL_EN;
+
+	/* Not stream interrupt or register inaccessible, ignore it.*/
+	if (!(status & stream_mask) || status == 0xffffffff) {
 		spin_unlock(&bus->reg_lock);
 		return IRQ_NONE;
 	}
-- 
2.17.1
