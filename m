From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/7] ALSA: line6: Remove struct usb_line6_podhd
Date: Wed, 28 Jan 2015 17:41:27 +0100
Message-ID: <1422463289-19135-6-git-send-email-tiwai@suse.de>
References: <1422463289-19135-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AFE8264EFA
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

It's identical with struct usb_line6.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/podhd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 5e4e02c1f4b5..4ebe6ef43073 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -25,11 +25,6 @@ enum {
 	LINE6_PODHD500_1,
 };
 
-struct usb_line6_podhd {
-	/* Generic Line 6 USB data */
-	struct usb_line6 line6;
-};
-
 #define PODHD_BYTES_PER_FRAME 6	/* 24bit audio (stereo) */
 
 static struct snd_ratden podhd_ratden = {
@@ -176,7 +171,7 @@ static int podhd_probe(struct usb_interface *interface,
 {
 	return line6_probe(interface, id,
 			   &podhd_properties_table[id->driver_info],
-			   podhd_init, sizeof(struct usb_line6_podhd));
+			   podhd_init, sizeof(struct usb_line6));
 }
 
 static struct usb_driver podhd_driver = {
-- 
2.2.2
