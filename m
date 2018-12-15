From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/3] ALSA: firewire-lib: use the same print format for 'without_header' tracepoints
Date: Sat, 15 Dec 2018 19:03:21 +0900
Message-ID: <20181215100321.1658-4-o-takashi@sakamocchi.jp>
References: <20181215100321.1658-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181215100321.1658-1-o-takashi@sakamocchi.jp>
Sender: stable-owner@vger.kernel.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

An initial commit to add tracepoints for packets without CIP headers
uses different print formats for added tracepoints. However this is not
convenient for users/developers to prepare debug tools.

This commit uses the same format for the two tracepoints.

Cc: <stable@vger.kernel.org> # v4.12+
Fixes: b164d2fd6e49 ('ALSA: firewire_lib: add tracepoints for packets without CIP headers')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream-trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/amdtp-stream-trace.h b/sound/firewire/amdtp-stream-trace.h
index c05b3da0aa1c..ac20acf48fc6 100644
--- a/sound/firewire/amdtp-stream-trace.h
+++ b/sound/firewire/amdtp-stream-trace.h
@@ -131,7 +131,7 @@ TRACE_EVENT(in_packet_without_header,
 		__entry->index = index;
 	),
 	TP_printk(
-		"%02u %04u %04x %04x %02d %03u %3u %3u %02u %01u %02u",
+		"%02u %04u %04x %04x %02d %03u %02u %03u %02u %01u %02u",
 		__entry->second,
 		__entry->cycle,
 		__entry->src,
-- 
2.19.1
