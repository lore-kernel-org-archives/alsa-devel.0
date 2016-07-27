From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/3] usb-us122l: add qualifier into pointer to
	userspace
Date: Thu, 28 Jul 2016 00:06:48 +0900
Message-ID: <1469632008-29710-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1469632008-29710-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id C30E326729C
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

Sparse reports below warnings.

us122l.c:393:28: warning: incorrect type in argument 1 (different address spaces)
us122l.c:393:28:    expected void const [noderef] <asn:1>*<noident>
us122l.c:393:28:    got void *<noident>

The first argument for memdup_user() should be a pointer to userspace.
In current implementation, a pointer to void is used without __user
qualifier.

This commit fixes it.

Fixes: 030a07e4412 ('ALSA: Add USB US122L driver')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/usb/usx2y/us122l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index 36654ac..c578c42 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -390,7 +390,7 @@ static int usb_stream_hwdep_ioctl(struct snd_hwdep *hw, struct file *file,
 	if (cmd != SNDRV_USB_STREAM_IOCTL_SET_PARAMS)
 		return -ENOTTY;
 
-	cfg = memdup_user((void *)arg, sizeof(*cfg));
+	cfg = memdup_user((void __user *)arg, sizeof(*cfg));
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
-- 
2.7.4
