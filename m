From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: oxfw: fix NULL pointer dereference to
	unused stream structure
Date: Mon, 26 Aug 2019 22:54:15 +0900
Message-ID: <20190826135415.27833-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CC078F8014A
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2019 15:54:22 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ALSA oxfw driver supports Griffin FireWave. This device supports one
isochronous stream for PCM playback. Current driver executes code to
wait event for stream structure of opposite direction. This causes
NULL pointer dereference.

This commit fixes the bug.

Fixes: ac5d77864cfc ("ALSA: oxfw: support AMDTP domain")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-stream.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 0318dc4dcc55..3c9a796b6526 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -350,13 +350,18 @@ int snd_oxfw_stream_start_duplex(struct snd_oxfw *oxfw)
 
 		// Wait first packet.
 		if (!amdtp_stream_wait_callback(&oxfw->rx_stream,
-						CALLBACK_TIMEOUT) ||
-		    !amdtp_stream_wait_callback(&oxfw->tx_stream,
 						CALLBACK_TIMEOUT)) {
 			err = -ETIMEDOUT;
 			goto error;
 		}
 
+		if (oxfw->has_output) {
+			if (!amdtp_stream_wait_callback(&oxfw->tx_stream,
+							CALLBACK_TIMEOUT)) {
+				err = -ETIMEDOUT;
+				goto error;
+			}
+		}
 	}
 
 	return 0;
-- 
2.20.1
