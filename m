From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-digi00x: fix memory leak of private data
Date: Thu, 13 Sep 2018 21:30:34 +0900
Message-ID: <20180913123034.3295-1-o-takashi@sakamocchi.jp>
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

Fixes: 86c8dd7f4da3 ('ALSA: firewire-digi00x: delayed registration of sound card')
Cc: <stable@vger.kernel.org> # v4.7+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/firewire/digi00x/digi00x.c b/sound/firewire/digi00x/digi00x.c
index 1f5e1d23f31a..ef689997d6a5 100644
--- a/sound/firewire/digi00x/digi00x.c
+++ b/sound/firewire/digi00x/digi00x.c
@@ -49,6 +49,7 @@ static void dg00x_free(struct snd_dg00x *dg00x)
 	fw_unit_put(dg00x->unit);
 
 	mutex_destroy(&dg00x->mutex);
+	kfree(dg00x);
 }
 
 static void dg00x_card_free(struct snd_card *card)
-- 
2.17.1
