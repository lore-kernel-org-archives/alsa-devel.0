From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: oxfw: allow PCM capture for Stanton SCS.1m
Date: Sun,  9 Jun 2019 19:29:12 +0900
Message-ID: <20190609102912.9717-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Stanton SCS.1m can transfer isochronous packet with Multi Bit Linear
Audio data channels, therefore it allows software to capture PCM
substream. However, ALSA oxfw driver doesn't.

This commit changes the driver to add one PCM substream for capture
direction.

Fixes: de5126cc3c0b ("ALSA: oxfw: add stream format quirk for SCS.1 models")
Cc: <stable@vger.kernel.org> # v4.5+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 3d27f3378d5d..b4bef574929d 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -148,9 +148,6 @@ static int detect_quirks(struct snd_oxfw *oxfw)
 		oxfw->midi_input_ports = 0;
 		oxfw->midi_output_ports = 0;
 
-		/* Output stream exists but no data channels are useful. */
-		oxfw->has_output = false;
-
 		return snd_oxfw_scs1x_add(oxfw);
 	}
 
-- 
2.20.1
