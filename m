From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: Intel: remove an unused struct member
Date: Wed, 28 Jan 2015 09:42:10 +0300
Message-ID: <20150128064210.GA30893@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Jie Yang <yang.jie@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Christian Engelmayer <cengelma@gmx.at>, =?utf-8?B?UGF3ZcWC?= Piskorski <pawel.piskorski@intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We never set the ->scratch pointer, so let's delete it.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index eeef9a5..78daa46 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -277,7 +277,6 @@ struct sst_hsw {
 	/* FW config */
 	struct sst_hsw_ipc_fw_ready fw_ready;
 	struct sst_hsw_ipc_fw_version version;
-	struct sst_module *scratch;
 	bool fw_done;
 	struct sst_fw *sst_fw;
 
@@ -2135,7 +2134,6 @@ void sst_hsw_dsp_free(struct device *dev, struct sst_pdata *pdata)
 	dma_free_coherent(hsw->dsp->dma_dev, SST_HSW_DX_CONTEXT_SIZE,
 			hsw->dx_context, hsw->dx_context_paddr);
 	sst_dsp_free(hsw->dsp);
-	kfree(hsw->scratch);
 	kthread_stop(hsw->tx_thread);
 	kfree(hsw->msg);
 }
