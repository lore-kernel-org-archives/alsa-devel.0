From: Kulikov Vasiliy <segooon@gmail.com>
Subject: [PATCH 09/10] oss: msnd: check request_region() return value
Date: Wed, 28 Jul 2010 20:41:36 +0400
Message-ID: <1280335296-23475-1-git-send-email-segooon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: Andrew Veliath <andrewtv@usa.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

request_region() may fail, if so return -ENOMEM.

Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
---
 sound/oss/msnd_pinnacle.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/oss/msnd_pinnacle.c b/sound/oss/msnd_pinnacle.c
index bfaac5f..cd70b9a 100644
--- a/sound/oss/msnd_pinnacle.c
+++ b/sound/oss/msnd_pinnacle.c
@@ -1400,9 +1400,13 @@ static int __init attach_multisound(void)
 		printk(KERN_ERR LOGNAME ": Couldn't grab IRQ %d\n", dev.irq);
 		return err;
 	}
-	request_region(dev.io, dev.numio, dev.name);
+	if (request_region(dev.io, dev.numio, dev.name) == NULL) {
+		free_irq(dev.irq, &dev);
+		return -ENOMEM;
+	}
 
-        if ((err = dsp_full_reset()) < 0) {
+	err = dsp_full_reset();
+	if (err < 0) {
 		release_region(dev.io, dev.numio);
 		free_irq(dev.irq, &dev);
 		return err;
-- 
1.7.0.4
