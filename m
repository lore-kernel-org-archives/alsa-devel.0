From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hda-emu: Add snd_power_get_state
Date: Thu,  3 Dec 2015 15:31:23 +0100
Message-ID: <1449153083-5134-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F867260418
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 15:31:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 include/sound/core.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sound/core.h b/include/sound/core.h
index e556765..1196319 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -113,6 +113,8 @@ int snd_card_register(struct snd_card *card)
 	return 0;
 }
 
+#define snd_power_get_state(card)       ({ (void)(card); SNDRV_CTL_POWER_D0; })
+
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
-- 
1.9.1
