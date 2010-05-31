From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 3/9] include/linux/usb/audio-v2.h: add more
	UAC2 details
Date: Mon, 31 May 2010 13:35:38 +0200
Message-ID: <1275305744-6590-3-git-send-email-daniel@caiaq.de>
References: <1275305744-6590-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id EA1091038A1
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 13:36:01 +0200 (CEST)
In-Reply-To: <1275305744-6590-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, gregkh@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Also, remove the 'bmControl' field from uac_clock_selector_descriptor,
which was at the wrong offset. This struct is currently unused.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 include/linux/usb/audio-v2.h |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/include/linux/usb/audio-v2.h b/include/linux/usb/audio-v2.h
index 8f91be3..383b94b 100644
--- a/include/linux/usb/audio-v2.h
+++ b/include/linux/usb/audio-v2.h
@@ -41,6 +41,13 @@ struct uac_clock_source_descriptor {
 	__u8 iClockSource;
 } __attribute__((packed));
 
+/* bmAttribute fields */
+#define UAC_CLOCK_SOURCE_TYPE_EXT	0x0
+#define UAC_CLOCK_SOURCE_TYPE_INT_FIXED	0x1
+#define UAC_CLOCK_SOURCE_TYPE_INT_VAR	0x2
+#define UAC_CLOCK_SOURCE_TYPE_INT_PROG	0x3
+#define UAC_CLOCK_SOURCE_SYNCED_TO_SOF	(1 << 2)
+
 /* 4.7.2.2 Clock Source Descriptor */
 
 struct uac_clock_selector_descriptor {
@@ -49,8 +56,20 @@ struct uac_clock_selector_descriptor {
 	__u8 bDescriptorSubtype;
 	__u8 bClockID;
 	__u8 bNrInPins;
-	__u8 bmControls;
 	__u8 baCSourceID[];
+	/* bmControls, bAssocTerminal and iClockSource omitted */
+} __attribute__((packed));
+
+/* 4.7.2.3 Clock Multiplier Descriptor */
+
+struct uac_clock_multiplier_descriptor {
+	__u8 bLength;
+	__u8 bDescriptorType;
+	__u8 bDescriptorSubtype;
+	__u8 bClockID;
+	__u8 bCSourceID;
+	__u8 bmControls;
+	__u8 iClockMultiplier;
 } __attribute__((packed));
 
 /* 4.7.2.4 Input terminal descriptor */
-- 
1.7.1
