From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Inform too slow responses
Date: Fri,  9 Aug 2019 16:49:49 +0200
Message-ID: <20190809144949.17579-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C6DB6F801A4
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2019 16:49:51 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id DB756AF7A
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2019 14:49:50 +0000 (UTC)
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

For the sake of debugging, show each response that took too long time
and its corresponding last verb.  Since such an error happens in
series once when started, use the ratelimited variant for suppressing
the flood.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 462559442f7a..6387c7e90918 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -794,6 +794,7 @@ static int azx_rirb_get_response(struct hdac_bus *bus, unsigned int addr,
 	unsigned long timeout;
 	unsigned long loopcounter;
 	int do_poll = 0;
+	bool warned = false;
 
  again:
 	timeout = jiffies + msecs_to_jiffies(1000);
@@ -813,9 +814,17 @@ static int azx_rirb_get_response(struct hdac_bus *bus, unsigned int addr,
 		spin_unlock_irq(&bus->reg_lock);
 		if (time_after(jiffies, timeout))
 			break;
-		if (hbus->needs_damn_long_delay || loopcounter > 3000)
+#define LOOP_COUNT_MAX	3000
+		if (hbus->needs_damn_long_delay ||
+		    loopcounter > LOOP_COUNT_MAX) {
+			if (loopcounter > LOOP_COUNT_MAX && !warned) {
+				dev_dbg_ratelimited(chip->card->dev,
+						    "too slow response, last cmd=%#08x\n",
+						    bus->last_cmd[addr]);
+				warned = true;
+			}
 			msleep(2); /* temporary workaround */
-		else {
+		} else {
 			udelay(10);
 			cond_resched();
 		}
-- 
2.16.4
