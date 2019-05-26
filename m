From: Bard liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 4/5] ALSA: hda: add polling mode in
	snd_hdac_bus_get_response
Date: Mon, 27 May 2019 00:58:35 +0800
Message-ID: <20190526165836.10867-4-yung-chuan.liao@linux.intel.com>
References: <20190526165836.10867-1-yung-chuan.liao@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 792FCF80730
 for <alsa-devel@alsa-project.org>; Mon, 27 May 2019 06:57:31 +0200 (CEST)
In-Reply-To: <20190526165836.10867-1-yung-chuan.liao@linux.intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, libin.yang@intel.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <yung-chuan.liao@linux.intel.com>

Polling mode is useful if a machine somehow missed an expected IRQ.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/hda/hdac_controller.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index b2e9454f5816..a16ac31bda83 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -239,6 +239,8 @@ int snd_hdac_bus_get_response(struct hdac_bus *bus, unsigned int addr,
 	timeout = jiffies + msecs_to_jiffies(1000);
 
 	for (loopcounter = 0;; loopcounter++) {
+		if (bus->polling_mode)
+			snd_hdac_bus_update_rirb(bus);
 		spin_lock_irq(&bus->reg_lock);
 		if (!bus->rirb.cmds[addr]) {
 			if (res)
-- 
2.17.1
