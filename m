From: Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [PATCH v2] sound: oss: ad1848: Fix returned errno code in ad1848_init()
Date: Thu, 24 Sep 2015 18:58:30 +0100
Message-ID: <1443117510-26906-1-git-send-email-luisbg@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.com, sudipm.mukherjee@gmail.com, joe@perches.com, elfring@users.sourceforge.net, Luis de Bethencourt <luisbg@osg.samsung.com>
List-Id: alsa-devel@alsa-project.org

The driver is using -1 instead of the -ENOMEM defined macro to specify
that a buffer allocation failed. Since the error number is propagated,
the caller will get a -EPERM which is the wrong error condition.

Changed the checks of the return of ad1848_init() to be for >= 0,
instead of != -1.

Smatch tool warning:
ad1848_init() warn: returning -1 instead of -ENOMEM is sloppy

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 sound/oss/ad1848.c    | 4 ++--
 sound/oss/dev_table.c | 2 +-
 sound/oss/pss.c       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/oss/ad1848.c b/sound/oss/ad1848.c
index 10c8de1..58c6d31 100644
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
@@ -2007,7 +2007,7 @@ int ad1848_init (char *name, struct resource *ports, int irq, int dma_playback,
 	{
 		release_region(devc->base, 4);
 		kfree(portc);
-		return -1;
+		return my_dev;
 	}
 	
 	audio_devs[my_dev]->portc = portc;
diff --git a/sound/oss/dev_table.c b/sound/oss/dev_table.c
index 6dad515..abb3db4 100644
--- a/sound/oss/dev_table.c
+++ b/sound/oss/dev_table.c
@@ -148,7 +148,7 @@ EXPORT_SYMBOL(sound_install_mixer);
 
 void sound_unload_audiodev(int dev)
 {
-	if (dev != -1) {
+	if (dev >= 0) {
 		DMAbuf_deinit(dev);
 		audio_devs[dev] = NULL;
 		unregister_sound_dsp((dev<<4)+3);
diff --git a/sound/oss/pss.c b/sound/oss/pss.c
index 81314f9..e84aafe 100644
--- a/sound/oss/pss.c
+++ b/sound/oss/pss.c
@@ -1091,7 +1091,7 @@ static int __init probe_pss_mss(struct address_info *hw_config)
 	pss_mixer_reset(devc);
 	attach_ms_sound(hw_config, ports, THIS_MODULE);	/* Slot 0 */
 
-	if (hw_config->slots[0] != -1)
+	if (hw_config->slots[0] >= 0)
 	{
 		/* The MSS driver installed itself */
 		audio_devs[hw_config->slots[0]]->coproc = &pss_coproc_operations;
-- 
2.5.1
