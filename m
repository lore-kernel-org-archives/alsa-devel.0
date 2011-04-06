From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 4/4] sst: make register_sst_card more
	self-contained
Date: Wed, 06 Apr 2011 10:20:42 +0800
Message-ID: <20110406022042.28406.78049.stgit@localhost>
References: <20110406022026.28406.98577.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id F2C9D10384C
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Apr 2011 04:20:18 +0200 (CEST)
In-Reply-To: <20110406022026.28406.98577.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>
Cc: Koul Vinod <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>, Harsha Priya <priya.harsha@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

From: Lu Guanqun <guanqun.lu@intel.com>

register_sst_card is used in ASoC code with field `scard_ops` being NULL.
Without this patch, there will be NULL dereference.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 .../staging/intel_sst/intel_sst_drv_interface.c    |    1 -
 drivers/staging/intel_sst/intelmid.c               |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/intel_sst/intel_sst_drv_interface.c b/drivers/staging/intel_sst/intel_sst_drv_interface.c
index ea8e251..cf10dd6 100644
--- a/drivers/staging/intel_sst/intel_sst_drv_interface.c
+++ b/drivers/staging/intel_sst/intel_sst_drv_interface.c
@@ -508,7 +508,6 @@ int register_sst_card(struct intel_sst_card_ops *card)
 			sst_drv_ctx->pmic_state = SND_MAD_INIT_DONE;
 			sst_drv_ctx->rx_time_slot_status = 0; /*default AMIC*/
 			card->pcm_control = sst_pmic_ops.pcm_control;
-			sst_drv_ctx->scard_ops->card_status = SND_CARD_UN_INIT;
 			return 0;
 		} else {
 			pr_err("strcmp fail %s\n", card->module_name);
diff --git a/drivers/staging/intel_sst/intelmid.c b/drivers/staging/intel_sst/intelmid.c
index fb22921..1fb39d4 100644
--- a/drivers/staging/intel_sst/intelmid.c
+++ b/drivers/staging/intel_sst/intelmid.c
@@ -802,6 +802,7 @@ static int __devinit snd_intelmad_sst_register(
 		pr_err("sst card registration failed\n");
 		return ret_val;
 	}
+	sst_drv_ctx->scard_ops->card_status = SND_CARD_UN_INIT;
 
 	sst_card_vendor_id = intelmaddata->sstdrv_ops->vendor_id;
 	intelmaddata->pmic_status = PMIC_UNINIT;
