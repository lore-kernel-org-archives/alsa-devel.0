From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda: Fix racy display power access
Date: Wed, 10 Apr 2019 15:24:48 +0200
Message-ID: <20190410132448.16299-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E14B1F89616
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 15:24:51 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id B7329AB76
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 13:24:50 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

snd_hdac_display_power() doesn't handle the concurrent calls carefully
enough, and it may lead to the doubly get_power or put_power calls,
when a runtime PM and an async work get called in racy way.

This patch addresses it by reusing the bus->lock mutex that has been
used for protecting the link state change in ext bus code, so that it
can protect against racy display state changes.  The initialization of
bus->lock was moved from snd_hdac_ext_bus_init() to
snd_hdac_bus_init() as well accordingly.

Testcase: igt/i915_pm_rpm/module-reload #glk-dsi
Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Imre Deak <imre.deak@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/ext/hdac_ext_bus.c | 1 -
 sound/hda/hdac_bus.c         | 1 +
 sound/hda/hdac_component.c   | 6 +++++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index 9c37d9af3023..ec7715c6b0c0 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -107,7 +107,6 @@ int snd_hdac_ext_bus_init(struct hdac_bus *bus, struct device *dev,
 	INIT_LIST_HEAD(&bus->hlink_list);
 	bus->idx = idx++;
 
-	mutex_init(&bus->lock);
 	bus->cmd_dma_state = true;
 
 	return 0;
diff --git a/sound/hda/hdac_bus.c b/sound/hda/hdac_bus.c
index 012305177f68..ad8eee08013f 100644
--- a/sound/hda/hdac_bus.c
+++ b/sound/hda/hdac_bus.c
@@ -38,6 +38,7 @@ int snd_hdac_bus_init(struct hdac_bus *bus, struct device *dev,
 	INIT_WORK(&bus->unsol_work, snd_hdac_bus_process_unsol_events);
 	spin_lock_init(&bus->reg_lock);
 	mutex_init(&bus->cmd_mutex);
+	mutex_init(&bus->lock);
 	bus->irq = -1;
 	return 0;
 }
diff --git a/sound/hda/hdac_component.c b/sound/hda/hdac_component.c
index a6d37b9d6413..6b5caee61c6e 100644
--- a/sound/hda/hdac_component.c
+++ b/sound/hda/hdac_component.c
@@ -69,13 +69,15 @@ void snd_hdac_display_power(struct hdac_bus *bus, unsigned int idx, bool enable)
 
 	dev_dbg(bus->dev, "display power %s\n",
 		enable ? "enable" : "disable");
+
+	mutex_lock(&bus->lock);
 	if (enable)
 		set_bit(idx, &bus->display_power_status);
 	else
 		clear_bit(idx, &bus->display_power_status);
 
 	if (!acomp || !acomp->ops)
-		return;
+		goto unlock;
 
 	if (bus->display_power_status) {
 		if (!bus->display_power_active) {
@@ -92,6 +94,8 @@ void snd_hdac_display_power(struct hdac_bus *bus, unsigned int idx, bool enable)
 			bus->display_power_active = false;
 		}
 	}
+ unlock:
+	mutex_unlock(&bus->lock);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_display_power);
 
-- 
2.16.4
