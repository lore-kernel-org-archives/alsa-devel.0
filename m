From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: oxfw: fix memory leak of discovered stream formats at error path
Date: Mon, 17 Sep 2018 17:26:20 +0900
Message-ID: <20180917082620.11574-1-o-takashi@sakamocchi.jp>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

After finishing discover of stream formats, ALSA OXFW driver has memory
leak of allocated memory object at error path.

This commit releases the memory object at the error path.

Fixes: 6c29230e2a5f ('ALSA: oxfw: delayed registration of sound card')
Cc: <stable@vger.kernel.org> # v4.7+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 1e5b2c802635..63b3e1ce986e 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -207,6 +207,7 @@ static int detect_quirks(struct snd_oxfw *oxfw)
 static void do_registration(struct work_struct *work)
 {
 	struct snd_oxfw *oxfw = container_of(work, struct snd_oxfw, dwork.work);
+	int i;
 	int err;
 
 	if (oxfw->registered)
@@ -269,6 +270,12 @@ static void do_registration(struct work_struct *work)
 	snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->rx_stream);
 	if (oxfw->has_output)
 		snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->tx_stream);
+	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; ++i) {
+		kfree(oxfw->tx_stream_formats[i]);
+		oxfw->tx_stream_formats[i] = NULL;
+		kfree(oxfw->rx_stream_formats[i]);
+		oxfw->rx_stream_formats[i] = NULL;
+	}
 	snd_card_free(oxfw->card);
 	dev_info(&oxfw->unit->device,
 		 "Sound card registration failed: %d\n", err);
-- 
2.17.1
