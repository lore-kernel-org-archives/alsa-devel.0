From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/3] usb-us122l: add support for compatible
	ioctl
Date: Thu, 28 Jul 2016 00:06:47 +0900
Message-ID: <1469632008-29710-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1469632008-29710-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id C2FF326729A
 for <alsa-devel@alsa-project.org>; Wed, 27 Jul 2016 17:06:54 +0200 (CEST)
In-Reply-To: <1469632008-29710-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ALSA hwdep is a thin wrapper of usual ioctl operation, thus it's better to
support compatible ioctl operation.

Currently, ALSA USB US122L module doesn't support it. This commit adds
support for it.

Fixes: 030a07e4412 ('ALSA: Add USB US122L driver')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/usb/usx2y/us122l.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index ace708f..36654ac 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -24,6 +24,7 @@
 #include <sound/hwdep.h>
 #include <sound/pcm.h>
 #include <sound/initval.h>
+#include <linux/compat.h>
 #define MODNAME "US122L"
 #include "usb_stream.c"
 #include "../usbaudio.h"
@@ -453,6 +454,18 @@ free:
 	return err;
 }
 
+#ifdef CONFIG_COMPAT
+static int usb_stream_hwdep_compat_ioctl(struct snd_hwdep *hw,
+					 struct file *file,
+					 unsigned int cmd, unsigned long arg)
+{
+	return usb_stream_hwdep_compat_ioctl(hw, file, cmd,
+					     (unsigned long)compat_ptr(arg));
+}
+#else
+#define usb_stream_hwdep_compat_ioctl NULL
+#endif
+
 #define SND_USB_STREAM_ID "USB STREAM"
 static int usb_stream_hwdep_new(struct snd_card *card)
 {
@@ -469,7 +482,7 @@ static int usb_stream_hwdep_new(struct snd_card *card)
 	hw->ops.open = usb_stream_hwdep_open;
 	hw->ops.release = usb_stream_hwdep_release;
 	hw->ops.ioctl = usb_stream_hwdep_ioctl;
-	hw->ops.ioctl_compat = usb_stream_hwdep_ioctl;
+	hw->ops.ioctl_compat = usb_stream_hwdep_compat_ioctl;
 	hw->ops.mmap = usb_stream_hwdep_mmap;
 	hw->ops.poll = usb_stream_hwdep_poll;
 
-- 
2.7.4
