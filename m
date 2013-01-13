From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH 3/3] ALSA: usb-audio: selector map for M-Audio
	FT C400
Date: Sun, 13 Jan 2013 23:02:04 +0100
Message-ID: <1358114524-5152-4-git-send-email-eldad@fogrefinery.com>
References: <1358114524-5152-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f41.google.com (mail-bk0-f41.google.com
 [209.85.214.41])
 by alsa0.perex.cz (Postfix) with ESMTP id E85BC26512B
 for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2013 23:02:27 +0100 (CET)
Received: by mail-bk0-f41.google.com with SMTP id jg9so1665778bkc.28
 for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2013 14:02:27 -0800 (PST)
In-Reply-To: <1358114524-5152-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Add names of the clock sources for the M-Audio Fast Track
C400.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/mixer_maps.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index e71fe55..0e2ed3d 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -179,6 +179,15 @@ static struct usbmix_name_map audigy2nx_map[] = {
 	{ 0 } /* terminator */
 };
 
+static struct usbmix_selector_map c400_selectors[] = {
+	{
+		.id = 0x80,
+		.count = 2,
+		.names = (const char*[]) {"Internal", "SPDIF"}
+	},
+	{ 0 } /* terminator */
+};
+
 static struct usbmix_selector_map audigy2nx_selectors[] = {
 	{
 		.id = 14, /* Capture Source */
@@ -367,6 +376,10 @@ static struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.map = hercules_usb51_map,
 	},
 	{
+		.id = USB_ID(0x0763, 0x2030),
+		.selector_map = c400_selectors,
+	},
+	{
 		.id = USB_ID(0x08bb, 0x2702),
 		.map = linex_map,
 		.ignore_ctl_error = 1,
-- 
1.7.12.4
