From: cezary.rojewski@intel.com
Subject: [PATCH 3/7] ASoC: Intel: Skylake: Read HIPCT extension
	before clearing DONE bit
Date: Thu, 13 Jun 2019 21:04:32 +0200
Message-ID: <20190613190436.20156-4-cezary.rojewski@intel.com>
References: <20190613190436.20156-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68BBFF89711
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 21:05:28 +0200 (CEST)
In-Reply-To: <20190613190436.20156-1-cezary.rojewski@intel.com>
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
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Cezary Rojewski <cezary.rojewski@intel.com>

Host clears DONE bit to signal IPC target it has completed the
operation. Once this is done, IPC target i.e. DSP may proceed with the
next reply, filling registers with new portion of data.

Because of this, host should always read all registers prior to clearing
DONE and BUSY bits to ensure no desynchronization happens the time in
between clearing bits and reading message data (here, extension).

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/cnl-sst.c     | 2 +-
 sound/soc/intel/skylake/skl-sst-ipc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index 245df1067ba8..759ea59615ca 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -313,6 +313,7 @@ static irqreturn_t cnl_dsp_irq_thread_handler(int irq, void *context)
 
 	hipcida = sst_dsp_shim_read_unlocked(dsp, CNL_ADSP_REG_HIPCIDA);
 	hipctdr = sst_dsp_shim_read_unlocked(dsp, CNL_ADSP_REG_HIPCTDR);
+	hipctdd = sst_dsp_shim_read_unlocked(dsp, CNL_ADSP_REG_HIPCTDD);
 
 	/* reply message from dsp */
 	if (hipcida & CNL_ADSP_REG_HIPCIDA_DONE) {
@@ -332,7 +333,6 @@ static irqreturn_t cnl_dsp_irq_thread_handler(int irq, void *context)
 
 	/* new message from dsp */
 	if (hipctdr & CNL_ADSP_REG_HIPCTDR_BUSY) {
-		hipctdd = sst_dsp_shim_read_unlocked(dsp, CNL_ADSP_REG_HIPCTDD);
 		header.primary = hipctdr;
 		header.extension = hipctdd;
 		dev_dbg(dsp->dev, "IPC irq: Firmware respond primary:%x",
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 9f3ce73593ae..5c9206dc7932 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -511,6 +511,7 @@ irqreturn_t skl_dsp_irq_thread_handler(int irq, void *context)
 
 	hipcie = sst_dsp_shim_read_unlocked(dsp, SKL_ADSP_REG_HIPCIE);
 	hipct = sst_dsp_shim_read_unlocked(dsp, SKL_ADSP_REG_HIPCT);
+	hipcte = sst_dsp_shim_read_unlocked(dsp, SKL_ADSP_REG_HIPCTE);
 
 	/* reply message from DSP */
 	if (hipcie & SKL_ADSP_REG_HIPCIE_DONE) {
@@ -530,7 +531,6 @@ irqreturn_t skl_dsp_irq_thread_handler(int irq, void *context)
 
 	/* New message from DSP */
 	if (hipct & SKL_ADSP_REG_HIPCT_BUSY) {
-		hipcte = sst_dsp_shim_read_unlocked(dsp, SKL_ADSP_REG_HIPCTE);
 		header.primary = hipct;
 		header.extension = hipcte;
 		dev_dbg(dsp->dev, "IPC irq: Firmware respond primary:%x\n",
-- 
2.17.1
