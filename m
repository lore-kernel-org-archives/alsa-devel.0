From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH v4 09/12] ALSA: line6: Add support for POD X3
	Live (only USB ID differs from POD X3)
Date: Sun, 18 Sep 2016 20:59:29 +0200
Message-ID: <1474225172-32081-10-git-send-email-dev@andree.sk>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
 <1474225172-32081-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DE482665FC
 for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2016 21:00:56 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id 133so11708399wmq.2
 for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2016 12:00:56 -0700 (PDT)
In-Reply-To: <1474225172-32081-1-git-send-email-dev@andree.sk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com, perex@perex.cz, stefanha@gmail.com, grabner@icg.tugraz.at, alsa-devel@alsa-project.org
Cc: Andrej Krutak <dev@andree.sk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Andrej Krutak <dev@andree.sk>
---
 sound/usb/line6/podhd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 8cf0a98..8246ea5 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -37,6 +37,7 @@ enum {
 	LINE6_PODHD500_0,
 	LINE6_PODHD500_1,
 	LINE6_PODX3,
+	LINE6_PODX3LIVE
 };
 
 struct usb_line6_podhd {
@@ -348,6 +349,7 @@ static const struct usb_device_id podhd_id_table[] = {
 	{ LINE6_IF_NUM(0x414D, 0), .driver_info = LINE6_PODHD500_0 },
 	{ LINE6_IF_NUM(0x414D, 1), .driver_info = LINE6_PODHD500_1 },
 	{ LINE6_IF_NUM(0x414A, 0), .driver_info = LINE6_PODX3 },
+	{ LINE6_IF_NUM(0x414B, 0), .driver_info = LINE6_PODX3LIVE },
 	{}
 };
 
@@ -409,6 +411,17 @@ static const struct line6_properties podhd_properties_table[] = {
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
