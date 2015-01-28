From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/7] ALSA: line6: Fix volume calculation for
	big-endian
Date: Wed, 28 Jan 2015 17:41:23 +0100
Message-ID: <1422463289-19135-2-git-send-email-tiwai@suse.de>
References: <1422463289-19135-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 43ACC264FE7
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 17:41:37 +0100 (CET)
In-Reply-To: <1422463289-19135-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/playback.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 1708c05f14db..5858f5f18e11 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -37,8 +37,10 @@ static void change_volume(struct urb *urb_out, int volume[],
 		buf_end = p + urb_out->transfer_buffer_length / sizeof(*p);
 
 		for (; p < buf_end; ++p) {
-			int val = (*p * volume[chn & 1]) >> 8;
-			*p = clamp(val, 0x7fff, -0x8000);
+			short pv = le16_to_cpu(*p);
+			int val = (pv * volume[chn & 1]) >> 8;
+			pv = clamp(val, 0x7fff, -0x8000);
+			*p = cpu_to_le16(pv);
 			++chn;
 		}
 	} else if (bytes_per_frame == 6) {
@@ -121,8 +123,11 @@ static void add_monitor_signal(struct urb *urb_out, unsigned char *signal,
 		buf_end = po + urb_out->transfer_buffer_length / sizeof(*po);
 
 		for (; po < buf_end; ++pi, ++po) {
-			int val = *po + ((*pi * volume) >> 8);
-			*po = clamp(val, 0x7fff, -0x8000);
+			short pov = le16_to_cpu(*po);
+			short piv = le16_to_cpu(*pi);
+			int val = pov + ((piv * volume) >> 8);
+			pov = clamp(val, 0x7fff, -0x8000);
+			*po = cpu_to_le16(pov);
 		}
 	}
 
-- 
2.2.2
