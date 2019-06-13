From: cezary.rojewski@intel.com
Subject: [PATCH 4/7] ASoC: Intel: Fix race condition in IPC rx
	list
Date: Thu, 13 Jun 2019 21:04:33 +0200
Message-ID: <20190613190436.20156-5-cezary.rojewski@intel.com>
References: <20190613190436.20156-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C0B5F89714
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 21:05:31 +0200 (CEST)
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
Cc: lgirdwood@gmail.com, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Gustaw Lewandowski <gustaw.lewandowski@intel.com>

Since there are multiple IPCs being sent in a short span of time, there
is a possibility of more than one message being on the Rx list after
receiving response from firmware. In such cases, when the first
notification of interrupt from firmware is received, driver retrieves
the message from the Rx list but does not delete it from the list till
the next lock. In the meantime, when another interrupt is received from
the firmware, driver is reading the previous message again since the
previous message has not been removed from the list.

Signed-off-by: Gustaw Lewandowski <gustaw.lewandowski@intel.com>
---
 sound/soc/intel/skylake/skl-sst-ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 5c9206dc7932..5094205a243f 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -344,6 +344,7 @@ static struct ipc_message *skl_ipc_reply_get_msg(struct sst_generic_ipc *ipc,
 
 	msg = list_first_entry(&ipc->rx_list, struct ipc_message, list);
 
+	list_del(&msg->list);
 out:
 	return msg;
 
@@ -488,7 +489,6 @@ void skl_ipc_process_reply(struct sst_generic_ipc *ipc,
 	}
 
 	spin_lock_irqsave(&ipc->dsp->spinlock, flags);
-	list_del(&msg->list);
 	sst_ipc_tx_msg_reply_complete(ipc, msg);
 	spin_unlock_irqrestore(&ipc->dsp->spinlock, flags);
 }
-- 
2.17.1
