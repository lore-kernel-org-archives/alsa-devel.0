From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 1/5] allow up to 32 PCM devices
Date: Wed, 12 May 2010 09:30:16 +0800
Message-ID: <20100512015713.762299923@intel.com>
References: <20100512013015.752623810@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id BAAE210393B
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 03:58:44 +0200 (CEST)
Content-Disposition: inline; filename=alsa-minor.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

Reserve 32 minor numbers for PCM playback devices.

The Intel SandyBridge HDMI audio codec provides 3 PCM devices with
indices 3, 7, 8. Among which the device 8's minor number will be
overlapped with the first capture device's minor number in the current
static minor number allocation scheme.

Also increase SNDRV_PCM_DEVICES to make pcm_dev_bits big enough to hold
the increasing number of PCM devices.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 include/sound/minors.h |   16 ++++++++--------
 include/sound/pcm.h    |    2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

--- sound-2.6.orig/include/sound/minors.h	2010-04-16 16:03:28.000000000 +0800
+++ sound-2.6/include/sound/minors.h	2010-05-11 13:02:48.000000000 +0800
@@ -23,23 +23,23 @@
 
 #define SNDRV_OS_MINORS			256
 
-#define SNDRV_MINOR_DEVICES		32
-#define SNDRV_MINOR_CARD(minor)		((minor) >> 5)
-#define SNDRV_MINOR_DEVICE(minor)	((minor) & 0x001f)
-#define SNDRV_MINOR(card, dev)		(((card) << 5) | (dev))
+#define SNDRV_MINOR_DEVICES		64
+#define SNDRV_MINOR_CARD(minor)		((minor) >> 6)
+#define SNDRV_MINOR_DEVICE(minor)	((minor) & 0x003f)
+#define SNDRV_MINOR(card, dev)		(((card) << 6) | (dev))
 
 /* these minors can still be used for autoloading devices (/dev/aload*) */
 #define SNDRV_MINOR_CONTROL		0	/* 0 */
 #define SNDRV_MINOR_GLOBAL		1	/* 1 */
-#define SNDRV_MINOR_SEQUENCER		(SNDRV_MINOR_GLOBAL + 0 * 32)
-#define SNDRV_MINOR_TIMER		(SNDRV_MINOR_GLOBAL + 1 * 32)
+#define SNDRV_MINOR_SEQUENCER		(SNDRV_MINOR_GLOBAL + 0 * 64)
+#define SNDRV_MINOR_TIMER		(SNDRV_MINOR_GLOBAL + 1 * 64)
 
 #ifndef CONFIG_SND_DYNAMIC_MINORS
 						/* 2 - 3 (reserved) */
 #define SNDRV_MINOR_HWDEP		4	/* 4 - 7 */
 #define SNDRV_MINOR_RAWMIDI		8	/* 8 - 15 */
-#define SNDRV_MINOR_PCM_PLAYBACK	16	/* 16 - 23 */
-#define SNDRV_MINOR_PCM_CAPTURE		24	/* 24 - 31 */
+#define SNDRV_MINOR_PCM_PLAYBACK	16	/* 16 - 31 */
+#define SNDRV_MINOR_PCM_CAPTURE		32	/* 32 - 63 */
 
 /* same as first respective minor number to make minor allocation easier */
 #define SNDRV_DEVICE_TYPE_CONTROL	SNDRV_MINOR_CONTROL
--- sound-2.6.orig/include/sound/pcm.h	2010-04-16 16:03:28.000000000 +0800
+++ sound-2.6/include/sound/pcm.h	2010-05-11 13:02:48.000000000 +0800
@@ -88,7 +88,7 @@ struct snd_pcm_ops {
 #if defined(CONFIG_SND_DYNAMIC_MINORS)
 #define SNDRV_PCM_DEVICES	(SNDRV_OS_MINORS-2)
 #else
-#define SNDRV_PCM_DEVICES	8
+#define SNDRV_PCM_DEVICES	32
 #endif
 
 #define SNDRV_PCM_IOCTL1_FALSE		((void *)0)
