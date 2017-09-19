From: =?UTF-8?q?Hans=20P=2E=20M=C3=B6ller=20Ebner?= <hmoller@uc.cl>
Subject: [PATCH] ALSA: line6: add support for POD HD DESKTOP
Date: Tue, 19 Sep 2017 12:45:34 -0300
Message-ID: <1505835934-3226-1-git-send-email-hmoller@uc.cl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: dev@andree.sk, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Hans P . Moller" <hmoller@uc.cl>
List-Id: alsa-devel@alsa-project.org

Add support for the Line6 POD HD500X multi effect processor for playback
and capture (in/out audio) through USB.

Signed-off-by: Hans P. Moller <hmoller@uc.cl>
---
 sound/usb/line6/podhd.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 956f847..ba4f71f 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -39,7 +39,8 @@ enum {
 	LINE6_PODHD500_1,
 	LINE6_PODX3,
 	LINE6_PODX3LIVE,
-	LINE6_PODHD500X
+	LINE6_PODHD500X,
+	LINE6_PODHDDESKTOP
 };
 
 struct usb_line6_podhd {
@@ -377,6 +378,7 @@ static const struct usb_device_id podhd_id_table[] = {
 	{ LINE6_IF_NUM(0x414A, 0), .driver_info = LINE6_PODX3 },
 	{ LINE6_IF_NUM(0x414B, 0), .driver_info = LINE6_PODX3LIVE },
 	{ LINE6_IF_NUM(0x4159, 0), .driver_info = LINE6_PODHD500X },
+	{ LINE6_IF_NUM(0x4156, 0), .driver_info = LINE6_PODHDDESKTOP },
 	{}
 };
 
@@ -463,6 +465,18 @@ static const struct line6_properties podhd_properties_table[] = {
 		.ep_audio_r = 0x86,
 		.ep_audio_w = 0x02,
 	},
+	[LINE6_PODHDDESKTOP] = {
+		.id = "PODHDDESKTOP",
+		.name = "POD HDDESKTOP",
+		.capabilities    = LINE6_CAP_CONTROL
+			| LINE6_CAP_PCM | LINE6_CAP_HWMON,
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
