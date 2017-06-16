From: =?UTF-8?q?Hans=20P=2E=20M=C3=B6ller=20Ebner?= <hmoller@uc.cl>
Subject: [PATCH 1/2] ALSA: line6: add support for POD HD500X
Date: Fri, 16 Jun 2017 14:14:16 -0400
Message-ID: <1497636857-13944-1-git-send-email-hmoller@uc.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f195.google.com (mail-qt0-f195.google.com
 [209.85.216.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EADA266CFE
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 20:14:26 +0200 (CEST)
Received: by mail-qt0-f195.google.com with SMTP id s33so12073859qtg.3
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 11:14:26 -0700 (PDT)
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
Cc: stefanha@gmail.com, "Hans P . Moller" <hmoller@uc.cl>, dev@andree.sk, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add support for the Line6 POD HD500X multi effect processor for playback and capture (in/out audio) through USB.

Signed-off-by: Hans P. Moller <hmoller@uc.cl>
---
 sound/usb/line6/podhd.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 6ab23e5..e389f92 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2011 Stefan Hajnoczi <stefanha@gmail.com>
  * Copyright (C) 2015 Andrej Krutak <dev@andree.sk>
+ * Copyright (C) 2015 Hans P. Moller <hmoller@uc.cl>
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License as
@@ -37,7 +38,8 @@ enum {
 	LINE6_PODHD500_0,
 	LINE6_PODHD500_1,
 	LINE6_PODX3,
-	LINE6_PODX3LIVE
+	LINE6_PODX3LIVE,
+	LINE6_PODHD500X
 };
 
 struct usb_line6_podhd {
@@ -372,6 +374,7 @@ static const struct usb_device_id podhd_id_table[] = {
 	{ LINE6_IF_NUM(0x414D, 1), .driver_info = LINE6_PODHD500_1 },
 	{ LINE6_IF_NUM(0x414A, 0), .driver_info = LINE6_PODX3 },
 	{ LINE6_IF_NUM(0x414B, 0), .driver_info = LINE6_PODX3LIVE },
+	{ LINE6_IF_NUM(0x4159, 0), .driver_info = LINE6_PODHD500X },
 	{}
 };
 
@@ -446,6 +449,18 @@ static const struct line6_properties podhd_properties_table[] = {
 		.ep_audio_r = 0x86,
 		.ep_audio_w = 0x02,
 	},
+	[LINE6_PODHD500X] = {
+		.id = "PODHD500X",
+		.name = "POD HD500X",
+		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_PCM | LINE6_CAP_HWMON,
+		.altsetting = 1,
+		.ep_ctrl_r = 0x81,
+		.ep_ctrl_w = 0x01,
+		.ctrl_if = 1,
+		.ep_audio_r = 0x86,
+		.ep_audio_w = 0x02,
+	},
 };
 
 /*
-- 
2.7.4
