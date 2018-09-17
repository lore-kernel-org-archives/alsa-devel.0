From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: oxfw: fix memory leak for model-dependent data at error path
Date: Mon, 17 Sep 2018 17:26:08 +0900
Message-ID: <20180917082608.11472-1-o-takashi@sakamocchi.jp>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

After allocating model-dependent data, ALSA OXFW driver has memory leak
of the data at error path.

This commit releases the data at the error path.

Fixes: 6c29230e2a5f ('ALSA: oxfw: delayed registration of sound card')
Cc: <stable@vger.kernel.org> # v4.7+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 63b3e1ce986e..9c8c527ebff9 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -277,6 +277,8 @@ static void do_registration(struct work_struct *work)
 		oxfw->rx_stream_formats[i] = NULL;
 	}
 	snd_card_free(oxfw->card);
+	kfree(oxfw->spec);
+	oxfw->spec = NULL;
 	dev_info(&oxfw->unit->device,
 		 "Sound card registration failed: %d\n", err);
 }
-- 
2.17.1
