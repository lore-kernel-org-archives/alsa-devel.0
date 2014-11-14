From: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Subject: [PATCH] 6fire: Convert byte_rev_table uses to bitrev8
Date: Fri, 14 Nov 2014 13:13:45 +0800
Message-ID: <35FD53F367049845BC99AC72306C23D103E010D1829C@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "'perex@perex.cz'" <perex@perex.cz>, "'tiwai@suse.de'" <tiwai@suse.de>, "'joe@perches.com'" <joe@perches.com>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Use the inline function instead of directly indexing the array.

This allows some architectures with hardware instructions for bit
reversals to eliminate the array.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
---
 sound/usb/6fire/firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/6fire/firmware.c b/sound/usb/6fire/firmware.c
index 3b02e54..2e39c3f 100644
--- a/sound/usb/6fire/firmware.c
+++ b/sound/usb/6fire/firmware.c
@@ -316,7 +316,7 @@ static int usb6fire_fw_fpga_upload(
 
 	while (c != end) {
 		for (i = 0; c != end && i < FPGA_BUFSIZE; i++, c++)
-			buffer[i] = byte_rev_table[(u8) *c];
+			buffer[i] = bitrev8((u8) *c);
 
 		ret = usb6fire_fw_fpga_write(device, buffer, i);
 		if (ret < 0) {
-- 
2.1.1
