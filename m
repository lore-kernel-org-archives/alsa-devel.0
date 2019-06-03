From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 5/8] ASoC: SOF: Intel: hda-ipc: read all IPC
	registers first
Date: Mon,  3 Jun 2019 11:20:29 -0500
Message-ID: <20190603162032.7626-6-pierre-louis.bossart@linux.intel.com>
References: <20190603162032.7626-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D4A8F896ED
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 18:20:43 +0200 (CEST)
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

Align with hardware recommended sequences, and read all IPC registers
before doing any other actions. Playing with BUSY and DONE bits may
invalidate values.

The values read may not actually be necessary but at least this
provides a snapshot of the IPC registers with no consistency issues.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-ipc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/intel/hda-ipc.c b/sound/soc/sof/intel/hda-ipc.c
index 728dd1e075a4..1f01897fa6e3 100644
--- a/sound/soc/sof/intel/hda-ipc.c
+++ b/sound/soc/sof/intel/hda-ipc.c
@@ -145,6 +145,8 @@ irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context)
 				  HDA_DSP_REG_HIPCIE);
 	hipct = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_REG_HIPCT);
 	hipcctl = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_REG_HIPCCTL);
+	hipci = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_REG_HIPCI);
+	hipcte = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_REG_HIPCTE);
 
 	/* reenable IPC interrupt */
 	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, HDA_DSP_REG_ADSPIC,
@@ -153,8 +155,6 @@ irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context)
 	/* is this a reply message from the DSP */
 	if (hipcie & HDA_DSP_REG_HIPCIE_DONE &&
 	    hipcctl & HDA_DSP_REG_HIPCCTL_DONE) {
-		hipci = snd_sof_dsp_read(sdev, HDA_DSP_BAR,
-					 HDA_DSP_REG_HIPCI);
 		msg = hipci & HDA_DSP_REG_HIPCI_MSG_MASK;
 		msg_ext = hipcie & HDA_DSP_REG_HIPCIE_MSG_MASK;
 
@@ -202,9 +202,6 @@ irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context)
 	/* is this a new message from DSP */
 	if (hipct & HDA_DSP_REG_HIPCT_BUSY &&
 	    hipcctl & HDA_DSP_REG_HIPCCTL_BUSY) {
-
-		hipcte = snd_sof_dsp_read(sdev, HDA_DSP_BAR,
-					  HDA_DSP_REG_HIPCTE);
 		msg = hipct & HDA_DSP_REG_HIPCT_MSG_MASK;
 		msg_ext = hipcte & HDA_DSP_REG_HIPCTE_MSG_MASK;
 
-- 
2.20.1
