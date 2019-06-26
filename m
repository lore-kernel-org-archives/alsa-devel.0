From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Fix race condition in IPC rx
	list" to the asoc tree
Date: Wed, 26 Jun 2019 12:32:44 +0100 (BST)
Message-ID: <20190626113244.E543D44004B@finisterre.sirena.org.uk>
References: <20190613190436.20156-5-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1B10BF896EA
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2019 13:32:48 +0200 (CEST)
In-Reply-To: <20190613190436.20156-5-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Gustaw Lewandowski <gustaw.lewandowski@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, tiwai@suse.com, lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Fix race condition in IPC rx list

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 26ae20490809db30677dfd54f81a73ce77ba2df1 Mon Sep 17 00:00:00 2001
From: Gustaw Lewandowski <gustaw.lewandowski@intel.com>
Date: Thu, 13 Jun 2019 21:04:33 +0200
Subject: [PATCH] ASoC: Intel: Fix race condition in IPC rx list

Since there are multiple IPCs being sent in a short span of time, there
is a possibility of more than one message being on the Rx list after
receiving response from firmware. In such cases, when the first
notification of interrupt from firmware is received, driver retrieves
the message from the Rx list but does not delete it from the list till
the next lock. In the meantime, when another interrupt is received from
the firmware, driver is reading the previous message again since the
previous message has not been removed from the list.

Signed-off-by: Gustaw Lewandowski <gustaw.lewandowski@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
