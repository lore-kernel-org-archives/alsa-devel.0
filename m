From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-tascam: fix memory leak of private data
Date: Thu, 13 Sep 2018 21:31:05 +0900
Message-ID: <20180913123105.3568-1-o-takashi@sakamocchi.jp>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Although private data of sound card instance is usually allocated in the
tail of the instance, drivers in ALSA firewire stack allocate the private
data before allocating the instance. In this case, the private data
should be released explicitly at .private_free callback of the instance.

This commit fixes memory leak following to the above design.

Fixes: b610386c8afb ('ALSA: firewire-tascam: deleyed registration of sound card')
Cc: <stable@vger.kernel.org> # v4.7+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
index 44ad41fb7374..d3fdc463a884 100644
--- a/sound/firewire/tascam/tascam.c
+++ b/sound/firewire/tascam/tascam.c
@@ -93,6 +93,7 @@ static void tscm_free(struct snd_tscm *tscm)
 	fw_unit_put(tscm->unit);
 
 	mutex_destroy(&tscm->mutex);
+	kfree(tscm);
 }
 
 static void tscm_card_free(struct snd_card *card)
-- 
2.17.1
