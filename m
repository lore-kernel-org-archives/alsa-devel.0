From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/3] usb-us122l: replace 'unsigned' with
	'unsigned int'
Date: Thu, 28 Jul 2016 00:06:46 +0900
Message-ID: <1469632008-29710-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1469632008-29710-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id C331C2672A0
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

This fashion is preferable to checkpatch.pl.

WARNING: Prefer 'unsigned int' to bare use of 'unsigned

Fixes: 030a07e4412 ('ALSA: Add USB US122L driver')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/usb/usx2y/us122l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index cf5dc33..ace708f 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -377,7 +377,7 @@ out:
 }
 
 static int usb_stream_hwdep_ioctl(struct snd_hwdep *hw, struct file *file,
-				  unsigned cmd, unsigned long arg)
+				  unsigned int cmd, unsigned long arg)
 {
 	struct usb_stream_config *cfg;
 	struct us122l *us122l = hw->private_data;
-- 
2.7.4
