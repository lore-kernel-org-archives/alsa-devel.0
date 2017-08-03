From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: cnl: Unstatify common ipc
	functions" to the asoc tree
Date: Thu, 03 Aug 2017 17:30:10 +0100
Message-ID: <E1ddJ0k-0002Uk-6Z@debutante>
References: <20170802162120.8935-7-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B26A267411
 for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2017 18:30:20 +0200 (CEST)
In-Reply-To: <20170802162120.8935-7-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: cnl: Unstatify common ipc functions

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 4bdb04f0e1b7600b87a92b4f98ba5490ceffdf4f Mon Sep 17 00:00:00 2001
From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Date: Wed, 2 Aug 2017 21:51:17 +0530
Subject: [PATCH] ASoC: Intel: cnl: Unstatify common ipc functions

Common ipc functions can be reused for cnl, so make them non-static.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-ipc.c | 6 +++---
 sound/soc/intel/skylake/skl-sst-ipc.h | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 498b15345b1a..5234fafb758a 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -283,7 +283,7 @@ enum skl_ipc_module_msg {
 	IPC_MOD_SET_D0IX = 8
 };
 
-static void skl_ipc_tx_data_copy(struct ipc_message *msg, char *tx_data,
+void skl_ipc_tx_data_copy(struct ipc_message *msg, char *tx_data,
 		size_t tx_size)
 {
 	if (tx_size)
@@ -347,7 +347,7 @@ static struct ipc_message *skl_ipc_reply_get_msg(struct sst_generic_ipc *ipc,
 
 }
 
-static int skl_ipc_process_notification(struct sst_generic_ipc *ipc,
+int skl_ipc_process_notification(struct sst_generic_ipc *ipc,
 		struct skl_ipc_header header)
 {
 	struct skl_sst *skl = container_of(ipc, struct skl_sst, ipc);
@@ -406,7 +406,7 @@ static int skl_ipc_set_reply_error_code(u32 reply)
 	}
 }
 
-static void skl_ipc_process_reply(struct sst_generic_ipc *ipc,
+void skl_ipc_process_reply(struct sst_generic_ipc *ipc,
 		struct skl_ipc_header header)
 {
 	struct ipc_message *msg;
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index e485e8f5ea2c..55f2d2ce09df 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -212,4 +212,10 @@ void skl_ipc_free(struct sst_generic_ipc *ipc);
 int skl_ipc_init(struct device *dev, struct skl_sst *skl);
 void skl_clear_module_cnt(struct sst_dsp *ctx);
 
+void skl_ipc_process_reply(struct sst_generic_ipc *ipc,
+		struct skl_ipc_header header);
+int skl_ipc_process_notification(struct sst_generic_ipc *ipc,
+		struct skl_ipc_header header);
+void skl_ipc_tx_data_copy(struct ipc_message *msg, char *tx_data,
+		size_t tx_size);
 #endif /* __SKL_IPC_H */
-- 
2.13.2
