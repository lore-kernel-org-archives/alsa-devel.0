From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 1/2] ALSA: include/linux/usb/audio.h: add
	__attribute__((packed))
Date: Tue, 11 May 2010 18:13:49 +0200
Message-ID: <1273594430-9356-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 14E5A248D2
	for <alsa-devel@alsa-project.org>;
	Tue, 11 May 2010 18:14:38 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

This was missing on the definition of struct uac_iso_endpoint_descriptor

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>
---
 include/linux/usb/audio.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/usb/audio.h b/include/linux/usb/audio.h
index 57f2055..9fae6bd 100644
--- a/include/linux/usb/audio.h
+++ b/include/linux/usb/audio.h
@@ -456,7 +456,7 @@ struct uac_iso_endpoint_descriptor {
 	__u8  bmAttributes;
 	__u8  bLockDelayUnits;
 	__le16 wLockDelay;
-};
+} __attribute__((packed));
 #define UAC_ISO_ENDPOINT_DESC_SIZE	7
 
 #define UAC_EP_CS_ATTR_SAMPLE_RATE	0x01
-- 
1.7.1
