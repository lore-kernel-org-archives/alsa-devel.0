From: Bard liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH] ALSA: hda: fix: lock reg_lock before calling
	snd_hdac_bus_update_rirb
Date: Thu, 30 May 2019 04:59:00 +0800
Message-ID: <20190529205900.26060-1-yung-chuan.liao@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 972E6F8065A
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2019 10:57:50 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, tiwai@suse.de
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <yung-chuan.liao@linux.intel.com>

The patch is to fix commit 5e13cf6cd64c
(ALSA: hda: add polling mode in snd_hdac_bus_get_response)
spin_lock_irq should be called before snd_hdac_bus_update_rirb.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
Takashi,

Sorry, I make a mistake on the "ALSA: hda: add polling mode in
snd_hdac_bus_get_response" patch. This patch is a fix for that.

Thanks,
Bard
---
 sound/hda/hdac_controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index a16ac31bda83..d6a91429c058 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -239,9 +239,9 @@ int snd_hdac_bus_get_response(struct hdac_bus *bus, unsigned int addr,
 	timeout = jiffies + msecs_to_jiffies(1000);
 
 	for (loopcounter = 0;; loopcounter++) {
+		spin_lock_irq(&bus->reg_lock);
 		if (bus->polling_mode)
 			snd_hdac_bus_update_rirb(bus);
-		spin_lock_irq(&bus->reg_lock);
 		if (!bus->rirb.cmds[addr]) {
 			if (res)
 				*res = bus->rirb.res[addr]; /* the last value */
-- 
2.17.1
