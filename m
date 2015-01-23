From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 15/16] ALSA: line6: Do clipping in volume /
	monitor manipulations
Date: Fri, 23 Jan 2015 18:13:22 +0100
Message-ID: <1422033203-23254-16-git-send-email-tiwai@suse.de>
References: <1422033203-23254-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 953DF2654FB
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 18:13:41 +0100 (CET)
In-Reply-To: <1422033203-23254-1-git-send-email-tiwai@suse.de>
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
 sound/usb/line6/playback.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 750d91dced57..cbcd97f5d629 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -37,7 +37,8 @@ static void change_volume(struct urb *urb_out, int volume[],
 		buf_end = p + urb_out->transfer_buffer_length / sizeof(*p);
 
 		for (; p < buf_end; ++p) {
-			*p = (*p * volume[chn & 1]) >> 8;
+			int val = (*p * volume[chn & 1]) >> 8;
+			*p = clamp(val, 0x7fff, -0x8000);
 			++chn;
 		}
 	} else if (bytes_per_frame == 6) {
@@ -51,6 +52,7 @@ static void change_volume(struct urb *urb_out, int volume[],
 
 			val = p[0] + (p[1] << 8) + ((signed char)p[2] << 16);
 			val = (val * volume[chn & 1]) >> 8;
+			val = clamp(val, 0x7fffff, -0x800000);
 			p[0] = val;
 			p[1] = val >> 8;
 			p[2] = val >> 16;
@@ -118,8 +120,10 @@ static void add_monitor_signal(struct urb *urb_out, unsigned char *signal,
 		po = (short *)urb_out->transfer_buffer;
 		buf_end = po + urb_out->transfer_buffer_length / sizeof(*po);
 
-		for (; po < buf_end; ++pi, ++po)
-			*po += (*pi * volume) >> 8;
+		for (; po < buf_end; ++pi, ++po) {
+			int val = *po + ((*pi * volume) >> 8);
+			*po = clamp(val, 0x7fff, -0x8000);
+		}
 	}
 
 	/*
-- 
2.2.2
