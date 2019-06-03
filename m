From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/8] ASoC: SOF: Intel: cnl-ipc: move code
	around for clarity
Date: Mon,  3 Jun 2019 11:20:27 -0500
Message-ID: <20190603162032.7626-4-pierre-louis.bossart@linux.intel.com>
References: <20190603162032.7626-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0B7FF896DE
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 18:20:41 +0200 (CEST)
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

Move all register access to cnl_ipc_host_done()
No functionality change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/cnl.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index 1fae75fc313f..4ecba1d8ec7f 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -99,15 +99,6 @@ static irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 			snd_sof_ipc_msgs_rx(sdev);
 		}
 
-		/*
-		 * clear busy interrupt to tell dsp controller this
-		 * interrupt has been accepted, not trigger it again
-		 */
-		snd_sof_dsp_update_bits_forced(sdev, HDA_DSP_BAR,
-					       CNL_DSP_REG_HIPCTDR,
-					       CNL_DSP_REG_HIPCTDR_BUSY,
-					       CNL_DSP_REG_HIPCTDR_BUSY);
-
 		cnl_ipc_host_done(sdev);
 
 		ret = IRQ_HANDLED;
@@ -118,6 +109,14 @@ static irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 
 static void cnl_ipc_host_done(struct snd_sof_dev *sdev)
 {
+	/*
+	 * clear busy interrupt to tell dsp controller this
+	 * interrupt has been accepted, not trigger it again
+	 */
+	snd_sof_dsp_update_bits_forced(sdev, HDA_DSP_BAR,
+				       CNL_DSP_REG_HIPCTDR,
+				       CNL_DSP_REG_HIPCTDR_BUSY,
+				       CNL_DSP_REG_HIPCTDR_BUSY);
 	/*
 	 * set done bit to ack dsp the msg has been
 	 * processed and send reply msg to dsp
-- 
2.20.1
