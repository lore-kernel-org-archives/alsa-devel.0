From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/8] ASoC: SOF: Intel: cnl-ipc: read all IPC
	registers first
Date: Mon,  3 Jun 2019 11:20:26 -0500
Message-ID: <20190603162032.7626-3-pierre-louis.bossart@linux.intel.com>
References: <20190603162032.7626-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 412A1F896DD
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

Align with hardware recommended sequences, and read all IPC registers
before doing any other actions. Playing with BUSY and DONE bits may
invalidate values.

The values read may not actually be necessary but at least this
provides a snapshot of the IPC registers with no consistency issues.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/cnl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index fd86269b5037..1fae75fc313f 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -42,6 +42,8 @@ static irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 	hipcida = snd_sof_dsp_read(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCIDA);
 	hipcctl = snd_sof_dsp_read(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCCTL);
 	hipctdr = snd_sof_dsp_read(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCTDR);
+	hipctdd = snd_sof_dsp_read(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCTDD);
+	hipci = snd_sof_dsp_read(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCIDR);
 
 	/* reenable IPC interrupt */
 	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, HDA_DSP_REG_ADSPIC,
@@ -50,8 +52,6 @@ static irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 	/* reply message from DSP */
 	if (hipcida & CNL_DSP_REG_HIPCIDA_DONE &&
 	    hipcctl & CNL_DSP_REG_HIPCCTL_DONE) {
-		hipci = snd_sof_dsp_read(sdev, HDA_DSP_BAR,
-					 CNL_DSP_REG_HIPCIDR);
 		msg_ext = hipci & CNL_DSP_REG_HIPCIDR_MSG_MASK;
 		msg = hipcida & CNL_DSP_REG_HIPCIDA_MSG_MASK;
 
@@ -84,8 +84,6 @@ static irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 
 	/* new message from DSP */
 	if (hipctdr & CNL_DSP_REG_HIPCTDR_BUSY) {
-		hipctdd = snd_sof_dsp_read(sdev, HDA_DSP_BAR,
-					   CNL_DSP_REG_HIPCTDD);
 		msg = hipctdr & CNL_DSP_REG_HIPCTDR_MSG_MASK;
 		msg_ext = hipctdd & CNL_DSP_REG_HIPCTDD_MSG_MASK;
 
-- 
2.20.1
