From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 20/21] ASoC: SOF: Intel: hda: remove misleading
	error trace from IRQ thread
Date: Mon, 22 Jul 2019 09:14:01 -0500
Message-ID: <20190722141402.7194-21-pierre-louis.bossart@linux.intel.com>
References: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7BADF803D6
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 16:14:25 +0200 (CEST)
In-Reply-To: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Downgrade "nothing to do in IRQ thread" message from error to a debug
message in the IPC interrupt handler thread.

The spurious wake-up can happen if a HDA stream interrupt is
raised while the IPC interrupt thread is running. IPC functionality
is not impacted by this condition, so debug is a more appropriate
trace level.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/cnl.c     | 4 ++--
 sound/soc/sof/intel/hda-ipc.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index f2b392998f20..ffd8d4394537 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -101,8 +101,8 @@ static irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 		/*
 		 * This interrupt is not shared so no need to return IRQ_NONE.
 		 */
-		dev_err_ratelimited(sdev->dev,
-				    "error: nothing to do in IRQ thread\n");
+		dev_dbg_ratelimited(sdev->dev,
+				    "nothing to do in IPC IRQ thread\n");
 	}
 
 	/* re-enable IPC interrupt */
diff --git a/sound/soc/sof/intel/hda-ipc.c b/sound/soc/sof/intel/hda-ipc.c
index 50244b82600c..2ecba91f5219 100644
--- a/sound/soc/sof/intel/hda-ipc.c
+++ b/sound/soc/sof/intel/hda-ipc.c
@@ -224,8 +224,8 @@ irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context)
 		/*
 		 * This interrupt is not shared so no need to return IRQ_NONE.
 		 */
-		dev_err_ratelimited(sdev->dev,
-				    "error: nothing to do in IRQ thread\n");
+		dev_dbg_ratelimited(sdev->dev,
+				    "nothing to do in IPC IRQ thread\n");
 	}
 
 	/* re-enable IPC interrupt */
-- 
2.20.1
