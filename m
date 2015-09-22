From: Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [PATCH] sound: oss: ad1848: Fix returned errno code in ad1848_init()
Date: Tue, 22 Sep 2015 16:37:37 +0100
Message-ID: <1442936257-8988-1-git-send-email-luisbg@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: perex@perex.cz, tiwai@suse.com, sudipm.mukherjee@gmail.com, alsa-devel@alsa-project.org, Luis de Bethencourt <luisbg@osg.samsung.com>
List-Id: alsa-devel@alsa-project.org

The driver is using -1 instead of the -ENOMEM defined macro to specify
that a buffer allocation failed. Since the error number is propagated,
the caller will get a -EPERM which is the wrong error condition.

Smatch tool warning:
ad1848_init() warn: returning -1 instead of -ENOMEM is sloppy

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 sound/oss/ad1848.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/oss/ad1848.c b/sound/oss/ad1848.c
index 10c8de1..6b35656 100644
--- a/sound/oss/ad1848.c
+++ b/sound/oss/ad1848.c
@@ -1992,7 +1992,7 @@ int ad1848_init (char *name, struct resource *ports, int irq, int dma_playback,
 	portc = kmalloc(sizeof(ad1848_port_info), GFP_KERNEL);
 	if(portc==NULL) {
 		release_region(devc->base, 4);
-		return -1;
+		return -ENOMEM;
 	}
 
 	if ((my_dev = sound_install_audiodrv(AUDIO_DRIVER_VERSION,
-- 
2.5.3
