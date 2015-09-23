From: Yaowei Bai <bywxiaobai@163.com>
Subject: [PATCH RESEND 3/4] sound/fabrics/layout: make aoa_fabric_layout_init return directly
Date: Wed, 23 Sep 2015 21:58:30 +0800
Message-ID: <1443016711-5297-3-git-send-email-bywxiaobai@163.com>
References: <1443016711-5297-1-git-send-email-bywxiaobai@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443016711-5297-1-git-send-email-bywxiaobai@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, johannes@sipsolutions.net, k.kozlowski@samsung.com, elfring@users.sourceforge.net, fabf@skynet.be, lars@metafoo.de
Cc: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Catching the return value of soundbus_register_driver in
aoa_fabric_layout_init is not necessary, let's return it
directly.

No functional change.

Signed-off-by: Yaowei Bai <bywxiaobai@163.com>
---
 sound/aoa/fabrics/layout.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index 8f71f7e..b6ba091 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -1161,12 +1161,7 @@ static struct soundbus_driver aoa_soundbus_driver = {
 
 static int __init aoa_fabric_layout_init(void)
 {
-	int err;
-
-	err = soundbus_register_driver(&aoa_soundbus_driver);
-	if (err)
-		return err;
-	return 0;
+	return soundbus_register_driver(&aoa_soundbus_driver);
 }
 
 static void __exit aoa_fabric_layout_exit(void)
-- 
1.9.1
