From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/6] fireworks: Remove meaningless
	mutex_unlock()
Date: Wed,  4 Jun 2014 15:25:36 +0900
Message-ID: <1401863137-15103-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1401863137-15103-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 6457326531B
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 08:25:57 +0200 (CEST)
In-Reply-To: <1401863137-15103-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Currently mutex_unlock() is called in module's cleanup function. But after
cleaned up, this mutex is automatically released. So this function call
is meaningless.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index 996fdc4..3e2ed8e 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -346,7 +346,6 @@ static void __exit snd_efw_exit(void)
 {
 	snd_efw_transaction_unregister();
 	driver_unregister(&efw_driver.driver);
-	mutex_destroy(&devices_mutex);
 }
 
 module_init(snd_efw_init);
-- 
1.8.3.2
