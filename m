From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 8/8] usb/audio.h: Fix field order
Date: Fri,  5 Mar 2010 08:41:25 +0100
Message-ID: <1267774885-16266-9-git-send-email-daniel@caiaq.de>
References: <1267774885-16266-1-git-send-email-daniel@caiaq.de>
	<1267774885-16266-2-git-send-email-daniel@caiaq.de>
	<1267774885-16266-3-git-send-email-daniel@caiaq.de>
	<1267774885-16266-4-git-send-email-daniel@caiaq.de>
	<1267774885-16266-5-git-send-email-daniel@caiaq.de>
	<1267774885-16266-6-git-send-email-daniel@caiaq.de>
	<1267774885-16266-7-git-send-email-daniel@caiaq.de>
	<1267774885-16266-8-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A14A103A2B
	for <alsa-devel@alsa-project.org>; Fri,  5 Mar 2010 08:42:18 +0100 (CET)
In-Reply-To: <1267774885-16266-8-git-send-email-daniel@caiaq.de>
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
Cc: tiwai@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>
---
 include/linux/usb/audio.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/usb/audio.h b/include/linux/usb/audio.h
index 6bb2936..4d3e450 100644
--- a/include/linux/usb/audio.h
+++ b/include/linux/usb/audio.h
@@ -269,8 +269,8 @@ struct uac_format_type_i_ext_descriptor {
 	__u8 bLength;
 	__u8 bDescriptorType;
 	__u8 bDescriptorSubtype;
-	__u8 bSubslotSize;
 	__u8 bFormatType;
+	__u8 bSubslotSize;
 	__u8 bBitResolution;
 	__u8 bHeaderLength;
 	__u8 bControlSize;
-- 
1.6.6.2
