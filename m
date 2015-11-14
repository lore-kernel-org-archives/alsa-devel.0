From: Cheah Kok Cheong <thrust73@gmail.com>
Subject: [PATCH] Sound: Usb: Misc: ua101: replace le16_to_cpu() with usb_endpoint_maxp()
Date: Sun, 15 Nov 2015 05:31:30 +0800
Message-ID: <1447536690-25173-1-git-send-email-thrust73@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: clemens@ladisch.de
Cc: tiwai@suse.com, perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Cheah Kok Cheong <thrust73@gmail.com>
List-Id: alsa-devel@alsa-project.org

Commit 939f325f4a0f ("usb: add usb_endpoint_maxp() macro")

And commit 29cc88979a88 ("USB: use usb_endpoint_maxp()
instead of le16_to_cpu()")

This trivial patch convert remaining user.

Patched against
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git

Signed-off-by: Cheah Kok Cheong <thrust73@gmail.com>
---
 sound/usb/misc/ua101.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index 9581089..c19a5dd 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -1037,7 +1037,7 @@ static int detect_usb_format(struct ua101 *ua)
 		return -ENXIO;
 	}
 	ua->capture.usb_pipe = usb_rcvisocpipe(ua->dev, usb_endpoint_num(epd));
-	ua->capture.max_packet_bytes = le16_to_cpu(epd->wMaxPacketSize);
+	ua->capture.max_packet_bytes = usb_endpoint_maxp(epd);
 
 	epd = &ua->intf[INTF_PLAYBACK]->altsetting[1].endpoint[0].desc;
 	if (!usb_endpoint_is_isoc_out(epd)) {
@@ -1045,7 +1045,7 @@ static int detect_usb_format(struct ua101 *ua)
 		return -ENXIO;
 	}
 	ua->playback.usb_pipe = usb_sndisocpipe(ua->dev, usb_endpoint_num(epd));
-	ua->playback.max_packet_bytes = le16_to_cpu(epd->wMaxPacketSize);
+	ua->playback.max_packet_bytes = usb_endpoint_maxp(epd);
 	return 0;
 }
 
-- 
1.9.1
