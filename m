From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-motu: fix destruction of data for isochronous resources
Date: Sat,  1 Jun 2019 12:08:01 +0900
Message-ID: <20190601030801.3675-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The data for isochronous resources is not destroyed in expected place.
This commit fixes the bug.

Cc: <stable@vger.kernel.org> # v4.12+
Fixes: 9b2bb4f2f4a2 ("ALSA: firewire-motu: add stream management functionality")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu-stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/motu/motu-stream.c b/sound/firewire/motu/motu-stream.c
index 73e7a5e527fc..483a8771d502 100644
--- a/sound/firewire/motu/motu-stream.c
+++ b/sound/firewire/motu/motu-stream.c
@@ -345,7 +345,7 @@ static void destroy_stream(struct snd_motu *motu,
 	}
 
 	amdtp_stream_destroy(stream);
-	fw_iso_resources_free(resources);
+	fw_iso_resources_destroy(resources);
 }
 
 int snd_motu_stream_init_duplex(struct snd_motu *motu)
-- 
2.20.1
