From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: fireworks: fix memory leak of response buffer at error path
Date: Mon, 17 Sep 2018 17:26:41 +0900
Message-ID: <20180917082641.11734-1-o-takashi@sakamocchi.jp>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

After allocating memory object for response buffer, ALSA fireworks
driver has leak of the memory object at error path.

This commit releases the object at the error path.

Fixes: 7d3c1d5901aa('ALSA: fireworks: delayed registration of sound card')
Cc: <stable@vger.kernel.org> # v4.7+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index 71a0613d3da0..f2d073365cf6 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -301,6 +301,8 @@ do_registration(struct work_struct *work)
 	snd_efw_transaction_remove_instance(efw);
 	snd_efw_stream_destroy_duplex(efw);
 	snd_card_free(efw->card);
+	kfree(efw->resp_buf);
+	efw->resp_buf = NULL;
 	dev_info(&efw->unit->device,
 		 "Sound card registration failed: %d\n", err);
 }
-- 
2.17.1
