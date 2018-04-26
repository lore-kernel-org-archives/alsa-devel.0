From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: dice: fix error path to destroy initialized stream data
Date: Thu, 26 Apr 2018 22:00:29 +0900
Message-ID: <20180426130029.4440-1-o-takashi@sakamocchi.jp>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In error path of snd_dice_stream_init_duplex(), stream data for incoming
packet can be left to be initialized.

This commit fixes it.

Fixes: 436b5abe2224 ('ALSA: dice: handle whole available isochronous streams')
Cc: <stable@vger.kernel.org> # v4.6+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index 8573289c381e..928a255bfc35 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -435,7 +435,7 @@ int snd_dice_stream_init_duplex(struct snd_dice *dice)
 		err = init_stream(dice, AMDTP_IN_STREAM, i);
 		if (err < 0) {
 			for (; i >= 0; i--)
-				destroy_stream(dice, AMDTP_OUT_STREAM, i);
+				destroy_stream(dice, AMDTP_IN_STREAM, i);
 			goto end;
 		}
 	}
-- 
2.14.1
