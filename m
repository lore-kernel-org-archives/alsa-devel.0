From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 4/9] ALSA: usb-audio: fix selector unit string
	index accessor
Date: Mon, 31 May 2010 13:35:39 +0200
Message-ID: <1275305744-6590-4-git-send-email-daniel@caiaq.de>
References: <1275305744-6590-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A63691038A0
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

This is another regression from the UAC2 code refactoring.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 include/linux/usb/audio.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/usb/audio.h b/include/linux/usb/audio.h
index 5d646c3..ed5cf92 100644
--- a/include/linux/usb/audio.h
+++ b/include/linux/usb/audio.h
@@ -244,7 +244,7 @@ struct uac_selector_unit_descriptor {
 static inline __u8 uac_selector_unit_iSelector(struct uac_selector_unit_descriptor *desc)
 {
 	__u8 *raw = (__u8 *) desc;
-	return raw[9 + desc->bLength - 1];
+	return raw[desc->bLength - 1];
 }
 
 /* 4.3.2.5 Feature Unit Descriptor */
-- 
1.7.1
