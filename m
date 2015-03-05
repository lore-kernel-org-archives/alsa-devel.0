From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: line6: Clamp values correctly
Date: Thu,  5 Mar 2015 13:05:52 +0100
Message-ID: <1425557152-7662-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 748C326562C
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 13:05:54 +0100 (CET)
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
Cc: Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

The usages of clamp() macro in sound/usb/line6/playback.c are just
wrong, the low and high values are swapped.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/playback.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 05dee690f487..97ed593f6010 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -39,7 +39,7 @@ static void change_volume(struct urb *urb_out, int volume[],
 		for (; p < buf_end; ++p) {
 			short pv = le16_to_cpu(*p);
 			int val = (pv * volume[chn & 1]) >> 8;
-			pv = clamp(val, 0x7fff, -0x8000);
+			pv = clamp(val, -0x8000, 0x7fff);
 			*p = cpu_to_le16(pv);
 			++chn;
 		}
@@ -54,7 +54,7 @@ static void change_volume(struct urb *urb_out, int volume[],
 
 			val = p[0] + (p[1] << 8) + ((signed char)p[2] << 16);
 			val = (val * volume[chn & 1]) >> 8;
-			val = clamp(val, 0x7fffff, -0x800000);
+			val = clamp(val, -0x800000, 0x7fffff);
 			p[0] = val;
 			p[1] = val >> 8;
 			p[2] = val >> 16;
@@ -126,7 +126,7 @@ static void add_monitor_signal(struct urb *urb_out, unsigned char *signal,
 			short pov = le16_to_cpu(*po);
 			short piv = le16_to_cpu(*pi);
 			int val = pov + ((piv * volume) >> 8);
-			pov = clamp(val, 0x7fff, -0x8000);
+			pov = clamp(val, -0x8000, 0x7fff);
 			*po = cpu_to_le16(pov);
 		}
 	}
-- 
2.3.1
