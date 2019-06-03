From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 7/8] ASoC: SOF: Intel: ipc: don't check for
	HIPCCTL register value
Date: Mon,  3 Jun 2019 11:20:31 -0500
Message-ID: <20190603162032.7626-8-pierre-louis.bossart@linux.intel.com>
References: <20190603162032.7626-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9194F8975E
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

The HIPCCTL register controls the IPC interrupts. It can be set or
cleared to mask or enable these interrupts, but it makes no sense to
read and test its fields in an interrupt (which can only executed if
its fields are set).

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/cnl.c     | 5 +----
 sound/soc/sof/intel/hda-ipc.c | 8 ++------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index b794a881542f..9a4927b6b6ae 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -31,7 +31,6 @@ static irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 {
 	struct snd_sof_dev *sdev = context;
 	u32 hipci;
-	u32 hipcctl;
 	u32 hipcida;
 	u32 hipctdr;
 	u32 hipctdd;
@@ -40,14 +39,12 @@ static irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 	bool ipc_irq = false;
 
 	hipcida = snd_sof_dsp_read(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCIDA);
-	hipcctl = snd_sof_dsp_read(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCCTL);
 	hipctdr = snd_sof_dsp_read(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCTDR);
 	hipctdd = snd_sof_dsp_read(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCTDD);
 	hipci = snd_sof_dsp_read(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCIDR);
 
 	/* reply message from DSP */
-	if (hipcida & CNL_DSP_REG_HIPCIDA_DONE &&
-	    hipcctl & CNL_DSP_REG_HIPCCTL_DONE) {
+	if (hipcida & CNL_DSP_REG_HIPCIDA_DONE) {
 		msg_ext = hipci & CNL_DSP_REG_HIPCIDR_MSG_MASK;
 		msg = hipcida & CNL_DSP_REG_HIPCIDA_MSG_MASK;
 
diff --git a/sound/soc/sof/intel/hda-ipc.c b/sound/soc/sof/intel/hda-ipc.c
index 04972f27ffe6..50244b82600c 100644
--- a/sound/soc/sof/intel/hda-ipc.c
+++ b/sound/soc/sof/intel/hda-ipc.c
@@ -135,7 +135,6 @@ irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context)
 	u32 hipcie;
 	u32 hipct;
 	u32 hipcte;
-	u32 hipcctl;
 	u32 msg;
 	u32 msg_ext;
 	bool ipc_irq = false;
@@ -144,13 +143,11 @@ irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context)
 	hipcie = snd_sof_dsp_read(sdev, HDA_DSP_BAR,
 				  HDA_DSP_REG_HIPCIE);
 	hipct = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_REG_HIPCT);
-	hipcctl = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_REG_HIPCCTL);
 	hipci = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_REG_HIPCI);
 	hipcte = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_REG_HIPCTE);
 
 	/* is this a reply message from the DSP */
-	if (hipcie & HDA_DSP_REG_HIPCIE_DONE &&
-	    hipcctl & HDA_DSP_REG_HIPCCTL_DONE) {
+	if (hipcie & HDA_DSP_REG_HIPCIE_DONE) {
 		msg = hipci & HDA_DSP_REG_HIPCI_MSG_MASK;
 		msg_ext = hipcie & HDA_DSP_REG_HIPCIE_MSG_MASK;
 
@@ -196,8 +193,7 @@ irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context)
 	}
 
 	/* is this a new message from DSP */
-	if (hipct & HDA_DSP_REG_HIPCT_BUSY &&
-	    hipcctl & HDA_DSP_REG_HIPCCTL_BUSY) {
+	if (hipct & HDA_DSP_REG_HIPCT_BUSY) {
 		msg = hipct & HDA_DSP_REG_HIPCT_MSG_MASK;
 		msg_ext = hipcte & HDA_DSP_REG_HIPCTE_MSG_MASK;
 
-- 
2.20.1
