From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH 13/15] ALSA: line6: Add support for POD X3 Live
	(only USB ID differs from POD X3)
Date: Thu, 11 Aug 2016 21:02:25 +0200
Message-ID: <1470942147-19848-14-git-send-email-dev@andree.sk>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id D8A6C267775
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 21:04:10 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id q128so956428wma.1
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 12:04:10 -0700 (PDT)
In-Reply-To: <1470942147-19848-1-git-send-email-dev@andree.sk>
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
Cc: Andrej Krutak <dev@andree.sk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Andrej Krutak <dev@andree.sk>
---
 sound/usb/line6/podhd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 80ed138..be764f8 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -37,6 +37,7 @@ enum {
 	LINE6_PODHD500_0,
 	LINE6_PODHD500_1,
 	LINE6_PODX3,
+	LINE6_PODX3LIVE
 };
 
 struct usb_line6_podhd {
@@ -373,6 +374,7 @@ static const struct usb_device_id podhd_id_table[] = {
 	{ LINE6_IF_NUM(0x414D, 0), .driver_info = LINE6_PODHD500_0 },
 	{ LINE6_IF_NUM(0x414D, 1), .driver_info = LINE6_PODHD500_1 },
 	{ LINE6_IF_NUM(0x414A, 0), .driver_info = LINE6_PODX3 },
+	{ LINE6_IF_NUM(0x414B, 0), .driver_info = LINE6_PODX3LIVE },
 	{}
 };
 
@@ -434,6 +436,17 @@ static const struct line6_properties podhd_properties_table[] = {
 		.ep_audio_r = 0x86,
 		.ep_audio_w = 0x02,
 	},
+	[LINE6_PODX3LIVE] = {
+		.id = "PODX3LIVE",
+		.name = "POD X3 LIVE",
+		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_PCM | LINE6_CAP_HWMON | LINE6_CAP_IN_NEEDS_OUT,
+		.altsetting = 1,
+		.ep_ctrl_r = 0x81,
+		.ep_ctrl_w = 0x01,
+		.ep_audio_r = 0x86,
+		.ep_audio_w = 0x02,
+	},
 };
 
 /*
-- 
1.9.1
