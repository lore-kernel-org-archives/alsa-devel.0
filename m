From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 5/7] ASoC: Intel: Allow Rx/Tx message list can
	be cleared prior to suspend
Date: Thu,  8 May 2014 16:07:25 +0300
Message-ID: <1399554447-16297-6-git-send-email-jarkko.nikula@linux.intel.com>
References: <1399554447-16297-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CD2426547A
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 15:08:28 +0200 (CEST)
In-Reply-To: <1399554447-16297-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Suspend/resume requires reloading FW to boot state so we need to also make
sure that the driver matches the FW state at boot.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/sst-baytrail-ipc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/intel/sst-baytrail-ipc.c b/sound/soc/intel/sst-baytrail-ipc.c
index 8941ff2f4b78..2487b6e2dfec 100644
--- a/sound/soc/intel/sst-baytrail-ipc.c
+++ b/sound/soc/intel/sst-baytrail-ipc.c
@@ -299,6 +299,24 @@ static inline void sst_byt_tx_msg_reply_complete(struct sst_byt *byt,
 		wake_up(&msg->waitq);
 }
 
+static void sst_byt_drop_all(struct sst_byt *byt)
+{
+	struct ipc_message *msg, *tmp;
+	unsigned long flags;
+
+	/* drop all TX and Rx messages before we stall + reset DSP */
+	spin_lock_irqsave(&byt->dsp->spinlock, flags);
+	list_for_each_entry_safe(msg, tmp, &byt->tx_list, list) {
+		list_move(&msg->list, &byt->empty_list);
+	}
+
+	list_for_each_entry_safe(msg, tmp, &byt->rx_list, list) {
+		list_move(&msg->list, &byt->empty_list);
+	}
+
+	spin_unlock_irqrestore(&byt->dsp->spinlock, flags);
+}
+
 static int sst_byt_tx_wait_done(struct sst_byt *byt, struct ipc_message *msg,
 				void *rx_data)
 {
-- 
2.0.0.rc0
